Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27DC2C2B9F4
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 10:42:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3BA160FDA
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 10:42:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231756AbhFQKoO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Jun 2021 06:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbhFQKoN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jun 2021 06:44:13 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD8E9C061574
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 03:42:05 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id c84so3090437wme.5
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 03:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5M0h7qh3eQIp4QdhRo3d2pkmMLkN+AUjzZO+mhHFp7M=;
        b=f0k7/w7j2hsNTGrlFiW4QhkNWrPP5qUJV9vh52UINRQtGvYGDrVNi2HwAEuSQXQMhx
         P+l163cWrJ3v9339uI5sNTDR0b9oo9QS4CPqQThe89sLshLvZj6E5pe95ARK85hXGNrS
         ez/hNckZX7objb33Zon2D+3OJ3lJReVNhSbwpNg3NpzEpQaqMdnezp8Z/UPZXw8DKqmm
         o7O5MUWFEKg9klSWh86JIGvk7CX9KBV+S7ZpjN8pAp0rWLT9c1Y4Y9AJX0THo4O+0b/s
         5WPEdZyVyLCXKUt7YtiOvEKibhzP3WKdAQm9bk0jWkvZTiFfopXENLnNhYrlTHyzT2/e
         vHUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5M0h7qh3eQIp4QdhRo3d2pkmMLkN+AUjzZO+mhHFp7M=;
        b=rYU14ZKaE7hCDW1bT4tdaLhwV4sNB++7TobNMVLYjp1SnOUlYmm94N0OSuPJN4SG5e
         vsnyn9BCTVnKlwc/tdDKjfBiCA3WnsPFbSn7beo6ftSGMv89MBoC3YnjXroo3Hfl4X8p
         PoHHSAulALTdHf9YZD0/J3t0nRMNa16lnmV4huqgHS+4z9iQtgItHnZ+65hZq5npixDh
         qXIYu3f0AjZL3KfEF7jWXd9ZHS7IrOmU+gLbS3mgtFQTwW5FGTVnOe6qryiRsQ+6Q5DF
         xKKSJNGt0/PyTjmu7hpEIeyMtLAEio/V2XaZtu8SiNGo2GP6974i4/A7Ljl57eXRZJie
         l46Q==
X-Gm-Message-State: AOAM533zc0EDW8QM6N5QAGt/GMg/CalTr2GAM/iPiebLCy/YV+BJox9S
        Z3LJlFkOtASY0cxsrcpYS4q3/MaXnRkE0A==
X-Google-Smtp-Source: ABdhPJyMH4Giy8mGp9RaFDacRGOF/U9WiOLefkodnFasT5Feil85XHSjdE2blqtHMGmHU/c/Qjw12g==
X-Received: by 2002:a7b:c193:: with SMTP id y19mr4390799wmi.172.1623926524152;
        Thu, 17 Jun 2021 03:42:04 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p10sm4784607wrr.33.2021.06.17.03.42.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 03:42:03 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Olga Telezhnaya <olyatelezhnaya@gmail.com>,
        Jeff King <peff@peff.net>, Andrei Rybak <rybak.a.v@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 0/6] mktag tests: test more exhaustively
Date:   Thu, 17 Jun 2021 12:41:56 +0200
Message-Id: <cover-0.6-0000000000-20210617T104011Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.571.gdba276db2c
In-Reply-To: <cover-0.6-00000000000-20210614T172422Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20210614T172422Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A re-roll of [1] which adds more mktag tests. Fixes the issues noted
in [2] and one more that I spotted myself: I used a "$bad_tag" in an
earlier commit than it was defined. I've fixed that, and changed the
structure of the tests (use rev-parse to assert) to make sure it is
defined before we do the "test_must_fail" tests.

1. https://lore.kernel.org/git/cover-0.6-00000000000-20210614T172422Z-avarab@gmail.com
2. https://lore.kernel.org/git/6148debe-fc44-67b7-ac9c-f27d376bc9f2@gmail.com

Ævar Arnfjörð Bjarmason (6):
  mktag tests: parse out options in helper
  mktag tests: invert --no-strict test
  mktag tests: test hash-object --literally and unreachable fsck
  mktag tests: test update-ref and reachable fsck
  mktag tests: test for-each-ref
  mktag tests: test fast-export

 t/t3800-mktag.sh | 121 +++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 106 insertions(+), 15 deletions(-)

