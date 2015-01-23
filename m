From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git compile warnings (under mac/clang)
Date: Fri, 23 Jan 2015 10:48:40 -0800
Message-ID: <xmqqmw59qqnr.fsf@gitster.dls.corp.google.com>
References: <CAO2U3Qi6Xf1RrbxyVW3cHNe1-ZwxFHDVskGLZguWS=b38pgaXQ@mail.gmail.com>
	<CAGZ79kaFWL5HWdctLzTWf6D4nTP19sPZbcOg9fiRx7RQrWjY7Q@mail.gmail.com>
	<b2cbad0d8e59a0c4eb0565608f3f90bc@www.dscho.org>
	<20150122220140.GB6695@peff.net>
	<315bf23981813799d16fdd9b533444f3@www.dscho.org>
	<20150123122317.GA12517@peff.net>
	<6fd8dc170de8be1ab38f8fda89d44f6a@www.dscho.org>
	<20150123133033.GA27692@peff.net>
	<xmqqwq4dqskp.fsf@gitster.dls.corp.google.com>
	<20150123183737.GA32191@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Michael Blume <blume.mike@gmail.com>, peter@lekensteyn.nl,
	eungjun.yi@navercorp.com, Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 23 19:48:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEjHk-0004zy-Bx
	for gcvg-git-2@plane.gmane.org; Fri, 23 Jan 2015 19:48:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932181AbbAWSsp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2015 13:48:45 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:50464 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752481AbbAWSsn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2015 13:48:43 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EE81531D62;
	Fri, 23 Jan 2015 13:48:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UB1/Z5y9pXuaAPmDwd0dbiaX+h4=; b=eV7O+B
	e66GGSu3nPPObtR2inxRBYNjfwkXCoMjQlytL11GhsoKwIb2ULAwRTjg9mywGptA
	1kfYKOGZfe2lv0Fqwr1J448aroZQfxMxnylNDRpRsasCSrhv5CT2B/LcZoXLWYFZ
	TkU5j/rszTfsHr4cpb4OHrrElAHRvBIF5947E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LtwuACqcInzf0IgBGVZXw0c+lufBX/4I
	g7OueiA+Pghx64AVKO8d0JA1GWIKWv/MTS53P+/OYXaq1HN3g6IciSSUYnpvJbsL
	HjxEj9VYNMkGexxSgwHIg0msr+c2+Xq2sWuiC1goEbG97rdoVohiy7Iob9y8khvR
	pW7ZQihxOjY=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E1C5C31D61;
	Fri, 23 Jan 2015 13:48:42 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4A62A31D60;
	Fri, 23 Jan 2015 13:48:42 -0500 (EST)
In-Reply-To: <20150123183737.GA32191@peff.net> (Jeff King's message of "Fri,
	23 Jan 2015 13:37:37 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 73C3C300-A330-11E4-8F36-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262945>

Jeff King <peff@peff.net> writes:

> But of all the options outlined, I think I'd much rather just see an
> assert() for something that should never happen, rather than mixing it
> into the logic.

Surely.

> In that vein, one thing that puzzles me is that the current code looks
> like:
>
>   if (options->msg_severity && msg_id >= 0 && msg_id < FSCK_MSG_MAX)
> 	  severity = options->msg_severity[msg_id];
>   else {
> 	  severity = msg_id_info[msg_id].severity;
> 	  ...
>   }
>
> So if the severity override list given by "options" exists, _and_ if we
> are in the enum range, then we use that. Otherwise, we dereference the
> global list. But wouldn't an out-of-range condition have the exact same
> problem dereferencing that global list?
>
> IOW, should this really be:
>
>   if (msg_id < 0 || msg_id >= FSCK_MSG_MAX)
> 	die("BUG: broken enum");
>
>   if (options->msg_severity)
> 	severity = options->msg_severity[msg_id];
>   else
> 	severity = msg_id_info[msg_id].severity;
>
> ? And then you can spell that first part as assert(), which I suspect
> (but did not test) may shut up clang's warnings.

Sounds like a sensible fix to me.
