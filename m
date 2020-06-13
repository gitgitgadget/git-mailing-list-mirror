Return-Path: <SRS0=iF2w=72=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1792FC433E0
	for <git@archiver.kernel.org>; Sat, 13 Jun 2020 12:38:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C25042078A
	for <git@archiver.kernel.org>; Sat, 13 Jun 2020 12:38:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="uloe49kN";
	dkim=pass (1024-bit key) header.d=Dell.onmicrosoft.com header.i=@Dell.onmicrosoft.com header.b="ed2DS53I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbgFMMiO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 Jun 2020 08:38:14 -0400
Received: from mx0b-00154904.pphosted.com ([148.163.137.20]:1734 "EHLO
        mx0b-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726039AbgFMMiN (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 13 Jun 2020 08:38:13 -0400
Received: from pps.filterd (m0170394.ppops.net [127.0.0.1])
        by mx0b-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05DCVlqP029321;
        Sat, 13 Jun 2020 08:38:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=J6NLH8Fo8cleS4Z69X9H1lgGZXhHwbXCE4cF8HBelqo=;
 b=uloe49kNesHf81B5e24RQazO1LukUVglQ2s6BSEI15f8hQTVcILDM6crM3UnXrJkNp2p
 dWKUJbnHdXAkbdao7bEh06SuHm1NBvQ03GdN7/abTkavftfOLSOMhuwIG1pOgTqcO12E
 zihW9v/qUn4v0OHbIES9qFzlVjpEwHpDOwmTgWlfgZbw8V0riK3b3nKnfgTBERLqd0ST
 1MyhqBFyBZCC1BRSuYWJcb3IwhFkASiZs+uTa4QJZnD8hpTvpxuI+FbWKNDJcjX+a0jO
 Sg5W7YIA6Y5KV1WBzr4kcJP0qwDUsbLrhMWfw9/vy6wLQRnvnvMhwZBfOlHr4Bwkkf7D Hg== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
        by mx0b-00154904.pphosted.com with ESMTP id 31msc5rbs8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 13 Jun 2020 08:38:10 -0400
Received: from pps.filterd (m0089483.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05DCXFK3006333;
        Sat, 13 Jun 2020 08:38:09 -0400
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by mx0b-00154901.pphosted.com with ESMTP id 31mukf1k4f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 13 Jun 2020 08:38:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jHJ+T6XNuJKaabG2PQv9HxSAF/XwyXQrFCE5xwtJDa+vp3hWRVKEzLA9pAp6pcau1C/XgnLxEG0dJCp3z6xjocfGjf3kAU6YF0ibIOvyO7/O0xcajth6XeGg+btYhDntH1MEr82RhY0+ZxoJ20qF9ueBSICnkBAN/PvjiWg4XwRsjFzySXloRLUoj4tFYUOtDX+1vBfrJceiVYiiVEpJ8blKqzuN/fx5yoamTElmetWh3Wa1x3Lc2w5r4BmlUAXaLO9w4rQ8vN+ghOjhb6q/KOjWBU5Jo02JaswGj5zfzGhqu52wWuPujF297xPoZjtxHDYjtaSYgPi/uVAHCw9joA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J6NLH8Fo8cleS4Z69X9H1lgGZXhHwbXCE4cF8HBelqo=;
 b=NOSxkUqcDnDR6PJucRMOTJ+xRZ2L/4gjotROTMJBqjWs6xrkfFVptQ7FeGPJ+COo5CEC7DjXLsXO4J4a16gFVrl+FYdFoMBre2vui/csSOIEuw0Kohn91m3F58KwP8VY/v4dmHaCnGITB+E43gzwAQOlX6ku6KMs5RQNaIKJ6weOsVLvL1xBvIMFTSj7oGEPHasmMETe0gTf9gunmnriWKGX/JLe1Sc7hK76EP8bpkYnLQxfG0JE/6VTId1lwC7Ctuyt3+lQErnpfrgaAuR20uZufPS1RjIf+IknDyxTDq1I4uOuNZLoIzr9dq7M+P2b+00sYQAfNnXK7F4WkkcOwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Dell.onmicrosoft.com;
 s=selector1-Dell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J6NLH8Fo8cleS4Z69X9H1lgGZXhHwbXCE4cF8HBelqo=;
 b=ed2DS53ICZ9ko8+u/93DkMjnNn7A9riy0aVIz4VPX9OGl0MxvPF8tELC8O5oqIwGCj9jNyC5q9fdIcA7apFM21f4vdL6J9AASPTfC6sogcpA/5TyeWRZcJPBvUrIcY9L1WYsT06htl5LNePr5sDpTAYn23a59px5JUdBvh7ajRw=
Received: from BY5PR19MB3400.namprd19.prod.outlook.com (2603:10b6:a03:181::26)
 by BY5PR19MB3986.namprd19.prod.outlook.com (2603:10b6:a03:222::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.23; Sat, 13 Jun
 2020 12:38:05 +0000
Received: from BY5PR19MB3400.namprd19.prod.outlook.com
 ([fe80::2008:3bcd:b8ea:126b]) by BY5PR19MB3400.namprd19.prod.outlook.com
 ([fe80::2008:3bcd:b8ea:126b%5]) with mapi id 15.20.3088.026; Sat, 13 Jun 2020
 12:38:05 +0000
From:   "Curtin, Eric" <Eric.Curtin@dell.com>
To:     Christian Couder <christian.couder@gmail.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "Geary, Niall" <Niall.Geary@dell.com>,
        "rowlands, scott" <Scott.Rowlands@dell.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Collaborative conflict resolution feature request
Thread-Topic: Collaborative conflict resolution feature request
Thread-Index: AQHWQMCn0onLmOAyQEGi/GXRui4z8qjWdTOAgAAG3/8=
Date:   Sat, 13 Jun 2020 12:38:05 +0000
Message-ID: <BY5PR19MB3400AE170C9F5FF501D27B18909E0@BY5PR19MB3400.namprd19.prod.outlook.com>
References: <BY5PR19MB3400EB9AD87DFE612AFD5CC390810@BY5PR19MB3400.namprd19.prod.outlook.com>,<CAP8UFD3m9ANt6UOyOoMDy2haTJjhzL5ctFiki46ktgH3RLPqjA@mail.gmail.com>
In-Reply-To: <CAP8UFD3m9ANt6UOyOoMDy2haTJjhzL5ctFiki46ktgH3RLPqjA@mail.gmail.com>
Accept-Language: en-IE, en-GB, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=dell.com;
x-originating-ip: [78.17.145.223]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c3b951d1-2372-4230-dcea-08d80f969ebb
x-ms-traffictypediagnostic: BY5PR19MB3986:
x-ld-processed: 945c199a-83a2-4e80-9f8c-5a91be5752dd,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR19MB39868ED0DDF4DE817AED3E98909E0@BY5PR19MB3986.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 0433DB2766
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mcFyCIoAVrLZOe8/frUfmgWID1Wnu5EIsskoXFRi3v89jtHhd2Myb6kO29S/BTdSEBkSdoHUJvlamb0rOKKbXjCOml8aXD7TEX3aiu6CfAWO+MIj9h8c/2A0oYtJhnjNhywHzfRA9b/ImmCz/nD0pnkek5HO+j2Pr3BkVmJxWR++xEGmrBiO4oQccn66opLUgM7H12oTbEwA7RykJkn4FRLuMgFw6827cIQc/oZwxWtUQH6xvGjktRvY1fnM2FchTR8xd/af54hI4JHAKhjK3He2L4Hc4s/JtGUWGxqtrJmSYSo6+91NPbCW4eiBV996UVwrpHFkYef0Zg1M+RC9ivxU6ZoD3NvzHuHBAWu2waAbZU8J+uVJs7k63VFOSHjIJZDgcaV68n3BgOudPvKCgA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR19MB3400.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39860400002)(346002)(376002)(366004)(136003)(396003)(5660300002)(478600001)(66446008)(83380400001)(186003)(2906002)(76116006)(71200400001)(33656002)(52536014)(966005)(4326008)(26005)(55016002)(91956017)(66946007)(6506007)(7696005)(53546011)(8936002)(8676002)(6916009)(86362001)(54906003)(66556008)(64756008)(66476007)(9686003)(786003)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: u33xoelF6lsW4ni225tnYHzXvVCALSyhvmEFSRkJ/TllybXCIkYcZaNPWj9rMaLuHLKr9y/WuS6M24tJ+EI4GuYIZXl27Ki0OKtetrjYxYKTnErvcNVvZktfZM9L/ed7ozR6Yv7EL3zO6B9qyAmcE05UfPM7HcUJOxKsYFFJgzOnz3AIfYmAVFChAxuOGo/vlOSU0tlh/yeZ+n7Mv4ENvmj1BD4xJYqnMBLnQK386zOhlmSfRMnkPSEfL2Gz1G4GW9P4/vjUPnyk7d1c3HSFE2EUXtZ1G6VkZ+vY+RWCvW16vC0XmAwb4ghcf1lKTRMo3dRirsf1Ny5SkvRbEJjaoevFQdDjWYRNd8huupjwJ3PyGG9o0vBR/9CbpkSqYd5m2K4F8g+Nld9cN+7G+oD+97g/cXZEVC7omnWangWbpX1bCrTO/11c4YDSwWUwxRxoEyNc65AWShP9Nohw3Q8rVPxujsMdXKyNWt0VJB88Ifg=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3b951d1-2372-4230-dcea-08d80f969ebb
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2020 12:38:05.4178
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +vvYmy9O7glwc8DR8gw1qSdPjvZGAuPRwjIQTNEhj4QSrD7E2iOD95SRPOtNY9LA+jOQa+R4ydbSbrFGUIym3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR19MB3986
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-13_05:2020-06-12,2020-06-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 cotscore=-2147483648 suspectscore=0 mlxscore=0 clxscore=1011
 impostorscore=0 bulkscore=0 adultscore=0 spamscore=0 priorityscore=1501
 phishscore=0 mlxlogscore=999 lowpriorityscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006130112
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 mlxscore=0
 bulkscore=0 mlxlogscore=999 adultscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006130112
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Both great ideas! And have the same theory right? Merge until you come acro=
ss the first conflicting commit in a branch to make the conflicts smaller r=
ight?=0A=
=0A=
Thanks so much for your help! Any=A0alternative ideas? I'm definitely going=
 to try both techniques, although imerge seems like an automation of the fi=
rst idea.=0A=
=0A=
Anybody ever think of rewriting the imerge tool in C or whatever to get in =
merged into mainline git? Potentially I could do it as part of my masters t=
hesis if Michael H and the git open source community agreed?=0A=
=0A=
Regards,=0A=
=0A=
Eric Curtin=0A=
=0A=
Software Engineer=0A=
Ovens Campus,=0A=
Cork,=0A=
Ireland=0A=
=0A=
Dell EMC=0A=
=0A=
From: Christian Couder <christian.couder@gmail.com>=0A=
Sent: Saturday 13 June 2020 13:08=0A=
To: Curtin, Eric <Eric.Curtin@dell.com>=0A=
Cc: git@vger.kernel.org <git@vger.kernel.org>; Geary, Niall <Niall.Geary@de=
ll.com>; rowlands, scott <Scott.Rowlands@dell.com>; Michael Haggerty <mhagg=
er@alum.mit.edu>=0A=
Subject: Re: Collaborative conflict resolution feature request =0A=
=A0=0A=
=0A=
[EXTERNAL EMAIL] =0A=
=0A=
Hi,=0A=
=0A=
On Fri, Jun 12, 2020 at 4:11 PM Curtin, Eric <Eric.Curtin@dell.com> wrote:=
=0A=
=0A=
> Is there any existing or upcoming feature in git that could help make con=
flict resolution a more distributed, collaborative kind of task?=0A=
=0A=
You might want to take a look at Michael Haggerty's 'git imerge':=0A=
=0A=
https://github.com/mhagger/git-imerge=0A=
=0A=
> I also opened this as an issue in github as I feel it could be solved by =
either tool potentiall:=0A=
>=0A=
> https://github.com/isaacs/github/issues/1816=0A=
=0A=
I also made the same suggestion on the issue.=0A=
=0A=
Best,=0A=
Christian.=
