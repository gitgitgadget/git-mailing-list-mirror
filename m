Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37271C4332F
	for <git@archiver.kernel.org>; Thu, 13 Oct 2022 15:39:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbiJMPjv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Oct 2022 11:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiJMPjm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Oct 2022 11:39:42 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16F2B219A
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 08:39:37 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id j7so3467175wrr.3
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 08:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yX93x3eQYJh4tU/nmi7lNwTFwJ3JQCninVlGOe8DQ+Y=;
        b=LGwxBszROXXIXyicfuVZAyOL7k/EhdgKjII+az0pT4QPNW38P3NcQOa017JzVgmUsj
         /cwpcER+jzm9oD6YCOROVB1dFVK2xOdpRgYWMBc09KDxmuLIBZKwU84TkB4QFPZ57ewB
         z+be8zTiJXa3B4DUL1RdLsRiO7mPIilFiGVO8InC7IIFPJrVGApgfFqOZH/gW3jkrICD
         uphZjF0o+OctdLIjtAgQsHuGNhEZujsi8a/0l5OyGLlu8Th25vJ3Iy1QcCca8UHbIUq/
         8W1EhxkJ9BZCvWN4HUyI8AjYkU0EVl+2sIUtxhfPdYsy6Yhd7WG8wbIV1lujEINEHkIE
         psTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yX93x3eQYJh4tU/nmi7lNwTFwJ3JQCninVlGOe8DQ+Y=;
        b=w/BjW6EjJEgXl8mb8MLUx//qe3x9Mf5aDJy+U0bvCxHo6cXrJvKqRqe93R9GvxIbsP
         QeCFCvPLV9VgCnM/MraMLJuE3cxQc0wlpfBscdtSJ8sAoHNDgYJVGuKlQYs6uBjOAkyG
         +y5IvHrK7kn5ZVm4u7DpwNGmWxQaG6pRju8ZeLVgcS5GupvpNtxEMp2KgT13SA7eMgKH
         wTy3dJH0oXyE9SQtVo7kn/+zi7b2B97F5o+cggGAgiP2AlPhxDU/IphCZklE8AYGuc1x
         AafTs6YnHX+w3eOxbrr28vX6g0UZ4bYJEw3iP9y3BJV+26lYKlDw/sJuBlJGuHWOhda7
         I5Kw==
X-Gm-Message-State: ACrzQf0kwZjPl/Ees5xSsGIA8xgQllPhTiGp6+bIG4xOj4TK8z3TdGgR
        VYvqqe7f/pfY71wyjqoRAknQ8ELk1JUgUA==
X-Google-Smtp-Source: AMsMyM69iY7Z19VDBV1tv3DWlobkJUNY4JkDAwlVs1y71dbCzdBy6dZSA+jaTffxbYOcxg5U2KtAgw==
X-Received: by 2002:a5d:64eb:0:b0:22e:48df:f1bb with SMTP id g11-20020a5d64eb000000b0022e48dff1bbmr407298wri.262.1665675575863;
        Thu, 13 Oct 2022 08:39:35 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id da12-20020a056000408c00b0022a3a887ceasm2258130wrb.49.2022.10.13.08.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 08:39:35 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 02/34] CodingGuidelines: update and clarify command-line conventions
Date:   Thu, 13 Oct 2022 17:38:56 +0200
Message-Id: <patch-v5-02.34-998cd47045b-20221013T153625Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1085.gb7e61c3016c
In-Reply-To: <cover-v5-00.34-00000000000-20221013T153625Z-avarab@gmail.com>
References: <cover-v3-00.34-00000000000-20221004T131009Z-avarab@gmail.com> <cover-v5-00.34-00000000000-20221013T153625Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Edit the section which explains how to create a good SYNOPSIS section
for clarity and accuracy, it was mostly introduced in
c455bd8950e (CodingGuidelines: Add a section on writing documentation,
2010-11-04):

 * Change "extra" example to "file", which now naturally follows from
   previous "<file>..." example (one or more) to "[<file>...]" (zero or
   more).

 * Explain how we prefer spacing around "[]()" tokens and "|"
   alternatives, this is not a new policy, but just codifies what's
   already the pattern in the most wide use in the documentation.

Having a space around " | " for flags, but not for flag values is
inconsistent, but this style guide codifies existing
patterns. Grepping shows that we don't have any instance matching the
second "Don't" example:

	git grep -E -h -o '=\([^)]+\)' -- builtin Documentation/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/CodingGuidelines | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index cb7a367ea08..2a03f748551 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -648,8 +648,8 @@ Writing Documentation:
    (One or more of <file>.)
 
  Optional parts are enclosed in square brackets:
-   [<extra>]
-   (Zero or one <extra>.)
+   [<file>...]
+   (Zero or more of <file>.)
 
    --exec-path[=<path>]
    (Option with an optional argument.  Note that the "=" is inside the
@@ -663,6 +663,16 @@ Writing Documentation:
    [-q | --quiet]
    [--utf8 | --no-utf8]
 
+ Use spacing around "|" token(s), but not immediately after opening or
+ before closing a [] or () pair:
+   Do: [-q | --quiet]
+   Don't: [-q|--quiet]
+
+ Don't use spacing around "|" tokens when they're used to seperate the
+ alternate arguments of an option:
+    Do: --track[=(direct|inherit)]
+    Don't: --track[=(direct | inherit)]
+
  Parentheses are used for grouping:
    [(<rev> | <range>)...]
    (Any number of either <rev> or <range>.  Parens are needed to make
-- 
2.38.0.1085.gb7e61c3016c

