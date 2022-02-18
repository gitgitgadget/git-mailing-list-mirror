Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 569E4C433F5
	for <git@archiver.kernel.org>; Fri, 18 Feb 2022 17:12:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238174AbiBRRMx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Feb 2022 12:12:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbiBRRMw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Feb 2022 12:12:52 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A9C143EEE
        for <git@vger.kernel.org>; Fri, 18 Feb 2022 09:12:35 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id o24so15683876wro.3
        for <git@vger.kernel.org>; Fri, 18 Feb 2022 09:12:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wJevBzooktxUjmnNILAY743f9t+P1mcxh3v384VaHUM=;
        b=XVUNAkB7HyF4QREV815w93NKqDq/36cjBUsTxp3hgAnOctan+ToUfSFkz6yOyse1su
         GnE/fCDN1oSyRdfKVZPi1UxV39Qg9UOSaUfA5TZ9SC/ESwykz/vIs5u5+Y4MBgb4VwUr
         dLbjVhOYGd+0XmXMBSuEnyKAkpnBr+Aves9kvNXOhzw9cEdPDSAqw15A1Vj/Z1DJKn1K
         YJu0Hn39Zxbj4ZjvI++IAh/+osQ39SSijVmVBm42nXljFIuUw5+h9ZzDJZrwhGwilEZl
         BLgr2g2INNeqYKal9qESx7mxwqN7GdBtu9M4FKm7FcW/jQH32bhO2umNHBksPrK2Dhdx
         sTYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wJevBzooktxUjmnNILAY743f9t+P1mcxh3v384VaHUM=;
        b=PpfGoPuJ1fyiyZJJHiA+7Fl9TPPuhnuT/53muIBxtedIGnXbxC85ASb3NeKrD6P8uD
         XE2bjxPRliQV+Prjqa+irtYp7SPn0n7tvnk48PZ+6idNbSKwVevWUY504ILY3MC5w8JQ
         aGid7z/Iq/S5iPgtMAamVeofKWD9vXU/kixsR/1NIT6U8jNRkOe0zs10TGhEXP+Z0eP3
         5XHKx4tJioIweZCqLKtCZtzE5V+oTXlhqaMIGTO9S7nZY59EUDatdyfxJE3KqY2Sybz7
         ddvx8rxLksiskCIZqkF6hbK7D749prIlHbfDuAO+pzxVx3gXPw9WlFAK5ieqQgqtTb0m
         dxjw==
X-Gm-Message-State: AOAM531OcG/xPbFh5ItJ2tVN7IAHhIVuTeb8EHLXECXNK+OCgLLAweAH
        WqdcY0SAzZu6YB1WZM3PgHs=
X-Google-Smtp-Source: ABdhPJxk7W7DU/SsiriOFeCUrJdfqPaCp0x+P9jhboc823k2hg9QI7c6AwdhA93/HYn0zzGP3IRiEQ==
X-Received: by 2002:a5d:66c8:0:b0:1e3:36c0:91d8 with SMTP id k8-20020a5d66c8000000b001e336c091d8mr6959808wrw.536.1645204354138;
        Fri, 18 Feb 2022 09:12:34 -0800 (PST)
Received: from localhost.localdomain (176.248.7.93.rev.sfr.net. [93.7.248.176])
        by smtp.gmail.com with ESMTPSA id h6sm14332wmq.8.2022.02.18.09.12.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 09:12:33 -0800 (PST)
From:   COGONI Guillaume <cogoni.guillaume@gmail.com>
To:     avarab@gmail.com
Cc:     cogoni.guillaume@gmail.com, git.jonathan.bressat@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, guillaume.cogoni@gmail.com,
        matthieu.moy@univ-lyon1.fr
Subject: [PATCH v2 0/2] replace test [-f|-d] with more verbose functions
Date:   Fri, 18 Feb 2022 18:12:22 +0100
Message-Id: <20220218171224.262698-1-cogoni.guillaume@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <220215.86a6erwzee.gmgdl@evledraar.gmail.com>
References: <220215.86a6erwzee.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> On 02/11/2022 at 7:02 PM, Junio ​​C Hamano wrote:

> * introduce test_path_is_symlink and use it appropriately.  This
>   will be a more verbose version of "test -h".

> * introduce test_path_is_file_not_symlink and use it here.

Replace test [-f|-d] in t/t3903-stash.sh by test_path_is_*
Add new functions like test_path_is_* to cover more specifics cases like
symbolic link or file that we explicitly refuse to be symbolic link.

COGONI Guillaume (2):
  t/t3903-stash.sh: replace test [-d|-f] with test_path_is_*
  Add new tests functions like test_path_is_*

 t/t3903-stash.sh        | 21 +++++++++------------
 t/test-lib-functions.sh | 20 ++++++++++++++++++++
 2 files changed, 29 insertions(+), 12 deletions(-)

diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index e8e933dc4e..0ec19a4499 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -390,10 +390,9 @@ test_expect_success SYMLINKS 'stash file to symlink' '
        rm file &&
        ln -s file2 file &&
        git stash save "file to symlink" &&
-       test_path_is_file file &&
+       test_path_is_file_not_symlink file &&
        test bar = "$(cat file)" &&
-       git stash apply &&
-       case "$(ls -l file)" in *" file -> file2") :;; *) false;; esac
+       git stash apply
 '
 
 test_expect_success SYMLINKS 'stash file to symlink (stage rm)' '
@@ -401,10 +400,9 @@ test_expect_success SYMLINKS 'stash file to symlink (stage rm)' '
        git rm file &&
        ln -s file2 file &&
        git stash save "file to symlink (stage rm)" &&
-       test_path_is_file file &&
+       test_path_is_file_not_symlink file &&
        test bar = "$(cat file)" &&
-       git stash apply &&
-       case "$(ls -l file)" in *" file -> file2") :;; *) false;; esac
+       git stash apply
 '
 
 test_expect_success SYMLINKS 'stash file to symlink (full stage)' '
@@ -413,10 +411,9 @@ test_expect_success SYMLINKS 'stash file to symlink (full stage)' '
        ln -s file2 file &&
        git add file &&
        git stash save "file to symlink (full stage)" &&
-       test_path_is_file file &&
+       test_path_is_file_not_symlink file &&
        test bar = "$(cat file)" &&
-       git stash apply &&
-       case "$(ls -l file)" in *" file -> file2") :;; *) false;; esac
+       git stash apply
 '
 
 # This test creates a commit with a symlink used for the following tests
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 85385d2ede..61fc5f37e3 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -856,6 +856,16 @@ test_path_is_file () {
        fi
 }
 
+test_path_is_file_not_symlink () {
+       test "$#" -ne 1 && BUG "1 param"
+       test_path_is_file "$1" &&
+       if ! test ! -h "$1"
+       then
+               echo "$1 is a symbolic link"
+               false
+       fi
+}
+
 test_path_is_dir () {
        test "$#" -ne 1 && BUG "1 param"
        if ! test -d "$1"
@@ -865,6 +875,16 @@ test_path_is_dir () {
        fi
 }
 
+test_path_is_dir_not_symlink () {
+       test "$#" -ne 1 && BUG "1 param"
+       test_path_is_dir "$1" &&
+       if ! test ! -h "$1"
+       then
+               echo "$1 is a symbolic link"
+               false
+       fi
+}
+
 test_path_exists () {
        test "$#" -ne 1 && BUG "1 param"
        if ! test -e "$1"
-- 
2.25.1

