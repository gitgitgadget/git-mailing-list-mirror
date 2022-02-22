Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78EF0C433F5
	for <git@archiver.kernel.org>; Tue, 22 Feb 2022 21:55:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235897AbiBVVzh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Feb 2022 16:55:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235306AbiBVVzg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Feb 2022 16:55:36 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE6A5A1BC0
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 13:55:09 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id s13so7478107wrb.6
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 13:55:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nMWxtjPgXOr2AeKaa6rL9wHH8L2fhclXACs8INUaLlU=;
        b=HFBGZa+GPPfHj4jVTFu8drj0D1dpDu9GSSoQvkn7JpKve389cnsSx7H4MSV4mmOZbs
         0fSzwOQwHHcO4uUK0sOxbJvf3IIxRlrrya5Da7BsG6zFPfqk94Qmc/GNQ7noKu76IpbT
         e4BE3M9vsxr2ZK6ZKBtm0t/OlI2HGD9oItaQAdhZnNLxgFXv1XDHvSnV+NISC3MDQPUC
         FnjaLnO+xJMU+yXiK3p0YO9EJ8QVrTpdGNGugm4OMO/nPWI2t8aiJN/nmUyUPRAK/zdp
         kHSGyVJ3Xzs0iQtlC5Yg0lO2InsG84fq5z5W8CMWwS0J8qYaF+WK4YGs4r/iUx0ovpJE
         ognA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nMWxtjPgXOr2AeKaa6rL9wHH8L2fhclXACs8INUaLlU=;
        b=Re7arzSbZTby82kjflWWpRGGoM7OJ1k6ngo6EOW/p1UPwP8fH7egK78/P1B9DWKbQ0
         /vLaiZq412YjhzOJq1okW2nix1Ra/qihdu4GeKFEXme6w2bu2A01gEKShRuSNFBiNXUX
         7VvQFbu7J9CFpKiRl1snTLQzIeGU9bvjOQzmopJEcejZFUIRSokV8Tg77NQNVYWDu1lR
         yNTD3LPhnkw4uUGcpj5PcPDRFnEO2CckMQMJG/rGCbvU4GGhLgkEBwZ38/Hfjx/ibEQQ
         cYp+M0tVunepik/DYM6macBMfoO/xahbnIhXNfISWoKUBYkx/MRxM8cHDjUzZyai4XGO
         KeZg==
X-Gm-Message-State: AOAM530BkfdfdjMnln6AV60celXT51woYt7iYkJFTJduezlfxc3Is/F/
        6lNIy0psvlkrnjbrCoENaGY=
X-Google-Smtp-Source: ABdhPJzi3Z4C6AabDktQ0KkSpac5SX7LRNYl2LJcMfEe259QgYHQvqoqYnHDufTsHiH8LHAzI0R6LQ==
X-Received: by 2002:a5d:58cd:0:b0:1e3:2a0f:a528 with SMTP id o13-20020a5d58cd000000b001e32a0fa528mr21550360wrf.338.1645566908313;
        Tue, 22 Feb 2022 13:55:08 -0800 (PST)
Received: from localhost.localdomain (176.248.7.93.rev.sfr.net. [93.7.248.176])
        by smtp.gmail.com with ESMTPSA id u12sm39471997wrw.32.2022.02.22.13.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 13:55:07 -0800 (PST)
From:   COGONI Guillaume <cogoni.guillaume@gmail.com>
To:     gitster@pobox.com
Cc:     avarab@gmail.com, cogoni.guillaume@gmail.com,
        git.jonathan.bressat@gmail.com, git@vger.kernel.org,
        guillaume.cogoni@gmail.com, matthieu.moy@univ-lyon1.fr
Subject: [PATCH v3 0/3] replace test [-f|-d] with more verbose functions
Date:   Tue, 22 Feb 2022 22:54:27 +0100
Message-Id: <20220222215430.605254-1-cogoni.guillaume@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <xmqqbkz4105s.fsf@gitster.g>
References: <xmqqbkz4105s.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Make the code more readable in t/t3903-stash.sh and give more 
friendly error message by replacing test [-f|-d] by the right 
test_path_is_* functions.
Add new functions like test_path_is_* to cover more specifics 
cases like symbolic link or file that we explicitly refuse
to be symbolic link.

