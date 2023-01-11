Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1A86C5479D
	for <git@archiver.kernel.org>; Wed, 11 Jan 2023 20:09:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233380AbjAKUJe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Jan 2023 15:09:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239587AbjAKUI7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jan 2023 15:08:59 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11olkn2049.outbound.protection.outlook.com [40.92.18.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35D78127
        for <git@vger.kernel.org>; Wed, 11 Jan 2023 12:08:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cnj9UH3dUNcDknaMFHscGmcL9yT0W+AnG7IHBunXRyJG9Hd1xSLB6++W/3WcmtZOxQ+E61D485ndxfkLK0jVtsNf4gSlkS6IGPc/nj6yH63BqYqCif/0lN2DgPejsMd8OVZtMTmo+aatBMx3m5jwRNwsxTlaXOQGNc81p67/ntLQyVSy6H7e+tFlumuBy6wYYmwugIzzXegOmPrWzvz8xPJhvZBg10zY+tzDEzvAxVehxVsznYid0ZSdZtMlfXamzFkarB5X1/NvpeW4vNzFYlNe93WO11ZQlvrnrt6seIxLzepbKLmG2y8q+GfcX0sV4YGr3guA0ZAjhhSHgAtCqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p4ljIEVQ3cRxutkRG3gOfr27OPemRbjx0EAIlASsh7g=;
 b=hRYlLHCxbVDZY/s12U4qIHCL+YJHgj0OIAhr9fsDos77r1BGAKLT4zlnKTcYDtgEKHdZmacndJRPPKbWz2aiO/hKaUY2B1HMUy/Ug7imv89E7mz1xEBX9G3/YmEYNi9jDRdVei4WE6Ie/AB49v0dP7pzi1rHdrJh/m2eku+Hl1PCGGRni5Fd2uXpldztMRZzTyQb6Tq8iYqubIG+8pXCRNsAEu5ozPh6k3yLai+9BKyICQTYHuUhzewVLGxjfQHZO0J7zZgeYDE3I2XllSGlkLVpRpM4Alo7Is5WB78cfmjy4oJuymVvUI5hAAvdMDTacJs0KSFqRTxVOFgLvoak3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p4ljIEVQ3cRxutkRG3gOfr27OPemRbjx0EAIlASsh7g=;
 b=kyzwDB1U3uTHrWuoD56mJ8ylJE/PGcu+8D6TCG2FjtYEAVlRk5RHpf/LnemBCFvbD/XfDOkmw4U3S0x5koxUsrGsLFN/VA24craPVODphRGvyW1BgAQULEm70uBox1QiW13D1voeaYRkQQxrHHLD1xz2ZaUd0SlXfstllkKJhAIr4Za61O/cgDuuAIspLQsv2NdQBb88RzBVnAgBDFeDlneCHo7+j5F5P2RC3ocAB0/oN7h5JcEUDmS0OC44RYP1oW7IzP4IgTkXuKJ4/JYuXcLGeW3VHBwtpCCHicPiu3orq2fS1gZe4yIly75qv31xjXIKEsob1b0mEYtu19N8iw==
Received: from PH7PR12MB7795.namprd12.prod.outlook.com (2603:10b6:510:278::21)
 by BL0PR12MB4851.namprd12.prod.outlook.com (2603:10b6:208:1c1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Wed, 11 Jan
 2023 20:08:32 +0000
Received: from PH7PR12MB7795.namprd12.prod.outlook.com
 ([fe80::436c:ae9f:c5a9:b22f]) by PH7PR12MB7795.namprd12.prod.outlook.com
 ([fe80::436c:ae9f:c5a9:b22f%9]) with mapi id 15.20.5986.018; Wed, 11 Jan 2023
 20:08:32 +0000
From:   fawaz ahmed0 <fawazahmed0@hotmail.com>
To:     Elijah Newren <newren@gmail.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Reducing Git Repository size - git-filter-repo doesn't help
Thread-Topic: Reducing Git Repository size - git-filter-repo doesn't help
Thread-Index: AQHZI8zQrYgXZgWbmUmkNkq+e9xLvK6W8qAAgABRgnuAAToeAIABKe92
Date:   Wed, 11 Jan 2023 20:08:32 +0000
Message-ID: <PH7PR12MB77959E90F52C59140ED662DBF1FC9@PH7PR12MB7795.namprd12.prod.outlook.com>
References: <PH7PR12MB779560B6C003FEE76E4F2471F1FE9@PH7PR12MB7795.namprd12.prod.outlook.com>
 <CABPp-BE_FLFL3-s3936zWWfaORBPim14A-oqVNo+8gx+CMduHA@mail.gmail.com>
 <PH7PR12MB7795ED45E989E2EDE2364049F1FF9@PH7PR12MB7795.namprd12.prod.outlook.com>
 <CABPp-BGh17pH1DUgPOoaDKBcKay3NAyi4js-HnEKAAyYUBSoYQ@mail.gmail.com>
In-Reply-To: <CABPp-BGh17pH1DUgPOoaDKBcKay3NAyi4js-HnEKAAyYUBSoYQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [4KNy/BmVXiiuEBR8ds+i63roRwGHRpt3J2X1s3tzMaYT1JP6wmJUzw==]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB7795:EE_|BL0PR12MB4851:EE_
x-ms-office365-filtering-correlation-id: b568ad78-96c2-461e-9452-08daf40f9cf4
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YZ1LKs/UvlosqOpu6OMdI29yTs2ofSA5oQZkquPLWHjf3cRqlz22bDmK2pRQkp5xfMdxtqoJoEDxCoMLlGenHEKViQLwArqJWMJSWgcxv3FUrp5KunOPHpF68hIqqulcmPNGtT6ZGdQtA+o2AcfrEaCZ52JHhExj22lSVuXfhzlNel/wHWFiqQLdI5eo5FxyeLsvyxVi8nW7GYRxihakopCg2HRAN7iG+WwXD27wWrcYBzzjuvNqVWVyvBjQkS/K8K/1wIEC0FJ3xth9aSpGBFSnTPWqgiJIOJA3+KIfXIAXThxABMnRb329HOJ3SrudSf2fuGjaPU7hdbKY6vOQqSzW5KTpd5gWzgQ3/uiz+zlP2KrylKCK8Q7QmlHBctG1NLl8orD0ZkCNoEhGwOHULYdagMeMYIVkRUCNsNgIYymsEmIlLRismJ/aFZRMHwttt+EzOpCuAI2oLyw3bS5PzEwinbuV3DLdSHYpCFtQafz60LY3tUrAQkT+DtIgW92YYPIbsbWZEMCi9W9o/XQaWXjfG9BhI1Md9vzbBuhNr20o6wQ4e9lN6RQ9d27dGj+g93w+EdmYwzHcxHG/V00yMQJyFUQZCqR5ewqsM/Ej7ZaMEeG1q4nz87kt2hXVW3TYc91Jp9yUY27OISd+PyVCRxGnXmCFhGzxhWM54Yss01c=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?gozZksoh0x4mEMWB+eWUB//yiBdpIFlEgFHZdvUtibT9TvzFnYbaWoAzyj?=
 =?iso-8859-1?Q?DbMcDXyx89XXmj7I+oWqNjliTN/EmSmO9n0P3G5NtXI8V60kpKbKh0ZRKM?=
 =?iso-8859-1?Q?Ti2MBaKdHq9zf+fRh6zn0Al7GZ8CPFQg5Zs0T/w/ut4jrRu/o30ecskanH?=
 =?iso-8859-1?Q?lms3vx6lBvkCOHlJXPxUGY3uQCznUHVYqkkHQF8J9J4MADBljUjg5q8/Wr?=
 =?iso-8859-1?Q?DGIqYhebay4k24m/MQ+W4EH/HW6xpUy7alv3Fag4N6dKJEYjdAfJPMMsy5?=
 =?iso-8859-1?Q?81pc2L2jq2nGs6wFultYZsmwtBXL/L5P3Nivq+NzkRYzDaPks7OdBjS9Cs?=
 =?iso-8859-1?Q?sYg3T+Ehi/hCkMDLQXbsECnReBtPTH+NCyC1Um4TfiTRGXdJ6eQHxpvNmX?=
 =?iso-8859-1?Q?HRDf8UlS4PpzyxIz8ELhlPjzxwc0txP+QI6g3wY3p1nzzpnU59MicPXqP0?=
 =?iso-8859-1?Q?uPf+l4Yr+4SAybmAAyk4ReA2uUPzSgZDycRTMU4UkfnKOUaZHtvVPmBO/P?=
 =?iso-8859-1?Q?///Ai4LVXrGwikcBNMlILpqcj/zoDH4D9zDKXDmg1JoPaxhFCYqCrckesO?=
 =?iso-8859-1?Q?SoOVgxxMmtYQX8ze6eBWU+80XtZVKDH+jLVJ6TeqyhnVtTHKHVB7z90VlR?=
 =?iso-8859-1?Q?cahcJJJqW2MHAtVEImy77e4AE5LojasQ8ronMWtN+UjHDc+g7uWt19Vr0Z?=
 =?iso-8859-1?Q?+91f+Yp+ujtca92NVWizCKRVnjjvRJd2D6GVgsBbZzeD3tJ3VXogM7kRys?=
 =?iso-8859-1?Q?L/1a5cMrGk8Ieb73M9LbVllA2UpUnPBMZI/WK6bYc0A7AHWBz1A1frEpJq?=
 =?iso-8859-1?Q?+G2QUA0+4nzZddQ7rkvF3aFPo6lYCNUXeSHeahD771FoQFTInWwUUQC5RE?=
 =?iso-8859-1?Q?TD1uccef7ItVSYQJdTPB3OlYPUoGuIL6MHMEMp6pnsVwyZk8Wss4FU20fN?=
 =?iso-8859-1?Q?V6BQFil6kOEefx1mST3KQeFbuo8QCi0x05vb5sOC1mOx4ejEuE8NuMxEdp?=
 =?iso-8859-1?Q?8CqZBOgX6QH9si9Qa23otD6hgO4+D6sNOAQ8lohU0UQrhEzahZM5V+g+dR?=
 =?iso-8859-1?Q?ZysR2IOnty61a3PDo44dQYDA8gq8K4/ARKW2KV8Uzaj6EsuhdY7nJRoIlS?=
 =?iso-8859-1?Q?tD4a818+q5oHaxG5mgxuOp0bxqc5djDwdS/SPPq9ZuDVlLz0HQt6XnBEzf?=
 =?iso-8859-1?Q?m48y6c5aDL+ar5FQlJ1cC5WvxjimCwRZ4D/3Gp57nnnPTDYmXBpHRNvLF7?=
 =?iso-8859-1?Q?ArJg/ZB7AArRGYUUzdmUVwPHqu76EJz29IItfNDIpe32Z9RCzmS4dDadaP?=
 =?iso-8859-1?Q?Mdm9QG+C6xM80CGC/XC9T2XnUXYmBQnCr26gGRonh31vbBs=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-71ea3.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7795.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: b568ad78-96c2-461e-9452-08daf40f9cf4
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2023 20:08:32.0995
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4851
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for looking into this. =0A=
=0A=
I have removed all the unnecessary refs on remote, and rerun the filter-rep=
o and force pushed the changes again.=0A=
To be be sure, I have also requested Github support to completely nuke the =
refs/pull and clear cache etc.=0A=
=0A=
Also would like to let you know that git-filter-repo --analyze (which was a=
lso suggested by EriK), causes OOM in my case (also tried running in github=
 actions with huge swap, but it exceeds 6 hours timeout limit).=0A=
=0A=
I have verified size reduction (after running filter-repo) using:=0A=
`git gc && git count-objects -vH`=0A=
=0A=
Thank you once again for the help=
