Return-Path: <SRS0=G+/Y=3C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,LOCALPART_IN_SUBJECT,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9FB2C33CA8
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 09:41:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44CBA2075B
	for <git@archiver.kernel.org>; Mon, 13 Jan 2020 09:41:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=atos.net header.i=@atos.net header.b="uPWqJfN7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726450AbgAMJlm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jan 2020 04:41:42 -0500
Received: from smtppost.atos.net ([193.56.114.176]:9915 "EHLO
        smarthost1.atos.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725978AbgAMJll (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jan 2020 04:41:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=atos.net; i=@atos.net; q=dns/txt; s=mail;
  t=1578908500; x=1610444500;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=IpxS0YnOYjAiX8Rj2rKZcOtQk5+X4pgPe4KdCLxu1cs=;
  b=uPWqJfN7ea9anxbBqsaEJHBew/wD97/t4t7lGgK+T7uMDUK2505z2wRm
   TnB84SMcu2qljRRVb+UONLOpVS0Gg5xN06ateoWocFxrgQK+hXUsqI6KT
   jG+A3k4ZFCAr114A9FbG8PInPMms3+8iPkwbUba7OhGTWk/m968bOPAj7
   U=;
IronPort-SDR: e5M5D8ag4H5L7gNCWRT497XxwthTB32+eNu9nKzUA1JF+lh/2QZplq7rhO7WMzBeHpFpvnLqyg
 C0ubsEtSnKTSPXHmlMRnNNnml+y3QAljvMKi5gd1VWjy/4upBoRaMW8GtUMyrFeeTXRgucfozA
 V/cnEmPIPWXFWFNskf6Kh5N4K3aJcoRzwa71O5ANR0cTIU5BUrlqLmF/CD2Jh2S8ekmnZ7ac5j
 v6dCMjiuYiVq58+LfM60ZX3G4H4/lfBpWXeKgCepc7dzBlMredBCUnyMDMsLdAhKM2Fj3WVOlw
 WIlEvStgFvviXmSWJWyQkqKj
X-IronPort-AV: E=Sophos;i="5.69,428,1571695200"; 
   d="scan'208";a="10075507"
X-MGA-submission: =?us-ascii?q?MDFGA7HEh7zHM0eSZXILB2YFcIki2l26h28/yz?=
 =?us-ascii?q?brb0s+/e7aXoA6r6QBnxnoXOwY3Mfqz8wLRL0jxYU1bmIlCDznNS+ClI?=
 =?us-ascii?q?qwnBXKzuwtmORCPTQlPdGv2pLzNYVBV10cLBrwiE10ZGirc1Nfc+YoHv?=
 =?us-ascii?q?zH?=
Received: from unknown (HELO DEERLM99ETYMSX.ww931.my-it-solutions.net) ([10.86.142.47])
  by smarthost1.atos.net with ESMTP/TLS/ECDHE-RSA-AES256-SHA384; 13 Jan 2020 10:41:39 +0100
Received: from DEERLM99ETTMSX.ww931.my-it-solutions.net (10.86.142.105) by
 DEERLM99ETYMSX.ww931.my-it-solutions.net (10.86.142.47) with Microsoft SMTP
 Server (TLS) id 14.3.468.0; Mon, 13 Jan 2020 10:41:38 +0100
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (10.86.142.137)
 by hybridsmtp.it-solutions.atos.net (10.86.142.105) with Microsoft SMTP
 Server (TLS) id 14.3.468.0; Mon, 13 Jan 2020 10:41:36 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C0WsyYTwLHeBkpx8DnSJVNneZfZZbcge6XppogJJg7fb5wrVTetNrS0t+9OXA+A94edh8RMsUdom2LabR8UOjzqGkDKwiuLzrUBUzHDuv3OSXl/S4YMk5Xgnq5+KoiHdhUHo9VAszmRLa0bJa740MD5P0oV7KTUli8QPrl4IFHEaC0H69XrlPyhAwS2GsNwKp79BvJcCSR6evaAzcAwojBW585dS2H7Q12XSSWSfZGzKLKI5E3jNjY0KkWll3Td52HreMNgkGmmtRJTLLre7ZKUMsBHDfeSTXvbnjruflnpvFhNoWtP0Tj0QM6Hjnfv64L7S0R2ID4qHbiiSTY+eOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IpxS0YnOYjAiX8Rj2rKZcOtQk5+X4pgPe4KdCLxu1cs=;
 b=L061YzvvM2vGz2BW+69yh9hKTDa9fIkdWkOY+pjlChDBEnCHy9RNS+jNUly1O0d2Rq/adzI5e06pCdP3VUmAEiz1hUixnBHd0MaWg842TgKaI5HWG6i0cdIeERrRvhIVcaBzclVMp+ZuGlb3tK8Khy57qR2L1zpnBF0ZKv3VyNuySgr1tZj3DDzvj1VCBdJSr+/YYJjN1ZYV1F9Jf77KSLPxW41kWCn8TwH8aJrLA6e9gzoJ9RgmMN6xzjxT7dNmQ4QmqJFF+88QcwVaZGg/PA3mE6LYrOl/wovbEE6PdqV9wTRVUgZd4CgIM6wet3CaFR0o/aFsiTIg30lbUCIkYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atos.net; dmarc=pass action=none header.from=atos.net;
 dkim=pass header.d=atos.net; arc=none
Received: from HE1PR0202MB2634.eurprd02.prod.outlook.com (10.168.184.21) by
 HE1PR0202MB2619.eurprd02.prod.outlook.com (10.168.184.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.13; Mon, 13 Jan 2020 09:41:35 +0000
Received: from HE1PR0202MB2634.eurprd02.prod.outlook.com
 ([fe80::41cf:741a:e8d:291f]) by HE1PR0202MB2634.eurprd02.prod.outlook.com
 ([fe80::41cf:741a:e8d:291f%3]) with mapi id 15.20.2623.015; Mon, 13 Jan 2020
 09:41:34 +0000
From:   "FIGADERE, LAURENT" <laurent.figadere@atos.net>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: git , submodules and remove from historic question
Thread-Topic: git , submodules and remove from historic question
Thread-Index: AdXJ82zAAJYwyFs6SpyYHLz4aCj5MQAAhXug
Date:   Mon, 13 Jan 2020 09:41:34 +0000
Message-ID: <HE1PR0202MB263439EFAE785201C61495ABE6350@HE1PR0202MB2634.eurprd02.prod.outlook.com>
References: <HE1PR0202MB2634CD91D2750E199098FACAE6350@HE1PR0202MB2634.eurprd02.prod.outlook.com>
In-Reply-To: <HE1PR0202MB2634CD91D2750E199098FACAE6350@HE1PR0202MB2634.eurprd02.prod.outlook.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_112e00b9-34e2-4b26-a577-af1fd0f9f7ee_Enabled=True;
 MSIP_Label_112e00b9-34e2-4b26-a577-af1fd0f9f7ee_SiteId=33440fc6-b7c7-412c-bb73-0e70b0198d5a;
 MSIP_Label_112e00b9-34e2-4b26-a577-af1fd0f9f7ee_Owner=laurent.figadere@atos.net;
 MSIP_Label_112e00b9-34e2-4b26-a577-af1fd0f9f7ee_SetDate=2020-01-13T09:30:53.4341647Z;
 MSIP_Label_112e00b9-34e2-4b26-a577-af1fd0f9f7ee_Name=Atos For Internal Use;
 MSIP_Label_112e00b9-34e2-4b26-a577-af1fd0f9f7ee_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_112e00b9-34e2-4b26-a577-af1fd0f9f7ee_ActionId=8793476a-0535-4525-b547-4240de124463;
 MSIP_Label_112e00b9-34e2-4b26-a577-af1fd0f9f7ee_Extended_MSFT_Method=Automatic;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_Enabled=True;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_SiteId=33440fc6-b7c7-412c-bb73-0e70b0198d5a;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_Owner=laurent.figadere@atos.net;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_SetDate=2020-01-13T09:30:53.4341647Z;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_Name=Atos For Internal Use -
 All Employees;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_ActionId=8793476a-0535-4525-b547-4240de124463;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_Parent=112e00b9-34e2-4b26-a577-af1fd0f9f7ee;
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=laurent.figadere@atos.net; 
x-originating-ip: [80.78.5.104]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ed120eb3-fbd4-4b14-17b3-08d7980cc71b
x-ms-traffictypediagnostic: HE1PR0202MB2619:
x-microsoft-antispam-prvs: <HE1PR0202MB2619D02C28A35AF777727F29E6350@HE1PR0202MB2619.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 028166BF91
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(396003)(39860400002)(346002)(136003)(366004)(199004)(189003)(33656002)(9686003)(2940100002)(26005)(76116006)(186003)(55016002)(4744005)(6506007)(52536014)(478600001)(2906002)(5660300002)(8676002)(81166006)(81156014)(71200400001)(316002)(8936002)(7696005)(86362001)(6916009)(66556008)(66476007)(66946007)(66446008)(64756008);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0202MB2619;H:HE1PR0202MB2634.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: atos.net does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: f9EvnxIpcjj40NmcH/enrQU3IIUe5wil/AgnAQHlaflJUbpA2YNpgFEtnXOZSx91KresYxvfzwxLVKLUJgXdoC5XXHGYRNoZmhDVKNjuujUY32VgcE4SjgIWuQ8Izkc3G1DgnoV+1oOzwKBjMZOeYjftPvBmFp5YRAcuCOFnUWcdzW9PnWHLOM3fqae1YfzW/klpJ/ELg35s0Kx7h+aps0vpxwDL4W5aDDaTOVVIrPAyxCWRK/aoB4RmVH3ANfkJeIZP1zLsfbDGlB8R8RRi9nQyhcktcAJvRrGas4sSF6HZSs43QXx2WOxtz3Y+xsJWVhDDlE6+kPw/XPwy7m6LDPAD2yzN/JAs0+ZZKEBZggoQkazaQxv68/Eef9Pz0NfnexYfwYgve3QEolcwukJ4lH683Ouk+KTw+h5xjU3qpq0+5ZrpAIW57tyKd4+YX9gI
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ed120eb3-fbd4-4b14-17b3-08d7980cc71b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2020 09:41:34.2546
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 33440fc6-b7c7-412c-bb73-0e70b0198d5a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DuRw6nyXZZ0YrUHUjLaheowcUWXth109bnLwL3xD8eWilZFHt8tM+qZeM2F3mw+WZLWddrknpaoE6dXk6ZKchmIVuugEIdTi9nmArIOhNUQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0202MB2619
X-OriginatorOrg: atos.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear git community=A0,

I am using git submodule features.

So, by example, I have a repository top which include a sub repository sub-=
repo.

I would like to re-write the whole historic on the top repository without t=
he sub-repo.

I tried to use git-filter command but I have an issue on sub-repo.

Here the commands and outputs:
[10:27:42] $ git submodule
d3fc420ee38babe74d6e3838b5b2a946ee551fa7 sub-repo (v1.0)

[9:55:48] $ git filter-branch --index-filter 'git rm -rf --cached --ignore-=
unmatch sub-repo' --prune-empty --tag-name-filter cat -- --all
Rewrite 471a2c664466a364bfe5fdf774c7c0d7efe50396 (32/54) (3 seconds passed,=
 remaining 2 predicted)=A0=A0=A0 fatal: exec '--super-prefix=3D sub-repo/':=
 cd to sub-repo' failed: No such file or directory
error: Submodule sub-repo' could not be updated.
error: Submodule ' sub-repo' cannot checkout new HEAD.
Could not initialize the index

Was somebody able to remove such historic from a top repository?
Thanks by advance for your help.

Kind Regards,
Laurent FIGADERE

