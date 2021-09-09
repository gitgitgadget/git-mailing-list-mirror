Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A690C433F5
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 09:09:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25FCE61041
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 09:09:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231892AbhIIJLH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Sep 2021 05:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbhIIJLC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Sep 2021 05:11:02 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A976BC061575
        for <git@vger.kernel.org>; Thu,  9 Sep 2021 02:09:53 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id f65so1214772pfb.10
        for <git@vger.kernel.org>; Thu, 09 Sep 2021 02:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w5qZzwjEu2koA6LcITVJV24m3AexX8hAfbqXcXFZDuM=;
        b=MMFYjPNPIC1IbkALpxi2AFSd7FBMtz0N1NP/7SJiXwFxUblkUsZi7sDoy2KPEkULNe
         FYB3yY7bjR/4jLVmAu317xbSryT5wQpp2nV38oC1e0cTr29WG9pfZJ9hvJFZctmp9z/Q
         VtIBRSMxeb15SaPK8BngeLK0jLz3vyg7gLUAWSqRltpAguIvufJpH/DMYxHZ73cvP9vj
         rLNgTTTheC6/epamUaMCovMXSgul/M1+v3uLkwGKdi0kSXAAVEZnHMm5enSqCkOz9gow
         u1COlbwR3GO1K7KxL+m2/ZuGAE9rhUz/mrwxndPl7/1IJFiCUX9w/7FpwaQshysyxLNl
         AaNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w5qZzwjEu2koA6LcITVJV24m3AexX8hAfbqXcXFZDuM=;
        b=EGi8QXykOpDnixDEmCgZEX2O+jihOnrGQjmwoYRQt9O6s4cHhANbP28gK8asPiQ/FJ
         d8UuBRPIGCXyppdX+PGKEqrqPAEMeGySf5rMpBCpc98oN0uKG+n6bX1uMsCaB9FantKF
         WkwvVxHvXF+Gbtm6eScX9UvEeVZmiN61P/zpyKQQg/P/wfec+wHo3rxxPowu+31OXPUZ
         0c8jPKCjV0clRMogFqe4euz6+/2584WPGg4dOk9fT6RXPyFOgRMeX9cu1lC4hZ9s31H8
         YFKaCfk/8qAKln9I5+JjNDQJhHj3us44PsQ/ewfSsP06epp/Lu3xW8YQ2+FPeSrfUCkG
         yZkw==
X-Gm-Message-State: AOAM532tobe/eMcF4enaZ8cAtlwGd8SRJmJW+jXDa+Zz0Bn/nC1Uumfa
        rLO4x0mm97JcGHyIb19rAVPfsI3BA1I=
X-Google-Smtp-Source: ABdhPJwTUCRsxcGxZmG29sBnAteM6wfdrLwiI/f5a+ROc8SGCc6BNhMeSqUD5k+frjK+5ClcoGEYBA==
X-Received: by 2002:aa7:98ce:0:b0:40d:a02f:5a59 with SMTP id e14-20020aa798ce000000b0040da02f5a59mr2201001pfm.20.1631178592952;
        Thu, 09 Sep 2021 02:09:52 -0700 (PDT)
Received: from localhost.localdomain ([205.204.117.108])
        by smtp.gmail.com with ESMTPSA id g3sm1620908pgj.66.2021.09.09.02.09.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Sep 2021 02:09:52 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v5 0/1] ci: new github-action for git-l10n code review
Date:   Thu,  9 Sep 2021 17:09:26 +0800
Message-Id: <20210909090927.66336-1-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210902023139.89251-1-worldhello.net@gmail.com>
References: <20210902023139.89251-1-worldhello.net@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

## Changes since v4

* "git-po-helper check-commits" can work with bare repository now. So do not use
  "actions/checkout@v2" to prepare workspace any more.

* "git-po-helper learned how to fetch missing blobs in a batch. So do a blobless
  partial clone.


## range-diff v4...v5

1:  0067ccc ! 1:  1c43d6b ci: new github-action for git-l10n code review
    @@ .github/workflows/l10n.yml (new)
     +    permissions:
     +      pull-requests: write
     +    steps:
    -+      - uses: actions/checkout@v2
    -+        with:
    -+          fetch-depth: '1'
    -+      - name: Fetch missing commits
    -+        id: fetch-commits
    ++      - name: Setup base and head objects
    ++        id: setup-tips
     +        run: |
     +          if test "${{ github.event_name }}" = "pull_request_target"
     +          then
    @@ .github/workflows/l10n.yml (new)
     +            base=${{ github.event.before }}
     +            head=${{ github.event.after }}
     +          fi
    ++          echo "::set-output name=base::$base"
    ++          echo "::set-output name=head::$head"
    ++      - name: Run partial clone
    ++        run: |
    ++          git -c init.defaultBranch=master init --bare .
    ++          git remote add \
    ++            --mirror=fetch \
    ++            origin \
    ++            https://github.com/${{ github.repository }}
    ++          # Fetch tips that may be unreachable from github.ref:
    ++          # - For a forced push, "$base" may be unreachable.
    ++          # - For a "pull_request_target" event, "$head" may be unreachable.
     +          args=
    -+          for commit in $base $head
    ++          for commit in \
    ++            ${{ steps.setup-tips.outputs.base }} \
    ++            ${{ steps.setup-tips.outputs.head }}
     +          do
     +            case $commit in
     +            *[^0]*)
     +              args="$args $commit"
     +              ;;
     +            *)
    -+              # Ignore ZERO-OID.
    ++              # Should not fetch ZERO-OID.
     +              ;;
     +            esac
     +          done
    -+          # Unshallow the repository, and fetch missing commits using partial
    -+          # clone.  "$base" may be missing due to forced push, and "$head"
    -+          # may be missing due to the "pull_request_target" event.
    -+          git fetch --unshallow --filter=blob:none origin $args
    -+          echo "::set-output name=base::$base"
    -+          echo "::set-output name=head::$head"
    ++          git -c protocol.version=2 fetch \
    ++            --progress \
    ++            --no-tags \
    ++            --no-write-fetch-head \
    ++            --filter=blob:none \
    ++            origin \
    ++            ${{ github.ref }} \
    ++            $args
     +      - uses: actions/setup-go@v2
     +        with:
     +          go-version: '>=1.16'
    @@ .github/workflows/l10n.yml (new)
     +        run: |
     +          exit_code=0
     +          git-po-helper check-commits \
    -+              --github-action-event="${{ github.event_name }}" -- \
    -+              ${{ steps.fetch-commits.outputs.base }}..${{ steps.fetch-commits.outputs.head }} \
    -+              >git-po-helper.out 2>&1 ||
    -+            exit_code=$?
    ++            --github-action-event="${{ github.event_name }}" -- \
    ++            ${{ steps.setup-tips.outputs.base }}..${{ steps.setup-tips.outputs.head }} \
    ++            >git-po-helper.out 2>&1 || exit_code=$?
     +          if test $exit_code -ne 0 || grep -q WARNING git-po-helper.out
     +          then
     +            # Remove ANSI colors which are proper for console logs but not

----

Jiang Xin (1):
  ci: new github-action for git-l10n code review

 .github/workflows/l10n.yml | 105 +++++++++++++++++++++++++++++++++++++
 1 file changed, 105 insertions(+)
 create mode 100644 .github/workflows/l10n.yml

-- 
2.33.0

