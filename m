Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17E42C32771
	for <git@archiver.kernel.org>; Wed, 28 Sep 2022 17:55:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233331AbiI1Rz3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Sep 2022 13:55:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232792AbiI1RzW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2022 13:55:22 -0400
X-Greylist: delayed 592 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 28 Sep 2022 10:55:16 PDT
Received: from mailgate11.slac.stanford.edu (smtpgateway.slac.stanford.edu [IPv6:2620:114:d000:2598::b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C95C0CCA
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 10:55:15 -0700 (PDT)
Received: from ppops.net (mx0a-00000d04.pphosted.com [148.163.149.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailgate11.slac.stanford.edu (Postfix) with ESMTPS id E1419804F3
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 10:45:21 -0700 (PDT)
DMARC-Filter: OpenDMARC Filter v1.4.1 mailgate11.slac.stanford.edu E1419804F3
Authentication-Results: mailgate11; dmarc=fail (p=reject dis=none) header.from=slac.stanford.edu
Authentication-Results: mailgate11; spf=fail smtp.mailfrom=slac.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=slac.stanford.edu;
        s=default; t=1664387121;
        bh=x0Zd3Mb/hw2NhRhLfyJbMV2CgcfisXDdjx2gvejs8xg=;
        h=From:To:Subject:Date;
        b=ghY+bxlePDwuJCk5wgQjUYr9xBewtHjfG8GfUWZUgG+BvGI5sqbfGzNI8TeWbR334
         Ajz61+JE0S0mE1W9Osz/y1JlyRnmte3mmp1rNqJdBRf6IwwrORNwYVHFuM55tR+ITy
         JIVzQx3kBwxgvaV6iOLtV1O0JUBGZevZS4wpdJjs=
Received: from m0102889.ppops.net (m0102889.ppops.net [127.0.0.1])
        by pps.slac_mgt (8.17.1.5/8.17.1.5) with ESMTP id 28SHjLwQ017791
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 10:45:21 -0700
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2106.outbound.protection.outlook.com [104.47.70.106])
        by mx0a-00000d04.pphosted.com (PPS) with ESMTPS id 3jsy7cprnj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 10:45:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ealsV8nlLbgLnxP/QZqDnaIQPnGF46CEg82gDBA6ZJXYvvyXM6rHpHfiSy3sob7zd7RQEa6JcZ9DeZE1r/Ckv0RTYb8s3zRpAP0dIexNoLAUoaL+1uKCEfJsHl5Ud9/5JEHURrg0VzppexLqSp+zA0qOJlUoJMksc4d4DCnjjlaNm+eqDKiQ2QJuq//AIg7qW8pdhRvaTDqW2mMo+6flqPnTajOxebLcWY/XRiCp/dpbPy14O5dOMW/8UAh3uTIMC9G5UiWZQhXDgyZFKlZC4Xd114kcyKqdsMUf02AkGrD+xxHZZdAGmJEyuXH2OnDCFiMoTCpIwWlnvwDYJxx6DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x0Zd3Mb/hw2NhRhLfyJbMV2CgcfisXDdjx2gvejs8xg=;
 b=V651Lq4f/hrmwbhkokGVCFp0U3/5Nexe/zbVyVK4ul3LLg5qP6FtO2kZg/F8HrCAF5Gyz5MN2ilVXiIUyqmvwRp6XsrOQNCr9Mhu9G1JqkSVdyTulnAsbX0Dgxy3mXF/Ol0Ezw190ukn733S1P027FiSIOq4E564MJG6EyHPf7i0ZYy1mhn/DGuRiz+d4r3wAWoaBAGAnNUndr7L6LmlHYJnsRHFP2YsoLJ1tsZxDNF6/EU5ryKbBFTnVUoXtrV4ojA3oFo95pNKkk50xQjvz8LlcLyVw9k4b5o4c6CJV/c3e31NvNle7yI7DOs5T47ozzM4CX3kORgXyyegs5HNrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=slac.stanford.edu; dmarc=pass action=none
 header.from=slac.stanford.edu; dkim=pass header.d=slac.stanford.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=slac.stanford.edu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x0Zd3Mb/hw2NhRhLfyJbMV2CgcfisXDdjx2gvejs8xg=;
 b=HtSfOE5iRkZNiwwYyLxdCNNLP9jp4Bt13DGtxIyJqxu7S7ng8qKrK0B1XTYi2y1Jo00U4QTS0wMTrlR7NYLkXpK188aLwe/uCJH3qEjQ0bER0Crxp5vSV7Q/yoGhQwOJuQ14VYAm7vFBJaBXycRL28vMn/4sYDPH5NClN/EiQ2s=
Received: from CH2PR07MB8187.namprd07.prod.outlook.com (2603:10b6:610:6d::10)
 by CH2PR07MB8124.namprd07.prod.outlook.com (2603:10b6:610:69::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.18; Wed, 28 Sep
 2022 17:45:19 +0000
Received: from CH2PR07MB8187.namprd07.prod.outlook.com
 ([fe80::ccc9:3055:3f73:42fa]) by CH2PR07MB8187.namprd07.prod.outlook.com
 ([fe80::ccc9:3055:3f73:42fa%8]) with mapi id 15.20.5676.017; Wed, 28 Sep 2022
 17:45:18 +0000
From:   "Ng, Alexander" <ang@slac.stanford.edu>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Git pop/apply/drop with stash message
Thread-Topic: Git pop/apply/drop with stash message
Thread-Index: AQHY016OgE23NDLx/0itc4nlz9nvMA==
Date:   Wed, 28 Sep 2022 17:45:18 +0000
Message-ID: <CH2PR07MB81876BD87634A5C62BF0BC12EC549@CH2PR07MB8187.namprd07.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR07MB8187:EE_|CH2PR07MB8124:EE_
x-ms-office365-filtering-correlation-id: f982f92b-0817-4df9-c998-08daa17935a0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gVOLMQzQK0XnR6rTZ/PQZSgT0Yy3tvFruG7zQi32TqIToLVTUuRVGmEFHpyD+rRanVjPw2dVnlJ7yvUJNCLWwI6QTw+VL02SfUT8XcG1Jse3yqov2Za1qS+qEWAd17J6J0Q/adn295pFEDC3SfB7zCXG1c7QfX2HyDQE7rWlm4RfXG/98+qdQ1BdWMqUZ/XQ/4XyBzDpmt7inGplVAUSQEM/B5Xb/s8HOWmznA4MTa8gopOfTxKDqCEBe8ZsfrPuZ4laU0NSEagkCQ3hBSmWvRUiT8Zh+BUWe49PR1UCR8clgkxqoPJNP1EOwWs9PKwdXisMMKiEK8FKyA3vvtA9C2aFaarhvroCw9HvJMY8OxxXi0iUZt7mCKXOuwP5VSvMfGInZLsRiNmgATYWUbHSKcx5aG4od8+BRqbdhHknkpD8CgE4zKohDWtcIysg2d0rR5iu6bihua/PTnWUgdrSgKTh88v76GL7lO6nvYSs5fGNM+XGvpRfvMH0Q2M27FHTMzRkWk4DBBptFPA5XWn+vS0nIJhwMO3d+vAKnmQzEDhqpixEpDZ2BYpOq/nfTVJ0eC034IFjEus8a8mxU38ozLxYxWRZ/MlQJlyZ+HCEAJI2zCw+Dbr4cwTLVI45AhjpbZ8DgwlcJu1djmQDUoCYKPUuqke0slQiCEc8QDSohHdmgIheGm+CDXAGDHQwXT7AK2oAs8pM1qpRRyPuP1c7o8DD65yGU5ujvDDlY0lqhBiY5A9efm6Dq7VLGBjdF5fGWep7w7yS36LZgIirgSaNaQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR07MB8187.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(39850400004)(136003)(396003)(376002)(451199015)(316002)(6916009)(478600001)(786003)(71200400001)(6506007)(8936002)(66446008)(41300700001)(9686003)(52536014)(66556008)(66476007)(66946007)(76116006)(91956017)(64756008)(8676002)(5660300002)(26005)(2906002)(33656002)(15650500001)(75432002)(186003)(83380400001)(7696005)(55016003)(86362001)(38070700005)(38100700002)(122000001)(41320700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?PDQ4OK11DfDWbRbn2wcx1TB+ir2ir3jc3nhAJyBgG15bbSegWrHLRbTNlm?=
 =?iso-8859-1?Q?RgM0pGIdH6cKr8wnE+GD3eva028anKEEZpk+7emKfZiwJq+5oq0TfH5lny?=
 =?iso-8859-1?Q?ZD7ySEUEINdRiN7/5qbIA+yrCiOVdzj6vcR3FQznSeRwnnvKkM00chpBM5?=
 =?iso-8859-1?Q?t1eWElAnU28Fy28xpLYPxbBvkDngOMl/+hORiJmpntseLu5iXKx0RDGX6+?=
 =?iso-8859-1?Q?TWXJYfmXArycBOuhUcPoIJThLJCu14KLiekWgl590XFZG7znnvNlmoY1xZ?=
 =?iso-8859-1?Q?344QRFAOIUqElvyOX9ZoQTyrAW+ZpsAOj53YJCHHhyyytCekJTqJPb0gDy?=
 =?iso-8859-1?Q?QouGIVipBtOlLrSEJesfiG/rMmOo/roZiU643i6GE9/vUArRHxdG6xP0X1?=
 =?iso-8859-1?Q?V+70OMVWmP5+tUD1FZlDTNj/9bJWYCE/yEY0YwkdKuVkV5G9LPBXrIG0CY?=
 =?iso-8859-1?Q?yDWN4426UCDAd37DpxTflP5XuSkDtln0saPAAAxPTDZXhKrbZvA8us0+oz?=
 =?iso-8859-1?Q?q9Bt7Shz/PqddBIwS7qhmAyVOslxUqAEB/nFBtFSczHq5yp8a4QjluDfCx?=
 =?iso-8859-1?Q?++/qJUTGjXOJ8YQmikdQV45OkFJLzMqyFKBPlVcBIncnQ+BH7QN8rLubSh?=
 =?iso-8859-1?Q?gA13KhKdtJBZiFA5WRPL3dQSH7OsKq8kp03yWfURoDNFTgBR8yMwPQTLRT?=
 =?iso-8859-1?Q?N0MNCQoI4zeSpCW7pws6iu+w2BxcDWQpmgUKZC93UNj8h3FG2IVeDbBM4c?=
 =?iso-8859-1?Q?NFCVi/p37gLAXGpXli9qSZzFRpCA5auifydTfDsl2n6lnLIBWAAMKuUuld?=
 =?iso-8859-1?Q?YnOk/rtg/cjO8zvz5ghlT1y+FhW9TUblsDReNgijBatYt0QOwsXa/jRtr4?=
 =?iso-8859-1?Q?sRfvWXR2axmtfjCz44ytovRF0JWvZbji6gkF7X0EJNkMRJBaeNyX8belSI?=
 =?iso-8859-1?Q?4hLwqHolti7DGAAKsV5tootiJ0t9/Ddi7I6cj7utZdOWGPO+JRj6zxeuq0?=
 =?iso-8859-1?Q?/v0YF/KQdlaVuqVu+G7lN94jhqgNE6FDw67xyyzq2wqgcT9pZ/GANf/7lT?=
 =?iso-8859-1?Q?4aArXLHSL1oVLvYM+t9zLKZ6CWmlptsuvOjtU3FUID4e+XaWal54q82Ndn?=
 =?iso-8859-1?Q?7VMu7K1yO3kAcHOJYKLSCwXswGf1JKLxE2WwTEbqq3HQ8iFG3/NqXQK+6N?=
 =?iso-8859-1?Q?EVFe4+raMHkCL9p04iF1Jn2WLplYZy1h/hpTScz3ny/PoVwCQXLY//W642?=
 =?iso-8859-1?Q?xcvchwm7mjfkQjfDgMhZ3hoqG4j+FT04Rr0hNWDGhO6N2dxsbMQ1JbGWNS?=
 =?iso-8859-1?Q?+5cXbzOlRS6jepvzIktgex1Px7Czxdd9WKAS6IBl95kGzlm7B3KV8muSUR?=
 =?iso-8859-1?Q?c5AQQdv/jCFytVs/ZRqQU7vtnGsX8Spg09aWRSlrOcTs3j66qmNAV+Q6u8?=
 =?iso-8859-1?Q?Ueif4WB1R/CHZFQ6E+7iRrgh7e8wN5kCA7mie7aNlD3w+tjLJxZ5mNWmLr?=
 =?iso-8859-1?Q?TpSLiq8F8Ve3ISwNlicUAQRkk/2Jgl/o4k2dwsoMgFiqfTmdZSOrrmvZA3?=
 =?iso-8859-1?Q?TzZFwyMTIfUxm3c3i9/RYCrmwvt27/yGjpq5mR9sC4asl5kNx3OGvUEUCS?=
 =?iso-8859-1?Q?LjpbyW3syeLhtkM2XiLawE6t+toend0WDc?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: slac.stanford.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR07MB8187.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f982f92b-0817-4df9-c998-08daa17935a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2022 17:45:18.8722
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: cef2ae5a-2666-4716-9b60-e88e2aebf49a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KV6r8CpMCvLKBXTO2xMcIdOfTzODC9qH08cJWsCCekn6YphdlF+ltHUsavNQMTwAszmXzWDohYZs1qYyRbWmQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR07MB8124
X-Proofpoint-GUID: beeHdWifF0artqcRfWnvItrAoV2GXxro
X-Proofpoint-ORIG-GUID: beeHdWifF0artqcRfWnvItrAoV2GXxro
X-Custom: SLAC verified emails
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-28_07,2022-09-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=717
 clxscore=1011 spamscore=0 impostorscore=0 mlxscore=0 phishscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209280104
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello, I am experiencing the following issue. Thanks for reviewing.=0A=
What did you do before the bug happened? (Steps to reproduce your issue)=0A=
1. Changes in working directory=0A=
2. git stash push -m "test" :to stash changes in stash with message "test"=
=0A=
3. git stash pop stash^{/test}=A0 :pop stash =0A=
=A0=0A=
What did you expect to happen? (Expected behavior)=0A=
git pops the stash with message "test", applying stash to files and removin=
g stash from list=0A=
=A0=0A=
What happened instead? (Actual behavior)=0A=
Returns 'stash^{/test}' is not a stash reference=0A=
=A0=0A=
What's different between what you expected and what actually happened?=0A=
Git stash pop and git stash drop do not allow for referencing specific stas=
hes by message.=0A=
The desired behavior does work for git stash apply stash^{/test}, but I nee=
d to also remove stash from list.=0A=
=A0=0A=
Anything else you want to add:=0A=
=A0=0A=
Please review the rest of the bug report below.=0A=
You can delete any lines you don't wish to share.=0A=
=A0=0A=
=A0=0A=
[System Info]=0A=
git version:=0A=
git version 2.35.4=0A=
cpu: x86_64=0A=
no commit associated with this build=0A=
sizeof-long: 8=0A=
sizeof-size_t: 8=0A=
shell-path: /bin/sh=0A=
uname: Linux 2.6.32-754.43.1.el6.x86_64 #1 SMP Wed Nov 17 07:27:32 EST 2021=
 x86_64=0A=
compiler info: gnuc: 4.4=0A=
libc info: glibc: 2.12=0A=
$SHELL (typically, interactive shell): /bin/bash=0A=
=A0=0A=
=A0=0A=
[Enabled Hooks]=
