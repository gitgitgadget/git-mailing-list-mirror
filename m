Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8EF7C19F2A
	for <git@archiver.kernel.org>; Thu,  4 Aug 2022 16:09:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232690AbiHDQJZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Aug 2022 12:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231909AbiHDQJY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Aug 2022 12:09:24 -0400
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-oln040092068038.outbound.protection.outlook.com [40.92.68.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A48F011460
        for <git@vger.kernel.org>; Thu,  4 Aug 2022 09:09:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V5E8b9xtNGYC9lXXwqA5+L6u3VLUu8QUet5Yg24qIVCzCdXAzqZLOeQNUtGL6JLzdR1/JqGLtx7pNaZLwR4qkWMZPx9X1zmieMghOtGx0hMAkyg0WgvIvUXmJQmHagFk4UpfvECXvMBCr5TnBrtyFtFJCeOvYK5Mu893cKTlljtA207HmG5brHax8C1qCXgWJBH01lyhI/zgpBlvVzzEnN/XBwzAPOmKUXJemIVVngkGE1+/7szrpW7NwKLqPYU0d2MczyrbTs0RvG/5BeescWzRZKRu2KjJIE3bB2lKTnAEABh+vd/AAqnp2x0pg7/fo1yXxLaj1Eotim6rVOITwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wRSimM73fMQC60ZrOJ4oew2LE4zaLhYlFaTS2Iwu2/E=;
 b=j/P6lHad6tgufQUMBtIW01+fWwBqcQk6mDyt+MlUaDJoTWxmHfLKVNJA6Wuf1aZsUye8/n3XxT1lTysJHsE9bRBQ8CEp/1kE+AoZ9yhEZuUyl/FvL2rwWLYxwXANh45sxnsalMZ7gAuNB1kfPqksbV8c9VVFxVcgxGm5Yw7ymi6k8LLJ8RAnoLAwc6xem9be7CGY/3H35Ga6c8vRPx1YgtNWZzeb4p+0hD4JLkH9md6BSA7ElcwIXhpjVYeilHR3PdNAdxEcrE3/1HnH9Y8mM6WQz3g+mLnWtJBZPR/edd+sRZXkRrZAxM8z2JSRcxPqBNqdoOVFdQDLcjv3wW1FGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wRSimM73fMQC60ZrOJ4oew2LE4zaLhYlFaTS2Iwu2/E=;
 b=OrPjIbTtwRqFb+dVnS5T0HGxU3Z2Uq796CZIGZydv7nws6Q87aZajKaOY6KDhkyY+mBMDwzcTZ4RvlmsXLMZo6ZHDHW6WR5IpQIW8IomafwAfxGLprtTeB+7MVgMSqq8V4+5dg3WnUh8ZU9Dal3gJwZplXOXeqEI/l41lv2ViNmiS7FKpd6cbmgAN80ObPC0Hbe5gxa67cR2UT+wP/Id7BWdHoZDJE5tkRlXrC+TKASb9Ni29eB8w5XhOS3hNO9QKaeakNOudIjFMMXAMQa5nQxMnT7loS7ASY+v9Q3b5TR+yn3ZvIIL5Mpb/ipTTtILzwqcI+hjrEYFUJjja3nDAA==
Received: from AS8PR03MB8689.eurprd03.prod.outlook.com (2603:10a6:20b:54e::12)
 by AM9PR03MB6689.eurprd03.prod.outlook.com (2603:10a6:20b:2db::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.15; Thu, 4 Aug
 2022 16:09:20 +0000
Received: from AS8PR03MB8689.eurprd03.prod.outlook.com
 ([fe80::b9da:1e3c:300b:d2eb]) by AS8PR03MB8689.eurprd03.prod.outlook.com
 ([fe80::b9da:1e3c:300b:d2eb%5]) with mapi id 15.20.5482.011; Thu, 4 Aug 2022
 16:09:20 +0000
Message-ID: <AS8PR03MB86898A2F7156918A390296CAC09F9@AS8PR03MB8689.eurprd03.prod.outlook.com>
Date:   Thu, 4 Aug 2022 17:09:18 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH v3 2/2] bundle-uri: add example bundle organization
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     gitster@pobox.com, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, dyroneteng@gmail.com, Johannes.Schindelin@gmx.de,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Josh Steadmon <steadmon@google.com>,
        Derrick Stolee <derrickstolee@github.com>, git@vger.kernel.org
References: <pull.1248.v2.git.1656535245.gitgitgadget@gmail.com>
 <pull.1248.v3.git.1658757188.gitgitgadget@gmail.com>
 <a933471c3afdd2c95d4115719c24d79e5e430b4d.1658757188.git.gitgitgadget@gmail.com>
From:   Matthew John Cheetham <mjcheetham@outlook.com>
In-Reply-To: <a933471c3afdd2c95d4115719c24d79e5e430b4d.1658757188.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TMN:  [RRIh/DKR7OOehP7xOuRLru7oeDtQjyj5tp5/cfzrO0k=]
X-ClientProxiedBy: LO4P265CA0061.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2af::7) To AS8PR03MB8689.eurprd03.prod.outlook.com
 (2603:10a6:20b:54e::12)
