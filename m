Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4958C6FA82
	for <git@archiver.kernel.org>; Fri, 23 Sep 2022 15:08:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232291AbiIWPIU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Sep 2022 11:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231879AbiIWPIS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Sep 2022 11:08:18 -0400
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01olkn2063.outbound.protection.outlook.com [40.92.102.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC057E7437
        for <git@vger.kernel.org>; Fri, 23 Sep 2022 08:08:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EnAIEAIrOwd8ElRhPcJxL2KZDeDJmeHzvHSWdJW2bX69gCSksD9HDFo3Z666MrMNKBZ/g5zx/ffcZEN3Z6EQcLzSHTiMF9cMy7quw/lZ8qGUet8a3W33+vkeeJTd4szoYH5yDGVFfN4xscaJCqHbw6VADE0UO/0HPx2QGBwxYA7OrFFK8xDkKCkFqeaSWm4yS95onO5wDHS8M708j4oYseiYIl/U3lZ18nlUUoKOGnIfvNh4NmcQlTZ/6U+FzTYIGJE0lnEWwArlO8xLm0Eo7QMkuGfc/2ZnVY/Ol9EfxyHZlJYdHC9FnN+mqi6Wt2qZAuI5ybxZksiGmoydv3i2IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ht9G50SlYlr7BPTCuy+KjNotHQlLEXbSKghIYlF3TI=;
 b=fG3IKPVOZU5sjjzsPXugx1BV2FJMpB1SOjyc7Y1i5q9t9h4dVGX2q/eFQcuEVhREI5x5N52tqZbB3otN3mZjXeyLcrqgdPU06uRKLpvF7aJ4d5n8o72xNmICVrBaDns7TqJZUBtgMNvoNomnVrbHMjeS8jpnIn0MAGBy8Aq11PMIGjmTRa97yCxa1rJL8B9VqB+rYBCUSZJtyxPY+TLH2ErvLKXh2eJ9LTCJ8rpr+SWZpHFpMbKMD7ycnBqPYdAb+rLDtNoLyAo2HjZf2N9JiFMvkNe+N4RrXLRplE3ZDsAVc5p4lydLfFQv93AOb7MjmWJtHJv1be7ehTyYfU8EDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ht9G50SlYlr7BPTCuy+KjNotHQlLEXbSKghIYlF3TI=;
 b=Fj86wpKWdRaeBFV7Gzp7jvOBJofr8Y+/MiHbrO0chr2G6Ht+P4YqedBPNKGUcQHx29tE8ZWZiTcWn7aOYBikISUVNbmb8CLUN0tjRlMJCI8gNKJPjUZFvZ6Op+yQeuZf3mtWeBFZDRoKIEjSygarrlBjVxdEgke7MREE8UMyJvNyJMr03Cia6DQANwvuRbS5zy66z7/uBrVHS3SuPKwQAfe3bkVtZVgy9OpQRXF6olI149UjtnQMR8eNtj3N2f+Db2vlAGH2VRvXXUS/9vPe2g5/D+1BYhBJCiYbiblFw3uqFYB95vy98+PApfp0shKkf5l9e0jSbYdzF42bNdjL7g==
Received: from PN0PR01MB6052.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:69::10)
 by MA0PR01MB6500.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:7f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.20; Fri, 23 Sep
 2022 15:08:08 +0000
Received: from PN0PR01MB6052.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::d1c5:6f92:f641:ae8a]) by PN0PR01MB6052.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::d1c5:6f92:f641:ae8a%7]) with mapi id 15.20.5654.020; Fri, 23 Sep 2022
 15:08:07 +0000
