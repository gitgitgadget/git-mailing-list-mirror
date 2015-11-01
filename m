From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/5] wt-status: don't skip a magical number of characters blindly
Date: Sun, 01 Nov 2015 09:55:50 -0800
Message-ID: <xmqq37wpioyh.fsf@gitster.mtv.corp.google.com>
References: <5634FB59.1000506@web.de> <5634FC48.7070609@web.de>
	<xmqq7fm1ip51.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Sun Nov 01 18:55:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZswrG-0002s1-5x
	for gcvg-git-2@plane.gmane.org; Sun, 01 Nov 2015 18:55:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752505AbbKARzy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Nov 2015 12:55:54 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:50723 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751999AbbKARzx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Nov 2015 12:55:53 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 85DA2269AB;
	Sun,  1 Nov 2015 12:55:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GXz5V0WcfcNK6+O5XTBRiq+grMA=; b=j7mefo
	r1a8gx38z3CLS92MLLkVFF0nzwrUwhncsGu6Fm+cza7d21u+GLgFzlDKx5dJzJWD
	V3kFIhdwMNOeWdAhncUn3dwae0Ji7iNQCGe8PdYRMkRSzVdWqzNAetVoXO8edClx
	9dl8dfgybLmpQkNaXAHl+uZfas9eFX4+mkKaE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HlCfnUHEmScwNTEEhMVsD3BwoA0SlLH2
	0we6FcDYxRMRzOPDOMnLJbcqEtkmdfEwmhT4exvp6MQjbeMeFvZr2+kX0H0Fpjhr
	gGMZkRj3vMEbYJF0Elk00KXRylXjNr5yH2IjlOQDMhxn2chFl3Uod9DU12WN8xqL
	/SbeTPXUXso=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7EBFB269A9;
	Sun,  1 Nov 2015 12:55:52 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 084D6269A7;
	Sun,  1 Nov 2015 12:55:51 -0500 (EST)
In-Reply-To: <xmqq7fm1ip51.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Sun, 01 Nov 2015 09:51:54 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: CA94B486-80C1-11E5-9095-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280642>

Junio C Hamano <gitster@pobox.com> writes:

>> diff --git a/wt-status.c b/wt-status.c
>> index e206cc9..42ea15e 100644
>> --- a/wt-status.c
>> +++ b/wt-status.c
>> @@ -1656,7 +1656,7 @@ static void wt_shortstatus_print_tracking(struct wt_status *s)
>>  	if (starts_with(branch_name, "refs/heads/"))
>>  		branch_name += 11;
>>  
>> -	branch = branch_get(s->branch + 11);
>> +	branch = branch_get(branch_name);
>
> Is this correct?  s->branch is the refname that is l10n independent;
> branch_name is the localized variant for human consumption.

Ahh, and that convention has been changed at patch 3/5.  Now the
only localizable string "HEAD (no branch)" never goes into that
variable thanks to the code reorganization in 3/5, this variable
is used only to give us a shortened refname.

OK, I misread the code.  The result is correct.
