Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3C02C25B4E
	for <git@archiver.kernel.org>; Sun, 22 Jan 2023 06:33:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbjAVGdt (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Jan 2023 01:33:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjAVGds (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Jan 2023 01:33:48 -0500
Received: from mout.web.de (mout.web.de [212.227.17.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9396A21A2E
        for <git@vger.kernel.org>; Sat, 21 Jan 2023 22:33:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1674369226; bh=lQgrj76GxmWQg5fzRFeXQS6qR3+qZxPGfAxsuGqj690=;
        h=X-UI-Sender-Class:From:To:Subject:Date:In-Reply-To:References;
        b=FyWH9dOEDMDNoO1gCJ/TiNVoVcXxHGGCYdwvCM4i1g0MJaHMSajriD8/YLd2QImW9
         D0yLlNl4cBOSlzI459X5KT31FSZ6vlDbufcliKpyOrrozN5Ni3COfpvItpFS51YMpC
         Dn7/hV+Co9oel++UN4+V6Ponoo++uXcW+/eZJwDjUXm+h0Xt6LIeHVRyq5J+7CY2/B
         472q6/Qd61ObOdA7aea0tpVu1OWVHM9R4I8uvvKbis/X1r48K5ooK+R8ypRiV1jpvx
         nODzKX27Ufcm8qdDVgD5he+EDSN7dBJQtiU39TdAA7b2mQbwswVDKVAE8ev+29NqmU
         L/t8SCLjlfm1g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost.localdomain ([62.20.115.19]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MgibW-1olEPu07ES-00h5xU; Sun, 22
 Jan 2023 07:28:42 +0100
From:   tboegi@web.de
To:     tboegi@web.de, git@vger.kernel.org
Subject: [PATCH v2 1/1] t0003: Call dd with portable blocksize
Date:   Sun, 22 Jan 2023 07:28:39 +0100
Message-Id: <20230122062839.14542-1-tboegi@web.de>
X-Mailer: git-send-email 2.39.1.254.g904d404274
In-Reply-To: <20230121110505.21362-1-tboegi@web.de>
References: 
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/3n6rr1YUGtXTpFJuogelQt9LHqjD2OmCr0NKy12XKUcCvsDLDh
 ydPfTzOSP10/lmbq7xnVsrbSbUAhGBgsKjm9iXgBllYTWM4atqF0/4rChgApuWZAyH6Orli
 cWgVHD9Vv+/qQSBjLdr0aG+JvjKSS/FDhIQk8q2HuDlj5Jb6CaYzr/Tq9LB7j93eJ2abjTr
 yL+AK9qMDgtlNNZIvpLcg==
UI-OutboundReport: notjunk:1;M01:P0:EmQaYEEiVRw=;IyTQj19PqsNQh3iyfGgg1xD4M/C
 Kvm0zbvwtdoR/7vRNqU/sQFhTs15wBN7N9/5OqtreOcXFO7tnzfyrvlhoRcPu3gIois4k5nJS
 0Z0cOAFwPOZMVe0NYnOBn4mmUQ0h9zOZHHj/91DCFjSusgpBNDBOaD5JEnbsPy/BuJAuuj+5E
 lA7rb7uvgjF0EEPCDSx0Uy0EmndsjGtB/rIHde/ZArgnMO8euufvAWY6M+1QWzTuRs2KtzsuB
 oeOmOiV7+jn6z2/HpS9TrDL9kvUztD5P9eznXYs4EJtd3g6TO8OjMtAJC3zCw+YIXnm/kqJfU
 OfXDksZzsnXktOogZM4EObn6tpMBvpE+dyC/qBfV2qMzJ0snxBXylsttSuqWWbQpDwezz7Jn6
 xAZv1w097kvOanQB507OBpKIoxGTA72wBdjOG4hDRnyVsmzU7cn18g4H0QYwzsuaa8puvWYcE
 Bk3GCKzmqQu+HihiZWqaUD6pFv8NDS34aDt1M5wMTnCzOJWV6k8FJV7z+CcTqBmGnq0ncRQcx
 irwXxT/u45WjD2G/oTEr2rVTP/8RR76M7JpxLhY5HOH2rNihygyVjTD+1eKJkVzfq7sZa3yPH
 /UMXe1n5k1CFaQEKtuz9NCJTB/E9tyt8DssAdV6+Uvd5rL1W8vKa2mgJAfgbRJMUKeCRO5oon
 6MxcDQJR0G+oxQEL2jjp70se2p7zysVw2ZOvFj6z9946tF6pfdRUF+OoDniOc3urDpS64Csli
 qLUdCLpFWlwcFFFalMer448OgLhSS/th3DclHIObnE40dajRfdc+WAN9RFm5D1malIpD0aXmz
 NOQ7v8dS9C6alZ4+4asW10OkjPMbXMcxWHgLbYB6e0U7zZw9z+AfPLyXo9/eM8ENcy0wPxx7p
 uRAfuCTWxByRTpVsSUoNxsUIm7NmvO1+EvgvCHg9w/fWhGyGBiztcS0L5BqahmBWMsty87kk0
 /PcX2G0zN3pZusaPlIhMpLLY8qc=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Torsten B=C3=B6gershausen <tboegi@web.de>

The command `dd bs=3D101M count=3D1` is not portable,
e.g. dd shipped with MacOs does not understand the 'M'.

Use `bs=3D1048576 count=3D101`, which achives the same, instead.

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
=2D--
 t/t0003-attributes.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t0003-attributes.sh b/t/t0003-attributes.sh
index d0284fe2d7..394a08e6d6 100755
=2D-- a/t/t0003-attributes.sh
+++ b/t/t0003-attributes.sh
@@ -400,7 +400,7 @@ test_expect_success 'large attributes line ignores tra=
iling content in tree' '

 test_expect_success EXPENSIVE 'large attributes file ignored in tree' '
 	test_when_finished "rm .gitattributes" &&
-	dd if=3D/dev/zero of=3D.gitattributes bs=3D101M count=3D1 2>/dev/null &&
+	dd if=3D/dev/zero of=3D.gitattributes bs=3D1048576 count=3D101 2>/dev/nu=
ll &&
 	git check-attr --all path >/dev/null 2>err &&
 	echo "warning: ignoring overly large gitattributes file ${SQ}.gitattribu=
tes${SQ}" >expect &&
 	test_cmp expect err
@@ -428,7 +428,7 @@ test_expect_success 'large attributes line ignores tra=
iling content in index' '

 test_expect_success EXPENSIVE 'large attributes file ignored in index' '
 	test_when_finished "git update-index --remove .gitattributes" &&
-	blob=3D$(dd if=3D/dev/zero bs=3D101M count=3D1 2>/dev/null | git hash-ob=
=6Aect -w --stdin) &&
+	blob=3D$(dd if=3D/dev/zero bs=3D1048576 count=3D101 2>/dev/null | git ha=
sh-object -w --stdin) &&
 	git update-index --add --cacheinfo 100644,$blob,.gitattributes &&
 	git check-attr --cached --all path >/dev/null 2>err &&
 	echo "warning: ignoring overly large gitattributes blob ${SQ}.gitattribu=
tes${SQ}" >expect &&
=2D-
2.39.1.254.g904d404274

