Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59ACAC433FE
	for <git@archiver.kernel.org>; Fri, 17 Dec 2021 14:06:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236942AbhLQOGX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Dec 2021 09:06:23 -0500
Received: from mail-dm6nam11on2049.outbound.protection.outlook.com ([40.107.223.49]:17684
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236939AbhLQOGT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Dec 2021 09:06:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iaqERpuZXq5WMsti+WxV+ePJrCFWWOfkp6TjzYQ0SKIDvZs269wnyWTCB+ocLurbNDpHYEiWXejU9f4yYplhvgt6kyZ5sgYrb+tEI0uTC0c02ngfWvPdffnErekl1w6oovk4IcY+PGMjAz+1NMCz+pK8GSucaQYM3QUrHUU49SotjR+uBKcGgkInC3Cl/xbzNf3z33tFlbg6Z+e+2b8F9Km4g4R3zPpyCFRYH2dUcvjSlJv2mKqY7B0N0DIDxTnmXM3Q4Oi3gAQ/SzWGuNtnPBPlffgCkpEC9atoL1XN8QbYcFb1pdgdFQleQvO4/K3lICmbBUCgfVNWRQxwagf05g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z2tDLoblOogcYEdwOAkg7VxZwIncAKfXbNa3Oex3wGU=;
 b=kDGmxxe1KexOXiKTv7Cl+3A8CeiAWaw6H2j+c9KICfZyxvjr2Z9AEkupQlnsxkPQrlRSwx0UhGb4Srw6Q7clDMnN4OppxXO9MCnWPwKDfNghOVSVqazr6iyZg4kVvqABuqvDSLtNpOlLGwsHN1IdFiJAobys0GcOxbtAd2k0hZav/Cj0O3UCeZqCYMV8CJPCs4Ha0NliXp8hJ1l99bP7rsIIFb8kcHhA3LWKlkjiZbzDQXHolUXlbOFAlgK+HrWjL0xp1FAP57zFcbxBvgAUxsq5Zw0gCBLVTNxrHzcl1jwOqQ6iCKKwXXVsNoL7jQ2g01rX4vuvpymZFM28uMKbJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z2tDLoblOogcYEdwOAkg7VxZwIncAKfXbNa3Oex3wGU=;
 b=RRZGXR7FaIDcyPXt5ztXgx4fPsiZe2lf3pH6o13Br+nLp4R4oqetBFU32AcjrEw+xPDysUUSTZinFUrPzgQ+CzFLxeituocpzs2wfmG6LVwd/3UK5Xd39HApDtVdRCbdU66EPLiu3F+Ut1/w+HxxHkSm3Qtms6UDFi9Vln2ku0S6EjUTRjF1cNGnwUEsVLdAq7Ao1I+I3w34jpaG8EElrPU9cC6LpfyGzeWtRijSDC6Czs46vm1tXxE4cjeA4Dg19aGtA2rxhaSIttnBBtNtEzVQbgSt4S1dgQ4kSU4gCT03fSAQADUa+9Nl4/uRay0azevN1sPE7LuxrDhVhpWjHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN8PR12MB3361.namprd12.prod.outlook.com (2603:10b6:408:67::19)
 by BN6PR12MB1250.namprd12.prod.outlook.com (2603:10b6:404:17::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Fri, 17 Dec
 2021 14:06:17 +0000
Received: from BN8PR12MB3361.namprd12.prod.outlook.com
 ([fe80::4063:6e26:a906:e592]) by BN8PR12MB3361.namprd12.prod.outlook.com
 ([fe80::4063:6e26:a906:e592%3]) with mapi id 15.20.4778.018; Fri, 17 Dec 2021
 14:06:17 +0000
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
Subject: [PATCH v2 0/2] git-p4: remove "debug" and "rollback" verbs
Date:   Fri, 17 Dec 2021 14:05:45 +0000
Message-Id: <20211217140547.2115095-1-jholdsworth@nvidia.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0128.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:e6::45) To BN8PR12MB3361.namprd12.prod.outlook.com
 (2603:10b6:408:67::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ed3a8ba0-0e9f-44d1-997f-08d9c16664d7
X-MS-TrafficTypeDiagnostic: BN6PR12MB1250:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB125076B94F5D7A14C36122BFC8789@BN6PR12MB1250.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bhBdhVH3St/2DHQRO3zOxfczkxPifplOat5tOnnxQ6qk5UX23d5/Y2D6itIF3+NhIHBm3NCC59YFUYgd0qi/9WND8usNteUbbsuFknXDsBcPT5f5DbK8Sx8jTkqWmIL6f4oiWPHJkGrbtNu6/k7QrR9z3HdjKG2BZUL+kMmihGBJ1A/MSaEbMP7dzNBMG4DESCAI7OpankbWBoI660ySJ2y275N/WJZfAdpehDy2ReDD/iydeiQ01Rf7f2JPfNmTvcCvQulCyPQnIlaSIRDcuGg7TrNA+4shK59lwm//Q4Mu54swNXhYnrOlML/+cgDNidoYjEc9VVTJdPM8Kcy+Og8fwn/28b3gT+xZaZHqGXjV/1LGJyZbDeiw8FaoMbf0G3XuvpEby2+5nEfARJrATP7JsOxquykSMjXswLYILBBIrqvI4zujAm6TbjR1g+Q9xEXqYB3JkT6KyKm5jakcS5tzLQs6rYyDFNHZGsfvWlAEfPQ56KN53cErrPBhHAeH97AMHy2uU8cBgVUcrH9FRA/bDe8Upy2chjEyLhTCgKqZKMgbWr5Qg25+9TAoHyIPH/ODkaSAV0AyE7PTkT+1y3uqEBjR8huodIIB42K+jqzY4suvNrGl65WvQRvdIgEAy8ygsAMQtdNuoehPYBTITLQ44l64jghnnZWaCflh3gL0L6RI7zi+dk3s0S0JAMzVQMX43grjL+RIbjdFIVtpdQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3361.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38350700002)(38100700002)(8676002)(83380400001)(66946007)(6916009)(66476007)(36756003)(1076003)(6666004)(186003)(2906002)(8936002)(66556008)(107886003)(5660300002)(2616005)(6486002)(55236004)(6506007)(26005)(52116002)(4744005)(4326008)(6512007)(86362001)(316002)(54906003)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MAKmOBJAyfmyWBAtHlZfHzP3dV6nWmUxk4/jj+C70EQK4l8ivyig7Cqgmq8S?=
 =?us-ascii?Q?FlpCbFSAtAUKbs/Za73Q+Dqfg5JyvAsfgQ8Dnkcss/C+qf/3B92hYhx+wI5s?=
 =?us-ascii?Q?3jL3gXEp9sIsTe4eJq+UDkMbCp8Mj2jcy6MJG+VFhD/+2wBk0RLLIAihNBcB?=
 =?us-ascii?Q?sKBt9lFcncXx3u5GhSFBZNPJZlGvOJR3YXOjqRP2xk1xm6vWxVUbcmEAHPKw?=
 =?us-ascii?Q?bLoet23Dk3XFkX8gLJTBIj81JJI3PJyvP6ntUDhshYEHkRZsMdXkjd7GOjnJ?=
 =?us-ascii?Q?pyZVbX+f9WY+5j3AvrU7106q7oqbSBaGg4HcioqBDTsm6nRcD+oexNFT2CHb?=
 =?us-ascii?Q?R19A7yNOypSXycxKJW3taamVkEw7VBGcYUVA7FB0p8fRwmuOLVjdC/ctUMZs?=
 =?us-ascii?Q?C0SmRGpY7mV6hjaquOyzoBN3eJ1dQ/TmF1rLzsirOZN1d7qbRH5LkglTx2td?=
 =?us-ascii?Q?xHmnbsY6Y+mfIzwfq4vVFEOb3iaByGwFunmyOrkJ0DTgucJI/TOHRcEbPMZy?=
 =?us-ascii?Q?h7GjArbCB+kbVTn5KtZIbKcMiL5OnAiX/mNnBZmur3O0kfUbG/q1VdjEkiaU?=
 =?us-ascii?Q?H45W4ilC7oE4Toz8h6HKILPWHwp2G5bZ5r7CQIaUtwbS2fD6SG8pGkqrhJqb?=
 =?us-ascii?Q?6MxhL8R7lZYcUtBl8mJXo7DyRfbN0iXrCbQzqqR2PJcuOphtJN8AeCs5uDe2?=
 =?us-ascii?Q?tw8R5v2r1JKl1nO1oYkbxCER7GaCED7WVZz77sHEiG4Yh0IOinvnKOYnBihC?=
 =?us-ascii?Q?b0Y5K01Zi0hy7v1oLgnuRJ0/MTM1491B0lMNZcc0xzIPyCxtX7udUmMIjs/+?=
 =?us-ascii?Q?vIg6I6ZVbH0Mfh1/mh7avI9BSSuyPo7PGVUDnSy6raboK5/4uLCDcD1GEc5U?=
 =?us-ascii?Q?KvwjxynEestAxzXtuuc3eB2ZKQrBHwl9b3aSQ5mxA1kV+bQMXQNu2z4gmoK7?=
 =?us-ascii?Q?maMU4BNFlz4+p7Id7401N2fX1FkYYzeQEuCHz2IWKi7lMKzTBbGE5Z8qZV3b?=
 =?us-ascii?Q?ELQdMUdIZqQXQxJ789bXoGl8aHXHS5jRr1QFSvpNo+oOrdWUcm97AvtYBl1p?=
 =?us-ascii?Q?LE8XRyKkL7CNnJG+6FdA5nhUdbcXkIJkshyiOVEWBkgYKEat5bw1k2HM1VYH?=
 =?us-ascii?Q?0pWuroIxN3QtvPFgGsPTQDbaPMZqFSnl9ImumumBWqr22283AU+cMoJDwi1d?=
 =?us-ascii?Q?jbzG7xpvCjFCKEfo4nI3elwLScz0LKBO1s9ROM+rrinFzpvhoIiu2xS0lu1l?=
 =?us-ascii?Q?Kb2dQqi9EY/W1+vr+qy5afFyx+0oFy2qCiFwk5aWtljoYcjaQNnykdbjSXDs?=
 =?us-ascii?Q?/vdNs/eQDr9auj0iSHuDnQIxRbti/kiUUFa1Lqm5kXygZvF1t53Y8G5BGQLJ?=
 =?us-ascii?Q?+V0SKhayr/3sLFdsQMBcqFQiSy/KZO5MWsQrqktxNeYdD4zQYT8/YBswqodm?=
 =?us-ascii?Q?+s+Vk54hU2XDJ6IOzAeAhNngHLUgahX2nB9TVqqief+XzCTZqoJol3RfvyBi?=
 =?us-ascii?Q?Gjz+Wp4l39cXPfrdBzFNE6FaBvV0uVSMqAI0caQSE5A5ndPsjSixjxE1AGWl?=
 =?us-ascii?Q?rucp2MJGyx6pENST1KK4aAf4+QUxYo9ViAj6Qt4EPC6ROKj218f6+xWYnsO8?=
 =?us-ascii?Q?m1x+9MMpUu83Pyx5XBTuaDQ=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed3a8ba0-0e9f-44d1-997f-08d9c16664d7
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3361.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2021 14:06:17.4870
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 276uuSXe1DRyityX3GlRF8IeAStppr4RSU1hBNvn2y9/mjbbylR5i3W0kq0txZsJyw637p4CxAiIngzjAxgh6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1250
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git-p4 contains a selection of verbs for various functions of the
script. The "debug" and "rollback" verbs appear to have been added early
in the development life of git-p4. They were once used as debugging
tools, but no longer serve any useful purpose either for developers or
users. Removing these verbs simplifies the script by removing dead code,
and increases usability by reducing complaexity.

Joel Holdsworth (2):
  git-p4: remove "delete" verb
  git-p4: remove "rollback" verb

 git-p4.py | 76 -------------------------------------------------------
 1 file changed, 76 deletions(-)

-- 
2.34.1

