Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9B27EB64D9
	for <git@archiver.kernel.org>; Sun,  2 Jul 2023 15:32:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbjGBPcc (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 2 Jul 2023 11:32:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjGBPcb (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Jul 2023 11:32:31 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10olkn2109.outbound.protection.outlook.com [40.92.41.109])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6D37E67
        for <git@vger.kernel.org>; Sun,  2 Jul 2023 08:32:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SV2zFIpeF6go5BSzLymAGbbgIJ9jHkcvqKm3qeVnwdHkq8nC6eDYPdygxwwkSHidJ3x05wfoJoD9vfDyM28peD9awzuniCpsqd1L2Mr1r4OmOoayHE6xTW5MoiT7uNUfHhys3tVodKo5S0vl1WAP7P7wZCMWvYwbtsqxAKIIihHVAY+JLzVtm+UpCUQFLEMHs+WzghznpxnjpQ8Vz/FImGe4yst/BQJt47TbtGR8W7zzpxeMCiATHyyym0YR6VfFW76ODZ7PQLNzyzP8KUWixX8yU37+znLFRXE7JuoAXyRTRi/bRQiuyIibshylULnH4fw4Zoo92Rx7yVjBIe/wcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Labt3j+IY5KaeoT8knZrGRMyHl7vLEV6Zfy7fF/S5IA=;
 b=RD8uQU9ETHfp11yJVNv+Z5F+jVtl9Rywb5kweFrNwP+rJOJDQ8Iz1kk+rJRVQyI5VDD9+Tk8CU4hgTeZUzO6Zo0u0Z4rsduDFVPvsBu9pSVDKx/SAiXuiQLOQBMUtmsBZVWJ3EeYUEUCCWVhGgtlAEb5s40OOGUte5klPaBgZTn6JMR3d+EevfBwG669VnB0NLtIhagwQIMzHNmLwe4TNzmnrzetJevm/ovyTgCorHWWkGIgv5hBtXL99hP7PWlSTPewkNBXFxuOWz+LxTW1sNQtX08WFRAWpvsejpV7KC+uH6QTRss4805zoqpsiNAWXH28zNtXgBS3YGVFy90++g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Labt3j+IY5KaeoT8knZrGRMyHl7vLEV6Zfy7fF/S5IA=;
 b=o5CajYu5BncudoYf6gd2auJgd9snNvLH0dS5v8gmjh/HQE9oIK0fiIWjHTWs1hIoBGmrOTtUsPpPl8PaMvBBvm7eRVIJnzy15g168Vz2AZtbmV7ujSp3l4ITF6dqTyyay7t5AgSQvDXB47Sp49HwVmdcbVOBPVIaLkOpcqoaRMUAg9HyLOisyTITHDbj8el+vvHaiyan97RXYzjDF6BN6D3REts0OdegTFkEss7pxHkX6ufT+Ix2mDuOpCGtn5U4ninVwoJKh/SsYXhcykQMx4k6WSVR/DdAz9cNhwIHJfAtN74ait1TSwdYLXB3n/q6dOmZqrokCTBqsx11LnlI4w==
Received: from CH2PR07MB7334.namprd07.prod.outlook.com (2603:10b6:610:ab::12)
 by DM6PR07MB7049.namprd07.prod.outlook.com (2603:10b6:5:1e6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Sun, 2 Jul
 2023 15:32:28 +0000
Received: from CH2PR07MB7334.namprd07.prod.outlook.com
 ([fe80::abe8:5ec2:f7bc:233e]) by CH2PR07MB7334.namprd07.prod.outlook.com
 ([fe80::abe8:5ec2:f7bc:233e%3]) with mapi id 15.20.6544.024; Sun, 2 Jul 2023
 15:32:28 +0000
From:   ross thomas <rossrecovery93245@outlook.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Who are you
Thread-Topic: Who are you
Thread-Index: AQHZrPpobF4CmCYAGEWfFfAcXvuVOA==
Date:   Sun, 2 Jul 2023 15:32:28 +0000
Message-ID: <CH2PR07MB7334359246A319C195383C50FB28A@CH2PR07MB7334.namprd07.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-tmn:  [KbUaEnNfnXM4JAyAzXV58/K1EkEkgdkRR78EELI2DBw=]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR07MB7334:EE_|DM6PR07MB7049:EE_
x-ms-office365-filtering-correlation-id: feeca52d-7f15-4b19-a266-08db7b118b1f
x-ms-exchange-slblob-mailprops: Z4JiEoKTUknnR3jZ1SEYrMAfo7OXf8UMRleMtqE7MvndYSgUyBJhuBGfYHr3k+RxaHb2hg3aG7SzhVLRjXGEGQt2Y3gZmDkI/oYSYpTAlahlyIfilACx8mCKFbVWNCNDMYwvDpDQY3G8/PJX5ga2O551UrbgKN2yeIgW6SVlTXX0ck+B0T8X8cwll6gWjqAMZjPRT/YeFoccFsdgVxC247p+RoGfRHju87Yk123d8op/jazjVPTxNHwQEtAHb6h82ZIaQoJdIJRWOIxRsaHT3lUTv6L2OqkD/8s70LChXHkpEgKENJ8mjGN6nktJUQK4ynatG8dbe8+r3pRC4wWxFwq6hVFPZpjbQy+5fGBY2OXc+lJdnV7K5+u4l6pItAZVsrPyXLgzrMi/JaMbbfGZmt/suSH/wb55tCHGoIlJ1VU4zgXBMkrfmiA7RHxGVLDR9hD3g19v+Ebj8TBJ9Sxma1ivv/6VkYc17zFoKiiz21GIRA+5Hv8D93LslKeB5RoCzTvfFZtVmk4zBVlikly7mAD5NX4nIg6QHRZsfVRwFv9bPT6wJoNpU77SL8GtS0smTbztU73BeGpbGDRG+cy2gFW04m85yQO6Fhk9IQZNuuA9QOgWh13xXpLyIzIl/Mqc
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8E/RhU2X+2JwBMRvwr5cW5Tpbb95ia8gAlq2tgiyOPR3JO4WWvR+4XNbdsx67yInFsqnDeM/fihTgeUFm3Ow9ls1NaHTl4uNnuoLdGE0SWOLCShkUBN5z/BuTBepU7svFF8u/CKZwF6ZzCUf2egigHsni2INW8zlly9yboq4xX4rRzbppiAUmgwB4nuNb5EXZBhcC/uGpr2bF039Mq32wPvn36mBOG+qeAmRz6ynhHjFgR7Z8da0xUHjOzjU8r6W6cUQmn7N+beUID5BqzqfQKlPAG7PfmYhr9nf4oz0vkIm55QpW1fY9Xqad3W6ApM7E5WDTlVvywj8FJ/eKdPlM8ug0M3wsW9a1ybIXX2EPFBBXRlu4Wche+tsS9PeK/PniKHT3zvhLOEH4DTsGl05AGnDyd4/PHV4R28Vxe9R6wepVf1vik1/w8h/F0b5MlblGdF2Gecope1xlg4gyaf94rXGAH4YPUqkHPrsA1tveJP5JqCmOhnFYekM2niez+N/1LYLDDGZB8rXW9q1P+bWL8L1HJVREB7Wz9G/BcGjZj2WC4LUm2hvsHJWGutGPrJUGA7kpQX5uziRYiQgdnOFjNCP0v5YquRQwdOY3nnyAxp2PG02L6uAz76kDlw0wB+F
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?j4zaw7W3OICkj60Kip5b/Vw/qWlfW3AiAWUQpxxbi/jy5Zmo0y8Ofl3jsQVM?=
 =?us-ascii?Q?VDU125H3rk6NyqzbWiaQQ+rpo+UUqqaQPgV93hheGpEflfRdnJA0TCtNsW2M?=
 =?us-ascii?Q?jNwpJqsdynpGTmjniwiiEw6sulyYm1UTESb/FEhRcisTHzqko2dPH3extqpA?=
 =?us-ascii?Q?W/nd6/osjLTo0gF3xPbkxCNcTECF2Ny6R2X1c/qqRwupIqGAGI5HTM5wMeYA?=
 =?us-ascii?Q?FH/b0k6YqrgHKQZR2DtYqIUkkl+gIM3+GrEJCv9z+n1lcTtg0G49jrD+8608?=
 =?us-ascii?Q?SwBDSvE5NCpFk+bDa6dOP3oasOQGUas3c6x3sTG22gTqFiEZcFqW2uNosKCm?=
 =?us-ascii?Q?rQZDeGm52oC92viUhzVhZ1m0dzk/rzXYHHgR1bVTF7OZuacf6wSoLlfrbnAw?=
 =?us-ascii?Q?bDSkENMUNDnMmuEV+LyzscNfpd5OGYvZRb4hA/2smxAJ0ozelmTiWhW6e6b0?=
 =?us-ascii?Q?iQ+e5jusg64mFvTWel2qeaOYrf5/WIRkz73LbyDe1sXGlaAWs+WurzQmYRia?=
 =?us-ascii?Q?aEbM/Kv+o3CUleRs9W1amy5JH/pCCbNiERvNUKzihDOsxv23CBlgHlU2yniw?=
 =?us-ascii?Q?AsApgKrtUrebKkLx6709oQ1C8tCd3W2zy9GLJoEnOvkg5rvQ+DG+63VKk3So?=
 =?us-ascii?Q?trB6N/hRKhzSg3NNuyT+75Jwh68pdavMp9heXvpaeVKjXKPfqlHsDcFgOjzi?=
 =?us-ascii?Q?Dx5UJvnLylfoJdLyLkleZAzU2MONb3S7iyd/u//vKL6aYzHhujTqs0fh4JGx?=
 =?us-ascii?Q?rVLxiReaimFwr+V5H/O4Au46ItcgW4Uapzw8OU9cw0whJKT6WwQ9PoLsNLk9?=
 =?us-ascii?Q?X4gQxJuimVv28iHvA8ywncVvyRVAuyl1/4mEfKeqq4H+U3jGdEbvzCGNyaUx?=
 =?us-ascii?Q?NCG/zop3UsJKPGYjWfMMtX42RxG0SSBJw4X3c58v6Old5nA9+iZZzxagsXu5?=
 =?us-ascii?Q?OfO4mZBIa9rNVfuKPg7qFIXVvNxUOattB2RFc3i0lHRwck3r+vybWotb5Kcj?=
 =?us-ascii?Q?UUFF+8P4fiYRnMdMRCnTFGgDhRTzVvBK/z/SL4Orz2c+g57UX9rLKVNoZZha?=
 =?us-ascii?Q?pCYfj93H2ml/A342oXZEluAZvozVybro+nWWBMBmdoDaVnL82zvsCWRIFP4m?=
 =?us-ascii?Q?avhDKsOXdi/Uq1pZyyS75Sw6eiFS/eMzxTPPBcK9MxmYMFPVWqJMS+qMnt+u?=
 =?us-ascii?Q?uLmKjddbi03DZVSY8dDkLfmO49M2VaxYYhMCxbjQm1wRkCIcziEp1qHiGQPQ?=
 =?us-ascii?Q?GMkVR6waHjmktfZ74Eu4?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C71D62C2FAFA6C4BBA027DC40B2F8615@sct-15-20-4755-11-msonline-outlook-5fbaf.templateTenant>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR07MB7334.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: feeca52d-7f15-4b19-a266-08db7b118b1f
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2023 15:32:28.1755
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB7049
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

You on GitHub.?

Sent from my iPhone
