Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 823C5C636CC
	for <git@archiver.kernel.org>; Fri, 17 Feb 2023 01:55:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbjBQBzE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Feb 2023 20:55:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbjBQBzB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2023 20:55:01 -0500
Received: from HK2P15301CU002-vft-obe.outbound.protection.outlook.com (mail-eastasiaazon11020024.outbound.protection.outlook.com [52.101.128.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 074D754D41
        for <git@vger.kernel.org>; Thu, 16 Feb 2023 17:54:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XmlUNKz3b5mxiNN7bHp6bZJMnh7TGz9LcM32NVGaCIgOjvGvqzL5xXjXDnFYpkUHPHtHAJIxiODCfOp+7V3jxwheoRQ+3TMDZV5GY3ESaUQXULw8+SBKiQ1i2Ee0eerT/69Lt6zRrPUgyTIwayH0WTAdyIANUVtq41OrFOQORAUcdWRo2p2YGxb+czPFsuc+Y4icWxREjt4tbcCVjYMD+ey/ML20gnp7jghMgsF56mxA78ldPideuUjrbj1DydpbBnF8LDRUMGnDlJIO83Ql2JCMf2z6+SjN6MsURZEXsvFs+EBWekNKaPZJUu0rg/+OT/V40sbvLUD39h/YunfQyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZgPYKSsAWQ7yIssDj/KkjtkRB4UT/2NuiobL+/BUBs0=;
 b=SSKZ8IFLi8OSjaW8Olv58WCzWulo9yOrxHrpQDGkRjCOGDbMiP4cAxEm3aXWC7wzK3tBtFg2WRJKw1XnnfXZEHeIfpJ5rLktteXjXDc4ia23UusOXahLeXILJ8+6i1iAaG2f5D6sZdFqg8Q9RfCkqUgVYWRN9j/TsQEXpzngUdj8wLKgx69rOqqUYTcp0TNNTpvjpjwrVC2jM0YL9iPJZTo9Bnf3vEnhMYqjlcmCPC+Mma4WKmRtRvJYTi8Ur1mEJmuJ3lbIsrvKTwRjdC4Hlg5aeu9OfKSapwuCrBpoE/uK1C9CZMCF4q3owfju6aiqKzBBF4KgEfhgUsM0ClBMSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZgPYKSsAWQ7yIssDj/KkjtkRB4UT/2NuiobL+/BUBs0=;
 b=jpP0c/uge1dpRTvlTPhFRZBkIbdI/FCkuSinsyqAVdi9ghfnczL7kXBGwcI6txsofCS4Mq5flsxA+lCsWj0UelnXVOL0n5uJgGNo+KCZhLMEzIGiZP4VjjnCHrrNN9QWwF/TPVoY1osPaXgYmtYhu0nOUbbjp2ZjixwRY5rHkUA=
Received: from PSAP153MB0391.APCP153.PROD.OUTLOOK.COM (2603:1096:301:2a::6) by
 PUZP153MB0666.APCP153.PROD.OUTLOOK.COM (2603:1096:301:e7::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6134.11; Fri, 17 Feb 2023 01:54:49 +0000
Received: from PSAP153MB0391.APCP153.PROD.OUTLOOK.COM
 ([fe80::87f6:70cc:9bbf:9c8a]) by PSAP153MB0391.APCP153.PROD.OUTLOOK.COM
 ([fe80::87f6:70cc:9bbf:9c8a%4]) with mapi id 15.20.6134.011; Fri, 17 Feb 2023
 01:54:49 +0000
From:   Drew Noakes <drnoakes@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: --jobs=0 no longer does any work
Thread-Topic: --jobs=0 no longer does any work
Thread-Index: AdlCcmVlM9cBGF6iSNWhgafmDXJB2w==
Date:   Fri, 17 Feb 2023 01:54:49 +0000
Message-ID: <PSAP153MB03910458707331B64FA7460DCAA19@PSAP153MB0391.APCP153.PROD.OUTLOOK.COM>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=162c7c96-eb7e-4aee-af8c-608e71aeec37;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-02-17T01:51:14Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAP153MB0391:EE_|PUZP153MB0666:EE_
x-ms-office365-filtering-correlation-id: 19d94b80-c9cb-4ab9-ca6a-08db1089f424
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5N/o9y2IxhbITYZ7TwAW2UMy63a548U6/da3Eeyp0OZ8ZWArn4PVOCAMu6HKlws67qwp8hSRfYNLIVV51Oa9UDXe5no3QLAxaGyoKL+RYkRzSbB30Hl8wIjgRKfOaYjSpG+Ujiu6YuIM5niEW0PWu4QnLfBwX8VrhJaL2/O/WoNsJeg8IXuaoxbW4U1Lqh5ECnquFHFb8gEVJN78OIWL9m3PLdgVUy7SVzOHmd15yuECf0jMG0XO2ggeRT2bEgUklJ+mGqGY+e7XLe4581Uk+S6JZHiRTAethuDvrnVQ2/JTZ8udH65QR3DbSo2LcNsnScHSLz7MDPs/X1rs+YRk7alc8a7iZdkEtJ6ZJbVcj63ono+OpCcMhLshiPtjH7xjBWyIV0lM2bmb7vV4StEcBw+mj5ZynsWqGZPWkxOCwi4dusc6uiG9NmCelv03qN0ymHHUN61jh2knA3Nt1gfnoUfrMTuR6z+67Mp/3ZJ/e2mhiwx6RjfkL12No+Z/wP9N550EbzH2ly4Scj+bNHcI4/gU8RCpk2MXQinHyT1E9L0zKF8Dipjsy2N0ioU92SoAy6Y7ZNw6JM4o4r5pjTZVYOWjWPcrIFSmYWK6RevdvOz8IH7ZsoRCp9QC41z+C2P8jKurtMiTCaIzuCtEol40WtNhJUZo4iNmFnyoRLrhA/QTJKyny7qANlslR2np+zIhsA9tCk2fRLL4yKUkFFgj92blQltNTuEcU1f1MexgtIAwi2VW//Z6SIH7vB4JCu/YHbxr7vWL0akItQ5pyg55AQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAP153MB0391.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(136003)(376002)(366004)(346002)(39860400002)(451199018)(8990500004)(7696005)(478600001)(55016003)(6506007)(26005)(186003)(9686003)(83380400001)(86362001)(41300700001)(66446008)(6916009)(8676002)(64756008)(66946007)(76116006)(66556008)(66476007)(52536014)(33656002)(2906002)(8936002)(82950400001)(82960400001)(5660300002)(71200400001)(122000001)(38100700002)(316002)(10290500003)(38070700005)(460985005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?myqQBQQFbvmBK9yoxU7r29iA64aBR6vpK0EGqvPbbKsKGRnVbnqxJn8VD/sy?=
 =?us-ascii?Q?hfq6a8I/a9YKl7dCcb1QsgVmDEDC3B+jZtrBgTkb/cVmUCA75Kk0QK7aYF1T?=
 =?us-ascii?Q?WebbYX+jJd1fPRgaQJDmPsPKSZ9pnWPhcm1OdHRtp62SkG9AiL3+ztjv7wmo?=
 =?us-ascii?Q?m14jnkngYCZcTRnHAYBcbxThdOuESoEf1+Sj1o3Qye1JmrP3MhAYU8H6yhbF?=
 =?us-ascii?Q?VCcgDpwvS0c5MvhttGkmnmWwlk9k2LUHX8NMmoY1RN9+HbmF9erI+2JXyLmr?=
 =?us-ascii?Q?GwFQNunGQoR37KCTMOtvon4bzZ8yt054wmjhJL6+S6CuM62TWyPD0IZXMDIn?=
 =?us-ascii?Q?pwTyDy8W53eR2pPdwZzUmdviKrM2xGFxueczzJdON0VuDmTEzJeST7O3k/B0?=
 =?us-ascii?Q?Uatzy4tfWawiCWlI3lXE3fQuikUQA+h1Dfq7dAZkmRyesvaZwqWVO+DuV8dc?=
 =?us-ascii?Q?4IwZ6DawbH5oCTPkG4XesiYMgZGu7HmY2NHEv33MpD9ls5N4egNo9udFNDoA?=
 =?us-ascii?Q?W1WecPIHVS7e9QJf/iSBtwVnIW/IAdQwzZPiAy0wgXYyoSs4tzmhl2SBzDQ8?=
 =?us-ascii?Q?tc/EWG0rBlFCh1dy44AyY2SVjpdh8LBj15CjjvMo7SK1f1FjHX+Mrs8oe+ie?=
 =?us-ascii?Q?jbQJjz+JCPRxGj7wA+HKWzDS+0KaU++Z4AGXXk1R1OG2h7D7GV5W0yJ9S3Dw?=
 =?us-ascii?Q?ZRe9bPJNVhIp5I4AyMDP6RH9kt9qoxySG6e1GVjUiLUG9G+i3HRBZRzt/0bg?=
 =?us-ascii?Q?HLtLc7v/xb7RQVobKhXs2K+93Tr0bikT2+f2eCy30aqJvpi1wPdc8QFG0hxm?=
 =?us-ascii?Q?rASpv2UN07+4zOV4KMQC8KUCf/4bchI2zrWLlWiwdej2OPwm0lJ978vvuTks?=
 =?us-ascii?Q?uq7YDiI7BIBuHCWdC15N+22Pe4BhtlQ2TTqd1HijoAMcP0R+awpMOBdIT7AM?=
 =?us-ascii?Q?uP6GGrBKUaaELhrc2X5Qrty3ZGVvZau3VfpeR+XWfVfv3oZBy8UKkUnNh/js?=
 =?us-ascii?Q?XFI6WynHNECY/iR+3unul3F7EwU7M8MJ3AM512YtZJuwq2g+zeoWHE0oDanK?=
 =?us-ascii?Q?5QuJZCWt/ux6nsMMzIj3kxfpmGn3/sTZakTVdBbmIILEQVsRMa/xM69Ri6r2?=
 =?us-ascii?Q?xfGwwFNLbfukgahCB3esveBx426Zr1KoQ5c+am0+hSnx0EoqxSu8Cj8MnbnX?=
 =?us-ascii?Q?FFuNBmgzUQlGDFwdeUFXxlWlSi8maNzu/V8zkTR9ZhR5eB/hEGYTeoye+w7k?=
 =?us-ascii?Q?ecV+yAXopfTFq4mSKia5IbvKyTD2ZTuxnXtZ9LjaBncN7C71CSGwm94swWQ/?=
 =?us-ascii?Q?cq0EdfR2Zc4/daeoxbGT5VEZQPk6WBK+ArMyWdkTNgn7DtOEG/pEl4i3lZ5P?=
 =?us-ascii?Q?sfbM8GNF9ay52QW6z5x1e7fvGjpsdFStWn2FFzPBtBlCxvTXXwcGmLbXP4e0?=
 =?us-ascii?Q?i8snmc9CRTRosHyR0HyII0P0pQeyK1VaL0VYzbS2/hVyBsBupVLgsnuwuzzG?=
 =?us-ascii?Q?ibcFjdy0KOu7dMKf8Nl+r5ujD6dxSpuDX0MIjHRlshKPNqb6YKqAqh5dUDi4?=
 =?us-ascii?Q?18U2ZhH6PF3JGnLbKLafN48mzsEijDtyINCAWHBW?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAP153MB0391.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 19d94b80-c9cb-4ab9-ca6a-08db1089f424
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2023 01:54:49.5359
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V2DeSeulT5D8w4nCVn+obPebmEMsknFVXZlAbHACfDurm/X32x5fy77iuqnnhU0YQCei/n54eoOx8YoO+k/gMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZP153MB0666
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

What did you do before the bug happened? (Steps to reproduce your issue)

- Enter a repo with multiple remotes
- Run: git fetch --all --prune --jobs=3D0

What did you expect to happen? (Expected behavior)

- Multiple remotes to be fetched in parallel

What happened instead? (Actual behavior)

- Nothing fetched and command exits quickly with no output

What's different between what you expected and what actually happened?

- That command used to work correctly. It now does nothing.

Anything else you want to add:

- The git-config documentation says of zero jobs in "fetch.parallel" that "=
A value of 0 will give some reasonable default. If unset, it defaults to 1.=
".
- This started happening after I updated my version of Git for Windows earl=
ier today.
- Excluding the --jobs argument or passing a non-zero value works as expect=
ed.

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.

[System Info]
git version:
git version 2.39.2.windows.1
cpu: x86_64
built from commit: a82fa99b36ddfd643e61ed45e52abe314687df67
sizeof-long: 4
sizeof-size_t: 8
shell-path: /bin/sh
feature: fsmonitor--daemon
uname: Windows 10.0 22621=20
compiler info: gnuc: 12.2
libc info: no libc information available
$SHELL (typically, interactive shell): C:\Program Files\Git\usr\bin\bash.ex=
e

[Enabled Hooks]

