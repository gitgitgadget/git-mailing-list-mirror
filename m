Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 68938215F4
	for <e@80x24.org>; Mon, 30 Apr 2018 22:08:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754890AbeD3WIE (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Apr 2018 18:08:04 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:39429 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754504AbeD3WID (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Apr 2018 18:08:03 -0400
Received: by mail-wm0-f52.google.com with SMTP id f8so6047657wmc.4
        for <git@vger.kernel.org>; Mon, 30 Apr 2018 15:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GIgQofa41QXNzlcZr4+YKSkVKT1TtSUBF3MQni6vy5M=;
        b=XYzKISSUxmyFLddSrHVo7NfU9z5p5wzynVyPpjIo2uenbSL+GRSb6PyT+2mvden9zI
         5YO6/SCSKhhthiCVLCUwgqTSNJnZvmB4JvDWXRw0i+kQh2Txt8qhgedd5x+4ZFDR7Wy1
         jCSHrH2Dtjnnvon7S0H2IRKLH5501APcP+r4DuvV0EtSQu8MfD4MYGiqBRrma9px+oI9
         S+smAkbkUPBOiUIKwKUw5XH9yQ3K5nyC7vcGtHbUQhwFAA7niAzzyXzXxPYyZknMUGOR
         5KnlIOsfjYlY5JB4GPKHrTvQovGijgYXKurD1tFB5te220b+MWQoJMV7VRWbhpj9GTeT
         R17w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GIgQofa41QXNzlcZr4+YKSkVKT1TtSUBF3MQni6vy5M=;
        b=YLfhIP355naI4dHkPUoH81zOvcTVYnM1bDL693fb9bPreu42rUfL+TcB0di8sL2EV0
         YBwsAuMKPIz1tl3dooWc4lBCVS7jc8smVWeVzO/9Jd6pTLQH70ZcGugMjA+8QjhbecEU
         snvPAl8TyrRrrDZFxdmV1S2EMI3sV7wjtXzeUPssp0pbpqLU4l8OsBgZsc3xmzLMJIVa
         /JA5FS1ixki291kU/gkeVFwb99BHFU25b7hJza2PIUSJkuld7CGFIny8rUw7nmCtNHQK
         G+biaoywIUETRgP+GPOiVq87R5QOwajM63WxzYzrpNUWSTO7pNGjm6q8V16SCudFN9/t
         yyHw==
X-Gm-Message-State: ALQs6tCMYLcaHw0RM5c96ATMShmLafTss435v02bs5KLz2OC32ulX7Ip
        qRWeBebJdjpKbg0ElA1iG4YMumEV
X-Google-Smtp-Source: AB8JxZpVdRSkm5c+MS4Dp03NxlmYap0Sdu0cLHsp5cTZsThITCc311tjNzfd+D/hh77CNq2yZx/33A==
X-Received: by 10.28.74.13 with SMTP id x13mr5740516wma.150.1525126081381;
        Mon, 30 Apr 2018 15:08:01 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id l53-v6sm24014633wrc.80.2018.04.30.15.08.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Apr 2018 15:08:00 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 6/9] get_short_oid: learn to disambiguate by ^{blob}
Date:   Mon, 30 Apr 2018 22:07:31 +0000
Message-Id: <20180430220734.30133-7-avarab@gmail.com>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
In-Reply-To: <20180430220734.30133-1-avarab@gmail.com>
References: <20180430220734.30133-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The disambiguation logic had all the pieces necessary to only print
out those blobs that were ambiguous, but they hadn't been connected.

The initial logic was added in daba53aeaf ("sha1_name.c: add support
for disambiguating other types", 2012-07-02), and when the flags were
propagated in 8a10fea49b ("get_sha1: propagate flags to child
functions", 2016-09-26) GET_OID_BLOB wasn't added to lookup_flags.

Before this change requests for blobs were simply ignored:

    $ git rev-parse e8f2^{blob}
    error: short SHA1 e8f2 is ambiguous
    hint: The candidates are:
    hint:   e8f2650052 tag v2.17.0
    hint:   e8f21caf94 commit 2013-06-24 - bash prompt: print unique detached HEAD abbreviated object name
    hint:   e8f26250fa commit 2017-02-03 - Merge pull request #996 from jeffhostetler/jeffhostetler/register_rename_src
    hint:   e8f2bc0c06 commit 2015-05-10 - Documentation: note behavior for multiple remote.url entries
    hint:   e8f2093055 tree
    hint:   e8f25a3a50 tree
    hint:   e8f28d537c tree
    hint:   e8f2cf6ec0 tree
    hint:   e8f21d02f7 blob
    hint:   e8f21d577c blob
    hint:   e8f2867228 blob
    hint:   e8f2a35526 blob
    e8f2^{blob}
    [...]

But now we'll do the right thing and only print the blobs:

    $ git rev-parse e8f2^{blob}
    error: short SHA1 e8f2 is ambiguous
    hint: The candidates are:
    hint:   e8f21d02f7 blob
    hint:   e8f21d577c blob
    hint:   e8f2867228 blob
    hint:   e8f2a35526 blob
    e8f2^{blob}
    [...]

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 sha1-name.c                         | 2 ++
 t/t1512-rev-parse-disambiguation.sh | 6 +++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/sha1-name.c b/sha1-name.c
index 68d5f65362..023f9471a8 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -971,6 +971,8 @@ static int peel_onion(const char *name, int len, struct object_id *oid,
 		lookup_flags |= GET_OID_TAG;
 	else if (expected_type == OBJ_TREE)
 		lookup_flags |= GET_OID_TREEISH;
+	else if (expected_type == OBJ_BLOB)
+		lookup_flags |= GET_OID_BLOB;
 
 	if (get_oid_1(name, sp - name - 2, &outer, lookup_flags))
 		return -1;
diff --git a/t/t1512-rev-parse-disambiguation.sh b/t/t1512-rev-parse-disambiguation.sh
index c7ceda2f21..08ae73e2a5 100755
--- a/t/t1512-rev-parse-disambiguation.sh
+++ b/t/t1512-rev-parse-disambiguation.sh
@@ -337,7 +337,11 @@ test_expect_success C_LOCALE_OUTPUT 'ambiguity hints respect type' '
 	test_line_count = 7 hints &&
 	git rev-parse 000000000^{tag} >stdout &&
 	test_line_count = 1 stdout &&
-	grep -q ^0000000000f8f stdout
+	grep -q ^0000000000f8f stdout &&
+	test_must_fail git rev-parse 000000000^{blob} 2>stderr &&
+	grep ^hint: stderr >hints &&
+	# 5 blobs plus intro line &&
+	test_line_count = 6 hints
 '
 
 test_expect_success C_LOCALE_OUTPUT 'failed type-selector still shows hint' '
-- 
2.17.0.290.gded63e768a

