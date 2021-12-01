Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 904D7C433EF
	for <git@archiver.kernel.org>; Wed,  1 Dec 2021 08:53:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242238AbhLAI4m (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Dec 2021 03:56:42 -0500
Received: from mail-eopbgr00072.outbound.protection.outlook.com ([40.107.0.72]:3017
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236947AbhLAI4l (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Dec 2021 03:56:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YPO0zadpPSpjvnumXkF4BVv3CeWE8ebqWvzxyoBSKynrx2ZVcAS97bJayXGLAp3PpTaru4KkMICkN8b541Cx3GDUchUwoPkvBTyMvcHne+SHRBcwsfIxqyVOoHmazEi5AYGszWbVx1h23EnBKpd6saOPcUzl9Oh5om9z7NAnBsb1CDvsN1D6CA9taeBq3++yanl7FRqPkyhKOr4N+41hxj+fE2rojd8BrQRsQo/p9A9m3uraNRQIGqpE8HrI3NiR3ovnYmtsBLJJ/MiytJ3W4BKbSpPCmZgHQyt7v/pWEuycntthkh31I9R41UKSCPb27wOrMfYJxA6iXBMdun51Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=43NZnd/N3Ujl1k4oBZy6ksiJDCFYYdsc+Q1HhAnnAuM=;
 b=hVwdlvz/dsyvLGO/PMUXPJa8aZUWSKqoseMV1oLzhOq5JfdcV9FqUCzHxDL7kkVCJJFgGAw1PLBcs09M7iDdpIz9Cn+s3khIUYNeF2jsmNGHNYX/C5X+wpkL9KtMcy+6p1+zMj0XqFLFpc3ZxouYHt/BCbCREnyUGiJrYPowzR8whcYNg8u9xAiAZzfG//pah6mdwK5YnvJ6XK6n1ursCP8Z1D6LuN7ajXMj7WDXfx0/bDD/ZSCkC38ntFLaKe9VZcd4P9wBt9LIKcP/FsbD46QB3Jyonilkal7V1D0Ef2So4fcqq7BC3i7efATHliwy2IYk9ChC1AXEszkZ3hDk0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=43NZnd/N3Ujl1k4oBZy6ksiJDCFYYdsc+Q1HhAnnAuM=;
 b=swSjxPoVh1geL7fGwcwlqhg0rwjZIp3yqf3yAwiKKU5KrkHhTr2DRKO39k/C238k1btt0Ef0Q8Feh46f68vWzl9Mx1nazeGNSbE6H9WTWNzdXKw5LdprPlRtTxd/HA0hyrpfDT32sB0q/xFx+/ea45vdrrwdgyoTLVojTZ8x+S8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PR3PR10MB4157.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:af::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.24; Wed, 1 Dec
 2021 08:53:18 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d9de:b41b:461d:fb5b]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d9de:b41b:461d:fb5b%8]) with mapi id 15.20.4755.014; Wed, 1 Dec 2021
 08:53:18 +0000
From:   Fabian Stelzer <fs@gigacodes.de>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Adam Dinwoodie <adam@dinwoodie.org>, Jeff King <peff@peff.net>,
        Fabian Stelzer <fs@gigacodes.de>
Subject: [PATCH v4 0/3] test-lib: improve missing prereq handling
Date:   Wed,  1 Dec 2021 09:53:12 +0100
Message-Id: <20211201085315.576865-1-fs@gigacodes.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211120150401.254408-1-fs@gigacodes.de>
References: <20211120150401.254408-1-fs@gigacodes.de>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM5PR0201CA0023.eurprd02.prod.outlook.com
 (2603:10a6:203:3d::33) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
