From: Junio C Hamano <gitster@pobox.com>
Subject: Re: first parent, commit graph layout, and pull merge direction
Date: Thu, 23 May 2013 17:21:44 -0700
Message-ID: <7vppwhb52f.fsf@alter.siamese.dyndns.org>
References: <20130522115042.GA20649@inner.h.apk.li>
	<7v4ndukhx0.fsf@alter.siamese.dyndns.org>
	<20130523090657.GB23933@inner.h.apk.li>
	<CAEBDL5WqYPYnU=YoCa2gMzcJCxeNbFmFgfWnHh=+HuouXLLsxg@mail.gmail.com>
	<20130523102959.GP9448@inner.h.apk.li>
	<20130523110839.GT27005@serenity.lan>
	<7vd2shheic.fsf@alter.siamese.dyndns.org>
	<20130523164114.GV27005@serenity.lan>
	<7vbo81e7gs.fsf@alter.siamese.dyndns.org>
	<20130523215557.GX27005@serenity.lan>
	<7vli75cpom.fsf@alter.siamese.dyndns.org>
	<CA+55aFz2Uvq4vmyjJPao5tS-uuVvKm6mbP7Uz8sdq1VMxMGJCw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: John Keeping <john@keeping.me.uk>, Andreas Krey <a.krey@gmx.de>,
	John Szakmeister <john@szakmeister.net>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri May 24 02:21:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uffld-0006pQ-RN
	for gcvg-git-2@plane.gmane.org; Fri, 24 May 2013 02:21:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757981Ab3EXAVs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 May 2013 20:21:48 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42595 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757810Ab3EXAVr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 May 2013 20:21:47 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4A09C226DB;
	Fri, 24 May 2013 00:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=86S/OoSWgRcuJAIb2bfDppgRa88=; b=eG1jxz
	jvUQufq0DFh0l/KcNHxgR6zZzWP3objGtbceniBIRWrMoaqx9jcSc6yrh2uQPq3Z
	oqZiYPzeigRbYUXx8yLldL+Fup4epHDFgUq85+e6ZBpRDCx8zXv8QqvKdnLwoMha
	GlYXu9g+ykqbcoB4Ze/3uDrdZXv4RzuV8r63M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZCUJiawnWw6taKrOlGvhnEk/Zua+GeRK
	19ZWzq5Y3uIZHBMyEBbWoSYFzSO6cBueWHme6soz9t9EX3yM3/Bpm3dxtj/9Zkgi
	S9AaqVwb3IMceDEbcQvoZubduulMyNW0EvtnUAaCSQEfYM7M+CDf1Drq6UEeMh0g
	/ZAqIuE6dkc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 35E66226DA;
	Fri, 24 May 2013 00:21:46 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A34BB226D7;
	Fri, 24 May 2013 00:21:45 +0000 (UTC)
In-Reply-To: <CA+55aFz2Uvq4vmyjJPao5tS-uuVvKm6mbP7Uz8sdq1VMxMGJCw@mail.gmail.com>
	(Linus Torvalds's message of "Thu, 23 May 2013 17:03:38 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EABFE60A-C407-11E2-8F15-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225324>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> It would be a *horrible* mistake to make "rebase" the default, because
> it's so much easier to screw things up that way.
>
> That said, making "no-ff" the default, and then if that fails, saying
>
>    The pull was not a fast-forward pull, please say if you want to
> merge or rebase.
>    Use either
>
>         git pull --rebase
>         git pull --merge
>
>    You can also use "git config pull.merge true" or "git config
> pull.rebase true"
>    to set this once for this project and forget about it.
>
> That way, people who want the existing behavior could just do that
>
>     git config pull.merge true
>
> once, and they'd not even notice.
>
> Hmm? Better yet, make it per-branch.

I would assume that "no-ff" above was meant to be "--ff-only" from
the first part of the message.

I also would assume that I can rephrase that setting pull.merge
(which does not exist) as setting pull.rebase explicitly to false
instead (i.e. missing pull.rebase and pull.rebase that is explicitly
set to false would mean two different things).

I have to think about this a bit to convince myself that the message
is clear enough and useful for those this updated behaviour is
trying to help.  After reading the above message three times, I
still cannot shake the impression that we are just covering our
backside to be able to say "we told you already and you chose
poorly", in case things go wrong for them later.
