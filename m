Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05A43EB64DD
	for <git@archiver.kernel.org>; Fri, 21 Jul 2023 12:42:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbjGUMmI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Jul 2023 08:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbjGUMmG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jul 2023 08:42:06 -0400
Received: from mout.web.de (mout.web.de [212.227.15.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D7230F4
        for <git@vger.kernel.org>; Fri, 21 Jul 2023 05:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1689943310; x=1690548110; i=l.s.r@web.de;
 bh=7/lSv0I+Z/iAjJmIeNaCYE8r/yVgJjvgLg+P9eGV1Y0=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=mJZGw9TCdSYCuOgQQDomLHegm/0TTfsFSklMbn4VyWX7vIGJGlrHY3xJFMfT3KnVx0S0Cr0
 OzhyflVNZnOHxfvgJNgd5CJq2PmZN3grGFrCIIYGO00Ug0Zboyl1tLMlmqyC5cBeqF/OzfnrW
 1eA/J/1sjS6nDjpDvJ3UuDsK1Mka1df7heSZTP8djYDko6g9E+TsTK92OLNJDtO0rfWWMgnO/
 HhmZ3XPLtPtjDNlCZo9xZfWYGIHzYcds1NL753l/of9GQ4/Q2GF+j2TNiDdA9XDsd1+3UzvBu
 KPNrFvU+7pCWcBM9RdUiHjDdXQVbEsRWlfKdmAPP/9OsmhD/+f/g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.150.179]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MsJTC-1q2XkC0RxK-00tyCM; Fri, 21
 Jul 2023 14:41:50 +0200
Message-ID: <b35ec7dc-3c52-6688-4292-19ab83257aaf@web.de>
Date:   Fri, 21 Jul 2023 14:41:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: [PATCH] reset: disallow --no-{mixed,soft,hard,merge,keep}
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
References: <d392a005-4eba-7cc7-9554-cdb8dc53975e@web.de>
 <xmqqo7k9fa5x.fsf@gitster.g>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqqo7k9fa5x.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Mgu9TnGIZLswoRiuaTOEoVGBZHu7GTgh+m8klNj28+FJUoGtxyH
 4wwtuHVCbgHZgCFcYJ3NMK+l5jr1TH+tXOwWHL4XoyLWlwdgfVa44TCVxpPqRFvSI7bwYNQ
 evrZ9Gwbx7eglfFzsfwYoguiqfNs9clYlgKwYkNE0E3ApDCSgBNccVBRcO3cC42pRH3Zybr
 tjC/ulLFbNo/25vZ9NrKA==
UI-OutboundReport: notjunk:1;M01:P0:AXs9dJh9DFE=;q2xY7rOlnQErJS8jb+AAQh2sA/Z
 dquRyKVCayPcUFnvd7bG5KlXbz/ExX4A1SZerBwcr96cBHL1sRSnC4zgS+DuJTe6blM3lFg/I
 nQqY/lk0X80sYxloMrVfhG7JQZlOmXupZwuUCu+Yx1NKNFde8QFxaDF9vJFiZ7iIhKc/f7gN9
 NddOdMfRJKOswMf21wrbB/Ydd8uiCxJcSOTPISGafEA3uEPNJsvvDFmbVppX5WtA2mZjlBD6O
 Pt0+dL29Ho5krdNO33o5FXolzs42MvgLw3u63/j5E5jr+7ObV/UVXFGTCQpmQnEb9llBhv5H3
 9fi83W7I4ZEGo8MDoH+h8smlJp35BVu6ISsgcXvju+ctJyj9zN9IuPkGybWKE+t3ZSwy86siT
 7g7EKdaQaV3dNYhVuOLxTqvPHfCnHQLrMy1lNLhmL4OzNTmcrxQQRjQYfazHibXAZi1NMVoat
 B79TLLp9nz/v3dW4Yw6HKh46s7g/P32z5PWMGZQywf9zCgHLdTSfteW0MruHfZZllb84W+2g1
 m6lnSVz55iITf7IU/PdWuFg8lY+RMmGSsTATHyxJ2CpV+bIMB5eOuUivo529TM5xJZ16TqVQ6
 eOiufwujLWK7UFPJ9LirvUx3UdaqYdl4iotLoS7iGd2UAEYdz2LArrwjHGT4TNQKpwzjJpV5a
 JbCD8fcyHIVx1fpSdrwpbKAfXFj2U3VrzFp4SK2Pevx4u2Bior6e57ZjraAY8/Y2X4p9OQ3o8
 /WuwREE3pj0jJwzjAcdPGeYQjXEfp62hkv04Y1GCxRLSIXHN3DctSu4TkxLV5P4PNaRyqzEvG
 4HejupvJ8Yx4MGlh7iTnTDz2V1leBAbQCphfki36sL6tHsRIBWBnIAoo0u+IK0NgkeP3iKN2Y
 cqmEEblcq9bmCB9CSUFHmgqqegXBQDjUnH4E2LwRunmRpKTjbFUflQ5FSOU66Cq8TVNaaPi/a
 8SaRQw==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since 5eee6b28b5 (Make builtin-reset.c use parse_options., 2008-03-04)
git reset has accepted the options --no-mixed, --no-soft and --no-hard,
9e8eceab73 (Add 'merge' mode to 'git reset', 2008-12-01) and 9bc454df08
(reset: add option "--keep" to "git reset", 2010-01-19) added --no-merge
and --no-keep, respectively.  They all do the same as --mixed, because
they are defined using OPT_SET_INT and the value of MIXED happens to be
0.  That's surprising and not very useful.  Disallow the negated forms.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 builtin/reset.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/builtin/reset.c b/builtin/reset.c
index 7f18dc03b8..6292859d3c 100644
=2D-- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -338,15 +338,21 @@ int cmd_reset(int argc, const char **argv, const cha=
r *prefix)
 		OPT__QUIET(&quiet, N_("be quiet, only report errors")),
 		OPT_BOOL(0, "no-refresh", &no_refresh,
 				N_("skip refreshing the index after reset")),
-		OPT_SET_INT(0, "mixed", &reset_type,
-						N_("reset HEAD and index"), MIXED),
-		OPT_SET_INT(0, "soft", &reset_type, N_("reset only HEAD"), SOFT),
-		OPT_SET_INT(0, "hard", &reset_type,
-				N_("reset HEAD, index and working tree"), HARD),
-		OPT_SET_INT(0, "merge", &reset_type,
-				N_("reset HEAD, index and working tree"), MERGE),
-		OPT_SET_INT(0, "keep", &reset_type,
-				N_("reset HEAD but keep local changes"), KEEP),
+		OPT_SET_INT_F(0, "mixed", &reset_type,
+			      N_("reset HEAD and index"), MIXED,
+			      PARSE_OPT_NONEG),
+		OPT_SET_INT_F(0, "soft", &reset_type,
+			      N_("reset only HEAD"), SOFT,
+			      PARSE_OPT_NONEG),
+		OPT_SET_INT_F(0, "hard", &reset_type,
+			      N_("reset HEAD, index and working tree"), HARD,
+			      PARSE_OPT_NONEG),
+		OPT_SET_INT_F(0, "merge", &reset_type,
+			      N_("reset HEAD, index and working tree"), MERGE,
+			      PARSE_OPT_NONEG),
+		OPT_SET_INT_F(0, "keep", &reset_type,
+			      N_("reset HEAD but keep local changes"), KEEP,
+			      PARSE_OPT_NONEG),
 		OPT_CALLBACK_F(0, "recurse-submodules", NULL,
 			    "reset", "control recursive updating of submodules",
 			    PARSE_OPT_OPTARG, option_parse_recurse_submodules_worktree_updater=
),
=2D-
2.41.0
