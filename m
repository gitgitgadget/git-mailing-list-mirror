Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66408C433F5
	for <git@archiver.kernel.org>; Fri,  6 May 2022 00:27:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387568AbiEFAaq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 May 2022 20:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352286AbiEFAao (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 May 2022 20:30:44 -0400
Received: from us-smtp-delivery-104.mimecast.com (us-smtp-delivery-104.mimecast.com [170.10.129.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4A03215FF5
        for <git@vger.kernel.org>; Thu,  5 May 2022 17:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=globalfinishing.com;
        s=mimecast20180829; t=1651796821;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=/o96+vKuKOAPEO33i7qB/rafPIHTWrjlT9C/+ScdE2o=;
        b=LIbyYioTAzuTU5apoWKeq8ZDv6d9vDhrakicIG5XX8Gam/SOkN96QsVUPYCvh1AQIai9ld
        rgm5K6mNyNhOYseamux3mbbHS1e7LQuCJevscgZVYWXw+jM6I9rXXVHklenuxYyGy8Qbqg
        IMLKKNoJVsYu/xIgmKs3vVUlU+rO7aE=
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-235-7QowixBmO6ScDV-MhR6Gvw-1; Thu, 05 May 2022 20:27:00 -0400
X-MC-Unique: 7QowixBmO6ScDV-MhR6Gvw-1
Received: from CY4PR16MB1655.namprd16.prod.outlook.com (2603:10b6:910:6d::10)
 by MN2PR16MB3582.namprd16.prod.outlook.com (2603:10b6:208:163::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.25; Fri, 6 May
 2022 00:26:53 +0000
Received: from CY4PR16MB1655.namprd16.prod.outlook.com
 ([fe80::6d76:e92c:8b8c:10ea]) by CY4PR16MB1655.namprd16.prod.outlook.com
 ([fe80::6d76:e92c:8b8c:10ea%4]) with mapi id 15.20.5206.027; Fri, 6 May 2022
 00:26:53 +0000
From:   Jason Hatton <jhatton@globalfinishing.com>
To:     Philip Oakley <philipoakley@iee.email>,
        =?iso-8859-1?Q?Ren=E9_Scharfe?= <l.s.r@web.de>,
        "git@vger.kernel.org" <git@vger.kernel.org>
CC:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] Prevent git from rehashing 4GBi files
Thread-Topic: [PATCH] Prevent git from rehashing 4GBi files
Thread-Index: Adhg33aOJ0Ra5s3oR3q4L+LbW+ficQ==
Date:   Fri, 6 May 2022 00:26:53 +0000
Message-ID: <CY4PR16MB16552D74E064638BEC11ECB1AFC59@CY4PR16MB1655.namprd16.prod.outlook.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9cb618fa-218a-4faa-404c-08da2ef71eb0
x-ms-traffictypediagnostic: MN2PR16MB3582:EE_
x-microsoft-antispam-prvs: <MN2PR16MB3582ECF1F8265D2E50D4E0FFAFC59@MN2PR16MB3582.namprd16.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: nvbp/+OsGLs1gGbVnHqUYHHkPo3H9zSUCwITl8ZNgkkT5/vx4I/N2xV2yho8hpzWpYkDiYpzmW/18YAGUzXTlgtDqzNKFVUD6/qmMf3Ue3L+b2CgyZZ41rXdhE7TnELP6+MHC3UbSwo9qhNlVUrsPqVNQzknCyK1SsQ7AgnskbWYCCJcMbO5vP8eaSV1hW5YxOo+U5DD8VTUydC4Z+w5WkrO9dkFkSPWUd3D3qfJvyYd5AlsoaYtEZvpKMPN1buUkRXetTGWhicGD9JZglIIfknyP0WfPfsZJtvw5hMHTN9LEwRoF6nOzvkmvPxiZq+xa1Z7Hh90gbO25LXY4HBeSCLgJrH1/0qHCqEvbM58QYeNaAaJ23zmTNjkjg/J5u7zfGpCB12wN+IcLdlrbzDrecqeDWUsmJrj1S7r9YSoHxO7PzJS0FJDtgruRYtT9OieCLWhIsbuI7eCw4iDiEOsWvivQRkKkbEuFDBJl47k/rOmFfJ2vdLbXMQ7Hkysz2HgHd+WOwZ+tFrtNJtKLtdeS0Jf85N94nwCnX4iwektvxLAKUmVb3nr0jPlp4dLMyHoq3nXyYf7EGJFOdtdN0dB5jgB8UZC9kSjDZx5ZPq012fRl2nwBbtT8MaTAuDwdRxdHsayNl2nKz5Fp8gvV7fTdSPev8ry7pwtz6ptXXWRAsvpHgkdpEZO1KBkqMz6+egt0vZ8b9ygszsu9MalWige1g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR16MB1655.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(110136005)(186003)(38070700005)(66446008)(64756008)(66556008)(66476007)(55016003)(26005)(38100700002)(76116006)(66946007)(8676002)(4326008)(122000001)(316002)(5660300002)(52536014)(86362001)(6506007)(7696005)(2906002)(508600001)(8936002)(33656002)(71200400001)(83380400001)(9686003);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?maqwtxrD4WhkfEOZsLKIKWE1yrnZcPbSRthLttCJm1vpUJNIKJcjjtnMMi?=
 =?iso-8859-1?Q?k7CsufPR7ZITprvHnQAo4U5ZwQmpZoh0mrk2uMUooViGILdMwUAqrHBenp?=
 =?iso-8859-1?Q?s/FK+K3YrUjkyZVHWENEh3gM6PQzBlIYIzSsaUgtZtCZ/+fSWPf9Gz5im6?=
 =?iso-8859-1?Q?/oxXit2AZvxNjmLCpEmODuAqHgDhUj+qX0Rg/YioIOKaiSYJfUrbMRi5+v?=
 =?iso-8859-1?Q?BRBuSUBY1mCgwAbRQj3KmvD2iEmjvyCetvHWjVehZ6wPceKq0uxso1bCFf?=
 =?iso-8859-1?Q?aSb4QxIS+yppZIxvXdMzoFBB5+b6CJCZoLj2rF0iPus4oY60EABj7/quiN?=
 =?iso-8859-1?Q?HQt/TlxdYrD7MV0SBphWDM36XF32Y5FKNWui7HTrYveNVVniHKH3wNGKFH?=
 =?iso-8859-1?Q?wAHNlVQyEBuEbMIWo0Bd+Ra3vXT2iSFfc5iesaq4Qjfrq0aogtj78H0wia?=
 =?iso-8859-1?Q?4+HxNovEJ74OYW8X1NFyiSoYcEr6kjBL/jZhpXoUnmd6LwTsDIiJKInc4y?=
 =?iso-8859-1?Q?s1abkgSJ1nzwxTb4YczcDqj4iiZU1PVCHBbgv6K3BUFfpTo2+ZrzFfbXfl?=
 =?iso-8859-1?Q?xqox2Jq7z790XriJnKen1Hq0WQz+rkfATERTTzb3f5HyoWhu8oeaswDWp7?=
 =?iso-8859-1?Q?rskzSu+oXJoSjZwqI7z8l0nJDI3awPuCyKjU2Fd9utzWXQepgHsHrZgoYL?=
 =?iso-8859-1?Q?nrhqb5v2MdUeeUdyphHJXh3hCUpoheF8+w1zn3RJOJc0l/BHr8ar7UyTXV?=
 =?iso-8859-1?Q?Ppzh4ny3/gjxuMO5/u3gPP+LugZTKx0HB19AarCkKsVJjYBrCwWLz/ati5?=
 =?iso-8859-1?Q?PmFP9cqUu20g8TUJ4IjRzGeX0csBQJTgtqTwItiHIKeNYR9nld0jHOvNPQ?=
 =?iso-8859-1?Q?4xz2bTMwwg8x9qdeSnrRcbMnQpHjJtqZkDmFj+gz6ukJNEVwMV5JGKUEGq?=
 =?iso-8859-1?Q?CvKuywZ3HMhiFSP1Vaxn+VnmdwTdgwcHbYhdL3qXjh/DOG8wiVYF9AdMHH?=
 =?iso-8859-1?Q?21h2HeuMBLwI8cWUTd2a1IJGTjNMtXMNMH5ajW/TTLWZ+QF33c3n9rml1c?=
 =?iso-8859-1?Q?vhK7ezVb/vyzTSkGgoFubBuJx++DFZvIJ0pv+Bj4uCIV2vZVnIgdrWYWiq?=
 =?iso-8859-1?Q?t7f2QXRkCdSCEsJkX2g24dDAB0CNJpVn37A5qFi0HleSopgtUaK1H5sYD/?=
 =?iso-8859-1?Q?7scdvwnzA9RE/ddtGsThEC8+Ro1nnLUBvdv+1kKCOtAK+GxLY36rOh9kt/?=
 =?iso-8859-1?Q?r342mapHDiPibDoHIgiLmSvafHCqT4Y8w/78XME3Ppcfe36cAI7msv9AzQ?=
 =?iso-8859-1?Q?ZIJ3Nw2TK0S2SphUYv1tppzd26S/JRuuzqISeav66vm4R0228BT8TCv5x0?=
 =?iso-8859-1?Q?ll2u5xMUDcRrGUefnW52d2OcK56A4kXZl7XUdTaUa/j4v5Z36GIllePnKJ?=
 =?iso-8859-1?Q?DCgeznF88dhAQT0qPUku5hN9CYGpTWQMKigHubBSB3Dyl5amTJAPEsv94Y?=
 =?iso-8859-1?Q?+0mV7SROfmEBjwllGe2rjbBXLKaLFGWNs3eZO8r4UdI7/D+m5nDlHp8tA6?=
 =?iso-8859-1?Q?28r0HFVUjxbdrplCzardrRbRVfmAIPaB+mulJkDgCtXr4h5QwHXq8zos+E?=
 =?iso-8859-1?Q?TjH8Sx5lmW5xERi0/L0+tzLzMxgBXctDr/wX+oyhUJKA6phDML5POgmw12?=
 =?iso-8859-1?Q?NyOFRr4Ucp4jx8zrvggg3Ry4ddVQQ22vInpjsb/en6bFBk7RtxgulGDB2g?=
 =?iso-8859-1?Q?05P0PXyCJJgQWHek9/uRxIgZM+/7r8oq4LZB6fCL08+tQi9SoSpncbVX0L?=
 =?iso-8859-1?Q?5pQX45YIxHQpDfOoIgBgAL/4FGsdTRo=3D?=
MIME-Version: 1.0
X-OriginatorOrg: globalfinishing.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR16MB1655.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cb618fa-218a-4faa-404c-08da2ef71eb0
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2022 00:26:53.2544
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 41026ff0-b4fb-4e53-ada8-a2e2e3e9ec4d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5wgcufZeHU0rSywj//NbTW3QEQ6EK98j4Gdmnv1VKLB5NyuFROiYnkHl4IzGT4+XtiV9teAJnVQaDZwrmF/X2qNEh29KNguadSN8crWemss=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR16MB3582
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

Git cache stores file sizes using uint32_t. This causes any file
that is a multiple of 2^32 to have a cached file size of zero.
Zero is a special value used by racily clean. This causes git to
rehash every file that is a multiple of 2^32 every time git status
or git commit is run.

This patch mitigates the problem by making all files that are a
multiple of 2^32 appear to have a size of 1<<31 instead of zero.

The value of 1<<31 is chosen to keep it as far away from zero
as possible to help prevent things getting mixed up with unpatched
versions of git.

An example would be to have a 2^32 sized file in the index of
patched git. Patched git would save the file as 2^31 in the cache.
An unpatched git would very much see the file has changed in size
and force it to rehash the file, which is safe. The file would
have to grow or shrink by exactly 2^31 and retain all of its
ctime, mtime, and other attributes for old git to not notice
the change.

This patch does not change the behavior of any file that is not
an exact multiple of 2^32.

Signed-off-by: Jason D. Hatton <jhatton@globalfinishing.com>
---
 cache.h      |  1 +
 read-cache.c | 16 ++++++++++++++--
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/cache.h b/cache.h
index 4b666b2848..74e983227b 100644
--- a/cache.h
+++ b/cache.h
@@ -898,6 +898,7 @@ int ie_modified(struct index_state *, const struct cach=
e_entry *, struct stat *,
 #define HASH_SILENT 8
 int index_fd(struct index_state *istate, struct object_id *oid, int fd, st=
ruct stat *st, enum object_type type, const char *path, unsigned flags);
 int index_path(struct index_state *istate, struct object_id *oid, const ch=
ar *path, struct stat *st, unsigned flags);
+unsigned int munge_st_size(off_t st_size);
=20
 /*
  * Record to sd the data from st that we use to check whether a file
diff --git a/read-cache.c b/read-cache.c
index ea6150ea28..b0a1b505db 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -163,6 +163,18 @@ void rename_index_entry_at(struct index_state *istate,=
 int nr, const char *new_n
 =09=09add_index_entry(istate, new_entry, ADD_CACHE_OK_TO_ADD|ADD_CACHE_OK_=
TO_REPLACE);
 }
=20
+/*
+ * Munge st_size into an unsigned int.
+ */
+unsigned int munge_st_size(off_t st_size) {
+=09unsigned int sd_size =3D st_size;
+
+=09if(!sd_size && st_size)
+=09=09return 0x80000000;
+=09else
+=09=09return sd_size;
+}
+
 void fill_stat_data(struct stat_data *sd, struct stat *st)
 {
 =09sd->sd_ctime.sec =3D (unsigned int)st->st_ctime;
@@ -173,7 +185,7 @@ void fill_stat_data(struct stat_data *sd, struct stat *=
st)
 =09sd->sd_ino =3D st->st_ino;
 =09sd->sd_uid =3D st->st_uid;
 =09sd->sd_gid =3D st->st_gid;
-=09sd->sd_size =3D st->st_size;
+=09sd->sd_size =3D munge_st_size(st->st_size);
 }
=20
 int match_stat_data(const struct stat_data *sd, struct stat *st)
@@ -212,7 +224,7 @@ int match_stat_data(const struct stat_data *sd, struct =
stat *st)
 =09=09=09changed |=3D INODE_CHANGED;
 #endif
=20
-=09if (sd->sd_size !=3D (unsigned int) st->st_size)
+=09if (sd->sd_size !=3D munge_st_size(st->st_size))
 =09=09changed |=3D DATA_CHANGED;
=20
 =09return changed;
--=20
2.36.0

