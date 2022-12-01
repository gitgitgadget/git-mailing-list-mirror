Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01D67C4332F
	for <git@archiver.kernel.org>; Thu,  1 Dec 2022 22:46:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231620AbiLAWqp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Dec 2022 17:46:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231550AbiLAWqX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2022 17:46:23 -0500
Received: from mout.web.de (mout.web.de [217.72.192.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 475CFCA79D
        for <git@vger.kernel.org>; Thu,  1 Dec 2022 14:46:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1669934755; bh=m/VQIswDyCWEAAJrn0MZISvesNZn7B2OGrBonQX7Ho0=;
        h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
        b=anbU2pRgbtgvHGwnQI5KY2yU9OzienRSASulf6SR0ZPARVgiYE637LM+FcMjS9LmP
         wxXbhZ53SO4w3FnXhiEOyPuGSSWBwdx4siirt5cFx596HN5KFVJ1XZaFHJ+f5EIlWk
         46SuU2yNIl5aj9pEOdtvXMPrYxm4X/DoBKmcBNR4ux+QTcVhwM9+ho56dO7wAfagLs
         wvryHgRz03AUAFbiEYgO1OxAZ1k52hjUP7bCfv51kRHS2zdPzlHwsw6Bae/824OxYL
         jBwo/94ADnMmM4CmkuKG1dJjBhdYJGVUnFB6UKh78oACRr152RUhPo61JbjL+Mz2Gm
         zBvHp/+BGqA1A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.34] ([91.47.154.159]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M9ZeA-1p6O630tHQ-005duf; Thu, 01
 Dec 2022 23:45:55 +0100
Message-ID: <19325420-5630-87bb-0c2c-362151214b36@web.de>
Date:   Thu, 1 Dec 2022 23:45:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: [PATCH v3 0/3] diff: build parseopts array on demand
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff King <peff@peff.net>, ZheNing Hu <adlternative@gmail.com>
References: <0620b4a6-b80a-d8a0-5a35-857b9fe0c986@web.de>
In-Reply-To: <0620b4a6-b80a-d8a0-5a35-857b9fe0c986@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:OD+ruEd84LD7V8F16yOwdN8IvSdrWQnCtEna/yFnzcmw5fbh5Hk
 sN4mzSUYqZ7MDliIpUzqjA5VyGljRvJ7g83W5Z7MeJNbFf9bSmCUg1aVKr6PWGc+c5xcklB
 4MYptLKl6Bffp6WKCml2WO6TaLaMdqDXu7lIoMrOOLATzzaig2azgYNz1m0Mzw4Lpsj+dtu
 Lj5SfxEzJY6wzYbODoOsg==
UI-OutboundReport: notjunk:1;M01:P0:7P1NhxiDiFQ=;ZyxJL+7JiMerIPxqhG1GBDyhiTM
 Echl386+z/moqkmgDKVwW/lCRJQGhCTasMtptXYto3qj0JLOpcGTMEXmkT6vZbTbtkNyeZaa3
 WOqqkhadQPqyRE3sSEGzxnT/v/FL2FbwY/TqB9xFBMH1Rm9sLpLyaAkUej6zM/SlUMJGPl38K
 ZFoc7raXjMRX1e2K4+10kKT3JALLiu22NpnfR8tUduK1At7d4h2RjSCdWkaIPn0ZXprXzD6u0
 aRWg6jehfbZu1cW2aCcK4vCdpRcQF3BDfXQXSgZANX6s2BtM4zKRRqSpllld+ucFu369GZI5M
 ToxEk+/ywvEwpmd8sF60qcw4JKRZ5INGcMbMxs7bN7s4keMH4kp2qxzxV/Mo2wQsw8oxnYcSi
 PXtHBAE7iScRZlSfQr+S5g3c35EnxITb/A5oZdqJLGKLwa4yMCoxpgsSsgUD1yOpPzHNV42l4
 +Vspko7X/trehj96o8z+XUtFb8pjfn9o3T7qb7lRlwSNgv5yOujILfPB1aVCsXW2SvePTs8ZP
 mgydcyH7E/XZMcAGwOyjEZiuRBIyNyh5tDP6HKieySQWt31mlEtjkDN1xQjgEHyDIa5eglNkA
 6cpi3PhhTP0wCjmGQ5zz1xcdim9+krGrH0P/IjGVRjB+BMZ/yhGzqOGo06sLbj2ctuxmKEGkk
 eFkvY9sSoCm579XmpRAhcBNg4bjKOVrNeGbbvCDaweguM6dm/SQGP+V2k/Bbj2jpce9xx4PpD
 q+qzBn+r6VjgeIPTo/rzaa/PxZjPKILvYfrJvpheOG89Qzm69npeUUjt62Oya/tK6iZv1wf4t
 FclWfEuRC8PNYARq0UKmvlLoal1xCWmNoU38bi6mxI5vLu9DmOjb1ldAlsAHVXDKBPjGZPCzR
 ptciRnaNyxD2s6M+5KB1YT3zMCkODAEEtsvUPuEJXfePg1VN7bT4Df54A0PnYbV+fuXehcwkc
 7Yj1J15weekr+2lV0Vw0xzUKD4U=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Calling repo_init_revisions() and release_revisions() in that order
leaks the memory allocated for the parseopts array in the embedded
struct diff_options member.  Get rid of that leak by reducing the
lifetime of that array.

Original patch:
https://lore.kernel.org/git/4fd82dc6-e0f8-0638-5b10-16bfef39a171@web.de/

Submitted separately from that thread because it's independent enough.

Changes since v2:
- Inline get_diff_parseopts() to simplify the code.

Change since v1:
- Actually remove the parseopts member.  Its removal got lost during
  refactoring in v1.  Thank you for spotting that, Junio!


  diff: factor out add_diff_options()
  diff: use add_diff_options() in diff_opt_parse()
  diff: remove parseopts member from struct diff_options

 builtin/range-diff.c |  2 +-
 diff-no-index.c      |  3 +--
 diff.c               | 19 ++++++++-----------
 diff.h               |  2 +-
 4 files changed, 11 insertions(+), 15 deletions(-)

Interdiff against v2:
diff --git a/diff.c b/diff.c
index 6415c4dc2d..4dfe824c85 100644
=2D-- a/diff.c
+++ b/diff.c
@@ -5413,7 +5413,8 @@ static int diff_opt_rotate_to(const struct option *o=
pt, const char *arg, int uns
 	return 0;
 }

-static struct option *get_diff_parseopts(struct diff_options *options)
+struct option *add_diff_options(const struct option *opts,
+				struct diff_options *options)
 {
 	struct option parseopts[] =3D {
 		OPT_GROUP(N_("Diff output format options")),
@@ -5683,33 +5684,25 @@ static struct option *get_diff_parseopts(struct di=
ff_options *options)
 		OPT_END()
 	};

-	return parse_options_dup(parseopts);
-}
-
-struct option *add_diff_options(const struct option *parseopts,
-				struct diff_options *options)
-{
-	struct option *diff_parseopts =3D get_diff_parseopts(options);
-	struct option *result =3D parse_options_concat(parseopts, diff_parseopts=
);
-	free(diff_parseopts);
-	return result;
+	return parse_options_concat(opts, parseopts);
 }

 int diff_opt_parse(struct diff_options *options,
 		   const char **av, int ac, const char *prefix)
 {
-	struct option *diff_parseopts =3D get_diff_parseopts(options);
+	struct option no_options[] =3D { OPT_END() };
+	struct option *parseopts =3D add_diff_options(no_options, options);

 	if (!prefix)
 		prefix =3D "";

-	ac =3D parse_options(ac, av, prefix, diff_parseopts, NULL,
+	ac =3D parse_options(ac, av, prefix, parseopts, NULL,
 			   PARSE_OPT_KEEP_DASHDASH |
 			   PARSE_OPT_KEEP_UNKNOWN_OPT |
 			   PARSE_OPT_NO_INTERNAL_HELP |
 			   PARSE_OPT_ONE_SHOT |
 			   PARSE_OPT_STOP_AT_NON_OPTION);
-	free(diff_parseopts);
+	free(parseopts);

 	return ac;
 }
=2D-
2.30.2
