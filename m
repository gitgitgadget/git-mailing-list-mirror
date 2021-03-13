Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 937E6C433DB
	for <git@archiver.kernel.org>; Sat, 13 Mar 2021 10:05:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A04264F16
	for <git@archiver.kernel.org>; Sat, 13 Mar 2021 10:05:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230441AbhCMJ76 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 Mar 2021 04:59:58 -0500
Received: from smtppost.atos.net ([193.56.114.176]:9628 "EHLO
        smarthost3.atos.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229615AbhCMJ75 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Mar 2021 04:59:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=atos.net; i=@atos.net; q=dns/txt; s=mail;
  t=1615629597; x=1647165597;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wvdVeMQYzM6kTbwEZoKqCJo8K5WFtU8nvDksyA9xUUQ=;
  b=RtC90xIlOKS+grbhx5b4ZhyE8QHV/acGKMB7tj8E3FQ1hlogBRfgxW3V
   qXfEmoXPjuPhghHRyOFfjJp4skFyXtdFrg/0dyWFAH0Mzmr+eHvNvRHei
   ERjn3gAB7bFjS0pFj4MgYbroEiF7dfNJzCQ2h/qwVi9z5XYnNRE2m3dYS
   A=;
X-IronPort-AV: E=Sophos;i="5.81,245,1610406000"; 
   d="scan'208";a="172965480"
X-MGA-submission: =?us-ascii?q?MDED1nv06OHYB/A9XazAxw429ba22xeOHsZFJf?=
 =?us-ascii?q?Hbb5LhqRBHhORN7/8QIRS6i2/Wi6Cl0V8y1jNHKERyXPRxoILZ423Ekp?=
 =?us-ascii?q?bd/03GQgLWNCciPDXg8iF7jRehPfUv+BGjOFlEQP5N3SWusr8zN+TSRC?=
 =?us-ascii?q?m2?=
Received: from mail.sis.atos.net (HELO GITEXCPRDMB21.ww931.my-it-solutions.net) ([10.89.29.131])
  by smarthost3.atos.net with ESMTP/TLS/AES256-GCM-SHA384; 13 Mar 2021 10:59:55 +0100
Received: from GITEXCPRDMB23.ww931.my-it-solutions.net (10.89.29.133) by
 GITEXCPRDMB21.ww931.my-it-solutions.net (10.89.29.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 13 Mar 2021 10:59:55 +0100
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (172.16.214.169)
 by GITEXCPRDMB23.ww931.my-it-solutions.net (10.89.29.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2 via Frontend Transport; Sat, 13 Mar 2021 10:59:55 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gfFCM/68uXRwjM4/+AXEpc2iEN4GYneGLK8mDzh7ZlzYNS4bYqnDO88dPMoUU5gMLdjbNTGardrKX/Mam1i2x8pKDrGxv68jOFze3JdkFrLUIiUbrRMoo6N59NN0NZ1nDESLCTRBlTuVWY6E4xSwyYMHuMROKmBX1Rr2n5rs9qdIjgsDXJlqbjqLZyclZby5WbfUGNMVPrSqN14CxROJ5/broluKi8hYAlBhdTAYDIOUkVM3A1rfp7NlTTQDcyP6EYHplU1SXP3XykB04L8FRPnC3GXuSxyyvgxLInGG0JJ07ZWqLlMqlzLb9KKOvvqKq1AKQVBWTDXjY/tY3vtewQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wvdVeMQYzM6kTbwEZoKqCJo8K5WFtU8nvDksyA9xUUQ=;
 b=Fys9Lbb/1Ek245wu/AlQEcVZAht9mqqIIt6diG8KYIx8RshISLMtWNxY6aaaJL9QBGtKA6HWUSVCTTvFnvc0W8BUkMwM8vzWHlynsbuuKMmnPamkitRGJ2ctyfSBFoJ2ZPedG8N5zB5KEN2MxsSKkNkfqdHWaht4LelSuxnCIGzl56Al5pgBN12lyfXA1FVZ7zVFc+YkGvvqaAGea4lG4CTGI6OYZ7VlRM4PoNxNLBU02ZwDuGUeRbGkvwQWypc91gwhA057FNWCJxoQ5xJ65hVaQibLLMj8frOL/8lqB7rarNsoVH8tWdoQZyfHnE0YYfACLI5191qBhNylTgumbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atos.net; dmarc=pass action=none header.from=atos.net;
 dkim=pass header.d=atos.net; arc=none
Received: from AM0PR02MB4081.eurprd02.prod.outlook.com (2603:10a6:208:df::14)
 by AM0PR02MB4484.eurprd02.prod.outlook.com (2603:10a6:208:f1::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Sat, 13 Mar
 2021 09:59:47 +0000
Received: from AM0PR02MB4081.eurprd02.prod.outlook.com
 ([fe80::c90:7c15:8f0a:c9ec]) by AM0PR02MB4081.eurprd02.prod.outlook.com
 ([fe80::c90:7c15:8f0a:c9ec%7]) with mapi id 15.20.3912.031; Sat, 13 Mar 2021
 09:59:47 +0000
From:   "Kerry, Richard" <richard.kerry@atos.net>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: RE: Can I Insert some Ancient History into a repo?
Thread-Topic: Can I Insert some Ancient History into a repo?
Thread-Index: AdbImLDW4svDywGtR/ak5dzepEH+WAAKho6AE5z28mAAKfYKYA==
Date:   Sat, 13 Mar 2021 09:59:47 +0000
Message-ID: <AM0PR02MB4081668373AD4AD8C38AE6219C6E9@AM0PR02MB4081.eurprd02.prod.outlook.com>
References: <AM0PR02MB40811C5C2E8B13B63D06E4B49CF30@AM0PR02MB4081.eurprd02.prod.outlook.com>
 <87o8jcus0m.fsf@evledraar.gmail.com>
 <AM0PR02MB4081BAED92DBEC1F3E33B2059C6F9@AM0PR02MB4081.eurprd02.prod.outlook.com>
In-Reply-To: <AM0PR02MB4081BAED92DBEC1F3E33B2059C6F9@AM0PR02MB4081.eurprd02.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_Enabled=True;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_SiteId=33440fc6-b7c7-412c-bb73-0e70b0198d5a;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_SetDate=2021-03-12T15:37:58.935Z;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_Name=Atos For Internal Use -
 All Employees; MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_ContentBits=0;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_Method=Standard
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=atos.net;
x-originating-ip: [165.225.197.49]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d6193de7-68a9-4b52-beea-08d8e606bc5d
x-ms-traffictypediagnostic: AM0PR02MB4484:
x-microsoft-antispam-prvs: <AM0PR02MB4484A81252631B83300A961A9C6E9@AM0PR02MB4484.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aaa/Qj588wA6uXU8f8mQbACZrEO6Oj8Wg6hDzm3GcK4vqt1U+76DTAd0+vLN/5y0IP4zu1nKDE1whJfI8ojg63JTnSlMSdEQm4B++kndKtGTOra61Ue11jeP5k+zsHxUFb8Qvg1qpS74TSTheZ/P26JvyMMsNG7lhBfaPVTg6q2QdZYOeLaIxwLTnbAx2w5Y3bZBrWmarHpjHz+VoAnS785yCaGeQNfawFb6pbYctz7efe2F9gA3HcbxXnG+C6q+Z8iPsOU4U++0Dd1wxj4KMCxzTkyCVO5sQZwTW2w2pMFap2gu/F7dOqOdusf2hpgPArPdA+kae5Fh4yWrWXYVO7ot9WpvRDJPpf8pYDBSQtqlAH8Bcpmvs5LKDYGj/EZYaZumO6ziIAQEpQUSwtb8etgS+5NCJ3Z9sDGmrQgqiy4trMSSXC/Y1MVF44jcFF1nYYnf7qQpeyjkzftjn4ifktjqJNYXp9j4JWtRROj85YO+XzwYhtGdkVEHppbdPJPyqiy1w50UOHU5RefRded2wJgCrofnTUR9JCLq9Ue1iyiFp5plIuVrIg0CtkN0rEab
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR02MB4081.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(366004)(396003)(346002)(39860400002)(33656002)(55016002)(8936002)(86362001)(9686003)(8676002)(2906002)(26005)(186003)(83380400001)(76116006)(6916009)(71200400001)(4326008)(6506007)(55236004)(7696005)(52536014)(66476007)(66946007)(66446008)(64756008)(66556008)(54906003)(316002)(478600001)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?3ufsqEslDqjGEmGQvyX/QtlG1AdvZVsj6n3TiS/OGwrxa/G18r8Sr34xgt?=
 =?iso-8859-1?Q?n21GyAuCyMpgfs6F+HZLUw0/ZJ76WGq2uXHGJ1tfXMxGMuoFEcGG+9F0ef?=
 =?iso-8859-1?Q?EuW3TAWbEI/mMZFogTYvaTKo93qo9GqlFYU0EpbayatZhSyLYyF41y1jz8?=
 =?iso-8859-1?Q?gI8/1CRcKcz6gLggm3kHCQJbjwSopscaxavzl1xYqh3trMyhaNKJf3jqvA?=
 =?iso-8859-1?Q?DY5cZW3VTqtXME6+FGlHcmcXM9Rg3Vozv/s1JVfFiyxe4vOeprZVQTANlR?=
 =?iso-8859-1?Q?NYLwRUHFdwOvm49LIT4B3PllvZWlDOlmiZRr49FZpIALmu9vdJ+YfG5WZA?=
 =?iso-8859-1?Q?45v7th5tByv5B7RWUTnSuWqDng77oKXwNuB0ciEHVfQqfmHu1WTlNIh6cZ?=
 =?iso-8859-1?Q?zTxfrQs6KPcHiqeMGsBoG3Mm6h4fhGUNGLt2e6OI4F5PKuX2kmMgLH1f93?=
 =?iso-8859-1?Q?N9gBEcFD4XVSqc64C8yqpsKnDIocgNEhwJAaNAFRSgtRYfsZo27fOFpuf8?=
 =?iso-8859-1?Q?AGHqfPnrZ6XwMY7sNUPV3n8DvSpETNgjjBQjtFYWwqBzPlS6CUbxK6ue2a?=
 =?iso-8859-1?Q?8NCB6r/HgBZZ3a2PcqHMBa4AWZZ/S9a+drlEtV1jPlx9A+6uYscqla1vFp?=
 =?iso-8859-1?Q?ILxxqrN3263K64Otpxst3zu1ZiDacivEOQe2TMRqh4dgNv600ndy8wSwds?=
 =?iso-8859-1?Q?Us+qkcPpLDylRlMbA0rW2ccGEDY70q1Pt0JskM1SNrT8XVVTSeiXUZGVD2?=
 =?iso-8859-1?Q?coXgE6skE/G7R/HSf9koa11jmYQJclvFbePFtEGvgk4xSCK70MsqF/iLVH?=
 =?iso-8859-1?Q?iaWWbWC/nMViBsFb4i9AqbQ7wHJITVpbDRZV30qaRo6S2svgkxEFxYjsDA?=
 =?iso-8859-1?Q?rgURNXDISOPnRHk10MbtoZOd21arY6Lm4pkpH5r7pUz2v41W388KX/NXzV?=
 =?iso-8859-1?Q?/QuyY9VBKs7KfYulJe96qTeiHcI534uWe6XxAb+3GgCKgpw5d4LqmXske2?=
 =?iso-8859-1?Q?oKfX6wanQ/MP75uRc2hzTfMmriqPR4qFj6pmXPsUSLc20k1v5zsdlN6DPG?=
 =?iso-8859-1?Q?AEdM/qxGVSYqLY4MlvLuWdfPOPItbxG/ZpUw9u1a34IiAP0J3fXD+96qtD?=
 =?iso-8859-1?Q?B1wfL3xRE1edmf+FRraZ8D5O13b3C+f6bG0vUdNBz00I7eqtrIf1g3GX1+?=
 =?iso-8859-1?Q?KSAhhyGfU3ObWmwlHkp6mdOTEnmc3z5VFIne55AFh1zxF/R1/iV2QR5rW6?=
 =?iso-8859-1?Q?KsBUaHoO6y7DteHkL5PQzZwQdz/6bTfuEDCC26FiEVU5RzxgjKOneZBy2V?=
 =?iso-8859-1?Q?FUHzhYS3iT4O79ncZmLoTbnqBtIrSpUhXPmmyhKJejXoNUM=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR02MB4081.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6193de7-68a9-4b52-beea-08d8e606bc5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2021 09:59:47.6368
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 33440fc6-b7c7-412c-bb73-0e70b0198d5a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZLZGSb7ExE7k9jb9rottUJhDxmuqg9Wd4ZiQpjTnHsuAfPUhgUY59Cml35625ctUHmrvScz4VA626H16LMoveg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR02MB4484
X-OriginatorOrg: atos.net
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


And...
Just after I sent that email I thought "is that right?  I'd better check", =
and no it isn't right.
So to answer my own question.....

From: Kerry, Richard
Sent: 12 March 2021 15:37

>
>However, I'm now not able to write the results back to BitBucket.  I've us=
ed "remote add" to add the reference to the existing remote >repo where L2 =
came from.  But when I try "git push origin" it tells me :
>
>fatal: The current branch master has no upstream branch.
>To push the current branch and set the remote as upstream, use
>    git push --set-upstream origin master
>
>Why does it do that?
>If I'm setting up a more conventional local repo to push to a remote it is=
 usually sufficient to do "git remote add origin" and it'll then >push (ie =
one set-up using a simple fast-import from cvs2git, with the instance on th=
e remote server created there).
>Presumably my current position of generating the local repo from scratch f=
rom multiple imports means it's missing something vital.  >What might it be=
 missing?  Is it just that it is aware that it did not originate from a fet=
ch and the above set-upstream is the best way to >fix it?  But other repos =
that originate from CVS exports are happy with just "remote add".
>Does git know that the repo of the same name on the remote server is someh=
ow "different" from my hand-crafted repo?

I misremembered the details of adding a new item to BitBucket and in that c=
ase the required push command does include "-u", which is "--set-upstream".
So, sorry for the noise there.

So I've done that and now I'm getting, as possibly expected, a message from=
 BB about it containing work that I don't have locally.  I'll get back onto=
 that next week.  Again presumably a side-effect of building a repo from sc=
ratch that doesn't really share history with the remote one.

Regards,
Richard.

