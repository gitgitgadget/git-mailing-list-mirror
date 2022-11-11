Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B18DC433FE
	for <git@archiver.kernel.org>; Fri, 11 Nov 2022 19:42:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234246AbiKKTmg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Nov 2022 14:42:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234145AbiKKTmf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Nov 2022 14:42:35 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2056.outbound.protection.outlook.com [40.107.223.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DA017F553
        for <git@vger.kernel.org>; Fri, 11 Nov 2022 11:42:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F96isWPwh4vpYquc6MzG8VKguQIcr5NHx8/BZkz3I5bKMilauLZyOReUGn6tXw0xEn9JLK7/zk6sSEQ0GrkO8Vgf1xY4Yq5T93JWI0vByS9HGcuoulaGBTYkDB7tAtebonqbDQmRrm7YjGjXgpbqoFxNurYgt5inCEK4FXhWYuKC8m1thKVhsy+RFc0juNBXvt2M9kO8lPv3ElzNn9d/0a37E1QbqVKnr7QMqqWuC8rltjX8lV4v+3JtIKRuoda4KFrinu0NzPmiikbr7kdozWkI9hi8KJGt7Q5f6JpGgXwwxIzabKcSGvKKPNoOvLvCoKDFXmL799X2Eui87Ryzug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SIwrTZKQPwfsh+y9zHBZWojq8BMGlv0z14Q8B+Btqno=;
 b=DFRKUEdzKhDzSb7/nghhveor6Ie9N9z5K3cOtIyyizzj4vimqveFwzfRel3hZcBv5RW2ZTIzFdSo+IgJGo+Q/Zis0zihLx3Dorr1FghrwbtQopoqvwOdLZqmhQB/LSILzPr5byRziKCn8EZH4FmVL+GQ1hu9y2nIZjn6YuH6iHmZskBcNYmYnTrW4PmjCDZw7QA+gc6VpbxUYPlFfV2P3RNFY4g/FykmVV7gTYrF2FNKf0m40fMr+PGJRYdwXwkRitnbsC0ZQK4xGZXdQUP/vMyk/cHQ1qX4FwjdYLXMbcOI1ZHEnYSXdjH9qng/WdvMa6YeFk9zLE8S9SlkTnkWoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SIwrTZKQPwfsh+y9zHBZWojq8BMGlv0z14Q8B+Btqno=;
 b=ZQxWNMnGMzT3+JGb2/Td+XP0+ELR1SyPuugoH4CsLjCBepVcrUwTfuYjeu/53dc5Cp+iRSP1/l7+FY1aFWFjhNYYNyslOij0gyfnQu4X6dFHPl9KgVKU2UlRwN+IKqPX+DWYhEK0MUWYQk/9yP78UuYCogQQB6Gv/djwE8HU8bY=
Received: from DM6PR12MB4356.namprd12.prod.outlook.com (2603:10b6:5:2aa::8) by
 BL0PR12MB4850.namprd12.prod.outlook.com (2603:10b6:208:1c5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Fri, 11 Nov
 2022 19:42:32 +0000
Received: from DM6PR12MB4356.namprd12.prod.outlook.com
 ([fe80::70fe:fd7e:da10:fd66]) by DM6PR12MB4356.namprd12.prod.outlook.com
 ([fe80::70fe:fd7e:da10:fd66%6]) with mapi id 15.20.5813.013; Fri, 11 Nov 2022
 19:42:30 +0000
From:   "Strawbridge, Michael" <Michael.Strawbridge@amd.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "Strawbridge, Michael" <Michael.Strawbridge@amd.com>,
        "Tuikov, Luben" <Luben.Tuikov@amd.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v3 0/1] Expose header information to git-send-email's
 sendemail-validate hook
Thread-Topic: [PATCH v3 0/1] Expose header information to git-send-email's
 sendemail-validate hook
Thread-Index: AQHY9gW8Jf7ShJnYXUiZP4qeh5Ec0Q==
Date:   Fri, 11 Nov 2022 19:42:30 +0000
Message-ID: <20221111194223.644845-1-michael.strawbridge@amd.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4356:EE_|BL0PR12MB4850:EE_
x-ms-office365-filtering-correlation-id: 31f408ed-2796-4746-4d4a-08dac41cdf1e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: C3vXTyt89P+cbRSEsidRNbQRW9GVvutpd0CMBCESecxdZ0rfrnnFNsDu74hWz/Ot/7lJZFm7+G5Sl8N+SjljcNnmc/vQjim6bAmLRYD8v/j9gytD0v4kOsh3V1OViqmDjjtxcEnKQgNzn8ugyYKbpe8IHbZRr+Ipg0OXqVz4d/H+jL00fXhXdNnTMctxnx5aEFr1KII9loulJL6mVDnagkJFxG9dsJ1r9AxJIqFjaZe1rG7nQSybufl9cA2GDPJR7jgwc+wkiM1nyXSW9aXyXWgmHFr0rWA27Jv3N8oL8wJX5X4WaoQrGX3XwfJ3NNTXEzfm20gUOPM1tLFAfJ0lcjU/RRObYvAje0mh4LH6YSaAdbuTOfUGeLbCkJ4fWGaLLgOFbvAqKDz9pq80NSJLGvZRt20jyOM664X2wgvNKHyQ5mAqTMVLGL0RKIiU1M28OhDbBGx4zXlPlTFTep4KHP14ibwHKPHm67UDKiReCROJg0UM5CIfDFsxWhSVbN5Ul022GfqQ5p7+sEHodsTYVyVm1vl7NPTw08+jPzQ+1xGjVvcM9/SnTqbZKSJvH2iHGd+HYJbMeG/SQdn/fFaC/O615S0mZqsVRR+bsn5RCKKHi3jAbYcHqTfGrZhEAiOn/vSHgGRVQyhtaULYthHERie/dxyDBuP+ohwEtObyznwsN+Q3/Z8gLZl1pWS5GZxuvFmrTieJWugpzve1Pzvy86svuPwrmtrv4wb/9yUJEB8F78gqFnRE/fozFDZKGx+s
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(366004)(39860400002)(136003)(346002)(451199015)(38070700005)(15650500001)(2906002)(122000001)(38100700002)(91956017)(86362001)(4744005)(6486002)(186003)(6512007)(2616005)(83380400001)(71200400001)(26005)(478600001)(6506007)(64756008)(41300700001)(76116006)(66946007)(4326008)(66446008)(66556008)(66476007)(5660300002)(1076003)(6916009)(8936002)(54906003)(8676002)(36756003)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?0TTcdHTrhnyACdUQkrlFKm9nncH+8c7A2gNd3jZg9zaQamMec76gKqeCAo?=
 =?iso-8859-1?Q?yx2ZG0zBoIfLDfh8ZXWF3opgKxcJgE6RGSYNZ4e+gJ7LoVGrIFW5nGQKAm?=
 =?iso-8859-1?Q?xJw0d9MBX0CohONVlpwHufrwq1N42q0559hZYk9shfCrC7idyemEbQYCt/?=
 =?iso-8859-1?Q?5Jm0bKx/Uf0/owP3xD9vlwZSRJMI3bmmeKfcd43ycTIFKNFGqiiwnli9cq?=
 =?iso-8859-1?Q?FruwY6p+7yxZJ/HiQiVsFW1goO926zkTjiV8joSh97ngssS/xayk2sNhd8?=
 =?iso-8859-1?Q?An8Wj7df/GyDrORWREWaC1lUFAN/NQDlHaMWvvyvSivFRl70tJFx0HfosB?=
 =?iso-8859-1?Q?SVWUsepoIfIebzugZKVVAlfHAToVJWPTVjfKXJc80dhONDbOOdxIPzmpmv?=
 =?iso-8859-1?Q?3IU2Vk1oZMyEM+TJ+eUX/l0l2pzXUJ/Q6oAIBfO4oqmgNvUIYlHSMMmDNo?=
 =?iso-8859-1?Q?F6hevAmrCPaBX9s3XrQJM+w7M1MVcxBQLJFo0bq6v5paQ+/cBD6UO380/o?=
 =?iso-8859-1?Q?zVPvzCbhO3+8jmkxQrP+ThtRNWsPwKKKBQYGc+Xw8bn2blKh3c0IczwIRi?=
 =?iso-8859-1?Q?TpGpEt3Kge+Fb2qosNVJjsc7otwBqPz82n41MiStDtRii+LNhsGjpz4zQr?=
 =?iso-8859-1?Q?PRKzNZSNILppyi8drYTWQd0UYPRGIaL8Ll6mrBBdp2c7Meo8wEI7t0hxiJ?=
 =?iso-8859-1?Q?CIEDxzHNIS2+meb4YjVIKha2Pd8cOPfc2GSoDYkCEulk+qpTrTYPcqw4JF?=
 =?iso-8859-1?Q?lCNqrDdHwgz9u4Nqus8ARbJEly/4u9noZJFfaoo6Q37CAyPovtMGernbyO?=
 =?iso-8859-1?Q?ZFYj4dOZWICjn/YxNJnNtNhJmMI/v3cS1uXXAu1F/KOq8EkERKufi5MMuj?=
 =?iso-8859-1?Q?Gv1hdnoghC0FSZgfNGaeBhjP0kKFp4/t7L6u6XcVuGhn1tc5Kbqay8c/wu?=
 =?iso-8859-1?Q?V+aFmT7/CW+yhRLSXiMU3J9/rp4kW+gAd9M3eCj0E94RSB9lUZtxKTxwNk?=
 =?iso-8859-1?Q?17vkGpnvZfE4+iqzgQMmE9dG1D69nUCcaRLLy/ktgpXJrH5DtNo6PDH2N2?=
 =?iso-8859-1?Q?mmTXZ+hg3DEEuyjswwIM/9k+0U3K1RbC+EKd40zM3BA2AEBguRtsSSVkcn?=
 =?iso-8859-1?Q?S9HRMsHFo9ZPpZvzzS4TwCnl64yQaBAEf0ilZCehvC8/8EF00Qu+RQmJfN?=
 =?iso-8859-1?Q?CJZ84fzn5Hy+eOswkeQJUamnQh+J7GcCxb9o7aW6/aKJDIhRUHgB/DDo2G?=
 =?iso-8859-1?Q?3qRe2StC7gVjbiMMbGjYTAFXFK9/ek5D0r8hwcUeJL0fFzUj8NCNpZ2IzC?=
 =?iso-8859-1?Q?1b8ygGydKUse3CJUP/IgimzDjsqwgPd+KC8vZop20uDR0xbJtePL0YqQMH?=
 =?iso-8859-1?Q?qHVhUD/1SB6Ynkd+51QH1ktK64VH4Ob8ey5avu8BQy+/U4lx8Ig0BJzR3z?=
 =?iso-8859-1?Q?tlTghGpWPRLBjfmqBNrL8DsEQTJdca3KFZkPvN1Q959LGEaoKejf6GbBYC?=
 =?iso-8859-1?Q?504/V/XCjFh5sbMeqX14zWYQYZ+dn96Tb0QWiIgVv4i1AoOl9RFGbjaZBg?=
 =?iso-8859-1?Q?ghswdydLpEvyj6e/vZPhkJGEnXqyGrPlxhdhdFRHGtU9e83PaJqX4WNkcO?=
 =?iso-8859-1?Q?vRiJsZpfDhoAwGYj4GoFv3a2KwZHMjN8Lx?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31f408ed-2796-4746-4d4a-08dac41cdf1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2022 19:42:30.7155
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7qO4Y7Nx1sguxG4K+09TZ5Tfc3HIL4qBezF3JeEF7LCrQN+m0SEiO1QamrByEMFnjgtzbx7S4z66woFyRDt2iQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4850
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I accidentally missed previous feedback to squash doc edit into main change=
 of git-send-email.

Michael

Cc: Luben Tuikov <luben.tuikov@amd.com>
Cc: brian m. carlson <sandals@crustytoothpaste.net>

Michael Strawbridge (1):
  Expose header information to git-send-email's sendemail-validate hook

 Documentation/githooks.txt |  8 +++---
 git-send-email.perl        | 57 +++++++++++++++++++++++++-------------
 2 files changed, 41 insertions(+), 24 deletions(-)

--=20
2.34.1
