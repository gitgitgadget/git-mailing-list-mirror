From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] win32: syslog: prevent potential realloc memory leak
Date: Sun, 25 Jan 2015 20:25:29 -0800
Message-ID: <xmqqzj96mame.fsf@gitster.dls.corp.google.com>
References: <1418463676-1753-1-git-send-email-arjun024@gmail.com>
	<xmqqbnn4eqay.fsf@gitster.dls.corp.google.com>
	<CABPQNSbCF7P23K+uj00PmjJkr=19t=W5wCN0-jweBJYEWgUWRw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git mailing list <git@vger.kernel.org>,
	Erik Faye-Lund <kusmabite@googlemail.com>,
	Arjun Sreedharan <arjun024@gmail.com>,
	Mike Pape <dotzenlabs@gmail.com>
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 26 05:25:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YFbF3-0007Ly-M3
	for gcvg-git-2@plane.gmane.org; Mon, 26 Jan 2015 05:25:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751794AbbAZEZe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jan 2015 23:25:34 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:58043 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751273AbbAZEZc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jan 2015 23:25:32 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C5DEC33B0E;
	Sun, 25 Jan 2015 23:25:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Ncm3nnoYIg/fESkUujl5hdVXA7s=; b=o9JCxv
	U0jM63sXX+94t3+erjolLD20iyMDJrGvv/S1/+nUlxOPUt36n2IZR8iUS6P/FdU0
	atqN9DTAW97hIzTEVd8XkisuyDkd9//d8tguE4H9H3A7pCnN33VwldeEVddoyQW7
	z4vzy+OJT1JhsdUTKu/6mwT1qRSvEpnGHt3gc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=g5tcvjlPSswGDNXB2HBFmTBG9W0uDDZX
	me2LA0epKWJZ+nz61CR6/Fgi7DXp6thbgPT5n4efIrefOUFFMIXMYCdb7VZQ03cn
	gM8xnayogDuNkRfnRFEnjVZRw0BIaUTc6jyzF+xNTED+t5CxioUhL+oNjVNpeJHw
	U2iqlpa9MXM=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BBDD533B0D;
	Sun, 25 Jan 2015 23:25:31 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 57DAD33B0C;
	Sun, 25 Jan 2015 23:25:30 -0500 (EST)
In-Reply-To: <CABPQNSbCF7P23K+uj00PmjJkr=19t=W5wCN0-jweBJYEWgUWRw@mail.gmail.com>
	(Erik Faye-Lund's message of "Sun, 25 Jan 2015 22:38:39 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5C8DAB08-A513-11E4-8004-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263024>

Erik Faye-Lund <kusmabite@gmail.com> writes:

> Sorry for very late reply. I had a bug in my mail rules that caused
> this email to skip my inbox. That should be fixed now.
>
> On Mon, Dec 15, 2014 at 7:11 PM, Junio C Hamano <gitster@pobox.com> wrote:
> ...
>> Regardless of that funny %1 business, I notice in
>>
>>     http://msdn.microsoft.com/en-us/library/windows/desktop/aa363679%28v=vs.85%29.aspx
>>
>> that each element of lpStrings array that is passed to ReportEvent()
>> is limited to 32k or so.  Wouldn't it make it a lot simpler if we
>> removed the dynamic allocation and use a fixed sized 32k buffer here
>> (and truncate the result as necessary)?  That would make the "leak"
>> disappear automatically.
>
> That's a very good point. Yes, I think that makes more sense.

OK, so I'd expect a simpler non-reallocating code to materialize
and will drop Arjun's patch for now.

Thanks.