X-Microsoft-Original-Message-ID: <2321f793-92c6-afe8-6684-7ed33717cdfe@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 29714496-29f5-4c9d-f199-08da7633b03d
X-MS-TrafficTypeDiagnostic: AM9PR03MB6689:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0x2n1q1X85p9eJIWXkxMdkd8ird4gsgH4EjrkpisHn9KJtlIy6Exj2usdYUYgiUATOQXdr7OujKMozEJeI9KljDiNyS/QSqUSWc8Q6oL2uG7ja6/If8LtB7cRHSDAViEv+j9Wj0VQlxJe/f50hdDXIlAW58DSb1fG8HcXhTt2GMnIo0YbQHQoftmEXDBItJC1AYxdsfj4lwbo5Wwu4eo2qNT0sboVt6Pf4I88fXOeaYBCI2S+5O5pn5D/pEcFaw+awwdfqfkgLElGIs6Z7HevQuJxIHUmpxkA9OnOlv2y/BJ1n5LnT8NN5fE81oZYM0UD2Qgl+NeCakDNJ27/fLDgKHhg6TMcKYtYKAUYuRPs8AXYBQ3hwRztLB8XXLvpM64rWNsrM+V7sT59WU1b45DbMNGo3UvhegJvnbLleZjufQP6I1DlYrm5hbFCLtpbQgIXlG+yf2+j1igxjYMNpSWs+DMquVkTwLoxFcYUkpM4cmn1gFQAgZxy04peRuodjqQArZaUmZobeBZ1PZ4GdEqlni88GV0yiGdZsTjL6qaehxc1j21MBkMqrWYU1piIG7syAAljC/ydWrDvj1fslZi61KIkU/cQBtr/D7mrdFVsa4SUjVA+3FPl0GjQvLRdepEiB2+E3WHAblyZgkI4NXWL9ol+DkAlNB9eKt88SM4QEzUeWwuQV1R4NKCxU/0oCJ4
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TDlpRXhKRzlvMnhWR2M5YkZOUjh1QXJZaVREQlZUczl4ejZGaExoWnJQTk1h?=
 =?utf-8?B?b0xCbnBwRWhTWjRwUDMzTUxTSmgzWWhjaEtjNTlkazcxN0craVVZYVhZZlh1?=
 =?utf-8?B?RDlXM0VlUXp0S0ZYaHhIRFVrWHpwQ2hQcDYydFl6NExBR0oxZjNnNVRRMTIx?=
 =?utf-8?B?UnZVRFVNajhDU0l1QjdiWDJXamE1VWUybkU4SlozNEpKdHBVOU5Fc2FuUmd0?=
 =?utf-8?B?ZGo1L3RpMW1BdnZoTGxaNS93aGVUTUV1aVpncVpvekpDSTYwTTFXdzBUei94?=
 =?utf-8?B?N2R6RVVrOFhHbnNKTHVvZ3R1a1FIOWJydEc4RG4zSHBSekVhVG01bWNEOHRM?=
 =?utf-8?B?L2F5eS9aQ0xFMEMreUM4T2VDMk9HVkZSQlFkbkxyb3FXREkyTHB5YWpxVTBz?=
 =?utf-8?B?cXJXejBlNE5XMlJLakdGZUhUWDhFKy9qOTE2S0R0YkNkdjJCS0UvNFoxQmw2?=
 =?utf-8?B?VUk0NlR2L1poR29YakN2VEFHd0x6NUtxU2xPZWxsM3pkNC9MRXhEMTBxcFh0?=
 =?utf-8?B?aCtRTWJFNWUrdHVXWi9ERzRaZTYzT3YydFlvTDdmanUySkRjc004dzNnZVAw?=
 =?utf-8?B?aCtQMmNtZjg2VUtrY2EvQmFzYTRJRVlnangrUEp2NkpVc0d1cUdNdFMycHJY?=
 =?utf-8?B?OGdqb2V3ZWM4bnk0d0JTK0NIS0d4eXl3QkVaOUJ2SytRRkRtKzc5VUpwcjVz?=
 =?utf-8?B?UWZlV2x0T0hjT3VGYnVrNkZSZ2JieU5HeHJjMnNhMW13d2NPL0JiQTkreEYw?=
 =?utf-8?B?d3ZWczd2N1M3anl2UXZOei80dElTTy9rSG1hdG5MRlU3Qm1DVkpkS0pKc3pI?=
 =?utf-8?B?T1BqUzFJS2t1OWd3d2hnY3BxTjA2UzI1NFN1emxPTXZYSmRSRXpicGxDUUpn?=
 =?utf-8?B?dlZYb2ZueC9CR0JSWlE0MGo2endwdkdrMnNpMmFuMllyR0gxcVR2WmZWZy9N?=
 =?utf-8?B?WWhVZklILzN5NE1oeXdBek50ZXIvV29HMjRzaWI1WGdpNTA5L3hhN2Mzdk93?=
 =?utf-8?B?NCtCTmpJZUcyS0V4dG1IVzFtYXczeTdKQjBMN3dRMDZhamJSQ1NTbzgzaVJH?=
 =?utf-8?B?S0tjemNWQTVNcGdaN2dVZ2U2RlFzZkxjODdvNDhNRGNqbnZpRW8wZHQ0VkVU?=
 =?utf-8?B?YnBHc3h4cnYyckN5d094OHd4TVhHZnVSMFFBZHdlWFhkNHhLQjB0YlFzZklO?=
 =?utf-8?B?TmJVMTh2ajVFM2xLQ2FNY0xhUk1NNW0zMEJTVXQrbllhL1NwRFdoOFdvOEZX?=
 =?utf-8?B?TzZWTThHK3B3Um9XVXorVGhHMmZkeXdydnpMVHgxeTF1WVQ2Y0VhdHVWRXUv?=
 =?utf-8?B?c21nUlFIcXUxY2h2aXlMcTN3QW5Kd3hLLzZ4QU94VU14VUpTRUdkYWRTQ0xF?=
 =?utf-8?B?K29OVGFXb3ZPdWJqbnAyNlhxMnpncWF0R3FTRjhla0FXdk9zdFdQOWt0SnlT?=
 =?utf-8?B?bGV5RUFBUWxzUjYvVjNpckh5aXBtYkxVcmpnN0o2aFg3azJ0UTM0d1oxelpk?=
 =?utf-8?B?Mk8rSUlFcmxvVFVxMzVwMXF5MWFncXJ6dk9mbHNwaGZSL3VSVWs3UnhyLzdF?=
 =?utf-8?B?dTlmcjV2ZEUzalVieVFWNkRCMTlQTTZROGIvdVduTXJYQzh1QUxqTlBEdlNP?=
 =?utf-8?B?aGt1WFBnbE1FNzJTTk9oWDA0TnVZU3pIQ2ZERVpYQnY5ZnVOdEtqTnJjWDA4?=
 =?utf-8?B?UytvVnZBdklwMmtUZzJxaC9lamNiZDRQdlNxVW55YzdqNFVySWhJL1l3PT0=?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29714496-29f5-4c9d-f199-08da7633b03d
