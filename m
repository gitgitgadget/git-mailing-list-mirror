Return-Path: <SRS0=fhRL=6M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5B62C83000
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 09:16:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B08F42053B
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 09:16:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=procountor.onmicrosoft.com header.i=@procountor.onmicrosoft.com header.b="IoEbkYjD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbgD1JQU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Apr 2020 05:16:20 -0400
Received: from mx10.partnercore.fi ([77.86.249.10]:44084 "EHLO
        mx10.partnercore.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726271AbgD1JQU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Apr 2020 05:16:20 -0400
X-Greylist: delayed 863 seconds by postgrey-1.27 at vger.kernel.org; Tue, 28 Apr 2020 05:16:19 EDT
Received: from pps.filterd (mx10.partnercore.fi [127.0.0.1])
        by mx10.partnercore.fi (8.16.0.42/8.16.0.42) with SMTP id 03S8xuAo030546
        for <git@vger.kernel.org>; Tue, 28 Apr 2020 12:01:50 +0300
Received: from eur04-he1-obe.outbound.protection.outlook.com (mail-he1eur04lp2055.outbound.protection.outlook.com [104.47.13.55])
        by mx10.partnercore.fi with ESMTP id 30pe6rggfy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <git@vger.kernel.org>; Tue, 28 Apr 2020 12:01:50 +0300
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mvzbg9ry/pLMmXKiHNbKndUHfvRd6JhWYmWr5WWzwLsJJRGRDPFFTWwzWI3Vxkw3Fwx8aSbDlaDIvoBce6j7cK8XBucnqgSmI/j7I70MXvSu1CMfKjwzSx1/YDe/C1YL4iNPHgjwmMS9tfva1KSpW8WVMKAOwJfh4dkEM+YHOttC2JPMaZD+T8K4N6VrYgtHZ9J/myeHHhtiYGZ/gfYiucb6GOi1+Ho/m2KPZG08/ItljAZXde/5jJrVD3IduwRFOqFTAljH3DwhM54EamaRX1wxv+++a8Kul2ZNLb1WDutY5PLvyhpcNTWNgoVWE6deg1Q0AiisDAoG+lCtgU+A6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fQqiWa8kt++ymyt7tHYZueF/qxzbsJA8vlXVfCOHXv8=;
 b=ep+/o40uyQXqZuv5P7DH9QcSAzNQ7977kn+p3dDiE6KC7yR53Ofp1YpjyJ9zdJsor3eVVlDao/icEEp12frKXZXL6gJdeK5+y2Ufs5pEcna8VWy0E53eE5l6g1yT9JKQAQAz4syVhObLQa6mSmd/OoofMZe66YcoArn/+P+QmPmwQ2FZAvr1lluUeG6JCuxXZbqBEoFjqaop/XiDBo41EJTC/68t827oGPISvN7F0GYUBqo2BZoLl7SuXoZC664l/fBh/D8NpsKl0fJqoA9ToXsiIGkUlT+Wioqof7wB63Qot+ayGKU/FVt/Ey2Ju2K34e8c1psuMaxYY1NLfV+4Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=finago.com; dmarc=pass action=none header.from=finago.com;
 dkim=pass header.d=finago.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=procountor.onmicrosoft.com; s=selector1-procountor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fQqiWa8kt++ymyt7tHYZueF/qxzbsJA8vlXVfCOHXv8=;
 b=IoEbkYjDKQTwQbgP6mSxNHgccphtdI8gfnSH4tgqiTXN826cgmFmWXTpRS1qE+91gGx42AOflRQtB9utTs74XMe59senObro6yYpd5JmXXydzjdTicnVI3ZymHvU7MxyYxw5EaWaQPZuFpaq06kc9sX4dqsmnEOrTTa5/cV5cU0=
Received: from AM6PR09MB2980.eurprd09.prod.outlook.com (2603:10a6:20b:d0::13)
 by AM6PR09MB3447.eurprd09.prod.outlook.com (2603:10a6:20b:f2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Tue, 28 Apr
 2020 09:01:48 +0000
Received: from AM6PR09MB2980.eurprd09.prod.outlook.com
 ([fe80::1836:f18a:593b:2cd5]) by AM6PR09MB2980.eurprd09.prod.outlook.com
 ([fe80::1836:f18a:593b:2cd5%6]) with mapi id 15.20.2937.023; Tue, 28 Apr 2020
 09:01:48 +0000
From:   =?iso-8859-1?Q?Harri_Meht=E4l=E4?= <harri.mehtala@finago.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Bug: git restore --staged --worktree not working in git version
 2.26.2.windows.1
Thread-Topic: Bug: git restore --staged --worktree not working in git version
 2.26.2.windows.1
Thread-Index: AdYdOul5yN8K+HC4S7Oe1JWGppWedw==
Date:   Tue, 28 Apr 2020 09:01:48 +0000
Message-ID: <AM6PR09MB298072F9FEB469130EAEB8F18BAC0@AM6PR09MB2980.eurprd09.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=finago.com;
x-originating-ip: [88.115.188.106]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b5f58d56-2513-456d-9e35-08d7eb52c896
x-ms-traffictypediagnostic: AM6PR09MB3447:
x-microsoft-antispam-prvs: <AM6PR09MB344793DA91478172853F539E8BAC0@AM6PR09MB3447.eurprd09.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 0387D64A71
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR09MB2980.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(346002)(396003)(39850400004)(366004)(136003)(86362001)(6916009)(7696005)(6506007)(2906002)(66574012)(316002)(4744005)(33656002)(508600001)(5660300002)(26005)(52536014)(81156014)(66946007)(71200400001)(76116006)(9686003)(66556008)(66446008)(64756008)(186003)(8676002)(55016002)(8936002)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Mn5wPB5mHUNbPEiOUMmqMUB4wly4NPI1qt2A2Lgl/LVnusilr02kgIQoNTFKvBlbA9JsIOALl+UKRaQ/ennZnliS+dEuqukFdu39bXlTFAVyN1gUB/iQEJXsFhuHBtEyZWe2kOraofVoxLZTKs2dhIFj+tKYQhx8DJLapWhOiwvlzUQZr/82AnEfabQBcc1xZHIe36gRKQMG6xBz8xaHWcfa1+q0FXIrgtlupQQU4hR5stYS9TQnr2UZ85i4u3HZv4mKqjw9iHAAYWioLPv7c1TRaSMY/9wXtYDxXOK76s49agpFCI0RE/OtNAUtqfAz1ixAAdyuvNosYKcPeJGCKCd0r72BkpMEM5wh2vRebHB16kPywZe9S9oVI+PZnhrMaFg0HInrqra7uEChOWy1FAdIaTMR80Souk42bo5pZ/GE7amQkxbrwS8VIlSvHXwt
x-ms-exchange-antispam-messagedata: lItW49/M7iUN+4nxGM2RbJpDUGutvgp3UxL6AObXeeZJd3xjELED+MU/snOP4ItfdMlE3cuy9HZY39ObgycdttMUpiQGLMOkvwgh+Hvs8ALBzLfbC4oBeqx90S3KBGix6qE9ns0b6MZQu5ivFHpUZpL3/lMecCeB9y7+48U0P7vRf1QwWm6n5wQlzjvsCUzZITBGsjWz/nLEqTNqkIiA5kDzfnF98cuuWV7Q5HtxMNcSRduC4xQBGJ98KSpZo2ZuuI1Rgyg2V7p7E4BYhI+B+LtIv7TvnWJ9zi1OV07Dvez1nxbAcJv6v+uoXS4hFRIfKSBLnAVkKVhdocu24Nu4xT4FrKEOmgzIrENJi9FZw9MjLrKcWFEuNTmY2isrxhc6mAAo2V41h/5sAr6DoadbyvYGItiq4UBtIVaa89K7ahuXwvLOrOtqy1CtVdWkbh0rZhffzuwSmUVWXQAFoliAtxwWkE6JcLCJdW0YpuY5Xleft0+ieOMlCl6GUo2ivoJLbVkfnvqxaY2np0lBdLCgclCvlZRE5KMR7B6H7yFhZQafEsJFtcKUgnPhbh0mme8cjBLADwlgKLtIRnOLSG56ShpZiIC5s0yUQUIlOumB1D/2gbiHikO39NJeooHpTdcPZl9bn9m3fcD1kXdO+cqQSwsCcjmEbNwU2+1/mmCGiM2ywHAOtNEoBDU/ao5H6mgMOmMq/cc9urwwUe33CuVEtT29U0HRvm5JB0fcrFtEm/B6ArknOJ7r6JHwKi1NCWqRhhIE6TM5NwM5S8GJhl3ZFYj2vVcn2OfSaE/c4u7nigg=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: finago.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5f58d56-2513-456d-9e35-08d7eb52c896
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2020 09:01:48.1044
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8712f8a5-8316-4c07-b8cb-d9ac94d3cfbb
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iEai4EC7VU+b/oYxLNQUoE4Js1cfLvEG6VxuVlUaa4BdbHW6x2tou82FGfmMNw2y9htyHJ+OTRyUg/vh3LdSdH58/naKzM1DrXj1SUQiezY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR09MB3447
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-28_04:2020-04-27,2020-04-28 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=775 mlxscore=0
 adultscore=0 spamscore=0 malwarescore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004280078
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello

In git version 2.26.2.windows.1

I am trying to do git restore --staged --worktree for a file. I understood =
from the documentation that you can do both.

"Specify the restore location. If neither option is specified, by default t=
he working tree is restored. Specifying --staged will only restore the inde=
x. Specifying both restores both."


______________________
$ git status=20
On branch ...
Your branch is up to date with ...

Changes to be committed:
  (use "git restore --staged <file>..." to unstage)
        modified:   pom.xml

$ git restore --staged --worktree pom.xml

$ git status
On branch ...
Your branch is up to date with ...

Changes to be committed:
  (use "git restore --staged <file>..." to unstage)
        modified:   pom.xml
______________________

It looks like currently I have to do both separately.=20

- Harri Meht=E4l=E4
