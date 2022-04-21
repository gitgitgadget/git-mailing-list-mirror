Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A154C433F5
	for <git@archiver.kernel.org>; Thu, 21 Apr 2022 08:31:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386685AbiDUIdr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 04:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386689AbiDUIdp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 04:33:45 -0400
Received: from esa.hc3962-90.iphmx.com (esa.hc3962-90.iphmx.com [216.71.142.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E95813EB0
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 01:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=qti.qualcomm.com; i=@qti.qualcomm.com; q=dns/txt;
  s=qccesdkim1; t=1650529856; x=1651134656;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=kQN/o0JztIX2Y6WSB0SZPx5YqlypfiYYC4Xbus0OAws=;
  b=vjw9sKj4db2PORJyUrxZBkGmwv3wJNejnwSsJJEX6tRnwfL7RvfscZh9
   EhM4q1YmjG4GqxV/lEpV/I7a4594FQqL+oUhZNSF39FHN7xKkesKHbNGg
   fb5W75o1fnwzsQCKNGtw19ibx71XRWda9X/vwtdkZSQsrPpzqa319Nw/e
   M=;
Received: from mail-bn8nam11lp2170.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.170])
  by ob1.hc3962-90.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2022 08:30:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hbVcYG7f1GVwniw4sBhiQl1yyLqr3VSNGDw4O+OuzDadzTdzA1wKViL5GvxMvIuDvD6A2RAsGyZsJkJB2LrWCLuvXKmoLNqyfKBCrNHQz/5IeM/emUxdGXVJ2+XIhHnpgAXhAS/8HO2wSlDFmzUhqnTw7CNf4VqZpZpowUhdZAKmlIhTpocf3b0zHgOd02keW3iW45h9lWUCxp71wPjC9sFtSxwk5BDp0/6BMVTkq/jTVc5XeBtUBzEoR2Nx5sGLBs8VYjybPBi/XouWN2SSvBXSSLIQ3BcCTUHOj5Jslrx2rx0g74LTOq3guGZRSC5q0ch5BxFHRKaZO3oYRUo+xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kQN/o0JztIX2Y6WSB0SZPx5YqlypfiYYC4Xbus0OAws=;
 b=AJwXCrNYoGg1O5XR8yjtQYYkTlzFSo7QGl5xrT3N2oqRFHOO58rMbArFs5i9tWv3VMYQ6N9GtCcwhI1TWU/7AugCJQHYA4WncZ232RjBK28J2evxMsZugCwzNc/kf63pcBPLP2Wjx514qf3nNBC9A5wPPCcG//ThMgrKtSVLqCOCc8NkBY/+HMjCjUSknP56HNrNf6q7BkMinFOO56PcUYtZVO4TDzTF3PHWngCcfqdv7qxqe6t4N5VrL6ViNhjaA3+x70kQdf8ORFrzQMRDMKFqZzgEbGJMP1JJ1PWdDj/RbRbvHCT0I0Z5hvIgF/bZphSXjyBU0Y1MT9Vx0+tuQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qti.qualcomm.com; dmarc=pass action=none
 header.from=qti.qualcomm.com; dkim=pass header.d=qti.qualcomm.com; arc=none
