Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E283C6FA82
	for <git@archiver.kernel.org>; Mon, 12 Sep 2022 19:36:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbiILTgA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Sep 2022 15:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiILTf7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Sep 2022 15:35:59 -0400
Received: from us-smtp-delivery-120.mimecast.com (us-smtp-delivery-120.mimecast.com [170.10.129.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF6A643E5A
        for <git@vger.kernel.org>; Mon, 12 Sep 2022 12:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mathworks.com;
        s=mimecast20180117; t=1663011356;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ecfu0ZWdqNVwMWaco/OiVJ5zfifW0+wd7SwPGb5ylF4=;
        b=ilIvC9h04hE3WBTUFCJ8s7iSlfRlhykJgw4pVRq4E/xaNga7PA8LWf7jNxdhxHicvRXeEu
        LZnSQYslz5bvdzObBy+4l+QvriQRGqOtslwHjtfJgMMy0cknE8yicUZyeihPQjoP173TBB
        2hlYp2ZPRiShLAIygVyXfZyyejIrHAw=
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-651-402uHKX9PRiUVb23DFBy8A-1; Mon, 12 Sep 2022 15:35:54 -0400
X-MC-Unique: 402uHKX9PRiUVb23DFBy8A-1
Received: from BL0PR05MB5571.namprd05.prod.outlook.com (2603:10b6:208:2f::17)
 by DM6PR05MB5193.namprd05.prod.outlook.com (2603:10b6:5:7c::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.12; Mon, 12 Sep
 2022 19:35:47 +0000
Received: from BL0PR05MB5571.namprd05.prod.outlook.com
 ([fe80::86c9:5cc7:6693:d9f7]) by BL0PR05MB5571.namprd05.prod.outlook.com
 ([fe80::86c9:5cc7:6693:d9f7%6]) with mapi id 15.20.5632.011; Mon, 12 Sep 2022
 19:35:47 +0000
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
Thread-Index: AQHYxVABuJRuWLHEVEGz/Q5e4Ag7LK3b8A7jgABA0TA=
Date:   Mon, 12 Sep 2022 19:35:47 +0000
Message-ID: <BL0PR05MB55719667F736618C49B00EBFD9449@BL0PR05MB5571.namprd05.prod.outlook.com>
References: <pull.1326.v4.git.1661962145.gitgitgadget@gmail.com>
        <pull.1326.v5.git.1662840031.gitgitgadget@gmail.com>
 <xmqqa674hagf.fsf@gitster.g>
In-Reply-To: <xmqqa674hagf.fsf@gitster.g>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR05MB5571:EE_|DM6PR05MB5193:EE_
x-ms-office365-filtering-correlation-id: 01cea3f0-2a20-4327-2a31-08da94f5fdf3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: ydIqrx7aGLTYbYE7JUxckbk5MqAevakkt3REVdNfyhLR4hUbvezBb4P0oaA+ch1v8DgAlB+AA31VeT7vqVY7XVeaWGs6Gm90HiW21d4Yh2W77qzIUN+WeCQJbtK2+IjEUudpuuLvJWxTrPKhQ6yYkOC9HnYHNTVUKInShcWuOhlO772Fm3L8NArZIkheoSMAOw8LENlvp/VF5/v8r0cWsrfXJkQfBTxCBn+MQZbb1pJzt5H6CYvflLV0FgShe5gpM1fdtCU4j5+jCrDfmrdXSK2wE3vFx15wEuCw83Imi+xJPvmKtKgrF+WUam5OOSFkIBgQ4aDQVy+M2ChYsxNtHmvogylusUPHqEsU5RqexmJXLc7oJfawuNL5FDG3PILWtcZ5x6ZDHJbP/gCErQ4EZCDIndGlZtMb8u7ApyBJ0myXprYgJGOJ6XqEZD4guYcpKDRKxydKWvvNH5Jy6LvYhQrpRJxE5Q0ijLmVzibIGRfkeveW2Fa0edd6bTWmpNc+j/5wUqVnHSZHIMZPRWK9By77QqfyARIJM9p7XcT/W6qUGXSqUxMAezRQtdCVRrAwQiUQ0EGl7gcModFkboMWi3oCjtiWN03WqSSQ37oitWO2ErNxU1xsVDI8kfsPKs1tWAs/G9JBZbgi15IOBbEoDSA7M/NGKT4edguSSvaqK8bmkvPZBwSILO8fc1kfdlF9GKXKtn2mEwMu7EOqnctNoUoEwGN33o1K+/SpNx3gfMZpIH279CPHC5Nq/hAShOfek8QLQ9/vD2THLmrfcfaVBw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR05MB5571.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(136003)(376002)(366004)(39860400002)(84040400005)(451199015)(54906003)(86362001)(316002)(41300700001)(186003)(83380400001)(33656002)(76116006)(122000001)(55016003)(38100700002)(38070700005)(110136005)(2906002)(4326008)(8936002)(52536014)(6506007)(66946007)(71200400001)(66446008)(66476007)(8676002)(64756008)(66556008)(26005)(9686003)(478600001)(7696005)(53546011)(5660300002);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?DOmyAcKkE1d3thmaDsymmqJZbFK4wV38kC7tG0sRLPGhbZa/VBvVL0ZZtJ?=
 =?iso-8859-1?Q?HLZXXs6i8RTl6DDNQw0MIBkTgYbRPkwnmHgNg5jx33+ezIWkn/bR2jMEV2?=
 =?iso-8859-1?Q?TMwVCjn2t2fQNMkNL3DY/Z7w31/QMzj8rXeqN8Tny2wrJki8SC9G+zx73l?=
 =?iso-8859-1?Q?PJvsVd0w0QQwaWsqWFLiq/x7hid5YRBNGseDx0aIH8oZeQcVyGLQtRkoln?=
 =?iso-8859-1?Q?+XZpng1WPxfx1/jkEgP866z1ZpmLLVSBTgn9rw4O3TfKas5tMI7qLFSUyJ?=
 =?iso-8859-1?Q?tuelKYwZlqAah7bapB/TdRF5DxmpO4SRQf7tHjXhWS/45C6cmwEchNpqcx?=
 =?iso-8859-1?Q?zX6ggg6aWPy+NrZaEc9dBRPt/EyOJfBW2ZvesfkpWcnojMVCbXlAB9E7dF?=
 =?iso-8859-1?Q?uCykXqKz+KhBgANohp1kcyZpFomJSkxTYOhgJpMmkuDVV2slb7wgmtT7fC?=
 =?iso-8859-1?Q?Ho1HVYxq8XhfNF+p+2uqMpILgzXZMBCg6IqPFJ/tB0tDCvF0vynugHucLL?=
 =?iso-8859-1?Q?jIKzBcMhKtK1sxwlc3vsnn4d2EXwJLcSo5nmFuzWMGuPAr2yDVUOqgYYq6?=
 =?iso-8859-1?Q?6bAAowYOec5aGVyR+xl0/Np+FgbLrshQ6Xhb9UDkt3j9NqnmRTDD1ajZ+7?=
 =?iso-8859-1?Q?Q6GCLWiiHeTcw4DuxVMbXtXx8jeVgaaFBBU9gsEmUDK/0O8XXTDvajR9U5?=
 =?iso-8859-1?Q?grdPPrcMQdRzXAY4foF7lg49y9KuEC/TwWKF5ho1Stl3GGspaYK/Ai+lys?=
 =?iso-8859-1?Q?NWlx4vgS4kkfmiJwD6BlQh5HeNRYgo1sUQr+pqhHt6XrbJ/LlGpRBFYRK8?=
 =?iso-8859-1?Q?xPy62mOEinmIoBD6KurMkTe2Vfxa1jHjgOi/PF/xlEFhhmj0ZAborG7sPm?=
 =?iso-8859-1?Q?koKaYPwybSdGERh+CwsKt0hAjUqCg2tVLjDmGXaE4qDeRXIB8/Zs4452ib?=
 =?iso-8859-1?Q?Fk9/BkTBTVOHcGtYJVTolWV3AhnbjMoq9Djn+0VvMO0/n1hhO6j7QZNDCC?=
 =?iso-8859-1?Q?qQfVM0iRqCE/WOzKNkIfqdp2QZjSfFEKVBSDFPXN5d6fgJ80n91DVZZW/C?=
 =?iso-8859-1?Q?isij26hLiC9j7KbloJTvNCMQfTpU6/AcaJbHb3ZLNECZWiYtvP/I8q/ShF?=
 =?iso-8859-1?Q?g6d0mukP50Y6y9L+xmQhaXKlHvw62vVAVDkcEV1UxBvhpw6Sib6C9H72Qr?=
 =?iso-8859-1?Q?/qFbz7jyEWrE73b++Uo1kBbU/+byD5JyBuwK8IRTkcnjXEgngIG5Ae38+f?=
 =?iso-8859-1?Q?vro7uzkPaUmTv6kDZZXgB07YZmculGNmls7Zme8XpXWF+wfUdZ2Sq72ldf?=
 =?iso-8859-1?Q?d8dQXxi+XVa2/WVDU+OCW0tSr6sTMKOSRK/e7rH8QAqR8hdN/mQ8VH1ip/?=
 =?iso-8859-1?Q?yWtPEAmUDfslvhddNxHMRz0zvAiZlBdx8MmG7M98A6c1YVj4Ng3J/eyr8n?=
 =?iso-8859-1?Q?IZZg59A2o20qBILd9B4APz4NDiNrbVhIzHQVXMlbtR2AFkyA4DMME6vvxY?=
 =?iso-8859-1?Q?2IGdmM2eZ1CrViIaTedYveRUemhuYGL6rqSRU7yIjCcePPLNjqDg5SauMf?=
 =?iso-8859-1?Q?GET4EwL/A/wFGy32fJmNqrFjos0v6GmfDawpwQ2DjltbRxTXZbK+lgaZGS?=
 =?iso-8859-1?Q?47eqD0e1Vq7hYVTlhLipPmzDY7S0ZOmOC2?=
MIME-Version: 1.0
X-OriginatorOrg: mathworks.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR05MB5193
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
> Sent: Monday, September 12, 2022 11:36 AM
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
> "Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com> writes:
>=20
> > Eric DeCosta (4):
> >   fsmonitor: refactor filesystem checks to common interface
> >   fsmonitor: relocate socket file if .git directory is remote
> >   fsmonitor: avoid socket location check if using hook
> >   fsmonitor: deal with synthetic firmlinks on macOS
> >
> >  Makefile                                 |   2 +
> >  builtin/fsmonitor--daemon.c              |   8 ++
> >  compat/fsmonitor/fsm-ipc-darwin.c        |  46 ++++++++
> >  compat/fsmonitor/fsm-ipc-win32.c         |   4 +
> >  compat/fsmonitor/fsm-listen-darwin.c     |   6 +-
> >  compat/fsmonitor/fsm-path-utils-darwin.c | 131
> > +++++++++++++++++++++++  compat/fsmonitor/fsm-path-utils-win32.c  |
> 106 ++++++++++++++++++
> >  compat/fsmonitor/fsm-settings-darwin.c   |  70 ++++--------
> >  compat/fsmonitor/fsm-settings-win32.c    | 106 +-----------------
> >  contrib/buildsystems/CMakeLists.txt      |   4 +
> >  fsmonitor--daemon.h                      |   6 ++
> >  fsmonitor-ipc.c                          |   2 -
> >  fsmonitor-path-utils.h                   |  49 +++++++++
> >  fsmonitor-settings.c                     |  58 +++++++++-
> >  fsmonitor-settings.h                     |   2 +-
> >  15 files changed, 441 insertions(+), 159 deletions(-)  create mode
> > 100644 compat/fsmonitor/fsm-ipc-darwin.c  create mode 100644
> > compat/fsmonitor/fsm-ipc-win32.c  create mode 100644
> > compat/fsmonitor/fsm-path-utils-darwin.c
> >  create mode 100644 compat/fsmonitor/fsm-path-utils-win32.c
> >  create mode 100644 fsmonitor-path-utils.h
> >
> >
> > base-commit: be1a02a17ede4082a86dfbfee0f54f345e8b43ac
>=20
> Another curious thing I need your help on.
>=20
> The cover letter says that this work is a follow-up to extend the previou=
s
> work for Windows, and I would have expected these patches to build on
> 85dc0da6 (fsmonitor: option to allow fsmonitor to run against network-
> mounted repos, 2022-08-11), which is not yet in
> be1a02a1 (The seventeenth batch, 2022-09-01).
>=20
> What is going on?
>=20
> Thanks.

I've been rolling that around in the back of my head over the last couple o=
f days
actually.  Initially I though the macOS changes were going to be independen=
t of
my earlier changes, but with all the refactoring that has occurred, that is=
 no
longer the case. I've rebased my current patch set on top of those earlier =
changes.
v6 will incorporate that, the review feedback that I've received so far and=
 add doc
for the new config options. I'll be sure to note all of this in the cover l=
etter for v6.

-Eric

