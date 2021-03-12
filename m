Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37062C433DB
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 15:38:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D2356023C
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 15:38:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231808AbhCLPiK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Mar 2021 10:38:10 -0500
Received: from smtppost.atos.net ([193.56.114.177]:23175 "EHLO
        smarthost4.atos.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S232065AbhCLPiD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Mar 2021 10:38:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=atos.net; i=@atos.net; q=dns/txt; s=mail;
  t=1615563483; x=1647099483;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TYZUP7/9YF0w6aJSqNr5GuW7uIk1vMGKPwoATyebhiQ=;
  b=TZ65DcsVp/6nKQNWg6YVmf8Lz/6wmRzhm22nHGw8ZpxsnZXnyS67oY/j
   2vyz2ZS86tazKMT3blAl1oCDZduuAuUWiHl9p6BlvcjZYnYCqsAouM4fE
   yiuDBB5Zy0KNi/yH+lu+LwT2W4289HYUYYrmF2wCYryGGsBA+9phspcrj
   Q=;
X-IronPort-AV: E=Sophos;i="5.81,243,1610406000"; 
   d="scan'208";a="181208048"
X-MGA-submission: =?us-ascii?q?MDE/KX1LMnetXuVVOc8BkNDGkny8slaFPwUdaX?=
 =?us-ascii?q?qaohPtTl90Xoy2AU7C9Ok+Nn4XwBqP02VOINc875vomgooudORp6obKm?=
 =?us-ascii?q?WcDNxPdVye8Vy+pf3o1lg3QJIaV7F8308Cjd/Ib1VlRIEI/xUPHppBwY?=
 =?us-ascii?q?6D?=
Received: from mail.sis.atos.net (HELO GITEXCPRDMB24.ww931.my-it-solutions.net) ([10.89.29.134])
  by smarthost4.atos.net with ESMTP/TLS/AES256-GCM-SHA384; 12 Mar 2021 16:38:00 +0100
Received: from GITEXCPRDMB24.ww931.my-it-solutions.net (10.89.29.134) by
 GITEXCPRDMB24.ww931.my-it-solutions.net (10.89.29.134) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 12 Mar 2021 16:38:00 +0100
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (172.16.214.170)
 by GITEXCPRDMB24.ww931.my-it-solutions.net (10.89.29.134) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2 via Frontend Transport; Fri, 12 Mar 2021 16:38:00 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FFmlbjSRexFKJklqXO5RgArP93eUCAHTfzQ7Jjz/m9HeL87A/yVWiU3WtNz8U4hzXEZX7rnLELM1Mw1JJuD+wL9fGGIRyfoi7hD8o3rZWzX92yLq0W3JpQAQDMZ2RqJ7bR+zkRf3HntXIIbAKNfj5LbqEU9dcjkpRgMMM3tZG9/XakHOelLrxnSlx05Gy9+43wWpGMAljCwcZvtnjs7GjWvsdRiICy2Tu23eP+YfKSu+tcHCCeQnFztwlCjJXibclfDs1NV68KsxDqaq+ydt2UBe+Nypt2UdhtDqMqrLQPsNACm97/H6yO/0WTnNo2NRGlCik9LV45z2i/aikH8x4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TYZUP7/9YF0w6aJSqNr5GuW7uIk1vMGKPwoATyebhiQ=;
 b=iICzVwAAn//zh9eht1RS8ludyJ9AhbWFORlzeZE0Zav3ZlvcsFrbzosLetEAm5JCpiNhGHvcxKzlcAC5UbeUnif/NYeLuB2+e3mlnZJJj426rm35wA07PEqWCMioQ94Mak1lwEjy+P17JWGhetU9uT3S06BedLH5ar4arrCRQuanAt9cBuzv1Z6YNkPfYGYpL2v1Anwto3qWf8cDvqxCHtfG+hEETR3nmc81jDMTEUYvcRA4r45IVBj6hRCgMLzEMlyXRvv+ttR+JiXMLZIUqu4ZrMYDd2/Bmaf2qSQCo3uW/7LZWA2E8m5Q+dHKrSya4/01pndh90tcQznL+5kq4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atos.net; dmarc=pass action=none header.from=atos.net;
 dkim=pass header.d=atos.net; arc=none
Received: from AM0PR02MB4081.eurprd02.prod.outlook.com (2603:10a6:208:df::14)
 by AM0PR0202MB3364.eurprd02.prod.outlook.com (2603:10a6:208:e::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Fri, 12 Mar
 2021 15:37:59 +0000
Received: from AM0PR02MB4081.eurprd02.prod.outlook.com
 ([fe80::c90:7c15:8f0a:c9ec]) by AM0PR02MB4081.eurprd02.prod.outlook.com
 ([fe80::c90:7c15:8f0a:c9ec%7]) with mapi id 15.20.3912.030; Fri, 12 Mar 2021
 15:37:59 +0000
From:   "Kerry, Richard" <richard.kerry@atos.net>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: RE: Can I Insert some Ancient History into a repo?
Thread-Topic: Can I Insert some Ancient History into a repo?
Thread-Index: AdbImLDW4svDywGtR/ak5dzepEH+WAAKho6AE5z28mA=
Date:   Fri, 12 Mar 2021 15:37:59 +0000
Message-ID: <AM0PR02MB4081BAED92DBEC1F3E33B2059C6F9@AM0PR02MB4081.eurprd02.prod.outlook.com>
References: <AM0PR02MB40811C5C2E8B13B63D06E4B49CF30@AM0PR02MB4081.eurprd02.prod.outlook.com>
 <87o8jcus0m.fsf@evledraar.gmail.com>
In-Reply-To: <87o8jcus0m.fsf@evledraar.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_Enabled=True;MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_SiteId=33440fc6-b7c7-412c-bb73-0e70b0198d5a;MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_SetDate=2021-03-12T15:37:58.935Z;MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_Name=Atos
 For Internal Use - All
 Employees;MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_ContentBits=0;MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_Method=Standard;
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=atos.net;
x-originating-ip: [212.56.108.147]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d9b5c507-2b91-4185-1636-08d8e56cd0dd
x-ms-traffictypediagnostic: AM0PR0202MB3364:
x-microsoft-antispam-prvs: <AM0PR0202MB3364834A50F332B102B9F9179C6F9@AM0PR0202MB3364.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hqdTHqc8By0uIO+gZm4iLSAnb/Lj9VLpc88/ysy0V1hTBLxM7dPDdlJ2WyCFxDgSExqWSdEUJSxmILDu2dcExBm9UEKWb+9u49C875y7RtSmNsG3/WKUkV42j0159I82Z/mW0D/dG1f49Vk/cWUdYqZngF9n+BQqhXR9VgBIt/S6xGuTqnyljryZBlgJRzefbivZJPV+l23H267PHh2nw1+qN/f9upNHn/vOKVet/g4daUoYlgxtI/j50kcOtek5rrjBCofe+ACB7POAN5MUcFTg9khdOxiC7hmS1lWdZE3GK9lpxLdt3653fmTtm6d792T3LfvBDbSjp11A6Gel5WEa6i6BoGAPP7rYnjkwVdldQtPUVTq8SRNf399ihdOmtQP8R85sORnucz2oDkezR3G17uq8TYu4iqSpBaU+8xzIQTK/IzpflIY+KZBodEquTsNRY5WHeRFfNr8rwgBxgFKv2lX9ji7OhIwFelUuVUjkmbqEj7t+phDsvLLA4Y3zWaWO9KLOs+gB17pxW196k5oVgFOFD8ifdi+4J/RiPq68dB3NKOJ8CyNSOwTrQLRB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR02MB4081.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(376002)(136003)(366004)(39860400002)(5660300002)(6506007)(71200400001)(7696005)(316002)(2906002)(55016002)(52536014)(478600001)(9686003)(186003)(6916009)(54906003)(8936002)(26005)(4326008)(86362001)(8676002)(33656002)(83380400001)(66574015)(76116006)(91956017)(66946007)(66556008)(66446008)(64756008)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?1OCHf2q197qqYTJ1GD9pzG/uVbb4sQsfw6gYeeoiiwcKBmJTMKfrDsPnAc?=
 =?iso-8859-1?Q?7XEiG/TuKELncunYvEoU92V87feFYiuoCjUtzH4/h5OgIHhrVk2Lb89xPn?=
 =?iso-8859-1?Q?kHrjQUpcrhwm5QBWXxnI3EWYqv05sC+IOFfepU8XusJW3KUTWSZdrbeoad?=
 =?iso-8859-1?Q?3ciJCuKmhazJl1gI3T0aGVljogd1drNAJl3+vsL90RCz+SkJlSeYeLzGmp?=
 =?iso-8859-1?Q?ntrvcDUWhFRajwc6p47QN4R1sV0cim8bpn/seF3/dBRkOamdcu+36ZDBW/?=
 =?iso-8859-1?Q?vk5OGtqbjD1f4kiWFK4X/R7Zquv6W8MFp2LRkL4u3R/dY58J3HoeBZXPb8?=
 =?iso-8859-1?Q?4dlSDY5vAN69Ujq1wuFi0wimsYbx/awPdnJCP2nZFzqGv4T16ujkoQrpyQ?=
 =?iso-8859-1?Q?fPqAr6gmqTvvSpYfywbbWyE2EQ01yatZqFEbgiJZTjI1GPBnQlNaPP7Z+s?=
 =?iso-8859-1?Q?3Xu9Bb2hVBoapOG9PLv0AsWA1sihrJhjDm9TTcCEAaNsSFGL6HKzjZe71e?=
 =?iso-8859-1?Q?fvycs3E1K567QUKajpp3AqXrKeMKpJaRbgjEMc9cDbjw+nU7D4u1p407Wx?=
 =?iso-8859-1?Q?ApMZMrXNPnroNlXg3lM8I05CZBmgeBogohbAKS8bhmUyNUEWTwkeL/QDha?=
 =?iso-8859-1?Q?Y4ZN4M9vtUn9Yk6VONLekNzTWiTgewldOvD6byijCHk12r7pHaF5uc6oPq?=
 =?iso-8859-1?Q?twl1dljMdm7VRCMBwrzo0/jyivtC+XkUhS69z7e55yDfpUouYHDi1KYpUJ?=
 =?iso-8859-1?Q?8nr/8dMEitV4Mk8QGs+UVvV767S8UVYMOrev5U3BkowD88gLcxpdQLVDdN?=
 =?iso-8859-1?Q?u1ilQLCa12EMzfp/fofnAL+DWs6KirNb6EjoJq4AWQY5VLNCkvI9slVR1e?=
 =?iso-8859-1?Q?Iy6niC1Q/n/Q6MjOQenXq4AfOBO2Bn7rH1ifnfE25qqUwuhtoRfVCN8Y5s?=
 =?iso-8859-1?Q?vgo/TBHzjhjaquC8OMa7vgqRXb6M3UxVWs6hBmLUbKcqyfRjckqckzXu5X?=
 =?iso-8859-1?Q?vR9+q9ZoIpg1oe/yeUbR7q/PLCpUvbLoOB8ztwelDuzwzWfXvBkAZwgrrp?=
 =?iso-8859-1?Q?o7uw0iea5xC4bQwlWexBcoLPB6/miqkKOyng2eajO7zKB4Jc3bJ8XhiZVQ?=
 =?iso-8859-1?Q?SvpRJKx5N4o/b4rRwk1qlwF2vjqK+oxFjzZMpEVbfmaCZZ5McjVz+wO2/b?=
 =?iso-8859-1?Q?b0NiRykbFbzF6id19iZjWLKWZgIk8eucOgQenGNiH4axUy9CKt+NDBGlkV?=
 =?iso-8859-1?Q?/x4ERrGhFFu8JrrcPbIIIpHPCs2dM8At2AITGtIUqM9HI3KpDb6TtmGuLv?=
 =?iso-8859-1?Q?cfuKQUeN6PUrBVf27g/zpmrO1DqIlZGu1G97NAxZ+Q4dmMc=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR02MB4081.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9b5c507-2b91-4185-1636-08d8e56cd0dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2021 15:37:59.4954
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 33440fc6-b7c7-412c-bb73-0e70b0198d5a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s19a9eLv4gukJPJb++fFoGTCq2Hio1S+76cyDK/GU/AoVWNX9vaID5OlIRfK9qTv2Jewg8EnY78+fOlvKMFBVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0202MB3364
X-OriginatorOrg: atos.net
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I've got back onto this issue after a couple of months on other matters,=0A=
=0A=
From: =C6var Arnfj=F6r=F0 Bjarmason <avarab@gmail.com> =0A=
Sent: 02 December 2020 15:50=0A=
=0A=
>On Wed, Dec 02 2020, Kerry, Richard wrote:=0A=
>=0A=
>> I've read up on merging repositories and I can easily get L1 into the =
=0A=
>> same repo as L2, as a separate line of development.  However, merging =
=0A=
>> it is not the right thing to do, as that leaves me with L1 and L2 =0A=
>> having separate starting points, with a merge leading to there being =0A=
>> only one head.  That's the opposite of what I want - I want to keep =0A=
>> one starting point (that of L1), and branch L2 off it (with L2 ending =
=0A=
>> up as master).=0A=
>=0A=
>I've brought in existing repos into other repos like what you describe you=
 shouldn't be doing, "git merge --allow-unrelated-histories" exists for a r=
eason, you can >just use it.=0A=
=0A=
I don't think I'm saying I shouldn't be doing it, just that doing it and le=
aving it as disjoint history doesn't seem like what I'm looking for for fut=
ure clarity of history and for some work I need to do quite soon.=0A=
And I have discovered --allow-unrelated-histories, so I knew that was possi=
ble.=0A=
=0A=
>I do think you're starting from the wrong starting point though, maybe not=
 in your thinking, but your post just says you want to combine these, and h=
ow to do it.=0A=
>=0A=
>The reason I've done this in the past is for some practical reason. E.g. y=
ou might want to arrange it so a "git blame" or "git log"=0A=
>on a file traverses down the right path & history, or to be able to refer =
to commits by SHA1.=0A=
=0A=
As you say, I should be doing it for a clearer reason, which I should have =
been clearer about when I first asked.  My reasons do include the reasons y=
ou give, so blame and log should than work, but more significant is that I =
want to merge some of the work done on the L2 branch into the L1 main line =
of development.=0A=
=0A=
>Depending on what you actually want to with the end result merging or usin=
g grafts might not be the best thing to do. E.g. a perfectly OK thing in so=
me cases is >to just have a side-repo somewhere to keep the old history, yo=
u can add it as a remote to do some ad-hoc inspection, but never need to pu=
sh a merger of the >two to the current active repo.=0A=
=0A=
=0A=
From: Johannes Schindelin <Johannes.Schindelin@gmx.de> =0A=
Sent: 02 December 2020 11:15=0A=
=0A=
>If I were you, I would use `git replace` to pretend that the `D` in your `=
L2` history has the `C` in your `L1` history as parent:=0A=
>=0A=
>	git replace --graft <D-as-in-L2> <C>=0A=
>=0A=
>Note that this is a local-only operation. Even if you push, the remote rep=
ository won't know that you grafted L2 onto L1 in your local =0A=
>worktree.=0A=
=0A=
I don't think this would work for me as you say it is local-only so it won'=
t get pushed to my remotes, which wouldn't be satisfactory.=0A=
Though I have to admit I don't really understand what it would be doing to =
git's structures, so maybe it would be useful.=0A=
=0A=
=0A=
Giving it some thought during the intervening time it seemed that to do thi=
s much reorganization of existing data I'd have to start from scratch and r=
ebuild a repo importing the various exports, in whole or in part, in the ri=
ght order and with right references edited in.  I've split the L1 export at=
 the point where the L2 branch starts and generated master up to that point=
, then imported L2 so master is now A-B-C-D-J-K-L-M, as required.=0A=
Then I've taken the remainder of the L1 export and edited the export to set=
 the base revision and the branch and imported the result, so L1 is now A-B=
-C-D-E-F-G-H.  That gives me a structure exactly as I want, with master bei=
ng the same as the original L2 but with the appropriate additional ancient =
history, and L1 being as required.=0A=
=0A=
However, I'm now not able to write the results back to BitBucket.  I've use=
d "remote add" to add the reference to the existing remote repo where L2 ca=
me from.  But when I try "git push origin" it tells me :=0A=
=0A=
fatal: The current branch master has no upstream branch.=0A=
To push the current branch and set the remote as upstream, use=0A=
    git push --set-upstream origin master=0A=
=0A=
Why does it do that?=0A=
If I'm setting up a more conventional local repo to push to a remote it is =
usually sufficient to do "git remote add origin" and it'll then push (ie on=
e set-up using a simple fast-import from cvs2git, with the instance on the =
remote server created there).=0A=
Presumably my current position of generating the local repo from scratch fr=
om multiple imports means it's missing something vital.  What might it be m=
issing?  Is it just that it is aware that it did not originate from a fetch=
 and the above set-upstream is the best way to fix it?  But other repos tha=
t originate from CVS exports are happy with just "remote add".=0A=
Does git know that the repo of the same name on the remote server is someho=
w "different" from my hand-crafted repo?=0A=
=0A=
=0A=
Regards,=0A=
Richard.=0A=
