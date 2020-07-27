Return-Path: <SRS0=S8Id=BG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E7BFC433E4
	for <git@archiver.kernel.org>; Mon, 27 Jul 2020 20:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B2B92074F
	for <git@archiver.kernel.org>; Mon, 27 Jul 2020 20:43:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R7kUD0Fq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgG0UnN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jul 2020 16:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726091AbgG0UnM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jul 2020 16:43:12 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1776C0619D2
        for <git@vger.kernel.org>; Mon, 27 Jul 2020 13:43:11 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id o8so15299414wmh.4
        for <git@vger.kernel.org>; Mon, 27 Jul 2020 13:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=TO4p8sD3Gu+F94PhkH9t9JgQEE+z1KFoekt5K0kCZ28=;
        b=R7kUD0FqEYzLJt2sMMuMt4LKZ0ECPx+xDGIzmjusKR0qj47ipPz9RX2wuvFNneQAEH
         WYJ8ZP48ZpRVSbfh7nVIc97DUbnzBIIErCu5p0FFhrpI68VecechPiRNXchUmYr+ODqu
         Gu1WcNsyHtRfpGv0vp7C32GBHLwQ9FDOvIEEIKYU6407g9MFqyobV2PfJS2NkgEtC2I0
         uMIc42m1uwWW5tBl5ji3lA9eL4WTHQ4Q7kmwt2FlY31Jwzw88JEjynaJXJccEa0nMy+2
         aDUUbRSbJnW/9FO1R1MVX8k04tB+bCyzIgjhJlvftBoAt9EtpEyBVjcN0mT2srCGkit2
         SX9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=TO4p8sD3Gu+F94PhkH9t9JgQEE+z1KFoekt5K0kCZ28=;
        b=WhfBTD3ERG70bs1Bb4sBvt/YUtyF2kc7IYgqJazo8I5kc1IsDGOb/UmasJqRrX0qVW
         PTs8Pxr8FMUxqqjG1+jhM7u690WKREpp1RKy60Yyybr4bX2XKoOiBTm7famb1j220a2V
         A3hhiDgH48g/u51bcMezvg9DR5YlC1UGxs1i3dHwXfQa2Emnv+7K8lXPX8hk0eN7PguO
         EqJhQNAjP9nXuaXO2k54bGHcyG6OH4YT7UEhd7RkHt/CWaKn+mi+xkKI18iwzVG6Yw+t
         Ti0erxHXd0lhdrMnb0HDW8/xcyOPbgxcg8+i+KSQ3mdO8BOSbiJ+ABzaLWEwTIgUEDXO
         kqlQ==
X-Gm-Message-State: AOAM531oo4vdtRSFEs3iMZ58uxd+XzSCrRoSXAdQQXFHgIEFxp4MOCFl
        yg7x0Z9WQBf3EVgwjfQBXhD7+sPE
X-Google-Smtp-Source: ABdhPJxSz5ui7Ne8JbJes+RmLqbjiBAe9bBx1sxcDkjR17Uaceizc8NAjm2uU3UBrpTL6Viv8UnHLA==
X-Received: by 2002:a05:600c:414f:: with SMTP id h15mr944811wmm.82.1595882590329;
        Mon, 27 Jul 2020 13:43:10 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h11sm14934631wrb.68.2020.07.27.13.43.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 13:43:09 -0700 (PDT)
Message-Id: <pull.684.git.1595882588.gitgitgadget@gmail.com>
From:   "Hariom Verma via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 27 Jul 2020 20:43:03 +0000
Subject: [PATCH 0/5] [GSoC] Improvements to ref-filter
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Hariom Verma <hariom18599@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is the first patch series that introduces some improvements and
features to file ref-filter.{c,h}. These changes are useful to ref-filter,
but in near future also will allow us to use ref-filter's logic in pretty.c

I plan to add more to format-support.{c,h} in the upcoming patch series.
That will lead to more improved and feature-rich ref-filter.c

Hariom Verma (5):
  ref-filter: support different email formats
  ref-filter: add `short` option for 'tree' and 'parent'
  pretty: refactor `format_sanitized_subject()`
  format-support: move `format_sanitized_subject()` from pretty
  ref-filter: add `sanitize` option for 'subject' atom

 Makefile                |  1 +
 format-support.c        | 43 +++++++++++++++++++++++++
 format-support.h        |  6 ++++
 pretty.c                | 40 +++---------------------
 ref-filter.c            | 69 ++++++++++++++++++++++++++++++++++-------
 t/t6300-for-each-ref.sh | 27 ++++++++++++++++
 6 files changed, 138 insertions(+), 48 deletions(-)
 create mode 100644 format-support.c
 create mode 100644 format-support.h


base-commit: 5c06d60fc55d2213c089f63c282468080f812686
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-684%2Fharry-hov%2Fonly-rf6-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-684/harry-hov/only-rf6-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/684
-- 
gitgitgadget
