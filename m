From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] worktree: allow "-" short-hand for @{-1} in add command
Date: Fri, 27 May 2016 10:52:22 -0700
Message-ID: <xmqqvb1zqtgp.fsf@gitster.mtv.corp.google.com>
References: <vpqshx5cb51.fsf@anie.imag.fr>
	<1464263662-1290-1-git-send-email-jordan.de-gea@grenoble-inp.org>
	<xmqqshx4vedr.fsf@gitster.mtv.corp.google.com>
	<vpqvb1zrh8s.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jordan DE GEA <jordan.de-gea@grenoble-inp.org>,
	git@vger.kernel.org, erwan.mathoniere@grenoble-inp.org,
	samuel.groot@grenoble-inp.org, tom.russello@grenoble-inp.org,
	Jordan DE GEA <jordan.de-gea@ensimag.grenoble-inp.fr>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri May 27 19:52:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b6Lw3-0005oF-0Z
	for gcvg-git-2@plane.gmane.org; Fri, 27 May 2016 19:52:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932587AbcE0Rwb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 May 2016 13:52:31 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53498 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932320AbcE0Rwb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2016 13:52:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D6DA91E0C2;
	Fri, 27 May 2016 13:52:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uxIWNdo4iIpWQduTqbuzfPLp43k=; b=pN9Vec
	7vDxj4UarJ34tGoeQObgMfYWqF3G0U5xsjeHmUcac9U6lgCgz2yAXwulVPFa+jeI
	Y5B46Uuw04HjrS8/sLKLWaL7ViA4Rbqm8OW2Qu5cCMgdyDwe6l/1OosfnIR918QS
	Xh1ktzHtR0ZjqoNtaSfOcQf9VWwR+V+RQhGXA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HrEoq73IOpyB4NX8bng2JzQldlbFUjG2
	81Bhm5iDihCb1himSJ8Cxe6Qum/32fy9bX0GJm2FXWQDC1nlC12wfxf+CLF510eb
	QdYGupgGEk+Yge/5u5qYE0dG3C9FkPZtCsHGArsV75lj7WpgudoljClK5otevpmo
	fWDI9YNzY9A=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CC44B1E0C1;
	Fri, 27 May 2016 13:52:29 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2729D1E0BE;
	Fri, 27 May 2016 13:52:24 -0400 (EDT)
In-Reply-To: <vpqvb1zrh8s.fsf@anie.imag.fr> (Matthieu Moy's message of "Fri,
	27 May 2016 11:18:43 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C4A35404-2433-11E6-92B1-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295778>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Jordan DE GEA <jordan.de-gea@grenoble-inp.org> writes:
>>
>>> +	branch=$(cd short-hand && git rev-parse --symbolic-full-name HEAD) &&
>>> +	test "$branch" = refs/heads/newbranch &&
>>> +	cd ..
>>
>> If any of the command between "cd short-hand" and "cd .." failed,
>> after correcting the broken &&-chain, the next test will end up
>> running in short-hand directory, which it is not expecting.  A
>> canonical way to avoid this problem is to replace the above with:
>>
>> 	...
>>         git worktree add short-hand - &&
>>         (
>> 		cd short-hand &&
>>                 ...
>>                 test "$branch" = refs/heads/newbranch
>> 	)
>
> Actually, $(...) implicitly does a subshell, so the "cd .." was just
> useless.

You trimmed my message a bit too aggressively while composing your
response, and I think that is what ended up confusing you.  

Here is what I wrote:

| > +	cd short-hand &&
| > +	test $(git rev-parse --symbolic-full-name HEAD) = "refs/heads/newbranch"
| 
| Broken &&-chain.
| 
| > +	branch=$(cd short-hand && git rev-parse --symbolic-full-name HEAD) &&
| > +	test "$branch" = refs/heads/newbranch &&
| > +	cd ..
| 
| If any of the command between "cd short-hand" and "cd .." failed,
| ...

The problematic "cd short-hand" is the one a few lines above where
you started quoting, not the one you saw in the $().