From:   Bdazzle McGregor <bdazzle43@hotmail.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: https://git-scm.com/
Thread-Topic: https://git-scm.com/
Thread-Index: AQHYz15Jn7Ys4Hl1PE6hzU4eTfdW2w==
Date:   Fri, 23 Sep 2022 15:08:07 +0000
Message-ID: <PN0PR01MB60521A90E590D70C6E9B22EBA6519@PN0PR01MB6052.INDPRD01.PROD.OUTLOOK.COM>
Accept-Language: en-AU, en-US
Content-Language: en-AU
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [rhDRmtlIakme74nG0hr2bJhUhzPQlAZW]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN0PR01MB6052:EE_|MA0PR01MB6500:EE_
x-ms-office365-filtering-correlation-id: 18c2e63c-1d03-4750-683f-08da9d756bdf
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sDnklb1pSlZeSlpRrxBy53CDRDGf04CTg1WkM7wYC7/1+qfaXrdLeIphzqeFA1Y6FjOosa3TSYoJeePvhb7uUMkvu1ij9pRfHdcZBpw5Njhgz7rMFSTzfZtoqv81Tc2YeYadTYB5tKqRxtkausYxiaf8aotog0vosnLHHvKKefM08y2Nw6oow/jJRIY+SDve/fvhsIcskEqruy0Q9Ota+jbE4renNwWpbFlHvNMH10J7Blwa/NgFN/AloxohOmLeWd4nrpabxTQSYK6RmpSBLDCv+iF6D1Mvum5A2pNd8k/PCZGxSYIetaCElO1EwH7/OAhH+L5KpR/lLT8FUOy9YWcg757H3PKKprLJrFv4lz9Qkc0AfV+2i6lpR7V1xFL4d7IbJHTe5803ZCApGzFdYbE0BiVPzPFHpHsh3kWPuH2b3c6NdWg/SB6tHnx2aM7Md3Ub6m5BurKuviXZHXX7mfxCVk/8xpFipsh/Dg2yaUcx/n1pAI9XgEyg6EXch2tu64Ywt71Kv+/5Bm0EW1S27+keZNnHiX124sG60xMeeftEqMFViz+Y25DqB/jphg3PUOxMqfp5aCt3xrHd6b+uf9cJh4V9popQNgVEwMYFDQHkP5fiZALKaDul/cyMmjRK
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kIgFJfWnk6KEJVWrRV2qPXjXbgRZPK3Z3dl0AuGEUodv9Y1D9Y68N9pHkSBU?=
 =?us-ascii?Q?5apyFQ3tJT4bSsypYsXOlBbnK2esZPXmjuoEvRxFwL3TFlcWDN5updsSdgs/?=
 =?us-ascii?Q?juSEt1VlYO7ybLS9V3Fvyb6Hmw//x1awlIaPDsHSbd1BcIgLHc3MbC7VLBm5?=
 =?us-ascii?Q?aoHUWsQBmKABDUpItOhnrhXjpUlv/OqM5Zx5ize2GsWpc5YkZ/7CUAWzcRj8?=
 =?us-ascii?Q?nf9W6chSp5wfuHCI7QG4GWjg0HkD7vWyVG8Mwjmx7FaREm7FvOEcOKG5z/cH?=
 =?us-ascii?Q?EIg+ixqpd+Hp6+hEsJz4343cln52JSi117SIJ7qpALMYw6D1hhOIIKc9GyLR?=
 =?us-ascii?Q?9NLvPJzARwqVUR4mHOzvFxitBZk6mHeqPXFNSgM5zs99PUIDv7spGGPXIYsj?=
 =?us-ascii?Q?8oWxK8bOqmSpJkrn7jGaSgCI0XN2BdJq97wgoNWLXooESYb0FF38T1dMSWDC?=
 =?us-ascii?Q?PJD9XjWb+du4LOKCRVwiHsbTLIasEoObYyLXJ8/9TWUTv+8Y4/f8+vuuMFBP?=
 =?us-ascii?Q?SA//ajdCJacMuIosqjK/3PwRqI30m1PcejG02fELIzYicHhGkYtZfZsNcUUa?=
 =?us-ascii?Q?U/pmgkaGSm7InoumDVzlj3TTzRavq1iX3KvwmlBNSEguMHbJm6z3QT3vpUNq?=
 =?us-ascii?Q?YBcolIdI371d5ur8PtS64uMwCz34wgNM13oKT3F+myKBednaDY6rsL2nqSbF?=
 =?us-ascii?Q?9n/3C+G+i252KnAEaZL8rvjvO0hFh0vWN4hIs+YoqJuDQ/xe0AS+26xSuPhr?=
 =?us-ascii?Q?lvwemzmjAjBfomqcUJpxriPWnhH4xXB11qNA000xxDx80xjLGVLuZJ2CiLS4?=
 =?us-ascii?Q?kTKCs6m12zNOFP1wj+FxCnuGDZU+DO/R/KmWvkLMijz9hW/+/AOelkpi2omc?=
 =?us-ascii?Q?5Mu/kKfoYZF/SG1TNVmhh/GXmXCwuFluEdtnxPVwHLspx0eBMmzTKQA0FukO?=
 =?us-ascii?Q?pIS+vzy33Jh0ld2zATZpzfGUHBOTCFaYqJx4y/jk5ry+zFe4pLnGPmKf8sQF?=
 =?us-ascii?Q?sTYMoY9U7emD6e4xvWkep6XekfTDdmpJAJUZKocTx6QvseskWNJPW597wzPq?=
 =?us-ascii?Q?SAGM5r6fZ4h6CFBwvLlxwMgQiledpaWxq5K6TlscMC1jQrx/4UbUhDLQw7uj?=
 =?us-ascii?Q?cD0u94v0n9nnEfxOEUs2IhY7lUEm7LliforKZG1stuaKaS/NqePOUr4VhbAp?=
 =?us-ascii?Q?4zgP1sK3t3TEsu5C6KVCNxqtQF6nAOS951CckWVqtNNzlQih75C73DKGZEdJ?=
 =?us-ascii?Q?XOJqvN6m2CLoK8d1FmrEoEvTkr+eOdRtJmNlxQCAMQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <546C411B30F1CF4B8DD6B57E5095FBCA@sct-15-20-4755-11-msonline-outlook-42ed3.templateTenant>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-42ed3.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN0PR01MB6052.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 18c2e63c-1d03-4750-683f-08da9d756bdf
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2022 15:08:07.2571
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB6500
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



Sent from my iPhone
