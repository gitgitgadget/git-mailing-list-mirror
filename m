Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9418D1F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:06:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752285AbeBFAGn (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:06:43 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:39163 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752265AbeBFAGe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:06:34 -0500
Received: by mail-pl0-f68.google.com with SMTP id o13so101179pli.6
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:06:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SnmJcw2IO1yUrOasEFPLU7Zp5hobSRMsZGv+RuMReww=;
        b=nzJ+8u1Bpk9icr8tQPAVQnaE8NPye2Qmd66IbsGQoOmX++in3ou+qkfL3RKD8A0RDC
         t0YkZJI2PtXdpvVAjDZt99EODjQJ58Jfgag+sLVWWb5W6HnCtJr9wWO/O4MRuPLgIyM9
         3AyahpQumY5Zs9aJEs7qjBHMCLz0xCdr2aX1OdfZP46DeFEuGkpTJaTdQ7TGRPM59Ua8
         wHGmrsbcqUsh0IVUoTEFQk/km5+8nVJgqHf9cB4SJ5WBQjKqIFIzR7KHN7YjTmoXOwz6
         prbybSaxFXWCwfy+pttQ0yqmhCoih/k+F9K5NFLy/lZiUITtaqlu0nrFMDe1WCdV7MDJ
         rMLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SnmJcw2IO1yUrOasEFPLU7Zp5hobSRMsZGv+RuMReww=;
        b=AN9Vpo/xSbhHurUq42CkOdVzXhxSn41PH+onIQ5Ovpe/helVDaKoJxue5C/uIqKTsf
         CWWasWWOpVMPlHnaFJiMarnvCuWPLVAO7IwXhhEyavfXEC1LLCqUIeCBIFNvgtRAyA6H
         nq9KgB0QzeWcCKneehCPNpRqW0NWHe3D0SMX+zvHiSzrrfkfSFoRrJJhGwaZiUwiiL69
         Mjcj/mS2Gx6/YS4lsM2qasEy5u3wK/nW6FKASfbrZvw81+rGIPde66fH98Dq5ZZ3Zgoy
         i87FDy+trzyTzcx2qn3nAViGiwAWkTaRIO/dCHDYx8uVLYsXZieoh5CZ0TGkLkgKcKlF
         +NeA==
X-Gm-Message-State: APf1xPCOkRSnKz9KMjQSJelBmcjxxXuJhuwIUHB3OTzIs28aYchU9zXO
        SiETwEDT9IRhJTlb2kXfrXDChqLnoOQ=
X-Google-Smtp-Source: AH8x226CqJ728H61ZRtTrMvUTE1AJHDVYeh4M1ABUB2cvMXRASJBWcWhSF5PlDRD8yBCydRf3JS64A==
X-Received: by 2002:a17:902:6544:: with SMTP id d4-v6mr494906pln.117.1517875593907;
        Mon, 05 Feb 2018 16:06:33 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id d205sm18560376pfd.165.2018.02.05.16.06.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:06:33 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 060/194] refs: allow for_each_replace_ref to handle arbitrary repositories
Date:   Mon,  5 Feb 2018 15:55:21 -0800
Message-Id: <20180205235735.216710-40-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180205235735.216710-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180205235735.216710-1-sbeller@google.com>
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
index f079d65030..e534ff4256 100644
--- a/refs.c
+++ b/refs.c
@@ -1416,9 +1416,9 @@ int refs_for_each_fullref_in(struct ref_store *refs, const char *prefix,
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
2.15.1.433.g936d1b9894.dirty

