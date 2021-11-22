Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7726C433F5
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 17:53:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239529AbhKVR4p (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 12:56:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239635AbhKVR4h (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 12:56:37 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E3EC06174A
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 09:53:29 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id i5so34286980wrb.2
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 09:53:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f36JRP1xQ66Wofs4YCgG2Er+ifKhS2Cn1MiIiKgLtqI=;
        b=AfzYCcwdG/ie9y5S39yVmLURGFdAend0oW1pVshxyjS5R09A9N3DRhpW8A1A9IFpmN
         w1HBqBAvEZmkxmIQ4UUjlQ3fIMpjis/PEgq4Bw1hL9PbtNDAD5FMbwQFj2hV5UyN6FhC
         1DFBLbjVxFJudt8kSHOkcl3SAE5zBaGcKxIFyiYzLwU0G+L9YABpvz8++M+6gViwCJuS
         k+1C+Ut1z8SY13Nx5Afb02b1Zy8+j9vllN2YZzYaOffEutcjEhb3H/bJzInbUy+JIPX0
         cplCLn9N6LPCUM1+GfhcQAv9V82XUUsf3IvMGOCRzNzng+PXT38bgm3aoCx5aQ4HarDJ
         u+Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f36JRP1xQ66Wofs4YCgG2Er+ifKhS2Cn1MiIiKgLtqI=;
        b=w2f+wjMvJRcwxtLhD2dVZF0MSAIgKDVAjlW4ZClCMDq3KUMx8BhsstzsAn1DG1M7Zo
         pHbxlpCnPZzQ4Sf1WkMGnqkcqgJRdssXKVOtp92B0Ss6uHiTG+kQxDlLF7GGYUgpkoNI
         mrCaCRpgM1xD/Uy7/aJZ1w51hKHxnBAvHlQa90jYyE9bQvBL2tgdXNdlCFj27mBAzhGi
         l2A8q1qxExoJTjnL2wovgowIMdbVoz57GHYIR+ZqoP8N9xNQgCQxL2qou5t6zANLjjvo
         Sk8tLp77iTpQXInydOeKFA5qrqqENcWMIaUy+9RbfES4h77YRx+SZvXpYxdZ2nSW8/ZU
         vpdg==
X-Gm-Message-State: AOAM532PqQJI6Ycd4BxRkgcMotMVLWtjy3KzVNNGbkWQVDmr6E17RWfd
        TbYVRhsPtYM53V0zzxmkSyLDpG1OuN8noQ==
X-Google-Smtp-Source: ABdhPJyEEY1chEUuYxvXYBrjcqx0gPda4GevA0uZxR6XuKxQunyp/p22PBme0O0UyrQYD6AOxeiknQ==
X-Received: by 2002:a5d:59a2:: with SMTP id p2mr41780522wrr.252.1637603607384;
        Mon, 22 Nov 2021 09:53:27 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l11sm9531664wrp.61.2021.11.22.09.53.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 09:53:26 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 0/3] object-name: make ambiguous object output translatable + show tag date
Date:   Mon, 22 Nov 2021 18:53:22 +0100
Message-Id: <cover-v4-0.3-00000000000-20211122T175219Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.822.gc64b680fd55
In-Reply-To: <cover-v3-0.3-00000000000-20211008T193041Z-avarab@gmail.com>
References: <cover-v3-0.3-00000000000-20211008T193041Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This topic improves the output we emit on ambiguous objects as noted
in 3/3, and makes it translatable. See [3] for v3.

The only changes since v3 are minor commit message improvements
spotted while re-rolling this. I think revewers were happy with it in
v3, but it fell through the cracks.

1. https://lore.kernel.org/git/cover-v3-0.3-00000000000-20211008T193041Z-avarab@gmail.com/

Ævar Arnfjörð Bjarmason (3):
  object-name: remove unreachable "unknown type" handling
  object-name: make ambiguous object output translatable
  object-name: show date for ambiguous tag objects

 object-name.c | 68 +++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 61 insertions(+), 7 deletions(-)

Range-diff against v3:
1:  fb29e10ee35 ! 1:  2e7090c09f9 object-name: remove unreachable "unknown type" handling
    @@ Metadata
      ## Commit message ##
         object-name: remove unreachable "unknown type" handling
     
    -    Remove the "unknown type" handling when displaying the ambiguous
    -    object list. See [1] for the current output, and [1] for the commit
    -    that added the "unknown type" handling.
    +    Remove unreachable "unknown type" handling in the code that displays
    +    the ambiguous object list. See [1] for the current output, and [1] for
    +    the commit that added the "unknown type" handling.
     
         The reason this code wasn't reachable is because we're not passing in
    -    OBJECT_INFO_ALLOW_UNKNOWN_TYPE, so we'll just die in sort_ambiguous()
    +    OBJECT_INFO_ALLOW_UNKNOWN_TYPE, so we'll die in sort_ambiguous()
         before we get to show_ambiguous_object():
     
             $ git rev-parse 8315
2:  587a5717e47 ! 2:  00d84faeb1d object-name: make ambiguous object output translatable
    @@ Commit message
     
         Change the output of show_ambiguous_object() added in [1] and last
         tweaked in [2] and the preceding commit to be more friendly to
    -    translators. By being able to customize the "<SP><SP>%s\n" format
    -    we're even ready for RTL languages, who'd presumably like to change
    -    that to "%s<SP><SP>\n".
    +    translators.
    +
    +    By being able to customize the "<SP><SP>%s\n" format we're even ready
    +    for RTL languages, who'd presumably like to change that to
    +    "%s<SP><SP>\n".
     
         1. 1ffa26c461 (get_short_sha1: list ambiguous objects on error,
            2016-09-26)
3:  8bde4e174b7 = 3:  9d24bab635d object-name: show date for ambiguous tag objects
-- 
2.34.0.822.gc64b680fd55

