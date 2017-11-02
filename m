Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F3E442055E
	for <e@80x24.org>; Thu,  2 Nov 2017 23:45:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934469AbdKBXp6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Nov 2017 19:45:58 -0400
Received: from mail-sn1nam02on0105.outbound.protection.outlook.com ([104.47.36.105]:18349
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932201AbdKBXp4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Nov 2017 19:45:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=EYkYCHXGwejGeef4NTbafTRECJp32ImQgUWvCOAqVPs=;
 b=OXn94HTq1tgXLBiTyUoSMohKGB5WQaSZoQHGv2bGdqlKegvrgCppOtUKKxj2VwevLc/hvj49l4oltim+splPed9pvP6Ry6GorWZkZfixFvRsgoKEI8PjyHcEse7jlVXebYjK3XKMXXjgO6AIciPeD/JxcvY+RZD1UlEavjRcVds=
Received: from MWHPR21MB0159.namprd21.prod.outlook.com (10.173.52.17) by
 MWHPR21MB0192.namprd21.prod.outlook.com (10.173.52.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.20.218.3; Thu, 2 Nov 2017 23:45:55 +0000
Received: from MWHPR21MB0159.namprd21.prod.outlook.com ([10.173.52.17]) by
 MWHPR21MB0159.namprd21.prod.outlook.com ([10.173.52.17]) with mapi id
 15.20.0218.005; Thu, 2 Nov 2017 23:45:55 +0000
From:   Andrew Baumann <Andrew.Baumann@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: git tries to stat //HEAD when searching for a repo, leading to huge
 delays on Cygwin
Thread-Topic: git tries to stat //HEAD when searching for a repo, leading to
 huge delays on Cygwin
Thread-Index: AdNUM3ISgxjYKsv8QeOBPtagpoPRBw==
Date:   Thu, 2 Nov 2017 23:45:55 +0000
Message-ID: <MWHPR21MB0159089DB91A30E5E5CFCB479E5C0@MWHPR21MB0159.namprd21.prod.outlook.com>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=baumann@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2017-11-02T23:45:52.6250871Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [2001:4898:80e8:1::12]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR21MB0192;6:KRyuINO/d9QnY5Lx14xNxnFggU+EjJ+ytwwSq/f0nWi4vhobp02CiCZX06ythyoS5AZqNqpAL5JtndWgt2d8qe7uz7qniy8kKe8eruYz2tVzMpGbHQJnFWXUIN7v7oQzpedvsmJoTeZGFB3xVAiXm+99aLMxR1P4WA0DGbE+p3wjwfashl1t2AFG1l44KZtK1Rd2Cd8gz04ISH5LZ/Jv7S9tcX6XG+2pMe2Su2zyikYityaYs4DtECu42aNgIjVNBGkz2A+ya3hC1ScBq1G3DROkhS/tOisWptbgNeDGQ5jHBc6OxcP/tvQ/ZAHgB6UmOjyK8sLGYH/2i+2x6M1CsqBOBVwEc0k19fLLZrUu5tY=;5:E118BLoVkYdX9sxjBl0P8X8FEcFWoXNw1d7x5Dx7KRgg18d6uFq5YykZN0fieyjW5SKwr6PD03XD8azcdthiLWT44upyU1V7HhmRvJBz7u/H5XG4SexoRATSjV313Gh8Lo+xjETnYg7LSK4iqwOsd+6xdYNJCYkORyFc05aA9Yw=;24:rE1FEIGzo1JVNQ+Pm/NHeUAkacN7bpu7sjRmzuafwbkHdXoXs/SU3hvN7KfvizTgr5+MOtMmIHycMnMEdsQVXQukreR/3nZpz+UzaxqW3mk=;7:qbe5nLS54RIAx50qIcSLLmsdgaXwA6iq/XX/6HEvvjO/IHDyORvOCqv1c6QQvx7/6b1KddBvGEtK0hgAqYCPcWWlfPdk8tKUYLPhs3gMN5eKwtDl2047CcVQhXYt8OeNgf/JBsOczIPY4FfDRaJaqd29jMyYQVBnEtxzoCQerOokn7Augky83eITKzmC+5DH3t5zfsPTBaVp2UBAhCK1c5ufFxaQRxwt84Ng/ZPZy//bLl2nI+BYbC7ZfklKA5BX
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-correlation-id: 361f043c-f954-4dd0-7ac7-08d5224bdc1c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(48565401081)(4534020)(4602075)(4627115)(201703031133081)(201702281549075)(2017052603238);SRVR:MWHPR21MB0192;
x-ms-traffictypediagnostic: MWHPR21MB0192:
x-exchange-antispam-report-test: UriScan:(158342451672863)(185212123834332)(211171220733660)(17755550239193);
x-microsoft-antispam-prvs: <MWHPR21MB0192128B39569AC756AAA2A39E5C0@MWHPR21MB0192.namprd21.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(61425038)(6040450)(2401047)(5005006)(8121501046)(93006095)(93001095)(100000703101)(100105400095)(3231020)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041248)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123564025)(20161123555025)(20161123562025)(20161123560025)(20161123558100)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:MWHPR21MB0192;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:MWHPR21MB0192;
x-forefront-prvs: 047999FF16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(6009001)(39860400002)(346002)(376002)(47760400005)(199003)(189002)(50986999)(6506006)(102836003)(189998001)(99286004)(6116002)(6916009)(3660700001)(10290500003)(6436002)(2351001)(478600001)(25786009)(8676002)(5640700003)(1730700003)(97736004)(2900100001)(72206003)(68736007)(3280700002)(14454004)(966005)(8990500004)(54356999)(7696004)(10090500001)(74316002)(2501003)(105586002)(86362001)(5660300001)(77096006)(8936002)(106356001)(7736002)(316002)(81156014)(101416001)(81166006)(2906002)(9686003)(305945005)(55016002)(53936002)(6306002)(22452003)(33656002)(86612001)(51383001)(14583001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR21MB0192;H:MWHPR21MB0159.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Andrew.Baumann@microsoft.com; 
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 361f043c-f954-4dd0-7ac7-08d5224bdc1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2017 23:45:55.1351
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR21MB0192
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I have a workaround for this, but someone on stack overflow [1] suggested r=
eporting it upstream, so here you go:

I have a fancy shell prompt that executes "git rev-parse --is-inside-work-t=
ree" to determine whether we're currently inside a working directory. This =
causes git to walk up the directory hierarchy looking for a containing git =
repo. For example, when invoked from my home directory, it stats the follow=
ing paths, in order:

/home/me/.git
/home/me/.git/HEAD
/home/me/HEAD
/home
/home/.git
/home/.git/HEAD
/home/HEAD
/
/.git
/.git/HEAD
//HEAD

The last name (//HEAD) interacts badly with Cygwin, which interprets it as =
a UNC file share, and so demand-loads a bunch of extra DLLs and attempts to=
 resolve/contact the server named HEAD. This obviously doesn't work too wel=
l, especially over a slow network link.

I've tested with the latest Cygwin git (2.15.0); this was also present in a=
 prior version.

Cheers,
Andrew

[1] https://stackoverflow.com/questions/47084672
