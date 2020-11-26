Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 244DAC56202
	for <git@archiver.kernel.org>; Thu, 26 Nov 2020 01:29:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0E1921534
	for <git@archiver.kernel.org>; Thu, 26 Nov 2020 01:29:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DpMVOcmu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731593AbgKZB3A (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Nov 2020 20:29:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730060AbgKZB3A (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Nov 2020 20:29:00 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B17C061A55
        for <git@vger.kernel.org>; Wed, 25 Nov 2020 17:28:58 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id k14so360720wrn.1
        for <git@vger.kernel.org>; Wed, 25 Nov 2020 17:28:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BxwvCQpQR9kZ2d4EygUbR8XMvsShs0mqNtCF1qLhut8=;
        b=DpMVOcmuHt5KneMel9HBABXLowHmXfcoCyeZJODNR4mo4EaTV8HocAApGBQ5OHemR/
         5RXaWUy9DQ3KPJapXt9uOASAcqq1kR9BPWpb+icZGUeFb+Ips+HVwUGOFfmCNuLS2v7X
         +aTkhg3vCMAV+lr8qjl9XmTBicXIQKMkuaLKRjPSA3umDRqR1h4NHI++EWB7gESHc8ah
         IfWYuUc3IOQdnc34kAjPLJAzLDEz3e40BhkcUkn0WD921Fveb6NgGQHefJi8pNgkhMID
         XOAWGjpTtT0tvttpnGLOwn3ZZnJ0nfy1uANVVM0ogJ/NFpJMPlc3drkpMbLKiLGuPL8Y
         Dn8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BxwvCQpQR9kZ2d4EygUbR8XMvsShs0mqNtCF1qLhut8=;
        b=QJhScDV7OV+ewWFf/5Hk8PwzWaG5KItkhhRkgvSEb5/ehqYmhVd59xxlvEYwMl8w4h
         N0pZn54T64cw7/yxCSPtr2ENtsKosFWUma6/CnBDKt4OgjO7qFLoxdTnZbAbMY6QGofa
         P1JvIULs2WyAjYp276eiaiPv3FP8c1wXD9AfGexmiNYLwtzftVHmdvyL0NHWizmbjeVS
         A8I8WmEed8NDOOMU8b5AlVNpxx8lzT7O9+Lj+rZoQwGTy19smBK/6Ig3fyKigxjY8T/y
         TAXQoB2Qn2hGpMADxC2IbhYpOHYs/JLKmjZhKhVK0EqF9pLNdmvEvktcGNOUk9yMxmVV
         1AOQ==
X-Gm-Message-State: AOAM53278gchBcUkBkEkGLdlyAsQlFDAyPrIja4C7IBP4Q6axO6uvMYP
        +4uM6kf8/3vYuaF7+okHQ1y5FQH1IdE4BA==
X-Google-Smtp-Source: ABdhPJxA+AjlxEby/XBhMnfELv1KX0Lp83dWoez8oKb2ET2iMeYPZYjqf8UxgJMKM7G4VFTScKsg/g==
X-Received: by 2002:a05:6000:10cd:: with SMTP id b13mr728052wrx.220.1606354137407;
        Wed, 25 Nov 2020 17:28:57 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q12sm6402523wmc.45.2020.11.25.17.28.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 17:28:56 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC/PATCH 00/12] make "mktag" use fsck_tag()
Date:   Thu, 26 Nov 2020 02:28:42 +0100
Message-Id: <20201126012854.399-1-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <X7wq3ba3QoxjyyrQ@coredump.intra.peff.net>
References: <X7wq3ba3QoxjyyrQ@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a replacement for my earlier one-off SHA-1->SHA-256 cleanup
patch, on the basis of Jeff's comment that we should just be using
fsck_tag().

I was pretty much ready to send this as a non-RFC, but as seen in
12/12 fully duplicating the mktag logic in the context of using
fsck_tag() is a bit tricker than it looks. That breakage was only
revealed by a test I added while writing this.

The result is still nicer than the current code, but even then this
series breaks the tests mid-way through (in "improve verify_object()
test coverage"), but fixes them in 12/12.

I ran out of time to make this more sensible, but wanted to send an
RFC with the current state, and in case anyone else has any better
ideas for how to deal with 12/12. This could be applied as a non-RFC
by squashing 12/12 into the "use fsck instead of custom verify_tag"
change.

Ævar Arnfjörð Bjarmason (12):
  mktag: use default strbuf_read() hint
  mktag: reword write_object_file() error
  mktag: remove redundant braces in one-line body "if"
  mktag tests: don't needlessly use a subshell
  mktag tests: remove needless SHA-1 hardcoding
  mktag tests: improve verify_object() test coverage
  fsck: add new "extra" checks for "mktag"
  mktag: use fsck instead of custom verify_tag()
  mktag: remove now-unused verify_tag() code
  mktag doc: update to explain why to use this
  mktag docs: say <hash> not <sha1>
  mktag: bring back some of the verify_object() logic

 Documentation/git-hash-object.txt |   4 +
 Documentation/git-mktag.txt       |  31 ++++-
 builtin/mktag.c                   | 207 ++++++++++--------------------
 fsck.c                            |  32 ++++-
 fsck.h                            |   2 +
 t/t1006-cat-file.sh               |   2 +-
 t/t3800-mktag.sh                  | 103 ++++++++++-----
 7 files changed, 202 insertions(+), 179 deletions(-)

-- 
2.29.2.222.g5d2a92d10f8

