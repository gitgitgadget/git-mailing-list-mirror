Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F2F8E1F406
	for <e@80x24.org>; Mon, 14 May 2018 21:59:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752137AbeENV7k (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 May 2018 17:59:40 -0400
Received: from mail-qk0-f202.google.com ([209.85.220.202]:48972 "EHLO
        mail-qk0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752270AbeENV5G (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 May 2018 17:57:06 -0400
Received: by mail-qk0-f202.google.com with SMTP id y62-v6so16869322qkb.15
        for <git@vger.kernel.org>; Mon, 14 May 2018 14:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=316Lcwfo9mWjCEoJF7bWMISM+WwSxWpHeyuv/a6fyQI=;
        b=vlJukD6TUmmg00WkX8DrYHYOYC7iiHHX5Lcvb/hDGhimaEL/wAEAs8zpOtpw+/lqdx
         QkpkFTGJxV40oIafdKGUv8Kk3CtRKTjp02SLM0E+vgpu4CrjAsQzUfEPZFKk3koVdskt
         kmoXcNG5I+lX+EHu/6eaFuH7qnoQ5YH+vcumHbuU5ODDQ399YxhisHtua7Frhaf3pRqv
         R8h2UoSKSvb0E+j4eCTy7QOLiinev7AaflEIbwPCxeJaGIo6EoGIBYweZcf+hfy2fdcP
         YCSPlnXSbfj/OKhlAW560/J+pvmZhfXWrQTkZm6sNJ2bYNsaRMohbf+l0KEoOe3ZXRwi
         zjXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=316Lcwfo9mWjCEoJF7bWMISM+WwSxWpHeyuv/a6fyQI=;
        b=Q/WeUW5lwLqGByLJLooa6KACNeR1H1worrQ1L2VJ1jiOnLeR5EJ5BWKhA3QhJY21Ph
         /t5r5YJPwqTaETLp+LzIKG/GLdzSH2Xif7s04KHULQAFgVIPL6EfQ/cjDmg2DMCAzu2l
         xj2HyLesGgpihsEbS02Ou9nrL84eUCPPt/S+5wVDoJep6GctZAkn18H2sCK/wbfOQddi
         MGuA1AGAlwgQvKfa5zhIYHeSoNHOmNs4RtX03MXXjIS6uB4hdlJQESXrpWGh8H2B7EJc
         +KxkeXDTimgNTvlkpGFD9wAurLmh3OOUkyPABPniVfh2fWftuXGZmbHUcgynEAlt+Urw
         kquA==
X-Gm-Message-State: ALKqPwemPOYTm9pKRLs6j2UNPft8hLoVP4wTmBU6XF2rkwMq4PVh/y8Q
        vOjaGT79VRLH6ZU3ILfCrR27ln/z+ygD15us+nBiE9eh8ZPkYpZSZt3QvWWn8g1GRvme1kanyYS
        I4eKaGdDlGp9j1q6Dfm1s40rCWtttyeJdSkTqvGfuGNC2V4cVJMja5o1BFA==
X-Google-Smtp-Source: AB8JxZo6PH1uJTaZ9K7ZKEpINrnyWz+i78VxNbsul2sFyXqBNf3WhIjZdEOlwD7zkLQOI/sVobvFLpn4nqs=
MIME-Version: 1.0
X-Received: by 2002:a37:de12:: with SMTP id h18-v6mr4294026qkj.6.1526335024761;
 Mon, 14 May 2018 14:57:04 -0700 (PDT)
Date:   Mon, 14 May 2018 14:56:02 -0700
In-Reply-To: <20180514215626.164960-1-bmwill@google.com>
Message-Id: <20180514215626.164960-12-bmwill@google.com>
References: <20180514215626.164960-1-bmwill@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
Subject: [PATCH 11/35] clone: convert cmd_clone to use refspec_item_init
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org, bmwill@google.com
Cc:     Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert 'cmd_clone()' to use 'refspec_item_init()' instead of relying on
the old 'parse_fetch_refspec()' to initialize a single refspec item.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/clone.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 854088a3a..8c5f4d8f0 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -895,8 +895,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	int err = 0, complete_refs_before_fetch = 1;
 	int submodule_progress;
 
-	struct refspec_item *refspec;
-	const char *fetch_pattern;
+	struct refspec_item refspec;
 
 	fetch_if_missing = 0;
 
@@ -1078,8 +1077,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	if (option_required_reference.nr || option_optional_reference.nr)
 		setup_reference();
 
-	fetch_pattern = value.buf;
-	refspec = parse_fetch_refspec(1, &fetch_pattern);
+	refspec_item_init(&refspec, value.buf, REFSPEC_FETCH);
 
 	strbuf_reset(&value);
 
@@ -1139,7 +1137,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	refs = transport_get_remote_refs(transport, NULL);
 
 	if (refs) {
-		mapped_refs = wanted_peer_refs(refs, refspec);
+		mapped_refs = wanted_peer_refs(refs, &refspec);
 		/*
 		 * transport_get_remote_refs() may return refs with null sha-1
 		 * in mapped_refs (see struct transport->get_refs_list
@@ -1233,6 +1231,6 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	strbuf_release(&value);
 	junk_mode = JUNK_LEAVE_ALL;
 
-	free(refspec);
+	refspec_item_clear(&refspec);
 	return err;
 }
-- 
2.17.0.441.gb46fe60e1d-goog

