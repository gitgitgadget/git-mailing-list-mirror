Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 71A731F406
	for <e@80x24.org>; Mon, 14 May 2018 21:58:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752631AbeENV6H (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 May 2018 17:58:07 -0400
Received: from mail-vk0-f73.google.com ([209.85.213.73]:37362 "EHLO
        mail-vk0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752190AbeENV6C (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 May 2018 17:58:02 -0400
Received: by mail-vk0-f73.google.com with SMTP id q85-v6so17200474vkb.4
        for <git@vger.kernel.org>; Mon, 14 May 2018 14:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=3plFAmIG3ZxG/H+vqV8zvVId0cjIhF93bK7Qa85zq+Y=;
        b=Wj+piVK/XSTBUZSJgIwFxKQG6mXXUmhPOIcBCgiNwqosncanYWge8cN0l6s2AxJM9K
         LYoa5jVZsP5j19a4GlQzrsTuxq39o4ZbXR7f4hFxKx7tEJHpydxOgCrjYk1woLXzgAwq
         O/g+pnE0fPWg8XagRV/toZq6K7UCtVY1FCnl2YLPA8UKBEPBw2gIFpPb7qxS/jZ6ReKS
         Ad0kid0MKWt9DQWHNaMdqoKSPlpHiaZVyA7rfyMays97eoS26okuKHN5gJlnHX8x7Dkr
         mB9AmxNq33jmWL9QnrAktRLxGRcaeTrjc03y9DBcYxtE/8coDIY6oCeGNRur3MrSvkG3
         9TsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=3plFAmIG3ZxG/H+vqV8zvVId0cjIhF93bK7Qa85zq+Y=;
        b=genewcsBoMdz2r+JT96mCdMI7zr50i+P2RmY0AKnELB5s0nf7dPxEBeh5JOXIgauug
         OnprfnkIPSVY9RH/kHS9bzAdIJrO22k4ESe8MOrJeUP0eZwnAMX9ffhOf05mSQSnfA8J
         0Qf/JKbyN7xM10Sm/PKq1OrV7BPDtvvSJyyPGA1YFdF4mGiB09SY4hfgNC5f30CaywxD
         i4sXFx/IlIQ9Wv59DUSSNlmAthGL0wbjdwzuqxaZyyB2bcuk7T1awoYKF1ze8L88AOd2
         4KMCAGo0RxfwliCqUE6oe5R8SR+9gWZ+uExhd7ULwHE0us+pLBPPbiCiHTAWCnsiomV0
         VaMg==
X-Gm-Message-State: ALKqPwf9KNXZVN+ski4zfnw/xFP/6AxaN+sp/Jp9aFuVL2C+q+3+D+BF
        Y8Mgmko+vP9B/lCnJ8Y+VEem8Atx2XmPYyyihyX1jzpxLDg4eu8vNCFxA/wCgiouObO8afpiH/h
        l5Wi8PK+82uTzkGCLVouczrWDsxAOSjQx+k/fLiRhrkD0fMVIEDDdpaYS2A==
X-Google-Smtp-Source: AB8JxZqaf474N3RKHlCAHC0YpJfPp4u6cCyXeYSS8eKrr1lHaxJNTeyjJiiA+1BHt/VLiWet77IM0+ahSq0=
MIME-Version: 1.0
X-Received: by 2002:a9f:26a4:: with SMTP id 33-v6mr13320328uay.14.1526335081927;
 Mon, 14 May 2018 14:58:01 -0700 (PDT)
Date:   Mon, 14 May 2018 14:56:25 -0700
In-Reply-To: <20180514215626.164960-1-bmwill@google.com>
Message-Id: <20180514215626.164960-35-bmwill@google.com>
References: <20180514215626.164960-1-bmwill@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
Subject: [PATCH 34/35] remote: convert check_push_refs to take a struct refspec
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org, bmwill@google.com
Cc:     Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert 'check_push_refs()' to take a 'struct refspec' as a parameter
instead of an array of 'const char *'.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 remote.c    | 14 +++++---------
 remote.h    |  2 +-
 transport.c |  2 +-
 3 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/remote.c b/remote.c
index 0e882d812..8e6522f4d 100644
--- a/remote.c
+++ b/remote.c
@@ -1264,24 +1264,20 @@ static void prepare_ref_index(struct string_list *ref_index, struct ref *ref)
  * but we can catch some errors early before even talking to the
  * remote side.
  */
-int check_push_refs(struct ref *src, int nr_refspec, const char **refspec_names)
+int check_push_refs(struct ref *src, struct refspec *rs)
 {
-	struct refspec refspec = REFSPEC_INIT_PUSH;
 	int ret = 0;
 	int i;
 
-	refspec_appendn(&refspec, refspec_names, nr_refspec);
-
-	for (i = 0; i < refspec.nr; i++) {
-		struct refspec_item *rs = &refspec.items[i];
+	for (i = 0; i < rs->nr; i++) {
+		struct refspec_item *item = &rs->items[i];
 
-		if (rs->pattern || rs->matching)
+		if (item->pattern || item->matching)
 			continue;
 
-		ret |= match_explicit_lhs(src, rs, NULL, NULL);
+		ret |= match_explicit_lhs(src, item, NULL, NULL);
 	}
 
-	refspec_clear(&refspec);
 	return ret;
 }
 
diff --git a/remote.h b/remote.h
index d5b5f24ac..9014f707f 100644
--- a/remote.h
+++ b/remote.h
@@ -161,7 +161,7 @@ struct ref *ref_remove_duplicates(struct ref *ref_map);
 int query_refspecs(struct refspec *rs, struct refspec_item *query);
 char *apply_refspecs(struct refspec *rs, const char *name);
 
-int check_push_refs(struct ref *src, int nr_refspec, const char **refspec);
+int check_push_refs(struct ref *src, struct refspec *rs);
 int match_push_refs(struct ref *src, struct ref **dst,
 		    struct refspec *rs, int flags);
 void set_ref_status_for_push(struct ref *remote_refs, int send_mirror,
diff --git a/transport.c b/transport.c
index 24a97d9e8..e32bc320c 100644
--- a/transport.c
+++ b/transport.c
@@ -1090,7 +1090,7 @@ int transport_push(struct transport *transport,
 		struct argv_array ref_prefixes = ARGV_ARRAY_INIT;
 		int i;
 
-		if (check_push_refs(local_refs, rs->raw_nr, rs->raw) < 0)
+		if (check_push_refs(local_refs, rs) < 0)
 			return -1;
 
 		for (i = 0; i < rs->nr; i++) {
-- 
2.17.0.441.gb46fe60e1d-goog

