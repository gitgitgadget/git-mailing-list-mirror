Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C4A7C4332F
	for <git@archiver.kernel.org>; Tue, 13 Dec 2022 06:48:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234276AbiLMGsK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Dec 2022 01:48:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233753AbiLMGsH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2022 01:48:07 -0500
Received: from mout.web.de (mout.web.de [212.227.15.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EAC318350
        for <git@vger.kernel.org>; Mon, 12 Dec 2022 22:48:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1670914080; bh=YayvpdZstwKrR13JxwnV5p1Hok3PqY/WnA4gHlNddOM=;
        h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
        b=JkGwCbmY+6uKQuQepKHnE47rUbEQLSjaJVPtI+UtKYUXB69kii0DeK0tAyriTgbYL
         YqSJ+6/zPa1zc2HRhZZPDl3Ydd8+PbxkrS8DzfJmOAvlHStEQdU70SYpRlW1+g+ZhB
         +KKteizUS3HMjVStrgcC1e6+RmqJiMv5Ggf6E3txb/urhN+0wLzsus1arXv7SZnCk0
         Nr7N1Mp8A+W+c7UXANwW99/WeAwqGEc4YMlLK2f7IOXK7uW7tGNWS0Apllaknrt5FQ
         NdPGRU8Jf28w7YNIkdc4l47alCizbYFmmrmpfBVtp3O9K3rNV5RpJznKZnFTrAXkdc
         Z6zeaVSJOnBJg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.151.35]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MumJD-1ooQ8K3ckV-00rZmU; Tue, 13
 Dec 2022 07:47:59 +0100
Message-ID: <baf93e4a-7f05-857c-e551-09675496c03c@web.de>
Date:   Tue, 13 Dec 2022 07:47:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
Content-Language: en-US
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] am: don't pass strvec to apply_parse_options()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NdilvVvsoYtpKX5wzYg1qendMc1uZRK8douqhbcJtWQixqidSAo
 ZbLBOTlTYoq8Brr7nn/XLowZ7GlgvCoGfAq5q3ewr7XVq5+EgF55qphD9e4uN48m8tIP2yZ
 WcX+LGCZ7Zy2HZgnUII28rkiZfh/yDhN8LGPKuRGANPviYKjffcTIdraIKVT6x0+TE5CDHs
 MU8AeRdkWGuxbWYSTESrw==
UI-OutboundReport: notjunk:1;M01:P0:ysCJK4c2YeU=;NDUwupsDmSwyoLf2exD+gM2lyD4
 mPLmZSqGqq61r2LkebGUytJWw4blp6I8YCd4A4IIEGW9QT+bUf+grliDYRiYKQL+r+xa/COM4
 oair7crvpF2BP584f25FW+/7bzdLUKuljt5+XjIGqqtPgQQxmg5JCi6tfPYNhBSV5Duiwr8YE
 qBKaueAIX2hrbFVdJODdIAoYTjw1Xsyud3LQc+8fEMEIeFoiGpaF8o4HWos6OGzBQ34LO4kj3
 TmrSv0iugx4Xp1F4KRQjfZNQ7/7rMLsgn3SQ8JE3n2Tf4yDG+/7vlyZuX9HMuk8l1o18W80VR
 Jjqs86APbIe2lHoEJ4BcBN134fFR0gaopHR6jTsHWOzSmi+Esa1sEwHLBnPYUKfv2gfr0rDHk
 Os0p3uK5Ht8mBItxlVbUX3Z16v9wbZ4e+BbwQ7kaFunx8RhYtsfdxru7WULWvzosGyoEenQlc
 2rUPh5+0nsomiY11OEzUK1Uv5U0FrG8zlpQykyafLpMOW8uk0N+ne/SNUelpYom1cA0tz8sko
 xfO+Aip2Nu0CMSwVad9fjpltGV0dIxccx1r1RTKffYkfOAHswlBIjM/BYrmHFrLImwGTe0+82
 Vhz/lG9HWXxUJyRE96hk9j6j3hcG+wqLUhcjPGU51Wk/kfo9MWb1Q3RP5N5Ha/S+/rfxSDt/H
 EzmLozu5MJLjWvtlFjdYv7LnqLl2f12Wa4nbmcS/n9IylCXm6OIEyuPLtl9GVP735YMAyX9sl
 vsdeh/KAn9R+Qc+DAQVhN242VCVK5EFeQJfBXLWt0b0p0eqKdVj7e0/cHjubmfD4RLxSMuxI7
 8vjYWKz+0boMDxZ+Oh+56iLnwsQAFiLgXt6nuz9zJusG4P+KYFQK3Xr+6tw+5Z6hOVz2IZMbP
 YdFQTtXOCngrd/8/ehNq46e6lGrRqEKznJ5Sf2vVc2xhDqDFw7hY8ytZ3nkMFw3UDKzMU/IFs
 ohuXFQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

apply_parse_options() passes the array of argument strings to
parse_options(), which removes recognized options.  The removed strings
are not freed, though.

Make a copy of the strvec to pass to the function to retain the pointers
of its strings, so we release them all at the end.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 builtin/am.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/builtin/am.c b/builtin/am.c
index 30c9b3a9cd..dddf1b9af0 100644
=2D-- a/builtin/am.c
+++ b/builtin/am.c
@@ -1476,6 +1476,7 @@ static int run_apply(const struct am_state *state, c=
onst char *index_file)
 	int res, opts_left;
 	int force_apply =3D 0;
 	int options =3D 0;
+	const char **apply_argv;

 	if (init_apply_state(&apply_state, the_repository, NULL))
 		BUG("init_apply_state() failed");
@@ -1483,7 +1484,15 @@ static int run_apply(const struct am_state *state, =
const char *index_file)
 	strvec_push(&apply_opts, "apply");
 	strvec_pushv(&apply_opts, state->git_apply_opts.v);

-	opts_left =3D apply_parse_options(apply_opts.nr, apply_opts.v,
+	/*
+	 * Build a copy that apply_parse_options() can rearrange.
+	 * apply_opts.v keeps referencing the allocated strings for
+	 * strvec_clear() to release.
+	 */
+	ALLOC_ARRAY(apply_argv, apply_opts.nr);
+	COPY_ARRAY(apply_argv, apply_opts.v, apply_opts.nr);
+
+	opts_left =3D apply_parse_options(apply_opts.nr, apply_argv,
 					&apply_state, &force_apply, &options,
 					NULL);

@@ -1513,6 +1522,7 @@ static int run_apply(const struct am_state *state, c=
onst char *index_file)
 	strvec_clear(&apply_paths);
 	strvec_clear(&apply_opts);
 	clear_apply_state(&apply_state);
+	free(apply_argv);

 	if (res)
 		return res;
=2D-
2.38.2
