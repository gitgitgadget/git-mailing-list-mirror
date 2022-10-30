Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 359FEFA373D
	for <git@archiver.kernel.org>; Sun, 30 Oct 2022 11:46:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbiJ3Lqa (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 30 Oct 2022 07:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiJ3Lq2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Oct 2022 07:46:28 -0400
Received: from mout.web.de (mout.web.de [212.227.15.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89F72247
        for <git@vger.kernel.org>; Sun, 30 Oct 2022 04:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1667130372; bh=OMFxcxxR/9U2amqabgibiRfaHL3ATz069Bsk5rxfbcU=;
        h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
        b=I4oZbNUj/XyNX8dRXwOtkJDRVQddKtvFS3L734uK7TRXQwNjuzs5YPO6MoLF9NvKo
         x9H0dhr2HA6xFAyLRjEeN2EyLMWdQt/VTHkKaMLmqWdcq6IVMhnOaCs0lBrDlLQNb4
         UA3g36iH1hyCx3cW9fh8/nI9iFvVR/Otj1LDk9J79+RO8u1U3zb5G615MZIbpBuuoQ
         H1c/iSTL51EuwXbNnJAgFY42ef9XNn9pJmYcv9Oxf+pMNGCQxGa2XSSJkEoMoFemIK
         cRQxPnkoZegGvDz7QEyXeVNrPe6xIzyj+ASB8IX0sSMCVhfjCidKZm7RsBEgVboOsE
         Zu9N8iqxjrm9Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.23.191]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MsaWF-1p4JVA3NhT-00u07i; Sun, 30
 Oct 2022 12:46:11 +0100
Message-ID: <e3a5cf13-d1c7-20b3-3f40-3eaff5a18b67@web.de>
Date:   Sun, 30 Oct 2022 12:46:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: [PATCH v2 03/12] am: simplify building "show" argument list
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <7407e074-4bd8-b351-7fa4-baf59b41880c@web.de>
 <ea061164-b36b-485c-963f-8c13e813a47e@web.de>
In-Reply-To: <ea061164-b36b-485c-963f-8c13e813a47e@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9poGmCsvovbM6O3dTwk7oSRIbKB9T5d6mxC4bX9fQERe/kjeDjd
 KyYo+JwOTFr9he5rDacNK57SFiqnONQz1WDC5ub8vtcur05rFYVUw5Tf07+NSGVVFFPLt3I
 eE6oEm6FhS//h+DA0+/uZbuH66ETJpLE8vJjo31KLhgNaO/KZcFIbG0DylajYPaEI89n97c
 J4vUsJ+6Cq5h6kkteOIXg==
UI-OutboundReport: notjunk:1;M01:P0:d0YNJt9E2KI=;IbfSpF35G67n8X4LuzxvyF1AI7w
 aPgT0xPGF2teww9FmNzbNZ6G2e4FyRJdkjTOHV2vKZXF30bfQdYDIRZjVfES4qfNqPO/3ey80
 tt5bJnoixg2olFBOmMWtV8xElkDFjh+dbpI8PwGugJonjlSI5zdHDe0+9KcRAM0wjvNPPzwRu
 VAJxLaN5IE+m95byH3xEEKOmp2aq8Vz9enwUDB6i00SkqkH006XEOGbStN35Ec9jedNXjy688
 cRQL0nxpp2JTgJRO4ADLwRelsFWFtxBYGHJkghm/H350hjvphkJ2lP92ByrDv1B01yMVP2wsx
 AggGSxS2FNn420ytScnd5/bu6Q0weLLeERyBBhPIUE16xwgp62lNkcnXlWUhSaVucEexzafrg
 GIezpojIMc1IhMWxgS2vVWpBA1dnhzRxpjK+5n81T/FpiOeljHs0CLJTdmyF/+DmFRZuBWNkd
 QahLOZoEWTykrpSjGzGI+eK3wFd+AqYhvE/5oHuGhufC/zBeDymCn+3cPE2cI+D2aUQeqnUFk
 VQRZiQE+tRICxBcTsjqsF17OUTC/zeFl5sKlkwWMXowPWhb7LYOybQ4KeqgNXQhu0hfLLXR2c
 FuapVvu/4I7WySASRdH0m/yDmqwU/B6UbjfJqHAzRRciFbX1adJhi+Nbq1wxsRkr2WfhBrVM+
 Z44lk8xBsEJ1uajo/9Kcz8f+/W/BgqMRohoEafMW+/3bzOXysxuwIz/DBlpCWy+ewMkmsHtRU
 hLLh91Jxs9jGVbAGfQmA5uS0tpPIC/TnRe3GYG7E4ZEVzZUcCQoN63XtNH6XcaZy645vuBvgF
 TuLibmVAnVJof5zBe5IVFHlv1R6U9O6pMCStZORd+ROD3fL6bjsy1YrE7laF9FFJ3d5jl+xyB
 9KcHpnP6m3oNOAKro/8uCPQHzIkBwAkQrzTBD+KEryPsqZaJ5vvEC4DZGuoocLcvW3uG/lSl/
 OdV5ooSRCe7+O3plpd9+SoUFfQ4=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Build the string array av during initialization, without any magic
numbers or heap allocations.  Not duplicating the result of oid_to_hex()
is safe because run_command_v_opt() duplicates all arguments already.
(It would even be safe if it didn't, but that's a different story.)

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 builtin/am.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 39fea24833..5781e7a95e 100644
=2D-- a/builtin/am.c
+++ b/builtin/am.c
@@ -2187,14 +2187,11 @@ static int show_patch(struct am_state *state, enum=
 show_patch_type sub_mode)
 	int len;

 	if (!is_null_oid(&state->orig_commit)) {
-		const char *av[4] =3D { "show", NULL, "--", NULL };
-		char *new_oid_str;
-		int ret;
+		const char *av[] =3D {
+			"show", oid_to_hex(&state->orig_commit), "--", NULL
+		};

-		av[1] =3D new_oid_str =3D xstrdup(oid_to_hex(&state->orig_commit));
-		ret =3D run_command_v_opt(av, RUN_GIT_CMD);
-		free(new_oid_str);
-		return ret;
+		return run_command_v_opt(av, RUN_GIT_CMD);
 	}

 	switch (sub_mode) {
=2D-
2.38.1
