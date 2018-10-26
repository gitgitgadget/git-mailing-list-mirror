Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC7291F454
	for <e@80x24.org>; Fri, 26 Oct 2018 23:07:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728345AbeJ0Hqy (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Oct 2018 03:46:54 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50887 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727792AbeJ0Hqy (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Oct 2018 03:46:54 -0400
Received: by mail-wm1-f67.google.com with SMTP id i8-v6so2872679wmg.0
        for <git@vger.kernel.org>; Fri, 26 Oct 2018 16:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m8uKsA8NO0fr26TkXK5TqU2QYhmOKbVQmuurpcJ16X0=;
        b=dx6mFKyRNHFJVNYS4LN8QA8Z7XV99Bov2A1F/Se/P50BlTDMXxg1wAGSOFgxJ7OT2+
         9/gasnVl+sYotngtOMwZj9lIhz1nuTF2p9sw/ilAD4n8ApzPfpFhIZYVeVOXKvlSmK26
         NJCEX9vrnYg97EvCDvPSqUrxCTc4P7mHptzDWSdDv2oCbmkwqopJ9/eYCu2rybqafrAJ
         rXBK2yb4kkql537Lj0IZfGLXOzZ4A4GbQ+gEnYDMC2nd0DSJh0FoC+3blpJdyHS1WzHT
         X+eGRpIRAQ8jFgax/QYyFPNhmZ9OVpg5bOCluW2O6S74ictAgVaYk8q7B/+tsoH01/Nj
         mtDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m8uKsA8NO0fr26TkXK5TqU2QYhmOKbVQmuurpcJ16X0=;
        b=Dz0SVM2B+LNkq7vsiMZ7uYSZqgn3gzIh3isZKP0KsWSmOQPcvfp+ZO0fsp6iCKm6KI
         agjUqbnP1VxXxZCV6viPEqA7xSQzFJ0HS6fGBCXp/PaL34yy0/CzoHO28GhidTfBK8GC
         00vOs9Bi8uPa656A4Cv2WTn6misKM9xGGr9fATByffGoXUzbG71ejcGcw4arGRyqagjf
         aZyS2BvBiEjXRiIM/XqL18JryN8g8Ara0wEPSB9/fwxw6SP9ies++TYjxo+Jz6spu2qY
         S30WAyQ5oFis/EVNeVbBfrbmSimM4OkoiegHuJPwmnbSNHrNAVox0anu15wO5TUvalui
         MAGA==
X-Gm-Message-State: AGRZ1gJlMA3OjwiLzfp9NTPjr1uOXaTQV2/M1aFVUs43mZatAikko2E+
        JtodlnWUqk0pXkygN3+oy2dhf3R9enE=
X-Google-Smtp-Source: AJdET5eNPbOhzERXAeycXqB9d/53RFfuupaFV4JuiWSS6Hd6ZeCXZrh/BuyDyvE+ZGYWZWst3A1Z/A==
X-Received: by 2002:a1c:f312:: with SMTP id q18-v6mr6787914wmq.14.1540595275798;
        Fri, 26 Oct 2018 16:07:55 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id 4-v6sm5632830wmt.16.2018.10.26.16.07.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 16:07:55 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 4/8] push: move unqualified refname error into a function
Date:   Fri, 26 Oct 2018 23:07:37 +0000
Message-Id: <20181026230741.23321-5-avarab@gmail.com>
X-Mailer: git-send-email 2.19.1.759.g500967bb5e
In-Reply-To: <20181026192734.9609-1-avarab@gmail.com>
References: <20181026192734.9609-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A follow-up change will extend this error message with the advice
facility. Doing so would make the indentation too deeply nested for
comfort. So let's split this into a helper function.

There's no changes to the wording here. Just code moving &
re-indentation, and re-flowing the "TRANSLATORS" comment.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 remote.c | 38 ++++++++++++++++++++++----------------
 1 file changed, 22 insertions(+), 16 deletions(-)

diff --git a/remote.c b/remote.c
index f4b438ff74..c7a0b9c46f 100644
--- a/remote.c
+++ b/remote.c
@@ -1005,6 +1005,26 @@ static int match_explicit_lhs(struct ref *src,
 	}
 }
 
+static void show_push_unqualified_ref_name_error(const char *dst_value,
+						 const char *matched_src_name)
+{
+	/*
+	 * TRANSLATORS: "matches '%s'%" is the <dst> part of "git push
+	 * <remote> <src>:<dst>" push, and "being pushed ('%s')" is
+	 * the <src>.
+	 */
+	error(_("The destination you provided is not a full refname (i.e.,\n"
+		"starting with \"refs/\"). We tried to guess what you meant by:\n"
+		"\n"
+		"- Looking for a ref that matches '%s' on the remote side.\n"
+		"- Checking if the <src> being pushed ('%s')\n"
+		"  is a ref in \"refs/{heads,tags}/\". If so we add a corresponding\n"
+		"  refs/{heads,tags}/ prefix on the remote side.\n"
+		"\n"
+		"Neither worked, so we gave up. You must fully-qualify the ref."),
+	      dst_value, matched_src_name);
+}
+
 static int match_explicit(struct ref *src, struct ref *dst,
 			  struct ref ***dst_tail,
 			  struct refspec_item *rs)
@@ -1049,22 +1069,8 @@ static int match_explicit(struct ref *src, struct ref *dst,
 			matched_dst = make_linked_ref(dst_guess, dst_tail);
 			free(dst_guess);
 		} else {
-			/*
-			 * TRANSLATORS: "matches '%s'%" is the <dst>
-			 * part of "git push <remote> <src>:<dst>"
-			 * push, and "being pushed ('%s')" is the
-			 * <src>.
-			 */
-			error(_("The destination you provided is not a full refname (i.e.,\n"
-				"starting with \"refs/\"). We tried to guess what you meant by:\n"
-				"\n"
-				"- Looking for a ref that matches '%s' on the remote side.\n"
-				"- Checking if the <src> being pushed ('%s')\n"
-				"  is a ref in \"refs/{heads,tags}/\". If so we add a corresponding\n"
-				"  refs/{heads,tags}/ prefix on the remote side.\n"
-				"\n"
-				"Neither worked, so we gave up. You must fully-qualify the ref."),
-			      dst_value, matched_src->name);
+			show_push_unqualified_ref_name_error(dst_value,
+							     matched_src->name);
 		}
 		break;
 	default:
-- 
2.19.1.759.g500967bb5e

