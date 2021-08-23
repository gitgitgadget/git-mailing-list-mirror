Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50BB7C4338F
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 11:03:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38A6E61372
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 11:03:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236324AbhHWLDx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Aug 2021 07:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236171AbhHWLDt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Aug 2021 07:03:49 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53205C06175F
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 04:03:07 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id q11so25691584wrr.9
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 04:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9uUl4UCbcqDqx66g85e0DLtAVeZKwa6+6MpnhEQtnRc=;
        b=mpHzQjCAQ5qUy1ydZ6ocXG+rJDMNNtgKDgsImho41NAKupOwf5s41BaEOVkq7IEpEK
         yHm1l9tpUuX3OnckT3JJYjUqH4c2q8efycLFUCQ+E676Yi/fBraUk5QaZ9aOM97F2tJ5
         vhBdqMwtjpuPjoihuUcIVGk9cdqi184Mz7/qLdQQ+gVdxoo/cLJPmVny/OlumbdkNq4A
         NKFaMpa/TIgp2K3RJC197+cI8DkBkW00dJ/yrqVBVhxopBsH4NLOo4klT8CLf2T5E/ci
         0Mi2MKPAlWv9fCzlFdF1TE1hxNh6cDT3Lemx46IEVpsbQU3UzXol5+ozK4UyDp9PgVyJ
         cyMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9uUl4UCbcqDqx66g85e0DLtAVeZKwa6+6MpnhEQtnRc=;
        b=iLaRg7K4dFK073TLdlpRhtbTKFK/oCsRIM++sRFwhkPpnRlZ++Ub8HKke7Op/uJXky
         1piQXodB1aySG1ctJAc68qnQBxK2/NK7w4uP6PG/Xs5UqAdqYCsXM8AeZR3DtLr+JYyZ
         rrwFw4V7URkJFJk8tmkpDi9dPcwZEpfQsC0bWcX9v63MFAplQn35zhM/lEFKU1IVZ9ZQ
         dE7MgnJP9JJou6g4OgyoQnYgpW9deSJ8QImUajEUBWNx0fasANtmLJ+KIuDVEp5yaefj
         bpoZdyOSpQHCrUmhElZVfvlFjljEoaNJMf9fuko6IMGRteko7uiXhnR7BupvHOoRCUPB
         yDoA==
X-Gm-Message-State: AOAM533cJ6vl5UnfbGIa79NxsrO5E760y5NC5q19GtLlNFsNv+gi7+Hd
        T95fmua+oPT0g02466YmVovbvGtYYUiMvXMR
X-Google-Smtp-Source: ABdhPJyG4E5X0qSGPvaG3utorvicqyyGiNtyF71QuaI5fz8KO10c4R2yjY9UJY0nOi6AgGO48sMHtw==
X-Received: by 2002:a5d:6085:: with SMTP id w5mr4231620wrt.104.1629716585742;
        Mon, 23 Aug 2021 04:03:05 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l19sm13255493wmi.4.2021.08.23.04.03.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 04:03:05 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 1/4] bundle API: start writing API documentation
Date:   Mon, 23 Aug 2021 13:02:56 +0200
Message-Id: <patch-v2-1.4-dc8591f6d0b-20210823T110136Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.662.g438caf9576d
In-Reply-To: <cover-v2-0.4-00000000000-20210823T110136Z-avarab@gmail.com>
References: <cover-0.4-0000000000-20210727T004015Z-avarab@gmail.com> <cover-v2-0.4-00000000000-20210823T110136Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are no other API docs in bundle.h, but this is at least a
start. We'll add a parameter to this function in a subsequent commit,
but let's start by documenting it.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 bundle.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/bundle.h b/bundle.h
index 1927d8cd6a4..84a6df1b65d 100644
--- a/bundle.h
+++ b/bundle.h
@@ -27,6 +27,13 @@ int create_bundle(struct repository *r, const char *path,
 		  int version);
 int verify_bundle(struct repository *r, struct bundle_header *header, int verbose);
 #define BUNDLE_VERBOSE 1
+
+/**
+ * Unbundle after reading the header with read_bundle_header().
+ *
+ * We'll invoke "git index-pack --stdin --fix-thin" for you on the
+ * provided `bundle_fd` from read_bundle_header().
+ */
 int unbundle(struct repository *r, struct bundle_header *header,
 	     int bundle_fd, int flags);
 int list_bundle_refs(struct bundle_header *header,
-- 
2.33.0.662.g438caf9576d

