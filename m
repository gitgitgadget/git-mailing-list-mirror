Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08F74E7D0AB
	for <git@archiver.kernel.org>; Thu, 21 Sep 2023 22:08:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232897AbjIUWIN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Sep 2023 18:08:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232756AbjIUWH6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Sep 2023 18:07:58 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C0AA211E
        for <git@vger.kernel.org>; Thu, 21 Sep 2023 14:53:33 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-59ed7094255so18869157b3.3
        for <git@vger.kernel.org>; Thu, 21 Sep 2023 14:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1695333212; x=1695938012; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4e5y6C26a+syJN+0LDuquXhFUdok+0i3HDgNYgKVZ7E=;
        b=IUCI1SSwAkYuILtlYUut850KYvJH7I8A2t43lw9gsZNtAK21Fy/WbNejHAatc7rBe4
         PcdZGMK5+iujPRwlkbyOlfygz639iDOnPFcVC4oEDy8fx1B8QDajpbhokepfJG9jHzT+
         F8ZKuMnGm00NCcEtCL452VJgM5mUPrle8PGyAMyn2jnR50iWN4qB5+gWsIGx0MqRPn8t
         D2gSxhJBb904NqTxACWY5Ii2LohuqnXlMueSZ/nC8ZalgJFZGIe5OcEBW0pM/O4+Y6vi
         EyGtttfdxZEu1B+u2EQ4kiYx0/jPogGfQpFKg2Z3tFwZsaUV550kC8FZnF5Q2JNSgYOu
         C7hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695333212; x=1695938012;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4e5y6C26a+syJN+0LDuquXhFUdok+0i3HDgNYgKVZ7E=;
        b=WxanDPHTQxZS+Cp7YJ2QLc6vh86yp+NJ7/UJCxmk605ZNsgAFWMEopxhwmkoMnkCWN
         wDKvit/vi1jeBk/ZvXNl3NopPhri7WeFGTMLpWHednekGvshrWSRXyT0bpNyWixH9rv1
         KaxJrJi1CiMN8t+gpy02HoHYk2yJhx6d+e/W10jkO413SICxudsSzRS1I9RcVBxK2XQv
         0Im0lKjorYPFWSYUT+W/Nl4Q/UgYIotl5X4gAW4hgMViTB1nAa5CbEYG7zOjtHSRgIBY
         myZ7mJYfB8bX2I+ZJZWH/qWA82EA3eDsFL5qe08+f7Ky7KtEimZbrig+tZ1ZGe6UnSeo
         njkw==
X-Gm-Message-State: AOJu0Yy2qDn++vuUj7k+0/rXB+HzbtkWVxKXlkwBRMILJ91R75ZBFsCS
        zOZNJgDTfaMvVuMoRydmsIXpXgv3xLVRkGow2ZLZHQ==
X-Google-Smtp-Source: AGHT+IG1g59OPl3aIASLTsqxdziIOc6RPDxf4QqWN/nWoiGvPbAEPCz0jESy3Z7GSvJHYVN4cly9wg==
X-Received: by 2002:a0d:e881:0:b0:59b:f152:8997 with SMTP id r123-20020a0de881000000b0059bf1528997mr6569780ywe.0.1695333212618;
        Thu, 21 Sep 2023 14:53:32 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id k64-20020a816f43000000b0058c668e46cbsm556600ywc.46.2023.09.21.14.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 14:53:32 -0700 (PDT)
Date:   Thu, 21 Sep 2023 17:53:31 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v2] .github/workflows: add coverity action
Message-ID: <b23951c569660e1891a7fb3ad2c2ea1952897bd7.1695332105.git.me@ttaylorr.com>
References: <4590e1381feb8962cadf2b40b22086531d662ef8.1692675172.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4590e1381feb8962cadf2b40b22086531d662ef8.1692675172.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Coverity is a static analysis tool that detects and generates reports on
various security and code quality issues.

It is particularly useful when diagnosing memory safety issues which may
be used as part of exploiting a security vulnerability.

Coverity's website provides a service accepts "builds" (which is the
output of running `cov-build` on your project, which invokes `make` with
additional magic) as input and generates reports as output. In order to
generate a report, we have to first compile Git and then upload the
build archive to Coverity.