X-MS-Exchange-CrossTenant-AuthSource: AS8PR03MB8689.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2022 16:09:20.2355
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR03MB6689
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2022-07-25 14:53, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <derrickstolee@github.com>
> 
> The previous change introduced the bundle URI design document. It
> creates a flexible set of options that allow bundle providers many ways
> to organize Git object data and speed up clones and fetches. It is
> particularly important that we have flexibility so we can apply future
> advancements as new ideas for efficiently organizing Git data are
> discovered.
> 
> However, the design document does not provide even an example of how
> bundles could be organized, and that makes it difficult to envision how
> the feature should work at the end of the implementation plan.
> 
> Add a section that details how a bundle provider could work, including
> using the Git server advertisement for multiple geo-distributed servers.
> This organization is based on the GVFS Cache Servers which have
> successfully used similar ideas to provide fast object access and
> reduced server load for very large repositories.
Thanks! This patch is helpful guidance for bundle server implementors.
> +This example organization is a simplified model of what is used by the
> +GVFS Cache Servers (see section near the end of this document) which have
> +been beneficial in speeding up clones and fetches for very large
> +repositories, although using extra software outside of Git.

Nit: might be a good idea to use "VFS for Git" rather than the old name
"GVFS" [1].

> +The bundle provider deploys servers across multiple geographies. Each
> +server manages its own bundle set. The server can track a number of Git
> +repositories, but provides a bundle list for each based on a pattern. For
> +example, when mirroring a repository at `https://<domain>/<org>/<repo>`
> +the bundle server could have its bundle list available at
> +`https://<server-url>/<domain>/<org>/<repo>`. The origin Git server can
> +list all of these servers under the "any" mode:
> +
> +	[bundle]
> +		version = 1
> +		mode = any
> +		
> +	[bundle "eastus"]
> +		uri = https://eastus.example.com/<domain>/<org>/<repo>
> +		
> +	[bundle "europe"]
> +		uri = https://europe.example.com/<domain>/<org>/<repo>
> +		
> +	[bundle "apac"]
> +		uri = https://apac.example.com/<domain>/<org>/<repo>
> +
> +This "list of lists" is static and only changes if a bundle server is
> +added or removed.
> +
> +Each bundle server manages its own set of bundles. The initial bundle list
> +contains only a single bundle, containing all of the objects received from
> +cloning the repository from the origin server. The list uses the
> +`creationToken` heuristic and a `creationToken` is made for the bundle
> +based on the server's timestamp.

