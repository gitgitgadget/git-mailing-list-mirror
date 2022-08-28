Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 489A6ECAAD2
	for <git@archiver.kernel.org>; Sun, 28 Aug 2022 05:18:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232143AbiH1FSH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Aug 2022 01:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231981AbiH1FSF (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Aug 2022 01:18:05 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 550C831ED4
        for <git@vger.kernel.org>; Sat, 27 Aug 2022 22:18:04 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id k9so6368463wri.0
        for <git@vger.kernel.org>; Sat, 27 Aug 2022 22:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=7ho9sgT861keFsrVjVONjG5/0bkGcfd7okraMt66mx4=;
        b=MBFwheCcI6dHOXQEN8xisVcGlG+77RU7YUHIp6qQRdwrBb7OAo7juYcoWQ8s7lZGhC
         F9l+03OePSuup3/np+9llM5w1g2tu7HSwFFNWgiEUlDmULKTg8EefZGyociUU6ZGUD3y
         /H0BuQPqc2RaTWY/AjCgXCOSCMjdmWMIUnBH2E++dZXoXc00ewzvnrooQx6B30k0oxVY
         DpsCZqrOT/UV3O+bvrwQ9lbXXmaIncfBJjyfoGZdRL3OsmFg9U2Tp7x1NM8N/Zr7VhkX
         wu+qMZpmQeYzAGJSg0qA+EgXDxQ2VgUywCoT4/QEM9wqYjun40G6SfrXetJ4nCJcjepW
         QsOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=7ho9sgT861keFsrVjVONjG5/0bkGcfd7okraMt66mx4=;
        b=L9++oZeMwdD4uSQTBxkKDJyM1im3GYncWN8tl6OaGF8VhnaqC9atKc27tjObg0W0pU
         6a9/VPjDsEURQ01yQAwHLbJKwVf0ANbJU71OJz6KU0o/sLc8isJJQByepGmUiQ9yv4Yn
         n7JwqpByaXav/ZiEQ4WeaGz+vRp9W/nV/MJTPrEJGBmGCXW2hvX65JSw+iWrvQi6kJAt
         /y2SnWVrPHII7ExnTkoO7+Dnf6Cqf6Q8iSaAp5Z0BrFSiabKmXTnhq1AAfsCagYECtyG
         NYCxl2m8hEgGTKU9S+JNBk3PJjjHrSPTkxQ4VqsnhqxGA5wiT6FvRatC9JqfrKxPIBSK
         pM+g==
X-Gm-Message-State: ACgBeo0pgKPji8+gkRzkNEz1fL3k/SCfwXgIHXLmzrgRVFh1EFI6fLAP
        oAiLLdCd0ZVnA12gNe0JbdPaF2uxqcc=
X-Google-Smtp-Source: AA6agR5AuzmGJj9MAmGwkdwha7uSJU77fSe4v9Bpy0Zsrb7vzGRRSgr3+5p11rStMdiBP/c5izgDRA==
X-Received: by 2002:adf:d1ec:0:b0:226:d538:40b0 with SMTP id g12-20020adfd1ec000000b00226d53840b0mr1377165wrd.693.1661663882435;
        Sat, 27 Aug 2022 22:18:02 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p6-20020a1c5446000000b003a83fda1dc5sm2278223wmi.44.2022.08.27.22.18.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Aug 2022 22:18:01 -0700 (PDT)
Message-Id: <a3576ff88226ffbdcc58bf837e4cd97dd299f77b.1661663880.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1339.git.1661663879.gitgitgadget@gmail.com>
References: <pull.1339.git.1661663879.gitgitgadget@gmail.com>
From:   "Eric Sunshine via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 28 Aug 2022 05:17:57 +0000
Subject: [PATCH 1/3] t4301: account for behavior differences between sed
 implementations
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Eric Sunshine <sunshine@sunshineco.com>

It is a common pattern in this script to write the result of
`merge-tree -z` (NUL-termination mode) to an "actual" file and then
manually append a newline to that file so that it can be diff'd easily
with a hand-crafted "expect" file which itself ends with a newline since
it has been created by standard Unix tools which terminate lines by
default. For instance:

    git merge-tree --write-tree -z ... >out &&
    printf "\\n" >>out
    anonymize_hash out >actual &&
    q_to_nul <<-EOF >expect &&
    ...
    EOF
    test_cmp expect actual

However, one test gets this backward:

    git merge-tree --write-tree -z ... >out &&
    anonymize_hash out >actual &&
    printf "\\n" >>actual

which means that, unlike all other cases, when anonymize_hash() is
called, the file being anonymized does not end with a newline. As a
result, this test fails on some platforms.

anonymize_hash() is implemented like this:

    anonymize_hash() {
        sed -e "s/[0-9a-f]\{40,\}/HASH/g" "$@"
    }

The problem arises due to differences in behavior of various `sed`
implementations when fed an incomplete line (lacking a newline).
Although most modern `sed` implementations output such a line
unmolested (i.e. without a newline), some older `sed` implementations
forcibly add a newline to the incomplete line (giving the output an
extra unexpected newline), while other very old implementations simply
swallow an incomplete line and don't emit it at all (making the output
shorter than expected).

Fix this test by manually adding the newline before passing it through
`sed`, thus ensuring identical behavior with all `sed` implementation,
and bringing the test in line with other tests in this script.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/t4301-merge-tree-write-tree.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t4301-merge-tree-write-tree.sh b/t/t4301-merge-tree-write-tree.sh
index c5fd56df28f..d44c7767f30 100755
--- a/t/t4301-merge-tree-write-tree.sh
+++ b/t/t4301-merge-tree-write-tree.sh
@@ -760,8 +760,8 @@ test_expect_success 'NUL terminated conflicted file "lines"' '
 	git commit -m "Renamed numbers" &&
 
 	test_expect_code 1 git merge-tree --write-tree -z tweak1 side2 >out &&
+	printf "\\n" >>out &&
 	anonymize_hash out >actual &&
-	printf "\\n" >>actual &&
 
 	# Expected results:
 	#   "greeting" should merge with conflicts
-- 
gitgitgadget

