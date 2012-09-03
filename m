From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Test failures in t4034
Date: Sun, 02 Sep 2012 18:53:13 -0700
Message-ID: <7vehmjg9di.fsf@alter.siamese.dyndns.org>
References: <80B6C6EE-130C-48C3-BBBB-5FCD1E7EFDEF@gernhardtsoftware.com>
 <5030FD49.6060704@ramsay1.demon.co.uk>
 <7vboi6nzym.fsf@alter.siamese.dyndns.org>
 <5033D573.9030103@ramsay1.demon.co.uk>
 <7v1uizdhi7.fsf@alter.siamese.dyndns.org>
 <5042494D.9040401@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brian Gernhardt <brian@gernhardtsoftware.com>,
	Git List <git@vger.kernel.org>,
	Thomas Rast <trast@student.ethz.ch>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Mon Sep 03 03:53:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T8Lqt-0007LH-Ju
	for gcvg-git-2@plane.gmane.org; Mon, 03 Sep 2012 03:53:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755818Ab2ICBxR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Sep 2012 21:53:17 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61423 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755657Ab2ICBxQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Sep 2012 21:53:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B7FBB8FC7;
	Sun,  2 Sep 2012 21:53:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2YvnKxPU6v9xvN4BznxkyiJDi88=; b=lKkD71
	q/yH9f5NsPV0k/+8//misf+BcqR1PgKtzu6RrPmgMs9HZ7IXzCZRS9xOT1+LzXao
	6EOmaXfV/l2lVZoezmJFEmDRdpBShU68UzPNUL2Y31QOY5/rl53cwrdra4puH9yH
	+YtCawAKJV29eorUeMCn9dYVi9I7qaIJr3pqo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Q5ALu4R8ef2TSI5FCJpgF+zlUFBddWck
	7MHDChH1hR8enQfuykBiS0O6K9BDPD6AENlo+DKgbys8rUxXKKucVorLqqrGMkUb
	Od3XLBQ3R2NJYvpQuNzkUmKyBBJ3/pjTnxYxuTr1l1PaAJaZ0leDgwBlRrpY1UPa
	iJHAcX5s5sI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A540B8FC6;
	Sun,  2 Sep 2012 21:53:15 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 057F58FC4; Sun,  2 Sep 2012
 21:53:14 -0400 (EDT)
In-Reply-To: <5042494D.9040401@ramsay1.demon.co.uk> (Ramsay Jones's message
 of "Sat, 01 Sep 2012 18:43:41 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2004276C-F56A-11E1-84D5-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204681>

Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:

> Yes, there was a net increase in the line count when I introduced
> die(), but the main program flow was less cluttered by error handling.
> The net result looked much better, so I thought it was worth it.
>
> What may not be too obvious, however, is that test-regex.c was written
> to be independent of git.

That part I was very aware of actually; it it is a bit tricky to
tell what the right thing to do, though.  Your test itself needs to
be pretty much portable without the portability help you would get
git-compat-util.h, but the point of this kind of test is to tell if
you want to define preprocessor macros that may affect the behaviour
of such compatibility layer ;-)

> Given that I'm now building it as part of git, I should have simply
> #included <git-compat-util.h> and used the die() routine from libgit.a
> (since I'm now *relying* on test-regex being linked with libgit.a).

OK.

>>> +int main(int argc, char **argv)
>>> +{
>>> +	char *pat = "[^={} \t]+";
>>> +	char *str = "={}\nfred";
>>> +	regex_t r;
>>> +	regmatch_t m[1];
>>> +
>>> +	if (regcomp(&r, pat, REG_EXTENDED | REG_NEWLINE))
>>> +		die("failed regcomp() for pattern '%s'", pat);
>>> +	if (regexec(&r, str, 1, m, 0))
>>> +		die("no match of pattern '%s' to string '%s'", pat, str);
>>> +
>>> +	/* http://sourceware.org/bugzilla/show_bug.cgi?id=3957  */
>>> +	if (m[0].rm_so == 3) /* matches '\n' when it should not */
>>> +		exit(1);
>> 
>> This could be the third call site of die() that tells the user to
>> build with NO_REGEX=1.  Then "cd t && sh t0070-fundamental.sh -i -v" would
>> give that message directly to the user.
>
> Hmm, even without "-i -v", it's *very* clear what is going on, but sure
> it wouldn't hurt either. (Also, I wanted to be able to distinguish an exit
> via die() from a "test failed" error return).

OK.

Thanks.
