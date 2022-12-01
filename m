Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C72BC4332F
	for <git@archiver.kernel.org>; Thu,  1 Dec 2022 22:52:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231676AbiLAWwl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Dec 2022 17:52:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231808AbiLAWwB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2022 17:52:01 -0500
Received: from mout.web.de (mout.web.de [212.227.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3860BC7253
        for <git@vger.kernel.org>; Thu,  1 Dec 2022 14:51:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1669935081; bh=MUngMwHgZXfs9MLcUwCNVBl9EwIl2t6hsj4NmxAAkSY=;
        h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
        b=uocb5iLjh9FcgR2U+b1hUXouqR4sOVHweXX0NtxXriZw4jWn2UjMCtHLVRf/wT/y+
         1008fIwbGAvuXW1V4HKS39D+nJXkrrNYpewl0OyHHJXlFFUPhbNkr0KlNDlQapkR2D
         nC3TQCW3dO5IhXFOp6fGFmHmzfjVJLhdn914RxkgaPzeUseeI5xYLu9LRxz9HO1TP4
         V5JEhO05JsC+IEfsQkI/UQMKvfPeGXbVMrEnUR4k0i1hlysm2jBBBLPlkJay9sZv6p
         KAYulHrsH5EqUA7OMWtDieD65lZbTnMnoE8Z7Ei8DJBQmUMuK6Oaciqtnmo/OGZSjR
         ng5fY3aZzK9kg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.34] ([91.47.154.159]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M7ux6-1p5qDT2gUs-0055bj; Thu, 01
 Dec 2022 23:51:21 +0100
Message-ID: <fb901635-8058-856d-c7cd-6fef24329f62@web.de>
Date:   Thu, 1 Dec 2022 23:51:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: [PATCH v3 2/3] diff: use add_diff_options() in diff_opt_parse()
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff King <peff@peff.net>, ZheNing Hu <adlternative@gmail.com>
References: <0620b4a6-b80a-d8a0-5a35-857b9fe0c986@web.de>
 <19325420-5630-87bb-0c2c-362151214b36@web.de>
In-Reply-To: <19325420-5630-87bb-0c2c-362151214b36@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:De7q0LdTGtEz+2hH1WpVx3onwDDhhLDWfr1V/vyejEXwX4VqOje
 ARGI4cYJen586ARETMZdVS2oFBFBUslvdQUbpsV4WwM66EjTukJuOwt+7SXretBiHFMJ3Nd
 cm/N+6CiIs6n0MfJSQCvGIEUdb2TUNYkMLi6jBHladh4tQtUzXt1cejqw1ia0y/H6wzFqju
 uX/NzdtRBuE+n38FjDXXA==
UI-OutboundReport: notjunk:1;M01:P0:XSvMA9Llsz4=;icm/YofIo1so/4HbRci+xQX0SwO
 jubnXm8F+mX+3k3KwA5/4KljlWVbCkD/T0GFGp2jlJgXCTv1XFcZLQL5x+v4XNYs/qJETNEtH
 ksooLIZDJ9XJ9I7i3sIxNymxvkQ3rWOh9YClW3dl28NCcO1cjAtVnJ2mq57jlcuv+XbfShN3c
 YhBD3iraAOqR4NkqicfIHq1hJKkt7chHQ8VGeT4SWBCAKl3YGNMWSsd3ymEsTuHF46aezlhBU
 gU96q2AIthSCXUxtoM7kX7OgbGra3U28ClFUZlkf1ZBQ6ISFERl4ZNXGfPfY+JV10+/tBypNb
 GwwQZUM4t0JfRyHinh3+N2ifXWFSMx2QeeAbJgi1faVwi3PLwbkT0011xfYVdDibEXWWS2T5T
 rUF1BjVt7gQWtRaNrggtAwoivrPYZzl/ZMdlFvhcHl1kBNR2l8STOgiUkE8+FevL55/6DcoZC
 T6Ov9cis03IR8ODYsXAV37ZCpRaE6s+PTlN22MShUp0ztA0PNKVb6ODjkhOJClXD496crXBqW
 c5hZ2FS5luLYMDRiNvJS5gkwq1qO+TuEY6YCD78KJBOk9Ptwzy7bpfcX0FSsw/SocIuRVwVvi
 QgCS6zp8P+tHLtq6Ue3UsbARc1OjgjM5RXUHoR+BRdnKK4NVXhQ1zoLuQgb8QnxcqKpjaneaK
 3Zku6o78zoifxDVF96HBTgBY6FDaNuGTUEzJ7yNffAvGdm3bGIuOb6gidpj4tQnOQ676zAPH6
 byeiIZaZDvO3c2gCqG/wTW4S0jF23xsajrxaAqAkk0R+tyuksoxBMhgR++3Befwz8/y8Bxy6w
 bJg3Bi0CrjBWMZc4zonDDa7DwNdBwM87U1XTBVW6GiYudYEYo/1tfsRYgRwRC+BgkWW61Skok
 0R7ULawn7tqk9DDPheURmttHmh0Cu5yA9jY9mPGKCMj7+a5H6ymPgG93dytPp5ROWMix94jzl
 y/ZeeFKPvTbT+8w6vxUcT/xAO5U=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Prepare the removal of the parseopts member of struct diff_options by
using the API function add_diff_options() instead of accessing it
directly to get the command line option definitions.  Building the copy
by concatenating with an empty option array is slightly awkward, but
simpler than a non-concat version of add_diff_options() would be to use
in places that need concatenation.

Suggested-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 diff.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/diff.c b/diff.c
index f1cf13e8e7..f6d85122a9 100644
=2D-- a/diff.c
+++ b/diff.c
@@ -5702,15 +5702,19 @@ static void prep_parse_options(struct diff_options=
 *options)
 int diff_opt_parse(struct diff_options *options,
 		   const char **av, int ac, const char *prefix)
 {
+	struct option no_options[] =3D { OPT_END() };
+	struct option *parseopts =3D add_diff_options(no_options, options);
+
 	if (!prefix)
 		prefix =3D "";

-	ac =3D parse_options(ac, av, prefix, options->parseopts, NULL,
+	ac =3D parse_options(ac, av, prefix, parseopts, NULL,
 			   PARSE_OPT_KEEP_DASHDASH |
 			   PARSE_OPT_KEEP_UNKNOWN_OPT |
 			   PARSE_OPT_NO_INTERNAL_HELP |
 			   PARSE_OPT_ONE_SHOT |
 			   PARSE_OPT_STOP_AT_NON_OPTION);
+	free(parseopts);

 	return ac;
 }
=2D-
2.30.2
