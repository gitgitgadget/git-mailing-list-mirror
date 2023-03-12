Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E09CC74A5B
	for <git@archiver.kernel.org>; Sun, 12 Mar 2023 20:16:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbjCLUQR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Mar 2023 16:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbjCLUQI (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Mar 2023 16:16:08 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD25923C56
        for <git@vger.kernel.org>; Sun, 12 Mar 2023 13:15:26 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id cn21so10642587edb.0
        for <git@vger.kernel.org>; Sun, 12 Mar 2023 13:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678652125;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tho9EBaUW3bky7spUsmcL+ttkyNuQbvgV67z+Zz/CLY=;
        b=BgYahL6yDQONug1UrYz+MG057PKj8uy6w1RotkcQUOKK+0Mh/RtgtiPtoI30w1z5mo
         vdvs0N4J5Xlx/WQYImhSdkYGZ4A5OhnuQqFGZYZQZ/uMDuI8yTvcLug+EY1iZ0liNoNF
         UJr0b5b67eR/fTlMxGQ+KlSi3DyYsCoJGeW0fZ5hw1braZwLvq1BmiAEroHefjPcnSQq
         TUrJgntRPZMt656KRNO6OebKoUIAjOfdMyDVa3gUBbrJph53ZPEc8MGs6GKMrjk4UDAz
         G2XBUu2KRK8gZWrh8BqCy+/KgQXUicOAAzALk1iN++0Y3y1s6lM7/7cPmVDbUIYIepaI
         xotg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678652125;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tho9EBaUW3bky7spUsmcL+ttkyNuQbvgV67z+Zz/CLY=;
        b=idCUqTfLJqigkX1ddGsEjt8jm+fSuhF1k7cJkV45kpLOEU+uxgvIGATQgOgojEKFp/
         bMHQVMU2nCrZJInCgiZkDlxmMkDgOTE2nubLCoEdiWE4tL1mGP5zP1T02OA7RckwKqHY
         Q6eidKRFnA/yrX7WoI6yVczLeai90w1mL46pa4J9aaFckpbe9Jr5qtakqJvEb/s+xu1l
         +wqLVKHPQL+l5kOc+r4KKin0ArDKyfP35OQgk/0PEzQYBq3y8L/EwvYrinMIMoWPAC10
         FwEX6loCyyKZjcjRtIybmKDrwRbT5aBPs8biPK+Ywg84WSW+FLiP0hbKwbWA8uKhlgQ1
         TgTA==
X-Gm-Message-State: AO0yUKVQqC3V5nD5Ou+gsFWM14FsllLDsdWoW/RMeZRJwElIetaMk0iy
        KCg7S8vE1CMYW2qnbHkyfh7YLZ8thd/evQ==
X-Google-Smtp-Source: AK7set+SAjj0nsKT31n8Z1KQjGGhytnXuHssfuREXuR7Egpekxo1NnsbVlIA5pVEEjSnuLmbn5BnCQ==
X-Received: by 2002:a50:ee18:0:b0:4a0:e31a:434 with SMTP id g24-20020a50ee18000000b004a0e31a0434mr30049389eds.27.1678652124941;
        Sun, 12 Mar 2023 13:15:24 -0700 (PDT)
Received: from titov.fritz.box ([216.24.216.227])
        by smtp.gmail.com with ESMTPSA id hz17-20020a1709072cf100b008dceec0fd4csm2570344ejc.73.2023.03.12.13.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 13:15:24 -0700 (PDT)
From:   Andrei Rybak <rybak.a.v@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Michael J Gruber <git@grubix.eu>,
        Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v1 0/7] t: fix unused files, part 1
Date:   Sun, 12 Mar 2023 21:15:12 +0100
Message-Id: <20230312201520.370234-1-rybak.a.v@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I've noticed that several tests in t9001-send-email.sh don't use the files
created from redirecting output of git commands.  So I wrote a crude script to
find similar issues in other tests:

    from sys import argv
    from sys import exit
    import re
    
    script = argv[1]
    
    filename_pattern = re.compile('([-a-z_A-Z]+|&1)')
    git_with_output_pattern = re.compile('git [^&"]*[ 2][>](?!/)')
    
    while True:
        res = git_with_output_pattern.search(script)
        if res is None:
            break
        filename_index = res.span()[1]
        res = filename_pattern.search(script[filename_index:])
        filename = res.group()
    
        script = script[filename_index + len(filename):]
    
        if filename == '&1':
            continue
    
        read_index = script.find(filename)
        if read_index < 0:
            print("File '" + filename + "' is unused")
            print("Script: ")
            print(script)
            exit(1)
        script = script[read_index + len(filename):]

It doesn't check the tests very throughly and has a lot of false-positives, but
this is enough for now.  I invoke it from test_expect_success() like so:

---- 8< ----
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 999d46fafe..ac2614009d 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -836,6 +836,14 @@ test_expect_success () {
 		if test_run_ "$2"
 		then
 			test_ok_ "$1"
+			if ! echo "$1" | grep -q -E '(setup|preparation)'
+			then
+				if ! python3 "$TEST_DIRECTORY/../check_unused_files.py" "$2"
+				then
+					BUG "check_unused_files.py found an unused file in test '$1'"
+					return 1
+				fi
+			fi
 		else
 			test_failure_ "$@"
 		fi
---- >8 ----

Here are the fixes for the issues I've found so far -- I've gone through t0???
and t1???.

Andrei Rybak (7):
  t1005: assert output of ls-files
  t1006: assert error output of cat-file
  t1010: assert empty output of mktree
  t1302: don't create unused file
  t1400: assert output of update-ref
  t1404: don't create unused file
  t1507: assert output of rev-parse

 t/t1005-read-tree-reset.sh    | 15 ++++++++++-----
 t/t1006-cat-file.sh           |  3 ++-
 t/t1010-mktree.sh             |  6 ++++--
 t/t1302-repo-version.sh       |  2 +-
 t/t1400-update-ref.sh         |  3 +++
 t/t1404-update-ref-errors.sh  |  1 -
 t/t1507-rev-parse-upstream.sh |  6 ++++--
 7 files changed, 24 insertions(+), 12 deletions(-)

-- 
2.39.2

