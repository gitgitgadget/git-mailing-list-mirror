Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D051AC04A94
	for <git@archiver.kernel.org>; Sat, 12 Aug 2023 05:32:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235328AbjHLFc6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Aug 2023 01:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbjHLFc4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Aug 2023 01:32:56 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC3D42728
        for <git@vger.kernel.org>; Fri, 11 Aug 2023 22:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1691818376; x=1723354376;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=r2HwwhHUn1GG0wlKp1y8cv2mVnJhrrmbjy02jLjHLD4=;
  b=enDUtIVIIgzToAFmnHYoLtnyTAWkc3UH0XOSQuQwnZsFYV4l3mBSKRSW
   XruLND2KZH9+KZ/iv88jNdgA7X4/1jJxO42uCSBExIW1aSJokA73B7eRP
   6RDBqsF5CrvDT0tN4PLKSqX9XnBG3GUGlXcBi3LNP0HAd2AQ5IvTJTY/E
   ZgVB+aJ9jj6swLjOJsOxz2p0llSamzmmc1AgRVU+YVOSPjr1+17HAJCpS
   QwTUmsuEMIA8KuNMxanLUgelG9eAqf3CphKjcE/k8XzHLJuCBC33pGuAK
   7TqC1Hv3g4BHMCX2tItIVQjQFPrBrUnfdvYzOczjtGTmSndJlE9Zeq6q1
   A==;
X-IronPort-AV: E=Sophos;i="6.01,167,1684771200"; 
   d="scan'208";a="240721267"
Received: from mail-mw2nam10lp2102.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.102])
  by ob1.hgst.iphmx.com with ESMTP; 12 Aug 2023 13:32:56 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HJq17djyuq+/9dl4ah1B0P+2jRSWJrD9sa48Awev1dbsCf5Ju8LePD9L9FCABgu6eywseGUrEQwZNlPqHiOfqdBzeHnQEbFVUlWqdL8/yqigU7VdA1G4Xp2PUHeZyA6QU3tzKsQdquyS5EoMCc4OmP9iKMe8vtcNFh5cg0d7IT8MgN5z/ykrkBi2C6N0rTtUAFuzFCghohbT1ZAZyvZ/fNUPhSb16wxIPmLvrGvwa7Do4lCYXRtFh3vzJivCN0S1m5xXzOsy722GfvClJqbHxVfa9cX/DPBIFRMUDHHHHtNtt1NtD5gOfp88+zCm58S/7wQNucGi6uI5jELopThsRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v8bKbLtJmkyS5prwpt2JiIXr9EcC9mR+Abs4U+itPT4=;
 b=foN1nvdDCm/bC71SKucHxPf0vq3mDN+WEUSLxXYUl9p8gm4jvkHk1+GSInfs7ZUagLXaiNm3oCr4bZvUvn035NEn285O44r9MyDd0u/7a9Lp02FiN5a9zUJ0/2cOpRnz8ccdkfGFhrOSAdl3xZvgiJlHtq7A8rLOAJ9XG51EuCPc0LGtQl5VrD7GngwARj3hmyh5/qgwQiImyRERLDSnnadDqtmvcgT7y0VNiavqYRxsBPzRvAapf2vZqv1c3qwEMuRJ4pPnuSGHeKJTGP3iwdxsGfHickGvDA9/2tmUpErRKH0WspJBOStgKoikSapmpuXN+dIyx0DVjWMQ2V3tfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v8bKbLtJmkyS5prwpt2JiIXr9EcC9mR+Abs4U+itPT4=;
 b=WrB9kIOHY17SSLh5WBphTBIAyAcwURFLyFGlOSzPhh6yDSFR7AJniei1YiKevmNJETQ4s6lmJ9Zh/ybjXOFJ3pQaGiz/hGfP4ez7jsNCeq+fdURUn/MhxOclF/P/4DZpvIBhtrjgf5jcH3bfe852d/P7X1ve+BNumaJHNvtSQUE=
