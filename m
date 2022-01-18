Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F170FC433F5
	for <git@archiver.kernel.org>; Tue, 18 Jan 2022 12:46:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238770AbiARMqc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Jan 2022 07:46:32 -0500
Received: from mout.web.de ([212.227.15.14]:49153 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238582AbiARMqb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jan 2022 07:46:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1642509985;
        bh=ifA4llf293NHACfhKN6YJS9vZRyQqX1ox/EKjlCczWU=;
        h=X-UI-Sender-Class:Date:Subject:Cc:References:From:To:In-Reply-To;
        b=FKe5aE3Ug5/p164AN2ACtz+EagEF8OiHSXueXeDy6VNAxxAt6HliubZHt9V58aZ9Z
         ZAVZoOTKGSrN3A8mWGeIuoGVXRencZs0UlDu49XCYjUv98kcOBc5kpcsJCNS+n86CT
         AYfSjtypVymHBffQc6MN4ibviOkJgSRFKyZlz1P8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.22.121]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N7QUL-1mFro40tbh-017UAL; Tue, 18
 Jan 2022 13:46:25 +0100
Message-ID: <97650f5a-a6c6-d3fc-010f-3d5a45c64a52@web.de>
Date:   Tue, 18 Jan 2022 13:46:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.0
Subject: [PATCH v2 3/4] bisect: document run behavior with exit codes 126 and
 127
Content-Language: en-US
Cc:     Ramkumar Ramachandra <r@artagnon.com>,
        Christian Couder <christian.couder@gmail.com>,
        "Miriam R." <mirucam@gmail.com>, Junio C Hamano <gitster@pobox.com>
References: <1edfc6ff-4db8-447f-9eb7-85843258a286@www.fastmail.com>
 <xmqqilus3ctf.fsf@gitster.g>
 <fead25d6-6f5f-487a-ad4c-0657fe9785fd@www.fastmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git List <git@vger.kernel.org>
In-Reply-To: <fead25d6-6f5f-487a-ad4c-0657fe9785fd@www.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vPI2kFFK6qQ4a1F8Bw8LvEPGaT22P+CubWNgPLWv654BgulvpOI
 SMznHmg+dZ5terFZQ/nPiZzxmMPBUxle7AKMSphqyB6JZctBJLVVbYnr573XTkTtbseoP/8
 ATEeuZ0eZgdsIQPGLGN1XMe6xqmwyqw5H9yiw9jPc5MYJkTLcB6P6LeuhDxp3QEpLDm6f89
 bP1GutJ7cMMyVBAvimNvQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:OLjaNsg4Svs=:h5eSMDSpm/7sdh1FeH967A
 V+uSKXkK6vBSwLjvPnVnz3Q68KksKyyFFrpvA15iyfk18HAVpLFDPZQXrPAlSeW7iFHrelg30
 iZhmjPoXb6aNe03hMNXWjYVp6Gddwzem8Rx2wcb3mzxevIfnxbeMi9xdQX7galyQF0jA4I31f
 Qxtb7z3m8m8OHzlWmlV3mPx9jRROWM2JclAYxJeYq9tIVvh69wR0+XEuX//m83Rf0d5uBEh2o
 tuXi1NUkF8lhYDv2qgv/KPi3FnlQxdSzFZdM350OnK2WvKWiPMglxxzuwlVTvT+bkmWbtjD07
 qAXaDUcjd6ShiVPbXtGpkU8C7x6ngkeGDjiWOvd1XKMQ0GCKbrDXPN99UywhQ9ZEJnav4KpkT
 4OIPXyDyAVDPM8ndomkB7AeIcYcDcylDZwdHCIwcmw5nMC31xD1SOUE016fDM9c7VLViS5cEa
 Z0stDqi/7dSbiz1WqhPMJQyUo9wMUPSGZLtcfDmYJ/PgYZHG5a83F7HqDTL0en1NX7KhWFors
 egc7uArrOEcsw5nq+4xPJlMCkkQ7hXmFQldDqyC4yqcMntXT+9T/qHmUQgCd4PVetak660FhV
 Zx8VfEojAjLvbPTQemgIFqz8F4JAgng4t7f6iC/fj0QqVGwQ41fMRnuiV3qi8L+I85flQGhz/
 LluN5oXDyEBctpCd1d6AkRSbx8Ol99NfRBCVkURbKxCD2eWm07RQaNJwjFiC4ajMoUNsTVPls
 X64EgQhRHP0e5huShJXsKXgxV0iJ6tTWYUKE/Yc9H2D42ca7zXnbA7U6sLZ8DQ1HbNT/95pQg
 8al1P3vwxDfL5xBjAU2CndW1Nj5LrhgS2QK/yZnU116diVi4xXUXW+U+ykG70HX1MufzsmrS+
 NRqJ2yCSw7gtwyqErF04eDqt3h2JvO2BQbfUN47zn1V0O0MJ/+Hy3efgmv5fJpnhti+lNxkKU
 OZk4sytzppWmvTBizNAfbNbSJ8CV6sude87hn4z/VZbOeB7p2oZ+sLZ8eycuuYIzUrB3XxYWy
 g8Ddt9pzBizH1uBuI2k8gTlfwJYc0sz4h+qpm1QW6SqWa5NmakCUIBhZVhHfsxeObBqKLjFq9
 Guem4txMgu5UqY=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shells report non-executable and missing commands with exit codes 126
