Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F293C19F29
	for <git@archiver.kernel.org>; Thu, 28 Jul 2022 08:23:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235123AbiG1IXc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jul 2022 04:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234819AbiG1IX2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jul 2022 04:23:28 -0400
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20092.outbound.protection.outlook.com [40.107.2.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5115962487
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 01:23:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Blh7w7SQ4q3k5UOjxTYgg8qlm8Wf9Vi3aDwe4HtKHYt7SLeui1CLRb0J+uvnWJWPjHBcg5NFPxDXKSWX9ywDS2IzXEZxVnYyN0EnM9AWPEGdxoiiuaAAjcsQzPBIlqf8Oq2Mf54UqdC8NaweCsAoxOEMoBHOBI7uOjquhsZ1/JBXZq8IOX9fm7qKxadmsjzPBMNfR4mNWviQBTEcrc4pnjTJlfdyWnfOHxYzzIxUZ0rxo2BxMEokfPFtRu/2sr8Y5BoT7Ki1ZS8g9Z6sl8wCVeuOwzxIr7iFsNXhpolTsgcr1k5Tn9zfCfoOsYAqKqeGXtX8ilv+4vaZhflZMl+Nkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8qtrRcjU8r+OUBFQrPBezAo2UfkM1jvZSEMU+qCWplE=;
 b=jKqITaBb3aAhlz5I80KrNBppYjOOxHKW7cQ4Jl1TNtSUZbm5d+4ynmA78n8LWicBcO9TjodgiSlJWnTAacPGooyyEITn0nRu/kCTLTwTMYRsCsXy1rT8zgIiw2CpqGah8Ik1MPkyF6tk1LRhaDNUSXLC2M3fttscFLK24hcYxJSID6cdtjkie9hOKaarIYLtWKYhOX0xb9Khs9V2w71Lno85mriehwQyQtVU9C9QNSwV7sfLKGS0lsPTPuM6YOvG4eB5irmtdeGLoiagXKu9+TNWVvGltCE8sTzxmK5CMBdGj3ihaEnEZg0aDounPrBR2VvJM4ozxct9Ap6dbTYC2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=olc.cz; dmarc=pass action=none header.from=olc.cz; dkim=pass
 header.d=olc.cz; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=olccz.onmicrosoft.com;
 s=selector1-olccz-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8qtrRcjU8r+OUBFQrPBezAo2UfkM1jvZSEMU+qCWplE=;
 b=uqQH0yuIBnvQGsHGNfcb70tkl/AVlYXG2c8Vkxa05/GbbWG2iuGewPeNCXEJonIrU5rL5GUWZ919OmaLxWSWH1l1pc8OzFFQ3QPpQPUsukqA8MSiDh/VNNa+ySMl59GQZZbiSs8SLjixYTEzED4ILhE9FlocEdVfxnp6CVu2Xe4=
Received: from HE1PR0501MB2409.eurprd05.prod.outlook.com (2603:10a6:3:6b::15)
 by AM8PR05MB8004.eurprd05.prod.outlook.com (2603:10a6:20b:364::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.25; Thu, 28 Jul
 2022 08:23:24 +0000
Received: from HE1PR0501MB2409.eurprd05.prod.outlook.com
 ([fe80::6c98:63b7:c190:ad75]) by HE1PR0501MB2409.eurprd05.prod.outlook.com
 ([fe80::6c98:63b7:c190:ad75%10]) with mapi id 15.20.5482.011; Thu, 28 Jul
 2022 08:23:24 +0000
From:   =?iso-8859-2?B?TGHvYSBUZXNh+O1r?= <lada.tesarik@olc.cz>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Lost file after git merge
Thread-Topic: Lost file after git merge
Thread-Index: AQHYolrq/tXrjmMn3kOeCoPu6QUpvw==
Date:   Thu, 28 Jul 2022 08:23:24 +0000
Message-ID: <HE1PR0501MB24096E2FBDB66318A2FDADAAF8969@HE1PR0501MB2409.eurprd05.prod.outlook.com>
Accept-Language: cs-CZ, en-US
Content-Language: cs-CZ
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=olc.cz;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b327f40d-090c-4351-77bb-08da70727084
x-ms-traffictypediagnostic: AM8PR05MB8004:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: esx6sHy/Nq/GX9WQiunoY0ZwO+xcc7zrUvna9nSX4+pj1VqVswkQGusaJzZM1HmVlWGUlhdauVDxVwtks/SWEXeunbD0Y+nVckFwRyTSHJS7aesNp4DISWDzQLMrVN6aQUMMQBJq+5vv7y2qlRo2u0isSaod9tNF+jdcayxE2BhoJ5S4XkTSrEn5jcj9gDp529ZP5xYkrDPDig/u3NXXhQZna3erO3WjqzMrnUnG3DBw9p+DU64vCZdhX4GJS/dvsf3Rk4QBbr9npzCGVEPTVzWrWCchEm/JuQBZ7X6spIfy3ytUQuqqRHLnLF+f7DPyB3kOVsrkpqgP4S6e+ZJGgvCswfSLfe6EN27xgFS6LvY3I9+UBljM0cAmICL4hWv7N+BnvO5MUOlY/wqXWdcn65p4k3n5VZjL1Kel0B8WZ/8xRBi+ecn2ciU1OAfu2cHCq3WIcBpDAIfpIj6GIBREqwIfDxGxXPX+BM9d6pzxqwgF8JqaugC/XmlU8ZvjREWanaZFOx1to6KNJDe4RMMsQ/zlNCISA8DfwBM3M16D9YVv8/ndmK8nJsbS+KocJD9HFEXIrBTCwM2TmNF8j+WbPMVLO9qlCrzGtVejIdP24UIFGU34c7iD+3E686ancHqPPVvKgRCIjKU37kIrXKMzOd32Uq/B5USkOUG4IswTYhnXG1vnLIh7CSZrPYVVAiKApQxhnfRxBqkgy65eMXT+P6KvU8fUlX44DvNvr+0TNe8ahuzvQRNDZkABGBSPGn8Vi7jXTTXsnlc92WDfjL6NutGFwdSghzj9BfLh8TLXQJ0sR9oN35r30b8ur5Ua49A+wAQ0us6D4rTR6A7V9CjTMVT2OpDBBaZdcUWy8+NrOPM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0501MB2409.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(376002)(346002)(136003)(366004)(42606007)(39830400003)(85182001)(76116006)(64756008)(5660300002)(66946007)(83380400001)(71200400001)(66476007)(66446008)(91956017)(8676002)(41300700001)(8936002)(478600001)(52536014)(2906002)(26005)(33656002)(4744005)(966005)(66556008)(9686003)(7696005)(316002)(186003)(86362001)(85202003)(6506007)(55016003)(38070700005)(6916009)(38100700002)(122000001)(15519875007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?C9RAixvmm6rZxG/m9ip6ufQHC1H8SZfCHsKe1/dhmFlH/gOAUEXvQeJpZZ?=
 =?iso-8859-2?Q?QcrWWfqNEBo4A/d9ln2tgCi0tXJvMNsx/t1apq1poHDAAMGpAxAhxs7LAW?=
 =?iso-8859-2?Q?6dg7gI+GmoZVL4ucpbxrkHyEH+p7n+ky/k6kwXknpU6uAVnNgGPubIABQ3?=
 =?iso-8859-2?Q?fqyLkcUZs43opt+9wrRYe/4BcbOY4h72Ta/oTkk5XxV35KwSjO5QcPV3fu?=
 =?iso-8859-2?Q?HxWXaJJRqP3XW1Sp8criaTFzjSIXYifLq3+1RwV5ZYY9ujAkX+s4C1uE6f?=
 =?iso-8859-2?Q?juC4UB/jJ7TSCNHe9PYSaPPcsuywB0erEnyWDJNQUUh+6ZWtzUu/eqSdle?=
 =?iso-8859-2?Q?6s/m4JCTI9VU9uyB95v6OS9IoY8iyu+wRu6qnZ2yRt5+mzkNyXhGq21CTa?=
 =?iso-8859-2?Q?B5qGNR1Jqj2d/WdIrkIQXN03OesReYiXS5nYXC2G3ODihD11U/Ra/nzdX8?=
 =?iso-8859-2?Q?TzUDawU+snpliJn1uN8vK05YIoc4ke2QpEpe4LUw3qKGcEJYDXSjJlh7v1?=
 =?iso-8859-2?Q?YVPMTznQ4JH1jdLLQNKaeK+V/dEeHO3qeH5/dqBYwj6Iw+drgaFspqOITF?=
 =?iso-8859-2?Q?XNKpGIeDLtvNQ+kLABdtj38AIVc9FeiS5xFC6oLuOzX2XjV4chqSnuKvVN?=
 =?iso-8859-2?Q?7UBRsADbZGHU2ru4AGYAV1KsJR8VnT+uZx6XbH6rqclmPTMWxwOU5tv9Tr?=
 =?iso-8859-2?Q?GoCD0WXO5ZIGXKCSwhai4S6KidWBDdSZYhRoeFVL05aWwxKHE8OZtwnLLH?=
 =?iso-8859-2?Q?Nsff95S8DjpIa1y6Y0dxi0ZdW89GH84RTV0v4bNezZ5KaRF9z7R5pL/wC1?=
 =?iso-8859-2?Q?hyizCIjazw0469Ld+ncvydaCbDAzNWYFAl3eBNsHCprX71+Hjgk/I6CtFj?=
 =?iso-8859-2?Q?vD7hSaIKWifXj31Hzeslc3rPtLZUra8AZmzC+vI6tc4yxB72huKbLrcYHv?=
 =?iso-8859-2?Q?7VjDz3gmHcb5Lb/3hQHOjQtp75W5H4/5Mh+8j+c7OgNHiVWw4eUxBlBSHl?=
 =?iso-8859-2?Q?CEmOcFODAkMiSaG0kO8HrF1REev1DElIx7WfQH27SBR0G41TPrY9YrRliI?=
 =?iso-8859-2?Q?bZmj+YWxTGc8ikD7O0ubZmewjXmbXvJG69Tdyb2UybSPM6RNUMHCzDCrKg?=
 =?iso-8859-2?Q?hAzZtSV6KUfhmaxaZsHNQ7VQfAW66Yt66vjvp2+ryel4EKmYLbGdk/BNng?=
 =?iso-8859-2?Q?R2zAqZdzQxLBx3ChXxbN9/QD0+nrkGTKFiOGkjFFKjLEiOSdrMqE8aHj/3?=
 =?iso-8859-2?Q?C6lHHqjT/mqiBbsNafXR4saHn5KQGf+aAVyqoPtnkb3cDVCvxBzrodqlYP?=
 =?iso-8859-2?Q?1RdoSwq8l8WJ7fvLj6nyecsFlENnEZ1OrCtO0HsIEPy4XTQ29AH3l/i/oL?=
 =?iso-8859-2?Q?JnwtcQmY0UpZOU0RALgZ0J0m48b3SziZebj6oqH0hQgnR76AtcvDUQ9DiU?=
 =?iso-8859-2?Q?vsLkgbzZD/PzTqu1lU73qsojvpGZOPe93FurKsf1dN0RZAN9+4iqSYoYNb?=
 =?iso-8859-2?Q?PeWhjQt/hQyaFZ4SRJFzOAjTtW8OpH/EATIC1/t9xkx1cY5LNNigYuYbX1?=
 =?iso-8859-2?Q?JLbWYUXmDOHouGP+d6RwBODv0+dZz/vJozZSNOGJ93neUt6GtBuNN0nTXo?=
 =?iso-8859-2?Q?kU9U9FcNdNo97fQ/PgXtaQY/QGE7jOI7hD?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: olc.cz
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0501MB2409.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b327f40d-090c-4351-77bb-08da70727084
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2022 08:23:24.2502
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 146cb6dc-e7e1-4e10-bac7-5346f797a2a2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sw4n8PWonb80h04tDvKtz4/2OvJmzQvs1rjyAeWmyszuyEoqqlPLOLhThAN67n8sOLYodGWQWhfIguMjVmz+oQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR05MB8004
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear all,=0A=
=0A=
recently we experienced strange behavior of git merge after deleting file i=
n two branches and introducing it again in one of them (revision graph: htt=
ps://i.stack.imgur.com/jNUZB.png):=0A=
=0A=
1. I added a file called 'new_file' to a master branch.=0A=
2. Then I created branch feature/2 and deleted the file in master=0A=
3. Then I deleted the file in branch feature/2 as well.=0A=
4. I created 'new_file' on branch feature/2 again.=0A=
5. I merged feature/2 into master, merge introduced no changes, file 'new_f=
ile' is not present in master.=0A=
=0A=
This could cause problems to our team in the future, fortunately we noticed=
 it this time.=0A=
Please, does anybody have any explanation for this behavior?=0A=
=0A=
Or is anybody aware of any Git or Source option that changes this behaviour=
?=0A=
=0A=
Thank you very much,=0A=
=0A=
Lada Tesarik=0A=
=0A=
P. S.=0A=
In the picture the steps were done with git revert command, but result is t=
he same if I delete file manually and perform git commit.=0A=
Tested with git versions 2.26 and 2.37=
