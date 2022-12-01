Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E063C4332F
	for <git@archiver.kernel.org>; Thu,  1 Dec 2022 22:53:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbiLAWxb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Dec 2022 17:53:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231175AbiLAWx1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2022 17:53:27 -0500
Received: from mout.web.de (mout.web.de [212.227.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 414427660
        for <git@vger.kernel.org>; Thu,  1 Dec 2022 14:53:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1669935197; bh=YlMPo0eF7dsyvxRXVaCLOkLL22l8alVyaOEaekmHgp8=;
        h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
        b=C9WevTnIZknvkj6tZpkvROiEEUB5+k9HEGVsNX+n7J/d9QtJ+qU1scxDYdxyblU14
         LOxbsgFNIt3faKnMW/ly2NWOdmluk6mO83XzJxl8zqgoZcFSSUGgSKfQEoV4cOzL7x
         55UnPE/LsJ6ZyKxJefxe2AdKde/Y9oiUeeULJfHnK0+E12fiUbjtWCKaTtL3OAQHYg
         262E3tbImXiHGDr2parNmm6HpSWJSAtpf5QGqWFym90eJPZ5uFkyeCDoHmP7qxUHGq
         orDp+5+xPwF2K6x3MkuVG317Mey09BX/CqKZbrG8rMljc5ZVDAVNSFPWyslhJOaTFs
         8ukBstliOodsQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.34] ([91.47.154.159]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MT7WH-1pQV622TT5-00UnGs; Thu, 01
 Dec 2022 23:53:17 +0100
Message-ID: <3816dd61-ee61-94b4-a2b2-49ee07986c5b@web.de>
Date:   Thu, 1 Dec 2022 23:53:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: [PATCH v3 3/3] diff: remove parseopts member from struct diff_options
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
X-Provags-ID: V03:K1:5hvn7/o7gWz25o74SEbQ0baXFq5Sy9thubQP3aV+BIKqFHAkbjP
 4uIIPV/s0VOE5FV5mQynNb6UUzveoFLvaxThOlml9wD7oaVk7Zs9yYoJvdl+1K97D5ZEC4Q
 glN1By2Dqsm9d5rA1vxN71K9kdwnQD9m96wQJ+NSsAmjrRf0Kxif+1LRC0Ws/p5R/fo9VoS
 01SNeSpSxbY5U2VAu9Pbw==
UI-OutboundReport: notjunk:1;M01:P0:fZnoYyY319Y=;nBF4dvLK8z2rOaKSCwr31rLOaJ/
 JkdnL2F9bUYPxcurYaINd4XxxJ6hQrDwn2lEcaSE5zH6uwt7HdhynKXhkcoUtG73AERd4r6OD
 dFpbBh1ANk4t7v0N+Jb3NHDep5/wxw43PpoS6nmpftpwUUwDyNGD3taMXkcU9yQU2gg/z0UEZ
 GS2t+C4nZTEi49jqkQRBb0kmHO5e1Y/3SeqfD1+7lrBUqgEE1GnmwQAfnuTlpH/2PQ1LaCrDB
 UML2UBrrQlxCuzXMtdxIPgA12UCZObpL2w902R2vnw3mVXOd3PCpjGh7IEJ+o+i0NbiW5Wu3L
 jaPzAOiWhnAHpymnVy7gpP6i4rD+jZwMbYhlxZo+0Hs8/MbIhScvdU0qJHfAVvj02NDCFCS7e
 C/P7zH4+eG/NSGbWG5PcdE39Zt6MYDPcLCr6NqzegwtH+r92h9xQebiiLApeH/52c0FNuhByR
 u1RnbsFMv7CDwjqo6b2C36anL5jLH9CiCWY7z7T4yRvXmqJX/AxuKLLWLomxSbOQK3XeU5Q5/
 yjYzQPpfEiGsGmCqeylcUe45HVnxTrREoTDVoVkbbRtWlu3dGn/Kl0eQT/bc6I2aWYBtJjDvQ
 XVa/7W9tIZEn9HxfxqAV84GYHr3Ua1o3C/uGmRkcEpk2gU3tv8+OrHz0Aj9URJu/KhsVkTtRq
 4wba+cz2bnf9OEAKXBku9N2N5MSH++H6FeRr+sjt4UKVt/0oOXzcfS0m4q7zs9hEeFKSsyBC5
 0DWfodhAxUdPiOWMAh7TaAmQki3iNWEqLGkMFh8fmhsYB/aTE/2Y0NDlBoZFxRZjlZvwRIY/t
 sqfZaa9V1i+iPGc/oODBg5010lrjrQCi2jt+vnl61ocAH2C10Zp1r3/ahW5M6napm2ZS0mE0U
 nuW4uTyP5fWPU/9gqtM8twWAWqbL2ule0c0N7jhULJEmPV27kxcJ0cbJ9Mntz9b4lDfqXpvvo
 ZeGEx0oTQ/zzGQAhJJ6DJqHFEpg=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

repo_diff_setup() builds the struct option array with git diff's command
line options and stores a pointer to it in the parseopts member of
struct diff_options.  The array is freed by diff_setup_done(), but not
by release_revisions().  Thus calling only repo_diff_setup() and
release_revisions() leaks that array.

We could free it in release_revisions() as well to plug that leak, but
there is a better way: Only build it when needed.  Absorb
prep_parse_options() into the last place that uses the parseopts member
of struct diff_options, add_diff_parseopts(), and get rid of said
member.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 diff.c | 15 +--------------
 diff.h |  1 -
 2 files changed, 1 insertion(+), 15 deletions(-)

diff --git a/diff.c b/diff.c
index f6d85122a9..4dfe824c85 100644
=2D-- a/diff.c
+++ b/diff.c
@@ -4615,8 +4615,6 @@ static void run_checkdiff(struct diff_filepair *p, s=
truct diff_options *o)
 	builtin_checkdiff(name, other, attr_path, p->one, p->two, o);
 }

-static void prep_parse_options(struct diff_options *options);
-
 void repo_diff_setup(struct repository *r, struct diff_options *options)
 {
 	memcpy(options, &default_diff_options, sizeof(*options));
@@ -4662,8 +4660,6 @@ void repo_diff_setup(struct repository *r, struct di=
ff_options *options)

 	options->color_moved =3D diff_color_moved_default;
 	options->color_moved_ws_handling =3D diff_color_moved_ws_default;
-
-	prep_parse_options(options);
 }

 static const char diff_status_letters[] =3D {
@@ -4821,8 +4817,6 @@ void diff_setup_done(struct diff_options *options)
 			options->filter =3D ~filter_bit[DIFF_STATUS_FILTER_AON];
 		options->filter &=3D ~options->filter_not;
 	}
-
-	FREE_AND_NULL(options->parseopts);
 }

 int parse_long_opt(const char *opt, const char **argv,
@@ -5421,11 +5415,6 @@ static int diff_opt_rotate_to(const struct option *=
opt, const char *arg, int uns

 struct option *add_diff_options(const struct option *opts,
 				struct diff_options *options)
-{
-	return parse_options_concat(opts, options->parseopts);
-}
-
-static void prep_parse_options(struct diff_options *options)
 {
 	struct option parseopts[] =3D {
 		OPT_GROUP(N_("Diff output format options")),
@@ -5695,8 +5684,7 @@ static void prep_parse_options(struct diff_options *=
options)
 		OPT_END()
 	};

-	ALLOC_ARRAY(options->parseopts, ARRAY_SIZE(parseopts));
-	memcpy(options->parseopts, parseopts, sizeof(parseopts));
+	return parse_options_concat(opts, parseopts);
 }

 int diff_opt_parse(struct diff_options *options,
@@ -6523,7 +6511,6 @@ void diff_free(struct diff_options *options)
 	diff_free_file(options);
 	diff_free_ignore_regex(options);
 	clear_pathspec(&options->pathspec);
-	FREE_AND_NULL(options->parseopts);
 }

 void diff_flush(struct diff_options *options)
diff --git a/diff.h b/diff.h
index c20a1ad76d..41eb2c3d42 100644
=2D-- a/diff.h
+++ b/diff.h
@@ -394,7 +394,6 @@ struct diff_options {
 	unsigned color_moved_ws_handling;

 	struct repository *repo;
-	struct option *parseopts;
 	struct strmap *additional_path_headers;

 	int no_free;
=2D-
2.30.2