and 127, respectively.  For historical reasons "git bisect run"
interprets them as indicating a bad commit, though.  Document the
current behavior by adding basic tests that cover these cases.

Reported-by: Ramkumar Ramachandra <r@artagnon.com>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 t/t6030-bisect-porcelain.sh | 45 +++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 1be85d064e..fc18796517 100755
=2D-- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -278,6 +278,51 @@ test_expect_success '"git bisect run" with more compl=
ex "git bisect start"' '
 	git bisect reset
 '

+test_expect_success 'bisect run accepts exit code 126 as bad' '
+	test_when_finished "git bisect reset" &&
+	write_script test_script.sh <<-\EOF &&
+	! grep Another hello || exit 126 >/dev/null
+	EOF
+	git bisect start &&
+	git bisect good $HASH1 &&
+	git bisect bad $HASH4 &&
+	git bisect run ./test_script.sh >my_bisect_log.txt &&
+	grep "$HASH3 is the first bad commit" my_bisect_log.txt
+'
+
+test_expect_failure POSIXPERM 'bisect run fails with non-executable test =
script' '
+	test_when_finished "git bisect reset" &&
+	>not-executable.sh &&
+	chmod -x not-executable.sh &&
+	git bisect start &&
+	git bisect good $HASH1 &&
+	git bisect bad $HASH4 &&
+	test_must_fail git bisect run ./not-executable.sh >my_bisect_log.txt &&
+	! grep "is the first bad commit" my_bisect_log.txt
+'
+
+test_expect_success 'bisect run accepts exit code 127 as bad' '
+	test_when_finished "git bisect reset" &&
+	write_script test_script.sh <<-\EOF &&
+	! grep Another hello || exit 127 >/dev/null
+	EOF
+	git bisect start &&
+	git bisect good $HASH1 &&
+	git bisect bad $HASH4 &&
+	git bisect run ./test_script.sh >my_bisect_log.txt &&
+	grep "$HASH3 is the first bad commit" my_bisect_log.txt
+'
+
+test_expect_failure 'bisect run fails with missing test script' '
+	test_when_finished "git bisect reset" &&
+	rm -f does-not-exist.sh &&
+	git bisect start &&
+	git bisect good $HASH1 &&
+	git bisect bad $HASH4 &&
+	test_must_fail git bisect run ./does-not-exist.sh >my_bisect_log.txt &&
+	! grep "is the first bad commit" my_bisect_log.txt
+'
+
 # $HASH1 is good, $HASH5 is bad, we skip $HASH3
 # but $HASH4 is good,
 # so we should find $HASH5 as the first bad commit
=2D-
2.34.1
