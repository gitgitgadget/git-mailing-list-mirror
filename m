Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 266F3C4332F
	for <git@archiver.kernel.org>; Mon, 14 Feb 2022 02:08:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239272AbiBNCIx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Feb 2022 21:08:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234025AbiBNCIt (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Feb 2022 21:08:49 -0500
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6144B54BF2
        for <git@vger.kernel.org>; Sun, 13 Feb 2022 18:08:42 -0800 (PST)
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 771215A09E;
        Mon, 14 Feb 2022 02:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1644804521;
        bh=IZvk5MKnkQgtGo0zlpZRpp6sqDFFA0rF811+XVH2IIk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=IU6tWaCWv3C5M/3318MQ0NdNLbnXV+kQTXyXOeP2eN76Clm9LKcRNkPCZafEy4Dg4
         wxD7knRTERElf0zSIKqiuS5/yumi3UINa9RRAjBlrGt3/2B9c9kvAT8EaLbEysxaX9
         CPOkJhJVp4Z7408onLlFJmwWnivAu19Te5ELXi2oJO0cVZEsNVWlF6UhK6mcrxjBFT
         PfE3SyerO7UiRli3QPpbm+e9s/oRmlwiNB1JChPBfkWLYe5ofpfsKfxiLnfOuy+xTl
         J8e9S1rz1E81bSHL0uMxnryZpJH9w+tUBYE4O921vLzh/v8v/Wr9r01ilM8FgvVWYh
         u/biXAj9Ou4HXvBo7QP5tMZwE11gY+PZC/t3NL2CFSo8rIwz4pc2M41Y76e7XE6EES
         zh+dhscDBkDWj3bcNFCJcQmUfIG+Y7TTXT1XeWk3q76S3OlkJbcZKEwODkxmsmVhX+
         tyiNl55Vs0fQ5KagjRs3XEGBxj9au0Tp/QNnU4zCZ93ZJx03HB2
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH v2 1/2] t0027: add tests for eol without text in .gitattributes
Date:   Mon, 14 Feb 2022 02:08:26 +0000
Message-Id: <20220214020827.1508706-2-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.34.1.575.g55b058a8bb
In-Reply-To: <20220214020827.1508706-1-sandals@crustytoothpaste.net>
References: <20220111021507.531736-1-sandals@crustytoothpaste.net>
 <20220214020827.1508706-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Right now, it isn't clear what the behavior is when the eol attribute is
set in .gitattributes but the text attribute is not.  Let's add some
tests to document this behavior in our code, which happens to be that
the behavior is as if we set the text attribute implicitly.  This will
make sure we don't accidentally change the behavior, which somebody is
probably relying on, and serve as documentation to developers.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t0027-auto-crlf.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/t/t0027-auto-crlf.sh b/t/t0027-auto-crlf.sh
index 4a5c5c602c..c5f7ac63b0 100755
--- a/t/t0027-auto-crlf.sh
+++ b/t/t0027-auto-crlf.sh
@@ -597,6 +597,12 @@ do
 	# auto: core.autocrlf=false and core.eol unset(or native) uses native eol
 	checkout_files     auto  "$id" ""     false   ""       $NL   CRLF  CRLF_mix_LF  LF_mix_CR    LF_nul
 	checkout_files     auto  "$id" ""     false   native   $NL   CRLF  CRLF_mix_LF  LF_mix_CR    LF_nul
+	# core.autocrlf false, .gitattributes sets eol
+	checkout_files     ""    "$id" "lf"   false   ""       LF    CRLF  CRLF_mix_LF  LF_mix_CR    LF_nul
+	checkout_files     ""    "$id" "crlf" false   ""       CRLF  CRLF  CRLF         CRLF_mix_CR  CRLF_nul
+	# core.autocrlf true, .gitattributes sets eol
+	checkout_files     ""    "$id" "lf"   true    ""       LF    CRLF  CRLF_mix_LF  LF_mix_CR    LF_nul
+	checkout_files     ""    "$id" "crlf" true    ""       CRLF  CRLF  CRLF         CRLF_mix_CR  CRLF_nul
 done
 
 # The rest of the tests are unique; do the usual linting.