Received: from SJ0PR04MB8289.namprd04.prod.outlook.com (2603:10b6:a03:3f1::19)
 by BL0PR04MB6532.namprd04.prod.outlook.com (2603:10b6:208:1c1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.20; Sat, 12 Aug
 2023 05:32:53 +0000
Received: from SJ0PR04MB8289.namprd04.prod.outlook.com
 ([fe80::1032:2a66:96ce:fef6]) by SJ0PR04MB8289.namprd04.prod.outlook.com
 ([fe80::1032:2a66:96ce:fef6%6]) with mapi id 15.20.6652.029; Sat, 12 Aug 2023
 05:32:53 +0000
From:   Mun Johl <Mun.Johl@wdc.com>
To:     "rsbecker@nexbridge.com" <rsbecker@nexbridge.com>,
        'Junio C Hamano' <gitster@pobox.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: "fatal: Not a git repository" issued during 'make' from source
 code
Thread-Topic: "fatal: Not a git repository" issued during 'make' from source
 code
Thread-Index: AdnMjcTVJgLV9DzbQRekliVLGjBYJQAAz3CAAAC6tsQAADubAAAALjhAAAHs6AAAEDPFMA==
Date:   Sat, 12 Aug 2023 05:32:53 +0000
Message-ID: <SJ0PR04MB82897032646F100BCC9001669C11A@SJ0PR04MB8289.namprd04.prod.outlook.com>
References: <SJ0PR04MB8289FF1D6BAC59833D922BA89C10A@SJ0PR04MB8289.namprd04.prod.outlook.com>
        <034501d9cc91$069bd360$13d37a20$@nexbridge.com>
 <xmqqr0o9qpon.fsf@gitster.g> <034d01d9cc94$df9db0e0$9ed912a0$@nexbridge.com>
 <SJ0PR04MB82892A7EB350531DBE4701BA9C10A@SJ0PR04MB8289.namprd04.prod.outlook.com>
 <035b01d9cc9d$4c2168d0$e4643a70$@nexbridge.com>
In-Reply-To: <035b01d9cc9d$4c2168d0$e4643a70$@nexbridge.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB8289:EE_|BL0PR04MB6532:EE_
x-ms-office365-filtering-correlation-id: 00cf9813-bac3-4c95-2c54-08db9af5938e
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: J5g+bvq/20k+U/8IcUoHsTex9KiKMGhXvME4mZRGrOZtOiMRHOpEN7vyAUR71h0aozb86GqWAweCJZPpZTr1yYAB7YSqrp3pWk83glk5UCS6m9p/4yilPkPMIHb0SYxc4BfB+QlXio7lQ/WsNE2uV9Q3OKhfrI0WGWFPFEyYwIn4DAoStsZEAt2RcbgFcTz5ZDQk662XpbBAVBkSlHdMOMaapjf48K5c5TW4WQnfszs4KL5ot70PBej4ItTe+ilKMsQvKu5tdsNsQYkyHbwvzaEcn6E69Gsz+N9wRw9a6YbVPoiidjjYomKIjHJFkuCiUaYLsZ526Dwb9mfh0ILCnhqasIQQbbkRT9tzWweFeDVBwuUSKLRrV8IJ5bjuzq45Dgbn+IoQ7MX0Nv7EhfYhKo3xl4HoRwUL9w63uOs0lA3bcZKDjakx4hnN8eyEFKHDlfsRVuskBISYu9wI6opzLE4cNCPPi883j6UPhTi5aaCEawBwKNf8QG7KIxfGuQ0zegd9i9eKMMPK5rDLpsRAokzpFELEh7NvMnBXPKETrpRD+B8mJocMtEWMtyYDa5zW4FJJO7+hIt0zsnBlPKjrMwGSiZY7W4hzD5HYnTu1DKE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB8289.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(136003)(346002)(366004)(396003)(451199021)(186006)(1800799006)(9686003)(110136005)(478600001)(71200400001)(53546011)(26005)(7696005)(83380400001)(52536014)(66446008)(64756008)(2906002)(5660300002)(66556008)(66476007)(66946007)(8936002)(76116006)(6506007)(8676002)(4326008)(41300700001)(86362001)(38070700005)(55016003)(33656002)(122000001)(82960400001)(38100700002)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ADaTFlr5EBjuGYqVfwqggXrUcKg26qn9GG/O3kc7KfXXRFz1u2fgyoXpW72b?=
 =?us-ascii?Q?lpHV/Bkao+eEgZc/H+BscTcjGbuzTRFprEw3ZYNOnIDBR+gv7qO+yPkz9rPz?=
 =?us-ascii?Q?Q2TpyDH/sMKap6UTwLEiTvlNDT8/l45dGgOyoC4YceZiHPW911UH0WCZXFl2?=
 =?us-ascii?Q?8qFf7HWAMcxF6kjRadvfGqrCFTC9BaTUYnA2X1QfbAB0HwnXLwsZrw03kMaw?=
 =?us-ascii?Q?EPFNve3PIN6xjlcuDMUWJcV+iS8OfLyAHV9CnBHNRhyn7tdYxNuW/ayPskLQ?=
 =?us-ascii?Q?U7SSqwYZM53/h2blFmO9TK1v08SeGdR4ust3LKKGbFlOjn0uYS+QijNIXO2O?=
 =?us-ascii?Q?HD+yHprjpHMD8e/f/f1TAtyqnxjbs9nJBHmU0AGlDSBDQIG/OJ/2Gnbe3RS3?=
 =?us-ascii?Q?+Wc3tMPEoF25QsOFkbL+7FOkPU6cGfqMDUPY7e3ERxyUdtGOurramad556nU?=
 =?us-ascii?Q?Ga4AT6JOpsv0/EI+xgRFc2ov5q+6xMoDZuZZqUfzy5eJK7Z/PJOaRpyIE4SA?=
 =?us-ascii?Q?OYyRxPzJFsRPVxCncETjptusn7j3oaX6foNNCgQO5zjsrkxvaxpgJHU5Tkx8?=
 =?us-ascii?Q?on5gXgCq5B00pPuE9umSpMtQ9HYvkkLrfUQOtjodXYTgjF62L4+NDMgUdU2z?=
 =?us-ascii?Q?hE0kanvUruVn47s65yT2K//guaEKuaeYUv3pSeKBYEwU+yruOSdSJv0fsJ26?=
 =?us-ascii?Q?R2HoN5ECnxW8ZZ+EK0ZyJJ1iQBR+7JWmKVb1wi2zOyZDE0ujIMVyneud4LTA?=
 =?us-ascii?Q?OYYGng00c8vVFPXAqQi8uP7Bp3RpIuMedKQStrfRtRPI6/rJEt61oplv0Pg6?=
 =?us-ascii?Q?ZRJUanlJXjAOQKbLV27ehxEdOLmuNBCkqLwW11FPEIURCeyBym9e9c02l66+?=
 =?us-ascii?Q?4f6O4k13dkV61ZailoOMz7xeC7n6JB4C2tb2lj7kV/sfMJb1OL8gpCh0RtAo?=
 =?us-ascii?Q?HXF4emEXBfOqfgbpBiyWzqk6hfF4IQKUNrH1s1VUFKAM/NxboKMdhl0O1fmN?=
 =?us-ascii?Q?I67GEIlXnA1Zumjr56NvUAwUm6gB0vFhgRK2WIosUHChJBF+nK3XSsD+OH5t?=
 =?us-ascii?Q?VbZFZ4gy5SInrHEfF3uXSjgoFRu2QWDjCbHGow6tuOsZjvE2j6SioKG4XD8Z?=
 =?us-ascii?Q?vjluYcHwMdSn0iOjP4tyjzbJ+ULnvOQBZZlEVZ3GDUaFsrgykQoZVcXhsN3S?=
 =?us-ascii?Q?xBHqBUTRpLmg+YlrmLm5mIeCo1wH/2K8J7fBFYbLQo5arAEVGAEjMvCjhfDj?=
 =?us-ascii?Q?5qaZEL//Xf0A3fReyM6PSo/bLyAgR0RixVcdBnpAu0gBVJEecTwT9iQ159w2?=
 =?us-ascii?Q?pNVGykUYjfuR7lw56m0ctPtVheXKSd6aM0HQ+aVehUewci85Zfi8kDbISrwK?=
 =?us-ascii?Q?z82ulWqTBkrSkkeyavgZ+jHCX9to0qHPueVzp6hEOUKEINZqAgl8viwF9stB?=
 =?us-ascii?Q?rIjVToLac1ZMP04Y3g/P1o0Zaj2eBk8esKuTrj7HCbvnZrWlf/TVPLGvnHLf?=
 =?us-ascii?Q?vOKzQiRpjykf8IgMGbN/cRXDax+Io5FqYinCEvBvRC9NP8EYGGDz8Ll0QKtH?=
 =?us-ascii?Q?iCwbDZT1eUVes4qx1FU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 6NlRVApPSRe50RZRU/az2iQ59qozfETYnLBnI1SkOnyrIis8wQ3mZuI+9D3MrI7Df/vPRkS2xCvAy8JxYoBWizuCTqQ0sRlVZaaX+RyWSGACwbKP4bh0tb9m4+UXCi5X1DE4NMdVIG7nRhf6LLa9shXkw+UoaZx5awMWt7ogApsnrLUNxEIbn8QKQFmq5uNjKlvMpBRPBfIH5J+3ugO0y2sRoeFlU1Fc2JGcA5Vxjt0lyB29aree5Wij0yaOrIHDh0uG/0M9ZveowfR04mma2N1S4iQ5JXNstRBIotqOhkwloYfpyDbURpOr1uREfXzHVlr5NKzD31MmNw2uzs84bQwgPA8jKNcLbYadAQMMYAI9+PL8mVf6Qca+uX++B0eOgqTARefQMyMnjd85I5bSO5cuLsG1de8senI/4hGWCJSD65ME2aGpjvXvlwGz6G8X2ufVoiNxyzMjeEw62sEEpzNia74DM1J6hZPGnurxRUulqqKJtcWFpb9lc/detxpqb+OfNG8Yw8Apxz54E93qrWcLvXT01qmO10uxZNLU9cRvYcZNJLovEnwQu1Q4P6MlW8lle+rJpoIwvmM3mBt1TJ56dOr2QXRiI4PJXPThD1gVyuzcfRs4zmHZ5QkxF1cfqLpLBjmccjD1QBXksok5xFTiTZ3wMnXSYKJgJq45yHuTX5k0XQDX78wLK2K5O0xAc7e/LvlQUR5WmIUuiFl/G9SWmTvKwaPLnj56KTpAWnfR3I8UxCo/g7RZjmI40VK8Gkck9Ob5f71m/+hA/z0twKmdDtW00lTqkZ1vk0JifdXTUgtVyZV+G6OdvtFQWvATSfcMETPGRGsMJrWqr1b1xA==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB8289.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00cf9813-bac3-4c95-2c54-08db9af5938e
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2023 05:32:53.5811
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RIzivmKpSEdeZOGeDBCMij4/oyZRV4RQC2uTkfC1nrUKFQhHYOU6kAGhc9tLKVsd3NaVdWKhzcP/0NFASZsI2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB6532
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi rsbecker,

> -----Original Message-----
> From: rsbecker@nexbridge.com <rsbecker@nexbridge.com>
> Sent: Friday, August 11, 2023 2:46 PM
> To: Mun Johl <Mun.Johl@wdc.com>; 'Junio C Hamano' <gitster@pobox.com>
> Cc: git@vger.kernel.org
> Subject: RE: "fatal: Not a git repository" issued during 'make' from sour=
ce code
>=20
> CAUTION: This email originated from outside of Western Digital. Do not cl=
ick on links or open attachments unless you recognize the
> sender and know that the content is safe.
>=20
>=20
> On Friday, August 11, 2023 5:15 PM, Mon Johl wrote:
> >> On Friday, August 11, 2023 4:39 PM, Junio C Hamano wrote:
> >> >Subject: Re: "fatal: Not a git repository" issued during 'make' from
> >> >source
> >> code
> >> >
> >> ><rsbecker@nexbridge.com> writes:
> >> >
> >> >> On Friday, August 11, 2023 3:57 PM, Mun Johl wrote:
> >> >>>I am new to git and am trying to compile git-2.41.0 on RHEL7.  When
> >> >>>I run
> >> >> 'make
> >> >>>prefix=3D/usr/local all doc', I get the following error:
> >> >>>
> >> >>>fatal: Not a git repository (or any parent up to mount point
> >> >>>/tools)
> >> >>>
> >> >>>Which I infer means that I need to do the build within a git repo.
> >> >>>Is
> >> that
> >> >> correct?  Or
> >> >>>have I missed some basic step in the build process?
> >> >>
> >> >> Yes, you must be in the cloned git repository in order to run the
> build.
> >> >
> >> >Shouldn't we be able to build out of a tarball?
> >>
> >> I don't get the impression he started with a tarball, so subsequently
> >> sent the doc ref for that. Using just "make" is not sufficient from a
> >> tarball.[Mun]
> >
> >[Mun] Thank you both for the information you have provided!  It turns ou=
t I
> did in fact
> >start from the tar-ball "git-2.41.0.tar.xz" which I downloaded from
> >https://mirrors.edge.kernel.org/pub/software/scm/git/ .  And then I ran =
the
> 'make'
> >command.  The process went something like this (basically identical to w=
hat
> Junio
> >documented):
> >
> >$ tar xf git-2.41.0.tar.xz
> >$ cd git-2.41.0
> >$ make prefix=3D/usr/local all doc
> >
> >And with the above 'make' command I got the fatal error.
> >
> >I consulted the Getting-Started-Installing-Git web page that rsbecker
> referenced, and
> >it basically matches the above--except it uses the 'make configure'
> process.  So I tried
> >that method as well, but when I got to the 'make all doc info' step, I
> again got the
> >same fatal error.
> >
> >Due to some "security precautions", I am unable to use 'git clone
> >https://git.kernel.org/pub/scm/git/git.git' to download the source code.
> But I can try
> >to figure out a workaround for that if that is my only option at this po=
int
> to
> >successfully compile git.
>=20
> Did you run 'make configure' before using 'make prefix=3D/usr/local all d=
oc' ?

[Mun] My apologies for not providing that data previously: Yes, I did run '=
make configure' prior to 'make prefix=3D/usr/local all doc'.

Regards,

--=20
Mun

