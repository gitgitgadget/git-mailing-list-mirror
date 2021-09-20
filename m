Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DB36C433EF
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 07:38:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B7FF60F43
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 07:38:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbhITHj0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Sep 2021 03:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbhITHj0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Sep 2021 03:39:26 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2911C061574
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 00:37:59 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id u18so25392235wrg.5
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 00:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:mime-version:content-transfer-encoding
         :fcc:to:cc;
        bh=Vs3TWngXHGp6dg9gt43UKpiWreV/EzmdtKkZ9KSr90A=;
        b=OJd3TZCiYPXl6hYtFfaEQLN8K/864NlooZUK1duWtKJXUsBEYqRt8XSZDQ1UnUE+QG
         xktQPr1vUuy/PFe1y4vafW5+e2CagMYwiTlzVZxHfuhKwIq0ORuy4rw5w3IuE70MeE8q
         PEIwrlq4PKxVHm2WPsfa3XZDAx7aIrfzoYxf0Nhpf1N9gpGHp8BE1XlRlrmu2PkOtWtK
         nzprN4DKILzppE53I+B0tH6GJvj+f3ELChGojBw4PdF1PYRRskhjwlJictaROQnBxOKS
         knO7GCQemIsuH9Q6uctmfirzX9ZrFUgl2OhvR6ljHEX9H6asWTh7q3Wv+0DJSmyPBE31
         Gdew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=Vs3TWngXHGp6dg9gt43UKpiWreV/EzmdtKkZ9KSr90A=;
        b=MNGrKmB5n8/Umq7k4rIgfHUJ/hp3j59/N8faZXyq+TqU2qIvhTuy/zRuuWMX5IOydm
         FVU4nMIZMUF0+8TOprfD2ezCb5xxsV5pmtHiEXuKFGeJi08/oDYmdEFiB8QRS3pYO7TO
         v9yVIYX2qNSP7r86KcnbXB9Vrrm+a6lBiGa5DDicaHGH+0meiXmzgngOJ+5SvD3o1lbx
         rcXlEuz3DWMUKncLg2lJ04IxUhMJ31ZYmHcI18QssXaPVgZMMHKDZxq28cWgCgWGHqSM
         Hgu039BUCIdC5rpLRNHtvd9b+F5jWzIdP2hiWN0l3b3YmHXaeARAtprUh0qg7twp1wEC
         9Vug==
X-Gm-Message-State: AOAM531OlFAVdmjFz3LUYSp7n6WNAm8R8cv2LdvDiDJpjhqs7EWREgXS
        XSjeLc5lWkwVMzb5MQcZ3aqqcoDZoLI=
X-Google-Smtp-Source: ABdhPJy73OUl0pAK1dJEN0RUv3MCp8Uvxz6U8eFHwIMM5dlamhFgLAZVk3BVYXbzS8pGnt2jTfMoag==
X-Received: by 2002:a5d:6d8a:: with SMTP id l10mr26836394wrs.121.1632123478353;
        Mon, 20 Sep 2021 00:37:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h8sm17845994wmb.35.2021.09.20.00.37.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 00:37:57 -0700 (PDT)
Message-Id: <pull.1042.git.1632123476.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 20 Sep 2021 07:37:52 +0000
Subject: [PATCH 0/4] ref-filter: fix %(symref) for pretty_print_ref()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Because pretty_print_ref() currently has no ref_item flag, but the
implementation of %(symref) need this flag, so git tag --verify or git
verify-tag cannot get the output of %(symref). Therefore, %(symref) will be
fixed in this patch series.

This bug was discovered by Peff here:
https://lore.kernel.org/git/YUO63qy2%2F5wibY4%2F@coredump.intra.peff.net/

on the other hand, git tag --verify --format="%(refname)" or git verify-tag
--forrmat="%(refname)" does not show the fullref name, but seems to be
similar to using %(refname:lstrip=2).

And git verify-tag --format="verify: %(refname)" c06b72d02` will output:
"verify: c06b72d02". They are wrong features, but because some scripts are
using them, so our current approach is to keep them.

ZheNing Hu (4):
  refs: let repo_dwim_ref() learn get symref itself and ref flags
  ref-filter: provide ref_flags to pretty_print_ref()
  verify_tag: use repo_dwim_ref() to get ref fullname and ref_flags
  ref-filter: let tag verify use %(refname:lstrip=2) by default

 builtin/tag.c         | 16 ++++++++-------
 builtin/verify-tag.c  |  9 ++++++++-
 object-name.c         |  6 +++---
 ref-filter.c          | 47 +++++++++++++++++++++++++++++++++----------
 ref-filter.h          |  4 +++-
 refs.c                | 15 +++++++++-----
 refs.h                |  8 +++++---
 t/t7030-verify-tag.sh | 23 +++++++++++++++++++++
 upload-pack.c         |  2 +-
 9 files changed, 98 insertions(+), 32 deletions(-)


base-commit: 8b7c11b8668b4e774f81a9f0b4c30144b818f1d1
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1042%2Fadlternative%2Fpretty-print-ref-symref-fix-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1042/adlternative/pretty-print-ref-symref-fix-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1042
-- 
gitgitgadget
