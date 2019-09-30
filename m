Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B9B81F463
	for <e@80x24.org>; Mon, 30 Sep 2019 21:10:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732645AbfI3VKd (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Sep 2019 17:10:33 -0400
Received: from mail-pf1-f175.google.com ([209.85.210.175]:33838 "EHLO
        mail-pf1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732641AbfI3VKd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Sep 2019 17:10:33 -0400
Received: by mail-pf1-f175.google.com with SMTP id b128so6312108pfa.1
        for <git@vger.kernel.org>; Mon, 30 Sep 2019 14:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pNW/5d03kX6rzb1J40jixnTNQ6JLAXVHeI36wT/1qwg=;
        b=cDNWNt3p6S9nu8MKCi6b/iFJA2GVAJgApBFwjUyDy1biZwWKFcyVlF0MdSoU85DSM9
         fWNwAAPaOdEeIv/bEmIn/CnDYen8Dsn4HIHWzxKlJoVPFrtzJUNCv14JNoZtLVvuxaN6
         5NkBWHFI2T3mHqqUXQVIT8IDK3PL0rpLDluYn38T/+4gSa+srzz39CszMNttPbfWBspB
         DlnAPvUenqcvgPQ69xzrQ1J2iiJxghv7LCnsmestjsh736tTEndgfE1rgnyBgQr1Arlx
         F/C5Bj2ixbqDX7+RShbjcDkoS7rbtNUlbXG43+ahpfdFOSg5nA/TxtxK9xg0iD2T//w5
         xXHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pNW/5d03kX6rzb1J40jixnTNQ6JLAXVHeI36wT/1qwg=;
        b=QIhy70TAfNSHdsC7bPZDA+lY250Cdz29fT+LL6Buq7nwpa1bVsglQ9Zixc85wKfABU
         yHj6GCAL64YLYPuI3xImsS4+HIisU3R8u37JO8f+tCpZkyuI9z+lc3EZ51s1+jboOhXC
         +0aGycBY1zPFNpXhcSFiVLYsHnLnGE1yjodjUsHItiW/JbJVWvic9ifhw6UZacCkYwOO
         vS4c0VUuQjO+l8pWIk41iv1hd097Fq02WealalLRO83/f45ES9MNYqDjtVHQ1QKeQptd
         5+CWle7hNr/22QRio2ZIzVQ2BeDEJcZCxRzQClqiGNZNnnFmUylJ2h3axNa/CmlEECLp
         GyAg==
X-Gm-Message-State: APjAAAVyWGFgxV+rR17GdXUytOIKJYVXFQ9iwA8hQaJduqgvmsUxn6QN
        OsP/T6oadGzARkajsvB2Dnk11tf+m3k=
X-Google-Smtp-Source: APXvYqzMqg6HE9rB7xD2pCjUI1VRxtNO0ZlkG7qqtps1FDZoFP6ijjJ38WsLvmvCTCD1nIxHBaNomA==
X-Received: by 2002:a63:cd04:: with SMTP id i4mr26263851pgg.21.1569877831639;
        Mon, 30 Sep 2019 14:10:31 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id w11sm13404609pfd.116.2019.09.30.14.10.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 30 Sep 2019 14:10:30 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 8/8] fast-export: handle nested tags
Date:   Mon, 30 Sep 2019 14:10:18 -0700
Message-Id: <20190930211018.23633-9-newren@gmail.com>
X-Mailer: git-send-email 2.23.0.264.gac739dbb79
In-Reply-To: <20190930211018.23633-1-newren@gmail.com>
References: <20190925014005.17056-1-newren@gmail.com>
 <20190930211018.23633-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/fast-export.c  | 30 ++++++++++++++++++------------
 t/t9350-fast-export.sh |  2 +-
 2 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index d32e1e9327..58a74de42a 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -843,22 +843,28 @@ static void handle_tag(const char *name, struct tag *tag)
 			free(buf);
 			return;
 		case REWRITE:
-			if (tagged->type != OBJ_COMMIT) {
-				die("tag %s tags unexported %s!",
-				    oid_to_hex(&tag->object.oid),
-				    type_name(tagged->type));
-			}
-			p = rewrite_commit((struct commit *)tagged);
-			if (!p) {
-				printf("reset %s\nfrom %s\n\n",
-				       name, oid_to_hex(&null_oid));
-				free(buf);
-				return;
+			if (tagged->type == OBJ_TAG && !mark_tags) {
+				die(_("Error: Cannot export nested tags unless --mark-tags is specified."));
+			} else if (tagged->type == OBJ_COMMIT) {
+				p = rewrite_commit((struct commit *)tagged);
+				if (!p) {
+					printf("reset %s\nfrom %s\n\n",
+					       name, oid_to_hex(&null_oid));
+					free(buf);
+					return;
+				}
+				tagged_mark = get_object_mark(&p->object);
+			} else {
+				/* tagged->type is either OBJ_BLOB or OBJ_TAG */
+				tagged_mark = get_object_mark(tagged);
 			}
-			tagged_mark = get_object_mark(&p->object);
 		}
 	}
 
+	if (tagged->type == OBJ_TAG) {
+		printf("reset %s\nfrom %s\n\n",
+		       name, oid_to_hex(&null_oid));
+	}
 	if (starts_with(name, "refs/tags/"))
 		name += 10;
 	printf("tag %s\n", name);
diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
index 9ab281e4b9..2e4e214815 100755
--- a/t/t9350-fast-export.sh
+++ b/t/t9350-fast-export.sh
@@ -567,7 +567,7 @@ test_expect_success 'handling tags of blobs' '
 	test_cmp expect actual
 '
 
-test_expect_failure 'handling nested tags' '
+test_expect_success 'handling nested tags' '
 	git tag -a -m "This is a nested tag" nested muss &&
 	git fast-export --mark-tags nested >output &&
 	grep "^from $ZERO_OID$" output &&
-- 
2.23.0.264.gac739dbb79

