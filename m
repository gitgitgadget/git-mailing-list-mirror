Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 743A720A1E
	for <e@80x24.org>; Wed, 12 Dec 2018 03:02:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbeLLDCb (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Dec 2018 22:02:31 -0500
Received: from mail-eopbgr800044.outbound.protection.outlook.com ([40.107.80.44]:34513
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726237AbeLLDCb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Dec 2018 22:02:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gMIxbEB7luaL2q74fE0Jtb28y3ErCSU4AWCaY/7tnqk=;
 b=eS8Uj8Fg1wmsCAzetl/jS1ueMr0L+0moIzGFuWJksRBJps7ggTn/qLNDs3gKzFH8kMfG2pB95mUruV8y/ZFfKMwNTaNMBq6YHqrOzgjJ/7jyYBtUARwL27YdM2euHCa04fHd4cPOSTOTQ/shquNce+MfVQKNZHdE8ZXk/mq8idc=
Received: from SN1PR12MB2384.namprd12.prod.outlook.com (52.132.194.153) by
 SN1PR12MB0589.namprd12.prod.outlook.com (10.163.208.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.22; Wed, 12 Dec 2018 03:01:47 +0000
Received: from SN1PR12MB2384.namprd12.prod.outlook.com
 ([fe80::f9a6:2b87:1862:d693]) by SN1PR12MB2384.namprd12.prod.outlook.com
 ([fe80::f9a6:2b87:1862:d693%2]) with mapi id 15.20.1425.016; Wed, 12 Dec 2018
 03:01:47 +0000
From:   "Iucha, Florin" <Florin.Iucha@amd.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: High locking contention during repack?
Thread-Topic: High locking contention during repack?
Thread-Index: AQHUkcZ+f0+V0Wt6CUuFEjrDC9wzQg==
Date:   Wed, 12 Dec 2018 03:01:47 +0000
Message-ID: <SN1PR12MB23840AFE62E41D908A40D1B095A70@SN1PR12MB2384.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Florin.Iucha@amd.com; 
x-originating-ip: [108.188.248.241]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN1PR12MB0589;20:OTX6Cr4TAuJ1g611gf0LOAllQ0NGGO5tZN//zfExWNWOEgxzpB+oMbnvpGVa9Ke68mC2KroyFBabCp4fik2jqs97oKnQeQfl3xknhn+pR5Zlzy7TDLSgSHGkoUNvNJHmAyzodr7VMrHY3OmcgC5r3VCXwxGm74EXzQWyNd/VcLTWz7cLwq6EHrhWkGVWWlweaxrbHrZ5o7hwLQErRQ0qT+pLiVil/kSamwOyttSNQa2Lb6aGJjDftTHxkGZqSG2F
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 567060a9-fc98-40e2-e79a-08d65fde27ce
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN1PR12MB0589;
x-ms-traffictypediagnostic: SN1PR12MB0589:
x-microsoft-antispam-prvs: <SN1PR12MB05898D9971AA16B311B6BFFA95A70@SN1PR12MB0589.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231455)(999002)(944501520)(52105112)(3002001)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:SN1PR12MB0589;BCL:0;PCL:0;RULEID:;SRVR:SN1PR12MB0589;
x-forefront-prvs: 0884AAA693
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(346002)(39860400002)(396003)(376002)(189003)(199004)(305945005)(2906002)(74316002)(71190400001)(14444005)(33656002)(6916009)(106356001)(3846002)(55016002)(2501003)(53936002)(72206003)(478600001)(7736002)(9686003)(97736004)(6116002)(25786009)(316002)(5640700003)(66066001)(345774005)(6436002)(26005)(6506007)(2351001)(105586002)(476003)(99286004)(186003)(575784001)(86362001)(8676002)(486006)(7696005)(68736007)(102836004)(81156014)(14454004)(8936002)(1730700003)(81166006)(71200400001)(5660300001)(256004);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR12MB0589;H:SN1PR12MB2384.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: jw3Dp3MDTb3yvcQxHRwi24CBlxjKRwcpL4/JhP45UuFVyYEv4OsXawc4d1TzFKwDT8AL9JvmDfHj42+ZasUJvZ3G5t6kcC8QWym3K5TjE3ck95nseOGUsHwM1IG4JiuanQGlseHO9DK1bfUBF/scIRZODeeaBOtNcYwYyclJ4DecpG5OiPgSFvw/RX0+H0zOzKW1YwwM2FyPvzedC9gvlGplVeULyqpdo5fIGZljA8CASY5NeYM3iQf1rRThy3Z7tixkrtgD1aIgUpuAV0goI6a0C+NrcnjNRIqIilVbY+alpgk63mmnB0LRN53SCkJO
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 567060a9-fc98-40e2-e79a-08d65fde27ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2018 03:01:47.3503
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB0589
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Greetings,

=20

I am running =93git-repack  -A -d -f -F --window=3D250 --depth=3D250=94 on =
a Git repository converted using git-svn.

=20

The repository contains more than 10 years of development, and a mixture of=
 source code and media assets. The size of the objects directory is around =
50GB, and there are around 700k objects. There are several svn branches.

=20

I have ran the repack with Git 2.17.1 (original package from Ubuntu 18.04),=
 2.19.1 (package from Ubuntu Git PPA) and with git next (bc1bbc6f855c3b5ef7=
fcbd0f688f647c4e5b208b).

=20

The system is a 16 core / 32 thread Threadripper with 128GB of RAM and NVMe=
 storage. The repack starts strong, with 32 threads but it fairly quickly g=
ets to 99% done and the number of threads drops to 4 then 3 then 2. However=
, running =93dstat 5=94 I see lots of =93sys=94 time without any IO time (t=
he network traffic you see is caused by SSH).

=20

=20

--total-cpu-usage-- -dsk/total- -net/total- ---paging-- ---system--
usr sys idl wai stl| read  writ| recv  send|  in   out | int   csw
24  24  48   4   0|   0     0 | 362B 8392B|   0     0 |  64k 5042
27  25  44   4   0|   0     0 | 289B 4830B|   0     0 |  36k 5017
24  24  48   4   0|   0     0 | 362B 8392B|   0     0 |  64k 5042
27  25  44   4   0|   0     0 | 289B 4830B|   0     0 |  36k 5017
20  22  54   4   0|   0     0 | 330B 4826B|   0     0 |  31k 4657
22  23  51   3   0|   0     0 | 286B 4834B|   0     0 |  27k 4536
17  23  56   4   0|   0     0 | 299B 4820B|   0     0 |  29k 4099
24  23  49   4   0|   0     0 | 347B 4830B|   0     0 |  32k 4436
27  24  45   4   0|   0     0 | 292B 4820B|   0     0 |  22k 4513
26  27  44   3   0|   0     0 | 292B 4820B|   0     0 |  24k 4878
25  28  44   4   0|   0     0 | 329B 4837B|   0     0 |  45k 5023
23  30  44   3   0|   0  9830B| 370B 4836B|   0     0 |  40k 5064
23  26  47   4   0|   0     0 | 373B 4848B|   0     0 |  52k 4746
25  26  45   4   0|   0     0 | 323B 4833B|   0     0 |  31k 4874
24  28  45   3   0|   0     0 | 269B 4842B|   0     0 |  30k 4820
25  28  43   4   0|   0     0 | 280B 4826B|   0     0 |  45k 5237
25  29  43   3   0|   0     0 | 263B 4826B|   0     0 |  26k 5037
22  30  45   4   0|   0     0 | 287B 4823B|   0     0 |  45k 4154
  0  53  42   5   0|   0     0 | 275B 1210B|   0     0 |5017  1331
  0  53  42   5   0|   0     0 |  97B    0 |   0     0 |5006  1272
  0  53  42   5   0|   0     0 |  70B    0 |   0     0 |5008  1272
  0  53  42   5   0|   0     0 |  24B    0 |   0     0 |5007  1283
11  43  43   4   0|   0     0 | 644B   19k|   0     0 |  20k 2995
25  28  43   4   0|   0   123k| 304B 4802B|   0     0 |  29k 5118
25  27  44   4   0|   0     0 | 297B 4800B|   0     0 |  41k 5121
26  27  43   4   0|   0     0 | 320B 4786B|   0     0 |  29k 4973
22  30  44   3   0|   0     0 | 332B 4786B|   0     0 |  32k 4610
24  27  46   3   0|   0     0 | 296B 4786B|   0     0 |  56k 4632
35  17  44   3   0|   0     0 | 292B 4776B|   0     0 | 100k 4889
34  20  43   4   0|   0  9830B| 610B 4820B|   0     0 |  59k 4811


This when it gets to two threads phase:

  1  40  59   0   0|   0    38k| 373B 2458B|   0     0 |  50k 2874
  0  40  59   0   0|   0     0 | 268B 2892B|   0     0 |  10k 2858
  0  40  59   0   0|   0     0 | 299B 3102B|   0     0 |8392  2919
  1  40  59   0   0|   0     0 | 297B 3176B|   0     0 |  21k 2831
  0  40  59   0   0|   0     0 | 281B 3414B|   0     0 |9192  2856
  1  40  59   0   0|   0     0 | 264B 3493B|   0     0 |  17k 2905
  1  40  59   0   0|   0    35k| 340B 3571B|   0     0 |  13k 2885

=20

The repack still progresses, as I see the count of repacked objects being i=
ncremented every several minutes. But I suspect there is some terrible lock=
 contention, because otherwise I can=92t explain the high system usage with=
 no IO.

=20

Running a strace on the running git-repack process shows only these:
--- SIGALRM {si_signo=3DSIGALRM, si_code=3DSI_KERNEL} ---
--- SIGALRM {si_signo=3DSIGALRM, si_code=3DSI_KERNEL} ---
--- SIGALRM {si_signo=3DSIGALRM, si_code=3DSI_KERNEL} ---
--- SIGALRM {si_signo=3DSIGALRM, si_code=3DSI_KERNEL} ---
--- SIGALRM {si_signo=3DSIGALRM, si_code=3DSI_KERNEL} ---
--- SIGALRM {si_signo=3DSIGALRM, si_code=3DSI_KERNEL} ---

=20

Any idea on how to debug this? I have ran git-repack under gdb, but it seem=
s to spin on builtin/repack.c line 409.
=20

Thank you for Git,

florin=
