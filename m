Return-Path: <SRS0=xG8z=6E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0BDAC3A5A0
	for <git@archiver.kernel.org>; Mon, 20 Apr 2020 14:03:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53CCC20722
	for <git@archiver.kernel.org>; Mon, 20 Apr 2020 14:03:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=atos.net header.i=@atos.net header.b="tRtejNzW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729116AbgDTODh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Apr 2020 10:03:37 -0400
Received: from smtppost.atos.net ([193.56.114.177]:15293 "EHLO
        smarthost4.atos.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726871AbgDTODg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Apr 2020 10:03:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=atos.net; i=@atos.net; q=dns/txt; s=mail;
  t=1587391414; x=1618927414;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=Cc1lLwWiavv/wFXVA7izlJwe+H8gMSR6L45C7JJzXNI=;
  b=tRtejNzW/85VXEzwyHCcGOQrNsQg726Ardo61m0la9TbN2Kr8LpVDKwz
   jIZBp+qzx2x97odDbjH4ws61x3a3X1Fzmq5+iHdNQ5gJkERCa8P3cZq/F
   pbo3JJx65SUcz+O+ai+lYLmx2FnF7BNghhZbAt3QaOxwwpIFCWGmyyh/x
   Y=;
IronPort-SDR: ix8ubIpMyMOaV6NvPhBqYaxSsy/gSTcogSbwyCgLFUuLvrEQocq9mmVr9v6u2IeniFLoxP34+N
 SCe4ROUxKAbuQZfMieQpDivGsnMEuCI7JgSrEQuSZln7zTxOntbX6S85H7G8nUPBAYqRd6dj3a
 wihAFecZVKBDT2vgHjk/JaHWRoGjYh34HAbvx1z7CA1lVF7tYoxgP5auG9ZFCnP52z9Od726Qi
 A4hMzpm7VZEzcRt+LKDfj1tK3YdkssXLX581yKw5QXIPdmxpqdrBPU5979Aip1XjEEEvEp9qaO
 oTvLj1MKvXdhKas1MJ+Y2X3f
X-IronPort-AV: E=Sophos;i="5.72,406,1580770800"; 
   d="scan'208";a="53324331"
X-MGA-submission: =?us-ascii?q?MDEXXOIrYNq/+RbigxjrlpjlhNCpcphaJxPzmt?=
 =?us-ascii?q?0ZQsyk69J7cJsfmiwjtl617U0Wg/cVEMgYfzJ1XXiRL7CSqhnyW8To5R?=
 =?us-ascii?q?7LylqRWEVDlbW/k+4tQJhCLNfUQdzSRKyclJ1npeEmgdUnO3ezHW2sVp?=
 =?us-ascii?q?y8?=
Received: from unknown (HELO DEFTHW99ETWMSX.ww931.my-it-solutions.net) ([10.86.142.51])
  by smarthost4.atos.net with ESMTP/TLS/ECDHE-RSA-AES256-SHA384; 20 Apr 2020 16:03:31 +0200
Received: from DEFTHW99ETTMSX.ww931.my-it-solutions.net (10.86.142.101) by
 DEFTHW99ETWMSX.ww931.my-it-solutions.net (10.86.142.51) with Microsoft SMTP
 Server (TLS) id 14.3.487.0; Mon, 20 Apr 2020 16:03:30 +0200
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (10.86.142.137)
 by hybridsmtp.it-solutions.atos.net (10.86.142.101) with Microsoft SMTP
 Server (TLS) id 14.3.487.0; Mon, 20 Apr 2020 16:03:29 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J37/7U/ts4TlB2aMf8a6v2ymI8h6Myopw2qmATcldQDH7tihyzZhUZgSN0F+rLOzFPe6VusJL865lAF0ZaYG+F0It5dA2FjodSrRslJ7gdDYMJICf92910599GOlXJstzERBUwCuJWl+tMYPm+IweezVLFgKhUMOpS1YbDCjyr6tLBpjVI5GEAPj5nfuRccxeKKpZbcAyxxqZlbHia8UC4nbHbXvH4PjfvZ5k8hzZdPTwUOeXnJ2KRQC6qLjRRIksB4ggPZ8bL5ERwzTyuTThFVbLj0CBbB1VgVA3j8vwhLIfKZPgCGiJ4HthtSXkVoy9njNkRJPkyLrTHFMb53pzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cc1lLwWiavv/wFXVA7izlJwe+H8gMSR6L45C7JJzXNI=;
 b=G9YQHdcraqXU15kQ+pJDGP8JvJ8TuEu33ozFE7LDsYH4fEaMkqmjshLr1TMpScbUohlH7urqZxUesiriIZPUUB806sGgfeebglAOeXKlZ1+MggAV4Ze3mweq8LXJObhbRJsaTXvS0fBU97kRIfRNPyGY7gx6r4lu/Ee8kmizdmofduDQrqx/06d8HJd7vtonPhnm530rU3eWbfA5oqD4t5P/knyjE26n9bH4yMrjzjt6vCI3kcdrdIr1iCKLzlam4Dut+RtbTufF+E1r1qo2VVR2Su7s83OTrlwZF+JFyr2SmjPfpUn1XdoCLPeQsL3CHmcqQT80iLIjGd6Y4UT6Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atos.net; dmarc=pass action=none header.from=atos.net;
 dkim=pass header.d=atos.net; arc=none
Received: from AM0PR02MB3715.eurprd02.prod.outlook.com (2603:10a6:208:42::13)
 by AM0PR02MB4515.eurprd02.prod.outlook.com (2603:10a6:208:ed::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25; Mon, 20 Apr
 2020 14:03:27 +0000
Received: from AM0PR02MB3715.eurprd02.prod.outlook.com
 ([fe80::b4c8:6064:534d:3eb8]) by AM0PR02MB3715.eurprd02.prod.outlook.com
 ([fe80::b4c8:6064:534d:3eb8%4]) with mapi id 15.20.2921.027; Mon, 20 Apr 2020
 14:03:27 +0000
From:   "Kerry, Richard" <richard.kerry@atos.net>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: git-filter-repo For Windows (possibly a request for a bash for
 Windows primer)
Thread-Topic: git-filter-repo For Windows (possibly a request for a bash for
 Windows primer)
Thread-Index: AQHWFxuem/MFBGt+wkehDmcm8+Ny9w==
Date:   Mon, 20 Apr 2020 14:03:27 +0000
Message-ID: <AM0PR02MB371559B3C5445A3C9D39821B9CD40@AM0PR02MB3715.eurprd02.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_Enabled=True;MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_SiteId=33440fc6-b7c7-412c-bb73-0e70b0198d5a;MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_SetDate=2020-04-20T14:01:25.366Z;MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_Name=Atos
 For Internal Use - All
 Employees;MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_ContentBits=0;MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_Method=Standard;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=richard.kerry@atos.net; 
x-originating-ip: [212.56.108.147]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0dc54785-f3b9-45c2-b007-08d7e5339958
x-ms-traffictypediagnostic: AM0PR02MB4515:
x-microsoft-antispam-prvs: <AM0PR02MB4515909341D985157E4636FB9CD40@AM0PR02MB4515.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 03793408BA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR02MB3715.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(376002)(396003)(366004)(346002)(136003)(39860400002)(52536014)(186003)(7696005)(71200400001)(76116006)(6916009)(33656002)(66446008)(6506007)(66946007)(66476007)(64756008)(26005)(66556008)(5660300002)(9686003)(8936002)(86362001)(55016002)(66574012)(2906002)(8676002)(316002)(81156014)(478600001)(966005)(460985005);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: atos.net does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZVpwHDCeMIB/Fpqh0Mv4TFYF5DTirZi/REnvdFeDj9bncgtx7ONEsewIJYG+mC9ELs9sJ7P3LVxEa9rsWSTeHHK5K6vO1JT7wG9Pdy7zUrrDnhKcjAP+EpzYd9mDyfMnKEZObpKp4KOqwWEa7lHOKLUos36UrKnf9GAemMPnxoomYFfkSSdqtlwXrtM5EX0gXZtlbptlXYaAQcTMOJJnFj2AnUIhOo2RF6+IB7f+xU/s7UCciEdNVaenIWzrQ2u2fwF0H+kP9+JF/TEAiSRa0xq+3Z/wJrvAjuk+fcp8txkvKDyJXKBDlSZuwrwfeIHV1dDlnbyZzluHC7/s5J+CAgHCsCCou7jbgGG3krHwPrAtPwpA1QZHAXYPaBjuOvodGuTrUJk19tiSktNB+HTjoqTpkC8/e1L1eDjgpmIF32ycSADmZFPHq9WRDUV5uHT6RvdysihA33I3ZvXm82ZjZhZwH3cUqkx4J2sD8RVhDjvlVIfG/J6zAmI3XBD7e5hV217auY0D3fJGJnnFhiu5WhJsjpxgsKxuEyvk0PUNKnVXgpHsCUI1PoqOEYThnJaH4suqF+OeZVf04K447hNKWg==
x-ms-exchange-antispam-messagedata: 94J4iN1+Hr8gB/gUtgbte22J9iCstu/FABV3YIyEACp1hXWJdocFTuh3aDDpNIqOzIWOwZqRe0/x4sRdZ+yshityJjmCk2eiPBj4nWLaUo3D7B9WbA6MdGjEMNJLZfk5XlMKqOghkZLwr8CfxQm6eA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dc54785-f3b9-45c2-b007-08d7e5339958
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2020 14:03:27.4334
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 33440fc6-b7c7-412c-bb73-0e70b0198d5a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C9MZ3JwRiWzvkcRRpTj2cbxNRYzAJvTA/TaRNjULRmdN4uj5rQ+MH9rJPzSw0SPCOEVlTT/4wgrH3bPQ8391rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR02MB4515
X-OriginatorOrg: atos.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


This follows my earlier query for which the answer was "use git-filter-repo=
".
I've cloned git-filter-repo from GitHub, and I've installed the latest Pyth=
on (version 3.8).  I'm working on Windows.=A0 Windows 10 if it makes any di=
fference, so git is Git For Windows.
The first instruction for git-filter-repo is to copy it into the "--exec-pa=
th" of git.=A0 That fails, saying Access is Denied.=A0 So leaving aside the=
 option to change the permissions I've followed the second half of the sent=
ence and added my git-filter-repo location to my Path (or PATH if it's in b=
ash).=A0 Now running "get filter-repo" gives:
/usr/bin/env: 'python3.exe': No such file or directory

My python executable is called python3.exe.=A0 There is a note in the git-f=
ilter-repo project about certain Windows installations where it isn't calle=
d python3, but that now raises in my mind the question of whether I need to=
 tweak git-filter-repo to look for "python3.exe" rather than just "python3"=
.=A0 Or can I take it that the Windows version of bash understands that it =
needs to add ".exe" automatically?

Assuming that is handled automatically, what do I now need to do to satisfy=
 the error message?=A0 Do I need to put something in bash-for-Windows' /usr=
/bin/env directory?=A0 Or is there something else entirely that I should be=
 doing?

And is it OK to ask about this on this list, or should I be going to a git-=
filter-branch resource?=A0 Or for Git For Windows?

Regards,
Richard.




Richard Kerry
BNCS Engineer, SI SOL Telco & Media Vertical Practice
M: +44 (0)7812 325518
2nd Floor, MidCity Place, 71 High Holborn, London, WC1V 6EA
https://webmail.siemens-it-solutions.com/owa/redir.aspx?C=3D9fb20d019e3e4cb=
99344d708709a3177&URL=3Dmailto%3arichard.kerry%40atos.net


This e-mail and the documents attached are confidential and intended solely=
 for the addressee; it may also be privileged. If you receive this e-mail i=
n error, please notify the sender immediately and destroy it. As its integr=
ity cannot be secured on the Internet, the Atos group liability cannot be t=
riggered for the message content. Although the sender endeavours to maintai=
n a computer virus-free network, the sender does not warrant that this tran=
smission is virus-free and will not be liable for any damages resulting fro=
m any virus transmitted.
