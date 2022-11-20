Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F99CC433FE
	for <git@archiver.kernel.org>; Sun, 20 Nov 2022 10:08:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbiKTKIA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Nov 2022 05:08:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiKTKH7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Nov 2022 05:07:59 -0500
Received: from mout.web.de (mout.web.de [212.227.15.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02C5D711BD
        for <git@vger.kernel.org>; Sun, 20 Nov 2022 02:07:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1668938864; bh=ss9oV8qrC1wV+87ts7pUNHi/Ib17sbePie+Y5nQZtYw=;
        h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
        b=wKp9LcUnS/BglIMVG5jwWI06Y/Xc9T/Ql9p48d9MhBt608W7lQVpiQ/ZWfjQ3Mllx
         d+HymgdBrhvrwOrKibKQCmPCD1TMlbMkFSQufWa00UZkqqprYNuqx4vgsibKzTaGXh
         LT/U/RR0OvJ3upoazbTkHU6mWiNOMmz3vEdwkiUx61uRxLY4zd6wY1/JGrISuRvemO
         2/8AyjBVov/bes/S3L9BytoUp9f3uuI6RslDU6uR1MikIv1V3/uyhtR+NWoQt3dOev
         CXyDOIXWWc4sIO/rwPE3zpuxhESEWZ23+EY/9o0enPcGxzCo6iYNUjftiDwcwVP8T3
         mgrsqY4pICmuw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.154.159]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MQ8Wa-1oabya38U4-00M3TL; Sun, 20
 Nov 2022 11:07:44 +0100
Message-ID: <0c6722e6-e6bc-0f7d-5f0a-1d242359e37d@web.de>
Date:   Sun, 20 Nov 2022 11:07:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: [PATCH v2 2/3] t5317: demonstrate failure to handle multiple --filter
 options
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git List <git@vger.kernel.org>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff King <peff@peff.net>
References: <c64e4fa5-62c2-2a93-a4ef-bd84407ea570@web.de>
 <d19c6cb4-611f-afea-8a14-5e58d7509113@web.de>
In-Reply-To: <d19c6cb4-611f-afea-8a14-5e58d7509113@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nXEAGIET0akLFuPNqaa5KAJ1qMAcvnoLMhUag7DgL5xVMFhpexq
 vPKGT1apgPlOqfWeYBzAiEUQzB3OHViK1SKvPZ2fG8fFlnxmiAbEMPAL88hpbl3cB/vxVDZ
 vHkc3zkbDBPuqYxS8VIZ4gTlIw5obRpaAZd+k6yWgmJ1k83AhUHP80m+tinXh98chNL7n7l
 LySi5fCRu0vhJMMJGPPWQ==
UI-OutboundReport: notjunk:1;M01:P0:JebrDoyL0Hk=;QLt8IT5VucH4W0gT2SwDlwDqOq+
 MhSDOkrUt3e/knI3ZloGzWzZm7FkN4kIBvssZ8/ewsu3bNk4MQo0jGsDDl6pUJbV54Lpw+If1
 aRWnbghZo905leFeXIZW2PmBBm2cju78jIhwf9+WmPydx5kUnIQzIWJ0tSTmdqor/z91JIcm9
 Hew/81VfIY2ZXvfRofX9A5bQNdkGLGqBgy2K9sQDBPq+gIJ5G0wSiiZWki+zIPgQQeeL9Tnj1
 k3M3v0MDc1c9fFuMEiCgkwd+IEu3ZTcZtfOKd+YpUDqeouBEphZcjK4l/a+gPF09UR2fg7K1G
 wXGbjluuAtdnIG/APiowH80l3b/6wNwkPTUZGyWvawarB0GhtKvVSznk/+QgeMaPEbV/IzCMQ
 ry0CUmltRbv9IHx3Y62RtBKIhif70zHYhrqHLAgspKV+xPvON1BD2KWYd6NCM+X0j4949dBV1
 37uG3XXIzzqfRvs+TA3tN3a1/T1/+qpwGUD1gbz9xYljQS10eNnEbn66V+Mwkd7783IOQyblh
 cNcYhVD5fyKIPkt7p6FGggshpZ2GAOuM86bXtWqIVfdJXq9UqQeuqKLA/EdlTHqtGvol+hHCZ
 qTaySabgt92XmUWMVGq9xY9mA8FFWvWkYkTKJjYinHbOTc67ZQ69xu2b0bWnFAUSuNrEdEBAg
 4utvqvHWoErwYuuH6UFscSBP+7nlEeDYdZv/4OLZnJvSU0Sm1/v0jaO22eRmEj8GEZG59kpz/
 a8/Dqm7h6lI73b5Evs7HPYpUGXJXmotZApjkvk4kn4EHinb8eDl698QORHmzs/tcfDDFe61Rz
 TCJSN/pjREtvjqrZPAiy3F00ufovQYV2oLZN+YXzvNhHak7CnQgyO0UxE+M95ww3KTMUfAshs
 mUGy5rD2kIDTBnVn6t27Sm9kXuvNENAKyXR1xTbH7DCIERAB0hbiEjXQsefSfQF9ARnSF8wwJ
 MVWS8w==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git pack-objects should accept multiple --filter options as documented
in Documentation/rev-list-options.txt, but currently the last one wins.
Show that using tests with multiple blob size limits.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 t/t5317-pack-objects-filter-objects.sh | 38 ++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/t/t5317-pack-objects-filter-objects.sh b/t/t5317-pack-objects=
-filter-objects.sh
index 82a22ecaa5..25faebaada 100755
=2D-- a/t/t5317-pack-objects-filter-objects.sh
+++ b/t/t5317-pack-objects-filter-objects.sh
@@ -265,6 +265,44 @@ test_expect_success 'verify normal and blob:limit pac=
kfiles have same commits/tr
 	test_cmp expected observed
 '

+test_expect_failure 'verify small limit and big limit results in small li=
mit' '
+	git -C r2 ls-files -s large.1000 >ls_files_result &&
+	test_parse_ls_files_stage_oids <ls_files_result |
+	sort >expected &&
+
+	git -C r2 pack-objects --revs --stdout --filter=3Dblob:limit=3D1001 \
+		--filter=3Dblob:limit=3D10001 >filter.pack <<-EOF &&
+	HEAD
+	EOF
+	git -C r2 index-pack ../filter.pack &&
+
+	git -C r2 verify-pack -v ../filter.pack >verify_result &&
+	grep blob verify_result |
+	parse_verify_pack_blob_oid |
+	sort >observed &&
+
+	test_cmp expected observed
+'
+
+test_expect_success 'verify big limit and small limit results in small li=
mit' '
+	git -C r2 ls-files -s large.1000 >ls_files_result &&
+	test_parse_ls_files_stage_oids <ls_files_result |
+	sort >expected &&
+
+	git -C r2 pack-objects --revs --stdout --filter=3Dblob:limit=3D10001 \
+		--filter=3Dblob:limit=3D1001 >filter.pack <<-EOF &&
+	HEAD
+	EOF
+	git -C r2 index-pack ../filter.pack &&
+
+	git -C r2 verify-pack -v ../filter.pack >verify_result &&
+	grep blob verify_result |
+	parse_verify_pack_blob_oid |
+	sort >observed &&
+
+	test_cmp expected observed
+'
+
 # Test sparse:path=3D<path> filter.
 # !!!!
 # NOTE: sparse:path filter support has been dropped for security reasons,
=2D-
2.38.1
