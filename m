Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40CDBC433EF
	for <git@archiver.kernel.org>; Mon, 28 Mar 2022 05:42:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238152AbiC1FoG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Mar 2022 01:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231955AbiC1FoE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Mar 2022 01:44:04 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2078.outbound.protection.outlook.com [40.107.255.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76C9E44A17
        for <git@vger.kernel.org>; Sun, 27 Mar 2022 22:42:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UV0T0vPrxZpFvWJBdMMrhVUglIUHkvlZMa78qiaZpbUUkckoa4Weun+h3XseW2uPjIBkRpKqYI8TLq/ulRfRbiK78c+lpYgTkILI4skxGVID5O6dcb5BO8UZ6HHuY5VEtDturm43vpfbXVkHoPYMcF4OabTWHBZyNCL7JhTkZ3TMtJEo87jpLai548864zNJg0/lBpc9w88DzxLc4/m4jERNyaTmgFMz/G3fK5Kma+9aYWLsqsRN3j5NKhRVlQYKploP1jcomvKVA2JY+aShUFusC7VZ9asjvfAqOvdCRZWVYxlNZAEV5E+uikkfKP0B5ul6hENzkYer9eZCmWyeLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0TkYGs7jJ9l83lWhfw2u5LDXrRdBx1PwIab++uEKYO8=;
 b=D9bBERiBT9iUXKgdYhXYiFjlbgL2ePcX+UzJBZmcHRElwMo5FKYgKqmSfaKRHsrtT0dBkhEneRtyM1GqyR80wc0cBekV9Qn1gSvFZvoElPSIcTi7bWkmvd4eNdByGrFpppTq07GNFz+euijUokrlJpystTiGz+OAEn1bddnPy8wjeYW1Vef2NA4m/5EnEJavK5wDv9ELljewrmrG+vIDbCawoPGwA1onmQrQ5RDF2uaOR52VwC+2I4FRn9yDdGgXFb+zexIgcQHNNIc2AOtaj6ZyXA6rkl7BrDTFAnmSBEw37gta65+f6XVFaq43E9mKFhrsh/Q9kBjvIrBKCh78TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=pmease.com; dmarc=pass action=none header.from=pmease.com;
 dkim=pass header.d=pmease.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gitplex.onmicrosoft.com; s=selector2-gitplex-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0TkYGs7jJ9l83lWhfw2u5LDXrRdBx1PwIab++uEKYO8=;
 b=eilW6Sa7TcsQPq46x7WxXs3qiT7dS82wks7ODgXPVFyNyU/dsGy/G0ZJICqAVcJcH/Z/fpX+Zn7QzwNbM2Yrf8x2BTvEYc7ZEduHeRkWpshRrru8FecEYiC15k9yxRB4wT2nS4Yh+/pmTgp+Oef9aXM5CgA1UJWgrVf59Ekzb5k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=pmease.com;
Received: from SG2PR06MB2966.apcprd06.prod.outlook.com (2603:1096:4:70::14) by
 HK0PR06MB2931.apcprd06.prod.outlook.com (2603:1096:203:70::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5102.18; Mon, 28 Mar 2022 05:42:20 +0000
Received: from SG2PR06MB2966.apcprd06.prod.outlook.com
 ([fe80::dce6:c14e:154e:242f]) by SG2PR06MB2966.apcprd06.prod.outlook.com
 ([fe80::dce6:c14e:154e:242f%5]) with mapi id 15.20.5102.022; Mon, 28 Mar 2022
 05:42:20 +0000
From:   PMEase <robin@pmease.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Subject: How to get the original raw commit message without removing extra
 leading/trailing line breaks 
Message-Id: <1BEBB3E1-0089-44CD-8D3B-3AA424C90E48@pmease.com>
Date:   Mon, 28 Mar 2022 13:42:18 +0800
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3654.120.0.1.13)
X-ClientProxiedBy: HK2PR06CA0019.apcprd06.prod.outlook.com
 (2603:1096:202:2e::31) To SG2PR06MB2966.apcprd06.prod.outlook.com
 (2603:1096:4:70::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7afdba61-dbbe-4ae4-5452-08da107dba19
X-MS-TrafficTypeDiagnostic: HK0PR06MB2931:EE_
X-Microsoft-Antispam-PRVS: <HK0PR06MB2931E9A693103F697180D30FC21D9@HK0PR06MB2931.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OKZTc3EXUZISJJvOpiZIIgHufMURvWWi1bPI+NEwzhc5qdhtgt++APpjSe9WS1s7CyWBRxQVgJYHqziXepFgAlTsicp4vV1EuyR7Mg/JwUsAHzoF53eP4MSgjmjcjTk5lPqeXxjXv1SW4tQNstKR8U1yLIIxqJ+ErZwVel+CyMuZmxNqQLgUW2eR4atq/R92wMDP1AuY9NCwoXQvSO79H6fjGPNMHbuP3EYPbKohtdPCvcB34DCK3CU7oBAHVB6ZUCB5MjnMvvFbs5TT0C3EuXecOOZcBJ/eMBGUxT8H5uOE6rMTqNrMDmsR7bigBqTFDkicqIO95WvZXHJlsijbtHZSzjlxFJKzpx9lVqgoBQmS/euI3f9P2wpOJ0wfZp6RkJxlsjaydi9x7bngTK/RnwkIjv8Zd+30KHklGjksEyWyfFI+FywOlyEBKCHfvu9daXH/IKZt92L0IooE6Q8k4kqwE1q8rTu/t85bivttm0Na0nf0rjfUlaaVY1R24ATw1ORMGjLHVSQZ14yyFTHLGK35bNLqz5uf9m9z/XqmI26R8yVFxupAekVfbuEHewLDusSYgHGQxhQx8mINibSQKxIXtzL+R9SfAvPM6Dgvoy01jMqayVxyQZIiQVclukl1WvMIoh43fZFFnpHIH1uy5MeG/dmY/r7S/XJUJrGNWW2YZz87PTMeL+ZSqbSmLpFc7jr2xh+1AlHCeyYnO8bmo7oun3DvGp2zKExyEoB3rSR6oTuo9EGXlcB12lSQfa8dzsKJ+a4oh08TuxSathWl2QLKkn36d2qnxJWU/d7CHLQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB2966.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(136003)(346002)(376002)(39830400003)(366004)(396003)(8936002)(4743002)(38100700002)(26005)(6486002)(2616005)(33656002)(66946007)(4744005)(66556008)(66476007)(2906002)(5660300002)(86362001)(38350700002)(52116002)(508600001)(186003)(6512007)(6506007)(36756003)(83380400001)(6916009)(316002)(8676002)(15650500001)(226483002)(15583001)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YdifzPMco9SUDebAFuMDluaR4UwifrbQ2fbHkNQFs4jDIUtlIsHi+TmRdl/s?=
 =?us-ascii?Q?mdVrUN0YlA488EKUUQKhTSgickT4UBhRTIpNz3d6A0fkyZ5T0kmG4XgwfqIA?=
 =?us-ascii?Q?ZMz8O1w1VePyIHy/JnI+8Qv1HDV71h5BHh/ci8QcYCr5q1SrFFErCyknootf?=
 =?us-ascii?Q?5Iw8KHNeY9+tFGmomAFl91ukmHdVMnIfceFLZ5nhKtGjYnvc8Msyb36Co0ZC?=
 =?us-ascii?Q?gnpqPfwXmoNRkhjeLWcokuvXQghuAfppC0qPoMizh6nSeNgVnRYPO3GIIs6L?=
 =?us-ascii?Q?OckCQKf64eIn4TbDuwSRmvtbx6Wp2EFLrKPYM7a7SOFO5HB0lZOq2zKznXbD?=
 =?us-ascii?Q?JkYc8n5UKFt4U8HsFcJWLxClWdXGVNSTb9RduEjSVqk+cDADTiu3IDYQH7Rs?=
 =?us-ascii?Q?KjX1LmvunnheLrV8NHtTEspqCO+0Wchz2hT5H2G4wax6C5LCnptHPy0qaufR?=
 =?us-ascii?Q?w8FQS/X5+p92vZVCgu3To3dSkP3coM6syi1Y/2YdHupqQscIhsjlRGyfhybu?=
 =?us-ascii?Q?069ZsrQ4imOqy47hI8DCbkTwNPhdIMxZQIvgw0f1onAuTqR4w8Z82kBap2Ss?=
 =?us-ascii?Q?MmDUx0LH2ToiQWcLTBwuGz62vrNZ8gl24yTDxzoQIzW5Cqbn37qiwHk9RIic?=
 =?us-ascii?Q?ylZdbfL7LV7XL7mcZAh6IVGFTTvdXvna5ynPMD9K2cmZe1IaXAGMx/07tMbQ?=
 =?us-ascii?Q?LHrGxs9ZTxhcQbSLw9VMVAgQGKcG4zEd4hz8X0AT99jKvtfxLCVbb3OofvJP?=
 =?us-ascii?Q?Of5bGsICMsc3tPg1YFTasvNN32+H4ZbTkRQ3PbwYNc5F7tba3lNmabOGnbwj?=
 =?us-ascii?Q?tFkZPdGE/1/1CBkoCsx7ox8/qBDS3c2F6LJKI6U/LyGsWTwXWSfS5xAQt4jM?=
 =?us-ascii?Q?Jg9dngmO3CPJPDbcppOGUurhLRAKxtpqsvlozjh1XPmWYJjxGSW2sd6pMLin?=
 =?us-ascii?Q?juGG1fddKaFv5TTv8bC7DfhAHjUN/uUxAeic9vNU46/3J+A6esUomUa7G9gb?=
 =?us-ascii?Q?FEq9OyceCh1wHT8c50wyMC83YPVwA4uEueTLJJsbLluplKQuUvfnU748mG1N?=
 =?us-ascii?Q?7QHINML2BFqlfRAMggjI37FooC4ZoI9/05ZXoQCcLe4wQOgPB5LNzmlo2ntV?=
 =?us-ascii?Q?+tQVr1lFDZPaK2b2J3yHAKqermf8s42hjTZE3sYS2ZrxXet+IJi3Rq0nhwbY?=
 =?us-ascii?Q?/RDVBEE/WhUICKtHfRIhQ6hsiAOPk9cAunHFQYmgQKYKH5B2rEp2b9DIxIbb?=
 =?us-ascii?Q?r8N3f0eNC7vICe+nnkz87eHs7hiAkGfZwn3XbrjysfwXZRiorPC6ygBjOOFZ?=
 =?us-ascii?Q?MprjUsdGDPHThi9lV4bfnWmEHGfRTJBtYt1FrGKnF34srbKzsyisaMKNGsU4?=
 =?us-ascii?Q?RAtn78w78Pn45jQrbC2jwjbaKOxq4+deUWX4Nasst8JgtM6abHqVBtvn0ot0?=
 =?us-ascii?Q?4/A1Bav3iFqjXYN8ojlNjmAjBNbhiSi5Mkepj5QSZUoXK1733nh1VZ9UAogl?=
 =?us-ascii?Q?BrCFu5LPTkcnvjUb/jOntgptKCb/eXIktYNEB9T7+W2NM8bKMhduUWPox5/Y?=
 =?us-ascii?Q?joQk3vYOyUM9tDjrN4hJlVB0nodpH2rpwm4bLaA0XQQzsLxk6BErVoGs/WpQ?=
 =?us-ascii?Q?zAKyhZrstku0QuSyUpWtubLr0qRQRx/IdqAg0bEouaxyJ5oev4cXpqj1LD2J?=
 =?us-ascii?Q?MS9T6PPhmCWLsREgbsZ3MVDAtMaK643Ow5OswRawV9Kxw+F9KS9aH3QsoIbW?=
 =?us-ascii?Q?3qF6bQhzeg=3D=3D?=
X-OriginatorOrg: pmease.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7afdba61-dbbe-4ae4-5452-08da107dba19
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB2966.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2022 05:42:20.7087
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1cdecfba-7dde-4cf3-9831-7a4189f20315
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bRfDP57XH0dv0/cjVEY6KUVqtCgdw9+oHoBCfF4YvOs30KfC+S90xiIk06CAuPpy6oB6dovkhQYj/uVK8dyJcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR06MB2931
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Folks,=20

I am using command "git show --format=3Draw <commit hash>" to get raw commi=
t object in order to verify the GPG signature in my program to customize pu=
blic key loading. However in the raw commit object, extra line breaks befor=
e and after the commit message is removed, which cause the signature verifi=
cation failure as git generates the signature without removing those line b=
reaks.=20

So is there any way to get the exact, original commit message? I also tried=
 format option %B in no vail.=20

Thanks for your time.=20
Robin=
