Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42A8EC433F5
	for <git@archiver.kernel.org>; Fri,  4 Feb 2022 12:27:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358789AbiBDM1x (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Feb 2022 07:27:53 -0500
Received: from mail-mw2nam10on2057.outbound.protection.outlook.com ([40.107.94.57]:29760
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230494AbiBDM1w (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Feb 2022 07:27:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P+OJQOb4MSgRPlhJDr6nBaW019rFJKIWAwmPrRcmDBPko39sr0bWzP6RcP7ttrJjVhlzrHRRtgtj6q0NQfTvmzunXcD1myccK9KJo08CNNkw8q6ohkD2IwTy6/x+ycyM2gaEYGPCiHHwMHrGbRDVI/heuC0OmmGk33tBghR7V3pFeX0u/Y5AjHaXBaXqNYCSPBeMveBO170Hza+DMUCwDTGSgTqKpD4MeSgDbk72HDTNz7VjuMx2byoDt6Nah8cbyUWlLIaGaiGHZASyraPWhOr7Whq9ncTI7HJHmB0CMm5puYpwcsO1QZz9FsemuQ16LfTTfaxaIaWwy4atghVHSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=klWy5ynP8C1HJIQOvTBAKz89wf+gCcTuv69YzjkIi7U=;
 b=d6n89wc5IW9JKd7G+1xnChnCdNCBAYm0QOalE9sNEQwkxEWUho8yyyQ2/6NZPItt5HgU+dlXIiNaBirmpNVsMt8e3I9ofhlajOGCiNf5o4Xk/t0EUSZNeEYovpriqR7devJGyR4GBCYIpyXAN4es8Wc8sUInkkdDAvfBs8XlBWgwK/0vmFqK79pKa+2WIOpdEEYsa5WudFBMOefhhZEyMst++jBbHzpz2I+zWYIKUEpBnGH9k0Ytjis+YvW8pMGbi38XStKNgx8DOtYB/mePY3kNr4iLjS5ruZYif8Q8ZKwUP5J9SpkkiXgE7y5wW86/MIywn99PPhrFjGoad7MxyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=klWy5ynP8C1HJIQOvTBAKz89wf+gCcTuv69YzjkIi7U=;
 b=iBAHZgEenuC3cSWTJanmpqh9vIPoZ7Sk+OT1CsLvehK1/RqyOtdhREAkOwU+kxHiBexJ8ZskBxbM3CzWlpAgjhM3ely0bhivuPR8WTylq5KNcZTKN5OZGYGh18p2MRHHxRvOAbLsFNYMwzqM7+wdkvuf8A4XXbLhGACjseAErx28bAzi3CRHzn8sxbx2a1psuQ5KzwgyEfHdytK+yQVJK4FMB+0fiP6TUQ283upCWD/QZh9zvmq5ZwfitXYnetu20gnVN+tTiZfu3AcgGw+mOo0bWFGvf56stGrc+rpkJ/DY5So9X82K4WNK6jgxrUXbJ8qJSXm6/En6XuN/6iZFgQ==
Received: from BL0PR12MB4849.namprd12.prod.outlook.com (2603:10b6:208:1c2::17)
 by CY4PR12MB1349.namprd12.prod.outlook.com (2603:10b6:903:40::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.20; Fri, 4 Feb
 2022 12:27:51 +0000
Received: from BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::dca7:5323:3:cc10]) by BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::dca7:5323:3:cc10%2]) with mapi id 15.20.4951.017; Fri, 4 Feb 2022
 12:27:50 +0000
From:   Joel Holdsworth <jholdsworth@nvidia.com>
To:     Junio C Hamano <gitster@pobox.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Luke Diamand <luke@diamand.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com>,
        Dorgon Chang <dorgonman@hotmail.com>,
        Joachim Kuebart <joachim.kuebart@gmail.com>,
        Daniel Levin <dendy.ua@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Ben Keene <seraphire@gmail.com>,
        Andrew Oakley <andrew@adoakley.name>
Subject: RE: [PATCH v3 00/21] git-p4: Various code tidy-ups
Thread-Topic: [PATCH v3 00/21] git-p4: Various code tidy-ups
Thread-Index: AQHYCvMfiIWdPzVYr0K1RMgJMRPAl6xmbsy/gBwAJqCAAAXL2YAA9+Iw
Date:   Fri, 4 Feb 2022 12:27:50 +0000
Message-ID: <BL0PR12MB4849C71DFC2628C00EF79196C8299@BL0PR12MB4849.namprd12.prod.outlook.com>
References: <20220116160550.514637-1-jholdsworth@nvidia.com>
        <xmqqr197xi0b.fsf@gitster.g>
        <BL0PR12MB4849847CD8385F0FABD9AE95C8289@BL0PR12MB4849.namprd12.prod.outlook.com>
 <xmqq8rurskmw.fsf@gitster.g>
