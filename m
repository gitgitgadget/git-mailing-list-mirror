Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED870C4361B
	for <git@archiver.kernel.org>; Sat, 19 Dec 2020 18:33:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B94BE23158
	for <git@archiver.kernel.org>; Sat, 19 Dec 2020 18:33:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbgLSSdL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Dec 2020 13:33:11 -0500
Received: from ciao.gmane.io ([116.202.254.214]:48124 "EHLO ciao.gmane.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727330AbgLSSdK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Dec 2020 13:33:10 -0500
Received: from list by ciao.gmane.io with local (Exim 4.92)
        (envelope-from <gcvg-git-3@m.gmane-mx.org>)
        id 1kqh1p-0003OF-4s
        for git@vger.kernel.org; Sat, 19 Dec 2020 19:32:29 +0100
X-Injected-Via-Gmane: http://gmane.org/
To:     git@vger.kernel.org
From:   Achim Gratz <Stromeko@nexgo.de>
Subject: Re: [PATCH] apply: don't use core.sharedRepository to create working tree files
Date:   Sat, 19 Dec 2020 19:32:24 +0100
Organization: Linux Private Site
Message-ID: <87y2ht4pfr.fsf@Rainer.invalid>
References: <xmqqpn3tqugm.fsf@gitster.c.googlers.com>
        <3f0403b84ab06b9deb7c5c189792bebe1db586a7.1606866276.git.matheus.bernardino@usp.br>
        <CA+kUOamDD_SDNLk3sPSwNAojrAAP+g38MjkfG4JMPRTGOVAKAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
Cancel-Lock: sha1:CJQEWcU0teKW3oD/vpwS+5vJjDQ=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adam Dinwoodie writes:
> To my surprise, the test fails if the worktree is under "/cygdrive",

/cygdrive is normally mounted with "posix=0", which only affects case
sensitivity, so that isn't the reason for this particular fail.  You
should anyway not build a Cygwin package with that option in effect,
instead create your own mount point for that directory (with
"binary,user" options).

> +++ diff -u f1_mode.expected f1_mode.actual
> --- f1_mode.expected    2020-12-19 16:50:20.169378700 +0000
> +++ f1_mode.actual      2020-12-19 16:50:20.249126000 +0000
> @@ -1 +1 @@
> --rw-------
> +-rw-rw-r--

You seemingly can't change the ACL and/or several mode bits and see the
effective access that your euid / egid has instead.  It is possible to
set up the (default) ACL in a way that removes the permission to change
them while otherwise still giving you what is effectively full access,
in which case the test fail is the result of an inability to remove the
default ACL from the directory.  I suspect your build directory is owned
by a different user than the one you're building with and/or has been
moved or re-used from another Windows installation that has different
SID.


Regards,
Achim.
-- 
+<[Q+ Matrix-12 WAVE#46+305 Neuron microQkb Andromeda XTk Blofeld]>+

Factory and User Sound Singles for Waldorf Blofeld:
http://Synth.Stromeko.net/Downloads.html#WaldorfSounds

