Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 283BDC433F5
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 13:37:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 024AA611C7
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 13:37:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351649AbhI3NjW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Sep 2021 09:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351502AbhI3NjO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Sep 2021 09:39:14 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C653DC06176D
        for <git@vger.kernel.org>; Thu, 30 Sep 2021 06:37:31 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id d21so10083898wra.12
        for <git@vger.kernel.org>; Thu, 30 Sep 2021 06:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qzZU389iEsX02dmEHR5Hs1z99Jc0DOl0Cwu0DEiunQc=;
        b=PInKCfBUCz9B5kUpa33XiR/BWLLRnLCcd1DvJ25MoMDQHcDZ5C24kI8ddAK/w0L05y
         d3Dw6d4/SVoyVTQ5jvB4dWD4rn1kbULr+c6QSdUYcE90mBgwQPpeDdHw2p00vwbZc/Rq
         0ByCSlKQsJJXrGfe6PN6+xWVdAGaIer8CI9FUIiICkym5ndZ+tOVpzzDlIoHgUEADAW+
         zfOqoS7FRsimsH6VwD4ohxf2CekboCxj1z2IDt0tJNGq4fGzafjhi9vlgvEF6E+K3vGN
         Gi9y2F7xpiBxp4nCk9SxZkLQmdPwRg2dHdEW/XJxo6PMsrE3CFTyofNdNlvl7ODV6ZPb
         Tqdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qzZU389iEsX02dmEHR5Hs1z99Jc0DOl0Cwu0DEiunQc=;
        b=i8aRK0gbQDm+hWkRxi00CN6G4ciRhfS91BVscyq7Ezl9LN4sova//Fww53I+ezU8bi
         riahCGFSvXN7vPGbmmkCB/+t2Rk5HTU3qx18LWG6A5kdzglitHJZH5Mr5Je7pCpw6un5
         0qyeylPKsVvIWKswnrME15mPnEhIdEo36fOFj2OdSncwa8MfnvznZXsYzXIBE4BbeUYI
         okFmDNb93bPqVn+7Q7C0Chtu5PFBCqwx77YviA59m2fkcVFlbN5lS6y0qzwiK3bn/W3A
         jmnnH19n1cvVpWBIC+/suiO4HwxkGFZ3Xfg43VsLgKO7W4Yrae2HzhC2w+wdkTuH5qvV
         SQMg==
X-Gm-Message-State: AOAM532I7l+2pyPOrqlmsB8iYJfHOBD/pVv94qfojfnwhgeP2GSrsg//
        EDgdJXKyLa87gIu+bp/exaq0O83pgGvDtzuc
X-Google-Smtp-Source: ABdhPJzgvNhTyOsH0tzcAtl81OVY9DxG7lsANjCYYHz8+BbbhgZxIwSexuVz4BUIUl4SrRRquScYfw==
X-Received: by 2002:a5d:67cc:: with SMTP id n12mr6069930wrw.381.1633009050150;
        Thu, 30 Sep 2021 06:37:30 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o11sm4654713wmh.11.2021.09.30.06.37.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 06:37:29 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v9 04/17] fsck tests: test for garbage appended to a loose object
Date:   Thu, 30 Sep 2021 15:37:09 +0200
Message-Id: <patch-v9-04.17-ff7fc09d5a1-20210930T133300Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1374.g05459a61530
In-Reply-To: <cover-v9-00.17-00000000000-20210930T133300Z-avarab@gmail.com>
References: <cover-v8-00.17-00000000000-20210928T021616Z-avarab@gmail.com> <cover-v9-00.17-00000000000-20210930T133300Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There wasn't any output tests for this scenario, let's ensure that we
don't regress on it in the changes that come after this.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t1450-fsck.sh | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index 175ed304637..bd696d21dba 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -93,6 +93,26 @@ test_expect_success 'object with hash and type mismatch' '
 	)
 '
 
+test_expect_success POSIXPERM 'zlib corrupt loose object output ' '
+	git init --bare corrupt-loose-output &&
+	(
+		cd corrupt-loose-output &&
+		oid=$(git hash-object -w --stdin --literally </dev/null) &&
+		oidf=objects/$(test_oid_to_path "$oid") &&
+		chmod 755 $oidf &&
+		echo extra garbage >>$oidf &&
+
+		cat >expect.error <<-EOF &&
+		error: garbage at end of loose object '\''$oid'\''
+		error: unable to unpack contents of ./$oidf
+		error: $oid: object corrupt or missing: ./$oidf
+		EOF
+		test_must_fail git fsck 2>actual &&
+		grep ^error: actual >error &&
+		test_cmp expect.error error
+	)
+'
+
 test_expect_success 'branch pointing to non-commit' '
 	git rev-parse HEAD^{tree} >.git/refs/heads/invalid &&
 	test_when_finished "git update-ref -d refs/heads/invalid" &&
-- 
2.33.0.1374.g05459a61530

