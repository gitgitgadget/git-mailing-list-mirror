Return-Path: <SRS0=wsT/=ED=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCD98C4363A
	for <git@archiver.kernel.org>; Wed, 28 Oct 2020 22:41:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74EE3218AC
	for <git@archiver.kernel.org>; Wed, 28 Oct 2020 22:41:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XhfKLZLp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389128AbgJ1Wl1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Oct 2020 18:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389104AbgJ1Wl0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Oct 2020 18:41:26 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1313EC0613CF
        for <git@vger.kernel.org>; Wed, 28 Oct 2020 15:41:26 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id r127so808521lff.12
        for <git@vger.kernel.org>; Wed, 28 Oct 2020 15:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=fYU+dfNBH+rlVl8H7koVwTnKCfmWaaJSBPn9tUjxyu8=;
        b=XhfKLZLpfuydzZGm/qjrGXME1X+7qdkvo+aV1u8fuYe0ZBssp9BE1vnJNVVc7MrXwN
         22OvV9U1fyT4xTqwYra9TaWVXunrEuToPrkoHB2dwmCrOLqp29JFj6BjNcPhcxlH1u8i
         a+JdI9efMHMyqqvTbLMwAYlFSGcmxizUjxZ0oCuorPeqX7a1RqUuNNlqM+0B/wHfsdIj
         TJSuL5R9oE7v2kh6y1tXSFr9Y9sYZ5je8VjzKEG9Wpoi7BO66iToDln/D24SSOdw9U/3
         qJb1sOOgxWfwMnSXOXyqC/2HUfxbhm4nVyBy4P7DQDHqA1tJJQxm5OWgwMYcbjJe7qxG
         F/Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=fYU+dfNBH+rlVl8H7koVwTnKCfmWaaJSBPn9tUjxyu8=;
        b=VaNRDRQMlwp/1rB+TapVWk4aXkSkVB+EhezkrnSLJbQYlVIEKzeyMw6ckQK7j9Mvwx
         H8WqcmQfno4KoaG9umk8R8r/r+70OJOiemRf8eRIdVDvY5SDo4GbRzA2SXctTrdlG4gw
         Qi1qw6lgglognRx7k2YHf/GxGohutmF40sh5oLDMpAq4SKBxuZAVPS3XmEGsZrmR/Y3z
         k0RHX+oqCoQhdrQl/ZcCCYR/NqXuDAf17+YaF+qocm5YqA7AYnKy77lSD5cajZ25AR7u
         qIBedy329kuAlY/2J7JdL37oYe06Bf/rS+PF80zJ+T2nN90X3AwKJfjoxyjC8P2wHYTl
         YgIg==
X-Gm-Message-State: AOAM533pFKAoOjPr6Cn6cPClXViiDPKUjxfmWfR9L0GALE6hpuAw3xCG
        d2lRmCwQ8sJphwE/eNbBDwa8VzbfCjE=
X-Google-Smtp-Source: ABdhPJxHpCNTIkAr8chljrlZ9ILwL4ozJyUfuekxaLA3TaIYEYVvEkDXn4L02+8ITRmSoQCnqRrsEg==
X-Received: by 2002:a5d:4088:: with SMTP id o8mr9043186wrp.2.1603889275021;
        Wed, 28 Oct 2020 05:47:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c10sm5988393wmb.20.2020.10.28.05.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 05:47:54 -0700 (PDT)
Message-Id: <f7b64bf3302f934c44cf9364e4f008bb9ce26def.1603889270.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.774.git.1603889270.gitgitgadget@gmail.com>
References: <pull.774.git.1603889270.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 28 Oct 2020 12:47:47 +0000
Subject: [PATCH 3/6] blame-options.txt: also mention 'funcname' in '-L'
 description
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Thomas Rast <tr@thomasrast.ch>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

Make it clearer that a function can be blamed by feeding `git blame`
'-L :<funcname>' by mentioning it at the beginnning of the description
of the '-L' option.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 Documentation/blame-options.txt | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/blame-options.txt b/Documentation/blame-options.txt
index 48bf0eeec5..8b4a90e349 100644
--- a/Documentation/blame-options.txt
+++ b/Documentation/blame-options.txt
@@ -11,8 +11,9 @@
 
 -L <start>,<end>::
 -L :<funcname>::
-	Annotate only the given line range. May be specified multiple times.
-	Overlapping ranges are allowed.
+	Annotate only the line range given by '<start>,<end>'
+	(or by the function name regex '<funcname>').
+	May be specified multiple times. Overlapping ranges are allowed.
 +
 '<start>' and '<end>' are optional. `-L <start>` or `-L <start>,` spans from
 '<start>' to end of file. `-L ,<end>` spans from start of file to '<end>'.
-- 
gitgitgadget

