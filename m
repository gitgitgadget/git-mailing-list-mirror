Return-Path: <SRS0=QcP8=4I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E9A7C11D00
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 23:52:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2E8D206F4
	for <git@archiver.kernel.org>; Thu, 20 Feb 2020 23:52:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Yvlyyfx+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729341AbgBTXwn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Feb 2020 18:52:43 -0500
Received: from mail-mw2nam12on2114.outbound.protection.outlook.com ([40.107.244.114]:9619
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729234AbgBTXwn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Feb 2020 18:52:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GPO6eFEaTXSmkFznKcWjLmG26WMZ5FGv3AuPkVN3ZWFds9hN4ATAnR/MG/FV7fdf04n19ETwgzxuZStvGwdN25EYiuPe/AELJkBYDaRTkY6cUUcSXnA48C1iJlP2iMVakX8RHitQJ6cOj6oGi+8EqWlrUB9uSfqontn3mAHI0aw/pRIkWnK00pJ8l5RFyhHFzP++V5eY5LAuErK0yLUyOJXaG7scILo+q+pGg+1/D+Hlwp3k7sK5ODFowWmijVi1ZbFTf8TfkfhELDON0qozfVae5Yn8n8G0AUshwFhvMgh5b7DBoT9H4188b6LE2CPo5Z7wKEZRylW/XnMTxTCb1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q2tN/OpSO+qm35wKWjLJVOLsV/JYbi9/oPbLX+Oy06Q=;
 b=jE5i2XI7hdt95KsPIpYG/C++mwnCJDvZX+fkKr5s+Y3IEy6gFHWeUxdKKxAbC3HNd8hCBD1nn9Elu7RtG1nh+JuwKd+PYluMcZmwQKzzMFezp7nM9DClNQqbTPo6D2h/Ukpd3KbRMSCkwGjzUbqUNRJUJz+C8AtNHOnmgh6vS1JQQYyXMqkJuVMhlLqALPdkNm3W6w7Szgw7gprwAvV5Au99sZ2Woys9VQXcsUTPkNrX/5O0AP6Xm4Xd7IfZyY3hBW6LfiIfhls5mlS1SzVQXL5CCTU/rqkU7xtmH40ApeQE5u7nkmF0cpPCD+KvRaLRy8qfLL2t/8OOWzUlfeqTkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q2tN/OpSO+qm35wKWjLJVOLsV/JYbi9/oPbLX+Oy06Q=;
 b=Yvlyyfx+C8qztVgHCdLMzKm3+EWNsOgQhRCxN//MfUEw3M9MQ0bG6qpkFYNTkn7ahbyV7h415t2nRUxdwm6RPxFAZMgzqpeIfumqEd4x9ATKj7JaSCToVnCikQkQJssXOrcp4uIhSsmtxNX/OECul/5foZoqN2b3KXomtYQOeQU=
Received: from BL0PR2101MB1089.namprd21.prod.outlook.com (52.132.24.23) by
 BL0PR2101MB0979.namprd21.prod.outlook.com (52.132.20.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.3; Thu, 20 Feb 2020 23:52:41 +0000
Received: from BL0PR2101MB1089.namprd21.prod.outlook.com
 ([fe80::fc40:896b:a454:8afe]) by BL0PR2101MB1089.namprd21.prod.outlook.com
 ([fe80::fc40:896b:a454:8afe%3]) with mapi id 15.20.2772.002; Thu, 20 Feb 2020
 23:52:41 +0000
From:   Adam Milazzo <Adam.Milazzo@microsoft.com>
To:     Junio C Hamano <gitster@pobox.com>
CC:     Elijah Newren <newren@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: BUG: git clean -d cannot remove files from
 read-only directories
Thread-Topic: [EXTERNAL] Re: BUG: git clean -d cannot remove files from
 read-only directories
Thread-Index: AdXoHrH5FO1NZ7qPQtSWwmVAnLy0/AAB5HAAAAAqcWAABXeuDgABB4pA
Date:   Thu, 20 Feb 2020 23:52:40 +0000
Message-ID: <BL0PR2101MB108926E052DA3B9072AF9F1C80130@BL0PR2101MB1089.namprd21.prod.outlook.com>
References: <BL0PR2101MB108917C204868FA653C2948680130@BL0PR2101MB1089.namprd21.prod.outlook.com>
        <CABPp-BE8t+M5A8BpkYzs-WkoKDTCR_4jiT-vqwpLriuxhx46eQ@mail.gmail.com>
        <BL0PR2101MB1089E3CE7738BB70B65C17B680130@BL0PR2101MB1089.namprd21.prod.outlook.com>
 <xmqqo8ts99pp.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqo8ts99pp.fsf@gitster-ct.c.googlers.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=admilazz@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-02-20T23:52:39.7345021Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=a93efbc7-599b-468a-a2a8-5eeac5bebfd7;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Adam.Milazzo@microsoft.com; 
x-originating-ip: [131.107.147.187]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 64450609-b0d5-4cf6-5308-08d7b65ff8fa
x-ms-traffictypediagnostic: BL0PR2101MB0979:
x-microsoft-antispam-prvs: <BL0PR2101MB09793C2C28672FA13B6BBFC480130@BL0PR2101MB0979.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 031996B7EF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(376002)(396003)(366004)(39860400002)(136003)(189003)(199004)(186003)(26005)(7696005)(81156014)(81166006)(66556008)(76116006)(316002)(8676002)(33656002)(64756008)(66446008)(54906003)(8936002)(6506007)(6916009)(4326008)(86362001)(66946007)(66476007)(478600001)(71200400001)(10290500003)(2906002)(8990500004)(9686003)(5660300002)(52536014)(55016002);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0979;H:BL0PR2101MB1089.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7F6Uv8xLkj8cZI7UbMJVI/HYGh0ONisZ0N9d8+Jx+r5wamM2e21/Kgyd9h3y7/du1In4CUEn0zr/ajxMf4GC1W3qLpHMoDSjVmVd2OyvRlrX1TlED3oe7HHkDc1q8MVwrTRiDafUDs6RDgCGaIlzqW5/pg5IE93lszvuRZaGstBehpGYmEqN0EH/D2BVxydlk8EuCx4l5WPtT/DU8MUKPz4bWmx1LfRedx/MSSZiFyCDJMAwQp2GKPdp6WXoApwuWA9D72sZptaJ6iZaFnbyIqRwedV1csIbgdzwB1KFJckQ19hhZYyMkPdLpd5p8ZuoUxcQrFzvkGvKROu/A12OcGkzhyOzl3Arm7t8nGiW7JKC3Zj4vrvqIkzZR05OBeVYh2kO7fJtoiaNf1CXE9OqDSOS4zYdvn78BiotADAAsL5cOVQnT8Y8oXPbVW+uQ0ff
x-ms-exchange-antispam-messagedata: O4XddID1uFUmjwWqafDNPmHPngsX3F6Jbb8gr3XK/NMa/AQMYSsn98TPtqa7mpsGSw6JNEuMUzhSn8en0nwfU4jbHynw06YySgQ1JqNNLb0AlET+FeAebB6b6ZSwyL88jeXjdlygCM/QtAHMNdeKjw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64450609-b0d5-4cf6-5308-08d7b65ff8fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2020 23:52:40.9978
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Iybnta9P87wmkq3zqHv/KPQr087FcPlm8wOT/xJPb2uT1X7QXDhPj0choba1e6FStJRQbb6ixOBeFX953bQQkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0979
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Simply because that is how users would expect how the world works (iow, m=
odel things after what they are already familiar with).

This seems to be an avoidance of my actual arguments about 1) the purpose o=
f "git clean" and what behavior best matches it, and 2) the violation of th=
e general principle that if a tool invoked programmatically can fail, then =
there should be a reasonable way for users to avoid the failure if possible=
. But my response is:

