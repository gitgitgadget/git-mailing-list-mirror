Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8130B20281
	for <e@80x24.org>; Fri, 15 Sep 2017 17:21:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751363AbdIORVt (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Sep 2017 13:21:49 -0400
Received: from mail-bn3nam01on0097.outbound.protection.outlook.com ([104.47.33.97]:53573
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751234AbdIORVr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Sep 2017 13:21:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=KNWYbiZylMZpW1exvViqDIP4yDYgxKtuyQUt0J7rZDc=;
 b=gxT26iMsjFX875T50zrA9TkpjYsaleJkzfMbdqSBbu1PuJ0I9PI8sdtTrIEbGDkbwQ5jGa/Eu+utzAmSN29Fnv5pg9/SZCNezeWP0GshflWcsi9Lw/Slv/VygZlDr1zzrSd9y4fL+pJVqwNNn5fH4Xy0AsdS/7mxQOK3jUOKZxE=
Received: from SN1PR21MB0014.namprd21.prod.outlook.com (10.161.254.12) by
 SN1PR21MB0095.namprd21.prod.outlook.com (10.161.254.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.77.6; Fri, 15 Sep 2017 17:21:40 +0000
Received: from SN1PR21MB0014.namprd21.prod.outlook.com ([10.161.254.12]) by
 SN1PR21MB0014.namprd21.prod.outlook.com ([10.161.254.12]) with mapi id
 15.20.0077.007; Fri, 15 Sep 2017 17:21:39 +0000
From:   Kevin Willford <kewillf@microsoft.com>
To:     Junio C Hamano <gitster@pobox.com>
CC:     Jacob Keller <jacob.keller@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "peff@peff.net" <peff@peff.net>,
        "pclouds@gmail.com" <pclouds@gmail.com>
Subject: RE: [PATCH 1/1] reset: fix reset when using the sparse-checkout
 feature.
Thread-Topic: [PATCH 1/1] reset: fix reset when using the sparse-checkout
 feature.
Thread-Index: AQHTKMyCASx4J5FrG0SFSfVy0yz4a6KrWy30gAAJb7CAAH5jR4AAB2mQgAMpW3CAAHk5AIABF7AQgACzS9CAAIOfgIAAA+EwgAAxKACAAVoC0IABB+GwgAD698uAALhmUA==
Date:   Fri, 15 Sep 2017 17:21:39 +0000
Message-ID: <SN1PR21MB00145406332AC0133FDD89F7B76C0@SN1PR21MB0014.namprd21.prod.outlook.com>
References: <20170908180050.25188-1-kewillf@microsoft.com>
        <20170908180050.25188-2-kewillf@microsoft.com>
        <xmqqvaktxawk.fsf@gitster.mtv.corp.google.com>
        <SN1PR21MB0014638E5D9CBFD0D9D85F10B7950@SN1PR21MB0014.namprd21.prod.outlook.com>
        <xmqqr2vgy2yt.fsf@gitster.mtv.corp.google.com>
        <SN1PR21MB00140C84DC02F3491F4E8469B76A0@SN1PR21MB0014.namprd21.prod.outlook.com>
        <xmqqh8w951ek.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.21.1.1709111259430.4132@virtualbox>
        <xmqq4ls836z3.fsf@gitster.mtv.corp.google.com>
        <SN1PR21MB0014435A97BCDA324FD55B46B7690@SN1PR21MB0014.namprd21.prod.outlook.com>
        <CA+P7+xqxmxexWS=MWNd9=EqG81uhKY-OdG+1mpyWhst6DvH5AA@mail.gmail.com>
        <SN1PR21MB001473733DAF15BC91C0E58AB7690@SN1PR21MB0014.namprd21.prod.outlook.com>
        <CA+P7+xqcAh4v4gDQOm-feYGc1EmFztAu0zMg2xnp8Gn4=BzkoQ@mail.gmail.com>
        <xmqqy3piz1j4.fsf@gitster.mtv.corp.google.com>
        <SN1PR21MB0014031012AEC69CED27FADFB76F0@SN1PR21MB0014.namprd21.prod.outlook.com>
 <xmqqh8w4y2se.fsf@gitster.mtv.corp.google.com>
In-Reply-To: <xmqqh8w4y2se.fsf@gitster.mtv.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Ref=https://api.informationprotection.azure.com/api/72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=kewillf@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2017-09-15T11:21:38.5095179-06:00;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [174.126.250.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN1PR21MB0095;6:xT9zuaOx0Sm8F+iQVpvys/9QiVHTAOrScfqx1Xk0L1hFGVj1hMYyybMjbO3sMeh7cMPGZ8Ug9oG682T3C8aeqtGGiWV8oLvBnHRRgRhmQ5kK9ZypCOE06VXZNVKa/JcdG3yuC9LtH7CvTBAHGFhrAEmMczYaI951/iajTZjueVK9y68CmQtHfGXFFa+D0+2boaR04y4GyuXjNOTZ+ayMj0xe712etviKnsDW8GMXcNh167dRk3TQkbwAtlyt79uiop3WKAwtXPlJVv9Wti+iWJVc8ud+YfRcqINepfNwNA6PZZKuCSNfiC8MijA2Sk+jbSxAZbA+kPvTnQsgG6EJjA==;5:kmhw6nAlnReCdkk/BIU7SoE1MHvYUUVwJ2UuPVgw7iHT5qu/eoDNo42OKLK9kRfa1XWxdSnVyGbmoJRpoN7FT30b6m81aKj4A1DY4juqYcN1QRVimba7j07II7JsxCvCOwax7yv/Jje7sQ3f7T0MXg==;24:nJW5c6nwKPfisd6IkooKwP8TyLXiC9kyXvCrGpv76i8KVWnOUCs6xQPd6QQ9/3VGKUtWIgeCLbBFATsg0BiloxR3fN7fHVSkCZ6bksPa4JE=;7:ohGm2ZgwMYR1yCBeVDwZqxgIs4rj7ykSs6/zCiAcy100bJwRcFG0qHzb7B+8RT+h0XAFfxGt4WdkRyRI9z2P2TxLEzqhQwadfksflakuXuck4FvU6RtWjXzVvoTIkO/oAGa5wD4ZbwTpT05f4LKrPvEuymBh661mQ2WiHPOe3fR3WrnhkixH3LSGztd+iwlo9U0deAdrmXS8lpqfovfrCpPUu946OlT9chwBzzPncVs=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 2483c877-4094-4fa3-9145-08d4fc5e3a37
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(300000500095)(300135000095)(300000501095)(300135300095)(22001)(300000502095)(300135100095)(2017030254152)(300000503095)(300135400095)(48565401081)(2017052603199)(201703131423075)(201703031133081)(201702281549075)(300000504095)(300135200095)(300000505095)(300135600095)(300000506095)(300135500095);SRVR:SN1PR21MB0095;
x-ms-traffictypediagnostic: SN1PR21MB0095:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=kewillf@microsoft.com; 
x-exchange-antispam-report-test: UriScan:(89211679590171)(100324003535756)(17755550239193);
x-microsoft-antispam-prvs: <SN1PR21MB0095B25F6725E8A19DCD398AB76C0@SN1PR21MB0095.namprd21.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(61425038)(6040450)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(100000703101)(100105400095)(3002001)(6055026)(61426038)(61427038)(6041248)(20161123558100)(20161123555025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123560025)(20161123562025)(20161123564025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:SN1PR21MB0095;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:SN1PR21MB0095;
x-forefront-prvs: 0431F981D8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(6009001)(376002)(39860400002)(346002)(47760400005)(189002)(377454003)(199003)(54356999)(66066001)(229853002)(8656003)(316002)(76176999)(22452003)(6506006)(33656002)(77096006)(8666007)(8676002)(50986999)(6436002)(2950100002)(6916009)(10090500001)(8990500004)(5660300001)(10290500003)(7696004)(25786009)(93886005)(97736004)(106356001)(101416001)(189998001)(2900100001)(478600001)(53936002)(39060400002)(8936002)(14454004)(6246003)(3660700001)(110136004)(105586002)(3280700002)(86612001)(74316002)(305945005)(4326008)(81166006)(3846002)(102836003)(6116002)(55016002)(54906002)(68736007)(81156014)(9686003)(7736002)(2906002)(99286003)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:SN1PR21MB0095;H:SN1PR21MB0014.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2017 17:21:39.8365
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR21MB0095
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Junio C Hamano [mailto:gitster@pobox.com]
Sent: Thursday, September 14, 2017 11:00 PM
>=20
> Kevin Willford <kewillf@microsoft.com> writes:
>=20
> > 1. Does this statement, "I only care about the files in this
> > sparse checkout, and do not concern me with anything else", mean
> > that git should not change files outside the sparse-checkout whether
> > that be in the working directory or in the index?  Or does that only
> > apply to the working directory and the index version of files can
> > change to whatever git the git command would do without using
> > sparse?  For example if I am doing a 'git reset HEAD~1'  should the
> > version in the index of files outside the sparse not be changed or
> > change to the HEAD~1 version with the skip-worktree bit on?
>=20
> My understanding of the purpose of "sparse checkout" thing is that
> the user still wants to create correct whole-tree commit even the
> user does not have the whole-tree checkout.  The object names for
> blobs recorded in the index that are meant to be included in the
> next commit MUST be the same as those that would be in the index
> when the "sparse" feature is not in use.  "reset HEAD~1" should
> match the index entries to the tree entries in HEAD~1.  So, the
> latter, I would think, among your two alternatives.
>=20
> IOW, after "git reset HEAD~", if you drop the skip-worktree bit from
> all index entries, "git diff --cached HEAD" must say "there is no
> changes".
>=20
> The only difference between the "sparse" and normal would be that,
> because the "sparse" user does not intend to change anything outside
> the "sparse" area, these paths outside her "sparse" area would not
> materialize on the filesystem.  For the next "write-tree" out of the
> index to still write the correct tree out, the entries outside her
> "sparse" area in the index MUST match the tree of the commit she
> started working from.
>=20

Makes sense.  And even though the reset might only change entries
outside the sparse area and the next status will report "nothing to commit,
working tree clean",  that's okay because the user hasn't changed
anything in their sparse area and intended to roll back the index to
whatever they specified in their reset command.

> > 2. How will this work with other git commands like merge, rebase,
> > cherry-pick, etc.?
> > 3. What about when there is a merge conflict with a file that is outsid=
e
> > the sparse checkout?
>=20
> I would say, rather than forbidding such a merge, it should let her
> see and deal with the conflict by dropping the "this is outside the
> sparse area, so do not bother materializing it to the filesystem"
> bit, but tell her loudly what it did ("I checked out a half-merged
> file outside your sparse-checkout area because you'd need it while
> resolving the conflict").  By doing things that way, the user can
> decide if she wants to go ahead and complete the merge, even if the
> conflict is outside the area she is currently interested in, or
> postpone the merge and continue working on what she has been working
> on inside the narrowed-down area first.
>=20
> I do not have a strong opinion whether the sparse-checkout
> configuration file should be adjusted to match when the command must
> tentatively bust the sparse checkout area; I'd imagine it can be
> argued either way.
>=20
> Note that "sparse" is not my itch, and I would not be surprised if
> those who designed it may want it to work differently from my
> knee-jerk reaction in the previous two paragraphs, and I may even
> find such an alternative solution preferable.
>=20
> But it is highly unlikely for any sensible solution would violate
> the basic premise, i.e. "the indexed contents will stay the same as
> the case without any 'sparse', so the next write-tree will do the
> right thing".

There was one other case that I thought about while implementing
this approach and it is when the user creates a file that is outside their
sparse definition.  From your explanation above I will attempt to
explain how I think it should work and please correct me if you see
it working differently.

The user creates a file that is outside the sparse area and it will show
up as untracked.  No problem here since the untracked are outside the
scope of using sparse.  Next the user adds the untracked file to the index.
The skip-worktree bit should be off and stay off since the user could make
additional changes and want to add them.  Once the user commits the
newly created file, I could see turning on the skip-worktree bit and
removing the file from the working tree after the commit but since
this was a user initiated action and it is sparse "checkout" it makes
sense to wait until the next "checkout" command which will use the
sparse definition to clean this file from the working directory and
turn on the skip-worktree flag.  If the user wants to continue to use
the new file, they would need to update their sparse-checkout file
to include the newly created file so that the next checkout will not
remove it and turn on the flag.
