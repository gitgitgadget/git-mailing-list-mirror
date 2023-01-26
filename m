Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AEA6C61DA4
	for <git@archiver.kernel.org>; Thu, 26 Jan 2023 14:47:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbjAZOrB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Jan 2023 09:47:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbjAZOq5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jan 2023 09:46:57 -0500
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2036.outbound.protection.outlook.com [40.92.98.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 594803AB6
        for <git@vger.kernel.org>; Thu, 26 Jan 2023 06:46:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OPximloUeUr2wOBC9VzDttALPtZAs3dKOfOsoTFtifTHZGb2HM8uRiTkQigkpTW8Grra39lccMBPsJKOBhOfPx3VvD5zd3f6MEgVfiglkjf602s8Zp1vZ/In46n5HhBhu4T6c2t8E+ayunhdZeFPMCJ+lIT9KUIGGMOAR+yhboeU6kiBo6jTI0Nuyt0a6rQqPzeIxnz/FcFKlyMWk64PjC5pNdpVttwrzWZIY8Fijkp2my5pOluxP5a5HsKRHZZ4XFUUOwIO4eUNJP+U4ozTU1F+7wu1RjslNzXhTqQ+HhE4wYTKTXTFb5g0VUrHI6a2GIS4MuuCc9FlDKCVDSc8uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NzAokIxfcLpCpjtc5iAQNpllbqbCufUsItLoyT8P+YA=;
 b=T+YjeaYYsXtMr+q9fwbzzSXu41xA6oZnbnoWzF6ctf/hgy5QcEfsIT5lTe8ICAEbnbHq+NkfjEsue8A8xvKZtUmq164WQ2pA6SGqHibcUD6tLUpfI+PtY/RnRFDlui5MTVEA4ECkp/mD4Sp/uBhCVSBBaGKL0Rz+u1xedA/UKZ/eaiKyF+VwTcecyNzdJ+9MOc/yR1eFbI7P/azn+aojtPPxtaJw1BLBFqSWlKvR0i5/hia6TZZO2USiTWwRZ8GgSntAwyrLS+MLjG0Xjn/zeauSZDKlbpk4O7iTmvMhi6BrQ0C0BNiBhRcR2RGjgN4FvwJU4xm1tItJJ1JtgS9fSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NzAokIxfcLpCpjtc5iAQNpllbqbCufUsItLoyT8P+YA=;
 b=JOUxHjPJR8ErLW6yJb40PJoqDy/TTtm7ZheNw4Nq8w6kGrr9gziKXtaQredWkQ6QQ5TXOiQqMjB/qzCq25yk8THeH5Cy+rlEJefuRha3oEp5LpG6Zs6x7eFi58DYYw6Xp4mpBXIuZTQXWDsRYweroIMoS7gxcrIdR2HdI4IztdOgLRUgH2JniIzoZpeNci4btPTS3+40x0tXXhlbEkj9vFGR0jWPnkCVt1DR40t0Oea/lw+WcU0GuUQ777rAyOFTX/2JaVCsnWS9OpbbndmTg2krI3h358JfDLX8jYFlqat3snWA92WP94x/flXatsosXcx+p6FdB8JBvPlptt7FoQ==
Received: from OSYP286MB0215.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:84::7) by
 TYWP286MB3205.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:2d1::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6002.33; Thu, 26 Jan 2023 14:46:54 +0000
Received: from OSYP286MB0215.JPNP286.PROD.OUTLOOK.COM
 ([fe80::1878:5d55:e47:b918]) by OSYP286MB0215.JPNP286.PROD.OUTLOOK.COM
 ([fe80::1878:5d55:e47:b918%3]) with mapi id 15.20.6043.022; Thu, 26 Jan 2023
 14:46:54 +0000
From:   Yangyang Hua <hyy_41@live.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: When using several ssh key, Git match ssh key by host, instead of
 hostname in ssh config file.
