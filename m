Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 250EFEB64D9
	for <git@archiver.kernel.org>; Thu, 15 Jun 2023 17:47:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233511AbjFORrL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Jun 2023 13:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231161AbjFORrE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jun 2023 13:47:04 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2084.outbound.protection.outlook.com [40.107.96.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A08B2137
        for <git@vger.kernel.org>; Thu, 15 Jun 2023 10:47:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hPCCNB7h1itXRt2PluRrpXWTXy/WCy9i9N7mV4xNRK8aJDqflFYLyMZ6aFL9DMT/Hzhdiq3RNkR+g0QnWGs/gEXv0hAh+9a0d1LPfvS/GSErK9xGVXGGx4p5mAhyK0m7WcfGUqoNBfGA0gmYFeffsNzK/HOK0iGOdkoVL5NaUGTU7Wly7y1X8dzyykgSwmu9miCJA0EPq95hDkmNYxQdbxS2kfiTmn3VBcgjqicAYMgjBXjp3/qa4PotqT6pBXFsodfhEYNhxnkEfsUK6kiV3LvTHxDfT3QG+qBpTZy5T1k/btqQAimKS7iNYY2kATUKWDmL7MY84cr8Xe+CGX58cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hbMea7E9I+6yqdBG4u1JZKJ1dGUMqenAhVKza42t79g=;
 b=Cso6HVlgn83+lvdeom8UUsXgeAfmYZP1JklXf9LysOLkbPR2g1ad9ny6CQwNxo/3jLgdE8shTbBVgFlGiSY2dz1xjOkDpz8XiSkgkF7/1OSiwvioQKvrscwMfDoRBf+Xn2Yaym3KMA2LEIrRxH+s2eedhCDLtvtrhN+XH8gkZvni0c9Ca4fSm/PvGC97MJnqc3nQQLU9UvplMxYzM+3kCwR4YD5Zhw2pE1lz2iEgLIPajJF19CuPlH/g5ZWqmC/XfrYE90SP+l9UiZwmtP/PLcyJchwEUhNRGPuyc4kpwzgNji/HeHhWfFZkHbSiSfSFCOCQRrOQNmc/ax6eH6AFCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hbMea7E9I+6yqdBG4u1JZKJ1dGUMqenAhVKza42t79g=;
 b=vsNuYq/eKsX6tNZeFo/9RIAJxGooGXYvX9hHi15QfL8YQ9I7OKh+k6oEE9XEteZv27LaGHThnhcOlNSTXfBBVAI67/2l82H8oBUeQa6cxZiz8LpvAjW1W3nmh+W94Wx0QRsRnuNlfmjU1GowlISTZ/nrUleKPxqCMPekquFKAeTdT4CFgAVb2tiT6mvVPteANkmjIXC89eRhyMYRc8iWlgxHCPdDGnDMm4dHAazM3ON8zQqYdaqDZA7ogxCueHEtFKBhcOZD7l9g/BRT0zJWwViOY7SeHiEhF9CpvL8NBVE3Qi644mGFvD0UVsf7J2fjGIlUWEVF0lQRHO5pyUPWvw==
Received: from PH7PR07MB9467.namprd07.prod.outlook.com (2603:10b6:510:1ee::12)
 by BN0PR07MB8895.namprd07.prod.outlook.com (2603:10b6:408:16d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Thu, 15 Jun
 2023 17:46:58 +0000
Received: from PH7PR07MB9467.namprd07.prod.outlook.com
 ([fe80::a5d1:273b:d763:6af1]) by PH7PR07MB9467.namprd07.prod.outlook.com
 ([fe80::a5d1:273b:d763:6af1%4]) with mapi id 15.20.6500.025; Thu, 15 Jun 2023
 17:46:58 +0000
From:   "eric.frederich@siemens.com" <eric.frederich@siemens.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Possible bug regarding trailers
Thread-Topic: Possible bug regarding trailers
Thread-Index: Admfq2AaKG0ibEbJSseXK7cc2YIRTg==
Date:   Thu, 15 Jun 2023 17:46:58 +0000
Message-ID: <PH7PR07MB9467452EBAFAB2C825295C0C8C5BA@PH7PR07MB9467.namprd07.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2023-06-15T17:46:56Z;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=32f04580-79f9-4f1d-bc61-936f901e2c35;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0
document_confidentiality: Restricted
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR07MB9467:EE_|BN0PR07MB8895:EE_
x-ms-office365-filtering-correlation-id: e9d7fd03-a7f9-47f8-6017-08db6dc88439
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HQC2VUPk/C/WKL31oQVtRCzP+57gNMn24ftEu0fXWYxgXHvvZuetUxG8d07YHIKJfecaf4zOW3Mvf2NhxMIL6ZFVSDGzuMNddqC/xUkSxOz1FPKdESwmAHVJPJu1bzfDJgClBKN4xDBWeNC6Ug7NxTXzgWWL0yMPe3dn1sEhyCNZzmqXykOZDAWXAzRLNCEcjhScqclpofmhSwiA5IYTpGeUHGK21dVrLuDu2K69K0ZiWiQU6lFavBLo5Ng1K9O3Mq1Cz5N+2vHKRJgcV5B1Yq/CKdAEViBc+fFxIh5s+oD4FHT8whTsWKWOs3UFGUKiKN6bUnfFAeIJiZHCKk7qN3LUl298VVQb6uHkdbTWodM4iqVwp98zgBu1TJ3vgaABPOuuB/S88N6mM4c4c/aMPjxAPkjEiAGD/vaDDpmE83ETZxTH/OMue7/S6teM/EzGbjt2zZxQFBQo59WBnC+W7wCGJSzDGTM7x1VGD4sOhyGXRPkew0O4WF71g9211thYqZd6vM7w2pYOhqQy4BME82NiG0dmJa51+i0nS0hmtqtjvGbJSNYtnyv5y+dpLmx47ysGqQRTDM19GRhvimT9BFOFcICS7O1pmsr6LEd8gcPIgtX6zFm1BoRXs4vK5Kqj
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR07MB9467.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(366004)(346002)(136003)(39860400002)(451199021)(83380400001)(2906002)(38070700005)(33656002)(86362001)(38100700002)(82960400001)(122000001)(3480700007)(55016003)(8676002)(8936002)(5660300002)(52536014)(316002)(76116006)(66446008)(478600001)(66556008)(41300700001)(66476007)(71200400001)(66946007)(6916009)(64756008)(7696005)(26005)(6506007)(9686003)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NThwDYI4Dg8IbbLxT6ZLiuelRUkd+6+tE5sDxOcV/lEa0AgKGD1y4BFANf37?=
 =?us-ascii?Q?Xa1J3YLTSl4/8pnGVibgkhX3Z8aKbUF8+uLXExgDoJDN8rSrl/gePPBvFEQz?=
 =?us-ascii?Q?Mln3bJze1/I87q6WwN3Ut4YhaR9hJztIZ1bCG4eaIwanK9JLrSgn1eQ2d7yR?=
 =?us-ascii?Q?4kDb8pzypqsuGaw/9j1FWv1OeuZE44WbMKLLyGUiRF5veaKtiWP68QYgIlNw?=
 =?us-ascii?Q?f1j1X+puHLXczQpshCWMHbUmzll4JP68+t4F5/aB2lbTYdKw6k73AQjyl1cy?=
 =?us-ascii?Q?i8dI5FiE89Z93vV8tMOey/g2vkTGSQxA8LNmZmsIvdEzqHXu8QYtbuaDx89C?=
 =?us-ascii?Q?x4wo171nxlOlsqPDAOP6Eg7YLL5fERmda05UHArIw1yTlRzkHry1T1hAoGSh?=
 =?us-ascii?Q?VhqHbNEn8GNOKne/CyDTgo8BajmVWun2PGdth2YQR94n4LdNvwbxjVOy3xd2?=
 =?us-ascii?Q?eWsE8NZHqOPaaxVtqP5mmAOlo7b/KQlA1m7jZ4ag0ca3HPn6g62bR2f8qKAU?=
 =?us-ascii?Q?/R2GxgPvX00mqnS8yzgwjTDI3dBtCaWXxdyX/MMWoo67lTFDOS1BoaOGfEZV?=
 =?us-ascii?Q?eW5ZvsuBj1ai0pHDc467+BjPvWX1r3hXYDeTllALIVfbNaWIyOejr0kAPxVc?=
 =?us-ascii?Q?PJBloc2A5Qi0P4qAjiUceG0IUsTvcVUsFx7qfyd5Q+tAxs/ZPf5M9Q+SLNGe?=
 =?us-ascii?Q?Khta+WSITBPH/QNq3R70qQxc9QbJbHsmY8HSFfH0ZxM01Z5voWX91Q23/hIr?=
 =?us-ascii?Q?jAxCY1iEK0lFWOGtLzfclfTmXW5jea3goiUKRlNe09yu+D+fZyeeU6Boh7ZJ?=
 =?us-ascii?Q?m1HXftr6Kzh+PNprzHMSAVJ87svZAv1R1Jqvp31QGzYYsCsJ8If/sTXV9oSO?=
 =?us-ascii?Q?7vxgYB0anFb7R0OvcKjB7nmrLpiEo6xr7UN4DrLQXEKOOdaJ8dT6CmXPs4Be?=
 =?us-ascii?Q?uRyi5dBYX/JQlxxfqWUc8kSt9TDrpv2fLR8aFiqzoREF4UXltvGS9/KMeHdu?=
 =?us-ascii?Q?kmrbCS3Ty44qU9hkWvkf5V0AsW1ACTVDmRiMkCOOhrxuEnlaGfuxW6THobJI?=
 =?us-ascii?Q?AiAM+RqSZvVhw2a3I3X9Dy2D7ZsuZvsV39uGmMPgcTexktnlb+0KBgrWpYm1?=
 =?us-ascii?Q?yzXI2qDhN4UswnVx1BNsu/CrXKV/zM/DM6kpzKXduxGnaJtxUdE58Yw7Av4/?=
 =?us-ascii?Q?joM/BvXngYdb5gFEx3KI/UEP2ogXBFB5YwqpKB80IHSY+bsif2HD84qHFXoF?=
 =?us-ascii?Q?0TfKgGHXzC5BFQ/qDSf/4QTUsPIuYIK6avtOiYUtJ8nR6SHbZa9uzk7yGmKb?=
 =?us-ascii?Q?rhwX2r4/s0wck3K9+3EaQIAV9VTp/SWU+NeDa9qJu+Qmi6a8GtGpeRQ9KsWR?=
 =?us-ascii?Q?nJR3KPNvClryorkSR0eTZKFJpM2fyKs4hQq6j0u093dYVhn2XOtkgH2fW9DJ?=
 =?us-ascii?Q?aecoLLGzwvcqIEdBdvrQBhjCYq3v1KshyI+LVFeiNfNzns6ZBS0iMhuQvaK4?=
 =?us-ascii?Q?Ebevzr6iZzRvOKoTbiNiG5f3E4XMIkVTBj45X00/lwZShM9disheFPqkPO6H?=
 =?us-ascii?Q?W/5QSnYdPE0A99tlWQJFna8KnKyYMvb3gw1K5YOR?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR07MB9467.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9d7fd03-a7f9-47f8-6017-08db6dc88439
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2023 17:46:58.1675
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 21WDiO4Eg/krp4v162oeHAN/MD8Xyux8rKjfJYSmFpISRkhCEilUDd2LQclEBYulMiS2FXY7taCC0xyw3K1Ou2JlCKI2pRuF43EB+5KVrtE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR07MB8895
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I am able to produce a commit with a trailer which does not show up in:
    `git log --format=3D"%(trailers:key=3Dold-scm-change-id,valueonly,separ=
ator=3D%x2c) %H %T" HEAD`
But does show up in:
    `git cat-file commit HEAD | git interpret-trailers --parse`

The following script reproduces the issue.  It deletes directory /tmp/foo (=
from previous runs if you want to change something and run it again) then c=
reates a new git directory in /tmp/foo and operates within there.
The comments at the bottom of the script were from run of the script.  You'=
ll see the "WE WILL SEE THIS TRAILER" but you will not see the "THIS TRAILE=
R GETS LOST" even though they both show up on an explicit call to `git inte=
rpret-trailers --parse`

I'm looking for a reliable way to store some meta-data from an old SCM syst=
em as we migrate to Git.
I'd prefer to utilize Git's native trailers and not have to resort to using=
 a (foreign to Git) sqlite database or something.

Thanks,
~Eric


#!/bin/bash

rm -rf /tmp/foo
mkdir /tmp/foo
cd /tmp/foo
git init
git config user.email a@b.com
git config user.name "example"
git config commit.gpgSign false

echo "CHANGE" >> README.md
git add .
git commit -m "A bad commit

--- let's mess stuff up ---

Have fun
" --trailer "old-scm-change-id:THIS TRAILER GETS LOST"

echo "CHANGE" >> README.md
git add .
git commit -m "A good commit

*** no problem here ***

Have fun
" --trailer "old-scm-change-id:WE WILL SEE THIS TRAILER"

echo "******************** git log ********************"
git log

echo "******************** git cat-file commit HEAD^ ********************"
git cat-file commit HEAD^

echo "******************** git cat-file commit HEAD ********************"
git cat-file commit HEAD

echo "*****"
echo "*****"
echo "*****"
echo "*****"
echo "*****"

echo -e "\n\n***** git cat-file commit HEAD^ | git interpret-trailers --par=
se *****"
git cat-file commit HEAD^ | git interpret-trailers --parse

echo -e "\n\n***** git cat-file commit HEAD | git interpret-trailers --pars=
e *****"
git cat-file commit HEAD | git interpret-trailers --parse

echo -e "\n\n******************** git log w/ trailers in format ***********=
*********"
git log --format=3D"%(trailers:key=3Dold-scm-change-id,valueonly,separator=
=3D%x2c) %H %T" HEAD

echo -e "\n\n******************** git version ********************"
git version


# OUTPUT:


# Initialized empty Git repository in /tmp/foo/.git/
# [main (root-commit) 62d1150] A bad commit
#  1 file changed, 1 insertion(+)
#  create mode 100644 README.md
# [main 0deff83] A good commit
#  1 file changed, 1 insertion(+)
# ******************** git log ********************
# commit 0deff83a2955ab5bb8aef24eca77e5399feabacc
# Author: example <a@b.com>
# Date:   Thu Jun 15 13:39:37 2023 -0400
#=20
#     A good commit
#    =20
#     *** no problem here ***
#    =20
#     Have fun
#    =20
#     old-scm-change-id: WE WILL SEE THIS TRAILER
#=20
# commit 62d11500db250440c190ebe60945789e13fb0bbf
# Author: example <a@b.com>
# Date:   Thu Jun 15 13:39:37 2023 -0400
#=20
#     A bad commit
#    =20
#     old-scm-change-id: THIS TRAILER GETS LOST
#    =20
#     --- let's mess stuff up ---
#    =20
#     Have fun
# ******************** git cat-file commit HEAD^ ********************
# tree 1dd017bdd070190005e5e162d87afebcd61e0fa8
# author example <a@b.com> 1686850777 -0400
# committer example <a@b.com> 1686850777 -0400
#=20
# A bad commit
#=20
# old-scm-change-id: THIS TRAILER GETS LOST
#=20
# --- let's mess stuff up ---
#=20
# Have fun
# ******************** git cat-file commit HEAD ********************
# tree cd83b4c038415891bff254e2954113df2f78aa62
# parent 62d11500db250440c190ebe60945789e13fb0bbf
# author example <a@b.com> 1686850777 -0400
# committer example <a@b.com> 1686850777 -0400
#=20
# A good commit
#=20
# *** no problem here ***
#=20
# Have fun
#=20
# old-scm-change-id: WE WILL SEE THIS TRAILER
# *****
# *****
# *****
# *****
# *****
#=20
#=20
# ***** git cat-file commit HEAD^ | git interpret-trailers --parse *****
# old-scm-change-id: THIS TRAILER GETS LOST
#=20
#=20
# ***** git cat-file commit HEAD | git interpret-trailers --parse *****
# old-scm-change-id: WE WILL SEE THIS TRAILER
#=20
#=20
# ******************** git log w/ trailers in format ********************
# WE WILL SEE THIS TRAILER 0deff83a2955ab5bb8aef24eca77e5399feabacc cd83b4c=
038415891bff254e2954113df2f78aa62
#  62d11500db250440c190ebe60945789e13fb0bbf 1dd017bdd070190005e5e162d87afeb=
cd61e0fa8
#=20
#=20
# ******************** git version ********************
# git version 2.41.0.187.g15d354cc3d
