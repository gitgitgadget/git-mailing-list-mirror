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
	by dcvr.yhbt.net (Postfix) with ESMTP id 2FDC51F463
	for <e@80x24.org>; Wed, 25 Sep 2019 01:40:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442127AbfIYBkW (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Sep 2019 21:40:22 -0400
Received: from mail-pf1-f172.google.com ([209.85.210.172]:44325 "EHLO
        mail-pf1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439285AbfIYBkV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Sep 2019 21:40:21 -0400
Received: by mail-pf1-f172.google.com with SMTP id q21so2365369pfn.11
        for <git@vger.kernel.org>; Tue, 24 Sep 2019 18:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Zlkoi6rTsj/rKOoXQBdiTxBZXu/PGCaRIpjv1vvMjKw=;
        b=l5O1WH21A8Ui4xyQHs+s+QSydvdbB+4/t1uF4KgJm3LWXgOHOe4L/I4J2hJDdc8VQI
         K5mdNqCG74CcQANSkLxTSuo42a/YZd+W/mbd5NrU2cssQzJiaQMZ22yn3daDu3ScNfQQ
         rWLnWBa0DN59njJvbbJoBeFh3RIBCnau6O7aeeV2P9mJPv3pjUqkV/2i3dMp+6PcJNCB
         mrIDvqZVWXZdqQWxaeZa6NRlpNXFygfoE46TWiQC1hUOpL8ViUYWPpd5k1Mn8mMTzVrG
         sBhKdX9Bn9XSac7fcz1YEcbP3toBPhsvDasu7U9F79fDQZU1IWt74pd+prdqwfke9WAb
         j9dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Zlkoi6rTsj/rKOoXQBdiTxBZXu/PGCaRIpjv1vvMjKw=;
        b=tQaU5wiuJ3YAl146tpLH/NYs1iJO6z8JVgnrkW9LYgdRHURANC1RNBT+9hWw0i7fRs
         OQzl7U8PAcHV7ZJpyH8XPoCFjM0AsZcsDWkB1Oc5uxZyhh85dggw/DqTOYtI7Mun7ELn
         vmOC6kkj9rZCgvpPKRs4qyQNchIVedOsuAYW7EgqZlXtWobGJQ7CTgo6eBPDzlc+jlep
         OKYmTmwiXcWuwXjE4BfLrjEaLPPlnI5TP4DikDPSfwTIs+caDitYCyyXhIXiAU23DT1H
         aJQDiOk+D6s6A0THcW3iK2klJ3ZiX5pkK1qgtYpE3V/EMx33PV+LNDL+HddfZhnwcO1R
         O8XA==
X-Gm-Message-State: APjAAAXszu2OcqQyxoz3Rt2HQV2ogZXMeYF6UsFk0bqz3iLW8BJ6MJNx
        FoMJ2xxyyu8EVUp4HlkFRPND9YNcjko=
X-Google-Smtp-Source: APXvYqy04ELIcKxyr8mavXg5ZZOIcYeEQPz6rTyBit/0cNVZ5uozPmCAmtBmWlmSKUi1GHI7sFlD5w==
X-Received: by 2002:a17:90a:db47:: with SMTP id u7mr3347482pjx.40.1569375620061;
        Tue, 24 Sep 2019 18:40:20 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id h4sm3759050pgg.81.2019.09.24.18.40.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 24 Sep 2019 18:40:19 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Elijah Newren <newren@gmail.com>
Subject: [PATCH 8/8] fast-export: handle nested tags
Date:   Tue, 24 Sep 2019 18:40:05 -0700
Message-Id: <20190925014005.17056-9-newren@gmail.com>
X-Mailer: git-send-email 2.23.0.177.g8af0b3ca64
In-Reply-To: <20190925014005.17056-1-newren@gmail.com>
References: <20190925014005.17056-1-newren@gmail.com>
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
2.23.0.177.g8af0b3ca64

