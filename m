Return-Path: <SRS0=75zt=3F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCEEDC32771
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 02:40:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B68B522522
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 02:40:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="fBOkuqWS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729727AbgAPCkk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jan 2020 21:40:40 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:41452 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729662AbgAPCkk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jan 2020 21:40:40 -0500
Received: by mail-qv1-f65.google.com with SMTP id x1so8422200qvr.8
        for <git@vger.kernel.org>; Wed, 15 Jan 2020 18:40:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+GlZ7FFCEwf0sdYljc0DF3MuiCMrB5W3NgUVRH2fkzg=;
        b=fBOkuqWS/tldWqAVehtyS3b7fB+xlxeYFuzamBdGroM2oZ+EJrwJLJAwOMJOAlBVSJ
         EHPIhagjjswdODbTISWd0ctFlYNz+BjyLLUMUHW/PBE4cDTIM2Zygf0IFFDeRpFHGo5R
         UF3FFANL9yHe1coOVmQ0uA9jE0knKdSD+9hmRJBbaMO+EBO7p/Aiyml464j4Nr/qDGQP
         r+dqtlUsNke7yksu5LZ7aCFaaiMvwXGbGl4WL0KcSy15xrfLEebMyJtDrlihv/fd46DL
         1nBFuyG+LnSAh2t3sSQByDcYvAc0XofJHEMehxnSFM1Se0TGlTXC7nQWSxtnh2HCBCdZ
         AYag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+GlZ7FFCEwf0sdYljc0DF3MuiCMrB5W3NgUVRH2fkzg=;
        b=QedYV8if+ewm9KMkao/PTzB5hHdxDWeiOASlGx4q9LluGSy8EeJkkdbw3oDVXyG7oA
         JKMDyx16MqftrkiNapJwCq2mxBdEKrDxfYZIjgh+lTfTbY1/Qqu/YjP5jTgck1G/FHZM
         3FICLXr7Un1mCkKarkBTvHK7Z/rynV4RScLlaoz+RTghicPIaDT1R1dDZBtbhHbMKFFp
         gQK4OSx8xM3CeAr+wR0025kCtPqxy2bKBA0sTugDUbImbSF98Zyx3KMjQsuJs0Pn1rIm
         vAZQ6Ot5jjOZOZFSDhvfSkWwVH1kaIMU+JELYa+nMXuCgbsG+ff3CWgn35Ia5a0cJizI
         MwvQ==
X-Gm-Message-State: APjAAAXXpMcSLVAnCawOcSnB4h53lUcgthtzrptF+NB1RxxdfpQr9vGN
        p7sIux0DMqIxrnklr/kqlPnx/byCg4Y=
X-Google-Smtp-Source: APXvYqx6G/Qoo9KJfM/bgQMjndXckENBpWHQNv/vGt57aWp0fRB9ot1CXqLZdV6TbknUJ4wyYRx5WQ==
X-Received: by 2002:ad4:4182:: with SMTP id e2mr453918qvp.187.1579142439277;
        Wed, 15 Jan 2020 18:40:39 -0800 (PST)
Received: from mango.spo.virtua.com.br ([2804:14c:81:942d::1])
        by smtp.gmail.com with ESMTPSA id u24sm9381289qkm.40.2020.01.15.18.40.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 18:40:38 -0800 (PST)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, gitster@pobox.com, jrnieder@gmail.com,
        olyatelezhnaya@gmail.com, pclouds@gmail.com,
        jonathantanmy@google.com, peff@peff.net,
        Brandon Williams <bwilliams.eng@gmail.com>,
        Antonio Ospite <ao2@ao2.it>,
        Stefan Beller <stefanbeller@gmail.com>
Subject: [PATCH v3 02/12] grep: fix race conditions at grep_submodule()
Date:   Wed, 15 Jan 2020 23:39:50 -0300
Message-Id: <6f0899701b88e255bae68e16e11a978488c0b1cd.1579141989.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1579141989.git.matheus.bernardino@usp.br>
References: <cover.1579141989.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There're currently two function calls in builtin/grep.c:grep_submodule()
which might result in race conditions:

- submodule_from_path(): it has config_with_options() in its call stack
  which, in turn, may have read_object_file() in its own. Therefore,
  calling the first function without acquiring grep_read_mutex may end
  up causing a race condition with other object read operations
  performed by worker threads (for example, at the fill_textconv()
  call in grep.c:fill_textconv_grep()).
- parse_object_or_die(): it falls into the same problem, having
  repo_has_object_file(the_repository, ...) in its call stack. Besides
  that, parse_object(), which is also called by parse_object_or_die(),
  is thread-unsafe and also called by object reading functions.

It's unlikely to really fall into a data race with these operations as
the volume of calls to them is usually very low. But we better protect
ourselves against this possibility, anyway. So, to solve these issues,
move both of these function calls into the critical section of
grep_read_mutex.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 builtin/grep.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 50ce8d9461..896e7effce 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -407,8 +407,7 @@ static int grep_submodule(struct grep_opt *opt,
 {
 	struct repository subrepo;
 	struct repository *superproject = opt->repo;
-	const struct submodule *sub = submodule_from_path(superproject,
-							  &null_oid, path);
+	const struct submodule *sub;
 	struct grep_opt subopt;
 	int hit;
 
@@ -419,6 +418,7 @@ static int grep_submodule(struct grep_opt *opt,
 	 * object.
 	 */
 	grep_read_lock();
+	sub = submodule_from_path(superproject, &null_oid, path);
 
 	if (!is_submodule_active(superproject, path)) {
 		grep_read_unlock();
@@ -455,9 +455,8 @@ static int grep_submodule(struct grep_opt *opt,
 		unsigned long size;
 		struct strbuf base = STRBUF_INIT;
 
-		object = parse_object_or_die(oid, oid_to_hex(oid));
-
 		grep_read_lock();
+		object = parse_object_or_die(oid, oid_to_hex(oid));
 		data = read_object_with_reference(&subrepo,
 						  &object->oid, tree_type,
 						  &size, NULL);
-- 
2.24.1

