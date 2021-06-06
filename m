Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB9FEC47082
	for <git@archiver.kernel.org>; Sun,  6 Jun 2021 01:02:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C35706115B
	for <git@archiver.kernel.org>; Sun,  6 Jun 2021 01:02:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbhFFBDw (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Jun 2021 21:03:52 -0400
Received: from mout.web.de ([212.227.17.11]:47325 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230060AbhFFBDw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Jun 2021 21:03:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1622941318;
        bh=8/LHb2WaUVvj+zgIONRPWpzNhOqMaNBLLyASra9AvMY=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=Ffo7nLDU3H/VtwFNtqZV5WEyCZwytf9RF4UxgglNLSF7O40+j6lnoAb9rEzpAVDTS
         qGjJJQJwEpasdw2OXeK7rw6YI7aydmYaitgS4CMzmuFT4XxFirhu+bD/+1gCs+0JmR
         DEkWxc213OFLJpWNDkcO5QRGK5DVbXPnV9cAvck0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.31.60]) by smtp.web.de
 (mrweb106 [213.165.67.124]) with ESMTPSA (Nemesis) id
 1MMGyK-1m6o5I2NOg-00JMUx; Sun, 06 Jun 2021 03:01:58 +0200
Subject: [PATCH v3] parallel-checkout: avoid dash local bug in tests
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git List <git@vger.kernel.org>
Cc:     Matheus Tavares <matheus.bernardino@usp.br>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <eb4bcd4c-e6d2-cbeb-8951-cf22b9d3d5fe@web.de>
 <472c1411-fcf8-862b-cef9-52c2c994914b@web.de>
Message-ID: <3b71b62d-b299-aac8-f796-ee7a5d7f87b0@web.de>
Date:   Sun, 6 Jun 2021 03:01:57 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <472c1411-fcf8-862b-cef9-52c2c994914b@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rw8swL4rxlHF5rabdiZG9969OoXp3teF/HINfau5otAlbFl6aGO
 Q7j5LcISi40eOruvEP2i3gnkZrWR6x6boGkUU45xA22bbvawU2irr4AaAJtQu82YJ4NLGih
 DXV4DNJJC3d86Pk1Xq1i2Ff7+rCiY/YSHamBb/8YDoyT8ZgOIDyVEVTpt1g01lK0NvX1V6S
 m1lQvxuVxLggsG/zm7icw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:giknZ98QqJQ=:G8hdhjkq1vbX3S77ozmkfD
 +q8As7mrOXlaN/+c7JNNywXHl7d/1HsdDmxn/qt6JehVv95CLIJtWIMQGzycVkZljdFdfxvyg
 1UOOa1EqlcBTzMyepShu4+hK/sJCibXqL0deUYyDVRD3SUWscmCH1rXWxVEZX9unqLN/UKpmI
 WYdpQohtxVIudTt8lEzDMvn58I8vWjSQlfC9DyddoNBdxYBKyywpSvgbA9nrg6L2F/zOIe7M+
 l0DQLot/8lbI/Fc9xgnp5Sx5ier37KSydFLaxeszsTzMEG9tUhGE5MQd9wILiEKRcwVJqJZ7B
 StHowO0g/U3lLWcnK8eoRducCP82Tq8Slk9PKINQbe03rGqJWH1rOiNLGuVk037hQvcnAu0Oq
 yCTXfnsHCvuIt4SJ1Z4K6u4ZRpdGqjYptt+iaZp1Poi/lqW9ymD88vbu4x978SMGDRsLv7ath
 k4jjyj7V3/O9y1Fq3s2d+luLiLYCU5eQhMgmZL7OrUWrN4ZoBOgXv5f1sOU8EjphA6/qNDpkk
 nqvgD7Q5ntPQoEhYni46IJg/lDTT699PVNO0staro7xWjD6mXaQ/66zV7/Lw4pQi9bqj2GHl+
 R52AkgyoZKhVAta/yQYwbCf76ztuMRGDzRcTzf0nlDMfSSCKGshXoHqMnsTdg2K9M3ftm+e5o
 Y6hGvFEXtvLgo1kLQgMaHpRl1f0urNGzGuZ2pQ+xTmfgFjDO+ORnJl6WH3pWusDCEp2cytC/q
 usXBy1pqZ+e2WggTiL0m6r3qvNEavVxtKlZpoBa3gbs1JfV4RFCxTyhDXvplZ/OjbxHHKH2KW
 OzGGnUyPhp7nmO/HLB0WW3gIE0Qn1dQedmbRXPUULBLZPuCvsScD2U2zct2pe9ECWY68HZ85N
 Jwnc00mPUYHe6tnve0wIxGmvAEpbQVXUYGPgexcKftNdPy3s3vwpkcaRLJb+v/8dSH548ecIJ
 6v5uQWqZrOEI0L0+g78uNctCvlnCi0tXa7vx0r/x0rx3Gx+8vNBz60ICIkZF4LGe9HXSj7ewW
 g24SqJmktrHEpV82pR07GT5sXW/B3jVe8ONl2bfqSNJE/ljw3f7kgqa70SnUKUBlnnNOwDMzr
 /9ldZgk6OOQ0RuCYaHPuSs5linh9yp8ib0L
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dash bug https://bugs.launchpad.net/ubuntu/+source/dash/+bug/139097
lets the shell erroneously perform field splitting on the expansion of a
command substitution during declaration of a local variable.  It causes
the parallel-checkout tests to fail e.g. when running them with
/bin/dash on MacOS 11.4, where they error out like this:

   ./t2080-parallel-checkout-basics.sh: 33: local: 0: bad variable name

That's because the output of wc -l contains leading spaces and the
returned number of lines is treated as another variable to declare, i.e.
as in "local workers=3D 0".

Work around it by enclosing the command substitution in quotes.

Helped-by: Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Helped-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
Helped-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
Changes since v2:
- Use minimal fix.
- New commit message.

 t/lib-parallel-checkout.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/lib-parallel-checkout.sh b/t/lib-parallel-checkout.sh
index 21f5759732..83b279a846 100644
=2D-- a/t/lib-parallel-checkout.sh
+++ b/t/lib-parallel-checkout.sh
@@ -27,7 +27,7 @@ test_checkout_workers () {
 	rm -f "$trace_file" &&
 	GIT_TRACE2=3D"$(pwd)/$trace_file" "$@" 2>&8 &&

-	local workers=3D$(grep "child_start\[..*\] git checkout--worker" "$trace=
_file" | wc -l) &&
+	local workers=3D"$(grep "child_start\[..*\] git checkout--worker" "$trac=
e_file" | wc -l)" &&
 	test $workers -eq $expected_workers &&
 	rm "$trace_file"
 } 8>&2 2>&4
=2D-
2.31.1