Range-diff against v1:
1:  d49549973d = 1:  d49549973d mktag tests: parse out options in helper
2:  550dcedfcb = 2:  550dcedfcb mktag tests: invert --no-strict test
3:  96520b3e89 ! 3:  bab235d752 mktag tests: test hash-object --literally and unreachable fsck
    @@ t/t3800-mktag.sh: check_verify_failure () {
      		--no-strict)
      			no_strict=yes
      			;;
    --		esac &&
     +		--fsck-obj-ok)
     +			fsck_obj_ok=yes
     +			;;
    -+		esac
    + 		esac &&
      		shift
      	done &&
    - 
     @@ t/t3800-mktag.sh: check_verify_failure () {
      			git mktag --no-strict <tag.sig
      		fi
    @@ t/t3800-mktag.sh: check_verify_failure () {
     +		then
     +			git -C bad-tag fsck
     +		else
    -+			test_must_fail git -C bad-tag fsck >out 2>err
    ++			test_must_fail git -C bad-tag fsck
     +		fi
     +	'
      }
4:  0359becdc9 ! 4:  a1d95c81ea mktag tests: test update-ref and reachable fsck
    @@ t/t3800-mktag.sh: check_verify_failure () {
      		# Reset any leftover state from the last $subject
      		rm -rf bad-tag &&
      
    + 		git init --bare bad-tag &&
    +-		git -C bad-tag hash-object -t tag -w --stdin --literally <tag.sig
    ++		bad_tag=$(git -C bad-tag hash-object -t tag -w --stdin --literally <tag.sig)
    + 	'
    + 
    + 	test_expect_success "hash-object & fsck unreachable: $subject" '
     @@ t/t3800-mktag.sh: check_verify_failure () {
    - 			test_must_fail git -C bad-tag fsck >out 2>err
    + 			test_must_fail git -C bad-tag fsck
      		fi
      	'
     +
     +	test_expect_success "update-ref & fsck reachable: $subject" '
    ++		# Make sure the earlier test created it for us
    ++		git rev-parse "$bad_tag" &&
    ++
     +		# The update-ref of the bad content will fail, do it
     +		# anyway to see if it segfaults
     +		test_might_fail git -C bad-tag update-ref "$tag_ref" "$bad_tag" &&
5:  8a626fc63a ! 5:  f4c41be92d mktag tests: test for-each-ref
    @@ Commit message
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## t/t3800-mktag.sh ##
    -@@ t/t3800-mktag.sh: check_verify_failure () {
    - 		rm -rf bad-tag &&
    - 
    - 		git init --bare bad-tag &&
    --		git -C bad-tag hash-object -t tag -w --stdin --literally <tag.sig
    -+		bad_tag=$(git -C bad-tag hash-object -t tag -w --stdin --literally <tag.sig)
    - 	'
    - 
    - 	test_expect_success "hash-object & fsck unreachable: $subject" '
     @@ t/t3800-mktag.sh: check_verify_failure () {
      		# will always fail.
      		test_must_fail git -C bad-tag fsck
      	'
     +
     +	test_expect_success "for-each-ref: $subject" '
    ++		# Make sure the earlier test created it for us
    ++		git rev-parse "$bad_tag" &&
    ++
     +		echo "$bad_tag" >"bad-tag/$tag_ref" &&
     +
     +		printf "%s tag\t%s\n" "$bad_tag" "$tag_ref" >expected &&
6:  6d613d88ac ! 6:  797c8d3a87 mktag tests: test fast-export
    @@ t/t3800-mktag.sh: check_verify_failure () {
      	'
     +
     +	test_expect_success "fast-export & fast-import: $subject" '
    ++		# Make sure the earlier test created it for us
    ++		git rev-parse "$bad_tag" &&
    ++
     +		test_must_fail git -C bad-tag fast-export --all &&
    -+		test_must_fail git -C bad-tag fast-export $bad_tag
    ++		test_must_fail git -C bad-tag fast-export "$bad_tag"
     +	'
      }
      
-- 
2.32.0.571.gdba276db2c

