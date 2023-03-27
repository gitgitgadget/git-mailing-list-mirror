Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06FEBC77B61
	for <git@archiver.kernel.org>; Mon, 27 Mar 2023 12:17:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232708AbjC0MRT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Mar 2023 08:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232153AbjC0MQw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Mar 2023 08:16:52 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2137.outbound.protection.outlook.com [40.107.255.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70163527A
        for <git@vger.kernel.org>; Mon, 27 Mar 2023 05:16:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UTx3hv4IivXPes3wfrTTTj8NvXPWXHHeCn9c+gWdjdvUnRnWF+CP++Eq3DIciM7cYbphVlwbTii83vl5OtaT5CHDQRMTnjKXe5R7nfauqpDzEkL4sQjJjmeitcToE5/G+BUlXCGLA7xHmRMWp5z+3BtTLJ/IYibJWZr0vV5A4cGmrr49JAr4XbL2eoMnW91rBIGZm/OurfopJY1RnKXTPJc4XwGl4BGsw0RykZrDt5WGctkUVZbEYa6PvqTwxaaMBEKAVPymnGqb7ePvl3qyZcA73uJlwIz34cNDr1CdLrmVryuh/z5fo5dDPQ6CuT1A22eVk+YzEIP1/fUz6YqmJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SeM1NoG/amQ0QrkLhZUtbc/I5Ah+mGgXxQQWyJSOPpY=;
 b=I04HQ0H+KoiYKbhBtTRlPBWfUeU/pvyElH8bnxIqpnUXgw2lgKS19D36Tk98SQKkZccqoZvqO8Ds6VZIED9NEiFhhfK7HZjL7FKFZydppdd5WO2KXzl6kgkRdjOJGKCzBnU7vQOJqmrMDo4WrPITAXINKg1BQrRAp5C/rxo/0/Gty3slqigR5mZM29t0OcaY7EYDPPDUfR/ESVnHbv0pw84UrxerbEb0/OdI6ItxLCDZsH0TQBUaX0wRKJ4kzl/06fh1ZjIzrgq44fFHwExNJREjbovm/fbDCCaHwtmP4Al3KCQ2ScSGFXDk275tM2nQHYY/GA3pfnwYPu8nxHvpew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SeM1NoG/amQ0QrkLhZUtbc/I5Ah+mGgXxQQWyJSOPpY=;
 b=aRQ9s8X+HqLAjh53YocLttY+AA7GtqrAn1/l15cRIQLjvnrQ2VOI9QkhS0qwLnJCh7bbxeF0p1naNjtOvlpkCWRS2igM8+D0XtUfRIP/Ecuq/DxxzUXuzvF1SJsPR+xaKlJto2lXAFRIr8brjLXn0tFqsDlwWeq9GDkH4JKdH84=
Received: from PSAP153MB0391.APCP153.PROD.OUTLOOK.COM (2603:1096:301:2a::6) by
 KL1P15301MB0498.APCP153.PROD.OUTLOOK.COM (2603:1096:820:57::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6277.4; Mon, 27 Mar 2023 12:16:02 +0000
Received: from PSAP153MB0391.APCP153.PROD.OUTLOOK.COM
 ([fe80::87f6:70cc:9bbf:9c8a]) by PSAP153MB0391.APCP153.PROD.OUTLOOK.COM
 ([fe80::87f6:70cc:9bbf:9c8a%4]) with mapi id 15.20.6254.016; Mon, 27 Mar 2023
 12:16:02 +0000
From:   Drew Noakes <drnoakes@microsoft.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: --jobs=0 no longer does any work
Thread-Topic: --jobs=0 no longer does any work
Thread-Index: AQHZYKXlVX5goLSMxU2SqJgoYjqZPw==
Date:   Mon, 27 Mar 2023 12:16:01 +0000
Message-ID: <PSAP153MB0391861D0B15BBA22D7D6E2CCA8B9@PSAP153MB0391.APCP153.PROD.OUTLOOK.COM>
References: <PSAP153MB03910458707331B64FA7460DCAA19@PSAP153MB0391.APCP153.PROD.OUTLOOK.COM>
 <ed63b919-eb3a-1aae-0746-1ff582890a28@gmx.de>
In-Reply-To: <ed63b919-eb3a-1aae-0746-1ff582890a28@gmx.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=6a98ed2b-e5c2-4e0a-a7ed-065904fec745;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-03-27T12:13:30Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAP153MB0391:EE_|KL1P15301MB0498:EE_
x-ms-office365-filtering-correlation-id: 7904fa2e-9fe5-4c96-b597-08db2ebd07f4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /z4zxae9SZEGxI7tzbiRUbcg0SZPOnbmO+AiTFDkK8kl6mpWUj4+x+a2uO6+bdg3MM/L5sUGKRYsSMO0fLFtswlyBp3mmGP4dm5c1nD7SaEVvn9NGWdnDQaRR6KtySvvs4vu/WqogjfuVKm6uDOdZS6CGPbIQHOcPvBjkJboKdtg9qN2jlx+dXN7MwL8/Zsb3phRKbJPulCzYwW+doCAw1dqchS2ha4nrMqaIyLxDwOHW3k/sMHEjNzietUsrcTWGvHlaJZj5mDWK73V+Txmu3Hy1dw2PSVbn4gXYRco5rgS/Cz6Z+xqXxr4xrMJSX7eWwuEyWhLe7rvTGq6DwvAMtzNOSCM/LjuJrAnwpB9ldfkkc66CtMcy7KsZeyf9qv6rjOVPPIB7cpOVoOix5rEqmc6+Z/MItL/vJAtoAa+CRypb0GMSI3n2AmNBE7CrR7tBFKOU9mWw99/ZF7vi+I6vaNkO5pJD4yBocnLJMTgI0vU9/wtaMRrA9sSKgx+QQOtTqpiw2BXzlyU3oxv497J6llQeyxJukpURQJzpG9YkcyIb/NuYUp2k0+rGtPGL5zDG/HugP/5tYam5umhEbMQE+7Ps7zBsP781afvtZLloRdGe7vDHylJQE+69rytF66jKg7h+u/E7WHRtoFtrRvusw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:cs;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAP153MB0391.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(136003)(39860400002)(376002)(396003)(451199021)(6506007)(7696005)(71200400001)(478600001)(83380400001)(966005)(10290500003)(26005)(316002)(9686003)(186003)(53546011)(66946007)(66556008)(66476007)(76116006)(66446008)(64756008)(8676002)(6916009)(4326008)(8936002)(52536014)(82960400001)(2906002)(82950400001)(5660300002)(33656002)(122000001)(41300700001)(38100700002)(8990500004)(38070700005)(55016003)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Li5sm3+IG4tgxiTQ9BQc35FDzNHlRFuihPfd+eJYXBa4o2AQeO0CyrSlPnTA?=
 =?us-ascii?Q?LF/ZS0qfoPfimbZFLyYw9GLObAN5VcWCyUes0ZFv2KLpApyp4jxFtnYUmIod?=
 =?us-ascii?Q?VBjg9XCCovmDvWtnAZCTl23K19Ma4OjGfjPn8eJisYZ2qCPUs/W59yFTuqTL?=
 =?us-ascii?Q?jT8NSa5czgo8iAYb7gh2NmGTEBlJ34JNwTt+/rbcfj4CmkMOd3nprRFHGFt2?=
 =?us-ascii?Q?egM+sgyfrG4iwA5SrA5iRzVJyt0AIuiPxx3huroDWyiaW2ceM9eodFTOY9tL?=
 =?us-ascii?Q?bpKStIm4FERFOwmdeg88r5zcl7hOOtv8178ScSDh5vld6kK3d3Jy86byRWl2?=
 =?us-ascii?Q?4cmo65lI+IUCI5pbOkQPeSrZ9j2Mt/9X5hgzBr+w+ygmCZeB03nCs8IS39+J?=
 =?us-ascii?Q?PsK+8Jdvp+FN+HUGP6d0vOE1D5owZFkk7cOUsmLe5CUqk8YaVfqKcE+mP300?=
 =?us-ascii?Q?hm4rXuyxyPNnvwafX6DKzLLmFzilOaEce4k2G/FJ7vZ4AVbjMDeUelOZAViT?=
 =?us-ascii?Q?jjyzL3jjmRztN3xgpITB0FeruM4xnSjXafMz8B+daNFYsrrmO+my+O/P/A5n?=
 =?us-ascii?Q?U1JVDwlYxFb6P7czc9X8xOjFZNdEcRufn9yw3p+I1N/IYXR4TXx0ZIywLlsh?=
 =?us-ascii?Q?HurfqVVYxH6Z2efdSHsRiIurh9MtGqVtAuEo/xKZqLPklTCEQCkQGP6PNRXs?=
 =?us-ascii?Q?vtALUD0eEpbbJSa6BInZ3VR4K4ABYrW1KDv34Yllb4eOco2R2TEkv65uWggj?=
 =?us-ascii?Q?1Q1rSh0Y/byahNkQfU0E1kIqpVVZNVeJ9hm8bw7v31oRZtaQForbYCiGd2OR?=
 =?us-ascii?Q?Hcr+9zjlyQWzo4tID4BVyUnfCcr3g4ngF6ml9qkD740Vh6LwPWBeVGzzVM63?=
 =?us-ascii?Q?a3jGD/oB/qkeyNYjZANGQ6RWg6jm/y7qqwi/XkucCmPTio0oMEMlTAJ6CqA+?=
 =?us-ascii?Q?RCEKaHBFucd/4/WnO0JRhl77MGqW53zS4xULCz/pgTUVC7bpc2TIu54/Z0i0?=
 =?us-ascii?Q?3Uyey5ZH2P9K8t8WDwdTiTu17tdZ0em9XNJZzBjnwhQL5I6ov8G2KKtDak8o?=
 =?us-ascii?Q?Ohxh0kPJqeId6azLVYZEJGVNCp+69q/tMc5WDIe63pzWgEvnvFExvX/2T0d9?=
 =?us-ascii?Q?AZGTjSAJKMzxI7uJcGHf3ocIJJNxbqzZzBMtR/HMzBwa/x4e2uDK4lOBY08X?=
 =?us-ascii?Q?fDdTWpWpQrRm+ABh0VnuEi2ZaXZlFBN4TnKE3rVfTFSN9/PBnj4tG+lErlFd?=
 =?us-ascii?Q?6MiKiUfXhmiC1JjVbk3VFoOzVo+HLhBDexarPXWbUksuLquYHzSByThAJE8m?=
 =?us-ascii?Q?rnF6yGa8Sx+bqi3Q3PbzLEfDjs4WTpEu3hvSUEJWH1jFuFN3ADE2PhV4MASK?=
 =?us-ascii?Q?qBGwBZs6BtiXGyk1gFdnMcChPuuB4/+zWqJguUOx7GlCXPG3Wev0aFgC1+g7?=
 =?us-ascii?Q?bd8o2ySpVkoDu8n2c6FOJ7PyIwa9z1WW1DLFQiifJGjRC4jljKPcIDcin6Tr?=
 =?us-ascii?Q?gPZExn6Y3WDeYj5qiG/WFrB0FAA0U+b8CiPYNccKkNKezIBwl2kRwWX1ziMu?=
 =?us-ascii?Q?Kx7oRscp1BXhhnWFVpkSKYzLJDSg6pMR8+sEQikM?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAP153MB0391.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 7904fa2e-9fe5-4c96-b597-08db2ebd07f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2023 12:16:01.9865
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6RJm7RO7TngOm58/AWbKkfdeDyYhH8dKcIGHAqNXOtzbcRyaXt2smbQmvKaKfAvgpFjrbzTR8mgmphCwm8CJRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1P15301MB0498
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

Fix verified in 2.40.0. Thank you for restoring this behaviour.

Best,
Drew.

-----Original Message-----
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>=20
Sent: Monday, March 27, 2023 8:19 PM
To: Drew Noakes <drnoakes@microsoft.com>
Cc: git@vger.kernel.org
Subject: Re: --jobs=3D0 no longer does any work

Hi Drew,

On Fri, 17 Feb 2023, Drew Noakes wrote:

> What did you do before the bug happened? (Steps to reproduce your issue)
>
> - Enter a repo with multiple remotes
> - Run: git fetch --all --prune --jobs=3D0
>
> What did you expect to happen? (Expected behavior)
>
> - Multiple remotes to be fetched in parallel
>
> What happened instead? (Actual behavior)
>
> - Nothing fetched and command exits quickly with no output
>
> What's different between what you expected and what actually happened?
>
> - That command used to work correctly. It now does nothing.

This should be fixed via
https://github.com/git/git/commit/d180cc297922569e530da843bee4df3964167dea
which made it into v2.40.0, unless I am mistaken. Could you verify?

Ciao,
Johannes
