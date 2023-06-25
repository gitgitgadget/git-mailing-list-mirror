Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DE2DEB64DA
	for <git@archiver.kernel.org>; Sun, 25 Jun 2023 02:56:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbjFYC4Y convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sat, 24 Jun 2023 22:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbjFYC4W (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Jun 2023 22:56:22 -0400
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23E17E50
        for <git@vger.kernel.org>; Sat, 24 Jun 2023 19:56:21 -0700 (PDT)
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6348a8045a2so10303666d6.1
        for <git@vger.kernel.org>; Sat, 24 Jun 2023 19:56:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687661780; x=1690253780;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=egqpQgAc+x1BNPXkvgKpQ5nZVFXKDPd8WVQZduANtFQ=;
        b=lkHR2CeJZGJXGPqgApLhCBqcQW+nFsUiUbvv1lC5M6yhytdJUetQrOOJZD9eZB6Z4T
         xREMGXjXnhYq/5TBoWvlP5sMjpzxXLN31pPucWGxVXTP4nNEPWmX4isljLBfX1eZolIU
         9gsqd1BooDSD6VfaH3ay5fBoB18z4HEJTfK28EhfC5ZOGZIUWlKqn6/2d/XPJF3UEa5G
         I6OKYFqWACQ+xkeZjYJklORf9lh05fcOGntyV9Rr5vhz9doQ2UAXUcApBlPckv+l+cDz
         u6vBW+aCbO9XbB8/ybcrlBem+B2aXdPNnRorv1AVc+GnlpaXw+EadMC9CmK9ZSVbJEG9
         sItg==
X-Gm-Message-State: AC+VfDz8GSi9QBBtz5JPZ9s6htfepf6BfnynkQPHi4yAZ/hz1itVC0Ms
        IF+S+GOxqBx/Vk930tneNCdDKDCg/YWtSq3fl50=
X-Google-Smtp-Source: ACHHUZ5I1eL4yVb2H1EWo6QCjW9jQQfFw/YmthlF54RSFOxAHpxWzgKpqYMpU/6ioNoICB21ekfh1yW8Q+FaZA04Fog=
X-Received: by 2002:a05:6214:1c87:b0:62d:f27a:c3fd with SMTP id
 ib7-20020a0562141c8700b0062df27ac3fdmr29441369qvb.7.1687661780080; Sat, 24
 Jun 2023 19:56:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230624212347.179656-1-mlevedahl@gmail.com> <20230624212347.179656-3-mlevedahl@gmail.com>
In-Reply-To: <20230624212347.179656-3-mlevedahl@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 24 Jun 2023 22:56:09 -0400
Message-ID: <CAPig+cTQcN9um=Pmtze9wyM_kBezpFQ4tJ-LsC-Jh37L=93Bpw@mail.gmail.com>
Subject: Re: [PATCH v0 2/4] git-gui - remove obsolete Cygwin specific code
To:     Mark Levedahl <mlevedahl@gmail.com>
Cc:     git@vger.kernel.org, adam@dinwoodie.org, me@yadavpratyush.com,
        johannes.schindelin@gmx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 24, 2023 at 5:35 PM Mark Levedahl <mlevedahl@gmail.com> wrote:
> In the current git release, git-gui runs on Cygwin without enabling any
> of git-gui's Cygwin specific code.  This happens as the Cygwin specific
> code in git-gui was (mostly) written in 2007-2008 to work with Cygwin's
> then supplied Tcl/Tk which was an incompletely ported variant of the
> 8.4.1 Windows Tcl/Tk code.  In March, 2012, that 8.4.1 package was
> replaced with a full port based upon the upstream unix/X11 code,
> since maintained up to date. The two Tcl/Tk packages are completely
> incompatible, and have different sygnatures.

Given the context, an understandable typo perhaps: s/sygnatures/signatures/

> When Cygwin's Tcl/Tk signature changed in 2012, git-gui no longer
> detected Cygwin, so did not enable Cygwin specific code, and the POSIX
> environment provided by Cygwin since 2012 supported git-gui as a generic
> unix. Thus, no-one apparently noticed the existence of incompatible
> Cygwin specific code.
>
> However, since commit c5766eae6f2b002396b6cd4f85b62317b707174e in
> upstream git-gui, the is_Cygwin funcion does detect current Cygwin.  The
> Cygwin specific code is enabled, causing use of Windows rather than unix
> pathnames, and enabling incorrect warnings about environment variables
> that are not relevant for the fully functional unix/X11 Tcl/Tk. The end
> result is that git-gui is now incommpatible with Cygwin.

s/incommpatible/incompatible/

> So, delete all Cygwin specific code (code protected by "if is_Cygwin"),
> thus restoring the post-2012 behaviour. Note that Cygwin specific code
> is required to enable file browsing and shortcut creation (supported
> before 2012), but is not addressed in this patch.
>
> Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
