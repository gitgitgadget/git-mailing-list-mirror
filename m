Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E28F5C54EBE
	for <git@archiver.kernel.org>; Fri, 13 Jan 2023 10:50:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241264AbjAMKuk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Jan 2023 05:50:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231274AbjAMKuZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jan 2023 05:50:25 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05hn2200.outbound.protection.outlook.com [52.100.174.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB615777C0
        for <git@vger.kernel.org>; Fri, 13 Jan 2023 02:49:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LL7j+QTyxvVANNjgMiOEubER2eSv01OjATFFtAXhLOC3SUhW6vVq9m4HnF6OIdi4GsWpwwSgjDeHH1rGCy1lsbucxX8uaiuGzqeWY540+X+4RuQla2PsdytVbbw/9EBT1sS8Mo/X6d/9rq2YcM/kDC90OVXAsb0Z/UeD94IHDWFZnenuvuLyqGturATXe4laymO+0zR3wHrF0pEwblJ8KAl7nRUYcAw5bqodg5f9kRSu5hrA/Ozczg45LrZpBvDuj0RlgizCR/w/PA0mTFeRadxnTxulm0AtJe7NF6GVVXpukJ1fHWIDkQnJL8LluzkBkItW6aENTnCjD2ibUMwryA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lllvniCtDWqW4OYDZkOtueO0Jc/9janYszKt8g+b7ws=;
 b=Hyr//lybL8c40+KumeqdKBAh4r6GD72bsSa00brrbp1eKKhu/9vgRV+Ivh4/6GPeOYlEAEBjg3pu7G/cA21MaLLE47nkJf6T9RTlyoUXKi1LcSa+RKFZ0hpJatkhgc95+GaAuFxMxUsbdR9dDhXbweN9Qq1+5NGLssQzfT0jW1CMI+ph3+EG3c649R7Dxlj7jg1vyD4tZWh2X88i5E0jTBcZIX/qDqFSsN0saQe4QI1ijyMm/CqAglnbq9gZUn2Uj4gB9ynUFmmt7z5U4MlgfbBqHhMJRsatq4NCrPvDaPT6NPDjURFaqaLTwA6OfsCAFGeJJoJFWD/hYeZdLwOhqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vitesco.com; dmarc=pass action=none header.from=vitesco.com;
 dkim=pass header.d=vitesco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vitesco.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lllvniCtDWqW4OYDZkOtueO0Jc/9janYszKt8g+b7ws=;
 b=XmE7OKrMwCO41qnWWHzhw7gPIceRtHt+N9nV+qx3jiEGLvRhPgh30SV4Lhbqsefi8t3YeBmoppwEVa8hxS5ZbbngXqFapiJRVRWje80+MPWTe1Tun3MGV7sysw+4dzpfPDQqqWp8tG5fl6JNtzfEFruHQo9MkxMCZapjyndn+Ug=
Received: from DB5PR02MB10069.eurprd02.prod.outlook.com (2603:10a6:10:3c1::22)
 by PAWPR02MB9973.eurprd02.prod.outlook.com (2603:10a6:102:2e0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Fri, 13 Jan
 2023 10:49:35 +0000
Received: from DB5PR02MB10069.eurprd02.prod.outlook.com
 ([fe80::5c77:e086:f988:cad5]) by DB5PR02MB10069.eurprd02.prod.outlook.com
 ([fe80::5c77:e086:f988:cad5%5]) with mapi id 15.20.6002.013; Fri, 13 Jan 2023
 10:49:35 +0000
From:   "Zitzmann, Christian" <Christian.Zitzmann@vitesco.com>
To:     "rsbecker@nexbridge.com" <rsbecker@nexbridge.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: Parallelism for submodule update 
Thread-Topic: Parallelism for submodule update 
Thread-Index: AdkeucE8zVh8kEwpTW+MtNPu9m+gTQAERy0AAhhoLOA=
Date:   Fri, 13 Jan 2023 10:49:34 +0000
Message-ID: <DB5PR02MB10069A5579A25D465DC126F998AC29@DB5PR02MB10069.eurprd02.prod.outlook.com>
References: <DB5PR02MB100691E6422F5E94228F0E0EC8AF79@DB5PR02MB10069.eurprd02.prod.outlook.com>
 <009801d91eca$e1646360$a42d2a20$@nexbridge.com>
In-Reply-To: <009801d91eca$e1646360$a42d2a20$@nexbridge.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_3f3ac890-09a1-47d3-8d04-15427d7fec91_ActionId=5b14e3e5-b10a-4a57-8d55-ca2104c50ebd;MSIP_Label_3f3ac890-09a1-47d3-8d04-15427d7fec91_ContentBits=0;MSIP_Label_3f3ac890-09a1-47d3-8d04-15427d7fec91_Enabled=true;MSIP_Label_3f3ac890-09a1-47d3-8d04-15427d7fec91_Method=Standard;MSIP_Label_3f3ac890-09a1-47d3-8d04-15427d7fec91_Name=Internal;MSIP_Label_3f3ac890-09a1-47d3-8d04-15427d7fec91_SetDate=2023-01-13T08:53:24Z;MSIP_Label_3f3ac890-09a1-47d3-8d04-15427d7fec91_SiteId=39b77101-99b7-41c9-8d6a-7794b9d48476;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vitesco.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB5PR02MB10069:EE_|PAWPR02MB9973:EE_
x-ms-office365-filtering-correlation-id: b390051b-f3fb-400c-e33c-08daf553dc14
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:DB5PR02MB10069.eurprd02.prod.outlook.com;PTR:;CAT:OSPM;SFS:(13230022)(4636009)(39860400002)(136003)(376002)(396003)(366004)(346002)(451199015)(53546011)(71200400001)(7696005)(6506007)(66556008)(4743002)(64756008)(26005)(66476007)(66946007)(8676002)(66446008)(76116006)(186003)(966005)(9686003)(478600001)(41300700001)(8936002)(52536014)(5660300002)(66574015)(15650500001)(3480700007)(2906002)(38100700002)(122000001)(83380400001)(33656002)(55016003)(82960400001)(38070700005)(86362001)(110136005)(316002)(11215385002);DIR:OUT;SFP:1501;
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: =?Windows-1252?Q?tk9iFXgeubg4aSm2DLPfWWe6ZR8VfHq56aenjbdsIwtPr7RDRPibIQAb?=
 =?Windows-1252?Q?Ix3+xNluf6jQU0KfQ/zMj539jv7ZfHwwQQ+FpRkDrmEt0t3IoAcdTXRY?=
 =?Windows-1252?Q?JJbz0C5C1V7PKqZ7GfqDDD6RT2hFZpAlPxYFyZHqZajb5RfZbLG0kUEv?=
 =?Windows-1252?Q?xrM19C1HpLUON5/b6Pu7m+mS3vzzsr0Y7zR/MUUI1jFwWSzs2xwTleTG?=
 =?Windows-1252?Q?MJk6bGgq25Kfmh42KMYIYNHEvNp+9ZPyatKz8hgmbCchzKCQEmsbd9O3?=
 =?Windows-1252?Q?Ocq0WYyBcOlxpeXn2Ee7x2dEyoK4ogXhZqNZsZG7Nh0ouNXCg9wuzUfG?=
 =?Windows-1252?Q?ZdXi3nZo9Kf1fHKnD+i9CuTb9VAU6moAp6lQJouSRrzVKAOR10sYiDkl?=
 =?Windows-1252?Q?PFgkDJs7ZnogzZ/39e2p4WslEDWMFSqzmy4rrhVuoUceWnx4j2PNQUt5?=
 =?Windows-1252?Q?93cbVNx4DcsvKH4LH1ubow8xdZvK31bDoed0YRe9Yk5I3G0smM6tlD/z?=
 =?Windows-1252?Q?YWNpF/yVwBLJ9yV2W8u4nF+dc/A3dIe33GtiY/STtCkReZVk7yUjb/G3?=
 =?Windows-1252?Q?Fc7PG9XqnDnkVpIAsqZq4eq/5Fs4HDYnt9bEh0qNJDs4q0CSc76YNpW9?=
 =?Windows-1252?Q?tkYULwE+RnJC4vFNxk/yqEnEete2Tcwm/WuK4890jDmR5tqHbPo5FLeM?=
 =?Windows-1252?Q?zClThvSUBgtwd6vN5aUbuUaBl1JlG0s7wKl129BOWP2RpsNCShx+lxNZ?=
 =?Windows-1252?Q?1f+vS7yCCjglUUcykAh5Jm8UWgRJX486Plx9wVEACNU3eZaHcqKIEh8+?=
 =?Windows-1252?Q?EMhBAxi4BPlFV5PvJkl9DWUrk3mu9+D970RQ2OLh79PImdYIyMv+H/X0?=
 =?Windows-1252?Q?zzkdQtF2shPjcXz6XDXUO7Ba9wemdTnReancQy5vzDcMddVUQI59K2Rp?=
 =?Windows-1252?Q?c4fBnaKXYaIlehklWZYPC9/hyMVu4vV5166Zaj4Xrajb89I/+XheO3ua?=
 =?Windows-1252?Q?/JhJP74s+m8qmrVwxPt1+a6G5NAFSd1LwQDY53rTjjLUE1hnyWLpuF+t?=
 =?Windows-1252?Q?lMKfvuJcSyHWc2/hcmw+l/aQq9ghJBEHD6VIt6tIQ2IxX2pS3kuKC8S8?=
 =?Windows-1252?Q?Ax6aDc4qup2pHKzbOciy1eQCxdk/UckMHbG6xGARGlculHzLWapLH9xw?=
 =?Windows-1252?Q?V2qBJIIwEZUAWEDj+IgnybsJDKJvy9rG?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?Ly8P8JJLIntzuwWzvYhHCuWwBjZ6F+mAuGE3/sWNkJ5myblmMIdsfeNM?=
 =?Windows-1252?Q?OLztffBl0RyRqMPopf8tvYlVt1l36KXNILEsqX56jAPo2Z7UQS2mzyeR?=
 =?Windows-1252?Q?T7B6xmxYpTNIbIMpTY1EVrGWm5b44hCcS7Dwu78zjvTc3Ol/gWG6+RJJ?=
 =?Windows-1252?Q?clt5wYSUOy1C5yLhiNQDK6VHR3AnSpJIg5resFwNDzJN4mIliEaqb0WJ?=
 =?Windows-1252?Q?5+yRvq1D+BjWQHFGGgZLTqQWPB70WekyYZwdKrngTCU1Hc1ZAxXbjXmr?=
 =?Windows-1252?Q?RTfGtrqX894MNcFA52bEaOEXCqDa6VXK2g/+0HLtKV78jaEZMX1jTd9c?=
 =?Windows-1252?Q?R2ZkYqFXNK3xFUdVhWjVEpa8INDfuNT9OXAFJq8ZQB2CFyOQvfk6Ysy1?=
 =?Windows-1252?Q?YLSIY/lpV+fW2a53VctRUVhplDv7e5/dCtH8E4aUUVFe89TOtlr/fc7m?=
 =?Windows-1252?Q?uVZienI9ESzNtb57rFIoIhDReL6W0Qy5FOWjrMLbGpk6y7KOP2AdHFHh?=
 =?Windows-1252?Q?qdaDrlegYA3cHhZgF+oDlURJ+C4NOkxi4PzXDWc0UGePumhjDCYSYazL?=
 =?Windows-1252?Q?NMgWaom0rCnhq4h7uA9arJC0p4QKWQ8RRi66fO91GhxMXeB2kvzdTpbT?=
 =?Windows-1252?Q?7RMwTVe4rHtM85GvC+nw0TZTYzSX8v4907hXnGu/zxDJC4x3YKw9+QHt?=
 =?Windows-1252?Q?pkIbDC+gFDtcaXvAqVFaEE9IWkzCqh7+zDv5JCNDidB7zHHoYn0g87kB?=
 =?Windows-1252?Q?RfU5uWlKj3d/kpkLpi7MCXdVVab5sNxUvXQtgZN+iwNt/Fe8bH5A4FGS?=
 =?Windows-1252?Q?Ix4HEqeHjgMsEFCBd82/Ras3iZLS8OsgcsSLr8avvf3cBrlHdeh6dLgb?=
 =?Windows-1252?Q?IRPC0/LPO6Cac23t52Pzxj2h88Hu1sVyomGLyh6W3UHwiWnAOcFFMkxR?=
 =?Windows-1252?Q?x5VtEKK/GWMHbUuyzXmADXAI0kTGsTwtChKYxMA/lW2J28DDdhgRHheJ?=
 =?Windows-1252?Q?F7nj7am9eM/eFp/xNVMwz8xL/GAHr4in7nCTlVHy7IbC6XvBwnA2bRyN?=
 =?Windows-1252?Q?hpTw0JX9eUkM+xPG0Pi2WmEzR5Tm8SHFkvVVUVCrAo/f+5+pnLu06Ztj?=
 =?Windows-1252?Q?b9I2SbFnVJGqnqOsa+6oo869/AVanKQGFk3ZLQ+NF59/awqO1KPSG3Xp?=
 =?Windows-1252?Q?eOnIZYpVA1deOrK7VlOReio0Rdc/4Tfn/EiWtnWks8sgRtQLL6GsFte3?=
 =?Windows-1252?Q?pY2wGxklWIuGtmvMJJltqdzpIl6+L4u3KmyvgS+8BOIF/JtT778tuRYi?=
 =?Windows-1252?Q?AF17RVuMqUfL/iXOIqsAdLGmi2+nBLiVyK+UzWF+6dhBpnx7aI4DLAy3?=
 =?Windows-1252?Q?vklbSRMlTWol4hpWH+18SrIi8NyP0KpozON4qlrFGeaBKIJfVLzeqMJn?=
 =?Windows-1252?Q?O6Zy6cuZcZmW5U42AUYYJMcf+mnulSzOIy7I31L855yRVvYiZ95oM+Lh?=
 =?Windows-1252?Q?KyiXvdEQLGwIyyHh6M4AG5sEgXDl7CEzJIIVuQICGje+wzl+zieDL40n?=
 =?Windows-1252?Q?XeaE97JObsCdSoUfFDfYu8MWtEg6l9BfvhizkyoRMqBgp7m4/d8nOc5/?=
 =?Windows-1252?Q?091+tZO1ygYURftIsOpH5NnOVQgaOkN5yDVliZMRlOYkxt2g4cgE0os6?=
 =?Windows-1252?Q?h1IPnB2ii0tFvptJyAx2nDWJysg4WtwG?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vitesco.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB5PR02MB10069.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b390051b-f3fb-400c-e33c-08daf553dc14
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2023 10:49:34.9324
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 39b77101-99b7-41c9-8d6a-7794b9d48476
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ADY66b3gReyWMgVz/C9LjY6W1pUuVhzdneOSGuA/1mGv8DPKTJYsafRIvjChtAemaXro70YFh5yQsBu96x7WtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR02MB9973
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Randall,
Yes, I guess this is a quite common that the harddisk is much faster than t=
he Network Services.
With the scalar strategy (e.g. blobless clones) the checkout phase does not=
 involve mainly harddisk activity anymore, but includes fetching sources fr=
om the remote. So it consumes a lot of Network Services.
Especially with parallelism we would gain a lot of performance here, as net=
work and harddisk are utilized in parallel.
This could be even a general strategy (without using blobless clones) to ha=
ve fetch and checkout done together, but both in an parallel Scheme

Currently it's like this:

Multithreading (mainly network utilization, only small amount of data - Com=
mits and Trees -)
	Thread1: Fetch submodule1                       -> NETWORK
	Thread2: Fetch submodule2                       -> NETWORK
	---
	Thread<x>: Fetch Submodule<n>               -> NETWORK

Sequential (alternating harddisk and network utilization)
	Loop1
		Try to Checkout Submodule1 commit                                      ->=
 HARDDISK
		Fetch missing objects (e.g. Blobs - big amount of Data)        -> NETWORK
		Checkout Submodule commit                                                =
    -> HARDDISK
	Loop2	=09
		Try to Checkout Submodule1 commit                                      ->=
 HARDDISK
		Fetch missing objects (e.g. Blobs - big amount of Data)        -> NETWORK
		Checkout Submodule commit                                                =
    -> HARDDISK
	=09
		...
	Loop<n>
		Try to Checkout Submodule<n> commit                                  -> H=
ARDDISK
		Fetch missing objects (e.g. Blobs - big amount of Data)        -> NETWORK
		Checkout Submodule commit                                                =
    -> HARDDISK

Here the Network accesses in the sequential part really have significant wa=
iting times (e.g. name service) with low local resources utilization


The proposal is to change it to a full parallel flow!

Multithreading (both network and harddisk are utilized all the time)
	Thread1:
		Fetch submodule1 (blobless)               -> NETWORK
		Try to Checkout Submodule commit   -> HARDDISK
		Fetch missing objects                            -> NETWORK
		Checkout Submodule commit              -> HARDDISK
	Thread2:
		Fetch submodule2 (blobless)                -> NETWORK
		Try to Checkout Submodule commit   -> HARDDISK
		Fetch missing objects                            -> NETWORK
		Checkout Submodule commit...           -> HARDDISK
	...

	Thread<x>

The only negative effect I'd see when having very slow harddisks, or disks =
that suffer significantly from parallel access, the overall performance cou=
ld also suffer.

In general in the partial clone, but even in the full clone approach, netwo=
rk and harddisk utilization will be in parallel, and therefore performance =
can increase.


Best regards

Christian

-----Original Message-----
From: rsbecker@nexbridge.com <rsbecker@nexbridge.com>=20
Sent: Montag, 2. Januar 2023 17:54
To: Zitzmann, Christian <Christian.Zitzmann@vitesco.com>; git@vger.kernel.o=
rg
Subject: RE: Parallelism for submodule update=20

[Sie erhalten nicht h=E4ufig E-Mails von rsbecker@nexbridge.com. Weitere In=
formationen, warum dies wichtig ist, finden Sie unter https://aka.ms/LearnA=
boutSenderIdentification ]

>-----Original Message-----
>From: <Christian.Zitzmann@vitesco.com>
On January 2, 2023 11:45 AM Christian Zitzmann wrote:
>we are using git since many years with also heavily using submodules.
>
>When updating the submodules, only the fetching part is done in=20
>parallel (with config submodule.fetchjobs or --jobs) but the checkout=20
>is done sequentially
>
>What I=92ve recognized when cloning with
>- scalar clone --full-clone --recurse-submodules <URL> or
>- git clone --filter=3Dblob:none --also-filter-submodules=20
>--recurse-submodules <URL>
>
>We loose performance, as the fetch of the blobs is done in the=20
>sequential checkout part, instead of in the parallel part.
>
>Furthermore, the utilization - without partial clone - of network and=20
>harddisk is not always good, as first the network is utilized (fetch)=20
>and then the harddisk
>(checkout)
>
>As the checkout part is local to the submodule (no shared resources to=20
>block), it would be great if we could move the checkout into the paralleli=
zed part.
>E.g. by doing fetch and checkout (with blob fetching) in one step with e.g=
.
>run_processes_parallel_tr2
>
>I expect that this significantly improves the performance, especially=20
>when using partial clones.
>
>Do you think this is possible? Do I miss anything in my thoughts?

Since this is a platform-specific request, if it happens, this should be a =
configuration switch that defaults off. On my platform, the file system its=
elf is fairly fast, but the name service traversals and resolutions (what h=
appens in the name service) is a performance problem. Doing the checkout/sw=
itch in parallel would actually be counter-productive in my case. So I woul=
d keep it off, but I get that other platforms could benefit.

Regards,
Randall

--
Brief whoami: NonStop&UNIX developer since approximately
UNIX(421664400)
NonStop(211288444200000000)
-- In real life, I talk too much.



