Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC2FBC433DB
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 20:26:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87D6161606
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 20:26:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237015AbhCAU0c (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Mar 2021 15:26:32 -0500
Received: from mail-eopbgr700092.outbound.protection.outlook.com ([40.107.70.92]:7840
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237601AbhCAUYB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Mar 2021 15:24:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bB/1gnTFvgGQ274oEMXm/J46nw6uR+5+tMQ+BjuCgiNeb0oElCy/PTfzyD4i6xp70vDFiij2eQJ0B2HRXgLokXrF/GkTs/zVP/UCJgDHCLpdZ2XQAWeeEY24RBezYbN8JNfCg+zjKURVdWsnkQdwyL9mdmguTqRjLGQMYoVJ8afhdUXSa454CSD/MGX1wVr4L/5L2G3F6Mm5RpSOpHf6QjM6oo8thPyoc3OxHa8xY+m1iN+ojwXtpGGoCvK+mnsOpMPbmnhkLU5Ku2mtRk306dcBydUjdQPRrIMYhMVgJbZ7I0l2pWPLWu1mU3V6RUZNVk9Zm6HDp//RVFB9pPKTgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=brfZEofx+3cWiHj8OQMmaXz2gBQ5Pgp9bLGoZ2Tc3yw=;
 b=lcgyJrBpDhjhcOnPdk7gHPfjNUAVpVDnmf/hjIZCmlHdtM7tjMY3LLEHR72u7XyY88yi+Kor0YFRQdQqw2rtCtnBy/dk90FVQbQeVmGg7KMc+HwFg3W7dJH1391tq5ZG5tDAB6teTz6qt7CGSv6WCS5r4H2KahZweQz1/eGdoIfMbKt2kXfuYsjfkOpRtDeaRYmIKQBZXkMymUbMUapJHOv9fldphbLa061b4+9CEHv1CBSYWcGGQCLX+cnWux5A+R9MDVdu2ai/VX7GOAWvumPlykwdV0gnBha9lI15BwDFtxyzGdQsEfpSS/tNtTfxNgYFhQ5mjb1tEVk19dMJ4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=brfZEofx+3cWiHj8OQMmaXz2gBQ5Pgp9bLGoZ2Tc3yw=;
 b=aHEOjKq5N0sREGhEWbJfcOn9OcB8oXeRxAH+H1zVRNRWp8Ev7Uk/vwn1d0sk31b0iI6d2+/U1kjFb8hwXP6ekllp9f7iZW620d8U+dxQQAdKRHVRbppjaFQmJz6CBonvA+LFSRPeyF4V4/vFnwT/Tjzqg3XfHkk53DAPI0oC6z8=
Received: from BYAPR21MB1158.namprd21.prod.outlook.com (2603:10b6:a03:104::13)
 by BYAPR21MB1350.namprd21.prod.outlook.com (2603:10b6:a03:115::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.16; Mon, 1 Mar
 2021 20:23:13 +0000
Received: from BYAPR21MB1158.namprd21.prod.outlook.com
 ([fe80::f59c:5d45:5a3a:9708]) by BYAPR21MB1158.namprd21.prod.outlook.com
 ([fe80::f59c:5d45:5a3a:9708%9]) with mapi id 15.20.3912.004; Mon, 1 Mar 2021
 20:23:13 +0000
From:   Dan Moseley <Dan.Moseley@microsoft.com>
To:     "tboegi@web.de" <tboegi@web.de>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: [EXTERNAL] [PATCH v2 1/1] git mv foo FOO ; git mv foo bar gave an
 assert
Thread-Topic: [EXTERNAL] [PATCH v2 1/1] git mv foo FOO ; git mv foo bar gave
 an assert
Thread-Index: AQHXDrzw4DdpSdXNXESAEAE8Qzln3apvkxvQ
Date:   Mon, 1 Mar 2021 20:23:13 +0000
Message-ID: <BYAPR21MB1158CDD04067369BB367474CE09A9@BYAPR21MB1158.namprd21.prod.outlook.com>
References: <xmqq7doqwvzx.fsf@gitster.c.googlers.com>
 <20210301170425.12154-1-tboegi@web.de>
In-Reply-To: <20210301170425.12154-1-tboegi@web.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=f2738f70-d197-4dc3-9bf3-d3aa3c702f71;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-03-01T20:20:16Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: web.de; dkim=none (message not signed)
 header.d=none;web.de; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [216.9.31.226]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 42293939-1c4d-4ba0-ade2-08d8dcefd6ce
x-ms-traffictypediagnostic: BYAPR21MB1350:
x-ms-exchange-minimumurldomainage: github.com#4892
x-microsoft-antispam-prvs: <BYAPR21MB1350D5CD4F120A3DCDF7AD3BE09A9@BYAPR21MB1350.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FYxrcu0wD7vzwhiDnqNlSdRR6ZXWbewB75qZra1rhT/f+hel2Tq511K1BC1HgzIL7R38uhiVQ0JSQwVSHQm76Hh97xgb6WXK7YD6HqIo40wobLYm3arZAMaFkY7H5wjuYfjD5rBNXEEv+XpktvnkiU3xTUDtFLvQ5n4YdtrUUzdb49cXC4UoBSuYh5wCWAxHBbIrxuePS7DHvgk8TDLdwY2Hmt5u+vvs2yC5GKUJ2kV4aLsZF+623TPvuby/Pxo7FIyEwenEhSqvoyangF9FdJTXSQdtumcX8uvLinlt8q3iX/CMsx2gl0P+pxRAcZWb5WqMntndqwYRAkus60qySwHwXw8AEqApkPPJwjMaES0vUor97KD3FfkUKdfFuWAZ8ocmT2VegWJWlBS71r+/1X0D3vtnPzTFpPOmMrb63T444G3KzCZNyWytRfSxt3BTkZE2EgsjQb1WG9VKbMq7RQGQGs68o+g3DizFwB6tRPc5NmHLvOP3kMizHtDdyYVocPX8VMUMEk8XVmC0Y2H1hWMc95Nb/+g0SSoYkbEJM9XUpoiYokxW1ilWgL3APUMbzTCz4n3hF+FKVVgUGWhQfmA93ouV14O1bv1zEuqYrWs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1158.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(396003)(346002)(39860400002)(136003)(8936002)(6916009)(8990500004)(8676002)(55016002)(478600001)(71200400001)(82950400001)(66574015)(82960400001)(966005)(86362001)(5660300002)(83380400001)(316002)(26005)(33656002)(6506007)(64756008)(66476007)(66556008)(66446008)(4326008)(186003)(66946007)(10290500003)(9686003)(52536014)(2906002)(76116006)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?x50gcW59NA4pV9/Hk5jj1LAda79rLGDPKOFryN/yvEgPfmzFscWfRspXaB?=
 =?iso-8859-1?Q?l8dfzNKadC0W2hXdkx8Nbh78mspWsUx0nZRMXvIEaXtzJGFqnrhP1suAUH?=
 =?iso-8859-1?Q?glL3tjTJHBS+sdKOccE0l2GuB6k0h15nNYLKgH1GSTosiVUEGAe82OlIjO?=
 =?iso-8859-1?Q?gmqHt8PQHUmX3zJjZZ9jYE7XlYfHEfWmIHeuYzefEqXOse9AK8EzuObKOL?=
 =?iso-8859-1?Q?XVW+mG5s8w91vXvFsfSNcWI9Xfy+NcH6qeq8ZQ6NepTnPBrA/r4W3Cah2/?=
 =?iso-8859-1?Q?8lhiimfbIHGpkEG64g+zkWWlp1Bmpv8KqHsvgCcq7PgYYuPb/CfWce0/sh?=
 =?iso-8859-1?Q?g3ZzZXvP9Wt/weaEsDFtYNvowE4UYkg1jl3Rge/jneuTAoUwTn5xoJqU6l?=
 =?iso-8859-1?Q?f9srWeMOSoT3uT3eO9GarEd4oTrnoia/ZPXbwd9UYhAflb4JG+6Ydwn0vM?=
 =?iso-8859-1?Q?eUqiUTLKkTEoArC/Eu6P9V3OPyUlCTbh9pqby37uQ92KEFWGO3I0eQPkQk?=
 =?iso-8859-1?Q?WcO2aSpaitufEUjVcQMkW7R5SF5a3/mPvSkrncb66IPZ6jff7Arc7/sIz1?=
 =?iso-8859-1?Q?Ct9V45a6yFJjfrIXQlotNl7l1n7EqRehfy95exfDiA5SUPuO+f5x7nlO2+?=
 =?iso-8859-1?Q?ooy78KjLK/o6CIn4lo5O3t+B9GYmnO7gEV+4wVqgK4CR6zk1Q9MuOOHjm8?=
 =?iso-8859-1?Q?SE3FbEmvHanUOpF+2Cec/UTtbQYIFcpuAxXbQ7MvJ6t0eonXoQGQvAavM9?=
 =?iso-8859-1?Q?y1ggp1ksa9W6V/kk+EapkDSdcy/6cKLoJ0f6bdlUKapDEXop89hBdz0jVM?=
 =?iso-8859-1?Q?FPWbnoX381egt/766bC3x48V4IZOFxUb+VVTW2kOB5vihYYyc+AzGIXGzr?=
 =?iso-8859-1?Q?UvgwQt3Xd6HvWQaqwBA03jcEfMhv+8UJJ8o8Cfd+Syu43jJR4aLlyazOol?=
 =?iso-8859-1?Q?7ZM0/QXUWxs1kLMJ7WMet1uN4m3J/fvgx/oh+YgvDUOuehciuCEvYFFW6M?=
 =?iso-8859-1?Q?gFNP/D2AZVqs/PvZ1Y1cmrzRSrCz0Ee5j2HbiF3ckm18Ra1Y4+2V6OpA6r?=
 =?iso-8859-1?Q?J0JLNuH2vTtRSve4uDzJc0oMZd+7E4gip1wpnHGfsE1UeLwyxdUHgxbFlj?=
 =?iso-8859-1?Q?zpX8GwmHgrI9aDml7NSJMDf/KSRKD9hyZibG6/g/EItat2EQrRQFlRZgO3?=
 =?iso-8859-1?Q?EsAFZzWomQe7p0HYibBXgX7Yh6Y10VQq+itu0MLPqWKvNpZtzJ577ICV/0?=
 =?iso-8859-1?Q?d5hhtFG9glFTAvum7xCu4sws4MPrFr2O1/DzzNeNZNbVqpnw9tSleXpbdH?=
 =?iso-8859-1?Q?OoJkIb27feWUPEZffzmuQdKQgpOdpU48xkLVRnvWy44zQuA=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1158.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42293939-1c4d-4ba0-ade2-08d8dcefd6ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2021 20:23:13.1699
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vDUFTvNEYu03lTyHttr/KdHcn537lcAL2WeICc/G4hyVd0RvLd564KCzk9I6WQAAnjRXLwYc7zoyTlhR0rO6qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR21MB1350
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> From: Torsten B=F6gershausen <tboegi@web.de>
>=20
> The following sequence, on a case-insensitive file system,
> (strictly speeking with core.ignorecase=3Dtrue)
> leads to an assertion, and leaves .git/index.lock behind.
>=20
> git init
> echo foo >foo
> git add foo
> git mv foo FOO
> git mv foo bar
>=20
> This regression was introduced in Commit 9b906af657,
> "git-mv: improve error message for conflicted file"
>=20
> The bugfix is to change the "file exist case-insensitive in the index"
> into the correct "file exist (case-sensitive) in the index".
> This avoids the "assert".
>=20
> Reported-By: Dan Moseley <Dan.Moseley@microsoft.com>
>=20
> This fixes
> https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgithu=
b.com%2Fgit-for-windows%2Fgit%2Fissues%2F2920&amp;data=3D04%7C01%7CDan.Mose=
ley%40microsoft.com%7Cb659ba5925c543bcc3e708d8dcd41268%7C72f988bf86f141af91=
ab2d7cd011db47%7C1%7C0%7C637502150683596627%7CUnknown%7CTWFpbGZsb3d8eyJWIjo=
iMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdat=
a=3D%2BLjQf5NooTUgOKbsyn10XCFIAgMw9v%2BKlhx8kDD6%2BIg%3D&amp;reserved=3D0
>=20
> Signed-off-by: Torsten B=F6gershausen <tboegi@web.de>
> ---
>  builtin/mv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/builtin/mv.c b/builtin/mv.c
> index 7dac714af9..3fccdcb645 100644
> --- a/builtin/mv.c
> +++ b/builtin/mv.c
> @@ -221,7 +221,7 @@ int cmd_mv(int argc, const char **argv, const char *p=
refix)
>  				}
>  				argc +=3D last - first;
>  			}
> -		} else if (!(ce =3D cache_file_exists(src, length, ignore_case))) {
> +		} else if (!(ce =3D cache_file_exists(src, length, 0))) {
>  			bad =3D _("not under version control");
>  		} else if (ce_stage(ce)) {
>  			bad =3D _("conflicted");
> --
> 2.30.0.155.g66e871b664
>

Thank you Thorsten. This makes sense to me. Do you want to add a test?=20
I believe this is what I had in my original patch, that worked pretty well:

diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
index 63d5f41a12..5c7fee9bd8 100755
--- a/t/t7001-mv.sh
+++ b/t/t7001-mv.sh
@@ -152,6 +152,14 @@ test_expect_success \
     'move into "."' \
     'git mv path1/path2/ .'

+test_expect_success \
+    'fail to move file already in index under different cased name' \
+    'echo 1 > foo &&
+     git add foo &&
+     git commit -m add_file -- foo &&
+     git mv foo FOO &&
+     test_expect_code 128 git mv foo BAR'
+
 test_expect_success "Michael Cassar's test case" '
        rm -fr .git papers partA &&
        git init &&
--
2.25.1
