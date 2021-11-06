Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FECAC433F5
	for <git@archiver.kernel.org>; Sat,  6 Nov 2021 21:47:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27AAF6103E
	for <git@archiver.kernel.org>; Sat,  6 Nov 2021 21:47:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233748AbhKFVtt (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Nov 2021 17:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231367AbhKFVts (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Nov 2021 17:49:48 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 169C7C061570
        for <git@vger.kernel.org>; Sat,  6 Nov 2021 14:47:07 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id d5so19646029wrc.1
        for <git@vger.kernel.org>; Sat, 06 Nov 2021 14:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/p2Oazxs3/MssrwgrmhTrgMEYAcDmJKMl2mUyQvSz8o=;
        b=ivJOwnMeUQ/IyCpaZgpdaRYlgKCaNk/A+u8wzVe6RSVtJdrHHv4bjtkyPbLYmJhv0w
         rlwzF+TwP4NYJzBtdAQrWCIhV0pm8Ur0dSo5r0RsXznVrT8mx6sVR0XOrdR61sjQlczY
         pfT2NyvnKt4I+EIOzY0nIjWmzXaAay8N8qqF55ogZDY1agxSLe04yCa4DGcUEto+LXOx
         Q5QfTdyGceHXnUyw2lP/pYEq+yihjtOdkXaAkBbO+WfAL5PJzxMjMdfi50oZaXboBCZs
         yLg5xtLRebRfXmPh7cAUrXOMGWngadxiVHEISF7v2insCdpCPqOMLst6j/1yCtdnE8iP
         imFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/p2Oazxs3/MssrwgrmhTrgMEYAcDmJKMl2mUyQvSz8o=;
        b=xWquBGfiQDVgp52hZ8l4naNCF2QSmwIbJoATSY0QP5tD2PWyWwPxbfdgllxp/9/idC
         tc2gryqQPGq8Vm0kerxEnaOJsscDxPRKh2LlIm0rZZ2VVaAPzgiM64fYhTg8rggcG5Yi
         elijQQ0gLCESlW16TArJH3tqSD0fbZrMgQAqmcnGuCP8I46vbO1VMUAfyHLZZRbYR3P4
         84zjlmKANpB8Phf1f9udGwkK9MdyfZeC0dZ24vcnGGffnO5Q18DDzJmqyLzb+idpfikr
         a+dhkz8xm1Mp9f+5RU4mu67PujNQVgbqNYkQuBayvqr+6VooQIX4CQqkTN2tw0ZO82Tv
         JCMw==
X-Gm-Message-State: AOAM532pduRwDaj/vmTaveA5YpxO8JPdMuepxHpvh793/9VHVf3fSTQX
        S0G1xUgv3Ibi3kzFMkjN5NKwYZMqgGTYwg==
X-Google-Smtp-Source: ABdhPJzN8MdyOxcyF/T2fjIB8TdC2b8TNhtr3lnuZVN6wU1g8/ukr12PYXexFNso7poHSW7AT45DLw==
X-Received: by 2002:adf:f6cf:: with SMTP id y15mr39665635wrp.56.1636235225462;
        Sat, 06 Nov 2021 14:47:05 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f19sm12736630wmq.34.2021.11.06.14.47.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Nov 2021 14:47:05 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        John Cai <johncai86@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 01/10] cat-file tests: test bad usage
Date:   Sat,  6 Nov 2021 22:46:53 +0100
Message-Id: <patch-01.10-c8040da8e55-20211106T214259Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.rc1.741.gab7bfd97031
In-Reply-To: <cover-00.10-00000000000-20211106T214259Z-avarab@gmail.com>
References: <xmqqlf33i36a.fsf@gitster.g> <cover-00.10-00000000000-20211106T214259Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stress test the usage emitted when options are combined in ways that
isn't supported. Let's test various option combinations, some of these
we buggily allow right now.

E.g. this reveals a bug in 321459439e1 (cat-file: support
--textconv/--filters in batch mode, 2016-09-09) that we'll fix in a
subsequent commit. We're supposed to be emitting a relevant message
when --batch-all-objects is combined with --textconv or --filters, but
we don't.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t1006-cat-file.sh | 90 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index 658628375c8..0ad00e1fe73 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -4,6 +4,96 @@ test_description='git cat-file'
 
 . ./test-lib.sh
 
+test_cmdmode_usage() {
+	test_expect_code 129 "$@" 2>err &&
+	grep "^error:.*is incompatible with" err
+}
+
+test_expect_success 'usage: cmdmode' '
+	test_cmdmode_usage git cat-file -e -p &&
+	test_cmdmode_usage git cat-file -p -t &&
+	test_cmdmode_usage git cat-file -t -s &&
+	test_cmdmode_usage git cat-file -s --textconv &&
+	test_cmdmode_usage git cat-file --textconv --filters
+'
+
+test_incompatible_usage() {
+	test_expect_code 129 "$@" 2>err &&
+	grep -E "^error:.*$switch.*needs" err
+}
+
+for opt in --batch --batch-check
+do
+	test_expect_success "usage: incompatible options: --path with $opt" '
+		test_incompatible_usage git cat-file --path=foo $opt
+	'
+done
+
+short_modes="-e -p -t -s"
+cw_modes="--textconv --filters"
+
+for opt in $cw_modes
+do
+	test_expect_success "usage: $opt requires another option" '
+		test_expect_code 129 git cat-file $opt
+	'
+
+	test_expect_failure "usage: incompatible options: --batch-all-objects with $opt" '
+		test_incompatible_usage git cat-file --batch-all-objects $opt
+	'
+done
+
+for opt in $short_modes
+do
+	test_expect_success "usage: $opt requires another option" '
+		test_expect_code 129 git cat-file $opt
+	'
+
+	for opt2 in --batch \
+		--batch-check \
+		--follow-symlinks
+	do
+		test_expect_failure "usage: incompatible options: $opt and $opt2" '
+			test_incompatible_usage git cat-file $opt $opt2
+		'
+	done
+
+	opt2="--path=foo HEAD:some-path.txt"
+	test_expect_success "usage: incompatible options: $opt and $opt2" '
+		test_incompatible_usage git cat-file $opt $opt2
+	'
+done
+
+for opt in $short_modes $cw_modes
+do
+	args="one two three"
+	test_expect_success "usage: too many arguments: $opt $args" '
+		test_expect_code 129 git cat-file $opt $args
+	'
+
+	for opt2 in --buffer --follow-symlinks
+	do
+		test_expect_success "usage: incompatible arguments: $opt with batch option $opt2" '
+			test_expect_code 129 git cat-file $opt $opt2
+		'
+	done
+done
+
+for opt in --buffer \
+	--follow-symlinks \
+	--batch-all-objects
+do
+	status=success
+	if test $opt = "--buffer"
+	then
+		status=failure
+	fi
+	test_expect_$status "usage: bad option combination: $opt without batch mode" '
+		test_expect_code 129 git cat-file $opt &&
+		test_expect_code 129 git cat-file $opt commit HEAD
+	'
+done
+
 echo_without_newline () {
     printf '%s' "$*"
 }
-- 
2.34.0.rc1.741.gab7bfd97031

