Return-Path: <SRS0=N0vB=6Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D012C3A5A9
	for <git@archiver.kernel.org>; Sat,  2 May 2020 07:18:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 683D0208DB
	for <git@archiver.kernel.org>; Sat,  2 May 2020 07:18:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SNZsDE2r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726745AbgEBHSi (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 May 2020 03:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726468AbgEBHSi (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 2 May 2020 03:18:38 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7FAFC061A0C
        for <git@vger.kernel.org>; Sat,  2 May 2020 00:18:37 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id l78so11463477qke.7
        for <git@vger.kernel.org>; Sat, 02 May 2020 00:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=NUjoVXMmUOmkECBK3oLg2+9ySmuA7APPkqgfY/L2ArE=;
        b=SNZsDE2rcXGfbPKfSdk4r/TLBxsf469AWFj/f1tbRvrj30UToFgqJtGOyDakCurmQd
         29nggKtKANz5xSLEmNrcLXDZg1D6+OadWnfTXQZuIhUrMDjQNxNRcC4OgRM1V/M8NzYM
         znk6jhFW6XDeKVI2p00L5+zt7zddI+dWKS+g3n9yvclpAl4Wol9wD053eHPbc76E2IXO
         L2e3zs2kjUHStJqKBxvXfO5Z8S8rsOKjAAC4UcA4bF94r6XnCkCiSElZrvWQ3uHEO7Ty
         xt4dncR0ClyyEPLDTL7tdE16AnRTpSSYqGJjLhUlOzxUwOjXd2GRoVdx9gY+VE5ga8Rk
         FiyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=NUjoVXMmUOmkECBK3oLg2+9ySmuA7APPkqgfY/L2ArE=;
        b=pF/oPE3riTj9O+Z6o3Yr916Z25qAvrOL4knFQ0j5arDuEEdibomrZ0HDbhEhEGiVx5
         CPgx6nMwMyDd/52ORI1142m8h9X71HCpKX6N+Q/n2zLXwYwlV4f5yA6snhJIwY+IExnX
         555bebGIQXx8zxjeplFFAsmyjbD3PXQCm9B2qgsaySucN+T56WYApgX9DA6QJVuRsL7v
         MCNAzt/6H9rXHxg3mrovOUOfc1ecgRYcRP1hzp0hNWBpqAm88RN3rlR0a2DKYMdpJKBz
         7FIlESyL/duwW2Ff6Pr+5Ccs/ka+UFVvGfVZBqo8qon6M6lnooq1X2CeSubpp+NOh0GU
         FXsQ==
X-Gm-Message-State: AGi0PuYYNeMNvSLC1BQjVNNOkv2yJXElwKGYbP3vpVLHjks0hALEuXZg
        wj9mrTZ6Wj54T+3laa0O4hWfyLRmbXrbIa986QmTkFPaWaeMTw==
X-Google-Smtp-Source: APiQypIyQ5F+NeyY6A6mp7Q94y17oC2O+gFRHeZ1273MmqIeNsgOzfFZMxk66tnuXchkQ2U5wCjE8YUnFPRmNwLNW/U=
X-Received: by 2002:a37:aa8c:: with SMTP id t134mr7416465qke.231.1588403916810;
 Sat, 02 May 2020 00:18:36 -0700 (PDT)
MIME-Version: 1.0
From:   Erik Huizinga <huizinga.erik@gmail.com>
Date:   Sat, 2 May 2020 09:18:26 +0200
Message-ID: <CADA507xceVtpNkK5hyUrnXM0rPBj=sgpR0eM7b+yybiWT6Cg3w@mail.gmail.com>
Subject: Why are experimental commands git restore and git switch suggested in
 CLI output?
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello!

Lately I've noticed that when I checkout a branch or show the working
tree status, then the CLI output suggests that I can perform certain
actions with new commands (since v2.23 if I'm not mistaken) restore
and switch. This is very nice, because I like to see these UI
enhancements. However, reading the help pages for these commands shows
'THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHANGE.' This is
somewhat discouraging use, because I don't want to learn to use these
commands if their behavior may change. This could mean that what I
learn about these command may not be usable on future git versions.

My questions about this are:

1. What is the git maintainers' policy regarding experimental features
like restore and switch? Apparently, they are there to be discovered
in plain sight, while experimental. Using experimental features may
not be what the user wants.
2. What exactly may change about these commands' behavior? Are the
superficially suggested actions stable? Are they stable within a patch
or minor git version only? Are existing use cases stable, or can they
be removed or incompatibly change under this experimental policy?

In other words: how can I, an individual end user, know what I can
safely learn about these commands, and what can not?

Thank you in advance for your time and answers. :)
Erik Huizinga
