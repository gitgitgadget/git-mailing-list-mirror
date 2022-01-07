Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D710C433EF
	for <git@archiver.kernel.org>; Fri,  7 Jan 2022 11:17:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347031AbiAGLRh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Jan 2022 06:17:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347025AbiAGLRg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jan 2022 06:17:36 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A792DC061201
        for <git@vger.kernel.org>; Fri,  7 Jan 2022 03:17:35 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id w20so10409527wra.9
        for <git@vger.kernel.org>; Fri, 07 Jan 2022 03:17:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6z1Q5jEGgesuCwTdsI4k2HVHA/Z/Z81SrOXimYCnySA=;
        b=PfkfDHN+ytLS2L6jciHE0S6p0pHnwMxMgFJNDuUPn93q8BPGLm1CsWZfCGQ3SQWBU9
         7PrvFVfDthL5ehLPtgdum+88CoD8SPqUWBN4Xl2bZnVYI4HVKMp/WVt9kQvQoEhHw+RV
         K5PWQNm1M1tjgmfhgGTd/ycoSwwvEkXMYSR5OiCdL8SyCyv7laLRx6GGSLtm+albICnF
         iZRGGOBw1Pk7y29V6INZfeb0aU2FW5nPBUNXuGKcw8RQmiLvaltyF3YuR8s2AwLcsfkl
         kxOefZ9BExEYG+S8F43HPfC3Lsk6wggqjtfQUp3E46LnW7R4657LOZTK0mNmLMuVimjg
         uT/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=6z1Q5jEGgesuCwTdsI4k2HVHA/Z/Z81SrOXimYCnySA=;
        b=4iUT3FrV2M+sNtfAgXZpZi2PksOIRJVjPqOoscCv7QUtVgVhNUpL0+i0ED7BNRyS9L
         mftqEvyzp/fpwNUsHSseYaMNaS93W/FkdVJwVMtVTiAaOQSoLFRLuB1RK9WgOqfNTuDC
         saAJxAFe5RLbQkA+OoTlpycKZFQ/LyDL+0g7CsrRlJjpNX9sSS3PXF7CGJJgD5iQkZud
         mcaO4k72ovd0zkmt/Z79TiZg1VDJ/qaREdawVtnEtx+FhNhX7w7ajt+Q44k7F8WcunYK
         cbzZkcRgfysNwhXSqacjpqDw80PNVd4C1gpOiEftfqoDNM2tlS0NOD3pkBI3iFsZ7uuW
         0VUg==
X-Gm-Message-State: AOAM532wkolNfqDvwUyK+xONaa4QEI0LBT5IxF68oZI71cZPmVRAVEIG
        VGu9PegZSCSxozvtuOkep2vO+qIr+9E=
X-Google-Smtp-Source: ABdhPJy30UBc33mkBk86/1BICEDgJ6aAOzFpjBWPU7Jn8MJ0b8XWPmCqnGPF0Tc03RK2LF2wwuVBrw==
X-Received: by 2002:a05:6000:1563:: with SMTP id 3mr54645815wrz.372.1641554254141;
        Fri, 07 Jan 2022 03:17:34 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d5sm4433687wrs.61.2022.01.07.03.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 03:17:33 -0800 (PST)
Message-Id: <37c11bfafc4c5675124db81cdd61fcb3e8c91ab2.1641554252.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1105.v4.git.1641554252.gitgitgadget@gmail.com>
References: <pull.1105.v3.git.1641508499.gitgitgadget@gmail.com>
        <pull.1105.v4.git.1641554252.gitgitgadget@gmail.com>
From:   "Marc Strapetz via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 07 Jan 2022 11:17:28 +0000
Subject: [PATCH v4 1/4] test-lib: introduce API for verifying file mtime
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Marc Strapetz <marc.strapetz@syntevo.com>,
        Marc Strapetz <marc.strapetz@syntevo.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Marc Strapetz <marc.strapetz@syntevo.com>

Add functions `test_set_magic_mtime` and `test_is_magic_mtime` which can
be used to (re)set the mtime of a file to a predefined ("magic")
timestamp, then perform some operations and finally check for mtime
changes of the file.

The core implementation follows the suggestion from the
mailing list [1].

[1] https://lore.kernel.org/git/xmqqczl5hpaq.fsf@gitster.g/T/#u

Signed-off-by: Marc Strapetz <marc.strapetz@syntevo.com>
---
 t/test-lib-functions.sh | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 389153e5916..c1afa0884bf 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1806,3 +1806,36 @@ test_region () {
 test_readlink () {
 	perl -le 'print readlink($_) for @ARGV' "$@"
 }
+
+# Set mtime to a fixed "magic" timestamp in mid February 2009, before we
+# run an operation that may or may not touch the file.  If the file was
+# touched, its timestamp will not accidentally have such an old timestamp,
+# as long as your filesystem clock is reasonably correct.  To verify the
+# timestamp, follow up with test_is_magic_mtime.
+#
+# An optional increment to the magic timestamp may be specified as second
+# argument.
+test_set_magic_mtime () {
+	local inc=${2:-0} &&
+	local mtime=$((1234567890 + $inc)) &&
+	test-tool chmtime =$mtime "$1" &&
+	test_is_magic_mtime "$1" $inc
+}
+
+# Test whether the given file has the "magic" mtime set.  This is meant to
+# be used in combination with test_set_magic_mtime.
+#
+# An optional increment to the magic timestamp may be specified as second
+# argument.  Usually, this should be the same increment which was used for
+# the associated test_set_magic_mtime.
+test_is_magic_mtime () {
+	local inc=${2:-0} &&
+	local mtime=$((1234567890 + $inc)) &&
+	echo $mtime >.git/test-mtime-expect &&
+	test-tool chmtime --get "$1" >.git/test-mtime-actual &&
+	test_cmp .git/test-mtime-expect .git/test-mtime-actual
+	local ret=$?
+	rm -f .git/test-mtime-expect
+	rm -f .git/test-mtime-actual
+	return $ret
+}
-- 
gitgitgadget

