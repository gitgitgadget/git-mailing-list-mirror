Return-Path: <SRS0=PD7l=EB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAE98C56201
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 14:32:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9140420780
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 14:32:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=collins.com header.i=@collins.com header.b="eCBCsyI6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1781541AbgJZOcY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Oct 2020 10:32:24 -0400
Received: from mx0a-00105401.pphosted.com ([67.231.144.184]:24082 "EHLO
        mx0a-00105401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1781528AbgJZObd (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 26 Oct 2020 10:31:33 -0400
Received: from pps.filterd (m0075556.ppops.net [127.0.0.1])
        by mx0a-00105401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09QEQSic002470
        for <git@vger.kernel.org>; Mon, 26 Oct 2020 10:31:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=collins.com; h=from : to : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=POD051818;
 bh=7L+9X/Irj6S4UjaWn2O/OoHsPX5g0rfWDP21njHL6jY=;
 b=eCBCsyI6hwcCUSPVvVCpy+aEdJWX5QZxo4oGMyUwGTXNE3jCFwaaNPLqj5p5JsX5kKd4
 jn77EL6cv+0lpPOeuG7HnUXys3g28Jft8dvwYheYZTCE5X8e6PHAw6oHN28yoL2whU6G
 9sJaJHLNiwT/kQouO3BqiYGK1vTvqYTrADpVp+DGbLQS3eyEC732NZ3PWSg4NR/ZKHDZ
 jamLMMPliSQ9DHjryvJpLBDLv62oO/hxvQtKcgWzToKalCs9uYevqtuIDrAJxXDJkgSy
 fGqgVus0M8/wKAeNwVQNowIdzGQi4yQLedLbU6qm6ROOlVN7GfzgWpEddQ98sDdGJ/NI Tg== 
Received: from xmnpv39.utc.com ([167.17.255.19])
        by mx0a-00105401.pphosted.com with ESMTP id 34dw79kt30-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <git@vger.kernel.org>; Mon, 26 Oct 2020 10:31:32 -0400
Received: from qusmna5k.utcapp.com (qusmna5k.utcapp.com [10.161.160.133])
        by xmnpv39.utc.com (8.16.0.27/8.16.0.27) with ESMTPS id 09QEVVtt013592
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <git@vger.kernel.org>; Mon, 26 Oct 2020 10:31:31 -0400
Received: from UUSALE03.utcmail.com (UUSALE03.utcmail.com [10.220.35.13])
        by qusmna5k.utcapp.com (8.16.0.42/8.16.0.42) with ESMTPS id 09QEVU3Q023068
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <git@vger.kernel.org>; Mon, 26 Oct 2020 10:31:30 -0400
Received: from UUSALE0i.utcmail.com (10.220.35.28) by UUSALE03.utcmail.com
 (10.220.35.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 26 Oct
 2020 10:31:30 -0400
Received: from UUSALE0i.utcmail.com ([10.220.37.28]) by UUSALE0i.utcmail.com
 ([10.220.37.28]) with mapi id 15.00.1497.006; Mon, 26 Oct 2020 10:31:30 -0400
From:   "Rosenbush, David M        Collins" <david.rosenbush@collins.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: bug report: git add --dry-run does not honor core.ignorecase
Thread-Topic: bug report: git add --dry-run does not honor core.ignorecase
Thread-Index: AdarpIxOGBDT5xQBT/eKDO/HCLanYw==
Date:   Mon, 26 Oct 2020 14:31:29 +0000
Message-ID: <b082a81ee8bc4d7da325c3b0a6d2611c@UUSALE0i.utcmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-tituslabs-classifications-30: TLPropertyRoot=UTC;TechnicalData=;
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL1VUQyIsImlkIjoiZDgzZjI4MmUtODljYy00YTdjLTgyNTQtZTU1OGE3M2M5ZjIyIiwicHJvcHMiOlt7Im4iOiJVVENUZWNobmljYWxEYXRhIiwidmFscyI6W3sidmFsdWUiOiJOIn1dfSx7Im4iOiJVVENDZXJ0aWZpY2F0aW9uQXV0aG9yaXplZFJlY2lwaWVudHMiLCJ2YWxzIjpbXX1dfSwiU3ViamVjdExhYmVscyI6W10sIlRNQ1ZlcnNpb24iOiIxOC40LjE4NDMuMTIzIiwiVHJ1c3RlZExhYmVsSGFzaCI6ImVZUDNidmt6MTF0QTdZYyt1WXZjYjVSZEVQS0l1S3lLeUJiU2FJemQ2Z3hRWEFqUUdDcEZMXC92TGw3V3d0cTBpIn0=
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.220.35.237]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Spam-Details: rule=outbound_default_notspam policy=outbound_default score=0 phishscore=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 impostorscore=0 mlxscore=0 adultscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2010260105
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SUMMARY: the git add --dry-run seems to ignore the core.ignorecase configur=
ation setting.

What did you do before the bug happened? (Steps to reproduce your issue)
I started with an empty archive.
The configuration was set: git config core.ignorecase true
The file git_ext.txt, used in the command below, includes multiple specific=
ations including *.ico
I issued the command: git add --dry-run --verbose --pathspec-from-file=3Dgi=
t_ext.txt
git reported that no file matched *.ico even though there were files named =
xxx.ICO
git proceeded no further after the report.
running the git add command without the --dry-run added the xxx.ICO files t=
o the archive

What did you expect to happen? (Expected behavior)
git add --dry-run should have reported that the xxx.ICO files would be adde=
d to the archive.

What happened instead? (Actual behavior)
Executing git add with the --dry-run switch should mirror execution without=
 the --dry-run switch.
Both forms should honor the core.ignorecase true configuration, but --dry-r=
un does not.


[System Info]
git version:
git version 2.29.0.windows.1
cpu: x86_64
built from commit: add3cebdf89e93784955b34e1c1ffcba308b89cc
sizeof-long: 4
sizeof-size_t: 8
shell-path: /bin/sh
uname: Windows 10.0 17763=20
compiler info: gnuc: 10.2
libc info: no libc information available
$SHELL (typically, interactive shell): <unset>


David Rosenbush | Staff Engineer, Software
COLLINS AEROSPACE | ISR & Space
One Hamilton Road
Windsor Locks, CT 06096
Tel: (860) 654-5697     cell: (860) 798-9944   Home: (860) 658-7993
David.Rosenbush@collins.com

CONFIDENTIALITY WARNING: This message may contain proprietary and/or privil=
eged information of Collins Aerospace and its affiliated companies. If you =
are not the intended recipient, please 1) Do not disclose, copy, distribute=
 or use this message or its contents. 2) Advise the sender by return email.=
 3) Delete all copies (including all attachments) from your computer. Your =
cooperation is greatly appreciated.


