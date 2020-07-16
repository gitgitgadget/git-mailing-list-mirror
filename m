Return-Path: <SRS0=27Fn=A3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83542C433E4
	for <git@archiver.kernel.org>; Thu, 16 Jul 2020 12:19:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DEF520739
	for <git@archiver.kernel.org>; Thu, 16 Jul 2020 12:19:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qLKvHz2U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728479AbgGPMT4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jul 2020 08:19:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728093AbgGPMTz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jul 2020 08:19:55 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B3CEC061755
        for <git@vger.kernel.org>; Thu, 16 Jul 2020 05:19:55 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id 17so11408010wmo.1
        for <git@vger.kernel.org>; Thu, 16 Jul 2020 05:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j+styKkbYPsVl913KxFpxOtNAd+ro8icYbnzqjW7sZM=;
        b=qLKvHz2Um3TfmMMTT7Jyod8fjf7zZEQb04To51ZvPegVUejlRUwn/QG5oenb/DB/l7
         LtHnNxUmZIHfEI8s6HsG9NnF3hEQoH0re3qMLFKgk0xOThUXjMhriIUWZ6wWaDQBIHLw
         yxLrEats3xqTIrIGKW74IgQ7w1jj1vyhrzFWQuG+jLtgf6PalNk/pTEYWcjMmBj9hhQS
         ustXYCjUEUdgqbHQz1RFLSaQQOW2SDFErMPDiaGJMGFfHmqpKvk28Ev0ByjzqMZrIesE
         6IgjsAy7eAPBBI+PpqUkI4tcbLTVYK35rAYqetUdL6+OGuxM7mnjg5VU2DB84uuzP7qU
         4DJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j+styKkbYPsVl913KxFpxOtNAd+ro8icYbnzqjW7sZM=;
        b=KImhuMWyW88H9sDHt73fAOPGBexdzYJD/7lnOP/6oHKS0AMBNDdPOh+WkR1tGKHW0f
         8crEblob9aT+OwAzPvrBUiPqUqsct1rS4Cn1r8aHv6aBN7mpBqMAO670EmJDGtjGeZfU
         Dd497xF977wPMP0XG9KuFAecPMWQ4uCkeRqrrru8Tm3d/pINVOLEKgCkmyeenYQjwCDp
         /H5PJQe9lgL/YnXnA0FVHJ5odXXFzxzsAMu4Cr3dEkI0IhQZ0YjtyRVKYBGrhDH/L0WK
         y2cLaX9qBJ/WOkWUsP96z1w40H72dt8NkkuLySEm2N5KwXOG634GsAlqdpunLNWjIYJS
         Z2bg==
X-Gm-Message-State: AOAM5324zkBD+PMo0yq6iBYN2DFxZ+Jlz76DDY9eVU3RMJA37/DztaYn
        aEuXciflJQZbgLpE/ZWqc+WkTjvPCtI=
X-Google-Smtp-Source: ABdhPJyTkWeUvadxcXiWStkakPZ7StrJMYTaiQ1JX1dO0mp9XF2k2Ht6UeNImKoCWAaLlTXKtM/weg==
X-Received: by 2002:a1c:4846:: with SMTP id v67mr4325193wma.175.1594901993614;
        Thu, 16 Jul 2020 05:19:53 -0700 (PDT)
Received: from localhost.localdomain ([193.56.245.81])
        by smtp.gmail.com with ESMTPSA id p4sm8725714wrx.63.2020.07.16.05.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 05:19:52 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v5 0/3] Add support for %(contents:size) in ref-filter
Date:   Thu, 16 Jul 2020 14:19:37 +0200
Message-Id: <20200716121940.21041-1-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.27.0.227.g757ac19d14.dirty
In-Reply-To: <20200710164739.6616-1-chriscool@tuxfamily.org>
References: <20200710164739.6616-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is version 5 of a small patch series to teach ref-filter about
%(contents:size).

This patch series is based on master at 4a0fcf9f76 (The seventh batch,
2020-07-06).

Previous versions and related discussions are there:

V1: https://lore.kernel.org/git/20200701132308.16691-1-chriscool@tuxfamily.org/
V2: https://lore.kernel.org/git/20200702140845.24945-1-chriscool@tuxfamily.org/
V3: https://lore.kernel.org/git/20200707174049.21714-1-chriscool@tuxfamily.org/
V4: https://lore.kernel.org/git/20200710164739.6616-1-chriscool@tuxfamily.org/

Thanks to Junio and Peff for their reviews of this series!

The changes compared to V4 are the following:

  - Modified test_atom() in patch 3/3 to as suggested by Junio.

The range diff is:

1:  f750832fc7 = 1:  f750832fc7 Documentation: clarify %(contents:XXXX) doc
2:  51c72e09d2 = 2:  51c72e09d2 t6300: test refs pointing to tree and blob
3:  c2ed3e228b ! 3:  cf6a60036e ref-filter: add support for %(contents:size)
    @@ t/t6300-for-each-ref.sh: test_atom() {
     +  # Automatically test "contents:size" atom after testing "contents"
     +  if test "$2" = "contents"
     +  then
    -+          case "$1" in
    -+          refs/tags/signed-*)
    ++          case $(git cat-file -t "$ref") in
    ++          tag)
     +                  # We cannot use $3 as it expects sanitize_pgp to run
     +                  expect=$(git cat-file tag $ref | tail -n +6 | wc -c) ;;
    -+          refs/mytrees/* | refs/myblobs/*)
    ++          tree | blob)
     +                  expect='' ;;
    -+          *)
    ++          commit)
     +                  expect=$(printf '%s' "$3" | wc -c) ;;
     +          esac
     +          # Leave $expect unquoted to lose possible leading whitespaces
     +          echo $expect >expected
    -+          test_expect_${4:-success} $PREREQ "basic atom: $1 $2:size" "
    -+                  git for-each-ref --format='%($2:size)' $ref >actual &&
    -+                  test_cmp expected actual
    -+          "
    ++          test_expect_${4:-sucess} $PREREQ "basic atom: $1 contents:size" '
    ++                  git for-each-ref --format="%(contents:size)" "$ref" >actual &&
    ++                  test_cmp expect actual
    ++          '
     +  fi
      }
      
Christian Couder (3):
  Documentation: clarify %(contents:XXXX) doc
  t6300: test refs pointing to tree and blob
  ref-filter: add support for %(contents:size)

 Documentation/git-for-each-ref.txt | 27 ++++++++++++++++-----
 ref-filter.c                       |  7 +++++-
 t/t6300-for-each-ref.sh            | 38 ++++++++++++++++++++++++++++++
 3 files changed, 65 insertions(+), 7 deletions(-)

-- 
2.27.0.227.g757ac19d14.dirty

