Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D626EB64D9
	for <git@archiver.kernel.org>; Mon, 19 Jun 2023 23:02:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbjFSXB6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Jun 2023 19:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjFSXB5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jun 2023 19:01:57 -0400
Received: from DM6FTOPR00CU001.outbound.protection.outlook.com (mail-centralusazon11020024.outbound.protection.outlook.com [52.101.61.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A67D8F
        for <git@vger.kernel.org>; Mon, 19 Jun 2023 16:01:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NFRPTsmvvkk4cNwQKfJXLukcz/c5UyX+4h6ljsJRGZqrYciRxYuUdAB+JcAvUbT80BPQzvwEXLBu+/CoaKpK3kL9S86WZCe0JSSIXpj2Bhk8qUj6/rV2f4Qx+tDk49dnivpD+2W/pbwecw0h5TLVoJpmGX0Dm54GR5T+fOyRxjzvYfFVXqPvGHScxAKfU588/KrVxUiGwnayHCk582MxTqE5pQty0ZVr4jl2zij+Re1MtN3KIBtCLHoDgSLmxSCOSUcJvx0xRpWuM9kfaHu0zOwVlaEJDwr+8EmhpFksflKI9hY8SbZX9woq575QFTpCNKaHO0qICwnPfr6MWGZq3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r+ekFwHSOVVxfg+Tq49q2NIPxY/S8kJOmaEWa0hLs78=;
 b=ltnj7sGmeVm+EZATwQxj0L5JIbYhPpJ56s1K5/mWCw/EnPJjX4O9+pvZ1j6lVGR+Z0GFtHQnyTzaaM0/7AjAd84K8oFiFSST2go20Q09QPRbhJiPgEMkelXRQ28Lumx1YFQ6J/9/mdHSws/vhVLfck4RZ5kcaQWHHxYdjuXOuQ2syawCPP2Z3h21o+3+0E4eDOeBiVQIGVuH1NBYhWHDTJqCtItPsycZp36GakZDTzGEJPewKzrwgeixyI8kAw7QCpqNBB/jzgYztPXqO1tNsTmqDWDCvjNSPPnnCETkmRAhKC6tB5s423LXHTlyB+nbGzzOBLRwoctq6TTBNGVwDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r+ekFwHSOVVxfg+Tq49q2NIPxY/S8kJOmaEWa0hLs78=;
 b=i8IxPj2FWqcYLYAngNpa00zZFbs/m24O193oA2gNY7gw+xOgbDeBRYVKN1pT7D9n8xUEK1qX40eIeI9oNXWDaXtcpVdF8iqUBTIDoARu72m2sHHSNp1/o88u3vRtA+2aD9jdDZKiXU8wBXdyV+/qFGfVg34fMNFNzyiRBoTgTyY=
Received: from SA1PR21MB1335.namprd21.prod.outlook.com (2603:10b6:806:1f2::11)
 by CY5PR21MB3543.namprd21.prod.outlook.com (2603:10b6:930:c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.19; Mon, 19 Jun
 2023 23:01:52 +0000
Received: from SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::bb03:96fc:3397:6022]) by SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::bb03:96fc:3397:6022%4]) with mapi id 15.20.6544.002; Mon, 19 Jun 2023
 23:01:52 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Andreas Schwab <schwab@linux-m68k.org>
CC:     "'git@vger.kernel.org'" <git@vger.kernel.org>
Subject: RE: [BUG] git-web unable to show this commit properly?
Thread-Topic: [BUG] git-web unable to show this commit properly?
Thread-Index: Admi9V5lvlNTbB2MSBabvLMU8FVizwABCdOlAAH1jgA=
Date:   Mon, 19 Jun 2023 23:01:52 +0000
Message-ID: <SA1PR21MB1335AACDE23D101DDE3D5568BF5FA@SA1PR21MB1335.namprd21.prod.outlook.com>
References: <SA1PR21MB1335BD64334ABD240C23C43ABF5FA@SA1PR21MB1335.namprd21.prod.outlook.com>
 <87o7lb5cz1.fsf@igel.home>