> On 18/11/2022, Junio ​​C Hamano wrote:

> The "ls -l" parsing the original does is to check how "stash apply"
> recovers the stashed state, where "file" wants to be a symbolic link
> and it wants to be pointing at "file2".

> It seems we have test_readlink() available these days, so with a
> separate clean-up patch, you may want to make the final version
> to read something like this, perhaps?

> I am not sure what test_readlink which is a one-liner Perl script
> does when it is fed a non symbolic link, so I do not know if the
> "path is truly a file and not a symlink"

-	case "$(ls -l file)" in *" file -> file2") :;; *) false;; esac    
+	test_path_is_symlink file &&
+	test "$(test_readlink file)" = file2

Firstly, we check if file is a symbolic link then if it is a symbolic link
on file2.
We check if it is a symbolic link because test_readlink() raise an error 
if we give it something that is not a symbolic link and this error is less
readable.

> Why not
> 	if test -h "$1"
> instead???  I think "is truly a dir not a symlink" has the same
> "Huh?" puzzle.

We fixed it.



COGONI Guillaume (3):
  t/t3903-stash.sh: replace test [-d|-f] with test_path_is_*
  tests: allow testing if a path is truly a file or a directory
  tests: make the code more readable

 t/t3903-stash.sh        | 21 ++++++++++++---------
 t/test-lib-functions.sh | 29 +++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+), 9 deletions(-)


Difference between V2 and V3.
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 0ec19a4499..d5ecee4fcc 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -392,7 +392,9 @@ test_expect_success SYMLINKS 'stash file to symlink' '
        git stash save "file to symlink" &&
        test_path_is_file_not_symlink file &&
        test bar = "$(cat file)" &&
-       git stash apply
+       git stash apply &&
+       test_path_is_symlink file &&
+       test "$(test_readlink file)" = file2
 '
 
 test_expect_success SYMLINKS 'stash file to symlink (stage rm)' '
@@ -402,7 +404,9 @@ test_expect_success SYMLINKS 'stash file to symlink (stage rm)' '
        git stash save "file to symlink (stage rm)" &&
        test_path_is_file_not_symlink file &&
        test bar = "$(cat file)" &&
-       git stash apply
+       git stash apply &&
+       test_path_is_symlink file &&
+       test "$(test_readlink file)" = file2
 '
 
 test_expect_success SYMLINKS 'stash file to symlink (full stage)' '
@@ -413,7 +417,9 @@ test_expect_success SYMLINKS 'stash file to symlink (full stage)' '
        git stash save "file to symlink (full stage)" &&
        test_path_is_file_not_symlink file &&
        test bar = "$(cat file)" &&
-       git stash apply
+       git stash apply &&
+       test_path_is_symlink file &&
+       test "$(test_readlink file)" = file2
 '
 
 # This test creates a commit with a symlink used for the following tests
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 61fc5f37e3..0f439c99d6 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -859,9 +859,9 @@ test_path_is_file () {
 test_path_is_file_not_symlink () {
        test "$#" -ne 1 && BUG "1 param"
        test_path_is_file "$1" &&
-       if ! test ! -h "$1"
+       if test -h "$1"
        then
-               echo "$1 is a symbolic link"
+               echo "$1 shouldn't be a symbolic link"
                false
        fi
 }
@@ -878,9 +878,9 @@ test_path_is_dir () {
 test_path_is_dir_not_symlink () {
        test "$#" -ne 1 && BUG "1 param"
        test_path_is_dir "$1" &&
-       if ! test ! -h "$1"
+       if test -h "$1"
        then
-               echo "$1 is a symbolic link"
+               echo "$1 shouldn't be a symbolic link"
                false
        fi
 }
@@ -894,6 +894,15 @@ test_path_exists () {
        fi
 }
 
+test_path_is_symlink () {
+       test "$#" -ne 1 && BUG "1 param"
+       if ! test -h "$1"
+       then
+               echo "Symbolic link $1 doesn't exist"
+               false
+       fi
+}
+

-- 
2.25.1

