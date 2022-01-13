Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF4A8C433EF
	for <git@archiver.kernel.org>; Thu, 13 Jan 2022 13:48:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235472AbiAMNsD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Jan 2022 08:48:03 -0500
Received: from mail-mw2nam12on2046.outbound.protection.outlook.com ([40.107.244.46]:56768
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235091AbiAMNsC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jan 2022 08:48:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l1dLFVp6rsyCVH+6vkm9DNz2EZcjoPmoFq2+tsfqS3GDGHJX6x+eytu1YkZtGOHnjfHUpQCNbgIn+S2y0VON8EjgW/99Ui6mh7T8cNov4ZqkJNtrcs6ZQRj5BdDEQgixZHIw29SF0QgRaKS4xvfVL6rWXwcPU+8BD+AYtaNS1N0Rv9aZ8rQnwnnV5faoNiuVHjMjteZ3gAa4xTtd9FQgkcPxN96b6r3xa6Tj77q07Wpb9TQC5JKMCV2lCZh8ZVFckSQFuj8MJoAPLsnoScZiIcdBbsNxir160cWuJdyX0/+IXou4uye50mYVR3g47jtleAOBC+88387IgsEppoFp6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x7J/YNg/a8I/1wXrZIdM6BBtgc1z6/8sV+TyQpwuOVw=;
 b=O2qEe3ZAo1nNXW9tkGrlQhJzHVZMf/AwZHP8ikefech3Jx4aYTZjlykFCoYt97UsLp4ISTireH7GAj0cufVTghgRr+8L5uxsAswkzhRw0b5jFdcWKOf2d2tzlGOWX+vGyG0tto6NdmHkmgnOiETwTCi3YfaO6YFSneB2aSsbSQrYhPxyoR/mANtsrxvHzubik9O0xWw8sRHonaHcK3Y7JCP72ArpG/6DGyW1JlZng39xPTkRrI9XW+HYRmpA2jaGHn+yl5PddV6mQPov1nZK7i9KFE//uXYrUhFMy0T7aDfs6JZmjJzkdRFjkS0UfhqUZyr1zRbZzlBoUFFi+j5sEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x7J/YNg/a8I/1wXrZIdM6BBtgc1z6/8sV+TyQpwuOVw=;
 b=Ui49/WT2xga1UYBcppfwH8hQa6IPqlHcc5g7HwHO/uwGz1D0dSkaupFt3scuW1yyosgtfXxnasnzjyP4M6FgSLCEX7D1p2cvw0cIUVtSUVtE8hvbfDb/dAmKBkRjNG0npY6J7fZzqMjD5dUE2vkrdGcVIKHbZhSbvT8C0Mfc46AZktYdw6HG/Ap/0rv8KYQWcs6EnhoSeRhVAaHDCVASpZFjh0Y5hqA30Xveydmk33KJasH35Rd4cpuCqwOsp8uc0Odjq/+zZXzqZ8MupZBVAYCzkCSj9oz3AqGdFTGbtuAjtNIOzbhzS0nbeBNPlCGbX1JzMYCb4v1hATHjgUUUmQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB4849.namprd12.prod.outlook.com (2603:10b6:208:1c2::17)
 by SN1PR12MB2447.namprd12.prod.outlook.com (2603:10b6:802:27::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Thu, 13 Jan
 2022 13:48:00 +0000
Received: from BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::509e:bbb9:e1fb:26ed]) by BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::509e:bbb9:e1fb:26ed%4]) with mapi id 15.20.4888.011; Thu, 13 Jan 2022
 13:47:59 +0000
From:   Joel Holdsworth <jholdsworth@nvidia.com>
To:     git@vger.kernel.org, Luke Diamand <luke@diamand.org>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Cc:     Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com>,
        Dorgon Chang <dorgonman@hotmail.com>,
        Joachim Kuebart <joachim.kuebart@gmail.com>,
        Daniel Levin <dendy.ua@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Ben Keene <seraphire@gmail.com>,
        Andrew Oakley <andrew@adoakley.name>,
        Joel Holdsworth <jholdsworth@nvidia.com>
