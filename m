Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 234F6C43334
	for <git@archiver.kernel.org>; Thu, 16 Jun 2022 23:20:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379208AbiFPXUq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jun 2022 19:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbiFPXUp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jun 2022 19:20:45 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04olkn2010.outbound.protection.outlook.com [40.92.45.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5342962A2D
        for <git@vger.kernel.org>; Thu, 16 Jun 2022 16:20:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gnfKRi5IcjnbpaHd24fuBNvd4yqsLom1T4iJzy2bg/GaDOcVSN1L+PqjSRCHMRiR1jQLbdzStwpsMKBAbdm8Cu5H8wGzQq39T8HOvWYmIZeZSWmIIsOAGjswjWLpU6CP6ba5JsNRF9YuGnXlioLt0dsxcmnxA4Sl/0oFxoMQJbRagLPpXmW3cbserDHipJiGliX5MJCu+1Z+DfvhwBzG6IyFGmmoQ8/no4NqtynkIrKsptUqUL10j3zrMZMaZoC/oa77CF/PyobcxIkJHJKCNPeS/zG+9+uonER6/vpZ1zqlkjxb5mZhyvthMqmLJexbwodGo/vzqdRysG6M1UsWIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vbg78Tf3BzAneKZJDZonopmR2fQoxoJcjNqjinhezO4=;
 b=j3KjdYRugFIEbqZvLqPvttJDvAZH/dKb6M22Xm04AZVzlfT5KawMs88wnIr2QiXUb/5ZVQor4sbXrQ4Ckn0U04D3FgXm3yl0DQLu2gyh/0vUYyQmABZddcOHZbbbHkVzrif2b7lJwCE2oKQWt2ZoMrQmCNg7RJhwL47SmnXSuLhfdCljEv47+5L+efshxge8deCWLcd/Q52Eb8fWB1Hwjz3qhxjc7A9U0jkvxkkQyXZ+emYodVWWHRn0f8s094hHhcvGi5dZqcQZGBLz8EVL/0gLjywVvlnsqZp8uPHIy/Ed24tDv9uAmoUkfEE0DYu7+klC3Ig5rLErpSpCgbhG7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vbg78Tf3BzAneKZJDZonopmR2fQoxoJcjNqjinhezO4=;
 b=XIj7wRUNi9J5e7bIgASr1pVB/NhE1jfeJlO0Y38ggbKq5fLAW5nTnAl4J6677IS7Ro0wEDIafLWvHAFV7V0NVyc64ZGpmrYBgZKlynSv4F7+gBkT4w+mJP01fHdMIl91gIUppQxrhFUEcvJ8eljDESv5I9+Jgmk4k+k5nOtPIi1kIQGRUA6e6aw5PEeqiaUGttnhTbJCvi8iDmAoJ3Psqn3oi29OzzmusjLBb+BQM3HJ1KkKj0xEfI86diqjb+zRFgP3cAV1h8VNDp9GCKIB9i+no7mD/HXOZzttNT6+rW/CjplMUhUlQP/njSx3Ea2kWHR3/KvFjBW1J3Jr5zQv7Q==
Received: from DM6PR13MB2987.namprd13.prod.outlook.com (2603:10b6:5:6::24) by
 BLAPR13MB4659.namprd13.prod.outlook.com (2603:10b6:208:330::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5373.9; Thu, 16 Jun 2022 23:20:42 +0000
Received: from DM6PR13MB2987.namprd13.prod.outlook.com
 ([fe80::6cd3:208a:c0e9:df97]) by DM6PR13MB2987.namprd13.prod.outlook.com
 ([fe80::6cd3:208a:c0e9:df97%4]) with mapi id 15.20.5373.009; Thu, 16 Jun 2022
 23:20:42 +0000
From:   Goss Geppert <gg.oss@outlook.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        christian w <usebees@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: [PATCH v4 0/2] dir: traverse into repository
Date:   Thu, 16 Jun 2022 23:19:54 +0000
Message-ID: <DM6PR13MB29876A53962557131120EF619DAC9@DM6PR13MB2987.namprd13.prod.outlook.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220505203234.21586-1-ggossdev@gmail.com>
References: <20220505203234.21586-1-ggossdev@gmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [ZACL3LSxa6Gxeb42yTqQynu4z4eqeq1z]
X-ClientProxiedBy: MN2PR06CA0028.namprd06.prod.outlook.com
 (2603:10b6:208:23d::33) To DM6PR13MB2987.namprd13.prod.outlook.com
 (2603:10b6:5:6::24)
X-Microsoft-Original-Message-ID: <20220616231956.154-1-gg.oss@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 77ce9f9c-99e5-42c3-5048-08da4feed532
X-MS-TrafficTypeDiagnostic: BLAPR13MB4659:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6T9eivlUVqlfuOL5Mj5pX5GVT+6PUKhJnpKrDl3++0ZanV46o2nYdbzjh+HbcILJePaucYsHaI+HvvTn/sNdlFU2e1fbYePIrIYG9lxNgRkksxqucSLheLe2ZN+rTiVb77X6QLxa05Or8xZCSGjCW9Smc3OnwVkgwD9QHJhAmr9XFhJu3NF3kHY0dIn5sCe3HCaZcVy+rIejOj4s3vb//HzUT7iQIThyiAq3llUdVymwY4qtdbVbQRr2MAY9av+ryC3em5x0FVGIm+/pwRtxblqu6OsZ2cft8PFg734C98Upc0UhEztCGxmHdaBBzrzWARnyQpB0HUuz23IQaj+ND0nru6DkyMqzr2EFNgp/9TEdAlJyC0BS9MvaWO0RIbgjz21JKwOoqDjWPF4gDjbeygBtTXU2yAfwpt86YnnfTUk99x5BpMUviySQb9X91LyNi3CwKyGXNPPcAb6EwLT33PdD/QPWL6gc1kTCiQFHACoN+YLDTkVjplhqOSwSDhBmjG00djyHsTqow42+A27XCL+/RY9yZnalUTtjJsrh3IZdkvqG+pMw0uC56J3ePATm/lLq9VS+X12L2IhdkXCubg==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ItrkGPWy/yOlHVp6vxnk/lwLJHPNSH4JQBVrghFiup4q7jW2ey0vt+FSIOtN?=
 =?us-ascii?Q?1gDtBdXXZLG4FTKxXE7jq0InxE+Fb64CpJbXLhLJFvg2FRawU30iZEOLoGkY?=
 =?us-ascii?Q?o5JhQ5gyVrppuQn+08ARvr0MQet8oxyGSgj1JsKWh1Joc8yF8KYIjgCxiod2?=
 =?us-ascii?Q?HKX9ZU3XvRv4/y7nMdIGwwn3Kvz42rhy05Nuo2ZXAyYr08K6/ytgdo+QOJky?=
 =?us-ascii?Q?XWqlbzfHo7MGE8X9lxYZX20Ix/uQKHt0VDpzhrHJ1P5srF53/tXyce1vMCc1?=
 =?us-ascii?Q?p9/cTOBwxs56RTdVvqF8yahWtECu7a0zs9wfmqbEvEEBX1vyJuMLyl83LjZw?=
 =?us-ascii?Q?Dk35RvxEyEGNcsQTswToKTlSOFiUjyH6NLaUrHT/l4wkNcR91hrrp6vBVfkR?=
 =?us-ascii?Q?X3il9n585S/x4QeuGt9U/OiVRu1CTi3LAeBe8yxN48MpA242xpdRD0tiCIxL?=
 =?us-ascii?Q?cMuJQmM+RhQ0qqBuOHiwOkre562kU/AfjScZXyPzgLJ1iELOr+ndlpV7UA4u?=
 =?us-ascii?Q?k79unnZ13SIhR+IzAMz4Fg1+9+P0zeKyJ2uuA2KBTKZlAVUCf9SQ1s8Gqenw?=
 =?us-ascii?Q?z6luBRjjfgfSJ4UZ3LLJSO6AAApd1qZ73EoA8iWjgaBukB/Yij7Xv2kq4fwu?=
 =?us-ascii?Q?wHSd/sKEO5UjpC1kaM2Mn8OvSx4oBg19bEFcLt/BOMwYiBc78ZEjUJ3+9+I9?=
 =?us-ascii?Q?GFu+0DJ8Ui4LJgsrscU316WnFHJt/vWk+8BHLEgk7WgyOm9g/4ZfleaHEaCv?=
 =?us-ascii?Q?KtjcK99Cs3qrp5p7PBFUM0FFMYs+kA0p+OIAe3wVYmBx4+nQjm+A1RlYJsAh?=
 =?us-ascii?Q?xd8UD7O8jCbX3WUEs3JGuQYxmZFQHbDBxPS/M7GjJcmxzRO6cWNXVyUb5/Io?=
 =?us-ascii?Q?YZAxlP0LDzANoVXfifvmGPfYHXcWGrwZmbLiWo/tB2OSyaKhhHSKKCqzrJfJ?=
 =?us-ascii?Q?9qBcM+gbnTtF1sormoDaKMaGFRuLvBafgpsw4rLHN+yz56Ubqn7ews8grcof?=
 =?us-ascii?Q?emRSb4VKVyUK5ouZsEvudvw9fNmJdevneg+yyYe+prQytQN4kIkjXiRijNR2?=
 =?us-ascii?Q?amhezmEEiU27qt26fvZooaDlJB1kHgPyGHptApaPChm/+ItkrhTgzlldwJ4t?=
 =?us-ascii?Q?UBxN11Cp/VqfhEUbQ8BrS0Q5tqF0PbV9QbTHOoXxWqJ1aVV/B+deFYvz+yyj?=
 =?us-ascii?Q?cRY/oYbZTI+HbTDFWjW0lPL26OLTPM127Oo2XYzqelENnGEkf/pEF/mCytEI?=
 =?us-ascii?Q?AGRNtyFh6UJD8cFNScp1+8fGmjdlb/KpOMBP52TzyqeStPzS/dyLtTX59/I/?=
 =?us-ascii?Q?N/qfcS5KX5aKpOV3xCyJx5v3EIXcIMlh5ZKlRQinU0B9U+7tQ2bQuOPvaRMr?=
 =?us-ascii?Q?pC05HYyczH599hW+tT/u+Ycs1e+HDIV5K3yA+nhDWDjZxpa62/7ETsM1umz3?=
 =?us-ascii?Q?lbQys+Ic7IM=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77ce9f9c-99e5-42c3-5048-08da4feed532
X-MS-Exchange-CrossTenant-AuthSource: DM6PR13MB2987.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2022 23:20:42.9157
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR13MB4659
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Goss Geppert <ggossdev@gmail.com>

This latest version of the patch series contains relatively minor
modifications relative to the previous version.  Let me know if there
is anything else I need to do.

Changes compared to v3:
* remove the commit that caches the gitdir's realpath as this was deemed
  a premature optimization given the amount of code churn
* use git option `-C` in some of the testcases to avoid creating a
  subshell

Goss Geppert (2):
  dir: traverse into repository
  dir: minor refactoring / clean-up

 dir.c                          |  35 ++++-
 t/t2205-add-worktree-config.sh | 265 +++++++++++++++++++++++++++++++++
 2 files changed, 293 insertions(+), 7 deletions(-)
 create mode 100755 t/t2205-add-worktree-config.sh

Range-diff against v3:
1:  0fc8886f1e ! 1:  f84cefe731 dir: traverse into repository
    @@ t/t2205-add-worktree-config.sh (new)
     +	(
     +	cd test1 &&
     +	local parent_dir="$(pwd)" &&
    -+	(
    -+		cd repo &&
    -+		git ls-files -o --exclude-standard "$parent_dir" >../actual-all-unsorted
    -+	) &&
    ++	git -C repo ls-files -o --exclude-standard "$parent_dir" >actual-all-unsorted &&
     +	sort actual-all-unsorted >actual-all &&
     +	sort expect-all-unsorted >expect-all &&
     +	test_cmp expect-all actual-all
    @@ t/t2205-add-worktree-config.sh (new)
     +	(
     +	cd test1 &&
     +	local parent_dir="$(pwd)" &&
    -+	(
    -+		cd repo &&
    -+		git ls-files -o --directory --exclude-standard "$parent_dir" >../actual-all-dir-unsorted
    -+	) &&
    ++	git -C repo ls-files -o --directory --exclude-standard "$parent_dir" >actual-all-dir-unsorted &&
     +	sort actual-all-dir-unsorted >actual-all &&
     +	sort expect-all-dir-unsorted >expect-all &&
     +	test_cmp expect-all actual-all
    @@ t/t2205-add-worktree-config.sh (new)
     +	(
     +	cd test1 &&
     +	local parent_dir="$(pwd)" &&
    -+	(
    -+		cd repo &&
    -+		git ls-files -o --exclude-standard "$parent_dir" >../actual-untracked-unsorted
    -+	) &&
    ++	git -C repo ls-files -o --exclude-standard "$parent_dir" >actual-untracked-unsorted &&
     +	sort actual-untracked-unsorted >actual-untracked &&
     +	sort expect-untracked-unsorted >expect-untracked &&
     +	test_cmp expect-untracked actual-untracked
2:  a80cbd5517 < -:  ---------- dir: cache git_dir's realpath
3:  899c69300c = 2:  d4ff1bd40a dir: minor refactoring / clean-up
-- 
2.36.0