In-Reply-To: <xmqq8rurskmw.fsf@gitster.g>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: af71ed13-67c4-4c18-c1d2-08d9e7d9c299
x-ms-traffictypediagnostic: CY4PR12MB1349:EE_
x-microsoft-antispam-prvs: <CY4PR12MB1349C752E6FCE04BBB42977CC8299@CY4PR12MB1349.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AdpxqZhvOY6w8vE7WSjKt0brsajknsoBe8zHOZe0m9Q3XI9/yGw7uZ0TzWfYfVsKlxi3rq9y7IkrRUppLLq8MbaeC1Syrp67swelErbjxencDg7oO32NyGn0DtyjcipnRd0FVm1mqEPBfbxBXO32n4/Yhm6e5XS8mUHFrLD/TkqR6CW81OB9s+2a+vaqiFzCYClNIpw4I3iVwWzbg1OKlSauSEjjOEUk+xVz6W5SvyUdti5ZU5upL9k4CFVrpMsMD/acawBcc1/rWcC/q3njQxj+8Jhdp1fDOJ9oAdc9ouiiCd5pKlS3b1K5SjU0uONlJIBIXEnSVmwrXtRJlyQddz1kks00wO+8YFXQUiFrtC8TQvshnwGay7BwiyT3sL9oapdj/TO9coB19y1KAXy9uhtTkcqs9Nx8yI7JORltc9bWr7t0PVGJvpaQZeWAFfTl2uKyyqmbv4dMVpJPk0MJaCY2Wjy5nt+KMwsH1sDqYQTuag2jdZpu8vwgOF0MhI05zEz8hkvy13jt/K9bBJISTsOG+scJJq5uC5s0YZkRVdYNyS4bbtk3s+TDgZo1n4ivGdnh0etGtWuOZNphCB/BmtPmZx2jC0DJEfLaoPhaAbMMqGhKxSVfhe576R0ne6CM13KgepM7Mh3mtMTmPtJKS/NlLcWarngH4GmWrPPg3EwqzRAliyr44lDm3jY2z/zG2OhQoAHTB1NRdKEdLOtgkA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(33656002)(508600001)(54906003)(55016003)(71200400001)(186003)(26005)(6506007)(7696005)(9686003)(55236004)(52536014)(7416002)(2906002)(5660300002)(316002)(6916009)(38070700005)(64756008)(66446008)(66476007)(66556008)(76116006)(66946007)(86362001)(4326008)(8676002)(8936002)(38100700002)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JBqjD1GwwknXmswV+xbKFKRrO6QcRnPKO93vIetlA2jNU7zcooy8vtXfAyl9?=
 =?us-ascii?Q?u9TrLHrud1XJXqw15ixFI1PNSaa6BbTujzd3gN5zYQfWGVEXCXACbZbnUuFO?=
 =?us-ascii?Q?2saCu+YrCn67GyMCVMGTAXouRj84r5wJhm7sXRL4GElDpflk7pCAKqEQDoEo?=
 =?us-ascii?Q?yYGfaBbF9sOg9Zqg9RTsC8oy6pmAq8cf4fxY1pZ99A05SyTgFGylSMlrt7/7?=
 =?us-ascii?Q?RFO2E8DGUleVKQg5sVfFTVV9Ng+uWYWddv40d8m/YfoP11yW6NOeT9quZbhw?=
 =?us-ascii?Q?4QcoZ49VKibdu1sCH7fM9JuMh5fSKGVbma7NS5zDhxOWy5MavleL4I57dJ0a?=
 =?us-ascii?Q?dM42cFy+xyzC0RMULdpswylPbM+4AiNbhsbCgzav/z6QYpzeUdDXxus8TcXQ?=
 =?us-ascii?Q?F/HUHcrlTxEu9U6MCJmGmR5GecsbyeW4azPKcNKnvzCwT4uZD9lpwc4Nh90w?=
 =?us-ascii?Q?PkwXYx0mUawVvRL5Rjjtta6qTSyzqxmnAZK4xokkEUzkCeA0UubltR2eW+if?=
 =?us-ascii?Q?0WD50mbovvYi/igNttkx8hlbRm2LPJxA8FqaThKSGqTB+eAeHiqDLqEwyi9s?=
 =?us-ascii?Q?uP6qlT6WrxAkrGGbXRN5Bv2hy65RPKI1eezuxXj6dGH4wH4EjzHCYT9EexD1?=
 =?us-ascii?Q?ET+QyNNDmGvuaPNZhNihZk4+0MjBe/WWfBXGExRw1tSsJO66EGuWe5wuvwsp?=
 =?us-ascii?Q?uVMCAo1vecV4tO8Bx8RpgRrvbzwpBLsqZ4zUKbW5FZOg1IxyyyyVM/v7I/tp?=
 =?us-ascii?Q?Fbs+YJITH49ra3qE0FLskZo5QZki2oOCgVL/aED+OV84EJLrZdnH89Pxbwq7?=
 =?us-ascii?Q?LZ2b2vBl3CHn11SQCVkPcmf/REP/8mbJ0igKjQbqPClmci+ii+nPBPd8o+sq?=
 =?us-ascii?Q?euCLZUJcfhrl/8XkrjpJZqflavLzxPhkWyAurUIw2lJZGssgXoXiPiLUjvhG?=
 =?us-ascii?Q?8DkUkTS++EH41Okp5jLGh8jCQsSlIksJyFFLwS3QHA694w6G8TmxNv4Pt9ID?=
 =?us-ascii?Q?iA6Xtp9PQjVp224cS9Mz5ku30HRMadeUM1r7eRAXgk93QL7h+43TxQjHfB7n?=
 =?us-ascii?Q?NpT2m7XCXBG0M45uSIvWJM16VN1GOAbb300Uao/lb1vqGKtLB4iZcqyn2Xdz?=
 =?us-ascii?Q?C7YNvwXvfIsh3NDmSNWJ/yG7X0pSkQUr1QYV2z3tXsR1Fpp/klCxdzNhitFM?=
 =?us-ascii?Q?eRTGuFhmrJefGfFwty2Te1t7STmuORet2LL3/CWsMtUvxrF57PlmAh9oOQ7z?=
 =?us-ascii?Q?PAiFbIrKjXX2URUjPaubuhBcCA1ql6ify4wgoef/u/zaiX03Twag59G6m7du?=
 =?us-ascii?Q?rnLNAUe/Rj4aq7MzOqjl/Co2dLle2/i18EUrEOBACRCCA2Nn2+v41vcLdOcy?=
 =?us-ascii?Q?fXFzNQmc5stxL2Zj5NM79DMlaZUSdxNXoiYyM2/+NeoX959lxI3GZldz5BSt?=
 =?us-ascii?Q?lKtDHS9rIiPGMu0XnoEapINMKPx+7g15AfdGTb+2Mjp4U9j2tTSBNmUVAiME?=
 =?us-ascii?Q?jj0ERJN41UBN51mAD+MS5zwdTluD4VLv8xqqkNLbPw1dCG/1NXGP77CSL3BT?=
 =?us-ascii?Q?ZF2Vl23lNuodFxej/t2M3HbGjo2JbBKFSRcVWaLQox07YpQlKTtg9BQ2TFdz?=
 =?us-ascii?Q?/1HjOxb8WHFJmePBYd8MRIM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af71ed13-67c4-4c18-c1d2-08d9e7d9c299
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2022 12:27:50.7318
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hJvmnnC86EhLHtkNsgy0hSulPsm4qsAOVkOZlbrumMEkiY1VANlC4dNOqZ4Tno+Cs6NL1DBiCz7a6JHOGvM1LA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1349
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,
=20
> Perhaps looking for "Note from the maintainer" in the list archive would =
find
> more info, hopefully?

Thanks for the info. I'll check it out.

> > The SubmittingPatches guide talks about branching off master, and
> merging the prerequisite topic branches. For this patch-set I will need:
> >
> >   * jh/p4-spawning-external-commands-cleanup
> >   * jh/p4-fix-use-of-process-error-exception
> >   * ab/config-based-hooks-2
>=20
> Correct.  FWIW, I was updating the "What's cooking" report and am plannin=
g
> to propose merging the first two to 'master' either today or tomorrow as =
part
> of the first batch, and the last one in the next batch after a few days.

Good stuff. It sounds like the easiest thing is for me to resubmit some tim=
e next week as and when the patch-sets hit master.

> You'd use "git format-patch [...] $BASE" where $BASE is the commit you'll
> locally create by merging these prerequisite topics to 'master'.

Makes sense. And I suppose the cover letter would have to list out the depe=
ndencies? - because otherwise you won't see any merge commits in the emails=
.

Joel
