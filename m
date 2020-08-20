Return-Path: <SRS0=wu5b=B6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E9C7C433E1
	for <git@archiver.kernel.org>; Thu, 20 Aug 2020 12:36:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FA64207DA
	for <git@archiver.kernel.org>; Thu, 20 Aug 2020 12:36:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aqe/9U6G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729636AbgHTMgS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Aug 2020 08:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729825AbgHTMfs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Aug 2020 08:35:48 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8231BC061386
        for <git@vger.kernel.org>; Thu, 20 Aug 2020 05:35:48 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id h2so986888plr.0
        for <git@vger.kernel.org>; Thu, 20 Aug 2020 05:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AKr/97na+EB4luwUGRe7GMnfb/YEd37jPr3sjMgpesA=;
        b=aqe/9U6Gxuf0Ix7vjFiER/LsLsWAMZxU6ZjnP172QqLkw7xWqvURdaBAehZ7mVWROq
         c3+WJiWWNr3beNKMzfc1PTLbe0q9FQLTDy3rdFkgEFXwCcq/lCb69xfRn8Mn+4bsJQcL
         Ni/18kltVkOnei6LDsYS3PMnw4qthgLEoqaRhcn69vkamLpVYOdZrbT2qBH0W5MPTopi
         OOQt3xiITmgQSGYXW+/6PydA0b8YBsqr9fI9/SPR5gsF1aN+BiCdHOT+aE/HhMwohir0
         gF+zcIJiUf93D0RhvJNqgbxiS6kfKTe/t2BeBr+kH93eV1PXf1PjxMJX9Nu5L2P1frDA
         i+Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AKr/97na+EB4luwUGRe7GMnfb/YEd37jPr3sjMgpesA=;
        b=HJ+mAvsuI7CuXbgQrtsXwRYFVKbAxvvsfvEhsBvamo2hYTVjslGYtW+BGTC9DxHbOi
         BRJ4OP2H+AUO6vKajjFwhIry1KL3I3wqmrTpH5Lk6SJC3ztnenby0+zd9cxm41fLJS1l
         qrX78maKivIbI+1V+fsxzhHd770OQHvTo2bfvcQ/YDLnZwE/YpWFugP57pKIDnHwozVP
         n18hqP3xFS3BRhxQMezL5yrYkA8x+VUamaZfS+jgXwiJx/IyndJsW7TbUzX8DS6tMhaR
         BiqPDQX+m+oAzhYANPYiJBULpMOSg+4VrdHGXGFjDFRZl9ts4eFS0QLCS2wlpiviTY4E
         v9tQ==
X-Gm-Message-State: AOAM532d0xkQsX0iG90l9Rmt8ZRslPPA2hPy/KNYUUhBxUxEzAyv8y1h
        5SHrZWkYFIqWzeVR+EZapoiXyA4JFaI=
X-Google-Smtp-Source: ABdhPJy9HjBczRev3z4BU4UZvmxVaTDE0lt1a0akzGQsBzVbQC8RzQrrwYjQ6cFVMbMekqJTKFwk6A==
X-Received: by 2002:a17:902:b782:: with SMTP id e2mr2521238pls.268.1597926946332;
        Thu, 20 Aug 2020 05:35:46 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:63a8:cb7a:1eb1:40a4:f50c:706e])
        by smtp.gmail.com with ESMTPSA id h5sm3171054pfk.0.2020.08.20.05.35.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Aug 2020 05:35:45 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH v4 1/2] t4013: improve diff-post-processor logic
Date:   Thu, 20 Aug 2020 19:35:34 +0700
Message-Id: <a52d0e59ecd5777f2a1d242a37c6bb6aaafb1ed2.1597926783.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.28.0.143.g760df7782d.dirty
In-Reply-To: <cover.1597926783.git.congdanhqx@gmail.com>
References: <cover.1596887883.git.congdanhqx@gmail.com> <cover.1597926783.git.congdanhqx@gmail.com>
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
special for not-exist objects, in consequence, we could't catch
possible future bugs where object names is all-zeros including but
not limiting to:
* show intend-to-add entry
* deleted entry
* diff between index and working tree with new file

In addition, in the incoming change, we would like to test for
diff with 10 characters index, which is also not covered by current
diff-processor logic.

Let's fix the bug for all-zero object names and extend object names'
abbrev to 16 while we're at it.

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

