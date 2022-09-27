Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4557BC07E9D
	for <git@archiver.kernel.org>; Tue, 27 Sep 2022 01:53:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbiI0Bx4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Sep 2022 21:53:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbiI0Bxy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2022 21:53:54 -0400
Received: from us-smtp-delivery-120.mimecast.com (us-smtp-delivery-120.mimecast.com [170.10.133.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38544A0623
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 18:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mathworks.com;
        s=mimecast20180117; t=1664243631;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RegVYbtxiHfSnh8QYQBm20BvwzK83bkZGf1/UE/pm/U=;
        b=ghsWw7v22AKpbfM69hGv2jhzDvBm8bwp+zXrtzQ5HS6YMhhCBewOyxyfQH1UVDNbtQmzrI
        fpncrIWyJHE/ngNjiw6i/gAUgZhzkWBBZk8u+/K22NUSYPjznI8HLlAeAXv3ngxzO3mCGA
        aO8XJ47LrJgPfjMWBjuHll14uuxR7BA=
Received: from na01-obe.outbound.protection.outlook.com
 (mail-eastusazlp17011011.outbound.protection.outlook.com [40.93.11.11]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-394-l9Q4_-G5MmaOkZpHaoZqzA-1; Mon, 26 Sep 2022 21:53:50 -0400
X-MC-Unique: l9Q4_-G5MmaOkZpHaoZqzA-1
Received: from BL0PR05MB5571.namprd05.prod.outlook.com (2603:10b6:208:2f::17)
 by SN4PR0501MB3727.namprd05.prod.outlook.com (2603:10b6:803:48::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.11; Tue, 27 Sep
 2022 01:53:47 +0000
Received: from BL0PR05MB5571.namprd05.prod.outlook.com
 ([fe80::86c9:5cc7:6693:d9f7]) by BL0PR05MB5571.namprd05.prod.outlook.com
 ([fe80::86c9:5cc7:6693:d9f7%6]) with mapi id 15.20.5676.014; Tue, 27 Sep 2022
 01:53:47 +0000
From:   Eric DeCosta <edecosta@mathworks.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
        Eric DeCosta via GitGitGadget <gitgitgadget@gmail.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?iso-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: RE: [PATCH v12 4/6] fsmonitor: deal with synthetic firmlinks on macOS
Thread-Topic: [PATCH v12 4/6] fsmonitor: deal with synthetic firmlinks on
 macOS
Thread-Index: AQHY0E5bGc9bn2DWPEWKFMLGnqi6Jq3x1UOAgACrHuA=
Date:   Tue, 27 Sep 2022 01:53:47 +0000
Message-ID: <BL0PR05MB5571D13B63CFC7AE2C3D6EDFD9559@BL0PR05MB5571.namprd05.prod.outlook.com>
References: <pull.1326.v11.git.1663798722.gitgitgadget@gmail.com>
 <pull.1326.v12.git.1664048782.gitgitgadget@gmail.com>
 <6efdc6ed74ec9224d93a1b88ff8be85d533cb30f.1664048782.git.gitgitgadget@gmail.com>
 <220926.86zgemyxbf.gmgdl@evledraar.gmail.com>
In-Reply-To: <220926.86zgemyxbf.gmgdl@evledraar.gmail.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR05MB5571:EE_|SN4PR0501MB3727:EE_
x-ms-office365-filtering-correlation-id: 273e1758-739b-42ce-2f08-08daa02b1dea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: MO2Q4gPMJj6PXSkhsp1DFGsgOnsfC7B+yPxHCfs2vW7hXi0ME7g/5/qYINh/5Ev69jD4TiecsgNLmYbxBP3iuqY31LFpCpQi01m7ldRH0ciWHVTsuYevcYOQL0ZxoQYa0Z+SyoiZM058cNqKN2uBdt9faJAHFwcemydhFnYWb6zC1BgbecR3Qtn4W4YBVw5jp3yW6FEx5e6TT2NKdyST9H8ec+EPkTgE8kSbuFtqRP/l2tcrEmCn8NSmhFHtz2tb8RxOw8IQ71spLrLXmTLNcrZDPJkDRv1N+t3YG5UfdCWD3BtdsZZis8swQCRCiC0Kbaf/CDVNCQZKXxP+L8kqdJQ6f4Ksaw9o0o9J2D6w35fHTu6A1C0ennEhypUnWxs1RLccR+4UfsO4OsByygSeuWtbq1AJftQ8Hi+ZstW6Ne+3Y9tSCY7cBfaiNv2BRVyIQOsRM0XtMDeATdL9tAEC93hXN1RehV5zOWVkINoU+3wCabDaJXFuA43an+bFc6zCV/cvGNxRxeRHrKSN7hmVzsU/2m5ATZ2BeR8qr3Q6nH8hjkWx6pjfi+snxlzbpOXvefWwSrZqXAQUsysvEaM1V4U0xx88ETKsEw/PAZLZBUg7KX+FcrExd+RN9PomjheTcHj0W7PoQ3mpxiJJJz7ejW8TO8WiEES3NOF5ZAerjWfcdZ/EbWWrAfMNXifLSUqNEzsGjYtGHk8lv69IJ5FPZPlDUKhe23cvyiKaPasAt63WMF2M6pXgc1MmIczmy8V2
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR05MB5571.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(366004)(136003)(346002)(376002)(451199015)(122000001)(38100700002)(38070700005)(86362001)(33656002)(66899012)(2906002)(186003)(26005)(5660300002)(83380400001)(6506007)(53546011)(7696005)(71200400001)(9686003)(55016003)(66574015)(478600001)(110136005)(54906003)(8676002)(316002)(64756008)(66556008)(66446008)(8936002)(66476007)(52536014)(4326008)(41300700001)(76116006)(66946007);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?kAcic0qtzJyLBhxtsFozMGGRhVPNCeiugiNz/OSwNaCn2TMHr0jmxCufb0?=
 =?iso-8859-1?Q?2dK/1RGk7x/RgfjeVwXxKpBumGQg30Zp8AMlHllAVwU+ITgNbRZ3V3LlE9?=
 =?iso-8859-1?Q?HUH0BLzzsUuT4AFAGFfWKSc2a5nqo2huWXJM8IG+d+zyb2SLKyKLiIV43p?=
 =?iso-8859-1?Q?rdqZwh5sukbufBdCGaX8LQctLIXy6/KdQqLtAdCp/NZ9h2fGcn6XmmxrMN?=
 =?iso-8859-1?Q?6OXU7RsUw+bm64w2OHDIwrbYcZ7oNzL5OIMPpgDVGepFFBss1h7yo35s4A?=
 =?iso-8859-1?Q?UmtaeGjH09aTRs2v2NTrrZ2aOGrBieShc+fLJaJrkVAMeB6d/NEgFB0reb?=
 =?iso-8859-1?Q?hUWLf2DOz0OeeQBvTJERnbg9SX3qAFR0dgW3A6fndhqOFRvc1FaN8bpwqM?=
 =?iso-8859-1?Q?1f1GP1jFGiGoqGoMefDPrCq8a28NnhRoQiw2fWTfMP6B1Eh/RidkGmN2SU?=
 =?iso-8859-1?Q?sc0boZv1f6VM1/OsCjH0fF9gjkafbVXNlF5vlq5IzKtbYjwH6kvmIH6vAH?=
 =?iso-8859-1?Q?SgJeV6iHZtPqA96Ee4/3tJ2JnyYZ9YEFYVKeYxdXLSwb1egw/OZsyV9bgz?=
 =?iso-8859-1?Q?ySshVqW5LoVDjS5lNqHZhs7pNJXlMMn4Smgfsee/pOoSBmE8T57LcWQQyF?=
 =?iso-8859-1?Q?Su0+HliYcIDFSzGxSeZPPO3WBiztnsEtNV3rId3wxIq0CVFCQsIFvADgjc?=
 =?iso-8859-1?Q?DQD6qbM4tniidTV2JvmxYBVfRZYnwYR4qab2EhD8AEXq/xPb1n1LRyM2EW?=
 =?iso-8859-1?Q?SbcJvsdRfO6KwvgPkYFZQVKsRyHHyj2OwO07z4Au4QDv3z0sKVYSUNS2U2?=
 =?iso-8859-1?Q?uvppDsPHDNqE8z0mohVVWqlaV2PPCsSmQe1tPehpzshYnyE10NC5f2WhwC?=
 =?iso-8859-1?Q?D9vU0UqCY1eHIb+jnUiFJQx83PwxXAtdKd0eBwNGvzWkLOaoCbFfog/mMg?=
 =?iso-8859-1?Q?vmI6WDI2SLd5jU74hGZXCz4S4n3CY3rmyzEsOFfoVvf5d9WNR2WBsX2Xh4?=
 =?iso-8859-1?Q?m5s/aKhgf6QwfIRksUe/j/tIQJYKFhiFRxdWlkU9jvM+oKgq8DTFN/C70S?=
 =?iso-8859-1?Q?5Q3vyCed8rNiuIH+xG+3LnaZexV19s3zK8j5DP5IbEDQ1ylYPCUIcH992a?=
 =?iso-8859-1?Q?jh80j3sSCOBVGHSU1R1TWNWKcB3OajCLkUaF7qncovr+Q3OXGMYtdl3S1z?=
 =?iso-8859-1?Q?9fpoSVLQOucoAeFYRwGqhssj1Afu2/Fr7Htg/rhfBWi/Z+cerWkZted8dJ?=
 =?iso-8859-1?Q?obyx67qkXjSbT7fKcyHsZhgP70dhTE62nBnh8eJ4tMsL9rKYGzivlI0fOJ?=
 =?iso-8859-1?Q?0e+0k8AHqLEc/aBwv/rDv7bXNpO/YT64W6NFi2d//exwOLEYHOMpPi2LV2?=
 =?iso-8859-1?Q?WRnIYfXNZRACiSjWiBCUVeOo06ZaE6TOQmHJpsk9KcvP2ikzTCsS9WyAb/?=
 =?iso-8859-1?Q?bUE4u6CY9RwdOJy35vHl77MHkpxZmKTqJ2CR5G+87mNPh+f2zglhqixP3z?=
 =?iso-8859-1?Q?LZwA7+RDxcAh9uAyS59/Ux2F4h3H26mlmGT9MWR7MldhMSVkDcuybx+WFQ?=
 =?iso-8859-1?Q?HM0N4XgL/vEY8TcXx1c7+azE/KSfPRJzN4/II4TPMcDF10m9iw7hTsu10t?=
 =?iso-8859-1?Q?vsRzK3KUjrsGxs0ZE1mZWNZL2VAhzGHQJy?=
MIME-Version: 1.0
X-OriginatorOrg: mathworks.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR05MB5571.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 273e1758-739b-42ce-2f08-08daa02b1dea
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2022 01:53:47.1802
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 99dd3a11-4348-4468-9bdd-e5072b1dc1e6
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ssVkSMes2Xnjb03BHTPnp9xMCQbzG5UPZfodzenJy/5etCxYQyZmiWYAm3Dy0kXxrex3PyElbK5CvEuw+we2eA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0501MB3727
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: mathworks.com
Content-Language: en-US
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



> -----Original Message-----
> From: =C6var Arnfj=F6r=F0 Bjarmason <avarab@gmail.com>
> Sent: Monday, September 26, 2022 11:16 AM
> To: Eric DeCosta via GitGitGadget <gitgitgadget@gmail.com>
> Cc: git@vger.kernel.org; Jeff Hostetler <git@jeffhostetler.com>; Eric Sun=
shine
> <sunshine@sunshineco.com>; Torsten B=F6gershausen <tboegi@web.de>;
> Ramsay Jones <ramsay@ramsayjones.plus.com>; Johannes Schindelin
> <Johannes.Schindelin@gmx.de>; Eric DeCosta <edecosta@mathworks.com>
> Subject: Re: [PATCH v12 4/6] fsmonitor: deal with synthetic firmlinks on
> macOS
>=20
>=20
> On Sat, Sep 24 2022, Eric DeCosta via GitGitGadget wrote:
>=20
> > From: Eric DeCosta <edecosta@mathworks.com> [...]
> > +=09state.alias.alias =3D NULL;
> > +=09state.alias.points_to =3D NULL;
> > +=09if (fsmonitor__get_alias(state.path_worktree_watch.buf,
> &state.alias)) {
> > +=09=09err =3D error(_("could not get worktree alias"));
> > +=09=09goto done;
> > +=09}
>=20
> As we can see here this is in the one-off setup code...
>=20
> > +int fsmonitor__get_alias(const char *path, struct alias_info *info) {
> > +=09DIR * dir;
> > +=09int read;
> > +=09int retval;
> > +=09struct dirent *de;
> > +=09struct strbuf alias;
> > +=09struct strbuf points_to;
>=20
> ...more of a code clarity comment than anything, else, but...
>=20
> > +
> > +=09retval =3D 0;
> > +=09dir =3D opendir("/");
> > +=09if (!dir)
> > +=09=09return -1;
> > +
> > +=09strbuf_init(&alias, 256);
> > +=09strbuf_init(&points_to, MAXPATHLEN);
>=20
>=20
> ...can't we just use the STRBUF_INIT macro here instead? most paths are
> nowhere near MAXPATHLEN, but more importantly we try to avoid these
> sorts of memory micro-managements except for hot codepaths.
>=20
> In this case it's just the one-off setup of fsmonitor, isn't it? So just =
using the
> default allocation pattern seems worthwhile, and will save e.g. anyone
> grepping for MAXPATHLEN looking for bugs (the MAXPATHLEN is sometimes
> not the actual maximum pathlen).
>=20
OK, makes sense.

> > +
> > +=09while ((de =3D readdir(dir)) !=3D NULL) {
> > +=09=09strbuf_reset(&alias);
> > +=09=09strbuf_addch(&alias, '/');
> > +=09=09strbuf_add(&alias, de->d_name, strlen(de->d_name));
> > +
> > +=09=09read =3D readlink(alias.buf, points_to.buf, MAXPATHLEN);
> > +=09=09if (read > 0) {
> > +=09=09=09strbuf_setlen(&points_to, read);
> > +=09=09=09if ((strncmp(points_to.buf, path, points_to.len) =3D=3D 0)
>=20
> We usually do (!strcmp()), not strcmp() =3D=3D 0, ditto strncmp. See
> CodingGuidelines.
> > +=09done:
>=20
Fixed.

> Nit: labels shouldn't be indented.
>=20
Fixed

> > +=09closedir(dir);
>=20
> We checked the opendir() return value, why not closedir() too?
>=20
OK, will do.

> > +=09if ((strncmp(info->alias, path, len) =3D=3D 0)
>=20
> ditto !foo() v.s. foo() =3D=3D 0.
>=20
> > +=09=09&& path[len] =3D=3D '/') {
> > +=09=09struct strbuf tmp;
> > +=09=09const char *remainder =3D path + len;
> > +=09=09int ptr_len =3D strlen(info->points_to);
> > +=09=09int rem_len =3D strlen(remainder);
>=20
> Make these s/int/size_t/.
>=20
> > +
> > +=09=09strbuf_init(&tmp, ptr_len + rem_len);
>=20
> And use st_add() here instead of " + ". I don't think it'll overflow, but=
 it's good
> to guard overflows out of habit...
>=20
Sure, just strbuf_add(). Then I don't need ptr_len or rem_len either.

> > +=09=09strbuf_add(&tmp, info->points_to, ptr_len);
>=20
> Earlier you constructed a strbuf, and then strbuf_detached() it into this=
 new
> "struct alias_info" you made. And now we're having to strlen() that to ge=
t the
> lenght that we knew earlier?
>=20
> Can't we just make the member a "struct strbuf" instead? Maybe not, I hav=
e
> not reviewed that aspect carefully...
>
Certainly could do that.

-Eric

