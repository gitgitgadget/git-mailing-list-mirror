Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B08A4C433F5
	for <git@archiver.kernel.org>; Wed,  1 Dec 2021 08:33:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241985AbhLAIg2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Dec 2021 03:36:28 -0500
Received: from mail-db8eur05on2045.outbound.protection.outlook.com ([40.107.20.45]:46688
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230433AbhLAIgZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Dec 2021 03:36:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fYZMXy8y0fFRm85lkEOr+cxayOPfnGbc7hxB3+1iwBV+cuBAw9MLfRSW6agXLL9DQSzEFYoBFmqUdUbZLiMxF728MsXBIokZNinpk69iyVjTfW/VFHaezgbhLpgp7L84dVgZgpT5dlrC5mn7j/UDMXeXCbsFAQcEYjALnlD7bvDVmxf9xSfmUUL0dt/qpeiPVbXJLRBcKDs26zAbq/CV3GMrxJC/Sx4BWK5tOc1ukFjFrRIhO3mbZXpPtKBHE33GKJEiFcpZ7GY3XsxMHBrTzsf+XHbaHkRn7PTXITNmf11LTNG9D2QLQVZMd7sieEphdNiueOExAWyS14v17Zwzfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hGl7Yz/0Az1nkX+UZr1SkB5ZtKOM234KwTJFrQUo2Fw=;
 b=K5YGZQh+YCWMKVXqYbnufNEVICWLnKB/2afbfcuey1fzhKIon2Pj4h8d4ZQrT8FDKPgKvEQBRf2xXK7uh9eRlKmLNv4u6BY1Kb0RXM+bPbr+J9k7bsI3JyN46eD9PtdfHv8M2WlbZ5qwujbJ3czbJ9aZTbygjKRD3jq9j5xhzB3hgkUs0lSweDfjsRAgiBJN9796dSPpaRdfxKRjlqjJ4ZKLxv6fKg8P6YVEfxFME9+a1f0yLzSFrNkq+EpVHVbDDfPC3Pdas5Wesgzl1kalWuIwmr3M3uoF2ugMclagQcsxVKE8BTgk1senjdLSS2SgrSip6vydx+4QaKxI5EV5SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hGl7Yz/0Az1nkX+UZr1SkB5ZtKOM234KwTJFrQUo2Fw=;
 b=Rr+4hsrKbPgQ5qaT/huAEOY640BndE7lcGTi1m46oyQaJJPy+ThsN9S5nDnsJxyYH2JF94KSJzqD/akjc+94LFfUotM/I2KDAvdey6J6wLR1a0DJFsIi2QrrgWoQFf055ap2vSQ4W6BsT1mZtlM0NL85sj5Rxbtoy09oFhDUsLg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PR3PR10MB3997.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:a7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22; Wed, 1 Dec
 2021 08:33:03 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d9de:b41b:461d:fb5b]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d9de:b41b:461d:fb5b%8]) with mapi id 15.20.4755.014; Wed, 1 Dec 2021
 08:33:02 +0000
Date:   Wed, 1 Dec 2021 09:33:01 +0100
From:   Fabian Stelzer <fs@gigacodes.de>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Randall Becker <rsbecker@nexbridge.com>,
        Baruch Burstein <bmburstein@gmail.com>
Subject: Re: [PATCH] CodingGuidelines: document which output goes to stdout
 vs. stderr
Message-ID: <20211201083301.ozrhi2brjk4zx5ll@fs>
References: <20211201053214.2902-1-sunshine@sunshineco.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20211201053214.2902-1-sunshine@sunshineco.com>
X-ClientProxiedBy: AS8PR04CA0089.eurprd04.prod.outlook.com
 (2603:10a6:20b:313::34) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
