Return-Path: <SRS0=ToNR=6F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEAFCC54FCC
	for <git@archiver.kernel.org>; Tue, 21 Apr 2020 14:53:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78A9B206A1
	for <git@archiver.kernel.org>; Tue, 21 Apr 2020 14:53:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=atos.net header.i=@atos.net header.b="8rk9MUxX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728676AbgDUOxJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Apr 2020 10:53:09 -0400
Received: from smtppost.atos.net ([193.56.114.177]:6343 "EHLO
        smarthost4.atos.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726018AbgDUOxI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Apr 2020 10:53:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=atos.net; i=@atos.net; q=dns/txt; s=mail;
  t=1587480785; x=1619016785;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rcwb5bJjDbNn/HSQQDRRxadYeYotPcSUN2/LBAnvM58=;
  b=8rk9MUxXG3qK2iAejAxFXKdTbsY+tCsQCztESF7tByL4bZzc6kiGkM2k
   zDE2Uyyym/zUGFQeJrWeBmAcU/PFGAG0wGfjsThPAQ6KwQwoSC0jYSK4X
   +24Up/oMD+V/uTsT6xm1qLlSh3wxtliZcfQKM3C1mrZiFGWoEbfiMFBB8
   g=;
IronPort-SDR: zYWMVVjtOtelS9pRk4GP0gl87crjDpBiuZp6Ho1EBF6RSIOk6lNYicr9YYb5wB2uXGMFD1iOL7
 s7T+Ng5onNINNspHukDA/iuYzUyJtEgnGTWKGnbHSLeZANXkdeVSvK6JmLgQ4un3KliYBtkNW+
 F4pJsJS0znYUiLdjFdYtpB9dRv8aTjlQWtOoqveIHf1IcMdfN2YSGMYOOXC0BPDtuEq7anCVpL
 mEEy+Xl6J3aykA70YAlwPX0B+cftJdf6j6Bs1wFMJ4dEH95SZiJk23vLVUFjmjAYArRmWiE85E
 K3phM+eYtxgwu0MdEutLTCVk
X-IronPort-AV: E=Sophos;i="5.72,410,1580770800"; 
   d="scan'208";a="53693033"
X-MGA-submission: =?us-ascii?q?MDEdv63rM2YzTc4lnqN8588EkMy9/NreSfqBZC?=
 =?us-ascii?q?7BIMf6yL/yWoiNDlKxQWoiIg1DH8AfBYZKf7Uv59Gfj7m36sW6P4I7mZ?=
 =?us-ascii?q?6XzdX399d6SHeMp+/oNqwGhhIXxt2LbMHj9Ui+KF0M3S4wDZYEW4mhAN?=
 =?us-ascii?q?2p?=
Received: from unknown (HELO DEERLM99ETVMSX.ww931.my-it-solutions.net) ([10.86.142.97])
  by smarthost4.atos.net with ESMTP/TLS/ECDHE-RSA-AES256-SHA384; 21 Apr 2020 16:53:02 +0200
Received: from DEERLM99ETRMSX.ww931.my-it-solutions.net (10.86.142.103) by
 DEERLM99ETVMSX.ww931.my-it-solutions.net (10.86.142.97) with Microsoft SMTP
 Server (TLS) id 14.3.487.0; Tue, 21 Apr 2020 16:53:02 +0200
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (10.86.142.137)
 by hybridsmtp.it-solutions.atos.net (10.86.142.103) with Microsoft SMTP
 Server (TLS) id 14.3.487.0; Tue, 21 Apr 2020 16:53:01 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nI+sFssPK2TK1tS3Fioeoxp/Ivc/JKogSeE7V+VCuvdX/H/6/4CqQzS6dp4ZCaTPlsUH9PvjPPuFMzMSBPGfrDYSaQf5SmxjQ8r05XNYNf3bfHQ4xjGXAiTF607sEAtTIwalectYx76Mk+u3OsnVnrUwFE6U1pjuNTH1II8h2IP1bmVS+9C/cEv4WfwbsOrnCM5CzOCMMpgPuVpvUl755hqbklqkmyVaH7kARIH8KOJh28iAE57XG9Z1Xi6afekiFlp1xbQz/+2e85K9rr8ZX0SH+oqj3aYPWQ6UiCB1Jb8Ikxc/tO0v5+bCsbajQwIMldLoqvjH85DeNYsRH2UL6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rcwb5bJjDbNn/HSQQDRRxadYeYotPcSUN2/LBAnvM58=;
 b=JcYnPED4KpS+5EeG7d2A8IVy0EQAE8d97ACUyBobp/Ud/qQf9aagjh5nomHIi3Mdvd2K3JJz7WECUT9GNekSwrl7DlN7/25+cL865Hf5ueBukc9MyJ4b/II4s6edNSFTp+qIYuptLdhsx9yw1+jrdCPYlDOU1kjJj6sj067BYs2s/xq5uBRY5djj1rQwPSvBed4da/k+vqbG1MTpIdqlKdFnkjFaxwlzM4YGGbPhyQ7yMmu72qwKT9PlkAZTEMCQ5ZjfYlSr2k+8NOholrpb6MYzDguA3qoKr+66eDSDBJ23j7K0WL/kJSUhTxVSm62akZN5MKR6V9ZvYCfNaozeZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atos.net; dmarc=pass action=none header.from=atos.net;
 dkim=pass header.d=atos.net; arc=none
Received: from AM0PR02MB3715.eurprd02.prod.outlook.com (2603:10a6:208:42::13)
 by AM0PR02MB4019.eurprd02.prod.outlook.com (2603:10a6:208:d9::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Tue, 21 Apr
 2020 14:52:56 +0000
Received: from AM0PR02MB3715.eurprd02.prod.outlook.com
 ([fe80::b4c8:6064:534d:3eb8]) by AM0PR02MB3715.eurprd02.prod.outlook.com
 ([fe80::b4c8:6064:534d:3eb8%4]) with mapi id 15.20.2921.027; Tue, 21 Apr 2020
 14:52:56 +0000
From:   "Kerry, Richard" <richard.kerry@atos.net>
To:     Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: git-filter-repo For Windows (possibly a request for a bash for
 Windows primer)
Thread-Topic: git-filter-repo For Windows (possibly a request for a bash for
 Windows primer)
Thread-Index: AQHWFxuem/MFBGt+wkehDmcm8+Ny96iCOkGAgAAIrwCAABb0gIABROt2
Date:   Tue, 21 Apr 2020 14:52:56 +0000
Message-ID: <AM0PR02MB37150CFFDD7A3871DB43DFBD9CD50@AM0PR02MB3715.eurprd02.prod.outlook.com>
References: <AM0PR02MB371559B3C5445A3C9D39821B9CD40@AM0PR02MB3715.eurprd02.prod.outlook.com>
 <CABPp-BGis7wswAjwgTa84m-TsQznrQWQJVJZW0_MyN9ieFMzeA@mail.gmail.com>
 <CABPp-BHjF4AJdTrdqxvgsZq+UBZd06upFOHEx-8eQ8qKO-CtkA@mail.gmail.com>,<9478ea01-8d1d-a897-48f1-813f88dde072@iee.email>
In-Reply-To: <9478ea01-8d1d-a897-48f1-813f88dde072@iee.email>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_Enabled=True;MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_SiteId=33440fc6-b7c7-412c-bb73-0e70b0198d5a;MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_SetDate=2020-04-21T14:45:21.665Z;MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_Name=Atos
 For Internal Use - All
 Employees;MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_ContentBits=0;MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_Method=Standard;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=richard.kerry@atos.net; 
x-originating-ip: [212.56.108.147]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 562f21fc-81aa-4d1d-6e00-08d7e603ad9c
x-ms-traffictypediagnostic: AM0PR02MB4019:
x-microsoft-antispam-prvs: <AM0PR02MB4019F9C423956C70BC30529E9CD50@AM0PR02MB4019.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 038002787A
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR02MB3715.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(39860400002)(376002)(366004)(136003)(346002)(396003)(86362001)(478600001)(33656002)(110136005)(5660300002)(9686003)(55016002)(186003)(4326008)(71200400001)(26005)(2906002)(8936002)(81156014)(8676002)(316002)(66574012)(6506007)(7696005)(52536014)(76116006)(66476007)(66556008)(64756008)(66446008)(66946007);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: atos.net does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JojV6Fa/lpKFinCbAplXQ+OWxYLL3svxNmGvEntpHFg6SfxjyViQSe8c58l0uP8iTFK03R68JXqqSx3z0YNtHGYMDIfLhCXfyInhRuomH+Fg0Us1Uqxg8Isje0XG0aAELRlZjUK5zp2saJJltkaCwQN93SW4UoITywXZspAHY+gewaJ6AwkTTzPIqeXsUd9jqGTfjqRbApXxJMK7z4rvZ5fMmM0NKfnVme/XwaCrcpgBRzSxddjco64P4K9pQjehi22Px6iFkoAn0fMqTVBI+cKPPOwGz6WoDHHNr7ki4FYckG+NhWiXfyKrFnkqUCyVobT4odktMODvi2JBBrTk9KHncs+oSwlm07GddXo1h4DH8fy2LnyzY4ocFckf20anrX/nAs2gRz1pgn3Mn8cS4iGvje0k4UUQWTV4iH/R92cR66+/NWIdCDHT9QVR305H
x-ms-exchange-antispam-messagedata: H0ZDpI/vqawlN/p0Dy9U3aBVlV1LOJ8cSux+qwtks+XqAFCYtd5ATGvEptvrCHuTRyGH+6g93lVFhZS1vtON2hlJSlWMCpUGdMc6zvmwr689CvkqKwwVRIUXJJ+8ebwgoqLUMF5CjM3Q1ad9GmND8Q==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 562f21fc-81aa-4d1d-6e00-08d7e603ad9c
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2020 14:52:56.7485
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 33440fc6-b7c7-412c-bb73-0e70b0198d5a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jujEIBjOq6rRPrAPntEJtqxPAf8Jvhq+R/Mp2bZQ0qAdD9wbkORDUQ1eVdCTGDqd7SuWUP8bA7Mz6LY0/vVAYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR02MB4019
X-OriginatorOrg: atos.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for everyone's advice and assistance.
I had a look at all the links provided and wasn't convinced any of them qui=
te covered my requirement, but I have now made some progress using Scoop.

I had hoped that all I would need to do would be:
1. Install latest Python for Windows (3.8). Install for All Users means it'=
s in C:\Program Files\Python38, and that's in the Path.
2. Clone git-filter-repo.
3. Point Path at git-filter-repo.=A0 (Alternative was to copy it into "exec=
-path" folder under Git, but that was protected.)
4. Run it.

That didn't work: /usr/bin/env: 'python3': No such file or directory.
That string pointed me at the shebang line of git-filter-repo, so I set abo=
ut trying anything that I thought might point at my Python installation.=A0=
 Nothing I tried worked.=A0=A0Some things, like "/bin/sh", did indicate tha=
t the right file was being found and executed, but gave errors that it was =
being executed as a shell script, which of course it isn't.  Any attempt to=
 point at the python exe seemed to say things along the lines of "git can f=
ind it but not understand it" (sorry I can't now copy in the real error mes=
sage as I had to close the Bash shell in order to update GfW.)

So I gave up on getting it to run using raw Windows - well not entirely raw=
 Windows as it's going to be run from Bash-for-git-for-windows (or so I tho=
ught).
Installed Scoop.=A0 Got Scoop to install git-filter-repo and python.=A0 At =
last that lets me run it and have it do something useful.
Though actually as Scoop gives its instructions for being run from PowerShe=
ll I'm not in the end running from bash at all.

First attempt at running it was using:

git filter-repo --analyze --source=3Dcore_system_archive
which responded "not a git repository" even though core_system_archive does=
 contain a ".git".
But then=A0
git filter-repo --analyze --source=3Dcore_system_archive/.git
or
git filter-repo --analyze --source=3D./core_system_archive/.git
didn't work either, same error, although it looks to me like=A0core_system_=
archive/.git is a git repo.=A0 So would I need some different syntax to mak=
e that work?  (And I've since noticed that examples use space rather than '=
=3D' to separate keyword from param, so I've tried that, with the same fail=
ures)
So next option was to "cd .\core_system_archive", then just
git filter-repo --analyze=A0
Which has worked.
Though it isn't clear what was wrong with the parameter I used for --source=
.  How am I supposed to reference a source repo without cd-ing into it?

So thanks everyone for a lot of hints, but for me, under Windows, only the =
Scoop package manager managed to get all the right settings for filter-repo=
 to work.
And only now, having been rather rushing to get this to work due to other p=
riorities, have I seen the comment about using pip to install it, so maybe =
that would also have worked.

Regards,
Richard.

Oh, and having also seen Philip's reply (below) I don't think I would have =
recognized it as relating to my issue.
What is winpty?  Should that have gone in the shebang line of git-filter-re=
po in some form?


From: Philip Oakley <philipoakley@iee.email>

with a reply by dscho reminding that:

This issue is listed specifically in the Known Issues in our Release Notes:

=A0=A0=A0=A0=A0=A0=A0 Some console programs, most notably non-MSYS2 Python,=
 PHP, Node
and OpenSSL, interact correctly with MinTTY only when called through
winpty (e.g. the Python console needs to be started as winpty python
instead of just python).

The installer even suggests (on the page titled "Configuring the
terminal emulator to use with Git Bash") to
=A0=A0=A0 Use Windows' default console window
=A0=A0=A0 [...] which works well with Win32 console programs such as
interactive Python or node.js [...]


Regards
Richard Kerry

BNCS Engineer, SI SOL Telco & Media Vertical Practice
M: +44 (0)7812 325518
2nd Floor, MidCity Place, 71 High Holborn, London, WC1V 6EA
richard.kerry@atos.net

This e-mail and the documents attached are confidential and intended solely=
 for the addressee; it may also be privileged. If you receive this e-mail i=
n error, please notify the sender immediately and destroy
 it. As its integrity cannot be secured on the Internet, the Atos group lia=
bility cannot be triggered for the message content. Although the sender end=
eavours to maintain a computer virus-free network, the sender does not warr=
ant that this transmission is virus-free
 and will not be liable for any damages resulting from any virus transmitte=
d.


