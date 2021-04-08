Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC8BDC43460
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 15:04:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C691261158
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 15:04:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232065AbhDHPFA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Apr 2021 11:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232042AbhDHPEx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Apr 2021 11:04:53 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82DB0C061761
        for <git@vger.kernel.org>; Thu,  8 Apr 2021 08:04:41 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id x4so2850536edd.2
        for <git@vger.kernel.org>; Thu, 08 Apr 2021 08:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KxUNl3TJri5Uh4i5df/Ev8iVqPZgeT9tdZbxgykVsPE=;
        b=vJuyGNdvw5fqsd6aO3h7ORDK++zdoZvTzvxC4S7USIHLcSI4d8zaOCQZPswYHamVcr
         ddzfnrx5KSpI8gP85A8OnO5l8sKgKZyFBqrRlPQu0rv8hDysZ7JIBl9lpPwFUTW2YGXd
         yeZp+OyL/ZB1+xXhtHvPd5Sy8nK4/cxig+/IXJzFcnPO6XDN/Y6thMwQ0dr0y7owkGgl
         wtATzwWMYfLt/aHvE2+vECghuFCytt92lk51vFiW8gOwhg/K55P0MhTye9OqIQFjY9ug
         MZ4cG/NrzsuHxLOqqAoot6mh6HJ70UcsPeZOz01iaH9S9inJa9wMrpBBbBeWAzFzKwKN
         zE7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KxUNl3TJri5Uh4i5df/Ev8iVqPZgeT9tdZbxgykVsPE=;
        b=CL85MfRIYdqq9N2f0IG7f/XmOemRs+MB6m9fdVJrPdq2YBM2OGZnhciVHzvs7T5yAg
         FChYT91Fe4a6114uYt6OH9q1Ttz1RDquWoZ5fT3DLhQqvu+6cMWxTmGotvx9lbndk+ud
         JVBpHw20F98GgVHyf+Dgqb45y47D8tSnqDTWriuVDLHjNjeD/x5Qpz781cCnrnqWCBtj
         wdROMEkRaQhJqDsLkuVOBFH5RAW1ii60U6CxS+qa68b9cEKr5n1Rvt4WTcBLI4iebpcq
         ZVR7jBA/MqOUNmbgGmtBv/3imgRf6HUgcybn4FviGmPmTquy3p43duMgTdpl7TgQTxlX
         AlCg==
X-Gm-Message-State: AOAM531/+8fJjsjWB/7ryx2SQFetvEBzlldYNVPlgbExQ8B9D5v29ttJ
        SBn0xQ7Cg3aFSnjeKKj+Dw9osLhNH+r6ng==
X-Google-Smtp-Source: ABdhPJwlw+vIVZVEzBEFdmhsOWHU+IKZuz+xot4E1uWIquG0wePclRZo2/Vv+CfD780GsdxIFvdwMw==
X-Received: by 2002:a05:6402:31ad:: with SMTP id dj13mr11693186edb.167.1617894279930;
        Thu, 08 Apr 2021 08:04:39 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h25sm2479253ejx.105.2021.04.08.08.04.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 08:04:39 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Adam Spiers <git@adamspiers.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Chris Torek <chris.torek@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 9/9] blame tests: simplify userdiff driver test
Date:   Thu,  8 Apr 2021 17:04:24 +0200
Message-Id: <patch-09.10-548673260b-20210408T145833Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.527.g9b8f7de2547
In-Reply-To: <cover-00.10-0000000000-20210408T145833Z-avarab@gmail.com>
References: <cover-00.11-00000000000-20210324T014604Z-avarab@gmail.com> <cover-00.10-0000000000-20210408T145833Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Simplify the test added in 9466e3809d (blame: enable funcname blaming
with userdiff driver, 2020-11-01) to use the --author support recently
added in 999cfc4f45 (test-lib functions: add --author support to
test_commit, 2021-01-12).

We also did not need the full fortran-external-function content. Let's
cut it down to just the important parts.

I'm modifying it to demonstrate that the fortran-specific userdiff
function is in effect by adding "DO NOT MATCH ..." and "AS THE ..."
lines surrounding the "RIGHT" one.

This is to check that we're using the userdiff "fortran" driver, as
opposed to the default driver which would match on those lines as part
of the general heuristic of matching a line that doesn't begin with
whitespace.

The test had also been leaving behind a .gitattributes file for later
tests to possibly trip over, let's clean it up with
"test_when_finished".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/annotate-tests.sh | 36 +++++++++++++++---------------------
 1 file changed, 15 insertions(+), 21 deletions(-)

diff --git a/t/annotate-tests.sh b/t/annotate-tests.sh
index 04a2c58594..d3b299e75c 100644
--- a/t/annotate-tests.sh
+++ b/t/annotate-tests.sh
@@ -479,32 +479,26 @@ test_expect_success 'blame -L ^:RE (absolute: end-of-file)' '
 	check_count -f hello.c -L$n -L^:ma.. F 4 G 1 H 1
 '
 
-test_expect_success 'setup -L :funcname with userdiff driver' '
-	echo "fortran-* diff=fortran" >.gitattributes &&
-	fortran_file=fortran-external-function &&
-	cat >$fortran_file <<-\EOF &&
+test_expect_success 'blame -L :funcname with userdiff driver' '
+	cat >file.template <<-\EOF &&
+	DO NOT MATCH THIS LINE
 	function RIGHT(a, b) result(c)
+	AS THE DEFAULT DRIVER WOULD
 
 	integer, intent(in) :: ChangeMe
-	integer, intent(in) :: b
-	integer, intent(out) :: c
-
-	c = a+b
-
-	end function RIGHT
 	EOF
-	git add "$fortran_file" &&
-	GIT_AUTHOR_NAME="A" GIT_AUTHOR_EMAIL="A@test.git" \
-	git commit -m "add fortran file" &&
-	sed -e "s/ChangeMe/IWasChanged/" <"$fortran_file" >"$fortran_file".tmp &&
-	mv "$fortran_file".tmp "$fortran_file" &&
-	git add "$fortran_file" &&
-	GIT_AUTHOR_NAME="B" GIT_AUTHOR_EMAIL="B@test.git" \
-	git commit -m "change fortran file"
-'
 
-test_expect_success 'blame -L :funcname with userdiff driver' '
-	check_count -f fortran-external-function -L:RIGHT A 7 B 1
+	fortran_file=file.f03 &&
+	test_when_finished "rm .gitattributes" &&
+	echo "$fortran_file diff=fortran" >.gitattributes &&
+
+	test_commit --author "A <A@test.git>" \
+		"add" "$fortran_file" \
+		"$(cat file.template)" &&
+	test_commit --author "B <B@test.git>" \
+		"change" "$fortran_file" \
+		"$(cat file.template | sed -e s/ChangeMe/IWasChanged/)" &&
+	check_count -f "$fortran_file" -L:RIGHT A 3 B 1
 '
 
 test_expect_success 'setup incremental' '
-- 
2.31.1.527.g9b8f7de2547