Received: from localhost (2003:ea:5820:600:c042:75a0:fd5e:1472) by AS8PR04CA0089.eurprd04.prod.outlook.com (2603:10a6:20b:313::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11 via Frontend Transport; Wed, 1 Dec 2021 08:33:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3d40c502-5429-4e97-7c8a-08d9b4a53098
X-MS-TrafficTypeDiagnostic: PR3PR10MB3997:
X-Microsoft-Antispam-PRVS: <PR3PR10MB3997BF143BB68B05FF4E4F62B6689@PR3PR10MB3997.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b08aIoQmRZ+7jSWSW7ZkESgB1N6D4zyg5jZFsUp75jHexVcK8Xn+Xwc5ESCOEtiwELDHuGXYyR2AIEFYLOL1w0BHXeycc2KjuGSP2Gdg45RAnQqA6MyH6x1T2xBZ2lPmZxl/el04zCaLphLP9sxY+klZSaUx/4Q2FWPn37eskAeCFnAaQQHrYHZMOC9f+8z4huivi401I8ItfXsEkTmdie0T/waa/MOzE+KOVYfJwnTnmUMyk5c85zlH+wbG/5q5Jx3cadXkeDd/YaJm2QAboPkrnBywD9aPj0Flmz5XU0Zx+k4sKF8Er3DjlQ+wiPGXF/H+RGNB/pMYchNazT4OicaJAYRR/6m5T0fXqjiDrNguQhdHR0W5n7ZWBdTPEla62/rVP+bkskq2fbZJ6Y/gooC0jRWyrTEttwSUgGZ8roltsi62Jl1rPAt3jhddi/udUvDMMyh1bDg65ah6SrVZzv5ZPuvv3Ih3HU/bowItFqrfIC4JXygHZgD8OpJVyD1Br3oOPQGVScB9qTaRJIeqlllMl4uJRmVy6b5ZgK916+iiM9iZIjjTvVaNtiiFcm6wfBunJR9pumE40+zHlrl+dYylbwzKeUqsfO4C+hrt6ziUfH3BPI3aFXrxtAUHcmtHR0u+qsOJn7B1ohEOFIYSSfPrLPe/gy7TSlmgcVzFsFvBLmJITndrfDPWF1ve1SpebTZMlSukFjjfWZLVWM7ciqWAZMXrskcn46tgnxEuKcE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(7916004)(4636009)(39830400003)(396003)(376002)(346002)(136003)(366004)(186003)(9686003)(66556008)(66476007)(6496006)(6486002)(5660300002)(66946007)(33716001)(53546011)(4326008)(316002)(508600001)(966005)(8936002)(6916009)(83380400001)(54906003)(8676002)(38100700002)(2906002)(86362001)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OWZsbzV5UFhEbDhvcE90dTZOMHFuTTUyMU9ORjVMVUQ5bVVqV2l1S2NDdzJG?=
 =?utf-8?B?MXMrR1FucmVaV0Z1clZZc1FWbEhRUmx6Q1JLM1pVSVl1T0htMUpCSDVPUjlL?=
 =?utf-8?B?bktibXFkZG1WTDllZ2FVcWZ5VGhBem03UjN0dGN2dnFGZHc5bTdGZkxpT25N?=
 =?utf-8?B?UXVZT01MTGx4U29UMFRzMDdSRk1EWjk4R2drRExxRG00NTY2UWxHNTBEbWE1?=
 =?utf-8?B?TjhMZkhDTnRkVyt0Z29WUzlSVE10dlZmWGlVZnhYTHp1eUdQUERaUzZRSDRI?=
 =?utf-8?B?ajVkbDhpdXNRck5FYXZyTktablhZWEhhZkYyMW5XeDhLZTBGVE1IY1hxZVNF?=
 =?utf-8?B?VDVjUlVCNWhjWGtZRVVNb0ZEZ3BlOVVvbXdTV09zQWZTcWQ0ZjRaaE4vMkpm?=
 =?utf-8?B?c1Q2OHhsY0NRL2NsQXNNM0wyUVl2OHhjN2FySHNKeEF0V0U2YUttcFVESFpi?=
 =?utf-8?B?Ti9nd1dLdyt2Z3YrRy9DQ3BqaThkb1FpcVh3UDFYRlppcnhicUNuVmNjd0lm?=
 =?utf-8?B?TXpZdlhQeS8xdUlyeWprd0ZXTmRjUWEwQnZ5S2todXJTZDNFQktaSy9RMFlG?=
 =?utf-8?B?RDdIZ1JVbzloUkYwai9Fc1VBK2haYjVCTXhiZDlzZnJjNmkvWkdad0lZOGYr?=
 =?utf-8?B?bFhtc3BlTHhwSDNzUnFWOVYzWTZ2bjFaTVcwUFE0NzlGdVZhY1F3R0tqeXBG?=
 =?utf-8?B?Qzl4NzlQbVl4Uk9qRDExdHRidDI1RFdBVVVLM1dJVTRSVUlGNEw4VE85QzMy?=
 =?utf-8?B?aHVpaGRkdklSS2EyZEVrMk9QZWNjQllCUC9QT1lwaWpUMHZ2YmhqNEVlaXBH?=
 =?utf-8?B?Rk9vY1BpNzZYMmMrZlVUWTJNMjExMW1CRkFYM3pSY2tJdFJwendSUlFVUFBZ?=
 =?utf-8?B?citYRFNaOHgwRzlZTzE4akN0bVlqU1QxN1FjL3RzRklSeHRQRCtaNU83YnEz?=
 =?utf-8?B?Tzh3elFxSDhUelVYNWo1ZUdxUVovSVZlVThqTGtyUkVWamFWV3FNUTFodE5H?=
 =?utf-8?B?NXd6Rm43ajlWK1Q3MEdURmJtb2haMGFTbXhhZG9tOE5TbVVNdzBaQnlsanRr?=
 =?utf-8?B?WXlPb3NPR3JrRnNBeVVXMDRqKzJTOWJaVkZ2d1FiclovNm93dW1kMjl2WFBk?=
 =?utf-8?B?RkwzY1ZXN2VhUk1LZ1VrckVydjEzYU03Q0tGMGtCemJldmtMdkdKT0FzOVZp?=
 =?utf-8?B?VmdNK1Y3S3lGTjlERnBkRUV1bm5CZ2NyN0ZqSG1TenRYTHlnRFArNjZiZDFS?=
 =?utf-8?B?WUlISmdUYWFsODdrVWtQUVo0SUZhQVNDSE9VWXdhd1BrdENrMTZHVHFKNGo1?=
 =?utf-8?B?bHpueVJXYlBnUnlhMGtBV00xbGhFeUIxVEJFMWxLUjlpWFFIamZqQ3BPS1ls?=
 =?utf-8?B?eWcwdVJvMTJZV3Z6OXBsbmlLNjR6cHVWbEJpR3FZbzJKWVRaQWVPZFl3YXRJ?=
 =?utf-8?B?Mk1MYXhUVUF6OVpQaEFCUURUSFU5eGxpVDhCcVJzc1RmU0E3WUVTYW12am8z?=
 =?utf-8?B?ZGNhRDRRT2xlU2owWHVRTWlLQ1JadURtT3lWemJhb1ptUkwrdUpsdjAyZjE2?=
 =?utf-8?B?TjZVdGNSSmRSaXJ6cVYybU05QWRTSVA4YStPNmo1SXcwb08yc1ZqRFEvVGMy?=
 =?utf-8?B?M2lDNFN6QWR5NkkzbUhJZ0VxVlFsbjB1MVhrU0FlNGtpNFY0RHdXYTFDRmly?=
 =?utf-8?B?QktLWmo2S0J3dlJlQXhMekRjcmlhYkVwbDMvdUtEUTJGOGl6TFRndXIzMTQ3?=
 =?utf-8?B?L0YzTVBFTXExS2dteitZZkVGMGtJckRmSWcrVkcyUkhTdkJsZlVRRHJVTkE2?=
 =?utf-8?B?M2hXeUhIR2JBNmpDMDh3M2VCZlZaanY5OG1aSWtKRjVydGlvQXRpbWZxNkFB?=
 =?utf-8?B?TUtkYmkxRlIySG9HSTcrak9RbERJTDR2eDJEaVVMWG1IZ2R1R2s0MTFCU0Vt?=
 =?utf-8?B?T29EUTlTUHp5ekl5YUUyZjVJaitBTGlDZXBBdHh3eTBWRkgxK0VGTXNheUQv?=
 =?utf-8?B?R09uNTZzampoMldpclFtbGVma2pmakoyVGErcHBTeENmSytVcVBiUEF5UHJ1?=
 =?utf-8?B?YmE1R2MwVEQyVEwwMW90c28zRXJOYzd4Qklvb25WVHhqVjlTRjFtY0FNeGlW?=
 =?utf-8?B?dG1iOXFVR2VJMnNRMUFXcEhrM2h1T09OTWQwaWQ1R2ZUR2VzQWo4c1BDTkxK?=
 =?utf-8?B?NnVKZTI3YlhaZ3NvRTlEVC84ZGxoQUtzREd3WGI3ZnpNQVdMUXdvMTZKWkwv?=
 =?utf-8?B?UlptSmpZSGNNWmNwZXFxMFN4MTR0ZXVSUndkM1U2ZjlUMWx3bFRVVUE3UWZX?=
 =?utf-8?B?VHN5NjJQQjZ4SXhwQlBCRkNNOEM2cDFiZ011aDBUcGNoN21BUEtLMWROdzJR?=
 =?utf-8?Q?d/f6RY49UD3SxCNw=3D?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d40c502-5429-4e97-7c8a-08d9b4a53098
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2021 08:33:02.8923
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W11bPJsaP+644H8EwvZMKL9MzZGNXJ2knRqevz73F6ZQIz8hvux3XlpMvT5rXiETslyOY/n8EzkWv5NqUC9VDbuQ7huqpRF4Z/hRgU5fNIQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3997
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01.12.2021 00:32, Eric Sunshine wrote:
>It has long been practice in this project for a command to emit its
>primary output to stdout so that it can be captured to a file or sent
>down a pipe, and to emit "chatty" messages (such as those reporting
>progress) to stderr so that they don't interfere with the primary
>output. However, this idiomatic Unix practice is not necessarily
>universally understood and may be at odds with other schools of thought,
>such as the somewhat common one that only error messages should go to
>stderr, and all other messages to stdout. Let's help newcomers by
>documenting how stdout and stderr are used on this project.
>
>Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
>---
> Documentation/CodingGuidelines | 26 ++++++++++++++++++++++++++
> 1 file changed, 26 insertions(+)
>
>diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
>index 711cb9171e..44dd178dc9 100644
>--- a/Documentation/CodingGuidelines
>+++ b/Documentation/CodingGuidelines
>@@ -499,6 +499,32 @@ For Python scripts:
>  - Where required libraries do not restrict us to Python 2, we try to
>    also be compatible with Python 3.1 and later.
>
>+
>+Program Output
>+
>+ We make a distinction between a command's primary output and output
>+ which is merely chatty feedback (for instance, status messages,
>+ running transcript, or progress display), as well as error messages.
>+ Roughly speaking, a command's primary output is that which one might
>+ want to capture to a file or send down a pipe; its chatty output
>+ should not interfere with those use-cases.
>+
>+ As such, primary output should be sent to the standard output stream
>+ (stdout), and chatty output should be sent to the standard error
>+ stream (stderr). Examples of commands which produce primary output
>+ include `git log`, `git show`, and `git branch --list` which generate
>+ output on the stdout stream.
>+
>+ Not all commands have primary output; this is often true of commands
>+ whose main function is to perform an action. Some action commands are
>+ silent, whereas others are chatty. An example of a chatty action
>+ commands is `git clone` with its "Cloning into '<path>'..." and
>+ "Checking connectivity..." status messages which it sends to the
>+ stderr stream.
>+
>+ Error messages are always sent to the stderr stream.
>+

This is not necessarily true in the context of the tests.
We just spoke about this in: 
https://lore.kernel.org/git/211130.86wnkpd6ou.gmgdl@evledraar.gmail.com/T/#u

I don't think it necessary to bloat this explanation with the test details.  
But mentioning it as an exception would be good.
