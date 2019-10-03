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
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E61B1F4BD
	for <e@80x24.org>; Thu,  3 Oct 2019 20:27:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388708AbfJCU11 (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Oct 2019 16:27:27 -0400
Received: from mail-pl1-f179.google.com ([209.85.214.179]:40434 "EHLO
        mail-pl1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbfJCU10 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Oct 2019 16:27:26 -0400
Received: by mail-pl1-f179.google.com with SMTP id d22so2033136pll.7
        for <git@vger.kernel.org>; Thu, 03 Oct 2019 13:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cFEKpUTHMK4jEjdfb9vYUj3CqxWL60eZhQIW6bagyNY=;
        b=TcHsGuVJ760p1qzMHLtdON0dgZ9sCofeD4+oppV9hPn2/eZ6inqSOoIcALK4kKdY3i
         po04m7ukOMvzYaAy5SC50Brt5CKnOvlUp6+cLRSAuXtd/VKclssPSSZCCa4XoJGPKp++
         1XZK8MQis49X51N/vbySQp6A5JqgOiV0tKO+rFsudHNZTNx1LS/jTtnrKBhGCcmg9QmQ
         lSxf8lfwsO558xR+fXpK1zDF/aE7Kcz0pu+K7I27rFIHVXwXZnhbWv8rI18dkGGcMmBZ
         DmWVxfF3JnKbHj0H3/+pfUxM/lB7r8+BcaLf3kWh1FlVnN1e3BpiYiWL7ataoa0K8bD1
         ScGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cFEKpUTHMK4jEjdfb9vYUj3CqxWL60eZhQIW6bagyNY=;
        b=tORlHiJusIlZumOC7p3UwjAA6Y+jNyc486048xsnJ7ilocke/8YQuF94M3ys+lgxBj
         EcvYq/IXOtgGCpVT0Q57tNha5ADNrCTAFERuhe7isxfJscA1wocICMlyJ1ADxLFnljQK
         7+/1JY9ulJ4IfQspDR61WoL5tKr9D7II/bykBqcYDTqXbcrtc4ucmnZ3uT8TpsNW9kUv
         MM5t/Gnu8R4iPcFStXq0hcGiv2qeMcRHyqS1YMHXnuo0reOHLYfUhjD8vmAUgL0wZFnF
         E4pvfP/DfY/IdwLdtY6vSbgrB3YJ0ir4lj33m+o4Kyej/k6DNSCAQpmym2pe7LtLhthB
         fzyg==
X-Gm-Message-State: APjAAAWxwoZgQDjVDy7L+A/ovfknEOEOIRrMHtdbniUWvVnxTHKgkrNn
        t34eYEbgh8+r+BUsLCMsD2I=
X-Google-Smtp-Source: APXvYqz/S0T/i3Qt1m6a1920bMRuXzq1SCQk9RXdcbVLZUinlAsg857IGb26BovaSGmH/69ArUUykQ==
X-Received: by 2002:a17:902:9a92:: with SMTP id w18mr11332029plp.201.1570134444284;
        Thu, 03 Oct 2019 13:27:24 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id c64sm4055498pfc.19.2019.10.03.13.27.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 03 Oct 2019 13:27:23 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH -v3 8/8] fast-export: handle nested tags
Date:   Thu,  3 Oct 2019 13:27:09 -0700
Message-Id: <20191003202709.26279-9-newren@gmail.com>
X-Mailer: git-send-email 2.23.0.264.g3b9f7f2fc6
In-Reply-To: <20191003202709.26279-1-newren@gmail.com>
References: <20190930211018.23633-1-newren@gmail.com>
 <20191003202709.26279-1-newren@gmail.com>
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
2.23.0.264.g3b9f7f2fc6

