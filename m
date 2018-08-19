Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD0081F954
	for <e@80x24.org>; Sun, 19 Aug 2018 17:54:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbeHSVGt (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Aug 2018 17:06:49 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:55056 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726634AbeHSVGs (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 19 Aug 2018 17:06:48 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:1024:89fd:c4a5:84be])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 227736075D;
        Sun, 19 Aug 2018 17:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1534701271;
        bh=Zq0WUrzv216TnnedUWYnry2X18aTDOLh9gPBsSiATMg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=lYPe1m3jRP+48UwS2Rroa6Go3d5P6Jph2NUFNLwFJFPFWJIu7csJRp8gom16eBbpj
         GAczQ1h5W5TCgk8S7+o0oeRFc+bBy15b1OrUG+9s4XsKSPiJ4p568dcDuftmwY4qf+
         BEC5qQkylUsVzt2zksnSSg2u/onxvcjKI6NwLHpq1L4RZjSBaGD8uA/hck5c+Vbe1H
         05lLYlI/7/kC9er2n8UtW+/f5k5AbCnNikGnRoyMGfbJQ1bBFH5OlcDAqxFXKkgPve
         JZ5MPhi8bV3W3993l3E1CqrvdoflGo/AiCeRxq4kvZ/+V4nPzkhgisu/JdQIrE0U7g
         Ulj9SXx9Sbq+1Zv8MRidcJe4QxIiaU9J7xLXfQYPB6phyyMGsnt9l7BCP754gsrNEk
         pes++6YsvCghrF8sNxBsR1JKW8KkxKUHwGQQiHplPQqp/lmdI2PzGkW2xxy4tWsQ7s
         yCkLSQm0O3EKyFyKMlf+jDTn1HUU0oi0nzGdl0gKG8CA12OITDX
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH v2 05/11] t0027: make hash size independent
Date:   Sun, 19 Aug 2018 17:53:45 +0000
Message-Id: <20180819175351.449973-6-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.18.0.1017.ga543ac7ca45
In-Reply-To: <20180819175351.449973-1-sandals@crustytoothpaste.net>
References: <20180819175351.449973-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We transform various object IDs into all-zero object IDs for comparison.
Adjust the length as well so that this works for all hash algorithms.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t0027-auto-crlf.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/t0027-auto-crlf.sh b/t/t0027-auto-crlf.sh
index beb5927f77..e748060489 100755
--- a/t/t0027-auto-crlf.sh
+++ b/t/t0027-auto-crlf.sh
@@ -15,8 +15,9 @@ compare_ws_file () {
 	pfx=$1
 	exp=$2.expect
 	act=$pfx.actual.$3
-	tr '\015\000abcdef0123456789' QN00000000000000000 <"$2" >"$exp" &&
+	tr '\015\000abcdef0123456789' QN00000000000000000 <"$2" >"$exp+" &&
 	tr '\015\000abcdef0123456789' QN00000000000000000 <"$3" >"$act" &&
+	sed -e "s/0000+/$ZERO_OID/" "$exp+" >"$exp" &&
 	test_cmp "$exp" "$act" &&
 	rm "$exp" "$act"
 }
