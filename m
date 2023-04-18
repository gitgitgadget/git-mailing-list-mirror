Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F762C77B75
	for <git@archiver.kernel.org>; Tue, 18 Apr 2023 20:41:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232805AbjDRUlW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Apr 2023 16:41:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232764AbjDRUlE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2023 16:41:04 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15B73CC06
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 13:41:02 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-54ee0b73e08so476902277b3.0
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 13:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1681850461; x=1684442461;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Yx+EmS5WT/vkIpWsHvjXnxBRriyE44ZY5B+ZfvWZpSo=;
        b=P7hTM9Xd9ducdpqRT2TP0N1d6lXvvfHxKMEkJc9z7Hs+SDvXevqhLI5q45uBo333N6
         HZRnJ2YrHIzcDyyTR9hqEtXStmXEbPJ8bfkWeATqCBq8ad2rWqVyltYVGfoCvRzqZmba
         BY8Mxzn1nbpUxmafzkRhlF8aphQXfpDScF85WyiLqIXlisUtjr61sf6toD2DxXBq/eZT
         LFRTgnqux8Y7AjbF/myr+kHQdfWmwujbovYnI4/Ch7RsHw0qbw0evcWLyf5fckRmQHnP
         uhW2v6QnsmME6WxIkYveascqlu59iSA6VfoH0J7tCVJ3/3cKalmMxgf0ZQxFdWYJoq7o
         QRlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681850461; x=1684442461;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yx+EmS5WT/vkIpWsHvjXnxBRriyE44ZY5B+ZfvWZpSo=;
        b=NxDHEPklXUfKDCwAhHld+3PlRBB+9kHETQxXqXFqEwxPQg1Xue5Aaz5IoTZc4voqlu
         GbpzMBFqLvdxcGyo5cNBaO+NW4G9QIZFEyg81j7k564Ak4HQ5hzgTXWRGc0amfM4hyIw
         6pH3IN8W8/y6rDqIbIJG0FPKPATCIhatlwwFZo4wNCvvH/MaHVFK5e0LusEX8Q375vag
         vX2OwR3P5hDkkPHMwwIXV2N7CoI34oANelb92rV4NfkUVhebi3XfrRYOHGBnSlb2X0Vd
         ttBFxtAkz2TNCaTtsg10FnUKSWiMJwRaF7mM+zSSQbAbNqUga7cNIwooJuA493aJR6fr
         Zujw==
X-Gm-Message-State: AAQBX9fGMe3HsVvME9EZUBV1FrVvNIi6AXwc1ucp+uwuqL1edbCJrTz7
        2swNIayByFb9cn+p3KxOxy1fYQNDBuu0hb2eeX/8vw==
X-Google-Smtp-Source: AKy350Z1X16fY4STaNXEJiodL/pa4FAGjTctSMoc/9lMblg4KRM0IGDX5kVV3xDhVog2SDVZY8A2Xw==
X-Received: by 2002:a81:4e05:0:b0:54f:64d8:9c9 with SMTP id c5-20020a814e05000000b0054f64d809c9mr36536ywb.21.1681850461487;
        Tue, 18 Apr 2023 13:41:01 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id db15-20020a05690c0dcf00b00545a08184b8sm4042087ywb.72.2023.04.18.13.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 13:41:01 -0700 (PDT)
Date:   Tue, 18 Apr 2023 16:41:00 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 10/10] repository.h: drop unused `gc_cruft_packs`
Message-ID: <c67ee7c2ff9456eda1c5468cf68ddb1b83d37c85.1681850424.git.me@ttaylorr.com>
References: <cover.1681764848.git.me@ttaylorr.com>
 <cover.1681850424.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1681850424.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As of the previous commit, all callers that need to read the value of
`gc.cruftPacks` do so outside without using the `repo_settings` struct,
making its `gc_cruft_packs` unused. Drop it accordingly.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 repo-settings.c | 4 +---
 repository.h    | 1 -
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/repo-settings.c b/repo-settings.c
index 0a6c0b381f..a8d0b98794 100644
--- a/repo-settings.c
+++ b/repo-settings.c
@@ -41,10 +41,8 @@ void prepare_repo_settings(struct repository *r)
 	repo_cfg_bool(r, "feature.experimental", &experimental, 0);
 
 	/* Defaults modified by feature.* */
-	if (experimental) {
+	if (experimental)
 		r->settings.fetch_negotiation_algorithm = FETCH_NEGOTIATION_SKIPPING;
-		r->settings.gc_cruft_packs = 1;
-	}
 	if (manyfiles) {
 		r->settings.index_version = 4;
 		r->settings.index_skip_hash = 1;
diff --git a/repository.h b/repository.h
index 15a8afc5fb..50eb0ce391 100644
--- a/repository.h
+++ b/repository.h
@@ -33,7 +33,6 @@ struct repo_settings {
 	int commit_graph_generation_version;
 	int commit_graph_read_changed_paths;
 	int gc_write_commit_graph;
-	int gc_cruft_packs;
 	int fetch_write_commit_graph;
 	int command_requires_full_index;
 	int sparse_index;
-- 
2.40.0.362.gc67ee7c2ff
