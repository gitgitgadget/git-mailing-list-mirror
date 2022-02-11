Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A719C433EF
	for <git@archiver.kernel.org>; Fri, 11 Feb 2022 13:49:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350659AbiBKNtQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Feb 2022 08:49:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239783AbiBKNtL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Feb 2022 08:49:11 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2E61EB
        for <git@vger.kernel.org>; Fri, 11 Feb 2022 05:49:10 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id c192so5483648wma.4
        for <git@vger.kernel.org>; Fri, 11 Feb 2022 05:49:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NjqlPMrZvlUlcemtvhAaIZnR3e3Ycy+e1zxnyJlmlRk=;
        b=UwkWab5xN1fi4fWZr54Jdmpubs+174hD6x+++TuHK9ezlcbbBRsek+xA99o+yeE+qO
         Mc9NWHZ1Oc1NQ4fnWA7qYnSc0dctO130eaG2sFoJXy8c5fdl0jYPanzEX4v/+eGSWI8S
         qWW3VOjM3hebfmJKyILoO1wj1UvgG41f3n0LZtG9dbtsOUQ2XJj9LygzBVFkq6Xo6/vh
         nr4vaEd5PtZGJEXNpq4EOOYCkgWcb1Hz+CTGJh1zQC9Txt+r+Dk/Op6fkbFngtxTJOB6
         622qBDa+96ZhW99LAVBIhBJg96QU3mPMm0ZsvLSiYq6IuKsavZPojCdZL5kk97fHWh1x
         /Rqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NjqlPMrZvlUlcemtvhAaIZnR3e3Ycy+e1zxnyJlmlRk=;
        b=ZZLHJ7P16bm1Tffdwva8XX/JlIfgOtFfyWGaFOCQZiyk6JZWMxnCPTFe4gaglqCFwr
         YMsZXViR570JSOYi9hDU9HbPTru7D8XJ5BM7GazChA0Bk2kARUkjtwcBhIELhCd+TIP6
         aEqTdTu/Pnigv0oqEwR0wfdXAg65et7WLE4OVXCT5cn5kzv1zWQMuEnFsyixHDwNObQc
         Yeb8Q5PN01aiPF49DEwYmUn4oR5z9M7Kuc5xFB37rj2A+Od/izH3DFUhWT9qFaWi3FRh
         bPkrpNkTScxYGuSAbPj+ScxgDNaY5eJYUYWwSlpKuce+QTiuBf1NS78mvT9tu5P/i0XT
         veew==
X-Gm-Message-State: AOAM531yAFHGnNp6Uq1QnbAKKufRWMZ36xBtA3niVGlTLcktUMs+2N/r
        bFNXi+Xo7ZblQbkT2muiZpw7W3hicjQNgnKX
X-Google-Smtp-Source: ABdhPJwz9LkIxvPIoLxLHD7kqXy4U9cf6CFMVxfSfny6DtRAUbr+qpxysqFyFk19dFCJJrPMZbjh0A==
X-Received: by 2002:a05:600c:601a:: with SMTP id az26mr396442wmb.2.1644587348965;
        Fri, 11 Feb 2022 05:49:08 -0800 (PST)
Received: from localhost.localdomain (176.248.7.93.rev.sfr.net. [93.7.248.176])
        by smtp.gmail.com with ESMTPSA id u15sm22987110wrs.18.2022.02.11.05.49.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 05:49:08 -0800 (PST)
From:   COGONI Guillaume <cogoni.guillaume@gmail.com>
To:     git@vger.kernel.org
Cc:     git.jonathan.bressat@gmail.com, guillaume.cogoni@gmail.com,
        matthieu.moy@univ-lyon1.fr,
        COGONI Guillaume <cogoni.guillaume@gmail.com>
Subject: [PATCH] t/t3903-stash.sh: replace test [-d|-f] with test_path_is_*
Date:   Fri, 11 Feb 2022 14:46:55 +0100
Message-Id: <20220211134655.1149320-1-cogoni.guillaume@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use test_path_is_* to replace test [-d|-f] because that give more
explicit debugging information. And it doesn't change the semantics.

Signed-off-by: COGONI Guillaume <cogoni.guillaume@gmail.com>
Co-authored-by: BRESSAT Jonathan <git.jonathan.bressat@gmail.com>
---
 t/t3903-stash.sh | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 686747e55a..d0a4613371 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -390,7 +390,7 @@ test_expect_success SYMLINKS 'stash file to symlink' '
 	rm file &&
 	ln -s file2 file &&
 	git stash save "file to symlink" &&
-	test -f file &&
+	test_path_is_file file &&
 	test bar = "$(cat file)" &&
 	git stash apply &&
 	case "$(ls -l file)" in *" file -> file2") :;; *) false;; esac
@@ -401,7 +401,7 @@ test_expect_success SYMLINKS 'stash file to symlink (stage rm)' '
 	git rm file &&
 	ln -s file2 file &&
 	git stash save "file to symlink (stage rm)" &&
-	test -f file &&
+	test_path_is_file file &&
 	test bar = "$(cat file)" &&
 	git stash apply &&
 	case "$(ls -l file)" in *" file -> file2") :;; *) false;; esac
@@ -413,7 +413,7 @@ test_expect_success SYMLINKS 'stash file to symlink (full stage)' '
 	ln -s file2 file &&
 	git add file &&
 	git stash save "file to symlink (full stage)" &&
-	test -f file &&
+	test_path_is_file file &&
 	test bar = "$(cat file)" &&
 	git stash apply &&
 	case "$(ls -l file)" in *" file -> file2") :;; *) false;; esac
@@ -487,7 +487,7 @@ test_expect_failure 'stash directory to file' '
 	rm -fr dir &&
 	echo bar >dir &&
 	git stash save "directory to file" &&
-	test -d dir &&
+	test_path_is_dir dir &&
 	test foo = "$(cat dir/file)" &&
 	test_must_fail git stash apply &&
 	test bar = "$(cat dir)" &&
@@ -500,10 +500,10 @@ test_expect_failure 'stash file to directory' '
 	mkdir file &&
 	echo foo >file/file &&
 	git stash save "file to directory" &&
-	test -f file &&
+	test_path_is_file file &&
 	test bar = "$(cat file)" &&
 	git stash apply &&
-	test -f file/file &&
+	test_path_is_file file/file &&
 	test foo = "$(cat file/file)"
 '
 
-- 
2.25.1

