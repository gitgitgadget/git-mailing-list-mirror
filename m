Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02449C433B4
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 17:11:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3465611C9
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 17:11:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232748AbhDSRLd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Apr 2021 13:11:33 -0400
Received: from mail-eopbgr60087.outbound.protection.outlook.com ([40.107.6.87]:4432
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230127AbhDSRLc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Apr 2021 13:11:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nIF6NLbDvdms26xdGtMIQ0EWDL9+xgK3csLRR8j7DRv6FUd+euB0N0b3jjX4ETz2U6cqQXaSocAyRiOawg9Wx6P/2B4ogA9EYjOCbELSpOtmboszOX6lISYF0FcNEmE5Fh/y52q0yei8qYsaHuDb7agWKCzxiVyKkRKvYzHWbm0Id3OI90DT0VJSKOflBCsOhI0n0icxCknoRdmpSXxEm3WZbiPUGpDZs85aeG7L2xaLcskFBXsCWbC5QwIlutVKengBtxWUosVivQMf4Y0TQHtCjkRh+hwMkGlBTyEvOyTlBCNgYVjHiH5KNGyOypzjk9MFPlEcLTTxZIDA7Dj+4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XniWzcvH4aqLbafMoOrZ5pplJUwUsWdJqLRTeuzIXhc=;
 b=ffdW1g+Mfq48FjAjgwN7v+z0yNFpFQ7i3WiHUfc3ryXuXNPkhB0PzHiYudMvrkIe2t7/p/XZjfuddU6DSA4wmETwV9yMWPHNQJFPl9mYGvlsYJV7eaBmsh/5dIOQNqEhX8ULzCRsAR+xtGAAoJG86nDGOtQeLuv00t1a8xlx1baKk6LXnhhXfuaT2s4EVGEbWQM90A8ICdFgES9Lcb/XK7NjedOFLG7dDz1UBUnZ3pSmi6t6kER+54kwkyKLLeiWf7Fsa0qWnU3jpgpUlJ1r6I6XeRFBQ7HbcxEVJHEuEgtiOFsCTkMnl1uruCW1a0UovyRz684gqTM1iZjJdiTVfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fi.abb.com; dmarc=pass action=none header.from=fi.abb.com;
 dkim=pass header.d=fi.abb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fi.abb.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XniWzcvH4aqLbafMoOrZ5pplJUwUsWdJqLRTeuzIXhc=;
 b=k0lJWhIpY25UVgbFuvN8oUFFnV36MZt5/JF2rrPbmn37KII1TRNjLAYoFlHquwXrOBvAGFAIPRbOUvopKWIc68jvPZIIz/fv8Pwi7EPbvDxNVnmnQWZZOZKucrtnqBuDaqlm9yOgVcSPraY/SVxLysvYULpQ7vBHjuWl4crhbSXduT38TUN7cagPsjJc2SqrbJRitcGcPlL5841Y6QPd55ttcdVK0XnMkwIod1uJ4lOInFwlTnsSmwPvcH5E/z+wfd++4zG0GJK93TQsVB9ZBLQ7Im0hM4gk04XS/qylnUso/cj+RGslbYJTbF303Uen4GkNzVQLga/HdNMrA+97uA==
Received: from AM6PR06MB4263.eurprd06.prod.outlook.com (2603:10a6:20b:1e::31)
 by AS8PR06MB7895.eurprd06.prod.outlook.com (2603:10a6:20b:3cc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Mon, 19 Apr
 2021 17:11:01 +0000
Received: from AM6PR06MB4263.eurprd06.prod.outlook.com
 ([fe80::7506:a4c7:c725:5bce]) by AM6PR06MB4263.eurprd06.prod.outlook.com
 ([fe80::7506:a4c7:c725:5bce%5]) with mapi id 15.20.4020.022; Mon, 19 Apr 2021
 17:11:01 +0000
From:   Joonas Harjumaki <joonas.harjumaki@fi.abb.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Git push --mirror hangs
Thread-Topic: Git push --mirror hangs
Thread-Index: Adc1PsxdsJlWDxYBRYq97Jz1MhOtPA==
Date:   Mon, 19 Apr 2021 17:11:01 +0000
Message-ID: <AM6PR06MB4263DD69639AFD60663D1DD6A7499@AM6PR06MB4263.eurprd06.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=fi.abb.com;
x-originating-ip: [88.114.213.40]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 387fd4e7-7c3a-4aca-8cc9-08d903561b87
x-ms-traffictypediagnostic: AS8PR06MB7895:
x-microsoft-antispam-prvs: <AS8PR06MB78959452A5AF615584398A8BA7499@AS8PR06MB7895.eurprd06.prod.outlook.com>
x-abb-o365-outbound: ABBOUTBOUND1
x-ms-oob-tlc-oobclassifiers: OLM:1122;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9KLo66PBVVZULzmz6hBoTMNWpWGyXAZeoYvKwcpJE+6+PtsaP8u89anbUo7lXaRLoad4o1vpymMfaF2P76Byrq11fagGwFFJzQo7zFGZxpf4gOmQ9v3Oro0ivgbeDLUnKfg8OA1jRAqqhbGEDRpzm8jhL+6Fs3syS4HjfX4Ee54kvRvAMFTHwST7R/duG1KJgREd3YfKh50r4Y+rH+34vztM4gLyEqANrx7caKLPQIuVycfgPNtHEMIe6lQ6DrbxpFePiDxZ+w5cbrqJl3mkQz5UMzG6xW8ijx8GQBchNoW7lqvm13KjXlRxWowhR/K/rimZr3wQfhVXGdnLLE8C7K8mIIxBfZ0+XjbO+pfY+F1KNpzF3zuWCwNXlpu+Umy1KL1hrFwMyuejR81YgaFuH0JhmjdKKn/eBDDZ3JutpMpwvrrNjiuNmKKTzw6uZ8Iq0GAiue0KICtSiuQVBrt/dSvCSJlBk4QBzAYBZ5pmnnk2IDZNiJXef8gPF/Gte+kZXw611IT/RqMdfmQFoLsVMcCT2/N2iaNk/8udzJ1H+pYMXL91BZxEdZJQLpfQhmGPEwiIAjO1asAAL74cwU+6sGqKGLPGW2BJlFI1V1LK6JKuPQEEOTaPP9L/0LjGDUtJifxzo+g8le6CTpgiyJsLSK71T8OZ9QUki0y+hGbSpReecrgjSStNbsGqpt/vzjTi
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR06MB4263.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(366004)(136003)(396003)(39860400002)(66574015)(6916009)(76116006)(52536014)(7696005)(83380400001)(2906002)(122000001)(38100700002)(316002)(26005)(5660300002)(44832011)(966005)(8936002)(9686003)(66556008)(64756008)(66476007)(186003)(478600001)(66446008)(86362001)(33656002)(66946007)(6506007)(55016002)(71200400001)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?2bRSBcYzB1Sps4ReVHc74iBctCWrTf6SA5qrPOPQQardqhISRpNVXOu1Nf?=
 =?iso-8859-1?Q?N60t42eai+UB7VHDUpiY6eWTVa+NqJ+knAsuu0pkmv6QIV8NawKsLuMJfr?=
 =?iso-8859-1?Q?oGCwYpEhw9KYMdJ0txPy/lMDJdmycvowpIuxlHTdBawRwykOtNqH9aYSrE?=
 =?iso-8859-1?Q?JxKTN4FBDnY4YgsBpwGEucMZn83qmgRXmqUGnaAGjW2DMRVA6bh6ozMpEB?=
 =?iso-8859-1?Q?dkI0N4wZc9dbuPkti9+Mb7KTVob7/+EYGXI8k4YKuugsRGDoJJ152eds4B?=
 =?iso-8859-1?Q?IogEvq8kRlwmvHh7MumI1GusdOWEzW8zAsdMA4TAo7VSqIupaXVaPJFWm0?=
 =?iso-8859-1?Q?dLdnZaFo3lF91HmTsWxEzjzJdmbCfSSoGI0CLY9iewkEhQLzUrWZlDIpm1?=
 =?iso-8859-1?Q?ny5FoG0cGxeCWCoLlpKOb9OufHhwy6HPlZxDzv/6eyVZKOZCCWThBF4xcZ?=
 =?iso-8859-1?Q?IiWxDAUlgf9vlVFNQ4JYxRt7cOiRORE8nlt7vWsffWEU1Ck2BIjIFfEMlS?=
 =?iso-8859-1?Q?e/FXCTiKcmj8OgjADswAEQlnCC2Ejf85Razky5EANeOjndpb/v7losTcVU?=
 =?iso-8859-1?Q?VfEtE5eFqPQQ3s0N56kC3hS+4/iKaRCttPhkHZyj9PkXuX2I7m71R/sJ2E?=
 =?iso-8859-1?Q?sS3VsQTVTfU4CPb12RmNzf0Y/qhEu/WBP/Kh4d9TjZhU44zsccLho0JvKY?=
 =?iso-8859-1?Q?78ZbW2a0m+YCeq/LPJDJDeFj8kPIXi6Tf+4TofiXl6tgdxAwmHzg5XVD6+?=
 =?iso-8859-1?Q?zWx5jAjSlElwzbeoEDW3rB8pmuXe8yIvj6x1Q/SDoyInBcAzuClO1LsqGq?=
 =?iso-8859-1?Q?gOS3IiBd2vIosiR2l60FfYOJtDcyt0WaxYr3aHr1tCWAqG7IoghWynTXZ3?=
 =?iso-8859-1?Q?f53igodbiK7OQSNLdp6U+vYKY6nzU/7x1kPdEacFzm07pG1YekdvduArTJ?=
 =?iso-8859-1?Q?gcf4fDJS2rY35NIk5i9irGdurnN0pYwQVorCObJIPP0njkRLvkHnFhJY8a?=
 =?iso-8859-1?Q?JteKW8V5sKj857H69IuIQLw47od2itgc4fsDcdCZH5DA5fV8E/Hc9/LxRe?=
 =?iso-8859-1?Q?fkjM1k9nMm4ZVsvmK+/Wyuft5cgh6Kz+Sv39U7SSw8fgixTgpI+uC99ztX?=
 =?iso-8859-1?Q?Yj0CVt4M/gNytt612x61V9GAqwjT0OM1W3Oq+G+xKHSZzgc9d/BxntYFVi?=
 =?iso-8859-1?Q?zVuvecz7LaUDukv/cR+CdDZJtaE6mt7brBxusjsFZq4HFbNyxwXQWpfHe/?=
 =?iso-8859-1?Q?Pk037VZiW5rli5p9IJgQKH9xSAXVz3UR11MdsBV9nGC0hn/dVrYJbJ98KF?=
 =?iso-8859-1?Q?7rbISBD174TMADPtQVIkdxenWuLl6gzN2ok2LKBKbubImPgbFSQ0kHSY3p?=
 =?iso-8859-1?Q?5wcBtHX0J5?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fi.abb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR06MB4263.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 387fd4e7-7c3a-4aca-8cc9-08d903561b87
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2021 17:11:01.2485
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 372ee9e0-9ce0-4033-a64a-c07073a91ecd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T/ndVi+oi2okfH8IXqMXPJYzmY8SJTNGQ64/KNjGYLOg0Lh0YxrwDZKyK7jlGAstSzs2EYnVSrqKY3htobPwRqMYRQ9fzJjfFdG7wQvzseI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR06MB7895
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm trying to "git push --mirror https://[project]@dev.azure.com" to Azure =
DevOps repository. The size-pack is 3.70 GiB. I have git version 2.31.1 fro=
m http://ppa.launchpad.net/git-core/ppa/ubuntu on Ubuntu 20.04.
iotop or top are not reporting any load.

iotop:
Total DISK READ:         0.00 B/s | Total DISK WRITE:         0.00 B/s
Current DISK READ:       0.00 B/s | Current DISK WRITE:       0.00 B/s

top:
top - 19:58:05 up 12:33,  1 user,  load average: 0,18, 0,27, 0,22
Tasks: 285 total,   1 running, 284 sleeping,   0 stopped,   0 zombie
%Cpu(s):  1,4 us,  1,4 sy,  0,0 ni, 97,1 id,  0,0 wa,  0,0 hi,  0,0 si,  0,=
0 st
MiB Mem :   9727,7 total,   1069,0 free,   1123,0 used,   7535,8 buff/cache
MiB Swap:   2048,0 total,    854,2 free,   1193,8 used.   8195,3 avail Mem=
=20

    PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMM=
AND                                                                        =
                                                    =20
  84514 ssc600    20   0   14528   4116   3308 R   6,2   0,0   0:00.01 top =
                                                                           =
                                                    =20
      1 root      20   0  169028  13284   8504 S   0,0   0,1   0:21.42 syst=
emd                                                                        =
                                                    =20
      2 root      20   0       0      0      0 S   0,0   0,0   0:00.02 kthr=
eadd                                                                       =
                                                    =20
      3 root       0 -20       0      0      0 I   0,0   0,0   0:00.00 rcu_=
gp                                                                         =
                                                    =20
      4 root       0 -20       0      0      0 I   0,0   0,0   0:00.00 rcu_=
par_gp                                                                     =
                                                    =20
      6 root       0 -20       0      0      0 I   0,0   0,0   0:00.00 kwor=
ker/0:0H-kblockd                                                           =
                                                    =20
      9 root       0 -20       0      0      0 I   0,0   0,0   0:00.00 mm_p=
ercpu_wq                                                                   =
                                                    =20
     10 root      20   0       0      0      0 S   0,0   0,0   0:42.87 ksof=
tirqd/0                                                                    =
                                                    =20
     11 root      20   0       0      0      0 I   0,0   0,0   0:12.28 rcu_=
preempt                                                                    =
                                                    =20
     12 root      rt   0       0      0      0 S   0,0   0,0   0:00.30 migr=
ation/0                                                                    =
                                                    =20
     13 root     -51   0       0      0      0 S   0,0   0,0   0:00.00 idle=
_inject/0                                                                  =
                                                    =20
     14 root      20   0       0      0      0 S   0,0   0,0   0:00.00 cpuh=
p/0                                                                        =
                                                    =20
     15 root      20   0       0      0      0 S   0,0   0,0   0:00.00 cpuh=
p/1 =20

Git has been stuck for an hour and half after printing these:
Writing objects: 100% (116519/116519), 3.69 GiB | 2.99 MiB/s, done.
Total 116519 (delta 74981), reused 116519 (delta 74981), pack-reused 0
18:42:45.650572 trace.c:487             performance: 1266.567544063 s: git =
command: /usr/lib/git-core/git pack-objects --all-progress-implied --revs -=
-stdout --thin --progress
18:42:45.743254 pkt-line.c:80           packet:          git> 0000
18:42:46.465637 http.c:703              <=3D Recv header, 0000000013 bytes =
(0x0000000d)
18:42:46.465693 http.c:715              <=3D Recv header: HTTP/2 200
18:42:46.465707 http.c:703              <=3D Recv header, 0000000024 bytes =
(0x00000018)
18:42:46.465716 http.c:715              <=3D Recv header: cache-control: pr=
ivate
18:42:46.465727 http.c:703              <=3D Recv header, 0000000053 bytes =
(0x00000035)
18:42:46.465734 http.c:715              <=3D Recv header: content-type: app=
lication/x-git-receive-pack-result
18:42:46.465744 http.c:703              <=3D Recv header, 0000000124 bytes =
(0x0000007c)
18:42:46.465752 http.c:715              <=3D Recv header: p3p: CP=3D"CAO DS=
P COR ADMa DEV CONo TELo CUR PSA PSD TAI IVDo OUR SAMi BUS DEM NAV STA UNI =
COM INT PHY ONL FIN PUR LOC CNT"
18:42:46.465763 http.c:703              <=3D Recv header, 0000000055 bytes =
(0x00000037)
18:42:46.465770 http.c:715              <=3D Recv header: x-tfs-processid: =
[stripped]
18:42:46.465778 http.c:703              <=3D Recv header, 0000000064 bytes =
(0x00000040)
18:42:46.465785 http.c:715              <=3D Recv header: strict-transport-=
security: max-age=3D31536000; includeSubDomains
18:42:46.465795 http.c:703              <=3D Recv header, 0000000050 bytes =
(0x00000032)
18:42:46.465801 http.c:715              <=3D Recv header: activityid: [stri=
pped]
18:42:46.465810 http.c:703              <=3D Recv header, 0000000053 bytes =
(0x00000035)
18:42:46.465833 http.c:715              <=3D Recv header: x-tfs-session: [s=
tripped]
18:42:46.465842 http.c:703              <=3D Recv header, 0000000051 bytes =
(0x00000033)
18:42:46.465849 http.c:715              <=3D Recv header: x-vss-e2eid: [str=
ipped]
18:42:46.465858 http.c:703              <=3D Recv header, 0000000082 bytes =
(0x00000052)
18:42:46.465866 http.c:715              <=3D Recv header: x-vss-userdata: [=
stripped]
18:42:46.465899 http.c:703              <=3D Recv header, 0000000029 bytes =
(0x0000001d)
18:42:46.465910 http.c:715              <=3D Recv header: x-frame-options: =
SAMEORIGIN
18:42:46.465919 http.c:703              <=3D Recv header, 0000000068 bytes =
(0x00000044)
18:42:46.465926 http.c:715              <=3D Recv header: request-context: =
[stripped]
18:42:46.465936 http.c:703              <=3D Recv header, 0000000048 bytes =
(0x00000030)
18:42:46.465945 http.c:715              <=3D Recv header: access-control-ex=
pose-headers: Request-Context
18:42:46.465954 http.c:703              <=3D Recv header, 0000000033 bytes =
(0x00000021)
18:42:46.465961 http.c:715              <=3D Recv header: x-content-type-op=
tions: nosniff
18:42:46.465972 http.c:703              <=3D Recv header, 0000000104 bytes =
(0x00000068)
18:42:46.465980 http.c:715              <=3D Recv header: x-msedge-ref: [st=
ripped]
18:42:46.465990 http.c:703              <=3D Recv header, 0000000037 bytes =
(0x00000025)
18:42:46.465996 http.c:715              <=3D Recv header: date: Mon, 19 Apr=
 2021 15:42:45 GMT
18:42:46.466009 http.c:703              <=3D Recv header, 0000000002 bytes =
(0x00000002)
18:42:46.466017 http.c:715              <=3D Recv header:
18:42:46.466294 pkt-line.c:80           packet:     sideband< \2\15Analyzin=
g objects... (41535/116519)
remote:

Is this normal and I should just wait, or is there a bug in git or Azure?

Joonas Harjum=E4ki
