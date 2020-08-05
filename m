Return-Path: <SRS0=VMi1=BP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CC5BC433DF
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 16:44:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1F7122D00
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 16:44:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JV5bat/s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727987AbgHEQoI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Aug 2020 12:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727843AbgHEQmL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Aug 2020 12:42:11 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 914D2C0A3BE2
        for <git@vger.kernel.org>; Wed,  5 Aug 2020 06:34:43 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id r2so35643216wrs.8
        for <git@vger.kernel.org>; Wed, 05 Aug 2020 06:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:mime-version:content-transfer-encoding
         :fcc:to:cc;
        bh=MTXnC31mbqKtME2dg4BlqvSgzM1a+DywlJueRgG2Ht4=;
        b=JV5bat/sGpFmuvBUIbG4ncBvfKusle8b+zuMlobgdi4Y8NYN0Poi0fUxUSDpy/RfTh
         A5csgImlWDhahjHj/WLoBXblbvgAJ7XdU+PIismEpx5h9aDHV8vrvKAWAbttB9bHcx0v
         6xwpk3UH9vrlW8YbgJbzeWBOswkOm5ADmw+CqcB62Kk7XMyln2QYqvmTYvp5zUioJfqZ
         KimUz+swAD4DS022KKfAn32AqcAETFjkvVGvzQCW+qDDU08HUau53yKrpqLxnAj7H7Jp
         zcIy2v36gZSYQ6rzqx1a/+G9gLqN5k+HIV0n3vA/gNCIHPpfhbygTuqVyUp6lngj6XKs
         2bHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=MTXnC31mbqKtME2dg4BlqvSgzM1a+DywlJueRgG2Ht4=;
        b=sBEHq+GRLTk5jf/QN2ecMU/DClSLuBNuUm5fQXLzw9X9+DcYGioWKQ4e+dHTlaPnLY
         H9rzgBj/AOhO6pZOSnh4FSLdXOcD3nUf6rKftPrI3fwbFYTZDWDJwBdPGl2USxB3059S
         9PgDfcGpxYAVUecplALlyQEGdP4ohvXIoZcoNPxecCMtfGdL704k3vcbHx3HV+LqeuLZ
         LUcPVSMeji4tGXa7+ZMT6iAWvobAS1bUD9LOOiwBkMd8j7Bp54XPvkjDWWbXAR1verqI
         MNTWGhbAOT3GLWigVebvES8b8ZasAZ6hLcn6yiuv49vV/DrK3mJJCRXpYDAE3JahU7TS
         QE2w==
X-Gm-Message-State: AOAM532PudBhkKWp7/rq2F3DAkTks4zKv7pp3ID6vbPx4kWD7OPkSzJ7
        LPSBSk9bjtr/M4GqeDPV0xOniXJ/
X-Google-Smtp-Source: ABdhPJyrwjoGSrO/0RxadrX9H+kICO0ALmoXKMDuL1CG3M+aR0QRp4hNXK1xgJRytAjpb8tosPRN6g==
X-Received: by 2002:a5d:6646:: with SMTP id f6mr2876721wrw.155.1596634465182;
        Wed, 05 Aug 2020 06:34:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b139sm3009620wmd.19.2020.08.05.06.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 06:34:24 -0700 (PDT)
Message-Id: <pull.693.git.1596634463.gitgitgadget@gmail.com>
From:   "Marco Trevisan via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 05 Aug 2020 13:34:20 +0000
Subject: [PATCH 0/3] mergetool-lib: Don't use deprecated variable to detect GNOME
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Marco Trevisan <mail@3v1n0.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To list merge tool candidates we used to use a private GNOME env variable (
GNOME_DESKTOP_SESSION_ID) that has been deprecated for long time ago and
removed as part of GNOME 3.30.0 release [1].

So replace this using XDG_CURRENT_DESKTOP instead, and cleanup the code to
avoid duplication and supporting KDE's kdiff3 better.

[1] https://gitlab.gnome.org/GNOME/gnome-session/-/commit/00e0e6226371d53f65

Marco Trevisan (Treviño) (3):
  mergetool-lib: use $XDG_CURRENT_DESKTOP to check GNOME
  mergetool-lib: keep a list of cross desktop merge tools
  mergetool-lib: give kdiff3 prioirty in KDE environments

 git-mergetool--lib.sh | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)


base-commit: 85b4e0a6dc8407de6f69808d9ee6debdf167ced3
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-693%2F3v1n0%2Fdesktop-envs-fixes-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-693/3v1n0/desktop-envs-fixes-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/693
-- 
gitgitgadget
