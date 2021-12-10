Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBC51C433F5
	for <git@archiver.kernel.org>; Fri, 10 Dec 2021 15:31:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242885AbhLJPfN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Dec 2021 10:35:13 -0500
Received: from mail-dm6nam12on2057.outbound.protection.outlook.com ([40.107.243.57]:40928
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242876AbhLJPfL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Dec 2021 10:35:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AcwfdjYE5fv6r257soXQNuE2j20yWtQ9ambGba0/jJW6eAVwtXyB+nSI3G6gaTZbS82SLKdOElQbsLzqGjWafaYyMbTSvmRGRRiVJvD0VZqRUSxAXffrQ//PF0PPzO6rUnhN7EExWd1rN/dhKhueI26pSsO9u7n0+psA+gDAZRwz9FLpkth4mKYwI/On8iwV4VESozdIvxmqP2IToNbOkyi8T8iUGEpQGCuYRzrA5fmebH8tDkr43lndjHBwi63oONDgYxGBTrr623kl0FSoVkGknuZ95FDfk+rZLQHntv93trhNQpxwUNXrflFcqb/NuSnE1DNVckaHoNdUP/52pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3q4DLmH4reTXj3bVYG7JL350y19wiAAfzNbRCNwywiQ=;
 b=ZcLJckvzVsj6jF9McCZCVM9rw9UCi2xHPDrWRBBNo4O67u6lSLpDzXyiWoAeJLA20OcTgGUCgmpxw5P6/v1Q1YYnAZioFoneBrFhtq2fHG0hCLMuIK7tHpvCfsjdmefrRd9NtHn05OcqOfj+VeCVWc1wVdH62AeTixSZhJJyGsX1p/FTbqDWg3VSxVqf/3SEMyzkzQEvMKozwHmij3V2oBt93Iu1CUbW3NSj23rwxyjq+4nEnkGaLFZ9kDDy7R0gDX7AdHznyzVPOXj5jHFacwGkhjHZjD+TOv5mlUtk1p/To1i5pllqBN9eTas+KPXoOaccJ/PwMGpFYNZOOnLvuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3q4DLmH4reTXj3bVYG7JL350y19wiAAfzNbRCNwywiQ=;
 b=F12Coy5sGduNUhPHSHFatr3MOX9x3Qtp7/im/8ZmF1skYSbYbF8OZ+N33aeWwhRe0Dk7iF4pnGSJgNreXAWcT9gByHNcOsieoRJZCu7OLcxq/JbbYse8nWKINA0uvAG92u0nLVPxhOZl322FL1/4PTfSsjy6mqmnvw/0DZapcn2Jv2qhAKdjzIFwRgRqSSiH65ancmX8uybwQotyP/56n/7xCoxAC27VEi3ay/wtgcx5z3uzFs36PkrAVvboKPu7QZfcfBiE7leyBU4PDFUndhnjPcZdGEXkbGn6GROaEo0yMUO0FXyKqYTBuko+2SdZFtXaJp/P6OoKgRsYQ76UZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN8PR12MB3361.namprd12.prod.outlook.com (2603:10b6:408:67::19)
 by BN6PR1201MB0019.namprd12.prod.outlook.com (2603:10b6:405:4d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.19; Fri, 10 Dec
 2021 15:31:30 +0000
Received: from BN8PR12MB3361.namprd12.prod.outlook.com
 ([fe80::4063:6e26:a906:e592]) by BN8PR12MB3361.namprd12.prod.outlook.com
 ([fe80::4063:6e26:a906:e592%3]) with mapi id 15.20.4755.025; Fri, 10 Dec 2021
 15:31:30 +0000
From:   Joel Holdsworth <jholdsworth@nvidia.com>
To:     git@vger.kernel.org
Cc:     Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com>,
        Dorgon Chang <dorgonman@hotmail.com>,
        Joachim Kuebart <joachim.kuebart@gmail.com>,
        Daniel Levin <dendy.ua@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Luke Diamand <luke@diamand.org>,
        Ben Keene <seraphire@gmail.com>,
        Andrew Oakley <andrew@adoakley.name>,
        Joel Holdsworth <jholdsworth@nvidia.com>
Subject: [PATCH v2 0/3] Transition git-p4.py to support Python 3 only
Date:   Fri, 10 Dec 2021 15:30:58 +0000
Message-Id: <20211210153101.35433-1-jholdsworth@nvidia.com>
X-Mailer: git-send-email 2.33.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0128.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:193::7) To BN8PR12MB3361.namprd12.prod.outlook.com
 (2603:10b6:408:67::19)
MIME-Version: 1.0
Received: from red.nvidia.com (195.110.77.193) by LO4P123CA0128.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:193::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20 via Frontend Transport; Fri, 10 Dec 2021 15:31:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eb1a2139-04bd-4608-a281-08d9bbf2236d
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0019:EE_
X-Microsoft-Antispam-PRVS: <BN6PR1201MB00198A1C01AA565836B4CEF6C8719@BN6PR1201MB0019.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Tqu4FDwC+puVbuAb1psCs01FJdz4g6apgQU4mkP0lGT+yPlD3BPN/KqltJ4dXuXBRUDql9Eb+w4PWFeFckDvjAVn+HTb/I3K771bJdmeQRg3cyz9o1m1uft9i7kx6zDir+ZTH36ljCZNZeqqsCS94eSp73epbqBdDwoAKxFgS5ll/QUOaOgbAZgoo6O/FKlHNDrWtCJ4vpwDlGzHTBVXHSRZhRlwlGgyN4NE1mEIMivOmrcl6XbYdhldtOwS2kPvn0RTlYmA+/c1bfXae5aLnpTCDRKvGEPQyk4Eo3vMTDU5aBz/BejAjcF18AEfDf8aV74Bk7khp1saV9mbp5o3B2G4vOgZ8CY221g8szGP1h/YU3HenDx14sQHeCDhd87f5WaEZuUlfctZnP7Apj0PzPhwNmIb/DjIpcE4jTI8Q3Oc4Z54aRU12DJFLjQtvdIpIAQ6RA8RjeE/OBw2WdB1u+UKCYkLqlas+YnS57NSGz8MYD0DhIp29ziDgJhSZB8K/Ld3huKu43LUg+Ax+yDbgseWmYCeIz6bTtmlZMnxFbx4TOupxEGpi3dzlhjePBfPF9dUCms+/T/Qr4Os8hn7Uo2S9FR2gJJ8D5ANzUzX1fNo9hMFuEKKXr9GZ1IxBc5AVLskMtbNFj2qqK87RjDS6RRE3WZz/ox4MfUinsjzF9/EAAW7KTDuJwoJQgS6BD2/WVxxqD8GP4lsh3dv3sjFYg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3361.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2616005)(66556008)(1076003)(956004)(86362001)(54906003)(8676002)(5660300002)(26005)(6666004)(55236004)(508600001)(6486002)(2906002)(52116002)(7696005)(6916009)(316002)(36756003)(4326008)(8936002)(38100700002)(38350700002)(83380400001)(186003)(66946007)(107886003)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zjscwiln+0t2EQwSO2P4kbsPx3iCh1Q2GGsfHQTj8lCPtmpLIvwQrLX8zbsi?=
 =?us-ascii?Q?5oGe/PZmjHi7buMnj7441tSix7l6k9nCfk0o+C14fd2qYVPFmArxAYSgtu1u?=
 =?us-ascii?Q?skQY6ND3wpkHmnoyqOB/Fsy6fyS21ZheAqcompBf0BNPJ7ivy4/94gXiJXUe?=
 =?us-ascii?Q?DH7fvavfqrnaR04bkjl1gDYKbkPdBnBAB5DNbOqhQZjVVai5ornOnNlyRdSS?=
 =?us-ascii?Q?O8FVgQ6MuFdcE7eVtJFhbx8TSSbm/74zIm89U4iSWECLWDJhLViJnnAc69Gw?=
 =?us-ascii?Q?Qd/lQ6kzRrPXevhHcxGn2pGWEkNj4/drsIUVK1rHA+ysO/mtxpQONa9BsK5n?=
 =?us-ascii?Q?SU63Sk1gwxTpkLjiC9liEgFxCYM+/ufCPwESr0LAf6PY54yS6CLtNv2O72Nj?=
 =?us-ascii?Q?gkOztTS6wbSvDr4z4Dqph6zWYKb5mH3LgZKMXsMmtHSKp0kTBpezXZqsdRLx?=
 =?us-ascii?Q?vYnHHznlSgCQNA0D/HktNQegoSB/ukbKgxnvpWI2EXokR1hdD8wrZaDolx+a?=
 =?us-ascii?Q?PiIMsvdKgQ70Eajiwm+GZ96OWq3xIAO23kPwp3dqPWV3M5CaRb8K/AMDeQhB?=
 =?us-ascii?Q?C7uTTSq8rBWGAJboeqUjSknGyuEJ5W0I6Q4WoQEq8KoxVgWFjSQzmsN8xep8?=
 =?us-ascii?Q?Bqua+1MIq/VXhlZi1r1hz1TzBuql5A44/RklNxQprUke5B/eYtIw78q5MiVk?=
 =?us-ascii?Q?Ky+szdpXyy83O8tPRAHPKHTGwgWQNTau6wsW9cVkHH9vecnn+p+XjbJOsFl3?=
 =?us-ascii?Q?usIJ1euwJ8jEmHJn6gRjbv+NvYrnJeI2d8mK7RRDIC+eFoAgirvMqxK9vYSi?=
 =?us-ascii?Q?srcE5FzVZrB5B9y9FN/qA8lwI/qeybXHCpqljwLXQfQ3mTWOv5ZGxdlOdOYo?=
 =?us-ascii?Q?5rRqs9tqZYLxjrrGXCv11bUngmnmXhZzdu/JFvk+bSI1uVEoLm9rxz/9xL0G?=
 =?us-ascii?Q?d4a04lv1btm111T13jpQ+vxZZItaVSkzpsDN1v5Z0xnWvJl+I/w5BsiSpynY?=
 =?us-ascii?Q?RdD8Y4ANU5SNQN1m1VfTp3Twg74nQeSO/fl38bjF77Iy9GtOtIUlogRNl9+p?=
 =?us-ascii?Q?r2SbnERpefMGjrjwpVUao3EOqtX+rM00UxTwTxTBPDCrqViQIH8jKP26LBmv?=
 =?us-ascii?Q?13kolqMgoDa2acdgRC2qn1pc+/f5epOHQrMqKpv1d+Lbl+YPS+mmHolFCwCG?=
 =?us-ascii?Q?bCZ3Ae87S6tEWNQ8UXxvYG3hjwTkM9Xe4O3OW8ytH/IEsCOi8KWFOe6OYZX8?=
 =?us-ascii?Q?5lVOJZIzJrEnkXSJuwTWk4XOZfU8qXyfVMSToAxb1pbor4qYmL5GAAX3bFA2?=
 =?us-ascii?Q?HD0S8LzC08C3wrqr8XQbC0oOL1gC6r2kGmB6nX/fO7fo9zg9xLxNFT9ZLXk3?=
 =?us-ascii?Q?17HISuUOzsfoskeOm+Q6K9U7MusKV9fPiE7FRd+5mJHPPWpZWJHEpFooYxgR?=
 =?us-ascii?Q?KhaPtIUMXHTYOTmjFYIFq2o5mZbhqmJ/jE8ntq3aArhix4lLtkTxLqFYe49M?=
 =?us-ascii?Q?2h8ExLmbvpi9B5+q42UDKSuWEN9v/M+A7FO5y4PiX9037lht+sign/n0nzrq?=
 =?us-ascii?Q?P+lyQG240nL3Yq//504pegxg4zFEvSxyh8/aqQS82rWMvFQZpxeQX5QdvSTC?=
 =?us-ascii?Q?SI7rz2KFpFlSoOs4+zN+OtA=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb1a2139-04bd-4608-a281-08d9bbf2236d
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3361.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2021 15:31:30.2871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wp6hYLPvBEb8xpdQoVkWMlPIu7oxa2arXAbWGop4iYGZP15EMBBvmYnAbNxzM7Qb6SVnuMjB9R0Lnue5CBOqig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0019
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The git-p4.py script currently implements code paths for both Python 2
and 3.

Python 2 was discontinued in 2020, and there is no longer any officially
supported interpreter. Further development of git-p4.py will require
would-be developers to test their changes with all supported dialects of
the language. However, if there is no longer any supported runtime
environment available, this places an unreasonable burden on the Git
project to maintain support for an obselete dialect of the language.

The patch-set removes all Python 2-specific code paths.

This second revisision of the patch-set is more tightly focussed on the
task of retiring Python 2, and excludes previously submitted patches
that contain other tidy-ups and bug fixes.

Joel Holdsworth (3):
  git-p4: remove support for Python 2
  git-p4: eliminate decode_stream and encode_stream
  git-p4: add "Nvidia Corporation" to copyright header

 git-p4.py | 132 +++++++++++++++++++-----------------------------------
 1 file changed, 45 insertions(+), 87 deletions(-)

-- 
2.33.0

