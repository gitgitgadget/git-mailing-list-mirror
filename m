Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BF96C83F2C
	for <git@archiver.kernel.org>; Sun,  3 Sep 2023 21:29:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348521AbjICV3h (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 Sep 2023 17:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjICV3h (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Sep 2023 17:29:37 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11olkn2037.outbound.protection.outlook.com [40.92.19.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05A89E5
        for <git@vger.kernel.org>; Sun,  3 Sep 2023 14:29:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b7JIHXRFMkB4M4ViasKNsd8O4C1iERvIYlMxpWIq2uQTtsQtsfPpcK7qYLv/qzsL5f8oFChc7KgBgIjL6mpmGvAkJENNlhvJcEHviui7yr7DdZCnPZK+Moi4BXgzxd/lAvfjV7/YmDKJsO72SSyh382Pt+qLx8jUomZ8o+WYpv1w7RBpMtKxEfaFlRbhCc6xGLQdVvLL1g9z9P0X5fHORRnDW1BJnk5udrg4FbwklL/71p4MEaxa8nepydpVHnc0M6ISYAgCVHcEH6efzkGqJOjjryO4d6CdGtYb3ZkR49L7+iRcAUvBnUTkJMVMpAN9xFrvD4oSlLRmwgdGlTKMhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
 b=LWxwXFvOr5AMozbzu3IChe1/LQ7Ul94gu5E2tU8YvyH5aE1Qf9WqcJrau6AJVcWdGdAhFtg+OKeye0vyRRQgpp5JqLtKpNQlDtbPHa+LqvK4khOKw/hVehUyWn00bnW7RY/CYOhlSVY2a8+sPOspPJpU7Lx4qVLVl8ncMb+mnLq/qWfgT63R0n6mKHZ5E/OYhw1h+oFyFFrbIgabGJh5JYDiZfyBSokSF0VEbE3fIiPWkb586fDmvwY3UfqVMBdt6/HBq8XiRJlU6aUnVWgxS4UcaMnFFj1SFseX9o8pKSkZYBsXQnfoKXfWC64+57ocX0YJWIMWVNtVqMGVKXjOvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
 b=Fay6kybqFrO+DJpqN7wTehG+XYtfdgJW/X+PY8fHeAD+n6hktrxe8PaOZglRjU+MKSY9mAR49b5+C4T8bgfbMfLhK7wrnPJmbEqHlafePCwi5buaEgelvOWhwRvX3nsN6d/dim6NTQeL6RwKgrVcc5FcsjKEAVQh2WVO5X8zXtBNwsUxvAWcrxP3xpRjy8/V7sIfF4/M4r4xCj9CImgBB1z95zh6EZ3SsJ7xiIzR+8Lf/8kAbzZRlM8b3b80kuZPNREYp5Lb3RKiKTtdUq2lmTSuG/JCOnoEWueB0Wj7hUWIQbzDqckTBIQYapGnhLUUwaJVi4if5XpPHkSNkbSMCg==
Received: from CO6PR08MB7690.namprd08.prod.outlook.com (2603:10b6:303:135::9)
 by DM8PR08MB7447.namprd08.prod.outlook.com (2603:10b6:8:d::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.30; Sun, 3 Sep 2023 21:29:32 +0000
Received: from CO6PR08MB7690.namprd08.prod.outlook.com
 ([fe80::1ff2:f621:3023:c786]) by CO6PR08MB7690.namprd08.prod.outlook.com
 ([fe80::1ff2:f621:3023:c786%4]) with mapi id 15.20.6745.030; Sun, 3 Sep 2023
 21:29:32 +0000
From:   tony raynes <tonyraynes12325@outlook.com>
To:     "gitgitgadget@gmail.com" <gitgitgadget@gmail.com>
CC:     "Johannes.Schindelin@gmx.de" <Johannes.Schindelin@gmx.de>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "newren@gmail.com" <newren@gmail.com>,
        "plroskin@gmail.com" <plroskin@gmail.com>
Subject: Re: [PATCH 1/2] am: pay attention to user-defined context size
Thread-Topic: [PATCH 1/2] am: pay attention to user-defined context size
Thread-Index: AQHZ2+BaHhsI/CnD80u/6v7M7vzuxA==
Date:   Sun, 3 Sep 2023 21:29:32 +0000
Message-ID: <CO6PR08MB7690C44ACF26939BAAA62E71F5E5A@CO6PR08MB7690.namprd08.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-tmn:  [keK7HrVrNENa0e8nMHOrebMSzTtLw/0GHEpnKzUGLuY=]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR08MB7690:EE_|DM8PR08MB7447:EE_
x-ms-office365-filtering-correlation-id: 661e1952-24a0-4283-2a87-08dbacc4dcd9
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Z12o+jeog6BlEJ9V9123DWkDjdrNO5uPOSBNId9nD8zkCZCNn2wVqKje4z1r0VHWqqpux12LyCnaRs2UXZDJ7GxVBnP3zNLXcu4UdYuzi38HNVamGum/NaMNZ/Z5wM+w7/slIvk/L+Xpyf8IN8/JFjIyD5kju307hVBqHQd4XZb+pYNZ02usl4/udMrrp9Byp0zKnzUMlCTxaxZr7inTF/DwT3QYzYdKGkpM2FizHCCzIK7x6zPbKBFO5KjAdghUIXAiyWrsrcmbLahJLuAZCS+hUpMtWMgOzHCL1o7WV1k=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?hL7ygaOWgLRaTDIiFOtF2DM3gGHuusQl72uv7EOMB2rdKy23QF+cUZFaZj?=
 =?iso-8859-1?Q?uV61Ewr75RBExENgMZ+T8z9YZit8q7deH0QkG41xIsMPhCK27rqXhRCDsG?=
 =?iso-8859-1?Q?794qSX7mDHXl9PiV4AxLjdwW7W6rSv02oDxdHvZelL2/0dmIWL7209abwY?=
 =?iso-8859-1?Q?tRhHIFjuBXzcJ6PZw/FXOCMBAlWGAUQm7BecdRYye+6oRHoafFlgdn2iOx?=
 =?iso-8859-1?Q?RYEG0zIfPH9D74lJ4pybssS5EKaWmQqlLvyUVPYwp7WiMdmIwAgQTtuu1d?=
 =?iso-8859-1?Q?5DSkcl3Ct0YGkzzM0azCtjaU5pwVpqdGfb9Qa10ZpIcz6tDBvbIAd4WCCp?=
 =?iso-8859-1?Q?h46/GWxgvsTViGIiDuedVg2bXUpqq8drzbbplB/FthAJnNPN7b8PpLOOlD?=
 =?iso-8859-1?Q?K5oefr52y5Rljk4BTl1sDUKHIDQaE7UjiQnUAWpx+5CrkpmkM5ArPiGT33?=
 =?iso-8859-1?Q?PDsRhBwpDz2ylAXSoNS+r7Lf1T24yaNkKtiUjIZCk4gpdukdx0yQT7H2Ud?=
 =?iso-8859-1?Q?f9v3EfVfIOjzGRBh8xRWit/4zpJxgQPcQ12bqZyH6Eq6LE/DKUyHxfaNvr?=
 =?iso-8859-1?Q?8Gw5URur0y679+6g64QIm+x5M2FlOw/NqJsyj8UEgwLSdlzxy8taAHKQDl?=
 =?iso-8859-1?Q?wlhmxBrFMiUkVwPN2jwKmiBfs8mXwcRz60z/YVWYslQV127LKiLHI4F/dR?=
 =?iso-8859-1?Q?Ox/v3Tq/6iPsnNbhAZ89Bto4Z9XCaA4wUkM5k/6tkp6aW8lLP2wwMNSehC?=
 =?iso-8859-1?Q?5SmKLwLNYS9sW+SBaL7WsRRjZ6ANY4nk0uISce/duSiANe0q/AZXo21SKk?=
 =?iso-8859-1?Q?6Zp/e9gLowu01z66QqEMuQJgft4leb75Rl7URlc50zOWwRlUIQPTgO+83L?=
 =?iso-8859-1?Q?yLcWohbDcu0vN+uLb3nAEjomhlhBEfyefQ+siBhtQNPJVznfeJxkJ/2lBD?=
 =?iso-8859-1?Q?bKACQU/vAHpsT3GkzmO4SeARUbXplh6us+e/cUuFnG1UUt1C9raGXGjUoC?=
 =?iso-8859-1?Q?5b5UPg0L/spqQPwAawhsZG/Y/qGpq3Lgw5Jpnrh1k9m5us18Bfl6ywbkLw?=
 =?iso-8859-1?Q?0lJPCli0WsoPp7JQ8ytDZio4ydkFitwZUgvMbJGmHVkWbIKiGHXoDq7l3E?=
 =?iso-8859-1?Q?VYp+WAts9Y5QU08BNdrFyXe+AMZSThqhdGflmGoDQJLXhEdjL4Zx9G1/Ly?=
 =?iso-8859-1?Q?d3j2zBBRlHmItqCtQFm8pYKlptRKginKbsNZiorY2czTAc1amnkF8QPHjB?=
 =?iso-8859-1?Q?nb48gYlfm98FiwyvG7/UOo5ASwlFm+NBfR1pbNNpc=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR08MB7690.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 661e1952-24a0-4283-2a87-08dbacc4dcd9
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2023 21:29:32.1562
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR08MB7447
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

