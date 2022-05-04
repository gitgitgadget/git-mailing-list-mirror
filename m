Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5153FC433F5
	for <git@archiver.kernel.org>; Wed,  4 May 2022 00:23:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244592AbiEDA0o (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 May 2022 20:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbiEDA0m (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 May 2022 20:26:42 -0400
X-Greylist: delayed 366 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 03 May 2022 17:23:08 PDT
Received: from us-smtp-delivery-104.mimecast.com (us-smtp-delivery-104.mimecast.com [170.10.129.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3C4611A82A
        for <git@vger.kernel.org>; Tue,  3 May 2022 17:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=globalfinishing.com;
        s=mimecast20180829; t=1651623787;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=JO28r3jwbZrBtl3uM4nRVtO07mYutauzS2MVeO2fIvw=;
        b=bPMAxPqfkLA9qrUNG6ZsBskR2kMsQFnAuhdXMjtrq4O3M6G6qfDc9rvsTX/UM/38kq0XY8
        I0RJvkeS9MH/Lv6pxSrnFQipQoB8g4ib3Pv6EfrpDe9R60FYcxca8NhtGIkJm2hv4H1yx4
        4o0Jhzg/QqDltbdSaFjQe/6/udZz6Cg=
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-22-g-613kLkOtibygA7nfr5lQ-1; Tue, 03 May 2022 20:15:38 -0400
X-MC-Unique: g-613kLkOtibygA7nfr5lQ-1
Received: from CY4PR16MB1655.namprd16.prod.outlook.com (2603:10b6:910:6d::10)
 by DM4PR16MB5001.namprd16.prod.outlook.com (2603:10b6:8:40::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5206.24; Wed, 4 May 2022 00:15:34 +0000
Received: from CY4PR16MB1655.namprd16.prod.outlook.com
 ([fe80::6d76:e92c:8b8c:10ea]) by CY4PR16MB1655.namprd16.prod.outlook.com
 ([fe80::6d76:e92c:8b8c:10ea%4]) with mapi id 15.20.5206.024; Wed, 4 May 2022
 00:15:34 +0000
From:   Jason Hatton <jhatton@globalfinishing.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Git status extremely slow if any file is a multiple of 8GBi
Thread-Topic: Git status extremely slow if any file is a multiple of 8GBi
Thread-Index: AdhfQzr04ODX/diXS1SG9hOzdxXKnA==
Date:   Wed, 4 May 2022 00:15:34 +0000
Message-ID: <CY4PR16MB1655A1F7DD8B2FABCC30C9DAAFC39@CY4PR16MB1655.namprd16.prod.outlook.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 456b2a93-e2a7-471e-500b-08da2d633509
x-ms-traffictypediagnostic: DM4PR16MB5001:EE_
x-microsoft-antispam-prvs: <DM4PR16MB500158A35140DB993F02EBC2AFC39@DM4PR16MB5001.namprd16.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: aexAYEBBhJLgArpUiS9XOP83vuqBm4DIxMVuOBhnE6GtjXZ2HRaBYR/6wUF9jJZ5gqefi6PXfWUT/2sahPrl25qkHJqVp4TtP6YtidoXy/S8/PCdQzfxLBo51JkLS9xRr9J+zGVfLZUh+RSEOdTvj0RPYnDVzVQdbybnS4R6BncUcTpiHc0QSUMxVAa2fAnrx8te6ycF+7ada+Uk/oEtveO5c0w3xkhUBeTURLTDQlfj5UQdDkAIjx+A8/ZMeegijllS5r6DrfWJoMijk4FtMathME3PHXp/GE7PBI5xbBtOw3i16IQ7tHrkR/25Za/Wjf9ZmjolxGph9RMRwF/BZfBGNeKLqjVbd7l/spTtW/yzDIO0HCc5pDggrUUfr2oqkY9NLi2E3UEv6MlpjLpUoLYAc/ALuWRk9IrPHH8NspCuuJ4oVkrsgITgdm+yfhE7pZDOsPRLIrNhsKXvnLYH+PDt8TaV0vJLhOZkvnJj3RCWSbimgNBOcADJKOT1CRlvXhyctu2+VCF5aIwyvnP8hfEZh9z9SQxAYN9czRPzF+G/dEb22A8NJyjmHCh7/UoHIWzbRIKd68Yxld9oyJ/YkqjCWrx802wcnxkeLZ6MW7gF9P2lmtRVdRcNTDszl75D0tCmPQsnFluLLBtVcXTb9y2n9U3Lq1p/CQkRqCQMWJRMpk0DmBjZbxOB9Gvj/Lyzy3lrgEcx05BEO833Zky5Bajotol2g0bgAejVaLEHRBHog2o7wi2czvlitPsAn0gqkaSc5BdciraJqZIojqEiPoy6EfcKMKACDMTSp05KZE4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR16MB1655.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8676002)(52536014)(86362001)(83380400001)(66476007)(5660300002)(8936002)(2906002)(66446008)(64756008)(66556008)(122000001)(38100700002)(38070700005)(76116006)(55016003)(66946007)(7696005)(9686003)(71200400001)(186003)(6506007)(26005)(316002)(6916009)(966005)(508600001)(33656002);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NlNLcjKeUPwT1Uz+qA5tZJzHeK91VaIp3VoNo7gWbIN0PdJHXAiORdrdwOtN?=
 =?us-ascii?Q?kajmcF1GcPLQjwOUwbpe50WTh+QeHYa6kznGnOS8SgFJ826xGJDEUKOcw7QK?=
 =?us-ascii?Q?zz2Ucrio0XN9cP6s8RtuKlkQtP8GT9bea1gXm1qquBNFvc718p4O43r5Vq7B?=
 =?us-ascii?Q?l9HsKZqT29HAYIpUL0DpnC0gsmnefo10pFiJgl/CG5Pc5GbHAdEDXeAtS1jD?=
 =?us-ascii?Q?jJJwzHTqcvRyUqLTuWXGZYjhKAEZWYLleey4knAxTm4Tiz8ufbolaVwAQHQ8?=
 =?us-ascii?Q?JD87ckp+pMU75yFl0wynSR7lH8JoPMn46ZkbBmfJvpIefOJdah7yZ8MYGmHy?=
 =?us-ascii?Q?6fIFPWiqHxD/vIxiFpZrf8qRrpc3oeQCuBblITiCnfkpvBTxeSIUGhpyhWCO?=
 =?us-ascii?Q?3aqqAuHEDOuzs2sEfbkFn0Cd1HjAxxoSUD0NU8HBH5howqGXK9NQklkKxYgE?=
 =?us-ascii?Q?5UdND6PZnErNadI2W/UqG7SgAGCSletLiEePnGQAtzH1WruKEM6wOFsYh8XE?=
 =?us-ascii?Q?0Tj55+KJQFT5C0msXvAqOweL4iIIrVe/my3z0RvEVgSUo7HDv9LueiCh/7sT?=
 =?us-ascii?Q?pS2/8n2Wl22gta5i3+ndAcmVpmOhuGoCup1pPny7wi3qh0spwwMn1rhkMLqs?=
 =?us-ascii?Q?Ct1rBKYvCa7jcyUVt/cNLn71nRPPYhihosEtCD9TBMUBg8G5lWi3gGVD6oFG?=
 =?us-ascii?Q?CLHVtCEIyljDdb4iJYvdgVmLtU+dad8alF7LYmQQw3F4MadojyyfsoKrCXNa?=
 =?us-ascii?Q?p9nZm0jhIT8QMufxFAM93tASUGz9G9ZHcoQuXy9qAQbyu13saNL1E8x7VelZ?=
 =?us-ascii?Q?zSXqmDLy/8AUnbUj2leqgkKAvQzsrGHAK+GaypkkwI913ukFjK2Eoea4kk7Z?=
 =?us-ascii?Q?5wm45IW2n3Br63xlPTVbuZ+Ju6unkKBLuDNVU+4HtXc8iwJnuJhPvNt+MAdI?=
 =?us-ascii?Q?hiN3EAoQ8euId2Ws+lr16mMuS1hF47tHbROq/FcwrwuldNYIv/ZUcLEz/zSb?=
 =?us-ascii?Q?j9d43ACuRDkxS6bVSOyTb8jWlFfyifRDyVugIDJK79Eih1VxGMtxs/g/k+U0?=
 =?us-ascii?Q?Yac4nc8w8e3SJe7eB63PTlhGKNaek2T2dpzA+oTjzCX9wcozyfbnYpjBDGyc?=
 =?us-ascii?Q?zAzWxeY3xWZDmRUF3m9Z4i+YClATLJndDx3WSNewocOM1iE0pD8j8+NPDsp2?=
 =?us-ascii?Q?GNp3cdu5vHErOJNjkUBqEQ7JTbQF4tkhHctnL9B1DZM9nP1vs4FSd8BEaht4?=
 =?us-ascii?Q?oxog9d1W+xgH+emnC3tnIZEBF3NpSJDx+sen85RJHmqJHpS0s+ftm00HOPfG?=
 =?us-ascii?Q?1Q+aUmGeBFK+8/6LKufCC+/2HCxA3kyRMypRR4gYRUCiuXVRBvgIALP8zQNF?=
 =?us-ascii?Q?wPTA4sCkXNP4GdsMvMdX4CiHMLtJV4on3+rNBGIpdOelAw//7YKJimrEapZv?=
 =?us-ascii?Q?EUWdP30NLKftN7upi9ev1Qm3MTC/mgr+g7Ku1r00oKJVQXoZMHNIk7pcmNDN?=
 =?us-ascii?Q?SjH2/MFa9rEhHDYf3/lyDINz0UlPS7Ddp4KrZdqPg0t252LR3oLvbLOEHzp1?=
 =?us-ascii?Q?gMg+GLjE1boGvsQfRu+qVtvTWTBwD6+PLIOM6raOGzuMt5WAT0y3YY71qjjb?=
 =?us-ascii?Q?k+FIs5HzwgELu30GSfP8w1vpH6gcR27QJk//ni11zjH2Py7kZuaaHfS3APpg?=
 =?us-ascii?Q?JJRkx+L4UXxsuey5S4/1ddKLwNQXQLd5iX6tOXgXtf5ZpHxDh6AS/swAb5ht?=
 =?us-ascii?Q?T5YzdYB/nU+SgDjNM06UaL2RvIRIM18=3D?=
MIME-Version: 1.0
X-OriginatorOrg: globalfinishing.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR16MB1655.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 456b2a93-e2a7-471e-500b-08da2d633509
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2022 00:15:34.0849
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 41026ff0-b4fb-4e53-ada8-a2e2e3e9ec4d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B+buvXvQ96L402YYSbUjwM10SHErolSdZ3dSJZSh5yM5jUdIcBg0NFheSMIxkTdVyZqhz6ijucnnKthAi2PazH/N8Jl2Ok7TN56iGYgsz5g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR16MB5001
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA104A295 smtp.mailfrom=jhatton@globalfinishing.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: globalfinishing.com
Content-Language: en-US
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Git is extremely slow if any file is a multiple of 8GBi. Below is
a working example.

> git init
> dd if=3D/dev/zero of=3D8gb bs=3D1024 count=3D$((1024*1024*8))
> git lfs track 8gb
> git add .
> git commit
> time git status
> time git status
> time git status

This seems related to git using uint32_t for storing the file size in the i=
ndex.
A file of zero size has a special meaning.

I have an open issue on git-for-windows where @dscho has a lot of good tech=
nical
information.

https://github.com/git-for-windows/git/issues/3833#issuecomment-1116544918

I have a proposed idea that may or may not help. Would it be possible for a=
ny
file that is a multiple of 2^32 to be adjusted to a file size of 1 instead =
of
zero? Git is already functioning with mangling file sizes over 4GB in the
index, so maybe bumping up the size of 2^32 multiple files would mitigate t=
he
issue. Using different versions of git would just cause 2^32 multiple files=
 to
be re-checked again, which is the current behavior anyway. 0 would retain i=
ts
special meaning. If the file size is changed from 2^32 to 2^32 + 1, git may=
 not
notice that the file changed because both files will look like they are siz=
e 1.
The ctime and mtime may still catch this.

// Some pseudo code near:=20
https://github.com/git-for-windows/git/blob/dc88e3cd72a2f0bbe2fe513acfc72bd=
66b577851/read-cache.c#L176sd-

sd->sd_size =3D st->st_size;
if (sd->sd_size =3D=3D 0 && st->st_size !=3D 0) {
    sd->sd_size =3D 1;
}

Thanks
--
Jason D. Hatton

