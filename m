Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36E43C433F5
	for <git@archiver.kernel.org>; Wed,  4 May 2022 18:22:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377492AbiEDSYV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 May 2022 14:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376645AbiEDSX2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 May 2022 14:23:28 -0400
Received: from us-smtp-delivery-104.mimecast.com (us-smtp-delivery-104.mimecast.com [170.10.129.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7F2009AE49
        for <git@vger.kernel.org>; Wed,  4 May 2022 10:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=globalfinishing.com;
        s=mimecast20180829; t=1651686468;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=WJefBSubadzFxupQ8tga26XHaNbZCZ9piaUdCmBpfgs=;
        b=J9Q72Jmo5b5DlRMUb3hXywB9OqhQBfmp54sqOyFl3u3UmNleVF9txYrJYs1EjKV1cmwP3/
        qO7z2RjSPP2le6i9wsflYgXCKca+yh72SGP/TM1S1hu0MOLVDqY28WHyZGAVPr8zxnwkz4
        Sc+l/PzYBuEzk6wk6Zg6kVQFSU8PHRY=
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-479-T0wyk1FpNLSTMSgBTUu_9g-1; Wed, 04 May 2022 13:47:47 -0400
X-MC-Unique: T0wyk1FpNLSTMSgBTUu_9g-1
Received: from CY4PR16MB1655.namprd16.prod.outlook.com (2603:10b6:910:6d::10)
 by DM8PR16MB4551.namprd16.prod.outlook.com (2603:10b6:8:2::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5206.25; Wed, 4 May 2022 17:47:46 +0000
Received: from CY4PR16MB1655.namprd16.prod.outlook.com
 ([fe80::6d76:e92c:8b8c:10ea]) by CY4PR16MB1655.namprd16.prod.outlook.com
 ([fe80::6d76:e92c:8b8c:10ea%4]) with mapi id 15.20.5206.024; Wed, 4 May 2022
 17:47:45 +0000
From:   Jason Hatton <jhatton@globalfinishing.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     Junio C Hamano <gitster@pobox.com>
Subject: Re: Git status extremely slow if any file is a multiple of 8GBi
Thread-Topic: Git status extremely slow if any file is a multiple of 8GBi
Thread-Index: Adhf2MbMFWSTh1oNQ/ePfRxjcwYZoA==
Date:   Wed, 4 May 2022 17:47:45 +0000
Message-ID: <CY4PR16MB16558FE8E69B2045435AD59DAFC39@CY4PR16MB1655.namprd16.prod.outlook.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5e97315a-6c8e-4007-7f68-08da2df63269
x-ms-traffictypediagnostic: DM8PR16MB4551:EE_
x-microsoft-antispam-prvs: <DM8PR16MB45510746BEEBDC4CED884D58AFC39@DM8PR16MB4551.namprd16.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: Xfl091C4PKAgCYjtvMPkR0Xz9oBPP4/q8Ww0HgoMiV/+/nSGlie5XvYJN9nBt7rN4ETrK50j8Vvy2KeM9oNuJCGr9K5tX9D5HQf6ZZVo0E63PLyZMJvLSxpO8aXU+DVOQoupizmQYXJu8piy4qRGkEFTStDhCuL67/Jm4XTW5G5UUKjfn45S6xckeEqksvHWQDRcY5kkhkQiSSzS9x/GUt2TBKXRgIrz3x16X7u5mz5rwY+CrOIaWLvezs+3y0jhQgiDwtz75RkEcEest5ty6pUltNHMi65S4oamjLkEuuSNBCIdwIADh/V0AbeXqJFfer8NYPCXR1M/XhEm2u/o7robHEELxMtye4iSjcpB9+cCx3NPYQbWMeCgM/KgnOK/mFBjsqbKJCxnwUB3aodMwKBqqsx1MsI0X8I/+3T8bj1lzUK011l/vEhxmY4tcIueovkum6f/R/7MIzDdfOhcH283/62NNlPYWc7fxoVme98rfi6Nm7nyZrh+aynt1Ac+/pCyaAtFZYLPnQeO2szzdMS2eS9w6cEABigiKGFkz6aSYT5g1GAv8wntS4wJBX6BqgbByaT94YJH03Puc3x1vVx+vkpAgTV4XKX1YwYsYFt/4wAyEtntEwwpt6OdCF9oRtmVpRgCKJu3NKlsoCDKQYmPxU4y05LZNS+V+hvaW13+VKzgaZMiVdAdZOKf+X56By/79mpH49QgOsnksXzYJcLKldMBOm5UBkiAdnAZEfAsdPfxuXIs9uzf1DHCYK5G
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR16MB1655.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66946007)(316002)(64756008)(76116006)(66556008)(66446008)(66476007)(33656002)(508600001)(6916009)(83380400001)(2906002)(86362001)(4326008)(8676002)(122000001)(5660300002)(8936002)(52536014)(38100700002)(38070700005)(26005)(6506007)(71200400001)(9686003)(186003)(55016003)(7696005);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LXqLRyAO/ZMhiZTWDWp7fKIPokm7fLYlSi1IHBUnkLUwe+Henwpg7ct4BXEv?=
 =?us-ascii?Q?10MOYeFwokueIeMz3vjtUjEtYu2uU1XW+ZWnVQPul7532/Ldp/fFDoMa7H+u?=
 =?us-ascii?Q?9PHXxzEKKzf7gHzA9UKPL4ZY1mJemDTbhwlQQqVFrIBaqeulC0hJ85UrHATR?=
 =?us-ascii?Q?iD3GgbEiv+HrkWPmtRhCvWjY6paZmy8EFjoMEzxNjcb4y3ZcnKKIz4XWoTrb?=
 =?us-ascii?Q?xy0Wlvm2kSHyL4ewr9uQE85cAy1EasIxRAekdR6Jb6iQZn99nXD6K3yvxCDf?=
 =?us-ascii?Q?2S3GsvKaq/Zjo6ftgoIYrNQQHJ1STKrgEhg3mG8ryor0UXdfgBmzti5Zo3MS?=
 =?us-ascii?Q?nlEUbbL0eIENV4r/dRPksMu4gpOBpCzD1h2balrRdYKOngA1kkOjrpcLBpZo?=
 =?us-ascii?Q?vcfbaq1HkBCLJ3AkCobCdS6amZrCQjqT/zX0wz+KweVdYAyHCz68Doq9T4K0?=
 =?us-ascii?Q?bCVRBAE6PWGEBtaemxNHP53Xb7P+VPgKCAWcu3URWFTv/nxmuQIF887WfyM9?=
 =?us-ascii?Q?3LQNJ2f8Ngzs8segLE4kKwjfOAwT3RhTc7fdn0vNElhfD9GThN/dD06CFbqZ?=
 =?us-ascii?Q?Si8okE9TFvK3cjk3xL34/yg2QSdLFUMPm5D1bLtvE4DGyK6VgqwNLD6TLflh?=
 =?us-ascii?Q?44CkIjn//zn2XJjdVuE1D6kzqEJ3sjQI7NPKbPb3siB+076mRJt6RYwCNXhG?=
 =?us-ascii?Q?GsGPuPngWEAIX014zJB2eQBKCi+D0S3xYvhbIvHRLhcDKqmsqSvCw94rCR95?=
 =?us-ascii?Q?vIqEa4fRRyDmx4z4sOO7d7zAwyQ095ErfSnsUbnZe+cYL+0xuzy6z7ChTxbC?=
 =?us-ascii?Q?nLIBk5XcdccLju+kGy5bZ9k1joCoYGDcrcpX5sXJA95ZRlPSdHG6R+B88bql?=
 =?us-ascii?Q?nZEXIx+qydXt7Oqm1LtB+x0PudNCiAIXrKI3bbIb43G2v3vScXl+tzOiJXU1?=
 =?us-ascii?Q?gtUP90BbVp2y6eYgnX4t/cizlSCavcL/7G1fst/xcoeK/CSdjz6rz5whtyfr?=
 =?us-ascii?Q?a3ro1e2p39ABy8vD9Gxt6X18wyXs7CUfcpZE7y36I5J6jUxZA7OaA+V0zeCt?=
 =?us-ascii?Q?rT6mqVFS4Emi8PHtXVTB6oi8qduDYL2kahkXXockaj5PbKTtgyF7uRGkIKqN?=
 =?us-ascii?Q?QlKvBtwtipfDYfUB8fQnr7dw0LMZkEq0BtwDEu9wNjPpwyrcFzRcWYPXZjXE?=
 =?us-ascii?Q?uKu89g/i9VODp2JBFvLpKxkuxLpNY82HIPEE8Vo3p87wQPCcZSYpxZZ5SwAq?=
 =?us-ascii?Q?7TxTfULLHDFTY0aSNajZDaYhL+f73+iiBkEuLU4UNqOD+gsECHKfSgeubupB?=
 =?us-ascii?Q?D4GXFJAXxwjwAGiYlzghnO+LKlQ23xtruFuHle5gk116CF+DF95x+52L6vlk?=
 =?us-ascii?Q?vfYpm4gXSaCCWTy5jX+ud93yqn+Ycp6xuXqtSJqqCnY0INPpE0cB+XZ/ovOe?=
 =?us-ascii?Q?/Jds0/9xDfIqfJnWvqNsCgMAPuks8Va099KIXWv0Jw27C+M9Ev4y5NOYHCZO?=
 =?us-ascii?Q?xTWd3eOYg+GEWvcovojZVGuKJ0LBIy0ZHPTyL2LsG6Tp2XvfMDuTfy55O2LC?=
 =?us-ascii?Q?pry73ifzo+Asuhbh/pgA6ABw81iurKz8/55dZaYQkekNs+IDxkgSCJJ6xTHU?=
 =?us-ascii?Q?tRojnMfIi6IR7+xS9j4AEQXCMzXxkzQ/edqCDF/qjrsRjnxpyPzRLUvRZwWG?=
 =?us-ascii?Q?yF5jMToYniUz+TJ46sR5vJFXyBu0asVQyfsPYppDAPat3+njbVFesPbTtEVS?=
 =?us-ascii?Q?d81+EuAANvM4lQu0rKs0+wy2fn2ijGI=3D?=
MIME-Version: 1.0
X-OriginatorOrg: globalfinishing.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR16MB1655.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e97315a-6c8e-4007-7f68-08da2df63269
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2022 17:47:45.6857
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 41026ff0-b4fb-4e53-ada8-a2e2e3e9ec4d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ln6bGX5Q4xHwTWRuyBPF8+/ae7hQmLHoyu8jcy4wqOuKeae1F017+UUudrDUEO7J1l7Ywdmx8VfO2DM4/9sSAb8a9Km6SsRz6GfvnuziKg4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR16MB4551
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA104A295 smtp.mailfrom=jhatton@globalfinishing.com
X-Mimecast-Spam-Score: 1
X-Mimecast-Originator: globalfinishing.com
Content-Language: en-US
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > The condition sd_size=3D=3D0 is used as a signal for "no, we really nee=
d
> > to compare the contents", and causes the contents to be hashed, and
> > if the contents match the object name recorded in the index, the
> > on-disk size is stored in sd_size and the entry is marked as
> > CE_UPTODATE.  Alas, if the truncated st_size is 0, the resulting
> > entry would have sd_size=3D=3D0 again, so a workaround like what you
> > outlined is needed.
>=20
> Junio C Hamano <gitster@pobox.com> writes:
>
> This is of secondary importance, but the fact that Jason observed
> 8GBi files gets hashed over and over unnecessarily means that we
> would do the same for an empty file, opening, reading 0-bytes,
> hashing, and closing, without taking advantage of the fact that
> CE_UPTODATE bit says the file contents should be up-to-date with
> respect to the cached object name, doesn't it?
>=20
> Or do we have "if st_size =3D=3D 0 and sd_size =3D=3D 0 then we know what=
 it
> hashes to (i.e. EMPTY_BLOB_SHA*) and there is no need to do the
> usual open-read-hash-close dance" logic (I didn't check)?

Junio C Hamano

As best as I can tell, it rechecks the zero sized files. My Linux box can r=
un
git ls in .006 seconds with 1000 zero sized files in the repo. Rehashing ev=
ery
file that is a multiple of 2^32 with every "git ls" on the other hand...

I managed to actually compile git with the proposed changes. It seems to co=
rrect
the problem and "make test" passes. If upgrading to the patched version if =
git,
git will rehash the 8GBi files once and work normally. If downgrading to an
unpatched version, git will perceive that the 8GBi files have changes. This
needs to be corrected with "git add" or "git checkout". If you people are
interested, I may be able to find a way to send a patch to the list or put =
it
on github.

Thanks
Jason D. Hatton

