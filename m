Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6DFAC4338F
	for <git@archiver.kernel.org>; Wed, 18 Aug 2021 05:19:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99CF260F39
	for <git@archiver.kernel.org>; Wed, 18 Aug 2021 05:19:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237236AbhHRFUN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Aug 2021 01:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236287AbhHRFUM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Aug 2021 01:20:12 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35BDDC061764
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 22:19:37 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id oa17so1901100pjb.1
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 22:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qXH5v2kNauiEh7C05NobJi1qolV9IYrImwjMLsCug7c=;
        b=edPBO2Wzik4kUUefv3r5ngXbqJxgLky7P5ejFNfHS73XTY/JKBtdFTYYjez+hLJv8J
         Bmuo3BRtHUr1+FtiIZq3pNhPdr0A0ecG2muD/4jxjSkL4+Zv4xw+9LzHl6M7lPcZNbrm
         bgzfd713juPBDVzNV37PtxHC1g4tvk3/Bw8OdlzJlydONAHVs9vS2TDZxLXjImKCVC0A
         +aLPU+VxOjUpaokmQ7qZWIiblYmFmE3G3zrV4cczcnjFQqkfR2+4H5FStoIUSYGuqvFe
         ckYRe7ZB1rEitYbp7Dy1Aukxjvkeg6CXhGjIqMJlQSWBGMNOGqskQoObN3Fc1LoFJlRt
         gAfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qXH5v2kNauiEh7C05NobJi1qolV9IYrImwjMLsCug7c=;
        b=Xgdk0xxN8+44YpzQF1+aWhgGeors59/1CL/z4YfyTEQLjutaaKzyH8T3Fgv69XbPuL
         BMqwfJCo//SZk5O7JOm1tdSmNhktQavDJljmG9nsRKrS/GuiiZtTn3powy7UOSE+UUGx
         z7jshft86crpFqTSBqFFm6M6oin4Oz5PEsPVOXssMP6EIens2rr/dBuNPaDGgDPphoSz
         Qlzeq+ZCnoRMqriiEz1RAzOzmZe/fIf4LEn+7eX3AMw11UaCpY2luPAeJ8BPZ2WGfwRW
         dpU4qC9Cg6Za0h9a5i8f0zjOHio1behm9B6PZNIrFNSy3YuS9moqTHweOrTssWuRhDL3
         AGxw==
X-Gm-Message-State: AOAM532HoDzwm8Oe8aoU7wTJHFrR2doN0mhigIO237L85yejiod6aWZj
        ShfzOJVWSTIIXsgalO0FhOjhaHlTbH0=
X-Google-Smtp-Source: ABdhPJw46vg48K/wGef0n6M+QlDWzzen0EWEgb6X+f1b8jiZi/O7IYpuQOwAZ6GZ0LSTHiXv3J8hkg==
X-Received: by 2002:a17:90b:e87:: with SMTP id fv7mr7442056pjb.85.1629263976491;
        Tue, 17 Aug 2021 22:19:36 -0700 (PDT)
Received: from athena.localdomain ([2402:800:63ed:4478:964c:2b9b:388e:4b0])
        by smtp.gmail.com with ESMTPSA id g202sm4385410pfb.125.2021.08.17.22.19.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 22:19:36 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v2 0/2] t6300: clear warning when running without gpg
Date:   Wed, 18 Aug 2021 12:19:25 +0700
Message-Id: <cover.1629263759.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.33.0.rc1
In-Reply-To: <bcbde2e7364865ac16702447b863b8a725670428.1629200841.git.congdanhqx@gmail.com>
References: <bcbde2e7364865ac16702447b863b8a725670428.1629200841.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Running t6300 in an environment without gpg(1),
we'll see those warnings:

	fatal: Not a valid object name refs/tags/signed-empty
	fatal: Not a valid object name refs/tags/signed-short
	fatal: Not a valid object name refs/tags/signed-long

Because, those objects will be created only when GPG is satistified.
This series try to clean those errors.

Change from v1:
* Make 1/2 as near pure-code-move; and
* Use 2/2 as a code change to preserve status code for cat-file
* Mention reasons that 1/2 couldn't be pure-code-move.

Đoàn Trần Công Danh (2):
  t6300: don't run cat-file on non-existent object
  t6300: check for cat-file exit status code

 t/t6300-for-each-ref.sh | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

Range-diff against v1:
1:  6d36f3a8df ! 1:  b813d6f2ad t6300: don't run cat-file on non-existent object
    @@ Commit message
         * skip their execution if prerequisites aren't satistified.
         * check their exit status code
     
    +    The expected value for objects with type: commit needs to be
    +    computed outside the test because we can't relies on "$3" there.
    +    Furthermore, to prevent the accidental usage of that computed
    +    expected value, BUG out on unknown object's type.
    +
         Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
     
      ## t/t6300-for-each-ref.sh ##
    @@ t/t6300-for-each-ref.sh: test_atom() {
     -		esac
     -		# Leave $expect unquoted to lose possible leading whitespaces
     -		echo $expect >expected
    ++		# for commit leg, $3 is changed there
     +		expect=$(printf '%s' "$3" | wc -c)
      		test_expect_${4:-success} $PREREQ "basic atom: $1 contents:size" '
     +			type=$(git cat-file -t "$ref") &&
     +			case $type in
     +			tag)
     +				# We cannot use $3 as it expects sanitize_pgp to run
    -+				git cat-file tag $ref >out &&
    -+				expect=$(<out tail -n +6 | wc -c) ;;
    ++				expect=$(git cat-file tag $ref | tail -n +6 | wc -c) ;;
     +			tree | blob)
     +				expect="" ;;
     +			commit)
-:  ---------- > 2:  68ee769121 t6300: check for cat-file exit status code
-- 
2.33.0.rc1