In-Reply-To: <87o7lb5cz1.fsf@igel.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=58e5499e-76f2-4a58-a9b1-3f6be790128c;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-06-19T22:57:01Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1335:EE_|CY5PR21MB3543:EE_
x-ms-office365-filtering-correlation-id: f81c7e5c-fff2-4300-7561-08db71192b82
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zNiIso0ezn2xI5DS7qIe18VOHPaaMtSvmPhfNaEY7naEpD5BeRjFtZH84MTAZ/KaXwmIYs0+intEqFO0FY+HUzUluyhTooHGy55QPYNkdcHOV9jE4eGcdrlKLfA7lm326fCvqyyu/nzXrqDStXU9ZxbePPK9+Sh4/4rbWZS/bgWv0C7C4htU9/g2FYkCbM0xjYgr64G909shj83CBZ+CCf7kg+bcpH+GB9qkC4DcZGOYZLH4dsctwaSdzNeacK0wnU54U6hljrplNoSSK/NsU66lE6TyL21ZtvR9SXPTHtb3+xnAQ7AihlFe4LjZm9KepG97oX5VBA93H49uLmqPbSNh8TKykEl4dnRwKpNoopHuAkWFRT9A5uELjrSV61ljeFySmamSZmfDwHsAiucJ35pY3mpAb8Kt3QSOUJzbo79wUCEl+VQ88EuZS/k3c6L94CzWfZmK7xyPdnokpt5GEDuQIGC4Jluh1ZvNY942PK5H/mdOmiiWUtIstTYaTAt5Ri060OUEWBH8moce3qzLgFA77EilD30ubvs6MBm1i57DMKs+ft+vrEjvQCW5Bay4hQjxmoOqurCBONMMQfirxRApzn5Spn35UO5u3w3a5rUH12LLLsfgJEa+VjjKPmhFQaQnonJP7FNEQ2tnL+nW6IFMkAj62H/IWIW/vjCB65A=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1335.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(346002)(366004)(396003)(39860400002)(451199021)(186003)(478600001)(966005)(7696005)(71200400001)(9686003)(86362001)(53546011)(26005)(6506007)(10290500003)(316002)(38100700002)(82960400001)(82950400001)(66946007)(66556008)(66446008)(64756008)(76116006)(122000001)(66476007)(6916009)(4326008)(8676002)(8936002)(5660300002)(52536014)(4744005)(2906002)(41300700001)(8990500004)(55016003)(33656002)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7VlXQBT5xXt2A8GLRL+eY4U6f8gnUYlWGL/QJlC9JQrjiF+9yX0NwDjvl75m?=
 =?us-ascii?Q?LMbE3Wp7FLFjGbvRImY/p7igv1fbzKB7F6NEWZ6fEmNtu39GDl2cqGVGrR10?=
 =?us-ascii?Q?YFIXR6rVwoQPxiUdlJiqw5iGhgdIz4AMAine2XILtA6m2T9wHPq54V+IKSsL?=
 =?us-ascii?Q?joFYPDkid7cKZ20AZyR9MVMSwBH/ODqket6klOS6iAgW/hGoQULVAQM+B4fw?=
 =?us-ascii?Q?VAx5UTXJX8YTOUm088ySX47VFMQgfGnTi4g6Y0g+qpobY1PsUa6qcmgyHRNS?=
 =?us-ascii?Q?DkMJk6dmBc91UPl8A6TAHk1Yznq5JZzAvk8PRTEeJfCFSZjumdaCHQU+EOAV?=
 =?us-ascii?Q?IRCbjkO6J2cjg1Y1jSULnQosOXwA1NrFeM9qdZcQMp2/7Wb10DMeDt3v3MCt?=
 =?us-ascii?Q?4j8Tg1Rp44BPA+CCmU2kUgurUNjqTF/f3kv0TY+mf3VQ6Tn2XA0ju1vJW58L?=
 =?us-ascii?Q?CLaK9gEGGvjmGAacvdwcakMeyghxAgCWbfc2NVpqUiuPLThVccFLz2ezhkIY?=
 =?us-ascii?Q?sHsXrD12W72Ivotui0y8clq20HpRkBAS/1HrDMz4jcPPjhLZRqU4/JCIYeKP?=
 =?us-ascii?Q?MDRx6vhUH4Hi9SG4AZp9oOv05vNPiGS4mXZs+ypUGdLQqF5nKujopW28nUBq?=
 =?us-ascii?Q?AE/jK+gPC7yZGq+kyC2GE4MjVacZjJR5LAz4EF5D4ZuUo6VjWe/iGF+CyaTq?=
 =?us-ascii?Q?+hpo7TUr1lQgpMt54bJoUEyQeN7iR+5aDk6EPgXhC5fZkrAAxx7TUfxDPy1v?=
 =?us-ascii?Q?P2gSEtM1TM9uV6oVB4X426zUG8xY8Mq9zrDLDnPBb8P+HKb/8xMdSTIWO3L/?=
 =?us-ascii?Q?8yLNun5D6BhsJk23TrMRAwp/sBYnfk0BL/kEip39JNHGt6yZKOgVKe5REpGW?=
 =?us-ascii?Q?HTzwITUJXM9R5WEsElA/+5XQoMPE1hoa31P51rUpEg/3ibaRU0X8ic15CKqu?=
 =?us-ascii?Q?rmHp/p1q7MgUaAvMMeNm3XfBwgjfBGZPDBrdaEFXvq98umSHby9cB65NVZuY?=
 =?us-ascii?Q?jGDcsAiFCQVxmMhGggDEtEWuUNrz42Cs9Di/JIJW6yEcfdDxF4+TopuXFrZv?=
 =?us-ascii?Q?GLE2Q8j7BwwBfsAC7lmHB3WVt9bM8S+qZJiLK4xC5D5N7/i2ata2pt81/du7?=
 =?us-ascii?Q?lMZT+fJ4xuz7GbnqBc9WoT17D1I5LC8zkyI+lFpE3PDdSZNjRZwHCyaZp7JS?=
 =?us-ascii?Q?LVb2azuiOgvmfs7erajPfPkrOx09bTGSv7C1A2JWh8FjQO+QkcRhu2Mmym8W?=
 =?us-ascii?Q?oaXgIeyVwtk1mH5BsnlGv+eM5Twbmjhgxsa/s6I/Pyqe2JWsBw2NKQV3uti5?=
 =?us-ascii?Q?PRrcuCLHLlsMC1JNaBrh/qxt8o+im3bwd0me5tmM918L08syWVXxAphFUbfc?=
 =?us-ascii?Q?kUGNj5az2ZefuZIE0Wbj6+9u90qfwPw6NQ8o53ktCINIy8qeqvrQIO2lsBQ6?=
 =?us-ascii?Q?Q0H9rM25qVReIsgGkZe9av080EOm86yEWfBz39Vc4B0CE2i45xAKSBOAn//A?=
 =?us-ascii?Q?B5agPPAzfswduIiMjDTqyryo4xig4Wl/mPVxEOL5GSEZGFkTMpC/J/fpzVEo?=
 =?us-ascii?Q?3UzerQauZvPKiM3yIWHZIKDx+iib+FdVgXgMIo4w?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1335.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f81c7e5c-fff2-4300-7561-08db71192b82
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2023 23:01:52.0864
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OhnwKHXsXqHbUZuzqV667Wrtt7pDa+5LLcpBpJtHygO+wOqo9G84Sh8hFtsr8Hz39anayyOmRo7HYygK1K6/2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR21MB3543
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> From: Andreas Schwab <schwab@linux-m68k.org>
> Sent: Monday, June 19, 2023 3:01 PM
> To: Dexuan Cui <decui@microsoft.com>
> Cc: 'git@vger.kernel.org' <git@vger.kernel.org>
> Subject: Re: [BUG] git-web unable to show this commit properly?
>=20
> [You don't often get email from schwab@linux-m68k.org. Learn why this is
> important at https://aka.ms/LearnAboutSenderIdentification ]
>=20
> On Jun 19 2023, Dexuan Cui wrote:
>  ...
> That URL corresponds to this command:
>=20
> git show 122333d6bd229af279cdb35d1b874b71b3b9ccfb -- arch/x86/coco

Oh, silly me! :-) I was checking the git-log for the folder from the web in=
terface
and forgot I was checking that folder only.

Thanks for pointing this out!
