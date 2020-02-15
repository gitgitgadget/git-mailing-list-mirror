Return-Path: <SRS0=Fd5/=4D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BAF5C352A3
	for <git@archiver.kernel.org>; Sat, 15 Feb 2020 21:40:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0070620718
	for <git@archiver.kernel.org>; Sat, 15 Feb 2020 21:40:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amat.com header.i=@amat.com header.b="LdE2VTpY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbgBOVkJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Feb 2020 16:40:09 -0500
Received: from mx0b-00128c01.pphosted.com ([205.220.173.92]:26572 "EHLO
        mx0b-00128c01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726273AbgBOVkI (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 15 Feb 2020 16:40:08 -0500
X-Greylist: delayed 1724 seconds by postgrey-1.27 at vger.kernel.org; Sat, 15 Feb 2020 16:40:08 EST
Received: from pps.filterd (m0187208.ppops.net [127.0.0.1])
        by mx0b-00128c01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01FLAVAL003635
        for <git@vger.kernel.org>; Sat, 15 Feb 2020 13:11:24 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amat.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=secureemail;
 bh=eMA8zmBl/mHUz6CV/IjfmRzCjw60++wXn/o4vige3v0=;
 b=LdE2VTpYW3wi6ibk+DDkJuIwkCoZc3ClNEY4eLtFMInfP6jeIYWiWVzlx0jUVV2uU4TG
 lQPYMo6zYxH1rk3JjMh5dlIGOZVrICIbd372PPvfj9L5mL97VpYRARvUlBJ6SQ0VSmIm
 3igkZDH2+rscyV8Gbt21LwmyzAXH0m6UT2L1AHR9HReUZX7A3ChCA7Qk4YcRwGn702VJ
 /wqhCb153nkfSBE3wPsv+DTHEomKFyDwHxZXw+Isfy4Ir8zU/KLM8YrEHAjiCZFHcLlI
 FJ1IRw12EGxw9XDk/hJUlG1bmJh8o9FTMXMivUPtQPuKOB4i42d6aLnWuTtbXTAm6IlF jA== 
Received: from eur04-vi1-obe.outbound.protection.outlook.com (mail-vi1eur04lp2055.outbound.protection.outlook.com [104.47.14.55])
        by mx0b-00128c01.pphosted.com with ESMTP id 2y6fa2rdwp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <git@vger.kernel.org>; Sat, 15 Feb 2020 13:11:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=as5FehpKmwLC4ATFuO1GADpyLv6RFOZz/fHv8Y3t2pD4URQmwXBk1ESaHvjmb+tlys+S0OJTvDQaM+bBZL1u3NF/bD+XijzXA+giJrrKzBOpdLjKFXe+Af1cd4T830W3uhZdMLTV9DfJsPOx3LUWh1jeMfu5qqdgigbs0ejUnQvkb2FxB/39cGf64mZG7ydFdZ5vtBJU/dErOBI2sEFjrsfW2198dBP0VkLyIM+2QAk+Csx2F3GfDqelbkLvTmq19YYRInoEXnzv19kH+TanHtGpzNb7ry5FzBI4HfzBXI7QxBnAQjjNt8x2Ik1eoQwBM39g2WGlP2HRzxoTE6e41Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eMA8zmBl/mHUz6CV/IjfmRzCjw60++wXn/o4vige3v0=;
 b=aDUoXvN7nja8/9+fbvwRKgd16YALbXYwWAhABqfky8KFezO902sRbNvNs9R8aEm+Fe7xiumg5BdkKODZom2Ku0YMCGCdbS8H0suuUS+Y8aOD+LkbxMfLZfReT7lQI71HDfbVfLeQfFIc4/mpn24a+hkKJ3oMRS7a/5Ney4dJ/RzmGZTYRv2qQe3uzjA3L4fuBjOD3SDkR4bhPAXpI9VDCO3esLMKJf8Tb1v9mX9cV4Tc9JbMFmYkkb4qKNXi0g0xdLlPLtGHmspN0rj6/Ij41fLMoEU1cTbiNXk/NZj0kWQKWkVsPCJubfIrTJ4B+mOxUr/pCdwaGhFneAqCCTNsaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amat.com; dmarc=pass action=none header.from=amat.com;
 dkim=pass header.d=amat.com; arc=none
Received: from AM6PR09MB2598.eurprd09.prod.outlook.com (20.177.115.143) by
 AM6PR09MB2535.eurprd09.prod.outlook.com (20.177.115.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.27; Sat, 15 Feb 2020 21:11:20 +0000
Received: from AM6PR09MB2598.eurprd09.prod.outlook.com
 ([fe80::48e:1ce9:87b3:b3b5]) by AM6PR09MB2598.eurprd09.prod.outlook.com
 ([fe80::48e:1ce9:87b3:b3b5%2]) with mapi id 15.20.2729.028; Sat, 15 Feb 2020
 21:11:20 +0000
From:   <Boaz_Nahum@amat.com>
To:     <git@vger.kernel.org>
Subject: FW: bug: fatal: this operation must be run in a work tree - after
 enabling worktreeConfig=true
Thread-Topic: bug: fatal: this operation must be run in a work tree - after
 enabling worktreeConfig=true
Thread-Index: AdXkK+eZTVi1/o0rS5yRA49d0Td4rgAGGkUg
Date:   Sat, 15 Feb 2020 21:11:19 +0000
Message-ID: <AM6PR09MB25980EF868A3FA782109D8DE9A140@AM6PR09MB2598.eurprd09.prod.outlook.com>
References: <AM6PR09MB2598893AEA5DB2D55DDFBF299A140@AM6PR09MB2598.eurprd09.prod.outlook.com>
In-Reply-To: <AM6PR09MB2598893AEA5DB2D55DDFBF299A140@AM6PR09MB2598.eurprd09.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [212.25.107.145]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 68ed5635-734e-45a6-140d-08d7b25b9a97
x-ms-traffictypediagnostic: AM6PR09MB2535:
x-microsoft-antispam-prvs: <AM6PR09MB25358C4AE8F125F3477F66209A140@AM6PR09MB2535.eurprd09.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 03142412E2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(136003)(346002)(366004)(39850400004)(376002)(189003)(199004)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(5660300002)(26005)(52536014)(186003)(33656002)(6506007)(316002)(9686003)(6916009)(478600001)(8936002)(86362001)(71200400001)(55016002)(81166006)(2906002)(2940100002)(8676002)(81156014)(7696005);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR09MB2535;H:AM6PR09MB2598.eurprd09.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amat.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NQN3BCTYLx47ySQeCWnFE3A+AEb+ihjSFFcj1F9yVy+IhnyMbB4gj76NzBSIDF5mmQK7gDZaANhfKkGBzcwPLO3s7rGxG09Z2eiIGq3xodaZaPJMQL2rPHgs0QXahry8DT4fApHnaY2KFyHv5zNtnLvMNXVt6CbYS6IiRbgveZ+vKBU3XzsuKCgjfHOzBDB6k/Ffn6xZiT9EF5IwjTomEU22x+u8K8Qs/eK+Sv+S4kIxa9MRL5LDXAoCUK7hU16IQQuAqIH5A+LznU0ErigMNTbfpNvqWurFSrFg4/GWYq5ZAk0GbkKEj5KBFUV4AjJHddd55tm62SUQiSDwOIv5N3sW5kPHgUIDRfR3ClusriP6mPRWrWwcdhV8EkclcqcKUa2NvNqs3A07osFx0oegZN1sDJ/eAZvTTRNKhsgAfSyTON6YS7oqNdA30f3THKNe
x-ms-exchange-antispam-messagedata: faNigHFhuzZxn7e98UuO6HxaZsibzcTNTk4NC+8uU80nvWPhqGzlTmzAKsWvBvg+FedWHeMo8fBsAmITy/6pF5T/TqWIyqRFKUH5xSMW2DW+OQl/sZFXUSMKI5zRA8LJvokLq03ogYIiHx10Io/loA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amat.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68ed5635-734e-45a6-140d-08d7b25b9a97
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2020 21:11:19.9566
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 709c2643-b1a9-4415-ad0f-521cfa6ba3f5
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1msU25Bda0dPxf2gMfBlfLBea912jR4X0g/JYs7YXQZZIIpqeSZK19o/92tb4CkgCSJDNXZqBMxWQQc78tQFQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR09MB2535
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-15_08:2020-02-14,2020-02-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 spamscore=0 impostorscore=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 mlxlogscore=999 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002150185
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Hi
(English is not my language)

We started to work with sparse-checkout and we found two issues.

We work with bare repository, with a worktree 'arounds' it.

Two issues:

Issue 1) fatal: this operation must be run in a work tree

TO reproduce, In bare repository:
   git worktree add ../testwt pub/empty -no-checkout
Switch to worktree
  git sparse-checkout init

Result:

    fatal: this operation must be run in a work tree
any operation in any worktree now ends with:
    fatal: this operation must be run in a work tree

This is because  extensions.worktreeConfig=3Dtrue
Workaround
1. core.bare=3Dfalse in bare - not acceptable
2. Remove worktreeConfig=3Dtrue  - not good idea if we want to work with sp=
arse-checkout
3. core.bare=3Dfalse  in worktree, but we need to apply it on any worktree

Please note that this happens even  if in time of creating worktree worktre=
eConfig=3Dtrue

Issue 2) fatal: Unable to create 'F:/views/MonoCentral/worktrees/testwt3/in=
fo/sparse-checkout.lock': No such file or directory

To reproduce, same as above, but worktreeConfig=3Dfalse before starting,
Result:
    fatal: Unable to create 'F:/views/MonoCentral/worktrees/testwt3/info/sp=
arse-checkout.lock': No such file or directory

Workaround:
  Set extensions.worktreeConfig=3Dtrue  before adding the worktree or runni=
ng sparse-checkout



Thanks
Boaz


The content of this message is APPLIED MATERIALS CONFIDENTIAL. If you are n=
ot the intended recipient, please notify me, delete this email and do not u=
se or distribute this email.
