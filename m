Return-Path: <SRS0=3/hf=DT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 564AFC433E7
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 14:24:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EB7920838
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 14:24:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rtx.com header.i=@rtx.com header.b="mjTZELVg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389600AbgJLOY1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Oct 2020 10:24:27 -0400
Received: from mx0a-00105401.pphosted.com ([67.231.144.184]:39994 "EHLO
        mx0a-00105401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389328AbgJLOY1 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 12 Oct 2020 10:24:27 -0400
X-Greylist: delayed 2321 seconds by postgrey-1.27 at vger.kernel.org; Mon, 12 Oct 2020 10:24:27 EDT
Received: from pps.filterd (m0078137.ppops.net [127.0.0.1])
        by mx0a-00105401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09CDj3PA002362;
        Mon, 12 Oct 2020 09:45:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rtx.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=POD2020; bh=dZGb+IFpE6TyFTXfL50oKgLv7pVHdqVq/h/H+QYbwXs=;
 b=mjTZELVgZge17D6woEYTw40JPysXSuqzk6bWrb0LF5pWGtTlhwPRlzIUk/Eehp6G+ZHO
 HZuGitNkFg3fCKiRMjLMsvMXIb1er+y9Eh5B0V/Ddfrk2AadSloi++PCYYNyYpH/JV8Z
 uTUvPwld2k/JW2dlK8vKMPdneQXsN9NzQ2IePffaUDMxtc0PXwv4mNV/IUeT6DbP2D4U
 poM9IxQOBbTEE8cAMoWhb8GbE9ySkhw36mlddhZit+L5bIreLI0YQjHMCgBY+BYP9dI0
 Tt0HIHfOfZYV919qbSNbR8Naw8E6Etxt1EFEwRWbn7JO7wqhACCbIu2XcY0+cSPdIa41 Xg== 
Received: from xmnpv36.utc.com ([167.17.255.16])
        by mx0a-00105401.pphosted.com with ESMTP id 343tdpxfxj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 12 Oct 2020 09:45:43 -0400
Received: from uusnwa4t.utc.com (uusnwa4t.utc.com [159.82.101.253])
        by xmnpv36.utc.com (8.16.0.27/8.16.0.27) with ESMTPS id 09CDjfI9092476
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Oct 2020 09:45:41 -0400
Received: from UUSALE0W.utcmail.com (UUSALE0W.utcmail.com [10.220.3.13])
        by uusnwa4t.utc.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id 09CDjelK004329
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=OK);
        Mon, 12 Oct 2020 09:45:40 -0400
Received: from UUSALE0Z.utcmail.com (10.220.3.16) by UUSALE0W.utcmail.com
 (10.220.3.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 12 Oct
 2020 09:45:40 -0400
Received: from UUSALE0Z.utcmail.com ([10.220.5.16]) by UUSALE0Z.utcmail.com
 ([10.220.5.16]) with mapi id 15.00.1497.006; Mon, 12 Oct 2020 09:45:40 -0400
From:   "Mora de Sambricio, Javier Export License Required - US RTX-Ireland" 
        <javier.moradesambricio@rtx.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "cousteaulecommandant@gmail.com" <cousteaulecommandant@gmail.com>
Subject: BUG: Removing a submodule with --cached doesn't stage changes to the
 .gitmodules file
Thread-Topic: BUG: Removing a submodule with --cached doesn't stage changes to
 the .gitmodules file
Thread-Index: Adagm1h2XvOHpW7LTQ+hQrlELbYucw==
Date:   Mon, 12 Oct 2020 13:45:40 +0000
Message-ID: <ea91c2ea29064079914f6a522db5115a@UUSALE0Z.utcmail.com>
Accept-Language: en-IE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.220.35.245]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Spam-Details: rule=outbound_default_notspam policy=outbound_default score=0 mlxscore=0
 clxscore=1011 lowpriorityscore=0 malwarescore=0 adultscore=0
 mlxlogscore=999 phishscore=0 impostorscore=0 bulkscore=0 spamscore=0
 suspectscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2010120111
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Removing a submodule with --cached doesn't stage changes to the .gitmodules=
 file

Command:
`git rm [--cached] some_submodule`

Behavior without `--cached`:
- `some_submodule/` is deleted.
- The entry for `some_submodule` is deleted from `.gitmodules`.
- Both changes are staged.

Expected behavior with `--cached`:
- Neither `some_submodule` nor `.gitmodules` are actually modified in the w=
ork tree.
- `some_submodule` is staged for deletion.
- `.gitmodules` is staged for modification (removal of the entry for `some_=
submodule`).

Actual behavior with `--cached`:
- Neither `some_submodule` nor `.gitmodules` are actually modified in the w=
ork tree.
- `some_submodule` is staged for deletion.
- **`.gitmodules` is not staged for modification.**

Git version:
Seen on git 2.25 (Linux) and 2.16 (Windows)

Workaround:
- I had to `mv` the directory outside of the project, `git rm -f` it (witho=
ut `--cached`), and then `mv` it back into the project in order to have `.g=
itmodules` changed without actually deleting the `some_submodule/` subdirec=
tory.
- Alternatively, manually edit `.gitmodules` and remove the submodule (this=
 isn't a viable option for automated scripts, and can be a bit inconvenient=
 when the `.gitmodules` file is too big).



Example code:

```
mkdir some_submodule
cd some_submodule
git init
echo hello > hello.txt
git add hello.txt
git commit -m 'First commit of submodule'
cd ..
mkdir top_repo
cd top_repo
git init
echo world > world.txt
git add world.txt
git commit -m 'First commit of top repo'
git submodule add ../some_submodule
git status  # both some_submodule and .gitmodules staged
git commit -m 'Added submodule'
git rm --cached some_submodule
git status  # only some_submodule staged
```



Best regards,
        Javier Mora