Just to confirm, in this example the origin server advertises a single
URL (over v2 protocol) that points to this example "list of lists"?

Remote -> 1 URL -> List(any/split by geo) -> List(all/split by time)

> +The bundle server runs regularly-scheduled updates for the bundle list,
> +such as once a day. During this task, the server fetches the latest
> +contents from the origin server and generates a bundle containing the
> +objects reachable from the latest origin refs, but not contained in a
> +previously-computed bundle. This bundle is added to the list, with care
> +that the `creationToken` is strictly greater than the previous maximum
> +`creationToken`.
> +
> +When the bundle list grows too large, say more than 30 bundles, then the
> +oldest "_N_ minus 30" bundles are combined into a single bundle. This
> +bundle's `creationToken` is equal to the maximum `creationToken` among the
> +merged bundles.
> +
> +An example bundle list is provided here, although it only has two daily
> +bundles and not a full list of 30:
> +
> +	[bundle]
> +		version = 1
> +		mode = all
> +		heuristic = creationToken
> +
> +	[bundle "2022-02-13-1644770820-daily"]
> +		uri = https://eastus.example.com/<domain>/<org>/<repo>/2022-02-09-1644770820-daily.bundle
> +		creationToken = 1644770820
> +
> +	[bundle "2022-02-09-1644442601-daily"]
> +		uri = https://eastus.example.com/<domain>/<org>/<repo>/2022-02-09-1644442601-daily.bundle
> +		creationToken = 1644442601
> +
> +	[bundle "2022-02-02-1643842562"]
> +		uri = https://eastus.example.com/<domain>/<org>/<repo>/2022-02-02-1643842562.bundle
> +		creationToken = 1643842562
> +
> +To avoid storing and serving object data in perpetuity despite becoming
> +unreachable in the origin server, this bundle merge can be more careful.
> +Instead of taking an absolute union of the old bundles, instead the bundle
> +can be created by looking at the newer bundles and ensuring that their
> +necessary commits are all available in this merged bundle (or in another
> +one of the newer bundles). This allows "expiring" object data that is not
> +being used by new commits in this window of time. That data could be
> +reintroduced by a later push.
> +
> +The intention of this data organization has two main goals. First, initial
> +clones of the repository become faster by downloading precomputed object
> +data from a closer source. Second, `git fetch` commands can be faster,
> +especially if the client has not fetched for a few days. However, if a
> +client does not fetch for 30 days, then the bundle list organization would
> +cause redownloading a large amount of object data.
> +
> +One way to make this organization more useful to users who fetch frequently
> +is to have more frequent bundle creation. For example, bundles could be
> +created every hour, and then once a day those "hourly" bundles could be
> +merged into a "daily" bundle. The daily bundles are merged into the
> +oldest bundle after 30 days.
> +
> +It is recommened that this bundle strategy is repeated with the `blob:none`
> +filter if clients of this repository are expecting to use blobless partial
> +clones. This list of blobless bundles stays in the same list as the full
> +bundles, but uses the `bundle.<id>.filter` key to separate the two groups.
> +For very large repositories, the bundle provider may want to _only_ provide
> +blobless bundles.
> +
>  Implementation Plan
>  -------------------
>  
In general this looks good to me!

[1] https://github.com/microsoft/VFSForGit/issues/72
