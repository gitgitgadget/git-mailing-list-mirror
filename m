Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BBC611F42D
	for <e@80x24.org>; Thu, 12 Apr 2018 00:21:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752662AbeDLAVp (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Apr 2018 20:21:45 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:46183 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752535AbeDLAVm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Apr 2018 20:21:42 -0400
Received: by mail-pf0-f195.google.com with SMTP id h69so2071261pfe.13
        for <git@vger.kernel.org>; Wed, 11 Apr 2018 17:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Y0LVmdeLyc8U69mSIOp9Di/8fMZ0DtBTg8TYtmA7Kac=;
        b=bWqVFmo9gy8rFwguNCaa/SfrFwJ3yXeNvk0Tb+hLoRzfAqRWlsqAL9CMaOtzUNl5Td
         fuxTuZc1lY52jD8xzJTmxQvQRKwirU+iKTy7NuOfr2ZwnJVB2aWH+9icUxXJ0KtyKdUg
         1YfLmGcSEM9vP8LWAhq7Efykt2zAHHXainVMFn0AHeHRoh47OE8SXc4Z4pai6bAvt2qh
         G+cdvpqQXLfsukWYGgVhdyyMeoPMPh9RbyuZofK+Gk6lWFW+NWGA6aI3ec/DRg4iJuAB
         IaWoCzuU620xoB2D38iglj9QfGomidmPEECdcJjHTl6bs434gOA6jI3sJNoJ9Gz0KqqD
         dUvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Y0LVmdeLyc8U69mSIOp9Di/8fMZ0DtBTg8TYtmA7Kac=;
        b=YXYYyXQ94BwTrhhdtQU3yYXx2OL8kqnvhuPZ9q2YXDDlDUyaZxb+Ps3UhElKxtOhl9
         5BrPxKTgUvpB/2zCTFhdBEnobyyjvBTgGarau/h3t867yL45ZgoColmGtQ3Adah8ffcu
         l2oNpYTQq99D+EuW4OrYAUiB8rZK6ZqOviX7HStaBK8C4XKUyh+easmaHKorK11PIklV
         ZtYHT0s9OriEtFcbc3JLIhld65J7wGrLxbR/oUcJRMHG64v26mtKFS3HOtWPG903Y2H/
         08oURwUJXtUtdR2HEN97yj2XNJTSmid4HH/N0zNG1/qE5yK77LWvmxlUs9F1e5K/PG/7
         m3fQ==
X-Gm-Message-State: ALQs6tAMNxACPB1II50cwHlgcXj1nHvfDsjshuV0iZm8SW3Ag7miv+Ec
        D5P9RhdXHBnkr1A59+dVcaYAyw==
X-Google-Smtp-Source: AIpwx4/3W1nedn5Yi+ind4Z7tzbAVQNS1P7cTvvOtES9Ers88c1ksZMESRBmDc7CE0zb0N+uKFCZ5g==
X-Received: by 10.99.54.65 with SMTP id d62mr4947317pga.225.1523492501588;
        Wed, 11 Apr 2018 17:21:41 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id x27sm6071300pfa.134.2018.04.11.17.21.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Apr 2018 17:21:40 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, jonathantanmy@google.com, l.s.r@web.de,
        pclouds@gmail.com, sandals@crustytoothpaste.net,
        sunshine@sunshineco.com
Subject: [PATCH 12/15] refs: allow for_each_replace_ref to handle arbitrary repositories
Date:   Wed, 11 Apr 2018 17:21:15 -0700
Message-Id: <20180412002118.102976-13-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.484.g0c8726318c-goog
In-Reply-To: <20180412002118.102976-1-sbeller@google.com>
References: <20180409224533.17764-1-sbeller@google.com>
 <20180412002118.102976-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 refs.c | 4 ++--
 refs.h | 4 +---
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/refs.c b/refs.c
index 36df1bc73a..9b56fa9b81 100644
--- a/refs.c
+++ b/refs.c
@@ -1415,9 +1415,9 @@ int refs_for_each_fullref_in(struct ref_store *refs, const char *prefix,
 	return do_for_each_ref(refs, prefix, fn, 0, flag, cb_data);
 }
 
-int for_each_replace_ref_the_repository(each_ref_fn fn, void *cb_data)
+int for_each_replace_ref(struct repository *r, each_ref_fn fn, void *cb_data)
 {
-	return do_for_each_ref(get_main_ref_store(the_repository),
+	return do_for_each_ref(get_main_ref_store(r),
 			       git_replace_ref_base, fn,
 			       strlen(git_replace_ref_base),
 			       DO_FOR_EACH_INCLUDE_BROKEN, cb_data);
diff --git a/refs.h b/refs.h
index f5ab68c0ed..15f3a91cc4 100644
--- a/refs.h
+++ b/refs.h
@@ -300,9 +300,7 @@ int for_each_fullref_in(const char *prefix, each_ref_fn fn, void *cb_data,
 int for_each_tag_ref(each_ref_fn fn, void *cb_data);
 int for_each_branch_ref(each_ref_fn fn, void *cb_data);
 int for_each_remote_ref(each_ref_fn fn, void *cb_data);
-#define for_each_replace_ref(r, fn, cb) \
-	for_each_replace_ref_##r(fn, cb)
-int for_each_replace_ref_the_repository(each_ref_fn fn, void *cb_data);
+int for_each_replace_ref(struct repository *r, each_ref_fn fn, void *cb_data);
 int for_each_glob_ref(each_ref_fn fn, const char *pattern, void *cb_data);
 int for_each_glob_ref_in(each_ref_fn fn, const char *pattern,
 			 const char *prefix, void *cb_data);
-- 
2.17.0.484.g0c8726318c-goog

