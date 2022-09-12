Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7B9AC6FA83
	for <git@archiver.kernel.org>; Mon, 12 Sep 2022 19:40:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbiILTkM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Sep 2022 15:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiILTkK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Sep 2022 15:40:10 -0400
Received: from us-smtp-delivery-120.mimecast.com (us-smtp-delivery-120.mimecast.com [170.10.129.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DC83459AF
        for <git@vger.kernel.org>; Mon, 12 Sep 2022 12:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mathworks.com;
        s=mimecast20180117; t=1663011607;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6p41rpZ5P9wv+42wbXFcY8+B1dmsqAY5BA+krEKidjY=;
        b=hocX+TFIvFCa6WQjvn7Mrk188rTH3whJ/VTGDcLAhqWkquUYX2t4fKXwNsbfgvpo6oOnEb
        tAKaVptrW+Biya1+pgMn3kbbJQHsAIoN/VbsoNhZOvJvSLzR8Ddl1UqsprdCGUhZGRhXFo
        k6O1qEfQCCKQzg5n0CtAXkoxfg0dD18=
Received: from na01-obe.outbound.protection.outlook.com
 (mail-eastusazlp17011013.outbound.protection.outlook.com [40.93.11.13]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-461-fwH1ozhUM-Wez84UgXcBdg-1; Mon, 12 Sep 2022 15:40:06 -0400
X-MC-Unique: fwH1ozhUM-Wez84UgXcBdg-1
Received: from BL0PR05MB5571.namprd05.prod.outlook.com (2603:10b6:208:2f::17)
 by DM6PR05MB5625.namprd05.prod.outlook.com (2603:10b6:5:5d::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.7; Mon, 12 Sep
 2022 19:39:59 +0000
Received: from BL0PR05MB5571.namprd05.prod.outlook.com
 ([fe80::86c9:5cc7:6693:d9f7]) by BL0PR05MB5571.namprd05.prod.outlook.com
 ([fe80::86c9:5cc7:6693:d9f7%6]) with mapi id 15.20.5632.011; Mon, 12 Sep 2022
 19:39:59 +0000
From:   Eric DeCosta <edecosta@mathworks.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Eric DeCosta via GitGitGadget <gitgitgadget@gmail.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?iso-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: RE: [PATCH v5 0/4] fsmonitor: option to allow fsmonitor to run
 against network-mounted repos
Thread-Topic: [PATCH v5 0/4] fsmonitor: option to allow fsmonitor to run
 against network-mounted repos
Thread-Index: AQHYxVABuJRuWLHEVEGz/Q5e4Ag7LK3b7aXQgABGBY2AAABMcA==
Date:   Mon, 12 Sep 2022 19:39:59 +0000
Message-ID: <BL0PR05MB5571582512C460D95E1F1839D9449@BL0PR05MB5571.namprd05.prod.outlook.com>
References: <pull.1326.v4.git.1661962145.gitgitgadget@gmail.com>
        <pull.1326.v5.git.1662840031.gitgitgadget@gmail.com>
        <xmqqedwghauv.fsf@gitster.g> <xmqqr10gcrjp.fsf@gitster.g>
In-Reply-To: <xmqqr10gcrjp.fsf@gitster.g>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR05MB5571:EE_|DM6PR05MB5625:EE_
x-ms-office365-filtering-correlation-id: 5d2e99f4-eb4a-477d-b000-08da94f69416
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: BRyxyv0k1fznm/JRCtDnsGbQj3lmq/ALioW4f/Z2c/zZS+4UN0xbcqHjVKfxYsilV2Di/HKqOjJrx8FQ74BQX8MWxt6zmYyvQ74262RglDBJaJydXoJrYtDVi8u54btvmA9uN1jGPCkQYXICWN+lyzX+CITU8S6vgQjpMuxItp7PXO6O0/C1+ZUIcyWU01w0dPM6sUjUVoCyPcx3ysgNrp0nfl3b0sHbrQxmSNHUC+Hjzd5AehRagjYiV7+Ex8n9dgUXRiHkhOjLU6r/vWlhijoKCAlMbhGlXTYkJ96BqyV2su6PwdI3D4YpxCHUwlz9UaW5aSXolrAzc7W/4yorRudgk4zfJ+qV5xZvzS7KSZkEDx1lrDTsnZynroARQfB7Kk2nsDy5JL2UtbkPgNAy2EJ8mRxFL+oB/3tnZMWrwgzfkK+uB8u6LHC3tGPuKRdvz512EdU82INHWY75JusLzwqgJM+jPtPcnfyyYsU3afrf6Js7HXdIUmLdUR6uYlXSGBStZuZXhZnMbyrdYMYcjhLO8izWP08iWYJXi/6u8FwZzaBwXSMIPrIxHxkVHCNPU5Z6e+UKj6HC8/2a+qBq5PO7pTLVeqwugVDn8HXOCJCfDDqiMT49ETZcgJUQ/dhtek7k4pNKek/BbMnc1O63CteOc3BdyLV8Lp4RaY9n4iUfzgrFJphavm/vrK+Indc2B20t7o3jSF4+M0sJDmtyhGcTIkgd0F96IXTmyi0Ic/YgJM3eEqrSbODnR+QjkWGEG8fQa0OOJwPH9HaxdOu+Qw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR05MB5571.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(39860400002)(136003)(366004)(376002)(451199015)(7696005)(9686003)(53546011)(26005)(83380400001)(76116006)(54906003)(38100700002)(66446008)(66476007)(64756008)(66556008)(110136005)(316002)(478600001)(86362001)(41300700001)(66574015)(122000001)(71200400001)(2906002)(55016003)(33656002)(52536014)(6506007)(66946007)(38070700005)(8676002)(186003)(8936002)(4326008)(5660300002);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?U9HO7rEQnmn16aFg7L1RB6ogFxV7iFj96nufPBSwgi6wDVv5qVAFYYNSq4?=
 =?iso-8859-1?Q?BEKvtzqlkoG17Zh4v5pbTgqZSPgv1jcpiR2TuBWLxN6IYqCkPjD8NGP8Qy?=
 =?iso-8859-1?Q?hTtl7fT5pU1QPb780jkeuLbyWYmn8ayWFVOl9jW6JezCxROhvU6rjR16cM?=
 =?iso-8859-1?Q?FXOUCVWwGU37pg//dvZnb5/u8LomKA4I1Pd9OEzMmtlyqW0kOQr1IL6vjs?=
 =?iso-8859-1?Q?HBtSbgEuohHh+P2kWco9G0pA0fWoFGWdjHi8ICg2e+WIaAE0j+k5JQJIaJ?=
 =?iso-8859-1?Q?u2MKTmUUIgg+Y4F0A/BJK7jgsXmxaeSmTBXBkswzi8DqOmxPykbeAXnuk7?=
 =?iso-8859-1?Q?nngfJiGCVMvSQF514+d/G5fuR/DSbJLV9d8Iunwl9w8mELTAYrt9v8u+gl?=
 =?iso-8859-1?Q?9mf2IiPHAqo/gNqMlZ9etLZG7W3EL0OH9ReD5xgKfzF4K+G3g1RbN/yjOt?=
 =?iso-8859-1?Q?xg1J5tHUttI8lHO9KqXr9E6VX4KqefcpAgb/nNwAiJyDY8pLyzHjBiLlN5?=
 =?iso-8859-1?Q?gRNCRa/8Etpml+/2JLJtZihQTxU8OWf/8wy/HxRoe19kLZE8+x/dFjXo36?=
 =?iso-8859-1?Q?S1Gs7SwlhOCpVJ10CEpxWzzMdCxnGahnXaCSfrP/3R88zNcWEIzyitpPSY?=
 =?iso-8859-1?Q?VI75Vh7vSbFzO88jsBKAphSyXrc5RzJK+5WhL++iBVj43Wx11Q5h7ztLju?=
 =?iso-8859-1?Q?u83HPcrRI6sG+h9IX9UxkzVgABsUH59moiP6hMGcHStZiLUpnLaWRTiq/1?=
 =?iso-8859-1?Q?6QWxQdwzIy3+i65rzalol+lcyQEp2aG76ywpAJq69KIz9n13pMVjhvkd1K?=
 =?iso-8859-1?Q?GLp+maBjufMVdjJkAwbibxW+x2XGIxN+PTjTP6bOQJywCCr4zvWALBAdlE?=
 =?iso-8859-1?Q?1eodh2Z3Yzzyc/1XvOPVdW1G104y6Nh90+ZNHalMw7Pl3bSDsrlXE4mmHl?=
 =?iso-8859-1?Q?rSEZ0zkJBszngTaQnoiGKrGF6bwrNA8eXmE+OCRhDurN0s+KvLa9nyQQOj?=
 =?iso-8859-1?Q?keR4nUPU+hdoL6NTvFEFLXgmzjNvh4aAamaAXGzkmmsoD4rdrx/KOt5R4U?=
 =?iso-8859-1?Q?Dk2GpzEFYyuJ6lyTejqsBogLxJIjg4bGnqocaRVAQIietr0qxatKgwOey7?=
 =?iso-8859-1?Q?kGGo7lbd+RwzC8NnddIjSl+SiEp20O1jljNUy4TUDIEwmgneyvJSoXJFEV?=
 =?iso-8859-1?Q?LHD0Q0VCOjwrcqf+QQ4oBpRcl/auvpBsve6iW+oqC9lvx1FRsDwMxbjHp/?=
 =?iso-8859-1?Q?gHY90pgn1HazLywH9fSLK683qoqBZReo6HakK0lPmRzgOYzgMy+aLJMyXU?=
 =?iso-8859-1?Q?5+GATGO8MpNrAbt5W+NBY63h7iN2cRRpaY26hWug1udQL1pSqpQpCrm3GD?=
 =?iso-8859-1?Q?IK/YA1ZpfdE2BmmbaWN6cWYnEQ31ElzRQSnu/2j5mub//rjsFsMIZnvcg6?=
 =?iso-8859-1?Q?lxXJ4uoaPm+R0eyzQakMoxaEsO4pMJg2vpgJ5I42IY7N2NuP630z3vXhQW?=
 =?iso-8859-1?Q?ZN/mpQPeLJ3ENRcGWyFLODdCByW9ZBNS8d2MTNgu3vbScaEH3MZ+0Zks25?=
 =?iso-8859-1?Q?WWB7iEqPsYKuy/tKOkDGYR2mVbs/Mq7tLgikjmmR+GjeTUDflQOHGNp+ck?=
 =?iso-8859-1?Q?7JaPz+6Itp5/UQdjfHIkR2HzQL5uTQ1si0?=
MIME-Version: 1.0
X-OriginatorOrg: mathworks.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR05MB5625
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: mathworks.com
Content-Language: en-US
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



> -----Original Message-----
> From: Junio C Hamano <jch2355@gmail.com> On Behalf Of Junio C Hamano
> Sent: Monday, September 12, 2022 3:38 PM
> To: Eric DeCosta via GitGitGadget <gitgitgadget@gmail.com>
> Cc: git@vger.kernel.org; Jeff Hostetler <git@jeffhostetler.com>; Eric Sun=
shine
> <sunshine@sunshineco.com>; Torsten B=F6gershausen <tboegi@web.de>;
> =C6var Arnfj=F6r=F0 Bjarmason <avarab@gmail.com>; Ramsay Jones
> <ramsay@ramsayjones.plus.com>; Johannes Schindelin
> <Johannes.Schindelin@gmx.de>; Eric DeCosta <edecosta@mathworks.com>
> Subject: Re: [PATCH v5 0/4] fsmonitor: option to allow fsmonitor to run
> against network-mounted repos
>=20
> Junio C Hamano <gitster@pobox.com> writes:
>=20
> >> Eric DeCosta (4):
> >>   fsmonitor: refactor filesystem checks to common interface
> >>   fsmonitor: relocate socket file if .git directory is remote
> >>   fsmonitor: avoid socket location check if using hook
> >>   fsmonitor: deal with synthetic firmlinks on macOS
> >
> > It looks like this one is organized quite differently from the last
> > iteration <pull.1326.v4.git.1661962145.gitgitgadget@gmail.com>
>=20
> Given that we are very close to -rc period, I am very tempted to say that=
 this
> follow-up effort can and should be separated out of the previous "windows
> only" one, and we should merge the single patch that has been in 'next' t=
o
> 'master' without waiting for this "macOS, too" topic.  What do people thi=
nk?
>=20
> Thanks.

I'm totally fine with that, turned out to be a bit more involved than I ini=
tially anticipated.

-Eric

