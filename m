Return-Path: <SRS0=NngS=CY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 518C7C43461
	for <git@archiver.kernel.org>; Tue, 15 Sep 2020 00:45:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BC5E208E4
	for <git@archiver.kernel.org>; Tue, 15 Sep 2020 00:45:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="K3gXquJu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726044AbgIOApm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Sep 2020 20:45:42 -0400
Received: from mail-dm6nam12on2074.outbound.protection.outlook.com ([40.107.243.74]:32097
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725994AbgIOApk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Sep 2020 20:45:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F5F4e18wVIS9R1tq7NMMH5cYnRXjm1qcOa4rHJ1LjfcJ1O2V1mrod8RlGITP2o5FCwUbJFQEGXYuehBsZ2xDO+8KPkLfVlCKRZY8XtiYgrYJ1oqszm4o4zSu50G2VZoKfSUp/elaR1Lm6lrcUGZUn/7dV1DfjpBLkPQL1oWP6mwou0tE0aRBxAJvQtHOBBFsbWlGrTbmLQ4kQp2/BHCDYhsIcnVuY3Na53D4VLF1AIVJ1VWvNtm1gnAQVxVdyS2BdHpQlFj3hJ3JO4d3DWGlfkY2OxPqZw/RKrkVH+Jd+4qylLrM40xQVv0etCBfRuG8iW5uj3qSrmoZmbmwhQmjUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OOGP4PXJjs29y7Rqs2TaIg+R82mYgITZmEKeeO1UHsg=;
 b=BytLaE7j9ZxlINM3Xy2FAtiwm/EyIcV2wbWiQ1JXdLgoZO+1vYPF75NyQsO/Wv2Izewt2iyiP5rd7Mkb6xN/+kDk/hD9PCW3NoX82bN27+mZRBjU0uF/E+s1pXhrBzC8+WBeOsyMulTmxQthyPwT6PfrF0SB1nUXqTvzE8K2TOuzwDv2IDsiXP33aSJvvQXBY2TWv2bLRfW4acrr44WNrqsQY1bjOqgOg/AqBTQeztjPcpqt0I93J4WR35QYshPmn+UxEZ4BpnQgIJYqpETqmG+elRJkchU/EbduXnyHbvnj/kH9PaW3CHVxAPhY4A+/8TCMShh2ia7B8Jumuw1xxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OOGP4PXJjs29y7Rqs2TaIg+R82mYgITZmEKeeO1UHsg=;
 b=K3gXquJuW6IC12JLLSNwGWctdIVTl/RpCN2ucW0rvIxH/76Q2js1IMV5dcF+qTlhwg36CjzvjtwTOH7mILGXAlGqcy9r0YTTPwrCV/U108RU2fybORntnqk8251Fgg+3bHGYfIB4mFzwSTrliyJrgcnqEreW/aFCY4m9Rxsk398=
Received: from DM6PR12MB3194.namprd12.prod.outlook.com (2603:10b6:5:184::13)
 by DM5PR12MB1499.namprd12.prod.outlook.com (2603:10b6:4:8::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3370.16; Tue, 15 Sep 2020 00:45:38 +0000
Received: from DM6PR12MB3194.namprd12.prod.outlook.com
 ([fe80::6538:6091:e95c:2c92]) by DM6PR12MB3194.namprd12.prod.outlook.com
 ([fe80::6538:6091:e95c:2c92%3]) with mapi id 15.20.3370.016; Tue, 15 Sep 2020
 00:45:38 +0000
From:   "Liu, Xuhui (Jackson)" <Xuhui.Liu@amd.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Recall: But : git-p4 unshelve 
Thread-Topic: But : git-p4 unshelve 
Thread-Index: AQHWivmH6AO7t7c1IUu6J9Km8IKLUg==
X-CallingTelephoneNumber: IPM.Note
X-VoiceMessageDuration: 17
X-FaxNumberOfPages: 0
Date:   Tue, 15 Sep 2020 00:45:38 +0000
Message-ID: <DM6PR12MB3194FC0CE3C2B8C78BC5B613FA200@DM6PR12MB3194.namprd12.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 00889ffb-79a9-4ae8-90d7-08d85910aa68
x-ms-traffictypediagnostic: DM5PR12MB1499:
x-microsoft-antispam-prvs: <DM5PR12MB14992C2087CF14382C39EB91FA200@DM5PR12MB1499.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TlSEHcnDbmpTh5MXSiug7fdILvLjINA0scJgw/OB8wsF1+b6lH+J6SdCkY8UHt1JOVOR/dUU1DA8TddqZqIjQYoVVeXT/oRK+V0kUoHbG9Fp+vkPpnD8a0GdVrgKhl/qtyP/PoxxuulMa4XKuxORbH4C3VlZuSDiAipZMA6KrSZHqtmhgZCVXBK9cjXrpRoR1awo9YtyJsUK5RBFbIYAV0gyt1VOBE9/JkmuhJksCl3+2dek5XoZ3Q9si+fS+rQalwUYls4V3EYDIUyYurqXOGlKirk6LfGklTSWOlZZsiX+Sg48aH4i2ZIbHfAlK4GckXmqz2QunWTP+O7DNpZmxpFGvoG+zHOYWJVXclP+wrdUB0WGoScWzfvvVe8nOTvx
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(346002)(396003)(376002)(136003)(6916009)(8676002)(64756008)(66556008)(2906002)(66446008)(7696005)(71200400001)(66476007)(66946007)(86362001)(83380400001)(9686003)(4743002)(76116006)(186003)(558084003)(55016002)(8936002)(6506007)(26005)(33656002)(316002)(5660300002)(478600001)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: cu2ISxz9MrYO67y31lDfm1xEClmfE2ab1hwGSlVVqTsOhbvGny22YKpcCi2S5SD6l8BngE3pPoi+lsD+1x1LGgtzwkH5vDDvyaTUwNR/P4wNdyQmalSXQ6kxqwtDSQV0qibiQQxflOOD41lvE3LeBhDzOJTVZcANh9pgQ8tzrFeuekrdw/4b0+cCztEJmuRx2+Vk9rqbfN9Ojo1z9P54wCluumjVE3wo+whVAVXTxyJYVBXk8TXUOzjMUDAWeec8t8Lb872xsBSRIqPOT0/MGFSRx2Npqy4UmqgM0lnT0TNjYLIcHhBSl7Itm6HF4dyORHYQapSa3+7JiM9NZnM62e5z2vd2ZX6yAR06GrRBrTMAZJr4pUXPZXToxZT+BlEZmdwGEZO8Rnlc8G2z8BDZGI1N925rXr33ZaxRJhx6m4SE/gsg5jc28+opWLmcjQVdpaIoIdMgSmeTRV/T7sGKbmNitEYr585GIK7dfX7rnNOpb8BWcs+MYskH8L2S3Dw/IuDkfqUoVHNa7BVMqLHRUZrNJQQ8rmDVi4FDpf4sMlIeKyuWPuQX4HGU+dbsf0AQAFUB3u2U3z2cniYflZHwt+8R3jsoh8l2Ri7U+HcCMEtBqclFNPjVIkx6xK0I3LV0SX3a/EGeqJlDvGCYNKEBnw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00889ffb-79a9-4ae8-90d7-08d85910aa68
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2020 00:45:38.5234
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rNXreaCURNWkhznlGgYT5HWUNn8yV17pgx+W3lJzZ5tz9w+/zbnLbF0bSIj04UVaRgV5p0LlrrEPpxIOyh4qVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1499
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Liu, Xuhui (Jackson) would like to recall the message, "But : git-p4 unshel=
ve ".=
