Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E181C433FE
	for <git@archiver.kernel.org>; Mon, 17 Oct 2022 21:32:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbiJQVcP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Oct 2022 17:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbiJQVcN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2022 17:32:13 -0400
Received: from us-smtp-delivery-120.mimecast.com (us-smtp-delivery-120.mimecast.com [170.10.129.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A3777B294
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 14:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mathworks.com;
        s=mimecast20180117; t=1666042331;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ncXl+yYnMmPjGU41XU6fCfOS6hpcOCOSb0O3w4xMXiI=;
        b=GMzqPhuE8W93YYeM4aydAUcUD3HewbBbHa0xcH32sqVcGQqgLU+abuCZP8vTWjgWWDtQEJ
        aZaKKWQkUEEI8HMQkbnkhlDxkEoc3BFmWWyRunkiDAZ5/eOtVJR8/+XH3LPGTrHofLoM5h
        gUzTcD8SZqevZyZN691gmMq+Q4lbOvs=
Received: from na01-obe.outbound.protection.outlook.com
 (mail-eastusazlp17010005.outbound.protection.outlook.com [40.93.11.5]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-169-JK2W3G0UPbGzVXQ00LvQkg-1; Mon, 17 Oct 2022 17:32:10 -0400
X-MC-Unique: JK2W3G0UPbGzVXQ00LvQkg-1
Received: from BL0PR05MB5571.namprd05.prod.outlook.com (2603:10b6:208:2f::17)
 by MW4PR05MB8914.namprd05.prod.outlook.com (2603:10b6:303:132::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.14; Mon, 17 Oct
 2022 21:32:08 +0000
Received: from BL0PR05MB5571.namprd05.prod.outlook.com
 ([fe80::fde9:a6ac:96b0:a49]) by BL0PR05MB5571.namprd05.prod.outlook.com
 ([fe80::fde9:a6ac:96b0:a49%6]) with mapi id 15.20.5723.016; Mon, 17 Oct 2022
 21:32:08 +0000
From:   Eric DeCosta <edecosta@mathworks.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Eric DeCosta via GitGitGadget <gitgitgadget@gmail.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
Subject: RE: [PATCH v2 00/12] fsmonitor: Implement fsmonitor for Linux
Thread-Topic: [PATCH v2 00/12] fsmonitor: Implement fsmonitor for Linux
Thread-Index: AQHY4BZWIrTTdGxQQEiEiOMitIi/Hq4OilQagASU4WA=
Date:   Mon, 17 Oct 2022 21:32:08 +0000
Message-ID: <BL0PR05MB557123F87157E0E091A43494D9299@BL0PR05MB5571.namprd05.prod.outlook.com>
References: <pull.1352.git.git.1665326258.gitgitgadget@gmail.com>
        <pull.1352.v2.git.git.1665783944.gitgitgadget@gmail.com>
 <xmqqwn9256cw.fsf@gitster.g>
In-Reply-To: <xmqqwn9256cw.fsf@gitster.g>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR05MB5571:EE_|MW4PR05MB8914:EE_
x-ms-office365-filtering-correlation-id: d6ecead3-6671-46f3-cddb-08dab0870b4a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: ZgJ3Lt6h93xKj/6+E5ShuGzONywGBd9JZ0hvlhUUodnYsrG75Peo3GNTBfEfY7UJb8nNPhPSJAaYOnNvt8J5jQiOhuEzecRWgc0C2Z7GQQHA2c5zKow4BkKvUD/d9kJ52SAA7gNV1gPIq/vsk7KfenDNqHlzbS7OD7NWxGxbJ8gS3a0efE1hFDDK1ZVkjErH9rRLSecQHfVhMoHkeQF6L+/be+EuYWttitD/yy09FE8DSRGWpmHcbNBSlc2CwvEi78hASK6k5+Lxho99Q3FDO1eJhdfxkQDfihLNPPlJMoucJMsdnsw9Gfp1W46TevnDAcK/OeTy2aI2MqKIx1kwly4WEiPe43gmuwtR/KoV8s7kxm8BHyze9pilE7m669PwwUoLRQwXcRc5pn897cylnsTV+9XhOwX0sHUuzMNdAD7JkP+Z5IqLXzboWNEL/GHqsioMnNQrPzhcN8Z1pIqcR7GkEcQP0JdB0iLN5NSFRSLlllO98b8AAqj+9Rf2LiZEPiUvR4kCC2YEqQKB4jUEUtZHER0Y5CrDpVrvgIxzZ6Z6tCFM4byijouYHRBSp+lOUpUpITmMWTp8/PRWLSXWSK/b0kSLIcSVhLhTGaskyZxtcqOQ7fEQqVOcC4xFbPsxASq0o9vk+WnFfjWR/fie2HkZXLcmCpdWdvTuFq3z1IHd2kTdAMwOO44UIHCSrySQMafHEB/CXTMvGLRmJLmixvo+18x5V/1B6yVCH5RghXaR3Z4zMw6zq1PGr40E6o0R9wPwuh/hj/oMODTAEuqGLA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR05MB5571.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(39860400002)(136003)(376002)(346002)(451199015)(5660300002)(38070700005)(7696005)(6506007)(8936002)(2906002)(52536014)(26005)(41300700001)(53546011)(186003)(86362001)(38100700002)(33656002)(66574015)(83380400001)(55016003)(122000001)(110136005)(54906003)(478600001)(66476007)(9686003)(76116006)(316002)(8676002)(4326008)(64756008)(66556008)(71200400001)(66446008)(66946007);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?AJxWG4FDaBM4Mz3WWqgvZecVBdUVHC/7Q+zYWjW6Axc1UccdssELAplSwS?=
 =?iso-8859-1?Q?EbSf6PTFPzO1+U7scUEQI3P8HLrZfg6Jpb9vN1BGAOqr/nGFim9SJe1B0D?=
 =?iso-8859-1?Q?hZPkJmMrGlYpEA82c25DVKmZ6gJ3UemYkfdRHviVdo3dBHOA96CGqYVvH0?=
 =?iso-8859-1?Q?8gy/DNSU9geMXB9XtUZ8Dee6eZbO3lBsPYs4wbTR9O7SzmhT010caxrh5U?=
 =?iso-8859-1?Q?DX0/1rmQiETKbPpwyvdNLGDVOaF/oLl9ENpccJZHckH3LOUHi5flV8eXCA?=
 =?iso-8859-1?Q?qXHjwBO1TgUhpU7U57DaJOA/srM0G3HJ4J9ityRLEapzP+zX7NCbyn6odn?=
 =?iso-8859-1?Q?EoTY1YsrV3bzvdSK1m1ZGMYwv2vwfiG95p+7uhzfvEwna6Owubh48pidQO?=
 =?iso-8859-1?Q?Reiw886pTvpyK6sg9b3EabftFkt8sU3xK3l/lkIPnlw3UHuBsTuz9WC3fv?=
 =?iso-8859-1?Q?rCpjLoJ8hPWTu77uCdGkBPmUFQZlAal8ontAhyjo/6rPKqYp/xUWuBv7HH?=
 =?iso-8859-1?Q?ZvxeeOzS3L7aS71bD5jRy5Loct+hqmiapg+wB5cPTNTZpmaPYQ77IUsiiQ?=
 =?iso-8859-1?Q?Er+THzut4lL9bRHohXAR3TDpcpQ8hHuzBHtgkVOlxSqA7Tm7AUpMMznYS+?=
 =?iso-8859-1?Q?evfan9864uwa4NuLPHAYHHmqUHlc55q+1qNwEPUcbVoT0+l8bvql00cqDp?=
 =?iso-8859-1?Q?htgH7H7fktROwZiXQ5ZjSL03a+b1c/hJn0yxDGz0YriZtQZyChdjMK7Bu/?=
 =?iso-8859-1?Q?d6Xn5LnBXldzMAXHrcw/Nwo87ZPkeh1GMr7YD3pd5FYKBP5kMVpdDkDkxz?=
 =?iso-8859-1?Q?Piudg2v4l0tX8falvUFXAtAzFX0KFHarqWI80rJN7Tb+xvTIyqz3pgwS/T?=
 =?iso-8859-1?Q?8t1gYI0xxujsDRef32fa4cjJhdsFgIOwiDkHMIyVbUeQYCXgd4YkHebiQO?=
 =?iso-8859-1?Q?FLGu7y97IEQ+9QS7OyAE6/LDPCL6xN0oJeZq5m86J3OROx0OWG/Gu3Uk6Z?=
 =?iso-8859-1?Q?g9n/HwiIEZe9Ja0zStz6Ua6wblyunHGgdkwGcCkFVfDz8V2w4ion5ycpwi?=
 =?iso-8859-1?Q?psbYaaeEcRMKmwgQ7Z+ThVldn49bfdIa5h2yBJpJUUZ+6ASaE27ulSellX?=
 =?iso-8859-1?Q?mWo9HtIG5lbX2BB1IUzMCcbCKtFTNgaucOvG+skSQ+fc6BC/wKm7AKFU8L?=
 =?iso-8859-1?Q?4tgSR3oO6Pe0mdfkXNwjkD+YfV/RcRMI+CsRxDeVJUlotVkIT83tB29wg8?=
 =?iso-8859-1?Q?UlFt3GL4GuSZ9YC2sPvZaREck6JNxVrxlmJCg4Mw/N2ZsH8ZXjEjG9o5Fp?=
 =?iso-8859-1?Q?yZlI9sMoUjZOOXLY4gNtIb4sm9XK3+s625i49/FK956EAEDA+o0YFmRSpY?=
 =?iso-8859-1?Q?iHIqGyfXisk4tAp2+c9jPDW2Gx5f8VqntdN+V2yU7WO/cKXs5NpXxZxT3n?=
 =?iso-8859-1?Q?Py/ald/u4C8fU9RIKulTD6Izd5odKyGMRc/f7u8lxNas2gXkYcnVnKIo7p?=
 =?iso-8859-1?Q?krsodZ5o+7NPh/i9l7mI/83lBhJqIikKkWLQDLtHLfN42xDo373v3yElJi?=
 =?iso-8859-1?Q?kz9cEFiIZaLfbPNy0aojd/IbxWu08vvYSsp8gPG5ZtURJhm/qcsecV0sS8?=
 =?iso-8859-1?Q?kNWw3Vd+K/IizwSssIQSsTyWEhXTCyaK0s?=
MIME-Version: 1.0
X-OriginatorOrg: mathworks.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR05MB5571.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6ecead3-6671-46f3-cddb-08dab0870b4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2022 21:32:08.2246
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 99dd3a11-4348-4468-9bdd-e5072b1dc1e6
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8pHVpXMHcXIYa0X0AZpBClj+0qlvpbzcrbnE2g/iq7/wTQW4iuHvjaWskI01MhtibKF8+1W7LanGJT2KMROjww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR05MB8914
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: mathworks.com
Content-Language: en-US
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



> -----Original Message-----
> From: Junio C Hamano <gitster@pobox.com>
> Sent: Friday, October 14, 2022 7:33 PM
> To: Eric DeCosta via GitGitGadget <gitgitgadget@gmail.com>
> Cc: git@vger.kernel.org; Eric Sunshine <sunshine@sunshineco.com>; =C6var
> Arnfj=F6r=F0 Bjarmason <avarab@gmail.com>; Eric DeCosta
> <edecosta@mathworks.com>
> Subject: Re: [PATCH v2 00/12] fsmonitor: Implement fsmonitor for Linux
>=20
> "Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com> writes:
>=20
> > Goal is to deliver fsmonitor for Linux that is on par with fsmonitor
> > for Windows and Mac OS.
> >
> > This patch set builds upon previous work for done for Windows and Mac
> > OS (first 6 patches) to implement a fsmonitor back-end for Linux based
> > on the Linux inotify API.
>=20
> Again, the first six patches are a part of what is queued as ed/fsmonitor=
-on-
> networked-macos that is now in 'next' but lacks a fix-up commit from Jeff
> King.
>=20
> I understand that it might not be easy/possible (e.g. perhaps it is a lim=
itation
> of GGG?), but I really prefer not to see them re-posted as part of this s=
eries,
> as I have to apply them and make sure there are no changes from the last
> one before discarding them.
>=20
> Anyway, thanks for an update.  Will requeue.

I looks like I can use GGG with the next branch, but I will have to open a =
new PR (and close the existing one).

-Eric

