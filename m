Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87B60C07E9D
	for <git@archiver.kernel.org>; Tue, 27 Sep 2022 01:25:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbiI0BZp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Sep 2022 21:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbiI0BZo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2022 21:25:44 -0400
Received: from us-smtp-delivery-120.mimecast.com (us-smtp-delivery-120.mimecast.com [170.10.133.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7B4663F07
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 18:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mathworks.com;
        s=mimecast20180117; t=1664241940;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I8dlPWO2KILjsnMr9Gy8cXU2ifKnD0s2AFUMIQDWVcQ=;
        b=bJWJCtI5XeJ2lm0uoc/36YkXjDrFm26wUuHElMAqOlryzp05JmpJWeTkA9FMYAcH+DyYr/
        aXxIG73OMzVGmzG/Bnfv2VbeSOJ/7kyAhJ+qVdV+U8n7nr7mEgNTGlnhCRWvcbZipwsrCI
        srKoyzCP3xQCXqpABIq2U4s0cw8Nx6Q=
Received: from na01-obe.outbound.protection.outlook.com
 (mail-westcentralusazlp17010006.outbound.protection.outlook.com
 [40.93.6.6]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-212-YdcIJFreM3WNn5nhI3CDCQ-1; Mon, 26 Sep 2022 21:25:39 -0400
X-MC-Unique: YdcIJFreM3WNn5nhI3CDCQ-1
Received: from BL0PR05MB5571.namprd05.prod.outlook.com (2603:10b6:208:2f::17)
 by DM6PR05MB6796.namprd05.prod.outlook.com (2603:10b6:5:1f9::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.7; Tue, 27 Sep
 2022 01:25:36 +0000
Received: from BL0PR05MB5571.namprd05.prod.outlook.com
 ([fe80::86c9:5cc7:6693:d9f7]) by BL0PR05MB5571.namprd05.prod.outlook.com
 ([fe80::86c9:5cc7:6693:d9f7%6]) with mapi id 15.20.5676.014; Tue, 27 Sep 2022
 01:25:35 +0000
From:   Eric DeCosta <edecosta@mathworks.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
        Eric DeCosta via GitGitGadget <gitgitgadget@gmail.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?iso-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: RE: [PATCH v12 5/6] fsmonitor: check for compatability before
 communicating with fsmonitor
Thread-Topic: [PATCH v12 5/6] fsmonitor: check for compatability before
 communicating with fsmonitor
Thread-Index: AQHY0E5d38XpcWXNI0m/cE524vEv3K3x118AgACkrgA=
Date:   Tue, 27 Sep 2022 01:25:35 +0000
Message-ID: <BL0PR05MB5571BE9E38E1E972ED3077C6D9559@BL0PR05MB5571.namprd05.prod.outlook.com>
References: <pull.1326.v11.git.1663798722.gitgitgadget@gmail.com>
 <pull.1326.v12.git.1664048782.gitgitgadget@gmail.com>
 <421d77775dc24e52ab26336a1a82ed0e7b15ff5a.1664048782.git.gitgitgadget@gmail.com>
 <220926.86v8payx6p.gmgdl@evledraar.gmail.com>
In-Reply-To: <220926.86v8payx6p.gmgdl@evledraar.gmail.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR05MB5571:EE_|DM6PR05MB6796:EE_
x-ms-office365-filtering-correlation-id: 6517b9dc-986b-401e-78ec-08daa0272db2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: jJFMqK93mQQSzIwHA3gHy/BqA6UXk4dOqjNCXbepZVbIagh3+hnQnLuM54CX5HT8TEkhiwVeZmPZdhqslpYJ7OaAJucuEJlaBZmPy6WXBEsHcIZwbqGAgSe9KjFv60hzc7GZ5mBF2xc1bBpXKJ1fSPgv8yzKR38/Ippp0HuvhL9/A/x52KhM66cNksp+yOTrFtum4mv+cvSWprKzSgx+60sdLoVcM6LLtOha8s8JwNX4HjuV98UndjsLjafMBzpj8fviuqg3p0u9VXeL25OB5lpnGf5WThkgatO7rcpSZJxYLDLflinWYgbVlK2zglVZp5ujTckD79KbNgsyaf4Ee8TXzQNi4AnSBJiK4iOXvoUfZ9+o1HkIpUdWxdGrHC2n3V4iD+PzMxoJQIIrFQx2w9NJSmRjCsDFCLa2LsjYUZ1tQH/N73+S3hQkjfYA37nwcmWH/nBGq7ZTmR6hmk0VDVxHXcU0mBiXAMiDk+fT51AH8DGDz/vEhjI7A9G1UMn+PlzQixmdVjEzVB0eIP/GYRvPpNgxjIDk9n5ZwdC45e39fubCzGyEYI3MZ6WpPaW+uPOL6czgyy4+a9LB47tikHhEMDsi4bvCmufo3gvVNHluLRGzkG/a5vUWH1pld+Z6cFBtsrBRkXewc2VZCN2M6FouVlbK9p92Jxdyj2M+/2P4ocFWy/vuJvf5ByMcaow8No/lUWh/WxoTbqMYmZo8H7pfKQQGEfKXoWl2FKAF70TsW+hXqpilGoo3IKjv3AhOrJIet5l6xhpYhhcAJyuk9Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR05MB5571.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(396003)(366004)(39860400002)(136003)(451199015)(8676002)(110136005)(316002)(64756008)(66476007)(8936002)(186003)(66556008)(66446008)(33656002)(2906002)(38100700002)(7696005)(9686003)(6506007)(4326008)(53546011)(5660300002)(52536014)(76116006)(66946007)(26005)(55016003)(38070700005)(41300700001)(122000001)(83380400001)(86362001)(478600001)(71200400001)(54906003);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?HVKUqlCnWPDnKTY1rCtuytcz0BQedcF3W3848RzbXRYiZ5JxUo/CH9olLm?=
 =?iso-8859-1?Q?PTslJXc3NP65PUJF8zetfZYlriDiVhZkAjH4WfLPW/qbnQhpnv4FCaYJNi?=
 =?iso-8859-1?Q?orwVkXdbGwCVZg0TojgJDwOihiJn/dKQ9E1gD9hEwKXLkBLKkhUMAHNQFM?=
 =?iso-8859-1?Q?Yx/h88anyQeiQHgOeC3qEdKXCA58EciBHbvG25RI9Flx1v4tpDj19H50bx?=
 =?iso-8859-1?Q?8x/NGaWNNT2qBQ47FslHVZaN5ZSgTXCGw3tKURR5eeQnRodOcNSFWB1CrV?=
 =?iso-8859-1?Q?F+RVyg43UFJcyupGF8CnrDZYgco/IW+L6v73B2ZnnzckoMCYiF8r2QhbRF?=
 =?iso-8859-1?Q?ynlI8hDIDQSMp9bJDrjbbc4V48F0BlnOye0iyA3aGM6O2cv6oX8osKVxLL?=
 =?iso-8859-1?Q?3NoCYqneI8316iPj0SFgIinQS7THpYdKsUboWRpUcp5s4yahcPj6yhaRPE?=
 =?iso-8859-1?Q?a6s0yEhdyXrNOxCOEkvcr3SBLYGflyG00LvZKLF/1RmXLoekP3aXao4Wa1?=
 =?iso-8859-1?Q?mHgWT0oJquqyZfOchrpVdL3baO2QG6WBfW/Ji7cyuES+7ul7RyBm5I75Mu?=
 =?iso-8859-1?Q?KrkQ3vIhk9Rszedwkzh84GForwmHQdPPj60FVdWPWOwME3aCaWMxOmXGxC?=
 =?iso-8859-1?Q?Tm+0exdEDliSkK4lcX4cGZK4pKri/8gGpZrtBUH5d0c/K9b474E3aa4plj?=
 =?iso-8859-1?Q?Hnla5YyRnhyo5LsdvX2mIi1esg/R/i5lsKt8r80sJ6gexUySgG/A4+qtUM?=
 =?iso-8859-1?Q?lgnXsYUEMPRYNhN7fmEbmC28llr07i+T23V1f2s4UuH6Qd0QiWAnnlWlWD?=
 =?iso-8859-1?Q?ThVgvifGRJU6jUKS34rJ/SnOe5VY1cysULSSO9XOBPIyL8s2HWdkM1lMZm?=
 =?iso-8859-1?Q?JRqF6hX3M+NgGKJd8tFe69bneo7PUX90rFrzTgq88KIMQ5B62rbf+HMUyV?=
 =?iso-8859-1?Q?P9zNp7xq5RvyD5sd2lHXfV4xSrHUXdCFC1XX3/r/zqokhPz8sFJnPgC6m7?=
 =?iso-8859-1?Q?w9aXFzZcGl+ZhZHKfwVJnw1QdE4bbGRN5IfEQh6q66bcMUZCBoazY2lw7I?=
 =?iso-8859-1?Q?Y85B/e7pvbdXXjsSQqXGO9d5B4TcUosgFXYHsb4WM4aZymXILXaO4uvnXo?=
 =?iso-8859-1?Q?mhICirqUDxElnPpcIN8AP84AkJdQ1CWpOx3jvY6CF9AsMHFRN3Lr71sTwy?=
 =?iso-8859-1?Q?+X/zEUqdwYnzfaiIhEH2no6vOGYpVTuRE+0bLNNmQkkm9VosKX5r0CHLx+?=
 =?iso-8859-1?Q?9iMBmtubhFOYSgX4vFwj21bRq4a+RXxGpGTdLRjfN86ujORl2SIxZl8d8F?=
 =?iso-8859-1?Q?q+9f6YxVY6ZfGkOA7FI94Ynx/XoKKxVvNqvcrOWigPTlbJVBagL2I409gy?=
 =?iso-8859-1?Q?3Xbvo3uRtqkHjrmcr69lxj2MokC+R2VNBZzj6VZ+Zloc1hHcNthIAdJYmx?=
 =?iso-8859-1?Q?ZBlPrPi9REsOoFUUpyOCXD+w+EuX5YUGSua2GQuKC8Qc7yKpCVnyHrZCgx?=
 =?iso-8859-1?Q?mlbCVLRu2xGa5oLGfb3meUAiffshn2qa7YFr4BBR/VvTRzbc7TtETJPbMr?=
 =?iso-8859-1?Q?NNFJ6gCOTgONuhJKAl9fr4eJplfUjG5xveEPx6Y+CZ07jL0QhV7UuU7XwG?=
 =?iso-8859-1?Q?BCvqWhleSrftkf7WS34n8nBHPq5mFrhyTS?=
MIME-Version: 1.0
X-OriginatorOrg: mathworks.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR05MB5571.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6517b9dc-986b-401e-78ec-08daa0272db2
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2022 01:25:35.6873
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 99dd3a11-4348-4468-9bdd-e5072b1dc1e6
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JeCQLaBhCq+XBjr6llUphCAadLSDXFzedkLDW8OA318APQbA/wnaD7iUHuFdhZoGcduaKKc1fqy7MTSo+a9OAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR05MB6796
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
> Sent: Monday, September 26, 2022 11:24 AM
> To: Eric DeCosta via GitGitGadget <gitgitgadget@gmail.com>
> Cc: git@vger.kernel.org; Jeff Hostetler <git@jeffhostetler.com>; Eric Sun=
shine
> <sunshine@sunshineco.com>; Torsten B=F6gershausen <tboegi@web.de>;
> Ramsay Jones <ramsay@ramsayjones.plus.com>; Johannes Schindelin
> <Johannes.Schindelin@gmx.de>; Eric DeCosta <edecosta@mathworks.com>
> Subject: Re: [PATCH v12 5/6] fsmonitor: check for compatability before
> communicating with fsmonitor
>=20
>=20
> On Sat, Sep 24 2022, Eric DeCosta via GitGitGadget wrote:
>=20
> > From: Eric DeCosta <edecosta@mathworks.com> [...] @@ -281,9 +283,11
> @@
> > char *fsm_settings__get_incompatible_msg(const struct repository *r,
> >  =09=09goto done;
> >
> >  =09case FSMONITOR_REASON_NOSOCKETS:
> > +=09=09socket_dir =3D dirname((char *)fsmonitor_ipc__get_path(r));
> >  =09=09strbuf_addf(&msg,
> > -=09=09=09    _("repository '%s' is incompatible with fsmonitor
> due to lack of Unix sockets"),
> > -=09=09=09    r->worktree);
> > +=09=09=09    _("socket directory '%s' is incompatible with
> fsmonitor due"
> > +=09=09=09=09  " to lack of Unix sockets support"),
> > +=09=09=09    socket_dir);
>=20
> Could do with less "while at it" here. We are:
>=20
>  * Wrapping the string, making the functional change(s) harder to spot.
>  * replacing r->worktree with socket_dir
>  * Adding " support" to the end of the string, and replacing "repository"=
 with
> "socket directory"
>=20
> AFAICT the continuation of the string isn't indented in the way we usuall=
y do,
> i.e. to align with the opening ".

The string, when properly indented, exceeds an 80 character line length. I'=
ll fix the indentation, but I don't think there's a much better alternative=
 to the wrapping.

The worktree could be in a perfectly fine location whereas the socket_dir m=
ay not . Crafting the error message the way I did reflects where the proble=
m is rather than reporting a potentially misleading error about the reposit=
ory.

-Eric