This Action generates and uploads a build archive to Coverity when a
GitHub repository has done the following:

- Configured the "COVERITY_SCAN_EMAIL" and "COVERITY_SCAN_TOKEN"
  repository secrets. Tokens are found on the "Project Settings" page at
  [1]. Tokens may be added as repository secrets on GitHub repositories
  by following the guide at [2].

- Enabled Coverity builds by (in addition to the above) creating a
  repository variable called `ENABLE_COVERITY`. Repository variables
  (which are different than secrets) can be added according to the guide
  at [3].

This enables Coverity to automatically report on new changes pushed to
the configured branch set, which is specified via the
`COVERITY_BRANCHES` repository variable.

The implementation is mostly straightforward. Though note that we could
upload the build archive to Coverity directly with a straightforward
curl request. But using the vapier/coverity-scan Action comes with some
additional niceties, such as caching the (rather large) Coverity tool
download between runs.

If the repository does not have the `ENABLE_COVERITY` variable set, or
the list of branches specified by `COVERITY_BRANCHES` does not contain
the branch being pushed to, this Action is a no-op.

[1]: https://scan.coverity.com/projects/NAME?tab=project_settings
[2]: https://docs.github.com/en/actions/security-guides/using-secrets-in-github-actions
[3]: https://docs.github.com/en/actions/learn-github-actions/variables

Helped-by: Jeff King <peff@peff.net>
Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
This fell to the bottom of my queue, but I got back to it today while
doing some ~~spring~~ fall inbox cleaning :-). Thanks Peff and Johannes
for helpful review in the first round. Range-diff is below:

Range-diff against v1:
1:  f74ae75ddb < -:  ---------- .github/workflows: add coverity action
-:  ---------- > 1:  b23951c569 .github/workflows: add coverity action

 .github/workflows/coverity.yml | 22 ++++++++++++++++++++++
 ci/install-dependencies.sh     |  2 +-
 ci/lib.sh                      |  2 +-
 3 files changed, 24 insertions(+), 2 deletions(-)
 create mode 100644 .github/workflows/coverity.yml

diff --git a/.github/workflows/coverity.yml b/.github/workflows/coverity.yml
new file mode 100644
index 0000000000..3ba00b3929
--- /dev/null
+++ b/.github/workflows/coverity.yml
@@ -0,0 +1,22 @@
+name: Coverity
+
+on: [push, pull_request]
+
+jobs:
+  coverity:
+    if: (vars.ENABLE_COVERITY == 'true') &&
+      (vars.COVERITY_BRANCHES == '' ||
+       contains(vars.COVERITY_BRANCHES, github.ref_name) ||
+       contains(vars.COVERITY_BRANCHES, '*'))
+    runs-on: ubuntu-latest
+    steps:
+      - uses: actions/checkout@v3
+      - run: ci/install-dependencies.sh
+        env:
+          jobname: coverity
+      - uses: vapier/coverity-scan-action@cae3c096a2eb21c431961a49375ac17aea2670ce
+        with:
+          email: ${{ secrets.COVERITY_SCAN_EMAIL }}
+          token: ${{ secrets.COVERITY_SCAN_TOKEN }}
+          command: make -j8
+
diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index 4f407530d3..7e100ee63f 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -74,7 +74,7 @@ Documentation)
 	test -n "$ALREADY_HAVE_ASCIIDOCTOR" ||
 	sudo gem install --version 1.5.8 asciidoctor
 	;;
-linux-gcc-default)
+linux-gcc-default|coverity)
 	sudo apt-get -q update
 	sudo apt-get -q -y install $UBUNTU_COMMON_PKGS
 	;;
diff --git a/ci/lib.sh b/ci/lib.sh
index 6fbb5bade1..2ad0ae340e 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -227,7 +227,7 @@ export SKIP_DASHED_BUILT_INS=YesPlease

 case "$runs_on_pool" in
 ubuntu-*)
-	if test "$jobname" = "linux-gcc-default"
+	if test "$jobname" = "linux-gcc-default" || test "$jobname" = "coverity"
 	then
 		break
 	fi
--
2.42.0.242.gc844f407a1
