Return-Path: <SRS0=jbtA=B7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCA63C433E3
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 11:54:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A55F720732
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 11:54:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mGunaVun"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728449AbgHULyV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Aug 2020 07:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726803AbgHULwm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Aug 2020 07:52:42 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B961CC061343
        for <git@vger.kernel.org>; Fri, 21 Aug 2020 04:52:00 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id j21so886303pgi.9
        for <git@vger.kernel.org>; Fri, 21 Aug 2020 04:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7TxxN4sFutC4n7qwOG7ZDTYmhBJZYpaLLAuT1rkrSUs=;
        b=mGunaVunV50VgB6UzaeE5JWnPS36WzCzWg0yLap/5ctN/RVYI4AncemDVKmRTX2spp
         yCy9gR6GzXKnykYj6LCjuZstXF+HIR0+dSgywjXkcAY61FJHgw8Oo3tQzsOZLFgkLN5d
         G6pYkO6ke09+ebt27R3biHmac7muAmDTb8/6XdOxGUR6KKzqMU63Ombe6rpUNwa8pHXG
         +cWBcxZ/5QLyxsGuGPomdKz6FBCKtN7MtwIckhFq0bCcwIdXauMpaciOPaIyDcQeIgWN
         d2wMhvIyb0xJXFWx3WsWKnCN4DL1Hmbq2tKaZ4IhJdlDSUuyVLuQ8F6cmh85lkK0A7gJ
         fFxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7TxxN4sFutC4n7qwOG7ZDTYmhBJZYpaLLAuT1rkrSUs=;
        b=sv2GS9oqmbtvzQ2gSU4NI03vx93+j3JE634YMndmU0y/5PznDsK/ww+zjCKwdFw0EP
         uAsnyYoJPTyh0JVsEU+3QhF3NjDjKFONjefias/2EUmlyWDDbHvj+Np9/dBoQvSNtz94
         rCEVApppCULH2BYeKpbQBC4gsPFMPNiXTAB+S/1xNej6SL5C7W04svWsaovPHbi+BdE4
         4aQknEgpACdSGaFMbs1mqyGWzaUMUOlAmtgGlqOfE/9Tcvb3X8jTh/dOq/aOX5xvuHXd
         YxnEp6YOFdkYxBaNJdC0WGYf+5wpSCHWRk+qId01hVixOSFGYMrgLjucmabinxaflfx+
         u2og==
X-Gm-Message-State: AOAM530tyaxCeSMdkXqeMsZq1d8L9Shq+PvoiTo1rZTUT170xAZGP9+C
        Q2/OxC/s56CTxxoOlmFjnTD5dVSV830=
X-Google-Smtp-Source: ABdhPJzOVz7uchTr8kIbqqPUuJgsN0YJ60SC4Nl2tDsMuOKzJ0mz4UKZrhxxJY9CqYn8zkfAt8EWig==
X-Received: by 2002:a63:d10a:: with SMTP id k10mr2047977pgg.382.1598010720028;
        Fri, 21 Aug 2020 04:52:00 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:63a8:cb7a:1eb1:40a4:f50c:706e])
        by smtp.gmail.com with ESMTPSA id y1sm2300413pfl.136.2020.08.21.04.51.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Aug 2020 04:51:59 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH v5 1/2] t4013: improve diff-post-processor logic
Date:   Fri, 21 Aug 2020 18:51:46 +0700
Message-Id: <d7e0f13ebaeae0545b74a64f13171ea85cc26d18.1598010556.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.28.0.143.g760df7782d.dirty
In-Reply-To: <cover.1598010556.git.congdanhqx@gmail.com>
References: <cover.1596887883.git.congdanhqx@gmail.com> <cover.1598010556.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "brian m. carlson" <sandals@crustytoothpaste.net>

From 72f936b1 (t4013: make test hash independent, 2020-02-07),
we started to adjust metadata of git-diff's output in order to
ignore uninteresting metadata which is dependent of underlying hash
algorithm.

