Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 44F701F597
	for <e@80x24.org>; Sat, 28 Jul 2018 22:53:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731474AbeG2ATg (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Jul 2018 20:19:36 -0400
Received: from avasout07.plus.net ([84.93.230.235]:53495 "EHLO
        avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730656AbeG2ATg (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Jul 2018 20:19:36 -0400
Received: from [10.0.2.15] ([80.189.70.183])
        by smtp with ESMTPA
        id jY3cfsa1fjlDzjY3dfbQSd; Sat, 28 Jul 2018 23:51:30 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=GrdsBH9C c=1 sm=1 tr=0
 a=6SF67mWK+VR8hB1Kjo6y2g==:117 a=6SF67mWK+VR8hB1Kjo6y2g==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=fH4NDmGawRt_UCpQ4W8A:9
 a=xr3qR-x9rYoJdFWt:21 a=49vK5Fv617wMwUlC:21 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
To:     Junio C Hamano <gitster@pobox.com>
Cc:     GIT Mailing-list <git@vger.kernel.org>,
        Max Kirillov <max@max630.net>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] t5562: avoid non-portable "export FOO=bar" construct
Message-ID: <c5b2a072-5058-0d3e-8fb0-52b84bfcdfa9@ramsayjones.plus.com>
Date:   Sat, 28 Jul 2018 23:51:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfIfnlTjSHU8ajpCgN4RRRbHiwuPpCCyejqJSOZ2fzhyVsmiZY6Oo7ED7Fu9T1KNEPfzMg6lG1bT9Owb4kWB5ZoT1+LOZCWvrJzr15cdCfxxR7L2/Id/w
 rpc+Q4IKAJEQZAloecHExWtRLGVr5nMvF78H/zvWzshIf4rNvqgMHMg8TwlCbunFxSw8np/mgw+ZXQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Commit 6c213e863a ("http-backend: respect CONTENT_LENGTH for
receive-pack", 2018-07-27) adds a test which uses the non-portable
export construct. Replace it with "FOO=bar && export FOO" instead.

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Junio,

Could you please put this on top of the 'mk/http-backend-content-length'
branch. This test tickles the new "export FOO=bar" check, so the test
suite does not run otherwise.

[If Max needs to re-roll that patch series, then he can squash this in.]

BTW, t3404.#4 fails for me, but I think you are already aware of that
test failure, right?

Thanks!

ATB,
Ramsay Jones

 t/t5562-http-backend-content-length.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/t5562-http-backend-content-length.sh b/t/t5562-http-backend-content-length.sh
index 057dcb85d6..43570ce120 100755
--- a/t/t5562-http-backend-content-length.sh
+++ b/t/t5562-http-backend-content-length.sh
@@ -45,7 +45,8 @@ ssize_b100dots() {
 }
 
 test_expect_success 'setup' '
-	export HTTP_CONTENT_ENCODING="identity" &&
+	HTTP_CONTENT_ENCODING="identity" &&
+	export HTTP_CONTENT_ENCODING &&
 	git config http.receivepack true &&
 	test_commit c0 &&
 	test_commit c1 &&
-- 
2.18.0
