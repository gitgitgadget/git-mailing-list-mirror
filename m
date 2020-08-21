Return-Path: <SRS0=jbtA=B7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31752C433E1
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 17:04:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2CEB20656
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 17:04:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mk9qoJhI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728535AbgHUREX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Aug 2020 13:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728506AbgHURAf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Aug 2020 13:00:35 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2456AC061795
        for <git@vger.kernel.org>; Fri, 21 Aug 2020 10:00:03 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id b11so1141027pld.7
        for <git@vger.kernel.org>; Fri, 21 Aug 2020 10:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VSiFAaypE54FCOOB7Geys/WuDt/PeezUVW2WbW47tQ8=;
        b=Mk9qoJhIrtQObyif/x/qL2z7rZ1vi3NFWA/gJGYkbTzGw3yG0uceuLbrin5ntnM4R/
         4gXM/4OQ0oOdaaZhYy6pxEJ+eAFJuXhe/3OY1BdWYbsjypuHkuifvWqKOZquEcOHJS02
         bZTpcJntsh7G4aDtqsz2WI1TCBMJoCpvaE8YdBPXYx/WbuLcZ7DbxOa7ctUj0+ZB18wW
         bZqtVEJDayiVTictvNdqdYug3NGWkAyVzPkIjgHvGrSmam4H101Wq+z9GkuMDIwdhPMC
         BzqgOEo3g26MEXWUXrVB2fLgzsPyzDCwpNqYq2p7G/fJgiFNFvjQfI2wZspI/AfPtJzS
         fbgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VSiFAaypE54FCOOB7Geys/WuDt/PeezUVW2WbW47tQ8=;
        b=IcDR64vPC37lmNSOBKp90+XsFnDlHQPMgqS+Zil3pWd3cXBOzNrgxktVaR8ScStyQw
         W9XjC6SzbewFC6PjwHYGuPpG5kdBdAZQsCve+OcMGDNTk+TnoCsbHPGe2GIylV9LtNRz
         RLkQnBqjdt0K5qQUf2tAJxP9Zj9jFj75C4+XR/O/pzzqxLFYYpAxApKYA7gv1Bn65GnR
         hRsznIytW8QmrUb/awsRsMvukOeL13Y0PmWpHzYbQEgUjppCW8V6OMKoCDARQ4dKnPQ+
         CJRixomrIxVAy0whFh9vTWr28d8Ckp38HIdvyaPWjpkIAG+pXoJ+hUIDhLbyPny0FJlH
         9BwA==
X-Gm-Message-State: AOAM5334RdxwHMY3qysqE5rv7kFra/IdpuAENFbUp5h3IXfppPslG1r4
        fVYlJwtW2afuaaF/yxwJ3c7HznmG/eUleQ==
X-Google-Smtp-Source: ABdhPJyd8UxBL2FUjGEtySzD4gDDjGS/NPVwHmrn7dCtPLSq8v72fULQtJ0tj+UIyDerlxFGZ39tsA==
X-Received: by 2002:a17:90b:3509:: with SMTP id ls9mr3202500pjb.230.1598029201665;
        Fri, 21 Aug 2020 10:00:01 -0700 (PDT)
Received: from localhost.localdomain ([125.99.204.38])
        by smtp.gmail.com with ESMTPSA id q7sm3043505pfu.133.2020.08.21.09.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 10:00:00 -0700 (PDT)
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, christian.couder@gmail.com,
        Johannes.Schindelin@gmx.de, kaartic.sivaraam@gmail.com,
        liu.denton@gmail.com, me@ttaylorr.com,
        Shourya Shukla <shouryashukla.oo@gmail.com>
Subject: [GSoC][PATCH v3 0/5] t7401: modernize, cleanup and more
Date:   Fri, 21 Aug 2020 22:29:47 +0530
Message-Id: <20200821165952.14376-1-shouryashukla.oo@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Greetings,
The is the v3 of the previously posted patch series with the same title:
https://lore.kernel.org/git/20200812192737.13971-1-shouryashukla.oo@gmail.com/

After suggestions from Junio and Kaartic I made some changes:

-> In 0f7f1d3f9a (t7401: modernize style, 2020-07-23)), Kaartic advised
   to use a '--short' instead of '--verify', which will remove the call
   to 'cut' since '--short' is the name as '--verify' and on top of that
   shortens the hash as per our need. Thus, deliver this change as a
   separate commit 2c7afd6147 (t7401: use 'short' instead of 'verify'
   and cut in rev-parse calls, 2020-08-14).

-> In 948c85f637 (t7401: use 'short' instead of 'verify' and cut in
   rev-parse calls, 2020-08-14), transfer the heredoc limiter change to
   7c227a2d47 (t7401: change indentation for enhanced readability,
   2020-08-11) since it is more apt there. This was suggested by Junio.

-> 7c227a2d47 (t7401: change indentation for enhanced readability,
   2020-08-11), improve the commit message and account for the heredoc
   change which was transferred to this commit from the previous one.

