Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61978C433F5
	for <git@archiver.kernel.org>; Wed,  5 Oct 2022 21:14:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbiJEVOd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Oct 2022 17:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231143AbiJEVO2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2022 17:14:28 -0400
Received: from us-smtp-delivery-120.mimecast.com (us-smtp-delivery-120.mimecast.com [170.10.129.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 858FC43627
        for <git@vger.kernel.org>; Wed,  5 Oct 2022 14:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mathworks.com;
        s=mimecast20180117; t=1665004465;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aWcEmWIL1yvZ0OHTEMZPbD7i4hNJQvwa3WkxQ1Sr8eA=;
        b=ISnuiNrrxy2KQ/oc8JkjM+d+dx96xcq+nqZt5FUkhsrHudzDSV2mLN5Bnp1TqzeE5Dfvmq
        MbF8bv813izZGSIROFX9kBUvQz3T9WxU0bp3kV2fzGAzI/CNanMbcWqMMab6H/oP0qTJKn
        Xgz8y/ALGwZzHwvhJHQvnrI3/HloORE=
Received: from na01-obe.outbound.protection.outlook.com
 (mail-centralusazlp17013035.outbound.protection.outlook.com [40.93.13.35])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-299-dd3Mwh3MOqCD44MY7KhP5w-1; Wed, 05 Oct 2022 17:14:24 -0400
X-MC-Unique: dd3Mwh3MOqCD44MY7KhP5w-1
Received: from BL0PR05MB5571.namprd05.prod.outlook.com (2603:10b6:208:2f::17)
 by BYAPR05MB6056.namprd05.prod.outlook.com (2603:10b6:a03:db::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.9; Wed, 5 Oct
 2022 21:14:15 +0000
Received: from BL0PR05MB5571.namprd05.prod.outlook.com
 ([fe80::86c9:5cc7:6693:d9f7]) by BL0PR05MB5571.namprd05.prod.outlook.com
 ([fe80::86c9:5cc7:6693:d9f7%6]) with mapi id 15.20.5676.014; Wed, 5 Oct 2022
 21:14:15 +0000
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
Subject: RE: [PATCH v15 0/6] fsmonitor: option to allow fsmonitor to run
 against network-mounted repos
Thread-Topic: [PATCH v15 0/6] fsmonitor: option to allow fsmonitor to run
 against network-mounted repos
Thread-Index: AQHY2BdNEC/3yCqRdk6OVHsHl00d2q4AGd2JgAAyMeA=
Date:   Wed, 5 Oct 2022 21:14:15 +0000
Message-ID: <BL0PR05MB557152E4728FBF3DB4B27CFAD95D9@BL0PR05MB5571.namprd05.prod.outlook.com>
References: <pull.1326.v14.git.1664395931.gitgitgadget@gmail.com>
        <pull.1326.v15.git.1664904751.gitgitgadget@gmail.com>
 <xmqq35c2qh7u.fsf@gitster.g>
In-Reply-To: <xmqq35c2qh7u.fsf@gitster.g>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR05MB5571:EE_|BYAPR05MB6056:EE_
x-ms-office365-filtering-correlation-id: d0544257-1ad6-4dee-887b-08daa7168ee3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: zXh5heUv+2++4jMp67eEy3eDLmLtG4G8W2TryI/WUqY0M19oosswRG2fsFIDk2b71cvnvU0YKCwpoDs/YqsoN0b/D1MxML+EDwMYM29U6IpbWcrT1mR0zZxphMMTx1MNdTLuwj5ucQ7WZNVU8vsuS9kUNoA4pAGWbqK4GBQq0BSbaEhY6FVJMiM0AynQTLLPoBjxOnJ0J3mm7Tpxz28B+rr0+KfGSCkvEsX8FqArgUyE3m6MLdeF56GPt1Lv6bXC08PHv1Bc/LI/j6J7XvqxSTS5hBQeG2FkYijs6qg+l2K9EBvdgtXm6sQMF604sdASDgYSebQujNCz+pm+hBz0FFr8k6guK5Xf7R1UCcmJLrRWgazQ8XPuP0YslfgZwECTdXUtoj4XghgA3HEPaydo8HGfbC+TjEVa9QWZzh96lMI5623icoe0Vit+P2cD566DkSgCsNY6eEZYtEYhruS1SoiMbj3Dw/8hkzOFgnJADdYpY2npwVy99fd6jS/GGTkEwwJbl20ANhVHAVCJuSt5OwkFfLiCK95vdNYdU9LtGmgwgkfEcc/OBnDVNt8dK4N/t7EKJe4XwxnzfL6euUbfqXzr8sSkRdHa5KH1vUiajLl1JHwgbU/Q/4wQ2dNw5DKDSOBVsKudvgto+PQoeGoVloWaaPE9bIdwk5SdSv0kLh/KYNLO80rReFEOpq/5ayUKQLREjlU86xVCb+5EkMg3mH3Ea885Ap2hvwQcI462lA3uhpTHC9aENqgpDLStC8pphGJDusp3QQXoybri3DvZ4Bya7S8ufxpuzcmDoBNhpdi3DB2z+5Livi/QT6gAge7o
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR05MB5571.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39850400004)(396003)(376002)(346002)(136003)(451199015)(186003)(7696005)(5660300002)(316002)(83380400001)(6506007)(41300700001)(478600001)(53546011)(2906002)(8936002)(54906003)(52536014)(110136005)(76116006)(66556008)(64756008)(66946007)(33656002)(66446008)(26005)(8676002)(55016003)(9686003)(66476007)(86362001)(4326008)(38070700005)(71200400001)(38100700002)(122000001);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?znbWaCvPB56NehbpxMMoY8A+f6ozG8k/Rw3k/BrtrKXV91xVqOrqQkcKRW?=
 =?iso-8859-1?Q?ZWS/jTlE7Fgk2mvkYyPZ+OCs9xzHujXA69/0tApPcvp0U2+ezgIGsdT0JX?=
 =?iso-8859-1?Q?A2SwGmHdHIf3rxxl5rZlOOt2BODCngJxgvTekyspBMIt1qZ7oT50HKJsPR?=
 =?iso-8859-1?Q?KOtbDI0RhjDVh/JFueob9wGSKyba2JgUjLdfm+T0zFwfjWqdChPeyQxKmi?=
 =?iso-8859-1?Q?jvW6KOW9e29BnQM9qM35mQuWm+QGTfCvAMV2lhoFu1ZEevxyXgGTU1oBlT?=
 =?iso-8859-1?Q?v1Fyk/8I0WkUeJaHQMWz67dgg+lsEptMpDQtoGHImz/3yNgefH08J8JIp0?=
 =?iso-8859-1?Q?xcoAKujeEdj1v+3X7mecS999oOn2DN9NZ8QRUZjQ7bbY2WdDARfV0XX8hA?=
 =?iso-8859-1?Q?FAIhjVqoyXOBwyJsbRbRJQEzzZwRmeha0Sbm3OXQ02chmYqA5HZCyiZuj0?=
 =?iso-8859-1?Q?HD/WaW6FZPWbwOeARNnchFu8iaiLVl0SN9KhyvJuVv4bP/PttgEqQcsVkV?=
 =?iso-8859-1?Q?/5OW32CTk7gcCpZFM8eqKzWtCvnJzMZjYJSG6DK4fV5OZLyB+4A0Kfk/zH?=
 =?iso-8859-1?Q?oPsfffc3TZrXAuCnPO2nW0Sy2eo470XpBoe3BY+ccPYWXj9tPw9CiGk20W?=
 =?iso-8859-1?Q?44Cc4IKaJT2p3l+W352mx+xPNg2wBtHsGaNueOKCsXRvmbmj1xaPARu4lk?=
 =?iso-8859-1?Q?gLAA8M/9b2XSDJ3/BBVCTAklUsr4yHOe7alJdAguZOp6Uo+pW72pVpdDmW?=
 =?iso-8859-1?Q?P/QOsi0Sfv0QDRW1BiM/kqfgtn2njPEnoMv2KDG0cXd5JziyaZnr5uB2yc?=
 =?iso-8859-1?Q?sK4LDlAjRFDp5+8nwo3PYxugJRWolnggyKY5smg8MRrD0SXwSEd1p3qKlf?=
 =?iso-8859-1?Q?AiFowwgfQ9iUNG/pPcP7QNK/COTP1fp+lGSAwCjPKqQQ/KFyVqsZckch2D?=
 =?iso-8859-1?Q?y0l4pFLgQBAEsCk1YLAWrx3p5wEBJSe3iVl5qOEoRXzuEPmfhwpdS0tgxd?=
 =?iso-8859-1?Q?9X4KbFUceT8ArrMI1PUV8r+SkcxiA9zbjfJNy3LIswZoh2EOUhK6UbDCns?=
 =?iso-8859-1?Q?u7PUcEyibOsl69bBdVhjpan9SjL2JBnh3DVG1/2NQBjmGcNL10KIBgifyU?=
 =?iso-8859-1?Q?vEmOJcxluojcqMIWxu/8lvZ/ZeJRQfj2O7XBSbzQ0WOqrLZFGV9b0yd6gn?=
 =?iso-8859-1?Q?UqZWFPtPzBV7KCeH/XyHtp0NFrIIq1UDavdJFFyapOjzM7VsgziwWUmsOq?=
 =?iso-8859-1?Q?RuEBTI/2Z1nIKMTiC1I0vEcmxkTcKdiDrDpQ47jXG2OTQIpjOMUyiwY6YQ?=
 =?iso-8859-1?Q?VnmgrsJ0aNTvrNHs7xGyDSRjcyy3NGgNkmjypeeeKVdyugc3m+vmilf93h?=
 =?iso-8859-1?Q?vq+79fWvzy6y9f4tk3M+yZrAiAv6aSd0xecOiS9TwQgqSEepq8tIt2n255?=
 =?iso-8859-1?Q?k3tPXVWMFe5qNle9bY0WEBnosnx7zSbC0jt78jkzmZ9zgpy5Jj+7GsZCVe?=
 =?iso-8859-1?Q?ohYRT56nBffs5tTGZ3AUukSfs1VFYzPK9ATbPwiYWoClhodlqQFUUOfAJ2?=
 =?iso-8859-1?Q?B3r/UZTUoKBntHNNRaxKWphQLv+amY+0wRS5oY4xjh5oU5DVEE1DwciXPt?=
 =?iso-8859-1?Q?RMfL/sOSF4E+LIrRAlReQFIKknuC7PghOE?=
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?iso-8859-1?Q?wvRzGryymnwS56vgBzxt9VV54SfrQNNZtGaCAPe7aXe3oKMlazOxh9hben?=
 =?iso-8859-1?Q?BG8lR1dLwFWgr1MagRP1urub4Wvg1yx7WTriwXqICZNHYWRjB6buETED0h?=
 =?iso-8859-1?Q?UGwlgb7YsG5xke9M4nj6GabjEstGclXH0L51ynkC2Bor9fLM9PVIrULHNY?=
 =?iso-8859-1?Q?qsWRD+d6JYOZqJ4JvYU6HYo1UklDI10EMN6CSv3TgGjZyJx2Mqg7eExkAU?=
 =?iso-8859-1?Q?5MKsqTwxcONzO7K3Xfo9whYg47mdkEZfN1pv/DkOyTdeIM4KJ6oUwlljft?=
 =?iso-8859-1?Q?ElV3cHFr2Q7Ho529/xcTHbE4nmElW4k2Sd9TgIuI5ixNjGwlTJiv5Xqj2X?=
 =?iso-8859-1?Q?DQORSE6NijFTTRssb0d9+l2ahO75Dl37Eg3s3eiyqSvd2yUNwoMgl2JcGk?=
 =?iso-8859-1?Q?xYpj3X9ST59kFBIlmRd31zvMtg2qjqV+P9mhssbirRSE8/FzXHgxsPQb0s?=
 =?iso-8859-1?Q?90YLGrPlW8iDuc5B/mbzY//xVBrFFV8X3ZRTOx8tS7fqzpOYJGrk1LH1J2?=
 =?iso-8859-1?Q?xBVmWfGh5Iko4CTtlt8GjA9dkcagJmRR4T0magvlDohjDXKSVOKOf3p6jL?=
 =?iso-8859-1?Q?0YSWCTOwzS1ainBNM4sQKge38qj+02wuB48pMgew9Xmp1fTWAXIeyoXJAd?=
 =?iso-8859-1?Q?ZXWtgqEXfc4KCWFAMKnlVjSBhktgYaMPIFZF3lGCxhrVYhKQADUU4hpW7z?=
 =?iso-8859-1?Q?8dgkdolN+hAgsjBP08vs7aFGoVE5YbgH6OSTIWGmBHUVYd3Nn17UVemZqN?=
 =?iso-8859-1?Q?0hqBmQP/fjwYc8RWkiAMWd/AsJgsjj/itJyJXofIvwi8GkNwtNa7roeKee?=
 =?iso-8859-1?Q?9M+n75HTkIJMaYRiGz5qk4Xk1yIrXaGgAGTx366ZcFkWigpGBi4iZdPbVm?=
 =?iso-8859-1?Q?tN4Sp3Q/lirPDZvDJDsNDnZG1VIlSstnX05d+uDo5rp1oUgSO7XfD5dEvu?=
 =?iso-8859-1?Q?e2pl9byvtHM4MRzPWJ8RkvuhYO5x7J8f5I7E5Orijw/LewKcyKL8wCJ0Yf?=
 =?iso-8859-1?Q?F/YR5jTSaaWMDMUKYbpc0cHFEAFs9amLrX97bdpiJTqfU7EL3vJz41luU5?=
 =?iso-8859-1?Q?yw=3D=3D?=
X-OriginatorOrg: mathworks.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR05MB5571.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0544257-1ad6-4dee-887b-08daa7168ee3
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2022 21:14:15.4429
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 99dd3a11-4348-4468-9bdd-e5072b1dc1e6
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /fxxjY0TJ+5UNn1veH9jKX7Qd1g8IAECoW4WZBmPAsmT4zp5UW7tWDXgIybrik4Ozran59NkL6G+ngpTdifnqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB6056
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
> Sent: Wednesday, October 5, 2022 2:05 PM
> To: Eric DeCosta via GitGitGadget <gitgitgadget@gmail.com>
> Cc: git@vger.kernel.org; Jeff Hostetler <git@jeffhostetler.com>; Eric Sun=
shine
> <sunshine@sunshineco.com>; Torsten B=F6gershausen <tboegi@web.de>;
> =C6var Arnfj=F6r=F0 Bjarmason <avarab@gmail.com>; Ramsay Jones
> <ramsay@ramsayjones.plus.com>; Johannes Schindelin
> <Johannes.Schindelin@gmx.de>; Eric DeCosta <edecosta@mathworks.com>
> Subject: Re: [PATCH v15 0/6] fsmonitor: option to allow fsmonitor to run
> against network-mounted repos
>=20
> "Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com> writes:
>=20
> > An additional issue is that for mount points in the root directory,
> > FSEvents does not report a path that matches the worktree directory
> > due to the introduction of 'synthetic firmlinks'. fsmonitor must map
> > the FSEvents paths to the worktree directory by interrogating the root
> > filesystem for synthetic firmlinks and using that information to transl=
ate the
> path.
> >
> > v15 differs from v14:
> >
> >  * fix memory leak
>=20
> Thanks.  I thought "what, another iteration?  didn't we see this enough t=
imes
> already?" and a note like this does help reminding reviewers why we need
> one.
>=20
> Very much appreciated.

Thanks.  Just getting better at doing the right thing as I climb up the lea=
rning curve :)

Hopefully it is in a state where it is now GTM.

-Eric

