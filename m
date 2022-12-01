Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BE07C4321E
	for <git@archiver.kernel.org>; Thu,  1 Dec 2022 13:43:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231164AbiLANnZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Dec 2022 08:43:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbiLANnX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2022 08:43:23 -0500
Received: from mout.web.de (mout.web.de [212.227.17.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BC16BF902
        for <git@vger.kernel.org>; Thu,  1 Dec 2022 05:43:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1669902188; bh=ULKjAoU9yDQjzsXoPz2U6xbYLnHuFks+NR39y5wNP8Q=;
        h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
        b=gudD4YPlN9oND4db0SoZpo2GTB4JOyoZCQoM/DQ9cfDfCT7VCqHIVJV5/yLSKtQzw
         +b6GrZvpmexuJfFDKQFUkUQrR9GZGuq2OX16XZY+eXggWypdphko9y9SdT2I8JMdZf
         bLxwsKzMDbcty1NgNv0VnVm6auHo9RF40hICmDSIL7oZM1wajXkk/3yaxCBjMcjz2K
         mqT/UWn5Tl+YIiRIWIIKZFsfW2AIgeg/ELUgTnS6y/kNbP2r7wmK0v8oH7xL3ZiKtm
         5RqXaW1OpXONEXiWKwwWRVMun36hISNgUerQnqeEsF7maflKyovPNacgCg3ei2f4sS
         KuW7TvY9t0Vxg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.154.159]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MA4bA-1p7qJ42FOk-00C0LZ; Thu, 01
 Dec 2022 14:43:08 +0100
Message-ID: <090e9e6b-00ea-c23b-aa2f-6d9f3d79c22a@web.de>
Date:   Thu, 1 Dec 2022 14:43:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: [PATCH v2 2/3] diff: let prep_parse_options() return parseopt array
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff King <peff@peff.net>
References: <0620b4a6-b80a-d8a0-5a35-857b9fe0c986@web.de>
 <ea838ae7-b635-d4d2-d9df-e96b3d8980af@web.de>
In-Reply-To: <ea838ae7-b635-d4d2-d9df-e96b3d8980af@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZQVQc/UBf4w0KuIHmeanHhT56UPnZfnjQNqbahHz5BiU2fZqihP
 868+iz8lKQnL2lBPxxfrD8Wivd6fdBG3b0JVa1dgG+Jplj7F7kEQvQDEzGEt+XgF0SU4qHc
 ih5hbkRTIkhwrhMnZylVdCsMik/GU1GwvOZtSX1E02Zv1BvT/Hm+AIFemM6tsS11t45CLzv
 ONgm9y1qBq/7lvPtOPF+Q==
UI-OutboundReport: notjunk:1;M01:P0:zBsXcKkYJVU=;W108Y5X7WU3v5lXYhrziYvug86T
 4Sh8/IbbkE40O1YXbS435JPt/t96Zp1GkR+I4QCF/TLLKGZEtZb5CRtULuCmReszIkFLXo4No
 nxo3PVButQYp5KnNEA3Kd6HXi5pYP+9ys6GXARgKVapNYyhMa+qvJNwUN4br4XqZxe7+AHlvx
 eeFUaG/TwOTx6MWxxV3he+jNNOxNp95wariPypdpBRzm9XFSCLLf9sRvbYQXGBUV9Z57bx+ie
 TFAE/fPZ1Y7OItHK3Wx+tlsyfMAJBoCYXtHI9MLyq7Q63ZsFNI+gUF+Qhk6NWOxDVdOeat2jm
 NwgEWN47Nk4SkfUg7bQduQmBh8NI0CkffLFzEWfjo4FMCSQdeKd6BkX7n43ktgoLvXFsAVnlP
 8uNMbO4mk15av7HxC/uc6gcZIwED1sEsPRpJGOAQfQu9LtNurLTvdsU69nfe/bW6iqkKj2vWP
 SOowZknSCMO2f9tcW7BWO+KhPlmbH9wLUe0v8uP3Ech1xpQJkrNxGvvs95VpS0+RBbdGuFfDB
 Zh6zW0XqiwCIAsle0XgcVPeHBEAfHqw5iZoJ4vNvJ1WLSusQfp/tJhiYMl+OB9C4eLspqEltX
 K6c/WWi1k4tMFWqFwr5mJgaSaPjfCq8GBOiojCTc0GS9usvKxeQQlS+3g4ky8amU8Lte6OqHN
 DN8WS+QLAUM51+UaMzy/K58MZ8sk9Dh85q6QdPLRCCIsfVyAeIfaC69kn28mNFrVQOFI0k1cB
 T+UoAm9S43szz4WqSm359CtxuMukALOjeg17mxgq2wveF5XiyZiTDljbovFCuDZY15HHRwpRS
 y42DOVVfvoW35eVBkr4F5cBvm/oJi2F4cV3bw3kEpmSghWFYlDT2Tz/Gz3fztbP10tly4Tn+z
 B2E9iWrWjGhSmBGnHKiL9ko/arjZs8F/4cOOot9yafkqozot/BLyOFPAReUlnair1HZ6A0h6z
 HdVOA9xz2xzvk/b61r70fYGpno0=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

prep_parse_options() sets the parseopts member of struct diff_options.
Let it return the pointer instead and have its caller do the assignment
instead and rename the function to get_diff_parseopts() to reflect that
change.  This allows using it in other places and with other variables.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 diff.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/diff.c b/diff.c
index e01129f0ea..e469d5d2a0 100644
=2D-- a/diff.c
+++ b/diff.c
@@ -4615,7 +4615,7 @@ static void run_checkdiff(struct diff_filepair *p, s=
truct diff_options *o)
 	builtin_checkdiff(name, other, attr_path, p->one, p->two, o);
 }

-static void prep_parse_options(struct diff_options *options);
+static struct option *get_diff_parseopts(struct diff_options *options);

 void repo_diff_setup(struct repository *r, struct diff_options *options)
 {
@@ -4663,7 +4663,7 @@ void repo_diff_setup(struct repository *r, struct di=
ff_options *options)
 	options->color_moved =3D diff_color_moved_default;
 	options->color_moved_ws_handling =3D diff_color_moved_ws_default;

-	prep_parse_options(options);
+	options->parseopts =3D get_diff_parseopts(options);
 }

 static const char diff_status_letters[] =3D {
@@ -5419,7 +5419,7 @@ static int diff_opt_rotate_to(const struct option *o=
pt, const char *arg, int uns
 	return 0;
 }

-static void prep_parse_options(struct diff_options *options)
+static struct option *get_diff_parseopts(struct diff_options *options)
 {
 	struct option parseopts[] =3D {
 		OPT_GROUP(N_("Diff output format options")),
@@ -5689,8 +5689,7 @@ static void prep_parse_options(struct diff_options *=
options)
 		OPT_END()
 	};

-	ALLOC_ARRAY(options->parseopts, ARRAY_SIZE(parseopts));
-	memcpy(options->parseopts, parseopts, sizeof(parseopts));
+	return parse_options_dup(parseopts);
 }

 struct option *add_diff_options(const struct option *parseopts,
=2D-
2.38.1
