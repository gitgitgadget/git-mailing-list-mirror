Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C8D7C433F5
	for <git@archiver.kernel.org>; Sat, 30 Apr 2022 14:32:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382796AbiD3Ofg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Apr 2022 10:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239177AbiD3Off (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Apr 2022 10:35:35 -0400
Received: from mout.web.de (mout.web.de [212.227.15.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FD0E20BE2
        for <git@vger.kernel.org>; Sat, 30 Apr 2022 07:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1651329106;
        bh=7ejKzOX4jJhJZSuVP3GRNk5HOq2AZDTxqgBNYOKJ4Kw=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=FM57Xsa+8nJa9Z4tMmkTwX3QWXsINjzhcmRV8H+3GQ8Yygs6Q/nBHWAf8SvItTFCX
         lqZiZ7f5txePJg9cI0H5Y6oV9TvuNPNLIwTal+SwfcUiMKwgR5lVe2ScEQZG+42EI0
         dcYgW5CxjoCmDf6k1CywatjQgWrU6+LcPcfoEqJo=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.27.144]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M9Zdw-1no83C0c20-005w9t; Sat, 30
 Apr 2022 16:31:46 +0200
Message-ID: <2c988c7b-0efe-4222-4a43-8124fe1a9da6@web.de>
Date:   Sat, 30 Apr 2022 16:31:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.1
Subject: [PATCH] 2.36 fast-export regression fix
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>, git@vger.kernel.org,
        Daniel Li <dan@danielyli.com>
References: <CAHVT7hW28jMcphDPhcUG==mycCWDaAt46wWo68=oTcSvebHWwg@mail.gmail.com>
 <xmqqzgk388tt.fsf@gitster.g> <xmqqo80j87g0.fsf_-_@gitster.g>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqqo80j87g0.fsf_-_@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DFAwuHcIqnxvNpofmZsuhrQfsH6a+GowYOBeysm98Mivb6KQWNp
 IXSTZ1mFiaaYsz6A10UK3IlNJqJ9b54BN4fadVchmyKT+JIeqg1aveibtfakLv3qCUwjDeo
 ZSnI0rCySmgr6w92/30tkSMaP1wJJsIFRGP2/felSzJFcL3IXfuyqlxQ3rFTchdqNFU0PAt
 5BCW4n/Iyax3sc5y6DTOA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vcTOu8n18OA=:fp4QEFtPGZrnihY8G58jm7
 EL45qsc9Nchg9ejWvHlGrcwtQET2iHbDanqzpRTmM7DWCGHQyC7200MOryay32Ulv6Oj3cXgH
 3m1WR4VTvfFD/miEW3pxImKSV2EZj7dBeX2mP78qmMGYjaQ7iqjaDoYFNZgSZtBrx8st0oZab
 tV3UsDl7Nn279oEgw7oTRbmwzjA2nYUXxNR6jOmTYXXFdp9gDV54ux7S5svgFvbOhwEFv+a/2
 R3Ocsj28uiwflxI+S3TAtZU7SGgqi5xxZKLYBpob63bZFakTRcbFbsnao5Cuo1u1BkJNJQMJ7
 MlXqoNcfUnwmCC6mEfloQNQuWpqsGD9UkKpW5OFoqusPEnN4chLBQo+6MbsDxDCBVgmejRhWS
 IuCZoMgou97h0pzJnyJdHmVhTSdWO5iN9l9YIfQTspY/nuHYcFjqoGXrka4tSPLFuXIvN84QR
 6CKjz4PoGV5D0cI7ws7galJ0IHMsvmrZdaNVuppUPkS2vgBgc4BB33CK6bQfVoKm0BxhTUYwU
 Q6IpiXPqiixh4HhHqBD7USzKv36buhXq+Pau/vhjJc2jYY0+YptgjwwOj4r8IZAbQ4Mjw5UmX
 3bbtLxQkbliCQGtLSDufRiAJ/9tUSHy2wSDII27y/8MZbd9xTNgcEEXTlUntqJtTbXBCdh4X1
 si917dk9DhKfKBZ1dcR94oblopbb4I0FG5G1sMKbSNVFHUgFdJmaF0WbMylFXrp6KfUENdh/a
 bN9mR6apspD2G/siOSzCyKntARQ6dPymt9zuTfM4VhO1CiscG+8I5L2TOMSPwin439e7G5Od5
 EIH8yHQwCO7nJlipZHD0uRaQEzOf4qF8+sMTgIIO7pQrhep/KGln3M1FTvEdI4dWmXPWsliKN
 OC5fLpx9xZltFClBHBf+tm5IBqMoZFE03m/Ar72ymjWkWwl/i9cbrP0VHF79WcHI+lw/ST2R+
 CKjrKoRvRD9DFWitsftnOBW6ZqVjzArEKm0kn2l+CQwlBTHruyqx43petrhJ0VWp0290P9+XO
 8qeJN5KMhKvDJ7+gfGheaMwgKJ5a6F/LR58uAC9ozwJE75PZdkZNvPnKlzVpeuvYi+Jt8UI/F
 F8U1ugmTwAwvjw=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

e900d494dc (diff: add an API for deferred freeing, 2021-02-11) added a
way to allow reusing diffopts: the no_free bit.  244c27242f (diff.[ch]:
have diff_free() call clear_pathspec(opts.pathspec), 2022-02-16) made
that mechanism mandatory.

git fast-export doesn't set no_free, so path limiting stopped working
after the first commit.  Set the flag and add a basic test to make sure
only changes to the specified files are exported.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 builtin/fast-export.c  | 1 +
 t/t9350-fast-export.sh | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index a7d72697fb..1355b5a96d 100644
=2D-- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -1261,6 +1261,7 @@ int cmd_fast_export(int argc, const char **argv, con=
st char *prefix)
 	revs.diffopt.format_callback =3D show_filemodify;
 	revs.diffopt.format_callback_data =3D &paths_of_changed_objects;
 	revs.diffopt.flags.recursive =3D 1;
+	revs.diffopt.no_free =3D 1;
 	while ((commit =3D get_revision(&revs)))
 		handle_commit(commit, &revs, &paths_of_changed_objects);

diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
index 7b7a18dd2c..fc99703fc5 100755
=2D-- a/t/t9350-fast-export.sh
+++ b/t/t9350-fast-export.sh
@@ -500,6 +500,13 @@ test_expect_success 'path limiting with import-marks =
does not lose unmodified fi
 	grep file0 actual
 '

+test_expect_success 'path limiting works' '
+	git fast-export simple -- file >actual &&
+	sed -ne "s/^M .* //p" <actual | sort -u >actual.files &&
+	echo file >expect &&
+	test_cmp expect actual.files
+'
+
 test_expect_success 'avoid corrupt stream with non-existent mark' '
 	test_create_repo avoid_non_existent_mark &&
 	(
=2D-
2.35.3