-> Although not suggested by anyone, but I also improved the NEEDSWORK
   in 313c04e197 (t7401: add a NEEDSWORK, 2020-07-23) to make it more
   precise.

Feedback and reviews are appreciated. I am tagging along a range-diff
between the v1 and v2 for ease of review.

Regards,
Shourya Shukla

-----
range-diff:

1:  2939804509 ! 1:  0f7f1d3f9a t7401: modernize style
    @@ Commit message
         The tests in 't7401-submodule-summary.sh' were written a long time ago
         and has a violation with respect to our CodingGuidelines which is,
         incorrect spacing in usages of the redirection operator.
    -    Using a Git command in the upstream of a pipe might result in us
    -    losing its exit code. So, convert such usages so that they write to
    -    a file and read from them.
     
         Mentored-by: Christian Couder <chriscool@tuxfamily.org>
         Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
    @@ t/t7401-submodule-summary.sh: add_file () {
                git add "$name" &&
                test_tick &&
                git commit -m "Add $name"
    -   done >/dev/null
    --  git rev-parse --verify HEAD | cut -c1-7
    -+  git rev-parse --verify HEAD >out &&
    -+  cut -c1-7 out
    -   cd "$owd"
    - }
    - commit_file () {
    -@@ t/t7401-submodule-summary.sh: commit_file sm1 &&
    - head3=$(
    -   cd sm1 &&
    -   git reset --hard HEAD~2 >/dev/null &&
    --  git rev-parse --verify HEAD | cut -c1-7
    -+  git rev-parse --verify HEAD >out &&
    -+  cut -c1-7 out
    - )
    - 
    - test_expect_success 'modified submodule(backward)' "
-:  ---------- > 2:  948c85f637 t7401: use 'short' instead of 'verify' and cut in rev-parse calls
2:  00c6289d5e ! 3:  f5548fe7c6 t7401: change test_i18ncmp syntax for clarity
    @@ Metadata
     Author: Shourya Shukla <shouryashukla.oo@gmail.com>
     
      ## Commit message ##
    -    t7401: change test_i18ncmp syntax for clarity
    +    t7401: change syntax of test_i18ncmp calls for clarity
     
         Change the test_i18ncmp syntax from 'test_i18ncmp actual expected' to
         'test_i18ncmp expected actual' to align it with the convention followed
    @@ t/t7401-submodule-summary.sh: EOF
      test_expect_success '--for-status' "
        git submodule summary --for-status HEAD^ >actual &&
     -  test_i18ncmp actual - <<EOF
    -+  test_i18ncmp - actual <<-EOF
    ++  test_i18ncmp - actual <<EOF
      * sm1 $head6...0000000:
      
      * sm2 0000000...$head7 (2):
3:  f0b87ddaf6 ! 4:  7c227a2d47 t7401: change indentation for enhanced readability
    @@ Commit message
         t7401: change indentation for enhanced readability
     
         Change the indentation of expected outputs for enhanced readability of
    -    the tests.
    +    the tests. Also modify the heredoc string limiter in a test which lacks
    +    it to support the indentation change.
     
         Mentored-by: Christian Couder <chriscool@tuxfamily.org>
         Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
    @@ t/t7401-submodule-summary.sh: commit_file sm2
      
      test_expect_success '--for-status' "
        git submodule summary --for-status HEAD^ >actual &&
    -   test_i18ncmp - actual <<-EOF
    +-  test_i18ncmp - actual <<EOF
     -* sm1 $head6...0000000:
    ++  test_i18ncmp - actual <<-EOF
     +  * sm1 $head6...0000000:
      
     -* sm2 0000000...$head7 (2):
4:  a743c28d71 ! 5:  313c04e197 t7401: add a NEEDSWORK
    @@ t/t7401-submodule-summary.sh
     -This test tries to verify the sanity of summary subcommand of git submodule.
     +This test script tries to verify the sanity of summary subcommand of git submodule.
      '
    -+# NEEDSWORK: This test script is old fashioned and may need a big cleanup since
    -+# there are lots of commands taking place outside of 'test_expect_success'
    -+# block, which is no longer in good-style.
    ++# NEEDSWORK: This test script is old fashioned and may need a big cleanup due to
    ++# various reasons, one of them being that there are lots of commands taking place
    ++# outside of 'test_expect_success' block, which is no longer in good-style.
      
      . ./test-lib.sh

-----

Shourya Shukla (5):
  t7401: modernize style
  t7401: use 'short' instead of 'verify' and cut in rev-parse calls
  t7401: change syntax of test_i18ncmp calls for clarity
  t7401: change indentation for enhanced readability
  t7401: add a NEEDSWORK

 t/t7401-submodule-summary.sh | 149 ++++++++++++++++++-----------------
 1 file changed, 76 insertions(+), 73 deletions(-)

-- 
2.28.0

