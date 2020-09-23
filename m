Return-Path: <SRS0=8LOk=DA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC96AC2D0A8
	for <git@archiver.kernel.org>; Wed, 23 Sep 2020 12:34:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7229F221E7
	for <git@archiver.kernel.org>; Wed, 23 Sep 2020 12:34:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=NETORGFT1029135.onmicrosoft.com header.i=@NETORGFT1029135.onmicrosoft.com header.b="HKE32rq+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbgIWMe1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Sep 2020 08:34:27 -0400
Received: from mail-bn8nam08on2116.outbound.protection.outlook.com ([40.107.100.116]:1294
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726504AbgIWMe1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Sep 2020 08:34:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ddg48L09hFoSdrzvHaaxZUsphAe43uaNccVrcvRpd9Hp1IBlX5x1LuwW5TJX7uFFHMYMwTEsmneLhkXk6mR1nwuLwkPF7chJq41xEX34D9Pps2zNs2K4D5l78ENOBanievlIfWczREFLc7K+79t4RLLv/sQSVzUCnFEhxgXczTUAiJpBkqgfIYBDkOlDpHRBPcvWiTaO37QficggG5R5UwyE3QtMCo6HmBACUYND5HjxwnLCw8Gst0Uu9JNRLYjJPX3RphygoM1TXjzyhjpLcguGYC7qs44iqY9jWzR8VNnMXYqbBkfj4j2aGbGLmXfXxP9mW5IuqNiP/IYIf69ZBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5S5pKhDW+acnz0En7ciAGonZOU3DC1+3DCeGeetAReM=;
 b=koYLO3t7/XrGeECMDpYApi2GdxSyWa3D8dfYgouw0PIL7v5/VOO3nrRBYqpKKW/qHQToIfdX+vVpRYwAFslnsb3kRzlHXwawaq3oK+7wYorP1Q8ainp0VZcKDYC69fwm8h6BVs2oA+Ddn4IcwLJVk4nu49s/WCPeE9SXuogipQeres6NX3m9pkjNcn477iiMrsITiMG0W0JnzptGL/Jz00zAEthuVF9xwwZPXZj+ejwmI34tBRWKt86h1M0X8vAjG6O7StsFRdApGUkLj8AMoZ1A4yFe/qcXdhq069BeyGz0nc1Tsi4ZN0bQ9ZGdFiJGO2UxkpVwEa17L1dbDDdmQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=thesharp.ninja; dmarc=pass action=none
 header.from=thesharp.ninja; dkim=pass header.d=thesharp.ninja; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORGFT1029135.onmicrosoft.com;
 s=selector2-NETORGFT1029135-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5S5pKhDW+acnz0En7ciAGonZOU3DC1+3DCeGeetAReM=;
 b=HKE32rq+4hmEulpp3dbMGqO1u0Yluw8qpuKYZ1Snc1H6HjKMiYaQRXf1QxLQqxRbwBdnTruwi6rsODZVzVc9sEPTvCAm9Fo485lrbFWHyPe11fIAjnGN43n7UnXlzfAdsZVldy8lxD8iSjQLiE5f/JhRMk9BdoHGnmrj9NP4tuM=
Received: from DM6PR12MB3244.namprd12.prod.outlook.com (2603:10b6:5:18c::19)
 by DM6PR12MB4156.namprd12.prod.outlook.com (2603:10b6:5:218::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.15; Wed, 23 Sep
 2020 12:34:24 +0000
Received: from DM6PR12MB3244.namprd12.prod.outlook.com
 ([fe80::cc82:f580:a586:42c3]) by DM6PR12MB3244.namprd12.prod.outlook.com
 ([fe80::cc82:f580:a586:42c3%7]) with mapi id 15.20.3391.027; Wed, 23 Sep 2020
 12:34:24 +0000
From:   The Sharp Ninja <ninja@thesharp.ninja>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Feature suggestion: Features Sets and Feature Dependencies Sets
Thread-Topic: Feature suggestion: Features Sets and Feature Dependencies Sets
Thread-Index: AdaRozdzS/fRjtjTRx2NJ50A+0xudQ==
Date:   Wed, 23 Sep 2020 12:34:24 +0000
Message-ID: <DM6PR12MB32446D3BE708BF5158CA0444D5380@DM6PR12MB3244.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=thesharp.ninja;
x-originating-ip: [104.192.238.111]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dde18687-3805-4fb7-c4b5-08d85fbd0105
x-ms-traffictypediagnostic: DM6PR12MB4156:
x-microsoft-antispam-prvs: <DM6PR12MB4156463807B63EF0501E3197D5380@DM6PR12MB4156.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 993aNnLyy8m2GWhe52/6xmkiskBsN1EKccDBGPVZo9t8cN+qDlET9r892bsKZLXqldJuTO9mAzq+g8CWadqE+KRumBDhK00cklMExZFfdFhSxKf075CxLqUx1mzNBkyauDHlw7lVaVK3n2kV65Ro/HPolWI+9GdU98mL+dmaNGb031EcAP6oNuiVr2a3K5x3mBjQcRbyKP9uM6SeVMq7XHwXnczt8fmQ2Bmx1cHAzILX3nzkQIXUYCfP3J2jXwdepiEIn3kggBmrFGacwbffK5qT+KXcLpjGxAqJkLd1ngiLbgTJOWACxOW7EXJlf3J+S0fabte5SRod0yXJ931p5yjFpkxuIgfZun4V+sRxbEy5m84/KBTytR1cgSswPde75P+kcshyG99IgN7NVux7n6RyzN+IvdXyIpuZBN9oPqA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3244.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(136003)(346002)(376002)(39830400003)(52536014)(6506007)(55016002)(66476007)(2906002)(71200400001)(66946007)(7696005)(5660300002)(186003)(83380400001)(66446008)(478600001)(76116006)(316002)(64756008)(9686003)(33656002)(86362001)(66556008)(26005)(8936002)(6916009)(8676002)(46492007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: pZ/recJID4UDQZenQB8MEMzxhc0osabv1dRJuqeEoIJBxjs+cIHpGAX8YdOTmJjKpifQN2DMzo70BzrO4Q23DUTfkudPmM7k5qI/oZ8Zek4JNN33Gv2XQQII+zs2SV6Dsp4fOzp/pYwXj7o67jNDThtiKsM5GBaCP5QRFoVDi0CEhpoAIyXdEz4l/Ltt5WqFXJM4QUljm9udxBi82b5TTKsm2MRIrT0+1rxzKSAmb+g8leMmciplCMFPJndOPRDPHqLYrEwxCuzC342Agne++9CajTY4KPx9I1M7UeWzRDSZDy+X37tnMCzWfZKJS+hx/J6mFHZtb3fpdCoXCo9t5/gueDap3VTcsTLLqxtUO3ipr/n1RFtx7kqgib02aToyLBl+6lxdkBVrsBvD3Dh7o8y4uEw6ck8a6UCQ7MFayL5wZiTncZ7Oo1fErqodZS0R6TDA03RbNzAQ+MYWohIKdoxh3JRVspXQ9JuGazH3SXln2xMj68rtYOkVBYbFa1ZGboqsSG66AwUMJIahQXAcAECuJwtF05IBIBWxdC5796JbNTn6eNGkOE20vBFlUULiqTpjYzMmG6Z2YhaQ5qkq7hn1iYFzst+mfLeV1/dkXAHlWuLOkqAL+9kOWZrsohM+aei1lw+Z8LLD3aFr9AXWVA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: thesharp.ninja
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3244.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dde18687-3805-4fb7-c4b5-08d85fbd0105
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2020 12:34:24.2448
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1d041a69-96e1-4f6e-b2b1-15acade5f35d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YvKuVwYVMkd+o0ZyyuPa/QYdUo6OwzZs6ml/e0fRZ/3refHrt8FiwCWk2yx5sfwSF4FOB13guan3WhoAvcm/Xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4156
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

# Proposal for Feature Sets and Feature Dependency Sets

I believe a very useful feature for Git would be the addition of Feature Se=
ts and Feature Dependency Sets. =20

## Feature and Feature Set

A Feature is a defined domain of functionality, such as a specific service =
of an API.  Features can be managed as a subset of the repository, allowing=
 for segmenting a repository into working groups that have their own set of=
 permissions for the pool of users with access to the repository.  As an ex=
ample, User A may not have permissions to merge within the repository, but =
within Feature A he is allowed to do so.  This would streamline integrating=
 new users into large repositories and teams.

A collection of related artifacts that together form the basis of a Feature=
 is a Feature Set.  All artifacts within the feature set are managed equall=
y by a merging of permissions for the Feature and the Repository with most =
permissive permission being chosen. =20

## Changes to Workflow

Once a user has cloned a repository, he may chose to scope his work to the =
Feature Set.  All Fetch/Pull/Push operations are limited to the Feature Set=
.

Checking out a Feature Set automatically creates a new branch for tracking =
the changes by the user.

## Feature Dependency Sets

Artifacts that are not part of a Feature, but directly affect the Feature c=
an be added to a Feature Dependencies Set.  When scoping actions to the Fea=
ture, artifacts related to the Feature by way of inclusion in a Feature Dep=
endency Set are also included in the activities.  If a commit includes chan=
ges to items in the Feature Dependency Set then creating a pull request wil=
l generate two PRs, the first a normal PR with normal permissions that incl=
udes only the changes in the Features Dependency Set, to be adjudicated via=
 the normal workflow, and the second PR scoped to both the changes in the F=
eature Set and Feature Dependency Set in the Feature's user-level branch.

## Finalizing a Feature Set=20

Ultimately the Feature Set work will become a PR to master/main and be adju=
dicated via the normal workflow.

