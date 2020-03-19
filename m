Return-Path: <SRS0=WCE0=5E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4081C4332D
	for <git@archiver.kernel.org>; Thu, 19 Mar 2020 14:00:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA49C208E4
	for <git@archiver.kernel.org>; Thu, 19 Mar 2020 14:00:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GZNT3aiC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727573AbgCSOAt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Mar 2020 10:00:49 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:38576 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727159AbgCSOAt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Mar 2020 10:00:49 -0400
Received: by mail-pj1-f68.google.com with SMTP id m15so1056364pje.3
        for <git@vger.kernel.org>; Thu, 19 Mar 2020 07:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CIx4ddyc9NjlKToFAMULdI4u237iTW1Z++4+VSGZg2A=;
        b=GZNT3aiCY5c/e6aKgX8Uks69DY92Q8yPHIOuieoz7xh9vkE7fYvK5+71WDA0hAD1b/
         /x2P8Peutzx5yLaLOzglIiMqGrCDW6j3d8ichYQU1s85VkE4a9IB04ehYFRorbIL5KeP
         0BgZAV/9Dd7rNtsiRDfGHeM95/Gw4ekkwNTlUmYCtjMX+XWyfDk5LsxjnT9gXJjwl/BY
         mqilhaqk0W54pvE5WCc8tskex277BtH8nzbw+1l9AndNgirm6T7UsfTnJAbCbsGINjKA
         ctZUSKFkbg7lOzMhgQ+meY3hpMa3SiAGa04kq3tAS8LHFC2tQLrPiMai5npfnb8tmq7X
         po2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CIx4ddyc9NjlKToFAMULdI4u237iTW1Z++4+VSGZg2A=;
        b=nuf2eq5Ol5txj8wbY9ZUTH2tiWviQV9QGNp44xTSg6QHJSloZPXcdg44CnphkkqRd2
         aaoXSJceviN+GUCrGlGvAV+FynSySLJ4NBbQMTP/Rc/bfqk/B5D1HxOyJvzOw6ZCQPcE
         1H/bDbDNMLdByGbqXKNeLtLYSwSCXMkTqaK9B/PqvrYwlZu8e3wyjg0rUkYRMakxlV3s
         as5oCHbXLtQKavog9V1S81KGRezGZF35wcPE4ONTuTYgpJPwb5Vo460G+6rMc37HEQdr
         eYfDLjOstTjnUZqFyCHkb3aByTiKqeFTYoKP7frZn75pw7lrwvbCDGnSqoNAYpewWKOS
         GYjg==
X-Gm-Message-State: ANhLgQ0Ex8wiv+T2SpKvbY0hdDmjBLiwyM0YiC9cz075jUYjC108a+up
        n8y9Nr1ucm/tiOoq4VCd40tQn/OX
X-Google-Smtp-Source: ADFU+vtBhxHuCxSYYDFmwLZot41DDKLO5piMBlj4l0dx8Hr3W8XLVts2rx4oVTAMUJ0RpT7dOerXOg==
X-Received: by 2002:a17:90a:3783:: with SMTP id v3mr4167913pjb.31.1584626446743;
        Thu, 19 Mar 2020 07:00:46 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6375:576b:56ff:d97c:a505:3e0c])
        by smtp.gmail.com with ESMTPSA id 189sm2654005pfg.170.2020.03.19.07.00.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Mar 2020 07:00:45 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH 2/6] test-lib-functions: test_cmp: eval $GIT_TEST_CMP
Date:   Thu, 19 Mar 2020 21:00:03 +0700
Message-Id: <7e184d97df8c673b0edfb6223c82385579777b19.1584625896.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.26.0.rc2.234.g969ad452ca
In-Reply-To: <cover.1584625896.git.congdanhqx@gmail.com>
References: <cover.1584625896.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shell recognises first non-assignment token as command name.
Thus, ` cd t/perf; ./p0000-perf-lib-sanity.sh -d -i -v` reports:

> test_cmp:1: command not found: diff -u

Using `eval` to unquote $GIT_TEST_CMP as same as precedence in `git_editor`.

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 t/test-lib-functions.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 352c213d52..ab0e47ae17 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -905,7 +905,7 @@ test_expect_code () {
 # - not all diff versions understand "-u"
 
 test_cmp() {
-	$GIT_TEST_CMP "$@"
+	eval "$GIT_TEST_CMP" '"$@"'
 }
 
 # Check that the given config key has the expected value.
-- 
2.26.0.rc2.234.g969ad452ca

