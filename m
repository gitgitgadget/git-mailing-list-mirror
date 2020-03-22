Return-Path: <SRS0=O1OI=5H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2C9CC54FCF
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 15:11:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E4252072E
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 15:11:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oYEWsrlW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbgCVPKf (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Mar 2020 11:10:35 -0400
Received: from mail-oi1-f170.google.com ([209.85.167.170]:39296 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbgCVPKf (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Mar 2020 11:10:35 -0400
Received: by mail-oi1-f170.google.com with SMTP id d63so12056449oig.6
        for <git@vger.kernel.org>; Sun, 22 Mar 2020 08:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=8MRni2Ih+TNerJElztUjWRvDDjFgxQ9ZvMucMJWjFkE=;
        b=oYEWsrlWjN6JaFzJmZsZdLO/7J3ZyEAmtkZJWHAU+B8IrYcR5sSna5n61nB4z3raYX
         e3u3jKjaaraJh3Hv+l2PYtOuP0jFrT+HrdBdsJvMha2TE90sszjocq3mK00nhgNETZMO
         j1bbkXTacMH9wfRV18ZEDLzZPOJJ0qDAox0+yrytGDtUTGUFtmWQeGqLeOb1suh96skf
         dJl2KOkW4DvWRm7iHPIHc1UOTrdpHJY+7T6U5Mq2k7V3l0+psyGdS4eS+zlWpexXFHsJ
         a5MthfxzPIKpy30C+UGBTupw9CBHAHOMptYXkDvrUsJCLP5Y19YeW1DPcHmcQRgwuhZR
         Ch8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=8MRni2Ih+TNerJElztUjWRvDDjFgxQ9ZvMucMJWjFkE=;
        b=ehcvghRmbhEY0CwkRpCWjvgBfnTHg85rnBrDrYfXg7BhtjF2hfg0M5OZRc2nQDr+eE
         IP3527mLx5qLF8SstRVb2Z0RUvZI05OIQGdrMCJJZAeybIVb2UzIrkG7lDZ1Yy4Med4V
         j2THToet01nzNp/ZnacBUnRD+EnvHPCXRJOoEGSSAqbCIXhf0FgdY1izEaZQckxxAUCH
         LbIgXa3zoREDeBvLSbO5C6hxGFJFAUGfrrIdT6caDibPGLsgMVpBMLakMDHb52yNyeh6
         yE1PqqpFdVpifeLCXZBZMZwlQRBKaXak4KVAmHAgEOa6Xgc5zomcQxj41e2GXl1h7v8U
         H6lQ==
X-Gm-Message-State: ANhLgQ1N7cj9c6d872c/pYTSkZ9z9Nrj1GS+bEohS+Qm/RV13m3R8pb7
        WeuKUYKZz8w9fcM/8ZBU9+ioOnth9LIqmTIirnEF2A2u
X-Google-Smtp-Source: ADFU+vsWAyKbwuFMK7WleEHxnrWDX6p0GnjMo1BmUPuTcPjlyD/9uXiwau7TlziV+ZQ9DZWS9m+JKWWyUiN0TH6ORWU=
X-Received: by 2002:aca:4bc5:: with SMTP id y188mr14250134oia.9.1584889833958;
 Sun, 22 Mar 2020 08:10:33 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?B?zqPPhM6xz43Pgc6/z4Igzp3PhM6tzr3PhM6/z4I=?= 
        <stdedos@gmail.com>
Date:   Sun, 22 Mar 2020 17:09:57 +0200
Message-ID: <CAHMHMxW=muHe5qqndtdzR_md6KFQqwEonko-2gXC_q973JgB5w@mail.gmail.com>
Subject: git stash push/save/create all return exit code 0, even if no object
 was created
To:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello there,

I am trying to run a `git checkout` command on a repository, without
the possibility of getting any error message about files interfering
with the checkout process.
I thought a safe way to do this was to run `git-stash`, similarly to
`rebase.autoStash = true`

However, I find two issues with those:
1) Exit code is 0, even if no object/stash was created.

It feels weird to parse stdout/stderr to decide "what happened".

2) `git stash create` (which sounds more like what I need), does not
clear what it was stored.
I can "take the pain" of printing the object-sha1 to be traceable if
something happens (even though I would prefer more if it was
"securely" stored in `refs/stash` i.e. `git stash push`), but then
`git stash` won't clean what it just stored.
Is the solution to also run `git reset --hard` there?

With regards,
Ntentos Stavros