First, there is no obvious choice for what other tool to model "git clean" =
on, even assuming that it should be so modeled. This goes back to the purpo=
se of "git clean". Is it just a recursive delete? Or it bringing the direct=
ory tree back to a certain state? I'd argue the latter, and if we want poin=
t to existing tools I'd point to rsync, which has no problem deleting files=
 from read-only directories if it's needed to bring a directory tree to the=
 desired state. It doesn't even give a warning about it.

Second, I doubt anybody here actually knows (i.e. has data demonstrating) t=
hat users expect 'git clean' to behave like 'rm'. Also, I am a user, and it=
 is not what _I_ expect. (And since some people here seem keen to dismiss w=
hat I say based on an assumption of ignorance, I've been programming for 30=
 years, using GNU/Linux, BSD, and other UNIX-like systems for almost 20 yea=
rs, and using various source control systems for about as long. Not that th=
at should carry any intrinsic weight in this discussion.)

Comparing to "rm" again, there is an easy way for users of "rm" to avoid th=
e error. Simply replace "rm -rf X" with "chmod -R u+w X; rm -rf X". What is=
 the comparable workaround with "git clean"? There is none that I'm aware o=
f, and that's perhaps the main reason why it would be useful for "git clean=
" to be able to handle it. If there is a reasonable workaround, what is it?=
 The best simple workarounds I've been able to come up with are:

* For "git clean -fd": git status -s -uall | grep -E '^\?\?.*/$' | cut -c 4=
- | xargs -r chmod -R u+w; git clean -fd
* For "git clean -fdx": git status -s -uall --ignored | grep -E '^\?\?.*/$'=
 | cut -c 4- | xargs -r chmod -R u+w; git clean -fdx
* For "git clean -fX": ??
* For "git clean -f": ??

These are not reliable because there are various conditions where they fail=
 (including ours), so I'm not sure they are viable approaches except in cer=
tain special cases. It's possible to handle all the possibilities with cust=
om scripting, but the workarounds would become quite complex.

So I ask again, if "git clean" won't have any option to handle it like rsyn=
c does, what is the workaround that can be placed in a script to get the sa=
me behavior? And if there is no reasonable workaround, perhaps it is a usef=
ul feature to have "git clean" try a little harder to delete the files, or =
have an option to do so?
