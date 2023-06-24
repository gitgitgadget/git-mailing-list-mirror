Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B06A6EB64DA
	for <git@archiver.kernel.org>; Sat, 24 Jun 2023 23:31:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbjFXXaS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 24 Jun 2023 19:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjFXXaQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Jun 2023 19:30:16 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E42F110F6
        for <git@vger.kernel.org>; Sat, 24 Jun 2023 16:30:14 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 83EE321BA3;
        Sat, 24 Jun 2023 19:30:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=5uFEkYoTGV4X/P1tg6vOxsRerWyIr3jSTLceat
        pdij8=; b=tzQSwnA6+piPaw2EwJX/ttGqc2kzbSK/ojNbQc6IOr11hROtU+RpmF
        y/PsP36HnYALOHevrkVlWLBQ+PQL6KZRTOZ0uLZDJBy49i5kbpq0xDjZAc0uLIsX
        s6x76+N672HSwlfdPggXva2LvOS6j/UqCuCn2gr87lifdGY5Bo6cw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7C04721BA2;
        Sat, 24 Jun 2023 19:30:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.62.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id AA5FE21BA0;
        Sat, 24 Jun 2023 19:30:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Mark Levedahl <mlevedahl@gmail.com>
Cc:     git@vger.kernel.org, adam@dinwoodie.org, me@yadavpratyush.com,
        johannes.schindelin@gmx.de
Subject: Re: [PATCH v0 0/4] Remove obsolete Cygwin support from git-gui
References: <20230624212347.179656-1-mlevedahl@gmail.com>
Date:   Sat, 24 Jun 2023 16:30:10 -0700
In-Reply-To: <20230624212347.179656-1-mlevedahl@gmail.com> (Mark Levedahl's
        message of "Sat, 24 Jun 2023 17:23:43 -0400")
Message-ID: <xmqq8rc8781p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 10692612-12E7-11EE-9FF8-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mark Levedahl <mlevedahl@gmail.com> writes:

> git-gui has many snippets of code guarded by an is_Cygwin test, all of
> which target a problematic hybrid Cygwin/Windows 8.4.1 Tcl/Tk removed in
> March 2012. That is when Cygwin switched to a well-supported unix/X11
> Tcl/Tk package.  64-bit Cygwin was released later so has always had the
> unix/X11 package. git-gui runs as-is on more recent Cygwin, treating it
> as a Linux variant, though two functions are disabled.
>
> The old Tcl/Tk understood Windows pathnames, so git-gui's Cygwin
> specific code uses Windows pathnames. The unix/X11 code requires use of
> unix pathnames, so none of the Cygwin specific code is compatible, and
> all should be removed.
>
> Fortunately, the is_Cygwin funcion in git-gui (on the git master branch)
> relies upon the old Tcl/Tk and doesn't detect Cygwin. But, commit
> c5766eae6f2b002396b6cd4f85b62317b707174e on the git-gui master branch
> "fixed" is_Cygwin, enabling the incompatible code, so upstream git-gui
> is now broken on Cygwin.

Here I presume "upstream git-gui master" refers to a5005ded (Merge
branch 'ab/makeflags', 2023-01-25) sitting at 'master' in Pratyush's
https://github.com/prati0100/git-gui/ repository.

> There is Cygwin specific code in the Makefile, intended to allow a
> completely unsupported configuration with a Windows TclTk.  This code
> misdetects the configuration, creating a non-portable installation. The
> Cygwin git maintainer comments this code out. The code should be
> removed.
>
> ...
>
> patch 1 removes the obsolete Makefile code
> patch 2 removes all obsolete git-gui.sh code, wrapped in is_Cygwin...

As it has been quite a while since I had access to any Windows box
or Cygwin, but the earlier two patches look obviously correct to me.

> The existing code for file browsing and creating a desktop icon is
> shared with Git For Windows support, and uses Windows pathnames. This
> code does not work on Cygwin, and needs replacement.  These functions
> have not worked since 2012.
> ...
> patch 3 implements Cygwin specific file browsing support
> patch 4 implemetns Cygwin specific desktop icon support

Both of these two patches do

	if {[is_Windows]} {
		... do Windows thing ...
+	} elseif {[is_Cygwin]} {
+		... do Cygwin thing ...
	} elseif {[is_MacOSX]} {
		... do macOS thing ...
	} else {
		... do it for others ...
	}

which I do not quite understand how the existing code meshes with
your "is shared with Git For Windows support", though.  If "is
shared with GfW" is to be trusted, on a modern Cygwin box,
"is_Windows" would be yielding true (that is the only way the "do
Windows thing" block will be entered on Cygwin box, sharing the
support with GfW.  But then, adding elseif _after_ we check for
Windows would be pointless.  Puzzled...

Thanks.

