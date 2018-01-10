Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D5B2D1F404
	for <e@80x24.org>; Wed, 10 Jan 2018 12:57:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934508AbeAJM5z (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Jan 2018 07:57:55 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:47066 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933931AbeAJM5r (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jan 2018 07:57:47 -0500
Received: by mail-wr0-f193.google.com with SMTP id g21so11444886wrb.13
        for <git@vger.kernel.org>; Wed, 10 Jan 2018 04:57:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I9XBTTOzxCguieUZPBHauA1fcRYHzkDrlWkXme7kBng=;
        b=ICQZ58hf1X0IKBn08E+aXVF2kL+ii9D0cFro/4eUozv/2J830QTp0TdgsCiv8y7Zul
         0uZsNfIn2DOjpj+7rUY4hwy+uSWPId064ZasVLrzv8tcz3CRo6CIASQBeuiqkB7PAMoU
         IUcVfZTWhcimmwKg/RJSTJfvI9KPG0DhSzs6cx4rIZRy4x2bvX/UhcYOw4U9gQ4lODuq
         mnXgkkpOOSlJ0LF2CV+aQVqtJ6UyrVL6B18TLQza1yTY5E6fkV67rkU6D7tLPQbAaIXe
         HBEVhVruf4izCGDAZffgjJOby9wlg++YJZXDZsPW889vwWYcMCU5bS71YKnafAoV/8q3
         WEEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I9XBTTOzxCguieUZPBHauA1fcRYHzkDrlWkXme7kBng=;
        b=XJIvdgFwy7FIqdoFmGRwyGvkEE/V78PWAoOuMlwAHughOYaDu5F7J292nYtigWEAfG
         uWCdRZ6BJBwSNDp4b8WToB5hQRNsSXQrsJI6yVNTcU+ytC96/Brq//3U6sYz1Iv8Pe/y
         KuWriUww2MPhauDNLtLgBvu3cgPBt4No37JfD1iNsENT3U+YbQ5OxT4IoQnCR3QhoV5e
         Bjs84aOv/0/dEa7AbjKFkCYqzMDyJ6MkgE1abnu/FokvL+jRC0YVfKEUk1paWBPBqFZo
         p0YCpvgezmtK+5NS2aJgUSVqs/Y0Uinv0g+LrEs2LTcNd0tSkolZT/9O2Y+3958qyEVN
         V6Jw==
X-Gm-Message-State: AKGB3mLYueCzwFhLL9GDLYJZF4S9X7di57juuMP3B6LYdFbLOCtztEHz
        geDOXGo4UEapUlt+c6QWKPbQtjt4
X-Google-Smtp-Source: ACJfBovRds1/W1Bo3JZQYMmkegkiKoCr2n3HPZCnZX6VnLRG11UB/EudhJQBiTDrZqYOzsBxBOEMSQ==
X-Received: by 10.223.137.1 with SMTP id s1mr13366658wrs.53.1515589066200;
        Wed, 10 Jan 2018 04:57:46 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id p29sm22722530wmf.20.2018.01.10.04.57.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Jan 2018 04:57:45 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/2] cat-file: -e should not emit output on stderr
Date:   Wed, 10 Jan 2018 12:55:54 +0000
Message-Id: <20180110125554.12582-3-avarab@gmail.com>
X-Mailer: git-send-email 2.15.1.424.g9478a66081
In-Reply-To: <20180110125554.12582-1-avarab@gmail.com>
References: <20180110125554.12582-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change "cat-file -e some-garbage" to work as documented. Before it
would emit:

    $ git cat-file -e some-garbage; echo $?
    fatal: Not a valid object name some-garbage
    128

Now:

    $ ./git-cat-file -e some-garbage; echo $?
    1

This is a change to longstanding behavior established in
7950571ad7 ("A few more options for git-cat-file", 2005-12-03) when
the option was initially added, but we should go with the promise made
in the documentation.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/cat-file.c  | 8 ++++++--
 t/t1006-cat-file.sh | 7 +++++++
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index f5fa4fd75a..75991788af 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -65,8 +65,12 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
 		flags |= OBJECT_INFO_ALLOW_UNKNOWN_TYPE;
 
 	if (get_oid_with_context(obj_name, GET_OID_RECORD_PATH,
-				 &oid, &obj_context))
-		die("Not a valid object name %s", obj_name);
+				 &oid, &obj_context)) {
+		if (opt == 'e')
+			return 1;
+		else
+			die("Not hello a valid object name %s", obj_name);
+	}
 
 	if (!path)
 		path = obj_context.path;
diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index b19f332694..c05a899bc4 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -201,6 +201,13 @@ do
     '
 done
 
+test_expect_success 'Providing -e should suppress all error output' '
+	! git cat-file -e some-garbage >stdout 2>stderr &&
+	>expect &&
+	test_cmp expect stdout &&
+	test_cmp expect stderr
+'
+
 for opt in t s e p
 do
     test_expect_success "Passing -$opt with --follow-symlinks fails" '
-- 
2.15.1.424.g9478a66081

