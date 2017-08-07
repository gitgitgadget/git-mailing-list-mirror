Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C717C2047F
	for <e@80x24.org>; Mon,  7 Aug 2017 19:53:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751743AbdHGTxi (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Aug 2017 15:53:38 -0400
Received: from mout.web.de ([212.227.15.4]:51726 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751505AbdHGTxh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2017 15:53:37 -0400
Received: from [192.168.178.36] ([79.237.60.227]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MV4tp-1e8lYr02hB-00YOQC; Mon, 07
 Aug 2017 21:53:20 +0200
To:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Cc:     Edward Thomson <ethomson@edwardthomson.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] t3700: fix broken test under !POSIXPERM
Message-ID: <ed5c4105-a383-ef7c-c8de-75f22d41edbe@web.de>
Date:   Mon, 7 Aug 2017 21:53:16 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:snieq9TsWbSU78URL5O4xZIpOo3k8Jg9VseuLgfGbvo+/JG83rH
 G4AYD9KT1HpKEZsvh5LUGLRp1g5oinRJaIZSaKTXJ/+M4J603+rMlg1tT1OBheFiUw7qcsl
 O4/0jpWjn+96gnR9bdnn6Qeo+13V/7OFF+ty+axDO91CpVOYsSmrkgONnK6WUuGPTY83QEi
 j3oxqhgHzDASjYiA1MBvw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:pWi9TvX5pOg=:eKhO03d1B61aYpUfXWqUSh
 bbdO0U3ep3mY563g3fbF9fxXEPHYi5x/4OZaL1RWnWm7mrFQgKaIcJ2RhphKJ2dWoeRtZAIzT
 2XOQpUtgfknn0w0cYpSTkR81ZlOt91jgrHDYCWzsOnai1+rCAIRRaoOqDx3P81A0Kmh9ZE7yS
 maFfN9Q+YrlXG24ZpXhqS/PJD9PZDCHdmgbqcwbKpmls7ESB02t/HrBzO+bMNd0n01TnMzwN5
 4drZG+PGjPa4KhJ4O+8shd4Lm1pQjCflZWNM5mDziS0Om+edz74rByvWSnIDl0jvVOQ0nTKpG
 AmzxomqD38X6K4bYjcsLzlqEzOrZhBMmC/e2rv0B3zTQQMX/u+6VswHGKEHfeI19YwNOKG3jH
 tep4wD44EoJRZCrgWYiZPXuKPO58CMlv/H3uD8EOwCqkSFXakmKDXl9Np0hjHAd5jlGpfn2gd
 l656g3n9deMeC4taNVvCJfHkZvhVUjufKPRymknxYD3nPhDrHCPyCf+nZexOgQ9Yo38dNrpbz
 fl/cYSOph6y5a/3ImpXIabP3Ddm28vED+czvDDNdGjtl/nrKE6/xgkSHRNlIdLi6mY6FRzGXz
 /OojMGU1pllfxIYXTeCerFTGd5NUkfJ/lpsxfrSggpn/1u/0S6WJhW9cdCy3b6SOFbBZF4MyA
 S8BS1xP6SD+yBsesxcOlSQew57P6AcV8sNWuL/vSk1aRKp5Ag8TD+0JHP4Memdu792dleMyTz
 bY+tIzQp4mlCeU8Ag0v8WSXiqrtP0nyfotaoZRopX9KiodemSBZMbOjDCm046JJNRC0x4/+bp
 QigqFoxJjw7rNnqlSGbIX1h3bt8gfxfGHIWno87i0M4m+xfAgs=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

76e368c378 (t3700: fix broken test under !SANITY) explains that the test
'git add --chmod=[+-]x changes index with already added file' can fail
if xfoo3 is still present as a symlink from a previous test and deletes
it with rm(1).  That still leaves it present in the index, which causes
the test to fail if POSIXPERM is not defined.  Get rid of it by calling
"git reset --hard" instead, as 76e368c378 already mentioned in passing.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 t/t3700-add.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t3700-add.sh b/t/t3700-add.sh
index f3a4b4a913..4111fa3b7a 100755
--- a/t/t3700-add.sh
+++ b/t/t3700-add.sh
@@ -355,7 +355,7 @@ test_expect_success POSIXPERM,SYMLINKS 'git add --chmod=+x with symlinks' '
 '
 
 test_expect_success 'git add --chmod=[+-]x changes index with already added file' '
-	rm -f foo3 xfoo3 &&
+	git reset --hard &&
 	echo foo >foo3 &&
 	git add foo3 &&
 	git add --chmod=+x foo3 &&
-- 
2.14.0
