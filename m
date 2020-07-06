Return-Path: <SRS0=LMRs=AT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DATE_IN_PAST_24_48,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F9BCC433E1
	for <git@archiver.kernel.org>; Wed,  8 Jul 2020 11:37:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CA8D2067D
	for <git@archiver.kernel.org>; Wed,  8 Jul 2020 11:37:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="VH/TYC/3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728864AbgGHLhG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jul 2020 07:37:06 -0400
Received: from mout.gmx.net ([212.227.15.18]:48803 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728410AbgGHLhF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jul 2020 07:37:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1594208216;
        bh=i8KN7/IcOtoEKKtyRbGC+fL3QLiRHbUWnkpYmlO2DKM=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=VH/TYC/3MbizSpJORNmzpOndMlLmnDfkZ7uw6PHJheMili2SZtzWai5TjXiJ+Wr9c
         JTtZDZlcpX55MEzNB8KqSmHxydOWjG9qZBYcHJLthnBWB0Rx4J6cDcYVI39uxXczEE
         APLaQtSQU4fuNKeMn1mzGW2W/Xy8rSlqWIXFJEmQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.28.26.78] ([89.1.213.9]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mt79P-1klmCX2yj3-00tT0k; Wed, 08
 Jul 2020 13:36:56 +0200
Date:   Tue, 7 Jul 2020 01:14:59 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Martin Bektchiev via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Martin Bektchiev <martinb@gmail.com>,
        Martin Bektchiev <martin.bektchiev@progress.com>
Subject: Re: [PATCH] commit: correctly escape @ of stashes
In-Reply-To: <xmqqv9j19mgn.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2007070114060.50@tvgsbejvaqbjf.bet>
References: <pull.815.git.git.1593768655179.gitgitgadget@gmail.com> <xmqqv9j19mgn.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:ZCXbZ0Hw6cJwvyOsR5EL/cmHqS2QzrYyt7lPWQIJXlTizdWct0E
 h0iNdv+ZoqTm+W5pcS/eUdSau74P10502ZjFOiKs8USu6R5gctewxoKAtj7Y8hSMstNAATk
 acjpodimoFKWmLCOv5FiatA36iFIOF7Lk8gkvCUulM1JLx1bQubaErw3S6U2CL5qBPTZ3L7
 rAaHT1sSFO5I1Rx4bDtYg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rjf4GJK8gMk=:YV/1wswthupRhGobVIDf1i
 C3g5Pe74wIKbEjzAi0UZS4WK4XvE3XiQCCaLGrx/dwKHPdQR21IwnlCd5ZZ2LdIFZv0f2FvUL
 5DqC2zs+TMD9L2rCoOtwssCaEdQSq+xyRAJn4OHOnd4OKF7pu9N//Bj387Uttpy4bE6OCZs8Q
 vPJmCLc7iKOEPHpD5iVf+vIBgW7O9aSClTYPsqzGoBtj3te0Ry+o4hDHjvU1nJFZiaVDBtWYR
 HIjsndWjYQ8SvV/BxFgHU3SDLB4RNHJK6/zEswJpWSk82DVS0wolGkzd6q8T4Ieudz4clM3+w
 1jnLt8q2yO7g8dQVQCgeTodNaF7dmX+937BQgD3t4vjQtI94oWiYiCH0X5wOFWugWgRrtIiHv
 BrhPugR6V4WJkM/xaZBoN/PhbhEDNR6CJ35wqVhcVGjBH7HgpBiHWjHQVUbJCzmhR6R9kiavR
 iG/XKe/xEKxpwwOrG+b6jlz+kKQtzMBgWEti7Wf7sr8IfhoO78FcA18yIpa1wuZMiX0VXI7JM
 svHTqr5yMmYO2lx6BZ6t1hNCXFNt5UQUtIA3jwJlytkjoCSN1ihtCFNW5R6LSNS7WC7+TxRsK
 oQTpAxVw+omsW8yyOXCWeOKbfEESA/fvhgdE3sFRD4sRIJZylfMH2EcMizE/87tgblGKcSaSn
 uAP8XK1H1lpEgBYZUlzXHqMDxstZwzciRlBXfRylbJt7FweKfN3isGDQBTnbUQdvph1WUYqp/
 RLVwvfEkruBKDVe9xg2pZsZDnPDSTadTlJvbHSGKwhsMGvqoa0YXKVOxiR+aNEf+upoTt+O9d
 zD27GN0bslevUie1nLifobIxmI+gU42gv5E7eb4X0GDcwDgJYr0bJ5HJCEulX6f+zMU1IsFSw
 yVFfCKioAGLIHw2OdsfiE4/ssi9u+OP9IuOC6xNGr25jj9UhpKugc9e8qOPtdDcbs6EZYdF9k
 Z+9/G9jgp9K4TLM9SI4ZYXw+o6j2nc79pQ5wPDP8nzdOTtu2IlEdRqQodVFERB+mbOzo+/LZ+
 q0h6VSYZ6XJ38roRb7ZhjfDwIdZKwRdRVBHg0FuZ0brT/dglEMArEEcXKhOhpKGAUlp6+Fazp
 hboc1JqS2BgpYzBbF51kft8bu+eCCUXb2iV5BtNED6YQykVrEbGhgwvX/n/IQWfw2iMtiLEyN
 dSje03xhZLsYFKL74QOA7yJFDEF7F9aAgqH3TMh6PSj1COCeP5oRZ+tDlpZZ2JQm7f9fj5Tsg
 u3Ok2/EtgyJha3O/QUIgk/lfOOLGYEjGYXIlT0A==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mirroring https://github.com/git/git/pull/815#issuecomment-654683996
manually, as I lack the time to figure out why Martin's mails don't make
it to the mailing list:

Hi Junio,

Thank you for reviewing this patch! I've amended and pushed the branch and
you can find my comments inline:


> "Martin Bektchiev via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Martin Bektchiev <martin.bektchiev@progress.com>
> >
> > Autocomplete suggestions for stashes are broken due to `stash@`
> > being suggested without escaping.
>
> What is unclear to readers of this sentence is why '@' needs to be
> quoted in the first place.  '@' is not like '$' that has a syntactic
> significance to the shell.
>
> In fact, I just tried
>
>     $ git stash show stas<TAB>
>
> in a test repository where there is only one stash entry and got it
> completed to
>
>     $ git stash show stash@{0}
>
> and pressing <Enter> from this state did exactly what I expected to
> see.
>
> > Reproducible on `GNU bash, version 3.2.57(1)-release` and
> > `macOS Catalina 10.15.5`.
>
> What did you reproduce?  The completion gave me "stash@{0}" (without
> surrounding double quotes) in my above experiment?  If so, that does
> seem reproducible, but I do not see "suggestions ... are broken" here.

The problem is visible when you have more than one stash. If
you press TABm autocompletion stops at the `{` and if you then
press TAB once more for a list of all stashes instead of that
the completion changes to `stashstash{` and becomes broken at
this point.

>
> > @@ -2999,12 +2999,14 @@ _git_stash ()
> >  				__git_complete_refs
> >  			else
> >  				__gitcomp_nl "$(__git stash list \
> > -						| sed -n -e 's/:.*//p')"
> > +						| sed -n -e 's/:.*//p' \
> > +						| sed 's/@/\\@/')"
>
> This is not a new problem introduced by this patch, but we should
> get rid of these unnecessary backslashes and pipe at the beginning
> of the second line, both of which make the resulting code harder
> than necessary to read.  Ending the line with '|' pipe would give
> enough clue to the shell that you haven't finished talking to it,
> and you can continue to the next line without any backslashes just
> fine.

Fixed.

>
> >  			fi
> >  			;;
> >  		show,*|apply,*|drop,*|pop,*)
> >  			__gitcomp_nl "$(__git stash list \
> > -					| sed -n -e 's/:.*//p')"
> > +					| sed -n -e 's/:.*//p' \
> > +					| sed 's/@/\\@/')"
>
> Ditto.

Fixed.
>
> >  			;;
> >  		*)
> >  			;;
> >
> > base-commit: a08a83db2bf27f015bec9a435f6d73e223c21c5e
>


P.S. I responded with `git send-email` but since I still cannot see my ema=
il received it might have not been sent successfully. Hopefully you'll see=
 my comment here ...

=2D-
You are receiving this because you commented.
Reply to this email directly or view it on GitHub:
https://github.com/git/git/pull/815#issuecomment-654683996
