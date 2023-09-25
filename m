Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0E1ACE7AB1
	for <git@archiver.kernel.org>; Mon, 25 Sep 2023 17:51:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbjIYRvL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Sep 2023 13:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbjIYRvK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2023 13:51:10 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4100C10D
        for <git@vger.kernel.org>; Mon, 25 Sep 2023 10:51:04 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-274939681b5so4185688a91.0
        for <git@vger.kernel.org>; Mon, 25 Sep 2023 10:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695664263; x=1696269063; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/eSbbtCbPQe/6XbQly0bjijPUpnCPMDjF1I3qrXPvb8=;
        b=Bx+sbIA46bdFCf8ihze27KivG01vsPWwgCmUE4iP/aT2wEMxbKC1kt4qadu6BakV/l
         /7gws5y5u4EO+Rjco4KyScVrGVTKv/tE3+MNeBZuuqRfwpV1KDMrSlOcOk97HG/ytHpY
         XSWuI4v9eIuneVifkdjkR7C7hmiYm/KUiWNCSx2z0eGOoyERpC/a85QpL1fv0Mm9AXhI
         ErXEH5R88T//uue96Ov9IolG+7pRkmC7Hm//vA/IsFW2VRcYmHJsr1/QhxhOdCw2utlN
         dzlRg0dWfqG2DobwDp+9UqVRwc7pu11s/uZkLlmb1lPI9fbm1N0cwXrg4tzmZE2gJCGI
         nqNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695664263; x=1696269063;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/eSbbtCbPQe/6XbQly0bjijPUpnCPMDjF1I3qrXPvb8=;
        b=SHgSq8iOKaFBHCvz8OmB+J2XaawYN2d5SiqDxBugSH/1ZD9hzWBjiywj2a5qtd/FOq
         CanDFQRzHm39SwFg1fbnTtQZp5jKUJF7evjuUAsIacOhpct3hVise0bWBj+tx6SGoNTG
         1HQCMECsBTql7ICSn2qvGiyxiHCV/QHfwBzrgzO0oQRg6Igeo8PEqX5Im8/bmqSZquly
         Lb3LGW0fv6oo0joCcpTgv5Vqu3E1rUe6ZqLSs9bbWtCR3n/tCXUW7pyiv7H1uAGaRvlV
         K2z1gHImMGqDxSgp1Ly0w/gG7Hs+U6KJpujp5d+xfKfbB7L4URt8s5lAi5RiVDHcctwK
         T7pw==
X-Gm-Message-State: AOJu0YwWXRWKoLPlF5/3ObJkkh21NsLi3GFRuQTDOxyyKr5So5tOVAia
        trsc1yV0jEYKyqBLm1k+JikxLyEMwoY=
X-Google-Smtp-Source: AGHT+IEaOkoqY3DSi1xV8lO2lafzKFXTjYSAMuAaIfhIEr1MqWDhJhR/izki3TUVWqEQd0f9dj+2yg==
X-Received: by 2002:a17:90b:b08:b0:274:862f:3439 with SMTP id bf8-20020a17090b0b0800b00274862f3439mr4877791pjb.13.1695664263402;
        Mon, 25 Sep 2023 10:51:03 -0700 (PDT)
Received: from fivlite-virtual-machine.localdomain ([49.37.157.220])
        by smtp.gmail.com with ESMTPSA id gw7-20020a17090b0a4700b00273f65fa424sm8417874pjb.8.2023.09.25.10.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 10:51:03 -0700 (PDT)
From:   Kousik Sanagavarapu <five231003@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Kousik Sanagavarapu <five231003@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>
Subject: [PATCH v2 1/3] t/t6300: cleanup test_atom
Date:   Mon, 25 Sep 2023 23:13:08 +0530
Message-ID: <20230925175050.3498-2-five231003@gmail.com>
X-Mailer: git-send-email 2.42.0.273.ge948a9aaf4
In-Reply-To: <20230925175050.3498-1-five231003@gmail.com>
References: <20230920191654.6133-1-five231003@gmail.com>
 <20230925175050.3498-1-five231003@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Previously, when the executable part of "test_expect_{success,failure}"
(inside "test_atom") got "eval"ed, it would have been syntactically
incorrect if the second argument ($2, which is the format) to "test_atom"
were enclosed in single quotes because the $variables would get
interpolated even before the arguments to "test_expect_{success,failure}"
are formed.

So fix this and also some style issues along the way.

Helped-by: Junio C Hamano <gitster@pobox.com>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Hariom Verma <hariom18599@gmail.com>
Signed-off-by: Kousik Sanagavarapu <five231003@gmail.com>
---
 t/t6300-for-each-ref.sh | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 7b943fd34c..7ba9949376 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -41,25 +41,29 @@ test_expect_success setup '
 	git config push.default current
 '
 
-test_atom() {
+test_atom () {
 	case "$1" in
 		head) ref=refs/heads/main ;;
 		 tag) ref=refs/tags/testtag ;;
 		 sym) ref=refs/heads/sym ;;
 		   *) ref=$1 ;;
 	esac
+	format=$2
+	test_do=test_expect_${4:-success}
+
 	printf '%s\n' "$3" >expected
-	test_expect_${4:-success} $PREREQ "basic atom: $1 $2" "
-		git for-each-ref --format='%($2)' $ref >actual &&
+	$test_do $PREREQ "basic atom: $ref $format" '
+		git for-each-ref --format="%($format)" "$ref" >actual &&
 		sanitize_pgp <actual >actual.clean &&
 		test_cmp expected actual.clean
-	"
+	'
+
 	# Automatically test "contents:size" atom after testing "contents"
-	if test "$2" = "contents"
+	if test "$format" = "contents"
 	then
 		# for commit leg, $3 is changed there
 		expect=$(printf '%s' "$3" | wc -c)
-		test_expect_${4:-success} $PREREQ "basic atom: $1 contents:size" '
+		$test_do $PREREQ "basic atom: $ref contents:size" '
 			type=$(git cat-file -t "$ref") &&
 			case $type in
 			tag)
-- 
2.42.0.273.ge948a9aaf4

