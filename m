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
	by dcvr.yhbt.net (Postfix) with ESMTP id F2B1F1F4BD
	for <e@80x24.org>; Thu,  3 Oct 2019 20:27:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387938AbfJCU1R (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Oct 2019 16:27:17 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39252 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726523AbfJCU1R (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Oct 2019 16:27:17 -0400
Received: by mail-pf1-f196.google.com with SMTP id v4so2460955pff.6
        for <git@vger.kernel.org>; Thu, 03 Oct 2019 13:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RqDXPrQpETSbRU+UZBVqA+4jkwRvX1lVJf8AsW6sgtc=;
        b=PQT+s3PNOa8K18qubXalFjEOAocsQz8kbys5BnKOpq5rWsbu6CYaglsOriC0d9fEvT
         MNaeo2Hm5hdDw6zLbcJMRa0u1LYBQpX8VMjwsBCAmzpaG0yebGEU8z4MCTEwOrKiDeN+
         WjDnp9mcC5JEHz3Tu7Z9P5/Dptqgn2wkdnOesnF1kPEqCcjf0WSVGaGyjJwycByJ5IaH
         LIW4AfZ6MlATEsk7KMyjeSx7f2hpcDcqg2LnOROCOVGZP3cAH1yM3xaBgtDwksVIW6qi
         tq2ns+CujhYHIm3Lk1F3nfkW14VCHpnf1IwO/XySQdY9anAdHWYmZqv3kGPaL8lxUWP6
         YzdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RqDXPrQpETSbRU+UZBVqA+4jkwRvX1lVJf8AsW6sgtc=;
        b=gx+y9lBosfFJyy16EKpqLaAbmjmMG6TxyV3E1G1Q55rtRahy2geaV+YaacF8TKQYkk
         d6xRFc6CN6Zs3LDXd38sKoBTGH+3JKjaZaw8TI+i4nL4UVX9jAiBXv2gJbzyN9HSvdMP
         NACjI4oo4KGZj3Kbwsx1gDLlyQwknCxj+hGBOL9HAVeHsTmOuhxAnKSccpBBOtOEHAzb
         Z4xovfLrpdQGzss8CvZcU3M++i154Wn0TUW/bQfHgpcR495xqU2OeltLo387+OqIN6xO
         0amhDeGsSBTY/GUJ/ossaG7YihwhgxVd4qtesDB9cqcFjN6aCSNoEY7LXseC4uqZ4Ln8
         KuBw==
X-Gm-Message-State: APjAAAWV6vLAQqECI7OfyBt6wbbLwDdbM5OZ6AlfSkW0pqkZECJPBWWD
        0Dm3+dLjiKX53G94hx4xToc=
X-Google-Smtp-Source: APXvYqyJgmT3L2axeRvI7I2szpwc6ujfzxHSXsknhiL3JXdc52h/NUPvEZIXx/T42uE/ntM8pvDt7Q==
X-Received: by 2002:a62:aa0f:: with SMTP id e15mr12632849pff.160.1570134436739;
        Thu, 03 Oct 2019 13:27:16 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id c64sm4055498pfc.19.2019.10.03.13.27.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 03 Oct 2019 13:27:15 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH -v3 1/8] fast-export: fix exporting a tag and nothing else
Date:   Thu,  3 Oct 2019 13:27:02 -0700
Message-Id: <20191003202709.26279-2-newren@gmail.com>
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

fast-export allows specifying revision ranges, which can be used to
export a tag without exporting the commit it tags.  fast-export handled
this rather poorly: it would emit a "from :0" directive.  Since marks
start at 1 and increase, this means it refers to an unknown commit and
fast-import will choke on the input.

When we are unable to look up a mark for the object being tagged, use a
"from $HASH" directive instead to fix this problem.

Note that this is quite similar to the behavior fast-export exhibits
with commits and parents when --reference-excluded-parents is passed
along with an excluded commit range.  For tags of excluded commits we do
not require the --reference-excluded-parents flag because we always have
to tag something.  By contrast, when dealing with commits, pruning a
parent is always a viable option, so we need the flag to specify that
parent pruning is not wanted.  (It is slightly weird that
--reference-excluded-parents isn't the default with a separate
--prune-excluded-parents flag, but backward compatibility concerns
resulted in the current defaults.)

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/fast-export.c  |  7 ++++++-
 t/t9350-fast-export.sh | 13 +++++++++++++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index f541f55d33..5822271c6b 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -860,7 +860,12 @@ static void handle_tag(const char *name, struct tag *tag)
 
 	if (starts_with(name, "refs/tags/"))
 		name += 10;
-	printf("tag %s\nfrom :%d\n", name, tagged_mark);
+	printf("tag %s\n", name);
+	if (tagged_mark)
+		printf("from :%d\n", tagged_mark);
+	else
+		printf("from %s\n", oid_to_hex(&tagged->oid));
+
 	if (show_original_ids)
 		printf("original-oid %s\n", oid_to_hex(&tag->object.oid));
 	printf("%.*s%sdata %d\n%.*s\n",
diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
index b4004e05c2..d32ff41859 100755
--- a/t/t9350-fast-export.sh
+++ b/t/t9350-fast-export.sh
@@ -53,6 +53,19 @@ test_expect_success 'fast-export | fast-import' '
 
 '
 
+test_expect_success 'fast-export ^muss^{commit} muss' '
+	git fast-export --tag-of-filtered-object=rewrite ^muss^{commit} muss >actual &&
+	cat >expected <<-EOF &&
+	tag muss
+	from $(git rev-parse --verify muss^{commit})
+	$(git cat-file tag muss | grep tagger)
+	data 9
+	valentin
+
+	EOF
+	test_cmp expected actual
+'
+
 test_expect_success 'fast-export master~2..master' '
 
 	git fast-export master~2..master >actual &&
-- 
2.23.0.264.g3b9f7f2fc6

