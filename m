Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 213FD1FADE
	for <e@80x24.org>; Fri,  8 Sep 2017 20:08:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756937AbdIHUIH (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Sep 2017 16:08:07 -0400
Received: from mail-by2nam01on0128.outbound.protection.outlook.com ([104.47.34.128]:61760
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756832AbdIHUIG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Sep 2017 16:08:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=qCxTshOkCxt+tYf6vORKFcEvHWrE2uIHRLabwQvLT+4=;
 b=P1ywo7cgK6WjfDDdkFpTaoG5nGuNqQ5AihqLrhReV5T8dNd5YzOA/DnlEYv01tTs4wGP49l385sGlUN4pH9xu4+1bQmAJZnA+9moPc7oHJsEHYmufDbk3vx2zRADITiju59bTeNLoa//0Ers64fgUHp1Ff2KDIkyign6vH6L9f8=
Received: from SN1PR21MB0014.namprd21.prod.outlook.com (10.161.254.12) by
 SN1PR21MB0031.namprd21.prod.outlook.com (10.161.254.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.56.7; Fri, 8 Sep 2017 20:08:04 +0000
Received: from SN1PR21MB0014.namprd21.prod.outlook.com ([10.161.254.12]) by
 SN1PR21MB0014.namprd21.prod.outlook.com ([10.161.254.12]) with mapi id
 15.20.0056.003; Fri, 8 Sep 2017 20:08:03 +0000
From:   Kevin Willford <kewillf@microsoft.com>
To:     Junio C Hamano <gitster@pobox.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "peff@peff.net" <peff@peff.net>,
        "pclouds@gmail.com" <pclouds@gmail.com>
Subject: RE: [PATCH 1/1] reset: fix reset when using the sparse-checkout
 feature.
Thread-Topic: [PATCH 1/1] reset: fix reset when using the sparse-checkout
 feature.
Thread-Index: AQHTKMyCASx4J5FrG0SFSfVy0yz4a6KrWDm/gAAQtHA=
Date:   Fri, 8 Sep 2017 20:08:03 +0000
Message-ID: <SN1PR21MB0014A3A5B8DFE3D353135184B7950@SN1PR21MB0014.namprd21.prod.outlook.com>
References: <20170908180050.25188-1-kewillf@microsoft.com>
        <20170908180050.25188-2-kewillf@microsoft.com>
 <xmqq4lsdypym.fsf@gitster.mtv.corp.google.com>
In-Reply-To: <xmqq4lsdypym.fsf@gitster.mtv.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Ref=https://api.informationprotection.azure.com/api/72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=kewillf@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2017-09-08T14:08:02.5133492-06:00;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [174.126.250.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN1PR21MB0031;6:BpXTMH9mxU10XF+XItBADOU/rf00peE1xk4CsOjXFkuaC85+Qdizfqg6HDtElZszkbwQSxeIGCyTP9sBtp3S+16b/vw0dWTi6tzbtPAcC6HQZpkyGxhkRAdL25KT9szDtqAsHqLy7fu50zNAZrxpWguxO3hZj+BPH8f5txcYvWa7zYRGknwaBf8a4zMCCASzETnvJCvTRT69Y3oODa7tZVRX9e3RxWNNpg1+XeBqtSkhVKOrfAi3ejAlTyQ8wdm7dgvN2Vx9YaCY0OoiSNWGp38vr0XhNEoCgPshgaHNimWOUH4RRDMqu4j9sjEjgSHUiilUlpmGJWxtaAxV05hDDw==;5:NUaDOj2tW7IowQg2C0eo5N6iy/xr3CwguJHL0J7RvKPXkDxkTjLrwHDL8KMf6kk2PYx2aJyAEucW97Mvpem5KMmTs8tjguqpSJdBRV6OIFXCD7pAXJ8xrv0KAEhopwgZO6yiyqG4kYDkYUNVKByZ7KHcJwjjPhXB7TNB1giLbvE=;24:QZ0ysvZeO4COgEqMyp5/jTvsDHSB1C85SFWargJ3+Gzx4LJkTWz0kQzp+Od5aMKAOvOQl01VN0AQc2BYqYT9B7C+JTkpVF3BlUNz4pWBJCQ=;7:GRKtaw5NFvCK5G6YTXe3I2BEXqYRpwBDFygktEA1b8LNOh+Yo78wqt3BhBQFh3PNxWeRo2xfWWUL/XlwOWhfdkFOAu3cUUXL1LcW7pUIL7VqeCP30cpofjWWvGTDUUnU3zy5//8y2vCAcj3aTqqK36My0xXYZKC7hQpGT0A861CWVex10BFU8718rI6B5eEKaXJhGUTcUHwMVYcZ+iehBWtG3zoSGLVpg5ynq4O3fBI=
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-correlation-id: 47320d89-15f9-40b9-7576-08d4f6f5503b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(300000500095)(300135000095)(300000501095)(300135300095)(22001)(300000502095)(300135100095)(2017030254152)(48565401081)(300000503095)(300135400095)(2017052603199)(201703131423075)(201703031133081)(201702281549075)(300000504095)(300135200095)(300000505095)(300135600095)(300000506095)(300135500095);SRVR:SN1PR21MB0031;
x-ms-traffictypediagnostic: SN1PR21MB0031:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=kewillf@microsoft.com; 
x-exchange-antispam-report-test: UriScan:(89211679590171)(100324003535756);
x-microsoft-antispam-prvs: <SN1PR21MB00313D424F6F82019E044CCBB7950@SN1PR21MB0031.namprd21.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(61425038)(6040450)(2401047)(8121501046)(5005006)(100000703101)(100105400095)(10201501046)(93006095)(93001095)(3002001)(6055026)(61426038)(61427038)(6041248)(20161123562025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123558100)(20161123560025)(20161123564025)(20161123555025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:SN1PR21MB0031;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:SN1PR21MB0031;
x-forefront-prvs: 04244E0DC5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(6009001)(39860400002)(47760400005)(377454003)(199003)(189002)(101416001)(76176999)(54356999)(6506006)(6246003)(189998001)(4326008)(106356001)(10090500001)(110136004)(8676002)(81156014)(81166006)(39060400002)(8936002)(33656002)(105586002)(66066001)(25786009)(102836003)(6116002)(2906002)(74316002)(3846002)(3660700001)(6436002)(50986999)(3280700002)(8990500004)(99286003)(53936002)(54906002)(2900100001)(55016002)(9686003)(10290500003)(7696004)(5660300001)(478600001)(8656003)(77096006)(305945005)(68736007)(229853002)(7736002)(97736004)(2950100002)(86612001)(14454004)(86362001)(22452003)(6916009);DIR:OUT;SFP:1102;SCL:1;SRVR:SN1PR21MB0031;H:SN1PR21MB0014.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2017 20:08:03.8483
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR21MB0031
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Junio C Hamano [mailto:gitster@pobox.com]
Sent: Friday, September 8, 2017 1:02 PM
> Kevin Willford <kewillf@microsoft.com> writes:
>=20
> > diff --git a/builtin/reset.c b/builtin/reset.c
> > index d72c7d1c96..1b8bb45989 100644
> > --- a/builtin/reset.c
> > +++ b/builtin/reset.c
> > @@ -24,6 +24,7 @@
> >  #include "cache-tree.h"
> >  #include "submodule.h"
> >  #include "submodule-config.h"
> > +#include "dir.h"
> >
> >  static const char * const git_reset_usage[] =3D {
> >  	N_("git reset [--mixed | --soft | --hard | --merge | --keep] [-q]
> [<commit>]"),
> > @@ -124,8 +125,32 @@ static void update_index_from_diff(struct
> diff_queue_struct *q,
> >
> >  	for (i =3D 0; i < q->nr; i++) {
> >  		struct diff_filespec *one =3D q->queue[i]->one;
> > +		struct diff_filespec *two =3D q->queue[i]->two;
> > +		int pos;
> >  		int is_missing =3D !(one->mode && !is_null_oid(&one->oid));
> > +		int was_missing =3D !two->mode && is_null_oid(&two->oid);
> >  		struct cache_entry *ce;
> > +		struct cache_entry *ceBefore;
> > +		struct checkout state =3D CHECKOUT_INIT;
>=20
> The five new variables are only used in the new block, so it
> probably is better to limit their scope to the "we do something
> unusual when sparse checkout is in effect" block as well.  The scope
> for the latter two can further be narrowed down to "we do need to
> force a checkout of this entry" block.
>=20
> We prefer to name our variables with underscore (e.g. ce_before)
> over camelCase (e.g. ceBefore) unless there is a compelling reason
> (e.g. a platform specific code in compat/ layer to match platform
> convention).
>=20

Will update.

> > +
> > +		if (core_apply_sparse_checkout && !file_exists(two->path)) {
> > +			pos =3D cache_name_pos(two->path, strlen(two->path));
> > +			if ((pos >=3D 0 && ce_skip_worktree(active_cache[pos]))
> &&
> > +			    (is_missing || !was_missing))
> > +			{
> > +				state.force =3D 1;
> > +				state.refresh_cache =3D 1;
> > +				state.istate =3D &the_index;
> > +				ceBefore =3D make_cache_entry(two->mode,
> > +							    two->oid.hash,
> > +							    two->path, 0, 0);
> > +				if (!ceBefore)
> > +					die(_("make_cache_entry failed for path
> '%s'"),
> > +						two->path);
> > +
> > +				checkout_entry(ceBefore, &state, NULL);
> > +			}
> > +		}
>=20
> Can we tell between the case where the reason why the path was not
> there in the working tree was due to the path being excluded by the
> sparse checkout and the path being removed manually by the end user?
>=20
> I guess ce_skip_worktree() check is sufficient; we force checkout only
> when the path is marked to be skipped due to "sparse" thing.
>=20
> Do we have to worry about the reverse case, in which file_exists(two->pat=
h)
> is true (i.e. the user created a file there manually) even though
> the path is marked to be skipped due to "sparse" setting?
>=20

I don't believe so because if the user has a file there whether they modifi=
ed
it or not, it is what the user did and we just leave it there and a diff wi=
th
what the index gets reset to will show how the file is different from what =
the
index got reset to.

> Other than that, the patch looks quite cleanly done and well explained.
>=20
> Thanks.
>=20
