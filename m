Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CBD6C433FE
	for <git@archiver.kernel.org>; Mon, 17 Oct 2022 21:30:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbiJQVag (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Oct 2022 17:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbiJQVae (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2022 17:30:34 -0400
Received: from us-smtp-delivery-120.mimecast.com (us-smtp-delivery-120.mimecast.com [170.10.129.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B6C760C5
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 14:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mathworks.com;
        s=mimecast20180117; t=1666042231;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=inhsJDn2Vxc0m5O3MeKDYdTgv00xa39WTLRuEL8Cm+4=;
        b=aAOswP3pkwunM+PtrUqAH7bKCPPcKJk37wyafdYpAzefdW+BtCy3TuyD52M4MNlHUITZ/w
        bAeHwp5Nx8qNrNO5781dUVg8S3jrHoeJ1cmq1huxTzLVGVZLh7AbkUAW2MZErYirwCwncd
        P2Xeib8zdA5UtC6SkeA73F1aAFRszCQ=
Received: from na01-obe.outbound.protection.outlook.com
 (mail-eastusazlp17010002.outbound.protection.outlook.com [40.93.11.2]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-231-4HdbZ-M9P7aMdKqy6CQMiA-1; Mon, 17 Oct 2022 17:30:29 -0400
X-MC-Unique: 4HdbZ-M9P7aMdKqy6CQMiA-1
Received: from BL0PR05MB5571.namprd05.prod.outlook.com (2603:10b6:208:2f::17)
 by MW4PR05MB8914.namprd05.prod.outlook.com (2603:10b6:303:132::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.14; Mon, 17 Oct
 2022 21:30:26 +0000
Received: from BL0PR05MB5571.namprd05.prod.outlook.com
 ([fe80::fde9:a6ac:96b0:a49]) by BL0PR05MB5571.namprd05.prod.outlook.com
 ([fe80::fde9:a6ac:96b0:a49%6]) with mapi id 15.20.5723.016; Mon, 17 Oct 2022
 21:30:26 +0000
From:   Eric DeCosta <edecosta@mathworks.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Eric DeCosta via GitGitGadget <gitgitgadget@gmail.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
Subject: RE: [PATCH v2 07/12] fsmonitor: prepare to share code between Mac OS
 and Linux
Thread-Topic: [PATCH v2 07/12] fsmonitor: prepare to share code between Mac OS
 and Linux
Thread-Index: AQHY4BZZKoPw/YR9fkalVxARDeMmoq4Ojix5gASPv5A=
Date:   Mon, 17 Oct 2022 21:30:26 +0000
Message-ID: <BL0PR05MB557147E13EFF24F664A14832D9299@BL0PR05MB5571.namprd05.prod.outlook.com>
References: <pull.1352.git.git.1665326258.gitgitgadget@gmail.com>
        <pull.1352.v2.git.git.1665783944.gitgitgadget@gmail.com>
        <295beb89ab10f001724fb64fa55944d05ee29fc7.1665783945.git.gitgitgadget@gmail.com>
 <xmqqmt9y55py.fsf@gitster.g>
In-Reply-To: <xmqqmt9y55py.fsf@gitster.g>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR05MB5571:EE_|MW4PR05MB8914:EE_
x-ms-office365-filtering-correlation-id: 84ed7bda-56c4-44b1-8573-08dab086cea3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: D4EY88sNvVOUrx9HLpWZVuO000K24FZneDgwcDHxwFHk0Sa8D8hPOn1QIF/u2mGuZsBPpAov+Sz2sZLQRHROiPCL9xlzmJbwMxMQVoUi3v54aFYyFq/mw/h7EqJLCQFV4gLaELoYEhAJx6CkGtmXWgAttcreRhRDyVRCQt6xk9lATIAwycknhoNFzGg2WzAhh0JTsKNIYFLW3M/a/AYq807kzC5zNs2K0/jM1QD2zJkChhMwvydvD1TbcJ7xwVhobtxb6KYjPFT9F5LoNJ2C+WgkZJfQ57ENQX/BvK28qfSdrlvAcYRFkyM5Mr+szoK6gEn/gJkgHlv1FsGPbHxhG0IJWanwwrRG0wTyEAE1jJJoGswnTLo3b9gGhn52lSjwOzWHVPsppy3MJonJ9ivI3jkE8k8H5uUeuKTaISUdp2LGLDoXqUmS/+EF0G2fPnmLjbYPOm/HgWxXpqXlsZarpMWOkH/mqJBpN77VYA7m4QOnSFhEcDw2YfCg7m777rUh7XfCFH+6kdcj5QWGPPHmjZQkIkQ9ycFGXZz9y1fyLaGHr97efnH/5Cpg5qngXzp56BX2e+4vd83Q+WMS2pIWndFIO1Rhixg14NLm+JZv00Ht62yMZRckN7qQ0S1K6e/5CgxlCTz82a44PZWfkXLbc9Dmj/R+oly4mQvUT34mcg1HspJrIAlw3aks0zM4w5bcCH2RDOfQita4aYP63P7a/l5KSB6e95b9UjqVY+QH8Ld3hFGc0hB0mCOna2C4KWFaNHtyBUQj7YVCwF6FeLgPuw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR05MB5571.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(39860400002)(136003)(376002)(346002)(451199015)(5660300002)(38070700005)(7696005)(6506007)(8936002)(2906002)(52536014)(26005)(41300700001)(53546011)(186003)(86362001)(38100700002)(33656002)(83380400001)(55016003)(122000001)(110136005)(54906003)(478600001)(66476007)(9686003)(76116006)(316002)(8676002)(4326008)(64756008)(66556008)(71200400001)(66446008)(66946007);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?jYV/bXID35sA2Br/KDlmChTe8CTImW/We7AUzULr/IQgDHPg3SKPK0tAgL?=
 =?iso-8859-1?Q?QHAo1IGiITucyO7kdcDJPq3y2CZjKcokIGRJXrunvudvTDPP0KQcklQBmS?=
 =?iso-8859-1?Q?etSCeFBa75j7yFT6iw37ceFxLpeAhUhjBodNC30N6EW+FAL5opDNQFlzvp?=
 =?iso-8859-1?Q?lCA/n3xQHO3yN7c+1seL99R8+6wbAoeopWAx+atKy2o17ZJT158hB29Zho?=
 =?iso-8859-1?Q?PWafwYukp6nbHNzbFNb8XSParoyTNDDA/tu9cfk3Eoy/jIIZgh6xwEZdls?=
 =?iso-8859-1?Q?UCZr0X6eqXnGi9oH+m0inILolmHja7Q+n4c9UF7WUoj4fzjSCnEcHwV7b7?=
 =?iso-8859-1?Q?6EPNW1QuB8LOTX7d8aaKkzTIvrk7jFffXRlaSs0KUeBQuzi8391PuvZ4wB?=
 =?iso-8859-1?Q?xMHZmWEKQNvUDYG3bAantqXuXogfVD7oBIPoDkDTui69wVrtYoof+DFtwu?=
 =?iso-8859-1?Q?qahZVP0rq7MJi0pJP0NxDJNQv6+tPnDGJhD8Iuqoz1/PJUZf+NZLPL1iI0?=
 =?iso-8859-1?Q?3abDa4Pghd6LD9ct4v44SYdv/3dbwbI6J7UwUmfMIuEwaGA1azBjdVdnS2?=
 =?iso-8859-1?Q?wqzLHICGC1bM46kgdfNb4ZFUWWK96vk+M2YEDYfdHP1sHIgnmlwOUpD3LV?=
 =?iso-8859-1?Q?KOWAsD0QsdNYNBe+D2E3hNX+53XI2J+riAOYx8AquZJNh6K5UqI9reOaK5?=
 =?iso-8859-1?Q?oWMgYGOfgnRAQgMthWm1uctGOwOXZEvgcSKt0W9Uhm5CXHLqvlnNHbKN9s?=
 =?iso-8859-1?Q?bzObUC2VaLRijhufU2Rwb09vLcQvLfP/Tdkt1wtOLUE1krEOymv9O70BHG?=
 =?iso-8859-1?Q?2qtIQ2J+lhohBjZktAh3UEJvVCzXgnPmQgg6LeFpu59InZw37KW4ZPNhIX?=
 =?iso-8859-1?Q?CsFyiThG8HjucBzjhhszj5BSmULnipOXQuIltlaVahZ92hkOMFXdOfm3Pp?=
 =?iso-8859-1?Q?2l4RNDAzqZhX4mmrCzCu9PjztEDx2Hf4IGwFv8RBW0uyX/i9YJesbd+kOB?=
 =?iso-8859-1?Q?8cxwLphxB1sXeS9f9M3km1S+6mt7sxcyHNh+dn6ydjcdTsvRWiijMOD4GU?=
 =?iso-8859-1?Q?yn+UNt4zvKMPTxcyns7aSenXeYDdzt7Qkci84Ss1hvxms+2RbOiM+7SV5H?=
 =?iso-8859-1?Q?kL2e+uZBsL2MIT7P9n64JJ6G0Dylvw/fLvcn/PTqXLIs0S+33Q6iXKtVCo?=
 =?iso-8859-1?Q?38V0wlmZR96yN4iLB8FSpcoc1/mb3vM7x7bfYZbfe6RzL8VvkSFjpGVJjU?=
 =?iso-8859-1?Q?1XvPuNeXKiq/YUIO/yTptqWAj9ZARBPn4lwXm5aCEUI2R4DL9PeB4SMZxl?=
 =?iso-8859-1?Q?JU+gjAfZZzei8ZqcYRZe8jSwj8Pmul5MBuhQs3JHflCdBiz8WtEG1oUTUd?=
 =?iso-8859-1?Q?VcCwyJtVBk/ze5ccXsead5y0BYIRbGmVFSQh1+QfA1rTmMkLBbZlcL5lsQ?=
 =?iso-8859-1?Q?EWP74xuRwvQoeEvQnn6/ZGtILGqO0hfc8XocE3q+35bjQzOY3Dgif/ebjW?=
 =?iso-8859-1?Q?FXnMuOI+9Tf/PK0urKs26PYTOsOS7rxbIAJodOYmDqV9SF4dhvz+tQTZ4c?=
 =?iso-8859-1?Q?vv+BvftM7JccCrPpDKXM5wHmRroGp8Hj3eFC7nfKCanC9r3VM8leTNuEVx?=
 =?iso-8859-1?Q?8tkhNjiZ5KW13jIoA6IWypzj6vBlJdfljv?=
MIME-Version: 1.0
X-OriginatorOrg: mathworks.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR05MB5571.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84ed7bda-56c4-44b1-8573-08dab086cea3
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2022 21:30:26.5119
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 99dd3a11-4348-4468-9bdd-e5072b1dc1e6
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2IlwIiUzJrwgSsYU+Wi9KvOXZWhLHbScHk6UxpQZhYpfVTpiwyThMPLFs95F+JADynbeThkCXBFlb6mEm5PEPA==
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
> Sent: Friday, October 14, 2022 7:46 PM
> To: Eric DeCosta via GitGitGadget <gitgitgadget@gmail.com>
> Cc: git@vger.kernel.org; Eric Sunshine <sunshine@sunshineco.com>; =C6var
> Arnfj=F6r=F0 Bjarmason <avarab@gmail.com>; Eric DeCosta
> <edecosta@mathworks.com>
> Subject: Re: [PATCH v2 07/12] fsmonitor: prepare to share code between
> Mac OS and Linux
>=20
> "Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com> writes:
>=20
> >  ifdef FSMONITOR_DAEMON_BACKEND
> >  =09COMPAT_CFLAGS +=3D -DHAVE_FSMONITOR_DAEMON_BACKEND
> > +=09ifdef FSMONITOR_DAEMON_COMMON
> > +=09=09COMPAT_OBJS +=3D compat/fsmonitor/fsm-ipc-
> $(FSMONITOR_DAEMON_COMMON).o
> > +=09else
> > +=09=09COMPAT_OBJS +=3D compat/fsmonitor/fsm-ipc-
> $(FSMONITOR_DAEMON_BACKEND).o
> > +=09endif
> >  =09COMPAT_OBJS +=3D compat/fsmonitor/fsm-listen-
> $(FSMONITOR_DAEMON_BACKEND).o
> >  =09COMPAT_OBJS +=3D compat/fsmonitor/fsm-health-
> $(FSMONITOR_DAEMON_BACKEND).o
> > -=09COMPAT_OBJS +=3D compat/fsmonitor/fsm-ipc-
> $(FSMONITOR_DAEMON_BACKEND).o
> >  endif
> >
> >  ifdef FSMONITOR_OS_SETTINGS
> >  =09COMPAT_CFLAGS +=3D -DHAVE_FSMONITOR_OS_SETTINGS
> > +=09ifdef FSMONITOR_DAEMON_COMMON
> > +=09=09COMPAT_OBJS +=3D compat/fsmonitor/fsm-settings-
> $(FSMONITOR_DAEMON_COMMON).o
> > +=09endif
> >  =09COMPAT_OBJS +=3D compat/fsmonitor/fsm-settings-
> $(FSMONITOR_OS_SETTINGS).o
> >  =09COMPAT_OBJS +=3D
> > compat/fsmonitor/fsm-path-utils-$(FSMONITOR_OS_SETTINGS).o
> >  endif
>=20
> Ugly.
>=20
> One overrides backend with common, while the other one doesn't.
> That asymmetry alone should stop us and wonder if there is something fish=
y
> in the approach that can be improved.  It makes it look like the word
> "common" means something quite different between the -ipc and the -
> settings world.
>=20
> I suspect that in both, you should not expose "unix" to this part of the
> Makefile.  Linux and macOS occasionally being similar in some places does
> not have to be exposed here.  INstead you can use backend "linux" and
> "macos", whose C sources may include from a separate C source file whose
> name may contain "unix".  That would allow you to get rid of
> FSMONITOR_DAEMON_COMMON in a cleaner way.

Let me see if I am understanding you correctly. Are you suggesting somethin=
g like:

ifdef FSMONITOR_DAEMON_BACKEND_LINUX
=09COMPAT_CFLAGS +=3D -DHAVE_FSMONITOR_DAEMON_BACKEND
=09COMPAT_OBJS +=3D compat/fsmonitor/fsm-ipc-unix.o
=09COMPAT_OBJS +=3D compat/fsmonitor/fsm-ipc-$(FSMONITOR_DAEMON_BACKEND_LIN=
UX).o
=09COMPAT_OBJS +=3D compat/fsmonitor/fsm-listen-$(FSMONITOR_DAEMON_BACKEND_=
LINUX).o
=09COMPAT_OBJS +=3D compat/fsmonitor/fsm-health-$(FSMONITOR_DAEMON_BACKEND_=
LINUX).o
endif

ifdef FSMONITOR_DAEMON_BACKEND_DARWIN
=09COMPAT_CFLAGS +=3D -DHAVE_FSMONITOR_DAEMON_BACKEND
=09COMPAT_OBJS +=3D compat/fsmonitor/fsm-ipc-unix.o
=09COMPAT_OBJS +=3D compat/fsmonitor/fsm-ipc-$(FSMONITOR_DAEMON_BACKEND_DAR=
WIN).o
=09COMPAT_OBJS +=3D compat/fsmonitor/fsm-listen-$(FSMONITOR_DAEMON_BACKEND_=
DARWIN).o
=09COMPAT_OBJS +=3D compat/fsmonitor/fsm-health-$(FSMONITOR_DAEMON_BACKEND_=
DARWIN).o
endif

And similarly for settings:

ifdef FSMONITOR_DAEMON_SETTINGS_LINUX
=09COMPAT_CFLAGS +=3D -DHAVE_FSMONITOR_OS_SETTINGS
=09COMPAT_OBJS +=3D compat/fsmonitor/fsm-settings-unix.o
=09COMPAT_OBJS +=3D compat/fsmonitor/fsm-settings-$(FSMONITOR_DAEMON_SETTIN=
GS_LINUX).o
=09COMPAT_OBJS +=3D compat/fsmonitor/fsm-path-utils-$(FSMONITOR_DAEMON_SETT=
INGS_LINUX).o
endif

ifdef FSMONITOR_DAEMON_SETTINGS_DARWIN
=09COMPAT_CFLAGS +=3D -DHAVE_FSMONITOR_OS_SETTINGS
=09COMPAT_OBJS +=3D compat/fsmonitor/fsm-settings-unix.o
=09COMPAT_OBJS +=3D compat/fsmonitor/fsm-settings-$(FSMONITOR_DAEMON_SETTIN=
GS_DARWIN).o
=09COMPAT_OBJS +=3D compat/fsmonitor/fsm-path-utils-$(FSMONITOR_DAEMON_SETT=
INGS_DARWIN).o
endif

And the rest of the platforms remain as was, with FSMONITOR_DAEMON_BACKEND =
and FSMONITOR_OS_SETTINGS

-Eric

