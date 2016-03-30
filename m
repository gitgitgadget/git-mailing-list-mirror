From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 2/3] pretty: enable --expand-tabs by default for selected pretty formats
Date: Wed, 30 Mar 2016 12:18:24 -0700
Message-ID: <xmqq37r7u64f.fsf@gitster.mtv.corp.google.com>
References: <1458775426-2215-1-git-send-email-gitster@pobox.com>
	<1459293309-25195-1-git-send-email-gitster@pobox.com>
	<1459293309-25195-3-git-send-email-gitster@pobox.com>
	<20160330013851.GF2237@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 30 21:18:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alLdS-00081k-A3
	for gcvg-git-2@plane.gmane.org; Wed, 30 Mar 2016 21:18:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752879AbcC3TSa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2016 15:18:30 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:56041 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752758AbcC3TS3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2016 15:18:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C7C5F51D30;
	Wed, 30 Mar 2016 15:18:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=F39omr4RWfes5GZ8zktm4KzdA0o=; b=k7Jbkh
	I0z9KZN9uN8g7VBWszxngvNgETo6uc2GRThMA9X6k/WXt62VE4v7mD3VpzojgJHP
	UVjKYe2cO5A1wz3U9IChJKpaMeI8JncxccaMUAeSmgAvO17TXaH5LK14HrOQEApB
	0lZGfRmrekDobgjxcbIMco5hkAWxdevxJ80BU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UVm4p4VMijwYl/lMr2zW78kBWZHXV+Xh
	D46iEU0VxepR1J06oUk6y2XfrGFerFUEcbKvFoj+OtVr3P/zjuhcgjbtaAw5awFw
	d5MOijc0U84++M2YBCsxBkvUXnyymALTPESFBSzJwwVtF7XtxI/CyrEGHcgbljQG
	6a7dCSW72gw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BDE3751D2F;
	Wed, 30 Mar 2016 15:18:25 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 3747A51D29;
	Wed, 30 Mar 2016 15:18:25 -0400 (EDT)
In-Reply-To: <20160330013851.GF2237@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 29 Mar 2016 21:38:51 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 2CE0F716-F6AC-11E5-B92C-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290338>

Jeff King <peff@peff.net> writes:

> On Tue, Mar 29, 2016 at 04:15:08PM -0700, Junio C Hamano wrote:
>
>> diff --git a/Documentation/pretty-options.txt b/Documentation/pretty-options.txt
>> index 4fb5c76..23967b6 100644
>> --- a/Documentation/pretty-options.txt
>> +++ b/Documentation/pretty-options.txt
>> @@ -43,10 +43,16 @@ people using 80-column terminals.
>>  	commit may be copied to the output.
>>  
>>  --expand-tabs::
>> +--no-expand-tabs::
>>  	Perform a tab expansion (replace each tab with enough number
>>  	of spaces to fill to the next display column that is
>>  	multiple of 8) in the log message before using the message
>>  	to show in the output.
>> ++
>> +By default, tabs are expanded in pretty formats that indent the log
>> +message by 4 spaces (i.e.  'medium', which is the default, 'full',
>> +and "fuller').  `--no-expand-tabs` option can be used to disable
>> +this.
>
> Mismatched quote types on "fuller".

Thanks.

>> @@ -172,6 +173,7 @@ void get_commit_format(const char *arg, struct rev_info *rev)
>>  
>>  	rev->commit_format = commit_format->format;
>>  	rev->use_terminator = commit_format->is_tformat;
>> +	rev->expand_tabs_in_log = commit_format->expand_tabs_in_log;
>>  	if (commit_format->format == CMIT_FMT_USERFORMAT) {
>>  		save_user_format(rev, commit_format->user_format,
>>  				 commit_format->is_tformat);
>
> This feels like the wrong time to set the value in rev_info, as it means
> that:
>
>   git log --no-expand-tabs --pretty=full
>
> and
>
>   git log --pretty=full --no-expand-tabs
>
> behave differently.

I was sort of hoping that we can get away by defining that "an
explicit --pretty asks for the full behaviour of the format it
specifies, e.g. if you ask --pretty=medium, you are asking for
4-space indented tab-expanded log with the headers at the medium
level of detail".

> The other values set in get_commit_format, like "use_terminator",
> are inherently part of the format, but I don't think this is.

IOW, I was hoping nobody would agree with that and rather everybody
would consider tab-expansion is part of the format.

Let me try your way instead and report how it went when I send out a
reroll.

> Likewise, if we were to eventually add config like "[log]expandtab = 4",
> it should not be overridden by "--pretty=full" (but we probably _would_
> want to have it kick in only for certain formats).

This is exactly why I didn't do a configuration variable, as I think
we can make only 50% of people happy.  Some would say "when I
explicitly ask for the "email" format, I expect that expandtab
configuration gets ignored" while others would say "I said I want
expandtab in the configuration no matter what".