Subject: [PATCH v2 00/21] git-p4: Various code tidy-ups
Date:   Thu, 13 Jan 2022 13:47:07 +0000
Message-Id: <20220113134728.23192-1-jholdsworth@nvidia.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR06CA0101.eurprd06.prod.outlook.com
 (2603:10a6:208:fa::42) To BL0PR12MB4849.namprd12.prod.outlook.com
 (2603:10b6:208:1c2::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1a5b1041-2adc-4773-7f7c-08d9d69b4fb7
X-MS-TrafficTypeDiagnostic: SN1PR12MB2447:EE_
X-Microsoft-Antispam-PRVS: <SN1PR12MB24479FCE1E82981FD49CF921C8539@SN1PR12MB2447.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oyQvlHFHk9Hg7dgb2ia2sFxRrc5022zHoUdhIjx4237qky2osP2CZIxQEcmubSH5LyUv2Ha5GAqFVSdEKMLL1+2WYk/2fL1iSWLKsL1BPyGtvGOe5hPJnxM9bNWj/gnsQ0Zt8fCjCbqHSE80JzWjR/E6Sa4k1YmKCMxer4hQ1IsARwGudyIrkTuydU9BSwuubQdloIxBLR+Ox99xd6z6tB0HKQKVHYy7wRiH+mRJtkXttCOqMnkg03+pWGO1vFfTfF3GDfhqUJH4fq1VBSzbNO2MP+aYJYypaQ8AiBHb6waswQ4SQXt+O6Z/65JnhowwYC9OV5TsAKzO4CneP80di8vugEpTinQCTndSFs/2VCN1guVhRz/YnAYKzm/31ydOlL6Yqv/0SjFj8Y0UDSNOHuQYWhApSZ27Gh8PCwT0vIq1IgM9nQ/W0YJ1AYJxgTYMKns7mMfaTAx2mv0LGn9YFnUh0CQixx8D/96T2QyHMse07RQtxhdPXkXtLQdq5PPx6jaUjC9JWTo2eWYHKrAJLsAooLFa9K20RUbHuE49vf+PuiPf3i3tWIdY8Lx8n1epuZ/ETgY8XucU88hg6NtMU8F46C46D3dO3E7LKNUiD9UE2PyRGyKKGHLh2h42II4t8YTzWrFcNbmtTusRdCXJFJAlBoxaqucy5IzzKalT8Gaoc+CPOCf4RxWNfY6aujkXCFQgkRUNezA6JPNfTDnPAQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66476007)(1076003)(8676002)(66946007)(8936002)(26005)(83380400001)(55236004)(2616005)(4326008)(107886003)(6512007)(6666004)(36756003)(6486002)(186003)(54906003)(316002)(38350700002)(110136005)(38100700002)(7416002)(508600001)(66556008)(5660300002)(6506007)(2906002)(52116002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FBOk1/uhpu6A2Rja4N7M4MmXl68wv1i1/16Z5wEbK9/jfBGGOYuQVlAh9PBm?=
 =?us-ascii?Q?Ph/lZUys8P38wzqXJAkNnhNy1toaRKnwu9iLBBmOtIlCldFVmmmbxz0yudI+?=
 =?us-ascii?Q?sdcydNtSx4N0HnKPAq7GlbA00MNVYlWrZqUsfxNtLwVZR4s+TSzzHCkvcxjT?=
 =?us-ascii?Q?E0r16+KxyLO5k7mrqp4HuUrdPvOwTjvchu+ixxdkq4PN1V70U3WofANfORMT?=
 =?us-ascii?Q?MiIKg32B7h8/1MAd4DtzAp99ulGPa1a3zMlloFR85X1NmeM7dYAOogdllftu?=
 =?us-ascii?Q?aRmoZbIvN5CsF4kAkYdBQyak3veXMNPI1GpuuJazUTVdjMZvxMcAVXX/NJqM?=
 =?us-ascii?Q?yY9XoR7aQhwoV/ReUoIM24Zt03fAwYpeYNTskrx8qg9KGKSa2j4eLUtvdsv+?=
 =?us-ascii?Q?QMrQvFZxHozhj6Ahux4N1F0z+fCZBpGI04Nxt345UHHhS0e188ymcW703Ly0?=
 =?us-ascii?Q?TIplf2ToqGp1euXd9QWFxXwfBaaBnfyGyQoCtRt8sJibgoGOrHeRVxU0dO3P?=
 =?us-ascii?Q?ut3dRvgY3Bdb8z8TJqDX0IjVVOGOydJLjZbxrb6D5NR3GS3Bw0V/7rMVjcs5?=
 =?us-ascii?Q?+kZZeSRmPxxP2ZjpLwuAMDzW7auswsvKT6Gu/R/0Yr+P8HtmJDSUafpL7U+x?=
 =?us-ascii?Q?C5z5c9SMXxrIm6s7Bf+37SY9yuJ8A1221mC/wT8HcUHiituLINx3Qc1vQp2c?=
 =?us-ascii?Q?/+eeADVHXZ5kmQF9ZTtqcNzcRNXXtnmK5GjV4ScqRI8IoAbQJPy7qGcZtber?=
 =?us-ascii?Q?+brZJJM1Ny3hHE+0EnRhEoeWYUhoBir7FyPuCT2p1kf109tjR96XHzGDak7C?=
 =?us-ascii?Q?OBEOGABDC/LC73cEYcjtcnWFYwcd5hBbpB1Dlje6hMy2FQ7DZTLihfUqt55D?=
 =?us-ascii?Q?u60E0/636XjMoJIzQjC/Iiv9jqkAF5+AScclFaddxNB57KDyOylPcGfjVq3c?=
 =?us-ascii?Q?lS5hWW2+rRVDIMuvvK5YFCym+AitjVBV4U6+G8Y7Mrytq7KhiFpL0+mx9vva?=
 =?us-ascii?Q?XJkjPygkADCMkbwKIAmM5Xaz20B6onU0udne0vTANMOIZgPgjS6KCyh+/Up6?=
 =?us-ascii?Q?mLVz3XhvF86o887/wFj3rDEXzfPFnw5aE0m4tZYbZmUQTraPMPUxh1wIN2Pt?=
 =?us-ascii?Q?m+g6ktrQi9TQspTjc6A40IOn2q/6BN2AHW5kmrepqG+w4g7d+AMK8mW3KWow?=
 =?us-ascii?Q?hQFl4QQbKauoa//K+SyIRAgVZW8jZPwQq4Vlw64pIrc0s69uDP6EEUQq/KOz?=
 =?us-ascii?Q?8OMIiqkyJ15udTSHs6sbovFvFQIAvBdmpFsrM3fPSZ0gMjgjGwv9Q/tsYqpE?=
 =?us-ascii?Q?Gqgyeg2u9hj8XscLF4J9fRPOH7sWdlBab8+JWwnafecudryTIGnmGkzEnqNx?=
 =?us-ascii?Q?1cXMNB/TYfBPoRLZYsXw04BPudzRf0dDaMbkvqMACM/bJVNvCSAArM2KYCIi?=
 =?us-ascii?Q?K9t8I4On3aLNRbnIL0BSOhRpRF/0McucvuqCaY5jwG2F4t+PoGZvxWTiAxW4?=
 =?us-ascii?Q?vj83jHKECc+PyUo8et6PvoxJB/2sdr982z6hOQEF01qH5qnmFWaRJLKDFLOU?=
 =?us-ascii?Q?hT69r+yomiPwsmzy3Xv/hCZ60Jt8tuDJb2JyLsFIFfFzJOX8S/sPnczN/trW?=
 =?us-ascii?Q?5LwFpSqgssLyQqDe4U6ti/8=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a5b1041-2adc-4773-7f7c-08d9d69b4fb7
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2022 13:47:59.7055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J6/u9fwKoPdOchpIeVWE8C85+oMk9XYk5bDgFz5eyrOy49yIotggl5McWXByE5eH9dr+J5rVAQP20fh9SjG+DA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2447
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch set contains multiple patches to improve consistency and
tidyness of the git-p4 script's code style.

Many of these patches have been driven by the guidlines contained in the
Python PEP8 "Style Guide for Python Code" and were applied using a
mixture of human intervention, and tools including autopep8 and
pycodestyle.

This patch-set stops short of bringing git-p4 into full PEP8 compliance,
most notably in regard to the following items:

  - There is no patch to apply the recommended column limit of
    79-characters,
  - There is no patch to correct hanging indents of multi-line
    declarations such as multi-line function delcarations, function
    invocations, etc.

Patches to correct these items may be provided later.

This second version of the patch-set incoorporates comments made by Eric
Sunshine.

Joel Holdsworth (21):
  git-p4: add blank lines between functions and class definitions
  git-p4: remove unneeded semicolons from statements
  git-p4: indent with 4-spaces
  git-p4: improve consistency of docstring formatting
  git-p4: convert descriptive class and function comments into
    docstrings
  git-p4: remove commented code
  git-p4: sort and de-duplcate pylint disable list
  git-p4: remove padding from lists, tuples and function arguments
  git-p4: remove spaces around default arguments
  git-p4: removed brackets when assigning multiple return values
  git-p4: place a single space after every comma
  git-p4: remove extraneous spaces before function arguments
  git-p4: remove redundant backslash-continuations inside brackets
  git-p4: remove spaces between dictionary keys and colons
  git-p4: ensure every comment has a single #
  git-p4: ensure there is a single space around all operators
  git-p4: normalize indentation of lines in conditionals
  git-p4: compare to singletons with "is" and "is not"
  git-p4: only seperate code blocks by a single empty line
  git-p4: move inline comments to line above
  git-p4: seperate multiple statements onto seperate lines

 git-p4.py | 888 ++++++++++++++++++++++++++++++++----------------------
 1 file changed, 527 insertions(+), 361 deletions(-)

-- 
2.34.1