Received: from localhost (2003:ea:5820:600:c042:75a0:fd5e:1472) by AM5PR0201CA0023.eurprd02.prod.outlook.com (2603:10a6:203:3d::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.24 via Frontend Transport; Wed, 1 Dec 2021 08:53:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2652765b-cf63-4796-35a3-08d9b4a80543
X-MS-TrafficTypeDiagnostic: PR3PR10MB4157:
X-Microsoft-Antispam-PRVS: <PR3PR10MB415744D2D7460F273611C26EB6689@PR3PR10MB4157.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:489;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jw/0n6XI6kNFRfQ0533VmHJFBaJcf20H4gr9UaGWo5QlNSZbxRvhiESdpqOggJ/JCKVRhElMSnnqkKLXs323azoq80phoKKDmr50dQDSQoqVGrv5A+a+75pvK0NHuV2bUSW+tOXKXNHnkRSQTsKlbA78SR3v8+gALgp3p6ZO0wKPzp4PFpZPcm7chmwhpe+Y/dzrY0TJH4arNvFiiGxbPHokmShkq1sYGuJ2hu+eOxD8lduTGw9oSOjblonb/cwM1Tehop7cj3CVMc7j/0JVXlm6drtA6pufqLusV0rj6bDNuFWGucw/U9b0tIa8+nJebmwy3+rD7SojzBZLXiCQ31bUDKJObSAoceLE0HHLHa07WNaPVo4Y03ED2qTh+JUl5r/UywUeTQveBMEE8X6SQlLitV9MZbpSiHQMR/nc7HkZvav0NPAFSY9OZuCmqsW6MJUwpXJ6fU2HlWkfiMZkpRsa22F/gDUBarX08G0E4yNZwyddTae4W9jbnYftu+6uu7lF3Q7krToXY6j2i05PYkj46VuaSAvJYO/6eXOqwEXvnpDYDvWC8QXNYwRUp85S3PrAGGc4WvaGJkUQ8L5748OUwyTiIH1Rkwk8at+DgETKErVflvKH6W+50FXJ/DCnjziK/ScNyKGjv4LuhGOufn6oj5tw5bqLnxsO6aDv0ZBBuYiF+EpC7AogXaklBZasPwPCUV5QqAMGW/fcILvWAMNFow11Kh9jtmD+DSj9Ieo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(366004)(136003)(39830400003)(376002)(508600001)(66476007)(6666004)(36756003)(66946007)(66556008)(966005)(4326008)(38100700002)(2616005)(186003)(6496006)(6916009)(1076003)(83380400001)(2906002)(107886003)(5660300002)(8676002)(316002)(54906003)(6486002)(8936002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XGimjzxOBCcF4JI9XfJs1GjewMQmeNSLWA8wX+1nB/wn8nksYo7zy/JBWE4+?=
 =?us-ascii?Q?bWPZDtz3xOhARa/AJt3n0BzRUmMEsM00Ji2r4GuXdt7oMTR0hmRP5zY1wQJR?=
 =?us-ascii?Q?wMonDD/mHac82IZ5gdHbD3xFFY4HpeVVsqh6AWjQ0v/8Xop3OcsLkqqebeSA?=
 =?us-ascii?Q?lzFT9MCmSoxcqbIaqdeuHAkyMW35ZpEyDs5kiSHOtuX+QXIVkA/LPzt4PSiJ?=
 =?us-ascii?Q?Fo/7XP+finDcggq6E/Ik2sV4TyMlmIzEbT5lsc+6DoVkf9epG1d1vyrBOIt/?=
 =?us-ascii?Q?y59yXIzCFNHZ/8+7/ZGEu08Y0QG++e3gV9wCtz/04JGQIXnxrrJkeDYwZxeZ?=
 =?us-ascii?Q?6RLDD2/t+Z24OsgPpbiHv0pniaJ7JFT++bHj3DhWYe49031arWLGpRTHnAD5?=
 =?us-ascii?Q?Or4y56UUg7Ldb9lrkdNTsi1GoKiaWxeQrEEbmjdOHV/Ezb2tZrjLilMyuvzJ?=
 =?us-ascii?Q?uAPo/lc8QHNJG4K11+JxvtaF3Xy5p4AOi7CbY5RF0xwTfQtbHzb5YmQ9MBiT?=
 =?us-ascii?Q?VotTifmyt1I0NMUuINpv17lreuhjx1q2LgmFqqrxfsIEiMJPIkwgDrwHxmm8?=
 =?us-ascii?Q?IUnZVCfpwS0GdB3vcbTzkAPqa/YJdTc8tvBTOC+miodop2XMzNH0BpMYjQtO?=
 =?us-ascii?Q?W+rQ/0y7URUsXZYq6SkVN37IRe2LY5afrcwUEzf+Th3d+wN+cinzK1zAIFfr?=
 =?us-ascii?Q?w0GCqA0EhmGC2E3FPMwaMlhL6speVhYfuWIciijCfcT8ApbuLkGR1jRLsXK2?=
 =?us-ascii?Q?FLtyZItrrlxiDW1WAhPeWAy57mJOoyfxqvRTXlNnFtjo4mT31Va+Cox1S7k0?=
 =?us-ascii?Q?CwCcd7e+4yolE40CBJjbqsIywz68kIibVNKc+e1HlpSOxG7jzDJNEd3uSaeG?=
 =?us-ascii?Q?imdRwtw5U83roI1ajzXysRYT8482zm5s1hmFhC0x+6Mg4sS+ItdsOD1qoVud?=
 =?us-ascii?Q?LdbLaRapKpsF9v4jLyIqCUd9FPjBlfVNSjSgTGqlxRdlRqJ4mFPHVGSs+bX0?=
 =?us-ascii?Q?KkgQiOpJFnU/ZeULS3EcLyTUgocq1SnPMfEpRAxA0mf4u9sKG8x2dnslVfa7?=
 =?us-ascii?Q?0gjBWLQ6K6xaWLbLQ0zWfe3OHHvNqwZN7ZEotsQD3vTnMoZfgboUD/oi1tD2?=
 =?us-ascii?Q?EKKJ6KhU/uFrRagNjfZusIU6QxtFuWHLASgCHqT2wrDwTv810Xn48hAj/Yvh?=
 =?us-ascii?Q?bYeHrzZ/+HKUtpS5n45A2T3S6bV3A87c9/X3mEPOX7g5Vafuq669a220sYOt?=
 =?us-ascii?Q?fX+IS2b8rcm/T767rvZoZtVD5MmeTi37wRgcqQQ+YCeerOQgSpbfUSDmwyio?=
 =?us-ascii?Q?poEkiTmmRYGzjmd2+d10E44CCV6u7omtbxF0SgktauZGrkfV1PjpmFYNXj2R?=
 =?us-ascii?Q?0REHlZMSvSWAiJ6WuSRLvHcSgmbB+Rg2/TqzDAbtvLBu+Bc75/ZteK0t9Rlm?=
 =?us-ascii?Q?WJIIxCckhkat50Z1mKIybnCNf3B/WPZoSdlXwBASDiCPL5tAd72DQOa0lh4N?=
 =?us-ascii?Q?RLKIgtCi4s4UvOJMvCi4P/TJvXX1uzMn0uIyLpfhsK8kxweDjupG3+bXEpLs?=
 =?us-ascii?Q?Fu9OmagqqoWuXwvjO8kz/b6hm9BfW841klxDPagZ5wrheoqchPISQLEF5lof?=
 =?us-ascii?Q?zxaveRyHkpGLwwVUsNiTUaHi6XU/Tw+M8SsFDMY2CDgTOZ8qzP39Zb7++lW9?=
 =?us-ascii?Q?hLynK+ruc89JaOBZjvD1JmKF/8smR6J8yce1ZbGd+Nt3R4FAJL5Gv/bK03tR?=
 =?us-ascii?Q?GKHXEYGEdaveeKYYmn6yo7bs3sZRWzE=3D?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 2652765b-cf63-4796-35a3-08d9b4a80543
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2021 08:53:18.6656
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ayXnK7wm8QLO5Fn9ujVueq8hvKHZbcdvI5NWOTHcXV+aGub6tk2GiFKibSZ7MvVjVhCMbKTQxDXHiDvrqs3kmVVkHdWDEiSslGB3kKwHDQI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB4157
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The ssh signing feature was breaking tests when the broken openssh-8.7
was used. We have now fixed that by checking for this exact case in the
GPGSSH prereq and I will improve that check further in a future patch.
However we are now in a situation where a broken openssh in the future
will result in successfull tests but not a working git build afterwards
(either not compiling in the expected feature or like in the ssh case
runtime failures) resulting in a false sense of security in the tests.
This patches try to improve this situation by showing which prereqs
failed in the test summary and by adding an environment variable to
enforce certain prereqs to succeed or abort the test otherwise.

See also:
https://public-inbox.org/git/xmqqv916wh7t.fsf@gitster.g/

changes since v3:
 - reword comment about test framework fd setup

changes sinve v2:
 - use a space separated list for GIT_TES_REQUIRED_PREREQ like we do for
   GIT_SKIP_TESTS
 - use BAIL_OUT() insted of just error()
 - make BAIL_OUT() print errors even when used within prereq context

changes since v1:
 - use \012 instead of \n for possible portability reasons
 - fix typo in commit msg

Fabian Stelzer (3):
  test-lib: show missing prereq summary
  test-lib: introduce required prereq for test runs
  test-lib: make BAIL_OUT() work in tests and prereq

 t/README                |  6 ++++++
 t/aggregate-results.sh  | 17 +++++++++++++++++
 t/test-lib-functions.sh | 11 +++++++++++
 t/test-lib.sh           | 25 +++++++++++++++++++++----
 4 files changed, 55 insertions(+), 4 deletions(-)

Range-diff against v3:
1:  35c92671e5 = 1:  9617d336c7 test-lib: show missing prereq summary
2:  d6a53f0980 = 2:  409694823a test-lib: introduce required prereq for test runs
3:  de21c484d6 ! 3:  3757e4e238 test-lib: make BAIL_OUT() work in tests and prereq
    @@ t/test-lib.sh: USER_TERM="$TERM"
      TERM=dumb
      export TERM USER_TERM
      
    -+# Set up additional fds so we can control single test i/o
    ++# What is written by tests to stdout and stderr is sent so different places
    ++# depending on the test mode (e.g. /dev/null in non-verbose mode, piped to tee
    ++# with --tee option, etc.). We save the original stdin to FD #6 and stdout and
    ++# stderr to #5 and #7, so that the test framework can use them (e.g. for
    ++# printing errors within the test framework) independently of the test mode.
     +exec 5>&1
     +exec 6<&0
     +exec 7>&2

base-commit: abe6bb3905392d5eb6b01fa6e54d7e784e0522aa
-- 
2.31.1

