Return-Path: <SRS0=KdtI=BW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0816C433DF
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 19:27:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B734E20866
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 19:27:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ECjpFsYS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726547AbgHLT1x (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Aug 2020 15:27:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726512AbgHLT1x (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Aug 2020 15:27:53 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EE88C061383
        for <git@vger.kernel.org>; Wed, 12 Aug 2020 12:27:53 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id kr4so1625383pjb.2
        for <git@vger.kernel.org>; Wed, 12 Aug 2020 12:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HmjRJZ34TmSiYHpifL9yvd+YubhGBrHtAeuZgWchII8=;
        b=ECjpFsYSikoTV7Ye0tod1ZRguAWHZEFcEFI/wZKn7nc5oouvCOKPOupWyWBsyWHL0R
         cf7HdHDmLyFS6vhNv5cXlhc1XqTYXnuC8xJMtuY3nvP/ROpnIAElKT9w0mcB2dx0jmqC
         yMUCf1BAOAtal7QLk1lsSdOFzf95M4DZhZUDUqjcUuEJpAzJNVZ+mXqIfPBX5/Xq5S+h
         /ZBQGjhhtvnZ4OWi1IGpj2m6T/nn4cS7yhFVE7kQilLr/rO9UF+eXzpTz+yIZmvfFyO+
         UZlzidFnsbCXTlPuVvoQN2TypjWkL4rTEs1gaxV/LhFWHMXYYDTtebqWig6WL4Sadb2A
         XnFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HmjRJZ34TmSiYHpifL9yvd+YubhGBrHtAeuZgWchII8=;
        b=s3UIIqPVr5tvtVrSsBKbUetiYEAjJ0lM2yVqllid/b5qJRtJwddSlTfh8yygz3/C6s
         UqnIkJ8CR75LaPdlx1CgVunIeqrklM/4ska/7uLE/+/LPwaLz6sW+1oARhP5wNGARaS0
         bG+67vGDK9+1mpjFM33Wwa2VF2Dl+b5736Wv+1Ff/P3giHynffxgUcnaIqzKLJteja6O
         vzDW94x6CjxotIp62i2Bay3XG2rbFGt1wrDAc8nTj6sOWNt7Kmbckj8/g8hQ/+saLyED
         mdrGi5DtIEjH+AHvgPzW/UWyF/uO41XafYK46iPFnX+RBkayxY1qBBu4EkS1MRdWkY42
         T6qQ==
X-Gm-Message-State: AOAM532u4s9PkKUjZbgLbstpK/jYJllB+74fLWjJsD5JzmqJzoVHQ4eE
        6WUy74qDVO5bGa/cJdGbsGc=
X-Google-Smtp-Source: ABdhPJyKhWTNS0ACSM7ap/ikBN7CWs9cgiMGgveREIMI0icJHW3xu50DisabJyGHD9WJqBZSv8k+TQ==
X-Received: by 2002:a17:902:c154:: with SMTP id 20mr895589plj.64.1597260472536;
        Wed, 12 Aug 2020 12:27:52 -0700 (PDT)
Received: from localhost.localdomain ([45.127.46.132])
        by smtp.gmail.com with ESMTPSA id f3sm3463334pfj.206.2020.08.12.12.27.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2020 12:27:51 -0700 (PDT)
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     shouryashukla.oo@gmail.com
Cc:     christian.couder@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        Johannes.Schindelin@gmx.de, kaartic.sivaraam@gmail.com,
        liu.denton@gmail.com
Subject: [GSoC][PATCH v2 0/4] t7401: modernize, cleanup and more
Date:   Thu, 13 Aug 2020 00:57:33 +0530
Message-Id: <20200812192737.13971-1-shouryashukla.oo@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200805174921.16000-1-shouryashukla.oo@gmail.com>
References: <20200805174921.16000-1-shouryashukla.oo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Greetings,

This is the v2 of the previously posted patch series titled
't7401: modernize, cleanup and warn':
https://lore.kernel.org/git/20200805174921.16000-1-shouryashukla.oo@gmail.com/

After suggestions from Denton, Taylor and Junio I made some changes:

-> In 2939804509 (t7401: modernize style, 2020-07-23), after suggestions
   from Denton and Taylor, I redirected the output of the two
   'rev-parse' commands to a file and then read from it instead of using
   a pipe '|' operator.

-> Drop the commit ab28283b67 (t7401: ensure uniformity in the
   '--for-status' test, 2020-07-10) and instead combine it with
   00c6289d5e (t7401: change test_i18ncmp syntax for clarity, 2020-07-10).
   This was suggested by Junio and Taylor.

-> Introduce the commit f0b87ddaf6 (t7401: change indentation for
   enhanced readability, 2020-08-11) which improves the indentation of
   the tests in t7401. This was suggested by Junio and Taylor.

-> Remove the WARNING from the commit 0bdb0bd72c (t7401: add a WARNING
   and a NEEDSWORK, 2020-07-23) and instead limit it to a more improved
   NEEDSWORK thus leading to the commit a743c28d71 (t7401: add a
   NEEDSWORK, 2020-07-23). This was suggested by Taylor.

Feedback and reviews are appreciated. I am tagging along a range-diff
between the v1 and v2 for ease of review.

Regards,
Shourya Shukla

-----
range-diff:

1:  31ae4038f1 ! 1:  2939804509 t7401: modernize style
    @@ Commit message
         t7401: modernize style

         The tests in 't7401-submodule-summary.sh' were written a long time ago
    -    and have some violations with respect to our CodingGuidelines such as
    -    incorrect spacing in usages of the redirection operator and absence
    -    of line feed between statements in case of the '|' (pipe) operator.
    -    Update it to match the CodingGuidelines.
    +    and has a violation with respect to our CodingGuidelines which is,
    +    incorrect spacing in usages of the redirection operator.
    +    Using a Git command in the upstream of a pipe might result in us
    +    losing its exit code. So, convert such usages so that they write to
    +    a file and read from them.

         Mentored-by: Christian Couder <chriscool@tuxfamily.org>
         Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
    +    Helped-by: Denton Liu <liu.denton@gmail.com>
    +    Helped-by: Taylor Blau <me@ttaylorr.com>
         Signed-off-by: Shourya Shukla <shouryashukla.oo@gmail.com>

      ## t/t7401-submodule-summary.sh ##
    @@ t/t7401-submodule-summary.sh: add_file () {
                git commit -m "Add $name"
                git commit -m "Add $name"
        done >/dev/null
     -  git rev-parse --verify HEAD | cut -c1-7
    -+  git rev-parse --verify HEAD |
    -+  cut -c1-7
    ++  git rev-parse --verify HEAD >out &&
    ++  cut -c1-7 out
        cd "$owd"
      }
      commit_file () {
    @@ t/t7401-submodule-summary.sh: commit_file sm1 &&
        cd sm1 &&
        git reset --hard HEAD~2 >/dev/null &&
     -  git rev-parse --verify HEAD | cut -c1-7
    -+  git rev-parse --verify HEAD |
    -+  cut -c1-7
    ++  git rev-parse --verify HEAD >out &&
    ++  cut -c1-7 out
      )

      test_expect_success 'modified submodule(backward)' "
2:  a3160d1ecc ! 2:  00c6289d5e t7401: change test_i18ncmp syntax for clarity
    @@ t/t7401-submodule-summary.sh: test_expect_success 'nonexistent commit' "
      "

      commit_file
    +@@ t/t7401-submodule-summary.sh: EOF
    +
    + test_expect_success '--for-status' "
    +   git submodule summary --for-status HEAD^ >actual &&
    +-  test_i18ncmp actual - <<EOF
    ++  test_i18ncmp - actual <<-EOF
    + * sm1 $head6...0000000:
    +
    + * sm2 0000000...$head7 (2):
3:  ab28283b67 < -:  ---------- t7401: ensure uniformity in the '--for-status' test
-:  ---------- > 3:  f0b87ddaf6 t7401: change indentation for enhanced readability
4:  0bdb0bd72c ! 4:  a743c28d71 t7401: add a WARNING and a NEEDSWORK
    @@ Metadata
     Author: Shourya Shukla <shouryashukla.oo@gmail.com>

      ## Commit message ##
    -    t7401: add a WARNING and a NEEDSWORK
    +    t7401: add a NEEDSWORK

    -    Add a WARNING regarding the usage of 'git add' instead of 'git
    -    submodule add' to add submodules to the superproject. Also add a
    -    NEEDSWORK regarding the outdated syntax and working of the test, which
    -    may need to be improved to obtain better and desired results.
    +    Add a NEEDSWORK regarding the outdated syntax and working of the test,
    +    which may need to be improved to obtain better and desired results.

         While at it, change the word 'test' to 'test script' in the test
         description to avoid ambiguity.

         Mentored-by: Christian Couder <chriscool@tuxfamily.org>
         Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
    +    Helped-by: Taylor Blau <me@ttaylorr.com>
         Signed-off-by: Shourya Shukla <shouryashukla.oo@gmail.com>

      ## t/t7401-submodule-summary.sh ##
    @@ t/t7401-submodule-summary.sh
     -This test tries to verify the sanity of summary subcommand of git submodule.
     +This test script tries to verify the sanity of summary subcommand of git submodule.
      '
    -+# WARNING: This test script uses 'git add' instead of 'git submodule add' to add
    -+# submodules to the superproject. Some submodule subcommands such as init and
    -+# deinit might not work as expected in this script.
    -+
    -+# NEEDSWORK: This test script is old fashioned and may need a big cleanup.
    ++# NEEDSWORK: This test script is old fashioned and may need a big cleanup since
    ++# there are lots of commands taking place outside of 'test_expect_success'
    ++# block, which is no longer in good-style.

      . ./test-lib.sh

-----

Shourya Shukla (4):
  t7401: modernize style
  t7401: change test_i18ncmp syntax for clarity
  t7401: change indentation for enhanced readability
  t7401: add a NEEDSWORK

 t/t7401-submodule-summary.sh | 151 ++++++++++++++++++-----------------
 1 file changed, 78 insertions(+), 73 deletions(-)

-- 
2.28.0

