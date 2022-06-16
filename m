Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2916DC43334
	for <git@archiver.kernel.org>; Thu, 16 Jun 2022 23:44:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379410AbiFPXoy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jun 2022 19:44:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379395AbiFPXow (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jun 2022 19:44:52 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10olkn2036.outbound.protection.outlook.com [40.92.42.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 348B854188
        for <git@vger.kernel.org>; Thu, 16 Jun 2022 16:44:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ieyDy7v2yNhzl7nEz2Ud80gnqBPZVMJ8xPUeSHwZbToEzvYbE5JtgpOVrBhboV7eLqQvFH90XnqU8uTPmWTGojrWlBhfgGoXT0eq7bwTPtRy8rjmTj71GGnwOYF2pmbE6aNf1U9fF5QnyAtMZ0faTJ8LbodaI/jA/Md0wxFhhQYN9RrJTsuDvc/5ovyyj+eatk7VNTm4x9TCKSyc2heKN0yErd+jgbZkSQmukVq7FiW8peZQTZQjtmHUk9joj0VGgMQ4AA2+vwVLWZTl44iN6CfaNO6jTa52nO43gbpNtjR14CTdxDBjadptrxCd6Bv2J3efdJW2eflAnLGiwbq0kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3HctUNqiWdiLLNv/S5lhfViSUVPKUSCXRPdohXkVApE=;
 b=iXD9ksARMQCustu0LqeLLbFSu3WA/JDgr6aCgMIQlN5pPMicIEnV56OHLPiDJ/waCrDvozmXTJ02RLjui9RPn7YxcnVfW+VRD1eFczfudz8VPVZgNKEYys7XGsxLSXuKUFzeFxcHy9PWhBW0pgzrC0jDIDIhFP7+N63KlgLf2XylSWbjsGrVNyWtnIvDAdBcAAQzexGoCv5be2/K1WsjNhLlJNQ7yS2qoRcaJ4G0AUlv9LojeIYr9vICjQnIdpjFMyaCaBt+KnQ03nEMXyso5JRUTdmSSVGDE82ZNKzyFOLCYSjhmRnqrWxdCd0p+ZOiTlwFYbi+JPYWrlC06dmcsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3HctUNqiWdiLLNv/S5lhfViSUVPKUSCXRPdohXkVApE=;
 b=gDsCGDti6oyGZhVrYZNFP8uqTmMUuK2xWhU0h1Glmxmuwn1uKSKHgZ9FDunKWg5kyQJqdBwuPQ0Pjnf9/zghZ+rUk0P7QRL6F9tZfiLNQjpOP50tT52v+w70g2WoYSCbr9KphM+w0W0W9wrD62IMjCn5pbdc/P9uEkH063FHdB3d5Qv26ePIm6PZFF1tyuRFMBrxbenb9wxWVv1uIlSvFRVqR5Y4ql4FfVUVKosFqvLwHiwioDp5Vwwn/2vSfmNZJw8BosL9aet5wCN80MbjxbKw/Ccy0WZd7NCLYYpqdjvz999JDF26mOJ9He122OTxSBYPskjLaDKTOy//mK/ChA==
Received: from DM6PR13MB2987.namprd13.prod.outlook.com (2603:10b6:5:6::24) by
 DM6PR13MB2521.namprd13.prod.outlook.com (2603:10b6:5:c1::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5353.6; Thu, 16 Jun 2022 23:44:48 +0000
Received: from DM6PR13MB2987.namprd13.prod.outlook.com
 ([fe80::6cd3:208a:c0e9:df97]) by DM6PR13MB2987.namprd13.prod.outlook.com
 ([fe80::6cd3:208a:c0e9:df97%4]) with mapi id 15.20.5373.009; Thu, 16 Jun 2022
 23:44:48 +0000
From:   Goss Geppert <gg.oss@outlook.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        christian w <usebees@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: [PATCH v4 0/2] dir: traverse into repository (resending)
Date:   Thu, 16 Jun 2022 23:44:31 +0000
Message-ID: <DM6PR13MB29879E6133A7DCC9903C4B4A9DAC9@DM6PR13MB2987.namprd13.prod.outlook.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220505203234.21586-1-ggossdev@gmail.com>
References: <20220505203234.21586-1-ggossdev@gmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [w+u9G05uf9urpKeGYlHzN6KrQ/Qx3T2M]
X-ClientProxiedBy: MN2PR20CA0025.namprd20.prod.outlook.com
 (2603:10b6:208:e8::38) To DM6PR13MB2987.namprd13.prod.outlook.com
 (2603:10b6:5:6::24)
X-Microsoft-Original-Message-ID: <20220616234433.225-1-gg.oss@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 11472750-280a-46d2-93d4-08da4ff232c9
X-MS-TrafficTypeDiagnostic: DM6PR13MB2521:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z0tNpjHTxUFsuOoTxBKujktTtgF4kYZGZKB2ia9vt95mOzoF9muoHqmhgoZdI7WB/2U9K/Xm5+fJey5jgDErMD1j7h5O+jI29XdDz7eBXXKzX1y2P+ez3VvkzTczwvlb+/y4oVj7AMqH3KsX/7o+Pxl/TSLh7Cv7JEZwynl5DAFEmkeGxtvMZnMcAi3OwDBaKs850qwiVIyVP6Mg+CAQhLrcXoAK2FEa6hyO53UXouK28qf7YFNU01/6n/fd+OWG8lamiqg6dPHeTAT6Sb1Os7dwgGHRgwMFJv2GMRbSzmNkSdY5M21TA4H+67UO5AuK6n0uO/YuNnP7cVloEOsXllIoYsQsHs6r9G4DpJJqRHiObqef5nFz7PievPN/XWVl/HnA+FCnQRNKV1WqwXiYmsTAThekW+HVNuE33y5jPo6NJRwvUAS9usPrsm3DbtqwfPQGS2QvTHUUwDHI7gLzRNJz9SFzR1sZuEHSlbStzRIDNEojYYew8j7z84oI59CujHHRe79uuEU4tPWsEYJ1H+02SZvZoyq7G54RcqZrfPLa2247wJm1o5kf1wECrEjcpZa2EL4zCBX4K9aHhVn6eA==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lBZZIJgCFq2s7VQlQW3wqDsj5wiBUlBVyvzkZb7lLMQX98/NQIs9rJT+SjJH?=
 =?us-ascii?Q?6FHXapCTMY1syGdtgWy2QHhornJem+r+bvmtX0EpPWAzbA0F1LxSYFFSuLOt?=
 =?us-ascii?Q?n6/wIxLY0SJGf+qrHWiaq33J9U2MbF+eJ9dhFWy7hav/RCEIYqrgg1Pyc/Nz?=
 =?us-ascii?Q?+uqeFKKW9k1xT2eJEnsGgpzUEei+TqPtn+LmrkntXoIVl9LNeE5OGltrOxB/?=
 =?us-ascii?Q?OL5Sd7DiDVKSTQQ+3rhu1Bu3+PJreHaNy/2t6uXMDzJz5QPlrSFeEGPT85Vh?=
 =?us-ascii?Q?kl7hpDcVhRMarFSzN1xUq1JZzUJ4I4lPFaVByobs1LUfDrKZ6y3ZKd8/enRw?=
 =?us-ascii?Q?PKgh6L/U0xAqTzSA9GWVuzfWkH3mq9ek9brxFhlD67F/4yY75X0Pv+47IQgM?=
 =?us-ascii?Q?NDDFqzhuhI4EnJ44HIvGRK2/QSOB+feyqBKEPZfCs5WukVFnia828DEgfqNO?=
 =?us-ascii?Q?vVYKqy/1LPgqDWUgdMa5TJiw2zxVW1X3hq3ksdhSvExS7Zyh9IJNn72I9YFR?=
 =?us-ascii?Q?GhxkNMhbs1/d8VVMtnJG19w8DKirqO5r2LxCfIZ++6ASEOgeuHXbgyj0TjaA?=
 =?us-ascii?Q?JSJSvwHE8TFB3BXAKsaHN8b1QS8Z/bmtopLXbPV/YLNNm4td80aTxtthWFrA?=
 =?us-ascii?Q?wm4WPZV0eEoQ19QHQakoM2/j6bokl5ti+32Jy25N4t9udvvW7uBrKTTEpzZw?=
 =?us-ascii?Q?xyo8xe9uke3u+qew5sLg2KbkaORRX2ShlYeIWc2fOASla2K1aq//jkTA25b+?=
 =?us-ascii?Q?biWq+c2Al61txBrKugGX7OydFF+UGfPiNErqLxOx9MaMwbJm5voWCI3LIucJ?=
 =?us-ascii?Q?qewIvZsjkUSJGAOJawLFGhOTXcA5CZ0Rzz6V84Ub7UB9jqpBQx/EjJZaaqiw?=
 =?us-ascii?Q?sqmqOFz8fKJup42R4Zc68bJe3pK5abt4oZNxmPLn9MHu9fVKXVdfB4ZZBee9?=
 =?us-ascii?Q?lk52b6W4gd5int6Fgom5sUGpRDKvvH7TJwDa4NTZjHrf13V7wjx5+PAtIN8i?=
 =?us-ascii?Q?oF62YhZ1sBLp0aKMqbTC7/gorZS3URFBkR+GAiF3s1KALYv5AtUZLWBDQMQ2?=
 =?us-ascii?Q?Vd6xMgcKoseO7q3u7fWw8yXKTVD95+VMnYKBv0fG7Z9q9xWqWN5if3u9MQn4?=
 =?us-ascii?Q?AAkANyXSXk+Q4EuDjlJvkL7fu/Xtp+ALfG8axoyDrpI4V5cmAlktDsCgfrOl?=
 =?us-ascii?Q?ysBWm8WVyqbKmhI/0oFAOZJc+OxNsLMr6NnMXSDKLxmD2h5hTSvnUBNA4bab?=
 =?us-ascii?Q?a2nVrH9+mNkZw0LvR88ThpBmiWlQR7xmdghDSC33q+saILTwk2o8f9W0wqx9?=
 =?us-ascii?Q?6ZTR7XAD0kFD12W/pO2PMDpKKvX0KNhTtPy8bWkLvD7Pi3d0Ye1Tzfp8ubT4?=
 =?us-ascii?Q?jsXxj3dsRYSQfZzRwzYu3vfBD5f/NkajwjvAzOEbXaXlR+XJgnVVt+ukJjdu?=
 =?us-ascii?Q?8f+6aVsZ5rk=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11472750-280a-46d2-93d4-08da4ff232c9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR13MB2987.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2022 23:44:48.2535
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR13MB2521
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Goss Geppert <ggossdev@gmail.com>

Attempt #2 to send this.  It seems sending patch v4 2/2 resulted in an
error with the outgoing server.

Original message below:

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

