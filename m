Return-Path: <SRS0=Vx3J=3N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32C11C32771
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 21:19:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0702E2077C
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 21:19:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b+4BOnCo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387476AbgAXVT4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jan 2020 16:19:56 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34454 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387423AbgAXVTy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jan 2020 16:19:54 -0500
Received: by mail-wm1-f65.google.com with SMTP id s144so4838953wme.1
        for <git@vger.kernel.org>; Fri, 24 Jan 2020 13:19:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=7OIxkWhiTuACvbhbr0mgY5mdi0HMxPaJU+8Iq5N0peE=;
        b=b+4BOnCoCsXc+7Tk63m0eF7nsmeYUJaCIxoysFKcHxkdUUxBbrFrsqFg+xbNuGKu7M
         IpB9WAuEmb3SvRS2WtwcTC/ByntGdCfTkaradFO58YIZsk2P8y4z140vTQ9el3VOJp2D
         1u1tdLYhUvz/PWvE79WnOj8jLgde/CtlkAFbh2eH9wpBXG9Ftwzbg1a6SuThKrYGahwF
         oATXPqwbyE9dCEm8mauTYLWSmQXlek0mli69U3F5a5kkJJxDRfIpw4ny07aQLTnF7E2H
         hgg3/ALVRN6nItY2M3K7pQ5mbWvo47+tD40hkAht6neVhU+oNUI4qZunrlcpr+JeACl5
         GIcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=7OIxkWhiTuACvbhbr0mgY5mdi0HMxPaJU+8Iq5N0peE=;
        b=BjnPlCt1avXuRgUvParv8wa6WCOvcVJLnG9ZczMYrCw8zARmFMJ7lG+fiSWo7vMBs0
         hTee5OlfwLZ9DWFd28aSvpG1um3BP6uCnfyeJQodHx9v/iZHJ+IWODklMJS3xp1nnbEu
         3/Srhh77jgHRBkqVqz6sDFLat866wcH3APLacpF44Z8IXqgpG0IdxTB0g0QkoOVxjGAL
         eStTrDXMM14K0HRZEBqkKDMrGu4Ln4weFEjIKuEduZnE+VnULvKj2qaKNrTssmQ4pvi5
         DuA58sm3Mb9z+szkHXYJF/EqZwUQVOFxMEpaJMvEHOAyb47is3meQBEIdRki/4S6OGTb
         PqPw==
X-Gm-Message-State: APjAAAWpjhBpJU6dQtD0gnjBJPwXwPdg47U0AogOJAh5IycaYoOatCR0
        NQIFomy+lXbOBikcgq6Puj1F4L/z
X-Google-Smtp-Source: APXvYqycEJjcBKVKR0ZLY1K7OZR8Mc5SAR6zUf8CWfEFQtCObeOjyk1ceypal6AfgJ3eVbsl5xa7eA==
X-Received: by 2002:a05:600c:2318:: with SMTP id 24mr1046688wmo.48.1579900792300;
        Fri, 24 Jan 2020 13:19:52 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o2sm7459009wmh.46.2020.01.24.13.19.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2020 13:19:51 -0800 (PST)
Message-Id: <1b5858adee36e326b7a98f3ca2a3c36c9ba5b85c.1579900782.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.513.v2.git.1579900782.gitgitgadget@gmail.com>
References: <pull.513.git.1579029962.gitgitgadget@gmail.com>
        <pull.513.v2.git.1579900782.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 24 Jan 2020 21:19:42 +0000
Subject: [PATCH v2 12/12] sparse-checkout: improve docs around 'set' in cone
 mode
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, peff@peff.net, newren@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The existing documentation does not clarify how the 'set' subcommand
changes when core.sparseCheckoutCone is enabled. Correct this by
changing some language around the "A/B/C" example. Also include a
description of the input format matching the output of 'git ls-tree
--name-only'.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-sparse-checkout.txt | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-sparse-checkout.txt b/Documentation/git-sparse-checkout.txt
index 4834fb434d..0914619881 100644
--- a/Documentation/git-sparse-checkout.txt
+++ b/Documentation/git-sparse-checkout.txt
@@ -50,6 +50,14 @@ To avoid interfering with other worktrees, it first enables the
 +
 When the `--stdin` option is provided, the patterns are read from
 standard in as a newline-delimited list instead of from the arguments.
++
+When `core.sparseCheckoutCone` is enabled, the input list is considered a
+list of directories instead of sparse-checkout patterns. The command writes
+patterns to the sparse-checkout file to include all files contained in those
+directories (recursively) as well as files that are siblings of ancestor
+directories. The input format matches the output of `git ls-tree --name-only`.
+This includes interpreting pathnames that begin with a double quote (") as
+C-style quoted strings.
 
 'disable'::
 	Disable the `core.sparseCheckout` config setting, and restore the
@@ -128,9 +136,12 @@ the following patterns:
 ----------------
 
 This says "include everything in root, but nothing two levels below root."
-If we then add the folder `A/B/C` as a recursive pattern, the folders `A` and
-`A/B` are added as parent patterns. The resulting sparse-checkout file is
-now
+
+When in cone mode, the `git sparse-checkout set` subcommand takes a list of
+directories instead of a list of sparse-checkout patterns. In this mode,
+the command `git sparse-checkout set A/B/C` sets the directory `A/B/C` as
+a recursive pattern, the directories `A` and `A/B` are added as parent
+patterns. The resulting sparse-checkout file is now
 
 ----------------
 /*
-- 
gitgitgadget
