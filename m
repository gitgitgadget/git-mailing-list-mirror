Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 450DBC433F5
	for <git@archiver.kernel.org>; Wed, 22 Dec 2021 14:56:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343600AbhLVO4M (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Dec 2021 09:56:12 -0500
Received: from mail-co1nam11on2049.outbound.protection.outlook.com ([40.107.220.49]:25184
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237161AbhLVO4M (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Dec 2021 09:56:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nGKi4eFZfoHMkEqJeBANVe3H1CV7X3hUYVK07qJwBIBwtqPxnNZXYikwJtqs1bVhYQUPPlfAK9af85880awPIV1dfVIdqdtqMJUN0wllgTvnkY0e8AsZ3m9JJQGtUPxOUfmPjVVvr5/0R02sqYJAcef54H4789Ts5KJz0pLWfbQ9nsANfLKs8w6wlEdw7Iigiuh3Ox5oJkEVBJUEnsY9jNpMpjMqQMeQn42OpGs8kn0gbFUGEdyk4AVCq+gJLQOTAskk8Ii6y5PqeyYBAkfgRy5IsedQBZV3BDKAK2/sOptPw6HLguKENetDW/HZ76plgp+l5+xg17QchfI5Mgrv2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mpm4yq9TG6LKi/z+jwHTZ+3bkFcvuwqmZUWai52KzYc=;
 b=n3JlEI/DEy9amJ/wvRT89sfyfgDzHHMZ1aSb6RKCF3u14na/LgJ0sp8CFfTJvrsBuUGu9HkfB4/rH/SkVPUl7gwpVU4S8y3oZq4l2qgBXjpohvkF7GQ9t71wpd1m+GV56DAJ+RxjPc/yYjj/DV1PqK92Bkp6pBhDxRGF7JslT/ShP4Ni+vn+IYA9uahe6gybveQ8n4/SUBnRJuGMrhmGG+5y0uKuMMt7/OrR9wU+V9MwMD7+/hnzC3CyvxfZ3dOBRtwsN7PItYvF1iCjTLT/RV0aqSlRRqQGggO+NrrK7tidXzXkH9zztvFLCVs12ykhkhyAPv9o7qZxyi3XxSwciw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mpm4yq9TG6LKi/z+jwHTZ+3bkFcvuwqmZUWai52KzYc=;
 b=ZkBJCgxERAQHOVOpIg+Xlp69hEidInRhQRQrIbA/IoAYYkffEzhM6TfafDm+8ZSb3/kEH1lhzWAZxc8ISdRQFMkWDTSkH0CkqqxaVEccGKBsywsmGWl8CrNmPzNiXeAWpE3jcWWwCDaFcWlfFUw0TGlIJ6YmmIiCLsQ65mlL4MBFL94uiD6ZJRstNVpKcwADsJalOCGl2KEYlRXxgNR4SBPqg8S5pqG/SZ7qGEKz1yBQ6nN1hxjQZ0gP2y5N0wwsAhQnsZ1H1K+0xJ1Xr1+6BKnnS6rfx11Z/jrvfCJQG+PnJhkzL1dL5qafV90Qn980qlFqbeUj9scuwMRllJLINQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM5PR1201MB0105.namprd12.prod.outlook.com (2603:10b6:4:54::23)
 by DM5PR12MB2487.namprd12.prod.outlook.com (2603:10b6:4:af::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.18; Wed, 22 Dec
 2021 14:56:10 +0000
Received: from DM5PR1201MB0105.namprd12.prod.outlook.com
 ([fe80::d57d:8569:57b9:874e]) by DM5PR1201MB0105.namprd12.prod.outlook.com
 ([fe80::d57d:8569:57b9:874e%7]) with mapi id 15.20.4801.020; Wed, 22 Dec 2021
 14:56:10 +0000
From:   Joel Holdsworth <jholdsworth@nvidia.com>
To:     git@vger.kernel.org
Cc:     Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com>,
        Dorgon Chang <dorgonman@hotmail.com>,
        Joachim Kuebart <joachim.kuebart@gmail.com>,
        Daniel Levin <dendy.ua@gmail.com>,
        Luke Diamand <luke@diamand.org>,
        Ben Keene <seraphire@gmail.com>,
        Andrew Oakley <andrew@adoakley.name>,
        Joel Holdsworth <jholdsworth@nvidia.com>
Subject: [PATCH v3 0/2] git-p4: remove "debug" and "rollback" verbs 
Date:   Wed, 22 Dec 2021 14:55:50 +0000
Message-Id: <20211222145552.93786-1-jholdsworth@nvidia.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS9PR06CA0001.eurprd06.prod.outlook.com
 (2603:10a6:20b:462::31) To DM5PR1201MB0105.namprd12.prod.outlook.com
 (2603:10b6:4:54::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ebc39440-3b40-41fc-f3ff-08d9c55b30f0
X-MS-TrafficTypeDiagnostic: DM5PR12MB2487:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB2487064F7911B02A9E4850E2C87D9@DM5PR12MB2487.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1417;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GyRVH9xhuCZW1H7e62HNR+H/NREuzDpoXZ2REFN2kvQ1TIZerUEoByYo0QrwSWimRKr6JezxGWRDN8Azdzh4uFc4ZDCcZ80SBqr0iE64A1hpd8U2x+dkqZUiTJbpOhQIX/G1x8qAYH8/Lq0n5+CRck7hgcC+8tfzXKhicWg2BlEUPqx+GSGHuhw9vLaAMVD0EKYGlfdBHUkywwwLGzgtJCJkYRdL4w2Sj1ulO1jUcfUvvmjqusU6EfHDje/gTG/kXJxvilUR74kesdmwjIMiEtoa4AL2sBlv2Z6VGvly1BFR4FN8PkB7EUsUlt/RLpZQ33BRmUUD0Qhn+uDG5cjAMyAvlyiL7NqwugZUfL5ZWlQSww0Lt20hSlkS2ox0ukZWp9PsFQN/GjK12iz0z2bfgyg6Kce/KBBo0Yp50Ln2lv+xbbQp4xDbWGw68cQf34z1hlojJ0BGP/qVAnelQbkUnn8zgPZgNUluM26wL4zqEmzpZ0YKV9N1DUJFEW38fx0THnO6w2TK8yBeJHhiO9Vzd/uVT1Dnr14eAtDIaQ6o75h77KwVXjN06iaL0Ljp/t2cZjUi6gD/ocT3uWZ3OdipkeOk2TWIR+IQFDdjm868VKlHy/T6JM0FEvHMSi4kpv/LfKvkIBo8Yl2qdSBX4dAHoNWxXTza8n2O6IpdQg7qGwkxphCgbzgDEQyEp9mOBQm0BV6h8Hv8VnPVEO+Rj16MBw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1201MB0105.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(52116002)(1076003)(4326008)(8936002)(6486002)(107886003)(6512007)(36756003)(4744005)(38350700002)(508600001)(38100700002)(8676002)(66946007)(66556008)(66476007)(55236004)(2616005)(5660300002)(54906003)(2906002)(6916009)(26005)(186003)(86362001)(6666004)(6506007)(83380400001)(316002)(4743002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tiSnUVvUOkr9cJbf5etYP/LZcs+9/yvTdhynbDW4ROUi7MRAGXX2gZK3cu5e?=
 =?us-ascii?Q?7KDdvc8Q20+JPQax9mTx+jV7OYfjpM1TgcqgjFOhGbNnhyWvznXLQCVUCxCO?=
 =?us-ascii?Q?rSkggWDyjiNgGwmWLXTUyChJbK6MV+d+DMBQ2eKrCSRVCFUOuH9Dtd89cpN7?=
 =?us-ascii?Q?azWaGOF8n9DPwzuEuA2Ov3E6Y+CRpZeQFA47bt21WW4PuOnOg5XZLyKr88D2?=
 =?us-ascii?Q?NVUya4pIHBsJD7nRW7c7buCwqplE3KFdujY9jZXRdG+Gnk6PbrE/Qn0PufaY?=
 =?us-ascii?Q?bv48MbmnNq1w1qCFMNpeU+/KWfdpCixSRerSLN7VnG/1cwnlKQRRQP727gXk?=
 =?us-ascii?Q?mbcdlBMJ3HMPS+SplyuzmpH7ah1SCrzSwe+NELpz1FiGSFN7Qi5prGqOUDtc?=
 =?us-ascii?Q?oziSTb3NMzuSlN0IG3kMGpbX+cHd7tv+BbstFFwGWndI5Lu5DnBskeLLl+rw?=
 =?us-ascii?Q?m9L3B76uuVJs4bITe/fu7iVKrXn37Ra4Hyco2JEMPIEW4Qfu8wSNLLo8DKe5?=
 =?us-ascii?Q?CnMwt5Bp9/Li9s0j2owuCp06UA2w/5jl/7dzZ47bNHWe7riv2cyno5UNLtO5?=
 =?us-ascii?Q?mWuRYTFlGkksAeadbfaJqhx19dMmLE6wIXdyCSCopYVebx3cg7qo3Dsn8vMT?=
 =?us-ascii?Q?ekP/E9a6D719CIXDWAmUcy+gVf2q8DDZet5hCfHROc1JbBDZlXYmNXHpjIWh?=
 =?us-ascii?Q?zgLv7t+ZHDGQhaDbQIqnXb/S9AUFZ/YIoA3zgzNu7mhTu0twO+OI6NHY805t?=
 =?us-ascii?Q?MOqAi5pr4yv+PPOGKFw8v66cfkfRSdcor9JBm1W72BqBbPBc/undphldjIj5?=
 =?us-ascii?Q?Xx25/VW9mVH8rRyHVx9+oS08S7NPIhaAgJ5PmFmq0wVaSTyxg9jS8d5D1BKD?=
 =?us-ascii?Q?fo9iWtufPfuLFGDLAulDqUb3pKP4xocwvUM/EZXSFlS1y14zyu4sRHjGZAxy?=
 =?us-ascii?Q?7lk9vF+ha4Gjg82n9Vrg+ms0SfyCya8dNQ8zWUX+D0W279+SUIoLuJKpEIht?=
 =?us-ascii?Q?0L5ympTrBz/3m07nRRT7NWR/5xU8YN7+TlKmdt4ppsINNsxfHmjOhUKOh8WX?=
 =?us-ascii?Q?DYtIuJcn1rIOcant2HsxrLHf8lYw/dMXa0gzbT9k153qLF6q97m1qSkLT8Yk?=
 =?us-ascii?Q?Ss3xVJ013L3R5TuegdmP1JhPh1Bs/0fyh8fnYsGpVRhzEmOKfYQ6Mkd31lV2?=
 =?us-ascii?Q?GMMsg8yqRdt1yBfGOtd/9XQYKHF0gnJZd6fe/lVL0e1DE942SEg3i0jD4RMk?=
 =?us-ascii?Q?1KsPds8x0c2LKnK5r1YasydDaCWgubgikB9SaEigaane3UALboGtbCHpNpzx?=
 =?us-ascii?Q?1+0b3OtDt6N/QN9gIgkG6rABYdvlWMx7jUz4Q4eQNc33BfQOo7E3B/jS2sJr?=
 =?us-ascii?Q?EzKf4sf4GhcQuItktXb7ys8t/pluljrHWHAvv/+ANxKc8H1sMFtOxu3sN5Vr?=
 =?us-ascii?Q?BlbLf72zLg4V8qlS/kerh0WblhoE2asje+GDd94QJP4DIENTd0RrZHnbn7P1?=
 =?us-ascii?Q?qFi9UK4mm1mKw5DkkMCIZdbntLTEeoVd6mWwpjKBAceygAiuaRSO2nackzRr?=
 =?us-ascii?Q?af4ArAd6TcG8JkKtelw0V8SPaOib/QMmFC67wkoKKodtfUB39zi3ze6vKHTJ?=
 =?us-ascii?Q?kR4Adwyr8acpzJnHMFbAXZE=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebc39440-3b40-41fc-f3ff-08d9c55b30f0
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1201MB0105.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2021 14:56:10.6710
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 73Bn+QzXlefCi7CItA3V/VaoXuD1QEO0650oP2hHiDPJl2KZrYN/qi2naR5mh3wt447P3fyHP2Uf4WfvdlxCfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2487
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git-p4 contains a selection of verbs for various functions of the
script. The "debug" and "rollback" verbs appear to have been added early
in the development life of git-p4. They were once used as debugging
tools, but are no longer being used either by developers or users, and
are largely undocumented. Removing these verbs simplifies the script by
removing dead code, and increases usability by reducing complexity.

This third version of the patch-set adds more detail to the commit
messages.

Joel Holdsworth (2):
  git-p4: remove "debug" verb
  git-p4: remove "rollback" verb

 git-p4.py | 76 -------------------------------------------------------
 1 file changed, 76 deletions(-)

-- 
2.34.1

