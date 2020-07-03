Return-Path: <SRS0=CKFy=AO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B040CC433E0
	for <git@archiver.kernel.org>; Fri,  3 Jul 2020 03:38:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B58B20890
	for <git@archiver.kernel.org>; Fri,  3 Jul 2020 03:38:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o5l6vSlP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726119AbgGCDih (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Jul 2020 23:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbgGCDif (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Jul 2020 23:38:35 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9018AC08C5DD
        for <git@vger.kernel.org>; Thu,  2 Jul 2020 20:38:34 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id z13so30992472wrw.5
        for <git@vger.kernel.org>; Thu, 02 Jul 2020 20:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=GLQfXtzWHfQb19pFZFKpYOZDCU3wLS/gxdWh64/R6sc=;
        b=o5l6vSlPl2sS5NaCd/aIN8hM+cfSPkiuazak0yDNYBBLAzYCac8CvLHhwKcG1y42We
         AudOfqPValThb99UnIbxxbaP9T1i8cw6Uk+vwe/5fegWv8xyFbzdgps7fRRm/DxBOkIl
         NwT0wLuPrggH4vsHzKQ+dCAB00Yr8QqUu9WCWWuWEizD03+fWSdGNMiDtyWSsqn6rt0f
         3fj/wRHBjAQNDLfpRhujkGna+Ttx0NcVFSzAhEK4tengCEGT9+7fBvBeZTppqBZjHIbw
         Mj+A0Ok5bAWGL+Mh6qi4QiXOE+JKBipiyxGcegMzzEpXRGG26nCcxIrBQ6zRQhYfgDrV
         gAAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=GLQfXtzWHfQb19pFZFKpYOZDCU3wLS/gxdWh64/R6sc=;
        b=ZcBocovDHE+CmS/XT9jqzHYLxFPd7N5nihBzGya21PM2JSl+WHoL0buzZ79yNFgEKw
         dmCJi8soDj1UA4DJlX0GEE4rsj+wG1Fy804L06CK3HmUfFLQbBzkrQzz63nTxLf3tDM4
         AmgXXlRiDQnrg8/EilfkDaqDSP7OULV31YHulTkEfSePO0tfMQwtJZ0GwUPPs66V2LOE
         ZYG3/3Q/aaMfNQO+Rp8GNSEWOTl+vLelXZLyaEOjXT4JmuhF2D60ZFENrukL3OVQVgxd
         Sim+U4DwOdpsMig6VQem/KDb7Hsh/s9Mbs0YSDR7olUGh5Hzsxs4QoXPIaOsTASjBJMq
         99cw==
X-Gm-Message-State: AOAM532mnlSEWoeLCW9op4hOiwaOfPBWt9aMxhf9hjqzpDiLHfBNjEwY
        xYW8pDPbRjHzccyVsOvpDjydLaZj
X-Google-Smtp-Source: ABdhPJwrtJ8tG6NdWi2LMJak9TYcr96qpaxaP4RDcy7/RIHEKz/o5uiorJWzViZYBC52ogeJgPpFjA==
X-Received: by 2002:a5d:4d8b:: with SMTP id b11mr34760809wru.341.1593747513188;
        Thu, 02 Jul 2020 20:38:33 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f16sm12067395wmf.17.2020.07.02.20.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 20:38:32 -0700 (PDT)
Message-Id: <3b923780c1f38ee183397b5766aae65933eec4aa.1593747509.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.590.v2.git.1593747509.gitgitgadget@gmail.com>
References: <pull.590.git.1585429894378.gitgitgadget@gmail.com>
        <pull.590.v2.git.1593747509.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 03 Jul 2020 03:38:29 +0000
Subject: [PATCH v2 4/4] rev-list-description.txt: fix Asciidoc syntax
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Lawrence Siebert <lawrencesiebert@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

Using '{caret}' inside double quotes and immediately following with a
single quoted word does not create the desired output: '<commit1>'
appears verbatim instead of being emphasized.

Use a litteral caret ('^') instead.

Also, remove the leading tabs in shell examples to bring them more in
line with the rest of the documentation.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 Documentation/rev-list-description.txt | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/Documentation/rev-list-description.txt b/Documentation/rev-list-description.txt
index dce78561be..4bde2fd4fe 100644
--- a/Documentation/rev-list-description.txt
+++ b/Documentation/rev-list-description.txt
@@ -14,12 +14,12 @@ Thus, the following command:
 
 ifdef::git-rev-list[]
 -----------------------------------------------------------------------
-	$ git rev-list foo bar ^baz
+$ git rev-list foo bar ^baz
 -----------------------------------------------------------------------
 endif::git-rev-list[]
 ifdef::git-log[]
 -----------------------------------------------------------------------
-	$ git log foo bar ^baz
+$ git log foo bar ^baz
 -----------------------------------------------------------------------
 endif::git-log[]
 
@@ -27,19 +27,19 @@ means "list all the commits which are reachable from 'foo' or 'bar', but
 not from 'baz'".
 
 A special notation "'<commit1>'..'<commit2>'" can be used as a
-short-hand for "{caret}'<commit1>' '<commit2>'". For example, either of
+short-hand for "^'<commit1>' '<commit2>'". For example, either of
 the following may be used interchangeably:
 
 ifdef::git-rev-list[]
 -----------------------------------------------------------------------
-	$ git rev-list origin..HEAD
-	$ git rev-list HEAD ^origin
+$ git rev-list origin..HEAD
+$ git rev-list HEAD ^origin
 -----------------------------------------------------------------------
 endif::git-rev-list[]
 ifdef::git-log[]
 -----------------------------------------------------------------------
-	$ git log origin..HEAD
-	$ git log HEAD ^origin
+$ git log origin..HEAD
+$ git log HEAD ^origin
 -----------------------------------------------------------------------
 endif::git-log[]
 
@@ -49,13 +49,13 @@ between the two operands.  The following two commands are equivalent:
 
 ifdef::git-rev-list[]
 -----------------------------------------------------------------------
-	$ git rev-list A B --not $(git merge-base --all A B)
-	$ git rev-list A...B
+$ git rev-list A B --not $(git merge-base --all A B)
+$ git rev-list A...B
 -----------------------------------------------------------------------
 endif::git-rev-list[]
 ifdef::git-log[]
 -----------------------------------------------------------------------
-	$ git log A B --not $(git merge-base --all A B)
-	$ git log A...B
+$ git log A B --not $(git merge-base --all A B)
+$ git log A...B
 -----------------------------------------------------------------------
 endif::git-log[]
-- 
gitgitgadget
