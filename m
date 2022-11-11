Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A0C4C433FE
	for <git@archiver.kernel.org>; Fri, 11 Nov 2022 19:31:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233965AbiKKTbG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Nov 2022 14:31:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233972AbiKKTbD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Nov 2022 14:31:03 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2089.outbound.protection.outlook.com [40.107.223.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CDEB73402
        for <git@vger.kernel.org>; Fri, 11 Nov 2022 11:31:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GsIjHSkAIWXiLzgkdcHdeNTWjvzz3IP6cMKecI3Ggfej3q8Z5LCrn0JIvS1OrIFexY4Obo/oiRgQkSlddminC4x4U0Hbw+q/eBiZRQvOqRiOc9QlNxv9RidaKmHz67JRWJTr50h8AKH6JyW1Uz++nVYW7UmQuw62t+LDPOJI/ACfAfGQv5JJm8fh6L9Kf5gX/A362VGmAXKkdhWG0fQWlOmcWxjwG1T8DO5H2iyhD0N4Bg44IbUwCIySngmYrGQwQd0ej80PwJzRbdiDQxHFLwo45Jb6NJsRMjGQnJ0ARR+R8+dU+4r+owO2M/hLWU9MQ+Byi6Ra3uWi34AibLD6ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=277fXvbJeQOLBRc+D61r5ggryIah40+28hxx2hqR2bs=;
 b=Gdcq3YNiC8tfAs5V3ttxguBux11G7NWbO2EuTLWC5yqK6D3R6syblPel+LduBMJsdh/aLUUqpFvOaEoyklg5AcijUHtZmuihEKgSrcQ66VEaJEEGulphguXaU6CgGH8rf3u/cTa9XLirlssrK164okLOcQArFVj6iWI7S08dSXFHX4r3Y1v4jlnptV4XTmYF6kc7EKNA9Bs216vLObE5TMhgK7yHGiMlK1+H34nBk8VjxtbYlYzW5ig2kry5RofNB2wymu47GQbep0NclD3Mz4q5kAWZSLcHVTXVOQ/TLUHoV+MkfxH6tArEsDHMEwbtHGIof6CmgcHfaCViTZeBCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=277fXvbJeQOLBRc+D61r5ggryIah40+28hxx2hqR2bs=;
 b=ZqB6FYfvMXS+R/FecMFoBa59Ltw9ES5N0hi77PU9FuiCVNQCca+zAcm3ArAKLH+CbPurp7UBvrWuGTDgHQ4OHfL0s9oHOKBDcJiycXUS/x7nkwHtsD9aG4t5/ZCQVo9vNzoDa00h7+aUE/YmDS0Lz2uyX2/DoAHpmBcezKnHNto=
Received: from DM6PR12MB4356.namprd12.prod.outlook.com (2603:10b6:5:2aa::8) by
 BY5PR12MB4291.namprd12.prod.outlook.com (2603:10b6:a03:20c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Fri, 11 Nov
 2022 19:31:00 +0000
Received: from DM6PR12MB4356.namprd12.prod.outlook.com
 ([fe80::70fe:fd7e:da10:fd66]) by DM6PR12MB4356.namprd12.prod.outlook.com
 ([fe80::70fe:fd7e:da10:fd66%6]) with mapi id 15.20.5813.013; Fri, 11 Nov 2022
 19:31:00 +0000
From:   "Strawbridge, Michael" <Michael.Strawbridge@amd.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "Strawbridge, Michael" <Michael.Strawbridge@amd.com>,
        "Tuikov, Luben" <Luben.Tuikov@amd.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v2 2/2] Update sendemail-validate hook docs to add header file
 parameter
Thread-Topic: [PATCH v2 2/2] Update sendemail-validate hook docs to add header
 file parameter
Thread-Index: AQHY9gQh8iPOs+HV7UiZkiz7py3dIA==
Date:   Fri, 11 Nov 2022 19:31:00 +0000
Message-ID: <20221111193042.641898-3-michael.strawbridge@amd.com>
References: <20221111193042.641898-1-michael.strawbridge@amd.com>
In-Reply-To: <20221111193042.641898-1-michael.strawbridge@amd.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4356:EE_|BY5PR12MB4291:EE_
x-ms-office365-filtering-correlation-id: 11343d2d-fdac-4817-a04b-08dac41b4393
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UCXZvf3CRFTZzR2E4SxXVn4lFoe0cppxYJAUndXh/eA8ZCwCLxydBJsfT5+JEZbXlP51VY+FJm/q4jvFt6HXFFO2S0jLor8iJk53fEJ6/8tUHuQDuE13PxJ+pqFo02Rr5TgcV4mepUs1EiBHfsv8fCReRIVDAEtCSCjyYVPw++i+q/CczUaFE3EyNmw2f/m0vFbDGaE8Kt+UbJr4bHu+zrpgSuTL5u8CvEzH4vc1AYGM/JoOvvYgwekUAfeyGxhLYC8a2xuKLcQToaVC0xrW+FuxgiQ5JWakTxtLLgYZxgjfvuAsyDLWuP+rYKStkH24jslTroGxCYeNsJaoEMp4oO32rTQANvRyMss2Zj4XGfOol7YzyWXdPA+is2c9Xr7ZmdwTgLCdpyCh7dIUFRxvF1ayvvqt/GgIWdzK/FJsxkQUO3P4ad/qj+XJdqU68GajiflpobjLdNwDuMAZKbUuS2YJ0xSLJDmDeaBMFadDOYxfpzZ3kL7ESaGPCEYeM1cvPhbHlSN6ereLOr3JhsBFke9Jx5Kessw8cPoe9yJZoHT7kCqyj7LPjtuBOqtWvy67oFlbd+tuEK7nyG1FQzEJamkgQE4rf4QTdJifiv7XGkjT7pNtQhKM6T2K0HQ5kqKiAAfhVOTlmr+qykfF7N79fI9deCKnS7/lcSfGnrwiy0GcxgLn5NmOtuIM2RmLxcgX65Krgp430Sj0OoqHhFyNb/AJSajXad++1gg05y1birvwbGBsFa8c0NtS6Z3v8kGp6TnMQTvvD4462e9S+WYtSg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(346002)(376002)(366004)(396003)(451199015)(36756003)(83380400001)(122000001)(6486002)(38070700005)(6512007)(478600001)(86362001)(1076003)(91956017)(15650500001)(6506007)(71200400001)(38100700002)(76116006)(41300700001)(66946007)(2906002)(26005)(6916009)(66446008)(66556008)(66476007)(8676002)(8936002)(4326008)(2616005)(316002)(186003)(5660300002)(64756008)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Hk6lwSgkZwjPrRW4P2g2k6jYe7H8gScOIJapgBkIbEOlJidJzjfr4hihzR?=
 =?iso-8859-1?Q?v1dFhTDo9pmBlv8xAztLx7sIq/zm+aVIFW7moiOZRumt6fX+RMOyJP5u65?=
 =?iso-8859-1?Q?4gUf+UyKROiBeDM7fJtKsuTTQ2g6UWXLzYOn1vP5YzXX3ezi0bACsnbMkZ?=
 =?iso-8859-1?Q?tVr4+ieqDBIT2BXcoMsbNZA7DWM1QTJn9kUERDM7ycDVRZ+vm1xslRD3Ml?=
 =?iso-8859-1?Q?h6k/0obH13QpB+dXqSLYVlXpoXbpd+YAgJ0cgpS4RrNsZ3zEOF4rwQUx9+?=
 =?iso-8859-1?Q?Du0kbXucSl4CnpcY+bZGkMKnmcqPQMzWq+cwLHqNPIFndN9tJCCy0vYfD1?=
 =?iso-8859-1?Q?3nPFKN+UK6+St9U+lbdG0Qah041YsZ7N5bEo2itj7iMiqQFMUy4fqfLiHA?=
 =?iso-8859-1?Q?WKKk6hm5zExUgzctvpIGJjyGdfwPZrUafQ6OBO3GHgbY+LjOpqLZnwTC6r?=
 =?iso-8859-1?Q?IWlXEkbJx4vKg9mHQzPSxRIyibQjNVsnQ65iaKQS3ekY7BAqck1XRgfQQx?=
 =?iso-8859-1?Q?sUnT8NJkTieVLsLsgRh5jxGz0XcG4JTw53SqzeCtbcPVwf8Km1nvCbyftu?=
 =?iso-8859-1?Q?7BYuBDvJJUANln5zxNvWlnE2Z2uboxvcGt3uqTwuv+WZf3wSfRrEpK9TtL?=
 =?iso-8859-1?Q?nFzXw5L4SObn+3WqPTkrMVBHthg8hfswOBbJ/1IYZQJqLafyTPbxGRWnQH?=
 =?iso-8859-1?Q?0h2t4a6jBhJ2Lv2lCLgOT0tX8SlOTVmPDTok+6ysuFz3aHfvY0lMk9J4xK?=
 =?iso-8859-1?Q?0njVUD/NDd5BfMPCjoDJxHedpC5bbB/MELAVdY4rTJf3D7XRQl891Qr0sY?=
 =?iso-8859-1?Q?QewdSU1alG2veZNPWODDIjHr7YeKrBrLd3vHozC7sSBG/k8pV1nUxlv0Cm?=
 =?iso-8859-1?Q?Ek1XsN38E30oA9kuzHzvQxGf1ahgf26P/pFOCetZFX6BlNhDgr14eV5OhO?=
 =?iso-8859-1?Q?9y3mbQBDcqTNVKi4i/NItDVd+qZpJYyADRVTWqNnVcYpUyatn1NkScGyRW?=
 =?iso-8859-1?Q?+VJ6Iqv1+4X09sL0C/Kln18B60y6uLAP8ivHpMDRPYPnTB90ME2heWGXUA?=
 =?iso-8859-1?Q?eREPUwY/SeLHTEoVuTDGgET8DJlodhAVE5gJc359uHXBmFhBeijCLpBOYy?=
 =?iso-8859-1?Q?Nr5K5puZ/oO9Q/mzEtkNAku+oy9yxuhMfxtnmqMQlfOkvsJjAnvgL5PGDY?=
 =?iso-8859-1?Q?aLysS5VKh9XJvQQF3i6vB1gv/fAIsxFVJDJPOYIxIRqwbBGPhOPPWqvUfj?=
 =?iso-8859-1?Q?edq8R4Tti0kHSjoDzDiymRhmSW/gBY+GD/q8IAmogqgZimg0qqO4e5xzpJ?=
 =?iso-8859-1?Q?UGKmuGBbMOS2hXUG0VmKo4+aXn71+Qk7RlLH5+zdu0cVIuNA0LOa9ZNKkI?=
 =?iso-8859-1?Q?/pDL3jEU7jfW1sc9Vct+z/6kpKe3MrPMUc7rRshX8Xdzq3MOySf3d/heN6?=
 =?iso-8859-1?Q?7mYOwUa2k0+hiz7QD/0hLkmiJSr0jjQKttu/tPuaKbu2IHsOw9hcbMUlSl?=
 =?iso-8859-1?Q?SDYCh7bQWceat7gTviGn1In1lcFjkcpi4mtBeYV/sMpRUl9gC2+1gtdlcT?=
 =?iso-8859-1?Q?GMVJlOWhhmgp79WAx586X3SmFlZvv8FwOX72LIra6lmSNgob49ul4bUlGs?=
 =?iso-8859-1?Q?hNbpAA1h4o3Gg1bRUbJW2jWncoykyQkQ0/?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11343d2d-fdac-4817-a04b-08dac41b4393
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2022 19:31:00.2943
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r+kKL8Hg1zq7ATLEeXrVlS3z108Su1fhgDLyh4IJnZveTGdqZvF1RH3paccDQck+KPiUAZuhORT/EbCAFYAEHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4291
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add documentation for the new SMTP header file parameter used by the
sendemail-validate git-send-email hook.

sendemail-validate accepts the patch file as the first parameter (same as
before) and now also adds the SMTP header information as the second paramet=
er.

Cc: Luben Tuikov <luben.tuikov@amd.com>
Cc: brian m. carlson <sandals@crustytoothpaste.net>
Signed-off-by: Michael Strawbridge <michael.strawbridge@amd.com>
---
 Documentation/githooks.txt | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index a16e62bc8c..346e536cbe 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -583,10 +583,10 @@ processed by rebase.
 sendemail-validate
 ~~~~~~~~~~~~~~~~~~
=20
-This hook is invoked by linkgit:git-send-email[1].  It takes a single para=
meter,
-the name of the file that holds the e-mail to be sent.  Exiting with a
-non-zero status causes `git send-email` to abort before sending any
-e-mails.
+This hook is invoked by linkgit:git-send-email[1].  It takes two parameter=
s,
+the name of a file that holds the patch and the name of a file that holds =
the
+SMTP headers.  Exiting with a non-zero status causes `git send-email` to a=
bort
+before sending any e-mails.
=20
 fsmonitor-watchman
 ~~~~~~~~~~~~~~~~~~
--=20
2.34.1