Received: from BN0PR02MB7919.namprd02.prod.outlook.com (2603:10b6:408:162::13)
 by DM6PR02MB4203.namprd02.prod.outlook.com (2603:10b6:5:a3::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Thu, 21 Apr
 2022 08:30:51 +0000
Received: from BN0PR02MB7919.namprd02.prod.outlook.com
 ([fe80::6df3:4624:5a08:c05e]) by BN0PR02MB7919.namprd02.prod.outlook.com
 ([fe80::6df3:4624:5a08:c05e%9]) with mapi id 15.20.5186.014; Thu, 21 Apr 2022
 08:30:51 +0000
From:   Jason Morgan <jasomorg@qti.qualcomm.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: git push locks up forever, file protocol
Thread-Topic: git push locks up forever, file protocol
Thread-Index: AdhVWXyk36NxwdF5TliwtYmSnunChgAAEsZg
Date:   Thu, 21 Apr 2022 08:30:50 +0000
Message-ID: <BN0PR02MB79195847F60CA239AE9F5CE3F2F49@BN0PR02MB7919.namprd02.prod.outlook.com>
References: <BN0PR02MB79194599872BD3693CD72CF4F2F49@BN0PR02MB7919.namprd02.prod.outlook.com>
In-Reply-To: <BN0PR02MB79194599872BD3693CD72CF4F2F49@BN0PR02MB7919.namprd02.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=qti.qualcomm.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cf984d4d-e56a-4d79-4657-08da23713e50
x-ms-traffictypediagnostic: DM6PR02MB4203:EE_
x-microsoft-antispam-prvs: <DM6PR02MB4203DB1E9518CBB601C86C0FF2F49@DM6PR02MB4203.namprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Yr+G1PgVK3t/i/QRnQ1nvTWzH6TyuWtAPJ+BPUPt62xif7W0qfpFWPASHt7LK+ehPNxcuzKhAW2Y10xVVLJnFZc1qLpBXM8qHSH3L0GDaqWjdvY+EZ6T/ZiIOqvsxA3FVr8YknH6n4O29T5LkhT1DAMl2aDLjhTifZbjrowe7Zwp7wl6Z00e7wyGCGbU5Os7GfOdFW7C3/Nq8Yr1Ub+EHBSdabUgqfav0eYwj8gB2jcgogj8e+yisbeCDUb/gCUFMrRXUehQIMfIVbQRblPMiHkQQVfjMlnaV5XBbNdfKHtzDCixnhCIw7zY0j4+NEOiKYKvTpLorXn5f+rXiSzBrTKpkucJgFom9KRCL2U/vkgqvl9enltmv7fNZvtMWTvfWoBSsh8QKAp1pq4uopdlyx5QSfjEP0vAhRzvl2405AmWV1U2/Q5ReDIgxrg3kr3tpYRqvDP83xBIUWxHFaZEf8u9xeqep7ciEEscDC2WoiIP6THt4O2FvT3CRT9dvdz0EHx2kCCQ5RNs5TDZymVmh+1sXhEVrvRRuM15NZc1BkUD168pF8aVNW+j+wWoxVi496tnGZDSLfhTePogDqCBApwARENRA+YU98WRzlPGgUuPr5nhMpgr4bdLr1BhhBLB3dcQGZjXZiOAh7GV35/uX4G+OQH+x1cP1U+BOMCIpvHNgUZXdudI888/geBg2bBqscbpFIdAmzJF4SVT6NEzzw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR02MB7919.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(52536014)(8936002)(71200400001)(33656002)(38070700005)(5660300002)(83380400001)(508600001)(55016003)(38100700002)(9686003)(86362001)(26005)(2940100002)(122000001)(186003)(6506007)(7696005)(2906002)(316002)(66556008)(66946007)(8676002)(66476007)(76116006)(64756008)(6916009)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ErEVv6/W+o/63zsk1ps23fYXTDr7jzBFrBorcLBquzgr5/KVeJ81M1cu4S?=
 =?iso-8859-1?Q?yIGqYrDUFvgfMkJkuN39vGXVRdL8A8c/gGZlejhRzlyj5pjz3KgpnYq4rD?=
 =?iso-8859-1?Q?IS1Ji4f1tjDwdQ566k7gFe5chufeHnYxRqSjIfn7aYN9eY8TLUQID0d9P6?=
 =?iso-8859-1?Q?1jQta5GURdaAW+XJ7ElnYQeOkqsq7j+YOVhco3By5bSnS95o6gL7YZUJj3?=
 =?iso-8859-1?Q?/S8EmPNpfnqwqYA7dTTOIG8AUH16g28wwaWqNZ2fVqnaC9Z/kQHBrUmp9e?=
 =?iso-8859-1?Q?Meyn30vDcDtBygy/n5d2aFRovq+xTkQM1TuEwCMnrSYiK3kyIy2DMHNfUT?=
 =?iso-8859-1?Q?zYgi5iULq4vI2v73CX/3qrB2mQiMAjQTX4aIU5xu4JDaSZdQbWHzLIxi7P?=
 =?iso-8859-1?Q?BGkg9f3Sj0Fn4Cn58R6UUr+dhEfwy4PWtI1WSunFlRv3hL3MiBSy2Uaxdm?=
 =?iso-8859-1?Q?HxTJKqfohqFXVXNHAQezUqI9X+iLKGbHL3YBTfEkrd+jlKGbgdrl6sSiBk?=
 =?iso-8859-1?Q?wBsWPblFoh6taGXXgR8rr6zO3EXcE1FF9+pwrw56d0L1dkmFgZO2sneEce?=
 =?iso-8859-1?Q?qyaHHNh5bm4+Eq2Sl23pHOKzgqjmd5NeO8eGhwext/5rLK3idKI42PAS9e?=
 =?iso-8859-1?Q?vYVMHLhb/q2SYkCc3mF1qNKf7/DArUwRxCTS2zdJZkmMVVLCMgqrwaZS/I?=
 =?iso-8859-1?Q?S4JM8a5Hd/aPJcvFTslzAfOJyY4io7uX5WhnjD3hNpE+f3NkV4Vq8W+a49?=
 =?iso-8859-1?Q?OBRWuuEAcvcg5VMRgsVDP/tspWhHSU6gvHO/h1nvwqP9mC83GCbAvEywSE?=
 =?iso-8859-1?Q?TGg/sf5zCPU52Tcq7PpaPHRchU8821cnGUT5BvEGme+3fbnp5v1knQ7Uei?=
 =?iso-8859-1?Q?NlE4D/nC88BGKXXOQp5d4PErB6ZUZzOCciw6iIA00axcjRQ8Mdtai54imZ?=
 =?iso-8859-1?Q?pcHLBtcVjVGCzIm576dQjVJcSjQ9Kgrsdai+Vllps8GgqX9OmdMmvExVa1?=
 =?iso-8859-1?Q?hKy/yYj66szQaB9oMPW5/9mXAwYjM8jLPJ4LHjS66Az+slMbQzEeue0hxl?=
 =?iso-8859-1?Q?V2TpGqa7oS76JgFIPWUXp3d64LrYcDHKEXHXwZlLxCJNmXFXfdIQ1U3VCz?=
 =?iso-8859-1?Q?p6vHBu2siR+s2VsEfIOyP94v5XYx3MHEJIdeykknCerfCTKFyt3Fc5HW1Y?=
 =?iso-8859-1?Q?7jnw5lTCE96jLH1G79tKxlThs/3wGdQAqZ5EOOuJ/f1qM3bb87Vl3LEC2v?=
 =?iso-8859-1?Q?AfwDjnR/KODp300aDr/RLyqhLESfvpzuNEJXnFATaoacJ71VcvMXuianXW?=
 =?iso-8859-1?Q?qchStTDxg/lZUCWbvdyMCzJpxxzFZsYl8xSKY0kCoMxpNyG7TGbdK0d7Dh?=
 =?iso-8859-1?Q?0a4BfDYbV2XxiYLQ+OWTthdqRlX8D30ExOm/iOmX+JXR4YMj1n2FCObpLZ?=
 =?iso-8859-1?Q?Z/9JP8HjeD8wY572uEsf0jxJYF/ChKiyaFNBuzB8niNKMuKEhG4xV/DKFB?=
 =?iso-8859-1?Q?Vj0X644dN63/QpDVDfFLcVTrtOr2ouZQBrjVawr9BKQaFeJeR3wmdbsra8?=
 =?iso-8859-1?Q?dApdf/0tXl1asVC4ZwGb77yl3cMo4kkwa3mg8YdsHMC7fWK8sq/L+Zm5pf?=
 =?iso-8859-1?Q?4Mi3B14eIY5b0pzUbTEO9HkRCke1fAyTXrS7/Bl/aYX8PtoQHLDgZk4DCA?=
 =?iso-8859-1?Q?6Pp4XdeJ/f7UM8ZgJzK8NCjAJcMf1kQyJy8MuMQlnO+IH/lnGvQmO9iYA5?=
 =?iso-8859-1?Q?0d6Ky0DFkrDBpFL4r+k2pI2D+cJwCIcXp40/ZhSop8IMVUuBzwVTKMmmpE?=
 =?iso-8859-1?Q?ztUkW9ZRWQc3hpmPifjKUjqXlJ7qNac=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: qti.qualcomm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR02MB7919.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf984d4d-e56a-4d79-4657-08da23713e50
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2022 08:30:50.9602
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pD+kpKKhv7WN/muzXw5vv++vwhZZ/I937v/DBr5CIqb1mbuo+9f/Jj5+BRT9nRm+IBYwI5lV/Wnz1aoCvj2pAz0eI/9zAoWPl4u7DsX96+0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4203
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

We have a remote repo accessed using the 'file:' protocol, mounted over Sam=
ba using drvfs into a WSL2 instance of Ubuntu 20.04.

We find a 'git push' waits forever. git version 2.25.1

Over a local LAN this works fine, but over a VPN this fails, hinting at som=
e sort of race condition.

Output from strace hints that git is trying (and failing) to read from a cl=
osed file handle.

Final output from strace:

-----------
openat(AT_FDCWD, ".git/objects/ad/065dad4384ae8c81c120c562985078d1f7b34b", =
O_RDONLY|O_CLOEXEC) =3D 3
fstat(3, {st_mode=3DS_IFREG|0444, st_size=3D152, ...}) =3D 0
mmap(NULL, 152, PROT_READ, MAP_PRIVATE, 3, 0) =3D 0x7f3e0e4af000
close(3)=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D 0
munmap(0x7f3e0e4af000, 152)=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D 0
openat(AT_FDCWD, ".git/objects/30/2508dfe5201db6c000ebf17b0c69e3afb31218", =
O_RDONLY|O_CLOEXEC) =3D 3
fstat(3, {st_mode=3DS_IFREG|0555, st_size=3D214, ...}) =3D 0
mmap(NULL, 214, PROT_READ, MAP_PRIVATE, 3, 0) =3D 0x7f3e0e4af000
close(3)=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D 0
munmap(0x7f3e0e4af000, 214)=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D 0
openat(AT_FDCWD, ".git/objects/d2/2323ec2ec40a74fbd519509662254c3cfda206", =
O_RDONLY|O_CLOEXEC) =3D 3
fstat(3, {st_mode=3DS_IFREG|0444, st_size=3D161, ...}) =3D 0
mmap(NULL, 161, PROT_READ, MAP_PRIVATE, 3, 0) =3D 0x7f3e0e4af000
close(3)=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D 0
munmap(0x7f3e0e4af000, 161)=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D 0
access(".git/hooks/pre-push", X_OK)=A0=A0=A0=A0 =3D -1 ENOENT (No such file=
 or directory)
write(4, "00953ea50e3c1f49c33f7dbbb5e3a310"..., 149) =3D 149
write(4, "0000", 4)=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 =3D 4
pipe([3, 6])=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 =3D 0
fcntl(6, F_GETFD)=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =A0=
=A0=A0=A0=3D 0
fcntl(6, F_SETFD, FD_CLOEXEC)=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D 0
mmap(NULL, 8392704, PROT_NONE, MAP_PRIVATE|MAP_ANONYMOUS|MAP_STACK, -1, 0) =
=3D 0x7f3e0d641000
mprotect(0x7f3e0d642000, 8388608, PROT_READ|PROT_WRITE) =3D 0
clone(child_stack=3D0x7f3e0de40fb0, flags=3DCLONE_VM|CLONE_FS|CLONE_FILES|C=
LONE_SIGHAND|CLONE_THREAD|CLONE_SYSVSEM|CLONE_SETTLS|CLONE_PARENT_SETTID|CL=
ONE_CHILD_CLEARTID, parent_tid=3D[12802], tls=3D0x7f3e0de41700, child_tidpt=
r=3D0x7f3e0de419d0) =3D 12802
pipe([7, 8])=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 =3D 0
stat("/usr/lib/git-core/git", {st_mode=3DS_IFREG|0755, st_size=3D3093072, .=
..}) =3D 0
pipe([9, 10])=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 =3D 0
rt_sigprocmask(SIG_SETMASK, ~[RTMIN RT_1], [], 8) =3D 0
clone(child_stack=3DNULL, flags=3DCLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|S=
IGCHLD, child_tidptr=3D0x7f3e0e1dae50) =3D 12803
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) =3D 0
close(10)=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 =3D 0
read(9, "", 8)=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 =3D 0
close(9)=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D 0
close(7)=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D 0
close(4)=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D 0
fcntl(8, F_GETFL)=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 =3D 0x1 (flags O_WRONLY)
openat(AT_FDCWD, ".git/objects/3e", O_RDONLY|O_NONBLOCK|O_CLOEXEC|O_DIRECTO=
RY) =3D 4
fstat(4, {st_mode=3DS_IFDIR|0777, st_size=3D4096, ...}) =3D 0
getdents64(4, /* 22 entries */, 32768)=A0 =3D 1328
getdents64(4, /* 0 entries */, 32768)=A0=A0 =3D 0
close(4)=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D 0
fstat(8, {st_mode=3DS_IFIFO|0600, st_size=3D0, ...}) =3D 0
write(8, "^3ea50e3c1f49c33f7dbbb5e3a31017f"..., 83) =3D 83
close(8)=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D 0
Enumerating objects: 31, done.ts: 1
Counting objects: 100% (31/31), done.
Delta compression using up to 8 threads
Compressing objects: 100% (23/23), done.
Writing objects: 100% (23/23), 5.60 KiB | 212.00 KiB/s, done.
Total 23 (delta 14), reused 0 (delta 0)
[{WIFEXITED(s) && WEXITSTATUS(s) =3D=3D 0}], 0, NULL) =3D 12803
--- SIGCHLD {si_signo=3DSIGCHLD, si_code=3DCLD_EXITED, si_pid=3D12803, si_u=
id=3D1000, si_status=3D0, si_utime=3D2, si_stime=3D6} ---
read(3,
------------------
That last read from handle 3 (which is closed) lasts forever until you ctrl=
-c.

The abbreviated strace output, simply halting at the comma, is very odd.

Note the behaviour is the same with the file: protocol prefix and without.

j.
