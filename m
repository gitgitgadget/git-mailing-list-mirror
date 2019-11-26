Return-Path: <SRS0=BbQ7=ZS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97F48C432C0
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 15:00:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C44A2071A
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 15:00:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="Cq3YM5rg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727586AbfKZPAt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Nov 2019 10:00:49 -0500
Received: from mout.web.de ([212.227.15.14]:59813 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726049AbfKZPAt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Nov 2019 10:00:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1574780444;
        bh=ibYruRBW1E6npnGlMdpMIsAwQQy9p2XQnJZC4Qps7Vs=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=Cq3YM5rgMNi0n7xNuXysM8bK+f1t1fecUW7/HWFEUTKo5d84OmVjy4GE5z0Wmw8Zz
         ys4m7QymaqNjV3iU96UzKzsR4lw+Lh79AzmdZOys0Py/4cyfLXQY3W+oVRzf6wM+dt
         Q+mWL0FRFyMm4fCfU6BREd0e7t2zUaanlBOASVQM=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([91.47.146.29]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M2Mq4-1hhvJf42K4-00s3QE; Tue, 26
 Nov 2019 16:00:44 +0100
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] shell: use skip_prefix() instead of starts_with()
Message-ID: <0a4dfbcc-9eb5-6b39-6b93-0014f5c475de@web.de>
Date:   Tue, 26 Nov 2019 16:00:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9meMAPQ77qKqcQWUjWFly8wZWapsMiEtK9tYAxBfcCYapRvybS/
 UePIFy+qwm/9yZs8m737zoVJIn+myTFlzywlZeaQ07fjmooLul///O76NDdvvm1G4/zhryg
 boSExSm614A8WdUkhF2+cYsBsnbgBdDQN89VH5QPnbhuF79YVATdsbYKWlAhFpXvJCIXmG4
 Anfj0g55w15W76C0Z1oSA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:GoRHt3BJI/k=:6K5LfHw/W4jYtnVgyxkPcd
 CjX2XJNXy97/cMfamM8MNAT44yTlocTBN3ouydOOWr2bd9faQPU/hx5ynhkodlRARUADSjlju
 ZBgd46L2BagO6r8i/Qpsj604WOh2l5ymGQ2hI56FPsjSQW84ubpLxBP4RT8L43+hF8LFNio84
 A7oPAFBuRK04YT9MIkPcgRbhkn4yBs70frwu0vWCvPyyJWwIgu5whdz8dr/eDh2RlIW825+Rv
 gF0V8qu46/MrleFyJTxc1Wru+3kyjq5QSSWTB00wcpsxJQaNqMkzNFEhsOPztqqqOZRW/Itsm
 KEDEnLa499ChGe4oxcJQKlL78egxpqCsSOorA9m1n4V9Ah19uiWQ9wKPmaabVVUrfWewu2rdu
 wUwR5zhNmU/87GnTvvil8Lt+YpD6u9ZwxPymwLe6l+M9uSoUAxdJjJqs3lMs3WsIyatLcknSo
 vfbZ8SOY5HWuRDfsHa9UOhrPHSXCccV+mvBSi6Uh5UI18UD/CMekkCgaErx8h3d7iImgC3tCp
 wjzkWRLu2BedvPBqvVB66uwtKZ+GS4WbcG/lCoTykBvnTAFw/VY5guEaL6oenvEojpa5YatWW
 hVhpPtmsj8HQvj1Wgv53KsHQd0NVflWlyxjIQ2ygE0AcMIYm5phRPl5tMwyrdQmHxWUy5IYnI
 nA3fXZeNDrewfvDL9EbaUAkhl6NygeBR5PEU5inb1STX4llay0SCnMVV3alsA8y134AhXLTxF
 gh7NGwGbJvjCkVxnNvHIoFCxfj9LgG5oo93AaVLRealVu3LHZf9OYe93eood7UVWOhjiexLom
 UIaqXsn6h08z0zDB0A8MPA0pDDHekp+CrgYwpsxIRlTfs5oiqcy4Zc5tuncDIYJ2lsWxdT0V8
 KhwVcSkelOTo5U9hVS2KcSTG47Att1GhR2IxQYoiPkEivrQI737PL3vklpewoBdik/PgPtPOZ
 Mh72zz+wnwU6YI4M17u5O6u7lhz8tVt2ekw0LuoJgv0F8t66rK86r1658PoPcjMtdw6svdgwH
 REOtbjCIYCI4trY0bzfsjqHpLyMYubSKo3m4j08ZEmMNdBb4FV+23Liyfg/3Lwt8Ces1SDxSc
 OHYWaIWHPOJJKNWgANW2TCoRYB5xaLUFcMAf9S3jqJIRwhIoOfEhrFTpnqHIjWf8u0dyloZpj
 StaUo6oeTZViThC8BivSjQ8WVOpiT59HCNsPXqNQtVcLrVLwXWhuK84P9ZtdE6QQ+VhlUY8/W
 b1pf8zwJr7t0zTEPtIYkkP1oQmWSnHptwmElNMA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Get rid of a magic number by using skip_prefix() instead of
starts_with().

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 shell.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/shell.c b/shell.c
index 40084a3013..54cca7439d 100644
=2D-- a/shell.c
+++ b/shell.c
@@ -16,10 +16,10 @@ static int do_generic_cmd(const char *me, char *arg)
 	setup_path();
 	if (!arg || !(arg =3D sq_dequote(arg)) || *arg =3D=3D '-')
 		die("bad argument");
-	if (!starts_with(me, "git-"))
+	if (!skip_prefix(me, "git-", &me))
 		die("bad command");

-	my_argv[0] =3D me + 4;
+	my_argv[0] =3D me;
 	my_argv[1] =3D arg;
 	my_argv[2] =3D NULL;

=2D-
2.24.0