However, we forgot to special case all-zero object names, which is
special for missing objects, in consequence, we could't catch
possible future bugs where object names is all-zeros including but
not limited to:
* show intend-to-add entry
* deleted entry
* diff between index and working tree with new file

We also mistakenly munged file-modes as if they were object names
abbreviated to 6 hexadecimal digits.

In addition, in the upcoming change, we would like to test for
customizing the length of abbreviated blob objects on the index line,
which is not supported by current diff-processor logic.

Let's fix the bug for all-zero object names, and file modes.
While we're at it, support abbreviation of object names up to 16 bytes.

Based-on-patch-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 t/t4013-diff-various.sh | 60 ++++++++++++++++++++++++++---------------
 1 file changed, 39 insertions(+), 21 deletions(-)

diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index 5f97dd6d65..f6bdfc13fd 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -130,27 +130,45 @@ test_expect_success setup '
 EOF
 
 process_diffs () {
-	_x04="[0-9a-f][0-9a-f][0-9a-f][0-9a-f]" &&
-	_x07="$_x05[0-9a-f][0-9a-f]" &&
-	sed -e "s/$OID_REGEX/$ZERO_OID/g" \
-	    -e "s/From $_x40 /From $ZERO_OID /" \
-	    -e "s/from $_x40)/from $ZERO_OID)/" \
-	    -e "s/commit $_x40\$/commit $ZERO_OID/" \
-	    -e "s/commit $_x40 (/commit $ZERO_OID (/" \
-	    -e "s/$_x40 $_x40 $_x40/$ZERO_OID $ZERO_OID $ZERO_OID/" \
-	    -e "s/$_x40 $_x40 /$ZERO_OID $ZERO_OID /" \
-	    -e "s/^$_x40 $_x40$/$ZERO_OID $ZERO_OID/" \
-	    -e "s/^$_x40 /$ZERO_OID /" \
-	    -e "s/^$_x40$/$ZERO_OID/" \
-	    -e "s/$_x07\.\.$_x07/fffffff..fffffff/g" \
-	    -e "s/$_x07,$_x07\.\.$_x07/fffffff,fffffff..fffffff/g" \
-	    -e "s/$_x07 $_x07 $_x07/fffffff fffffff fffffff/g" \
-	    -e "s/$_x07 $_x07 /fffffff fffffff /g" \
-	    -e "s/Merge: $_x07 $_x07/Merge: fffffff fffffff/g" \
-	    -e "s/$_x07\.\.\./fffffff.../g" \
-	    -e "s/ $_x04\.\.\./ ffff.../g" \
-	    -e "s/ $_x04/ ffff/g" \
-	    "$1"
+	perl -e '
+		my $oid_length = length($ARGV[0]);
+		my $x40 = "[0-9a-f]{40}";
+		my $xab = "[0-9a-f]{4,16}";
+		my $orx = "[0-9a-f]" x $oid_length;
+
+		sub munge_oid {
+			my ($oid) = @_;
+			my $x;
+
+			return "" unless length $oid;
+
+			if ($oid =~ /^(100644|100755|120000)$/) {
+				return $oid;
+			}
+
+			if ($oid =~ /^0*$/) {
+				$x = "0";
+			} else {
+				$x = "f";
+			}
+
+			if (length($oid) == 40) {
+				return $x x $oid_length;
+			} else {
+				return $x x length($oid);
+			}
+		}
+
+		while (<STDIN>) {
+			s/($orx)/munge_oid($1)/ge;
+			s/From ($x40)( |\))/"From " . munge_oid($1) . $2/ge;
+			s/commit ($x40)($| \(from )($x40?)/"commit " .  munge_oid($1) . $2 . munge_oid($3)/ge;
+			s/\b($x40)( |\.\.|$)/munge_oid($1) . $2/ge;
+			s/^($x40)($| )/munge_oid($1) . $2/e;
+			s/($xab)(\.\.|,| |\.\.\.|$)/munge_oid($1) . $2/ge;
+			print;
+		}
+	' "$ZERO_OID" <"$1"
 }
 
 V=$(git version | sed -e 's/^git version //' -e 's/\./\\./g')
-- 
2.28.0.143.g760df7782d.dirty

