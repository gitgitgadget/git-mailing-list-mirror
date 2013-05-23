From: Junio C Hamano <gitster@pobox.com>
Subject: Re: first parent, commit graph layout, and pull merge direction
Date: Thu, 23 May 2013 14:01:39 -0700
Message-ID: <7vbo81e7gs.fsf@alter.siamese.dyndns.org>
References: <20130522115042.GA20649@inner.h.apk.li>
	<7v4ndukhx0.fsf@alter.siamese.dyndns.org>
	<20130523090657.GB23933@inner.h.apk.li>
	<CAEBDL5WqYPYnU=YoCa2gMzcJCxeNbFmFgfWnHh=+HuouXLLsxg@mail.gmail.com>
	<20130523102959.GP9448@inner.h.apk.li>
	<20130523110839.GT27005@serenity.lan>
	<7vd2shheic.fsf@alter.siamese.dyndns.org>
	<20130523164114.GV27005@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Krey <a.krey@gmx.de>,
	John Szakmeister <john@szakmeister.net>, git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Thu May 23 23:01:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ufcdw-0001PY-TN
	for gcvg-git-2@plane.gmane.org; Thu, 23 May 2013 23:01:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759109Ab3EWVBn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 May 2013 17:01:43 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35892 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759072Ab3EWVBm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 May 2013 17:01:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 34B9622A79;
	Thu, 23 May 2013 21:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=glsvHBoFpDdwF68a+sNcvE0t1bA=; b=bTygrG
	VNu8S0WwKaINEuskPPof96qnXSmmQO4ZXKPaAvOk3SzjxMJDJq/nZhcQgb0RNlqq
	E3o6LZ5gf/iODhUzzL08/9v+r8mQp3tPD/dI1cgzuvSxVnHtOgS2fBzNPXOLtPag
	cClBhYsErzIwqrkmOssIiZhayFXTmrTOjvHXo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pbu9n9YvtAYs37pjdbxb9aIvjHbDfYkC
	o1cIIjJJJgMBXWC4trlxdz/aX5ilOvDQdirTOeAf3Hqs7eX0rTq0jy+q80dTIJ7r
	J5azRENE3qAxWdD5VEqOUAzIJje1WrSTUFsLuHhUNBki/eSmRhkkWD/ckgL/sSP+
	ok0a99jjz18=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 270EA22A78;
	Thu, 23 May 2013 21:01:41 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 79E0322A75;
	Thu, 23 May 2013 21:01:40 +0000 (UTC)
In-Reply-To: <20130523164114.GV27005@serenity.lan> (John Keeping's message of
	"Thu, 23 May 2013 17:41:14 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F71CE05E-C3EB-11E2-9996-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225292>

John Keeping <john@keeping.me.uk> writes:

> I have to wonder how often "git pull" with no arguments actually does
> what users really want (even if they don't know it!) when it doesn't
> result in a fast-forward (and pull.rebase isn't configured).

If you are in a totally centralized shared repository mindset
without using topic branch workflow, --first-parent would not help
you.  In your history the second parent is more likely to be the
mainline.

So for them "git pull" that either fast-forward when it can, or
makes a merge that records the then-current state of the central
shared repository, is perfectly sensible.  They will view gitk and
see all the changes, "git shortlog" and "git log --no-merges" will
give them what they expect.

> Hence my suggestion to error when "git pull" doesn't result in a
> fast-forward and no branch name is specified.  We could give some advice
> like:
>
>     Your local changes are not included in the local branch and you
>     haven't told Git how to preserve them.
>
>     If you want to rebase your changes onto the modified upstream
>     branch, run:
>
>         git pull --rebase

I can parse the first paragraph above, but cannot make much sense
out of it.  Unless you are talking about local changes that are not
committed yet, that is.  But in that case I fail to see what it has
to do with the current discussion, or suggestion to use rebase.

>> But people need to realize that it is not solving the other half, a
>> more fundamental problem some people have in their workflow.
>
> Yes, but some users don't realise that their workflow is broken, and
> perhaps we can nudge them in the right direction.

I actually avoided mentioning that deliberately, because I think the
"flip the head when merging" encourages people to (1) work directly
on 'master' and (2) pull too often when they shouldn't.

That is detrimental if your goal is to nudge them in the right
direction.