Thread-Topic: When using several ssh key, Git match ssh key by host, instead
 of hostname in ssh config file.
Thread-Index: AQHZMZFP2uywjTKQq0uXSEDuCS1VQw==
Date:   Thu, 26 Jan 2023 14:46:54 +0000
Message-ID: <OSYP286MB0215D880FA9D82B74E393DD691CF9@OSYP286MB0215.JPNP286.PROD.OUTLOOK.COM>
Accept-Language: en-SG, en-US
Content-Language: en-SG
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [dI8Afrzdgn2qnGSfiTqG6q04xbGWLRhY3KhIA2T/n0+aHmfFs37MpzVkmbjv3Zsr]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSYP286MB0215:EE_|TYWP286MB3205:EE_
x-ms-office365-filtering-correlation-id: 22194f04-b0dd-4cfd-d449-08daffac2aee
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: x0tPUNAkxsCCLgLKxqdgORC3jCUqcRynmqPQ3xCQTiK+Tn+9WCm+36xjQsWRSJoXdcftVlRwfpZ7jH3lQboqm18sO0ojh7nXqOZtNtAHRVl2CG7EI/BoD8wkolVnmXiP9Jd6goQXLj4GIqNdWV+9ItUt5zI1ZuDuKeV2UjjL9Y/me8HLxn5qYhK2cK0v2QxujJd+7v7tuItgJVAwUIyTArU9VcZR4epIryFOOer0C+VsEWKovE228BXpH/OR18UKB3tJpsP8Ijmf9FPQ7stUuZbRyDnnpHuVRmPtGxThPjl72JVxbtQXaKQSoE+aCLHqQA6c7jND8sY7thKmDLT72YkoMDD1pP//TkxrdeBQpyrTG1rcnwj+peuNPRO5AGRSfrjvs1Vo0/+Vglyku/won/Wx5DsdTV+d3I1uhSAYt0MuJXNMg9yyNovaQyskdzfZmGraXcgzIz7bVxslyarCrQHGlANGfgDyMHtnwonvP2/R5CfU8ENoufDA4Top+6h90XtdcpKGIQzRHWBgP+LLoT2qy0vdyReM8EwzpmyTp1quSr0bKLGl6RzO09ZetrVTdMgz88w2fvNCpSgpp2iJdpVpj9pCVT9lfNxlT+vZmp0=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?nhdHtB0eYqnteiY26DyCGG4g76C9gfdlWjfAtTlJzIf22S8w/lClxhlZxa?=
 =?iso-8859-1?Q?xhg3PCec2DPzOYtICS2HfrJRNsOkkVKWCMZSCX7XDTZ6zOlpjwba5UCIMI?=
 =?iso-8859-1?Q?m98rjxn2UvtgdZMxerz3BCU2w82fJd2If7qH9KTKrl2LpkWQRkkv5p7RAu?=
 =?iso-8859-1?Q?IqZ70Y1/KfCAQJ3ZEUqwaoFa6dSB/bjIcxf4xziGpXLizQvMuu7Uj+3BOk?=
 =?iso-8859-1?Q?dirbAQb5fcw5dtbQyQMDpB6YT2eJBMs7vBq5kj0TI+f6RM/Bswlz63y5xI?=
 =?iso-8859-1?Q?qsheN5kTm37Fr34ZlHk4J+BuV/Iyjttoz/+/BnwYK5Y4PIQb+JZ4gROuDR?=
 =?iso-8859-1?Q?PvwxDxPnLu1kP1VLWxA5Bw+E169qQNX/ahZRj3sQiQqIzShuQZTwDydouV?=
 =?iso-8859-1?Q?04dSUruU3tUFxSNBKRgM08qbEI6g2hCDpuAiMfGJdNRi2VPdWi9CLQKr/b?=
 =?iso-8859-1?Q?kMxduL8Ns0MVY1awr+9vGeTAg2Nmk1kLDmgEaMOAFphc9M6yFl9L0HbmhB?=
 =?iso-8859-1?Q?McZy/FymdB4LdkIijmFbr1r5ZzlorCBZhJ9U9E/8ZtPbhgTnahDa3as0xQ?=
 =?iso-8859-1?Q?zwOdefkWEtLWA2s2N0+V9wwMDLziCCWy/RxPJ7X6B+TdudysxgEGEVHT44?=
 =?iso-8859-1?Q?Xe2G54qE6sZZkigpkc8ka1yfuFQagf/sSkjnDfOay5beLqkMKJkcjUa3FN?=
 =?iso-8859-1?Q?eqaVjqnbMJ9+y8NplADFMixFEy5tyrTa9q0Rr72sRgyOA4JYqGcJy/tBGG?=
 =?iso-8859-1?Q?YPovUasygeBiJ4EFhvgE9Z2h14+lcZIJoqHbNIbjWsqG+9Wh8cylhsr45n?=
 =?iso-8859-1?Q?BKaUv+bkEebGMHg/KWeODscNNFYmCipiSw5ZogurQEftk8PcS7XKGpcwlB?=
 =?iso-8859-1?Q?aiQT1HFMLGOHIuyO9IIeDrKMaY780zzAAegqAHuWnbsmbOXVTv/ZLFxR7y?=
 =?iso-8859-1?Q?w+KvjTjYvOiidTJ6QmLInvX0uG3pQhOVwnF/mq1HrHTOq678Es2BiIs1R5?=
 =?iso-8859-1?Q?MF7Xb55Yy9iKPTho1Jun+KBSP5POTdqC2Uvw18p3b7iH0YRzsyT68my3kI?=
 =?iso-8859-1?Q?XMeWnJTzLwKAOZN/vKrB/ZCsPUmjHoYyaRjusYEDIE7qKw3YZKlBLooPHq?=
 =?iso-8859-1?Q?FREJM2pWADHLUGzIjOecYy0D07qnbVhTE35ifAw8Si7NxJlqzebhqxQQWP?=
 =?iso-8859-1?Q?sWZ0tplKCRcla6dULvVrakRb0LmOWFpMO7fvqSoGG/mhOoOunVrzn5k8M2?=
 =?iso-8859-1?Q?lfUKzEzvVQ69U3fs5WpqcGeQ3azAbOiCwfaN9pEXWarm6+s1BYQNrdukgl?=
 =?iso-8859-1?Q?8cSKBUoXkqc8tQTTCGb4IB6Xnu1ANmI0gqRsSkvlJPNcVI//1KquIBtpB2?=
 =?iso-8859-1?Q?Fu/kIh+M9k?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-05f45.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSYP286MB0215.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 22194f04-b0dd-4cfd-d449-08daffac2aee
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2023 14:46:54.5942
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB3205
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, =0A=
I find when I use several ssh keys with the right config file and clone my =
private repo, git can't match the key by hostname.=0A=
I try ssh-add command to add the keys. "ssh -T git@github.com" can work, bu=
t git clone/push/pull these action display "Permission denied (publickey)".=
=0A=
Test in git version 2.38.1.windows.1 with win10 and git version 2.34.1 with=
 Ubuntu 22.04.1 LTS=0A=
I check the -v and -vvv log, git does read my config file in ~/.ssh.=0A=
=0A=
After I change the repo address to host("github") in my ssh config file, i =
can clone the repo and push/pull.=0A=
Host github=0A=
  HostName github.com=0A=
  PreferredAuthentications publickey=0A=
  IdentityFile ~/.ssh/id_rsa_111=0A=
So I change the host to "github.com" in ssh config, everything is back to n=
ormal.=0A=
Host github.com=0A=
  HostName github.com=0A=
  PreferredAuthentications publickey=0A=
  IdentityFile ~/.ssh/id_rsa_111=0A=
=0A=
 I think when git read ssh config, it uses host to match the key instead of=
 hostname. Is this bug?=
