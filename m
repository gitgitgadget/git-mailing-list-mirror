Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E112C433EF
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 12:09:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233509AbiGUMJm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 08:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233498AbiGUMJk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 08:09:40 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-oln040092075092.outbound.protection.outlook.com [40.92.75.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D2C485FB4
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 05:09:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AGi8qUluVcl9D4KsSiAyz5mHX98u3YxObOdo6sHXBVFTO69NYaa+kqkynMJFHtKZIEnC2kX5ZnsoIeyW5UuxtZBcAGdE5LGFpUYYoCc2xWJr6F4gp7VFw3/Ri8VTenIXFRHWe2+lEsihTjFVw/Pqrg66Pv/kai6N+EIE94rRq/v1i5UT1451F2Has/mgbSatRyXZsmkfxiGFl6G9tvM8yEmvP/C+XVrytHfAEoB1dubD/l64yIKRvb0LvypZLPpD9Fl8Z8iB7hpSemp2XOs45ylU+CmFkC0Fs5WMNG+nMHd++0jQMAMutJu2cxFUAbMfRRsNn8IE/ktPQLbgW+nqRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/8AJCNUssj+UdcThM9+93Tgg9g7vurxOTAmrIcAc5RA=;
 b=UMBoKLWBx4xtfdGPf0bthLZgMt1QJPfdlSC7nfAJyEwnYP5resGh64f5jAzAK+fS8aUodqDLw5hT0WoVdl4WQ+i4pHaqPW6O2Dh5zhrWJCPKsQ5bKP1Z+XZEB0zK2P4KplM3Ievx2ro8FqlqWrR2qykfFBaVvMSOrkmANgvvIlSiTC9b4YO8SUYgam11BM1dTZ1EJfOeot5xC03694kbhYAY2YSXpa7TtBQQ7WKlRMcyl0cHKHT6pLMtmpldluN4yd4Yk/c53TeW4PETL0gIFtxEtcVzQvt6RLUTPR+olaqGHE0Tdky7xfRbhbb6dSyogqRAXXOblTS1Wvg64DPJsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/8AJCNUssj+UdcThM9+93Tgg9g7vurxOTAmrIcAc5RA=;
 b=hUmB89op+/9/syD3K//GeXQRUitgXYCFRRJttAaVgg62fi2t6Z2BvcbXg6e4UfqkUtG6cL2zUC6aBPyjB3MqLsITfbY6TiqYdtqdqvgmzXqGXpRoQm98TR3sHj8CQjgqRv7T9VL6zKT/2M8zCzvkvoaEjSaTMoiuLJkviEfRESenf9NHHyDGFeidiuKYYrfUVYFg4IkuNPf1q7GZLQi5E8Jw8go/sapXG0SxNJ4QNTFDvvbTtKGbR7wnGtYh+MeBWvVHRteJhsAbaKpwd46bpLLcax6wfVs9hWDOe5f0tBuqQYXHsnTYIoj2pWDSKoYql2uNuQMw38WQJVkDi593jQ==
Received: from AS8PR03MB8689.eurprd03.prod.outlook.com (2603:10a6:20b:54e::12)
 by AM6PR0302MB3173.eurprd03.prod.outlook.com (2603:10a6:209:26::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.23; Thu, 21 Jul
 2022 12:09:36 +0000
Received: from AS8PR03MB8689.eurprd03.prod.outlook.com
 ([fe80::b9da:1e3c:300b:d2eb]) by AS8PR03MB8689.eurprd03.prod.outlook.com
 ([fe80::b9da:1e3c:300b:d2eb%5]) with mapi id 15.20.5438.023; Thu, 21 Jul 2022
 12:09:35 +0000
Message-ID: <AS8PR03MB8689A38CDA60565FED96EC99C0919@AS8PR03MB8689.eurprd03.prod.outlook.com>
Date:   Thu, 21 Jul 2022 13:09:33 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH v2 1/6] docs: document bundle URI standard
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     gitster@pobox.com, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, dyroneteng@gmail.com, Johannes.Schindelin@gmx.de,
        Derrick Stolee <derrickstolee@github.com>, git@vger.kernel.org
References: <pull.1248.git.1654545325.gitgitgadget@gmail.com>
 <pull.1248.v2.git.1656535245.gitgitgadget@gmail.com>
 <d444042dc4dcc1f9b218ca851fcf603a3afce92f.1656535245.git.gitgitgadget@gmail.com>
From:   Matthew John Cheetham <mjcheetham@outlook.com>
In-Reply-To: <d444042dc4dcc1f9b218ca851fcf603a3afce92f.1656535245.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN:  [0hok2DHZ3APnJP5U9qP9QCNv+5ynFerd6m+hHLM9Zwc=]
X-ClientProxiedBy: LO2P265CA0112.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:c::28) To AS8PR03MB8689.eurprd03.prod.outlook.com
 (2603:10a6:20b:54e::12)
X-Microsoft-Original-Message-ID: <bac19ecc-1b50-ecb0-65a1-fb9cc13fcc78@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f7630eef-2000-4155-4b5f-08da6b11e002
X-MS-TrafficTypeDiagnostic: AM6PR0302MB3173:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q7QJhNSIt6P19aHRsV4vu7s5iA2F3EP3CKSkQnBB9q4PyURAs2Ew+naqoRnMxe3lshqU730cSvEgnyf0xYXDWJWfy8MXukocVtJ+GD0c4kRBPrdNGQGbhUzVYNvEJ0nwr+AaGnVHTI7yNzPpb2xIoijVy2rBzvMBhMSec/oTouxVm4Rl7k4Tf2LVgaBWqufqfobDlsqdedfnBJub9/CZS6m/t81frga0Lezi9bZ+wSUnpfLyicz6JtUBnYAca30KOfEEZdgYGH1R1K04xdG2Pdmdev26n5yObzUEXqOOrxmm+7R/POJtZLImrEGQfZf9s13IcwrRp4DmFokk9neVEkMNkAvaB/rBmPUx2kQUFIfZAXgjAt2f1rP0Jmjf4nNDpF4pevNlGwBoncGIZfElWFrl5RpNZov+pWPvElnl1DTYu2rU3p9tFMoCeQ/Rq9NRzHTBnGPE4q9q3Zmp5Wwfi4igMCmevwx4qZ1a8zCAaPAjeZE7QMata7RNn1m6hH7h6bgBH/29eTgxuFwEiGC0nNZ4C3vT6Rj/MjuxtQCNwewRHi0iz0sidbTxe7lG6l2GzRZIdwxt30u5D/rr64Lc+IX5B3mFwP47cecJBiVjnFmiIKprcu+e1XDMQEdxaFk/Otqe/FXFUu8g/2IVts1RyTBuYvhxlpHJsbnYKhh5hQYEQFa6hXvhTLOCT9mehlMw
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OHBwQ2dROWdRWmZLYm1LRjQrbXNMMnFieUJOVkt1ckoyUUQrWTVTc1l3Nk1N?=
 =?utf-8?B?U2xPcEhsN3ptTHNnZWdGcHRVc3E2MmEvREdBSExpKzdraTNYczByRzhkYis0?=
 =?utf-8?B?c0hMOW1CQ3dnQ0UvTzZuRFluNXBCWG82OElwZ0lTVzdWZm5MbUV2SzVwbkdh?=
 =?utf-8?B?YTBucnZxaWNhTnFQeSt2SWZwaDNYaE1MUXhENi9JL25RZExTbG5VVnYrSWdp?=
 =?utf-8?B?Ty9SYnZOV3BzckwyUXQxV0drbUdwVktXSDBSUW0zNkhzT1pPNlRkcmc2RGk1?=
 =?utf-8?B?VU1scEt3YWpzb0htT2lFN0s0WnlOb1YwVUV4d3hoMkgxd0JHM0U4YTJVK04x?=
 =?utf-8?B?U2YrZjNwZ2hLOEs2anFuRklNeHpVTFZieW5vZjNhZGE1dUtONCtVUnZ6c1Ez?=
 =?utf-8?B?MkVXcUZRMFZGMGdBc0ppaGUwQzQ4Z2Z6cmFrK1ZQNjQvT0V1aFh4UTZlUXNn?=
 =?utf-8?B?SHVWNzJhZFVkNlM5QlRUZWRVbUJvQXVxbDhTRDdrVkRjV2JoNXAwZTJuUGFE?=
 =?utf-8?B?WFlTbWVPQXVQdGtWR2doeE15RE1CeUxLcjlQRU50ckVtTmZha1FDSldTSUdM?=
 =?utf-8?B?dEp3OEJpUy81N1FKVVRuUkI2cGlHS1RIUVAxVVBQQUdtNjFTTlhISCtZMW84?=
 =?utf-8?B?NFpyby9Ec2l1bkNjT3hXRWlTY2hDekN1N29HSDZCb1FNeWtDbjFDUkNXNWEx?=
 =?utf-8?B?bDU4MEhqM1RLalhYVjdXVHVTeGIvY2hFamJhMy9rRHBlWWxpa2o4WkxyMmxY?=
 =?utf-8?B?MTFXeWpnT3hqRVdjVENQS2RRenZlSDFKV0x2bUhpVUlCZ0lEaWtEbkpEWFB1?=
 =?utf-8?B?eUpHKzJlbHJuMUFqc0RQZ1YrMEZncXhsaDVHSXY1V1piTDZsM0lFaGNzQWJm?=
 =?utf-8?B?aTFJUFRBUWVqMnkwOXFOMmVXQThOYkw1SmZKcVo0ZmVxY3RvL2tkZzAxU0ZD?=
 =?utf-8?B?UkV0SkdGa3dNSWtobzJBRVNUQTBwMjd0dG9VbkYxOXJKZjJrb2JCUUk4bktt?=
 =?utf-8?B?MU1XendLV2dhTDlMVUFnYUpaanVsZVBqS21BMTd2cDVqWDdKU3ByT1B4YXhP?=
 =?utf-8?B?V3NtVWJ4a256ajl3cXlPdUF5eHBFZjNTRlVHbVIwL2M1WWJZVFVYd090UFZw?=
 =?utf-8?B?L2VDbU4yWWFiamlxSUNPeGFNRWs3Q2lDWDlNVVphWTF5a21aTGp5L2NPcEY0?=
 =?utf-8?B?VkdwYWpEdlc4cE04MGNUZDVMRXBqblZNVjhmdkxqU01PaHlOVkVhRUlwVGpV?=
 =?utf-8?B?aytyRFBWNVZ0V1dYWWwvckpDYnRQWUtxQkt0b3Z0UEZqbG4vQzM1N0xZblNX?=
 =?utf-8?B?b3FEMWozcmNZTURQejZ3VHNxTi9GQXFHdTVRQk85VGY3TkRXS3dqRXVJR2Zj?=
 =?utf-8?B?dDJDSWtZeEZCZitVZjBzc2FpM0FjRzE1QXpFYmdKNm01NmVaa1hHeEczQU96?=
 =?utf-8?B?RjdFQWczc2wyWUpZQXpDMkpXZEZQUDl3Nit4a1BxUWZ0UWZJL3pTcVYrTndN?=
 =?utf-8?B?eWxjWkdIWWR5dDJpNGVZRjNxZ0ZJNE04RWZBdFVBSWxIenRzMUFIVkkwT3ZX?=
 =?utf-8?B?c0lEMXY1MU5yNnMyK1UrOCt3SldXcXdpQkI1eFl1T2x6WmxjTGx1NnNrY3Zy?=
 =?utf-8?B?eVM3cHlzc2pGOG9qUU9XTmNwbjVzc2xLSW5tVmprU3hKeVpnSXJKRWVaWDM3?=
 =?utf-8?B?aDMydkl3N1I0dzJDTWJCcHNjRHgvRU1adW9Xd2JPdTN6MzBwSGVrS1dBPT0=?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7630eef-2000-4155-4b5f-08da6b11e002
X-MS-Exchange-CrossTenant-AuthSource: AS8PR03MB8689.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2022 12:09:35.8362
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0302MB3173
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I had a few questions and suggestions; below.

On 2022-06-29 21:40, Derrick Stolee via GitGitGadget wrote:> +Assuming a 
`200 OK` response from the server, the content at the URL is
> +inspected. First, Git attempts to parse the file as a bundle file of
> +version 2 or higher. If the file is not a bundle, then the file is parsed
> +as a plain-text file using Git's config parser. The key-value pairs in
> +that config file are expected to describe a list of bundle URIs. If
> +neither of these parse attempts succeed, then Git will report an error to
> +the user that the bundle URI provided erroneous data.
> +
> +Any other data provided by the server is considered erroneous.

I wonder if it may be worth considering adding an optional server 
requirement ("MAY" not "MUST") to provide a `Content-Type` header 
indicating if the response is a bundle list (or bundle) to skip straight 
to parsing the correct type of file? Eg "application/x-git-bundle-list"?

Even the simplest of content servers should be able to set Content-Type. 
If not falling back to 'try parse bundle else try parse bundle list' is 
still OK.

> +bundle.mode::
> +	(Required) This value has one of two values: `all` and `any`. When `all`
> +	is specified, then the client should expect to need all of the listed
> +	bundle URIs that match their repository's requirements. When `any` is
> +	specified, then the client should expect that any one of the bundle URIs
> +	that match their repository's requirements will suffice. Typically, the
> +	`any` option is used to list a number of different bundle servers
> +	located in different geographies.

Do you forsee any future where we'd want or need to specify 'sets' of 
bundles where "all" _of_ "any" particular set would be required?
Eg. there are 3 sets of bundles (A, B, C), and the client would need to 
download all bundles belonging to any of A, B, or C? Where ABC would be 
different geo-distributed sets?

I guess what I'm getting at here is with this design (which I appreciate 
is intentionally flexible), there are several different ways a server 
could direct a client to bundles stored in a nearby geography:

1. Serve an "all" bundle list with geo-located bundle URIs?
2. Serve a global "any" bundle list with each single bundle in a 
different geography (specified by `location`)
3. Serve a single bundle (not a list) with a different

Are any of these going to be preferred over another for potential client 
optimisations?

> +
> +bundle.heuristic::
> +	If this string-valued key exists, then the bundle list is designed to
> +	work well with incremental `git fetch` commands. The heuristic signals
> +	that there are additional keys available for each bundle that help
> +	determine which subset of bundles the client should download.
> +
> +The remaining keys include an `<id>` segment which is a server-designated
> +name for each available bundle.

Case-sensitive ID? A-Za-z0-9 only? "Same as Git config rules"?

> +bundle.<id>.location::
> +	This string value advertises a real-world location from where the bundle
> +	URI is served. This can be used to present the user with an option for
> +	which bundle URI to use or simply as an informative indicator of which
> +	bundle URI was selected by Git. This is only valuable when
> +	`bundle.mode` is `any`.

I assume `location` is just an opaque string that is just used for info 
or display purposes? Does it make sense for other 'display' type strings 
like 'name' or 'message'?

> +Here is an example bundle list using the Git config format:
> +
> +```
> +[bundle]
> +	version = 1
> +	mode = all
> +	heuristic = creationToken
> +
> +[bundle "2022-02-09-1644442601-daily"]
> +	uri = https://bundles.example.com/git/git/2022-02-09-1644442601-daily.bundle
> +	timestamp = 1644442601
> +
> +[bundle "2022-02-02-1643842562"]
> +	uri = https://bundles.example.com/git/git/2022-02-02-1643842562.bundle
> +	timestamp = 1643842562
> +
> +[bundle "2022-02-09-1644442631-daily-blobless"]
> +	uri = 2022-02-09-1644442631-daily-blobless.bundle
> +	timestamp = 1644442631
> +	filter = blob:none
> +
> +[bundle "2022-02-02-1643842568-blobless"]
> +	uri = /git/git/2022-02-02-1643842568-blobless.bundle
> +	timestamp = 1643842568
> +	filter = blob:none
> +```

Do you mean to use `creationToken` in these examples rather than 
`timestamp`?

> +Advertising Bundle URIs
> +-----------------------
> +
...
> +The client could choose an arbitrary bundle URI as an option _or_ select
> +the URI with best performance by some exploratory checks. It is up to the
> +bundle provider to decide if having multiple URIs is preferable to a
> +single URI that is geodistributed through server-side infrastructure.

Would it make sense for the client to pick the first bundle URI rather 
than an arbitrary one? The server could use information about the 
request (origin IP/geography) to provide a sorted list of URIs by 
physical distance to the client.

I guess if arbitrary is 'random' then this provides some client-side 
load balancing over multiple potential servers too. Interested in your 
thoughts behind what would be 'best practice' for a bundle server here.

> +If the bundle provider does not provide a heuristic, then the client
> +should attempt to inspect the bundle headers before downloading the full
> +bundle data in case the bundle tips already exist in the client
> +repository.

Would this default behaviour also be considered another explicit 
heurisitic option? For example: `bundle.heuristic=default` or `inspect`.
Is it ever likely that the default behaviour would change?

> +* The client receives a response other than `200 OK` (such as `404 Not Found`,
> +  `401 Not Authorized`, or `500 Internal Server Error`). The client should
> +  use the `credential.helper` to attempt authentication after the first
> +  `401 Not Authorized` response, but a second such response is a failure.

I'd probably say a 500 is not solvable with a different set of 
credentials, but potentially a retry or just `die`. Do we attempt to 
`credential_fill()` with anything other than a 401 (or maybe 403 or 404) 
elsewhere in Git?

> +* A bundle download during a `git fetch` contains objects already in the
> +  object database. This is probably unavoidable if we are using bundles
> +  for fetches, since the client will almost always be slightly ahead of
> +  the bundle servers after performing its "catch-up" fetch to the remote
> +  server. This extra work is most wasteful when the client is fetching
> +  much more frequently than the server is computing bundles, such as if
> +  the client is using hourly prefetches with background maintenance, but
> +  the server is computing bundles weekly. For this reason, the client
> +  should not use bundle URIs for fetch unless the server has explicitly
> +  recommended it through the `bundle.flags = forFetch` value.

`bundle.flags` is not mentioned elsewhere in this document. Might be 
worth including this, and possible values, with the other key 
definitions above.


> +Implementation Plan
> +-------------------
> +
> +This design document is being submitted on its own as an aspirational
> +document, with the goal of implementing all of the mentioned client
> +features over the course of several patch series. Here is a potential
> +outline for submitting these features:
> +
> +1. Integrate bundle URIs into `git clone` with a `--bundle-uri` option.
> +   This will include a new `git fetch --bundle-uri` mode for use as the
> +   implementation underneath `git clone`. The initial version here will
> +   expect a single bundle at the given URI.
> +
> +2. Implement the ability to parse a bundle list from a bundle URI and
> +   update the `git fetch --bundle-uri` logic to properly distinguish
> +   between `bundle.mode` options. Specifically design the feature so
> +   that the config format parsing feeds a list of key-value pairs into the
> +   bundle list logic.
> +
> +3. Create the `bundle-uri` protocol v2 verb so Git servers can advertise
> +   bundle URIs using the key-value pairs. Plug into the existing key-value
> +   input to the bundle list logic. Allow `git clone` to discover these
> +   bundle URIs and bootstrap the client repository from the bundle data.
> +   (This choice is an opt-in via a config option and a command-line
> +   option.)
> +
> +4. Allow the client to understand the `bundle.flag=forFetch` configuration
> +   and the `bundle.<id>.creationToken` heuristic. When `git clone`
> +   discovers a bundle URI with `bundle.flag=forFetch`, it configures the
> +   client repository to check that bundle URI during later `git fetch <remote>`
> +   commands.
> +
> +5. Allow clients to discover bundle URIs during `git fetch` and configure
> +   a bundle URI for later fetches if `bundle.flag=forFetch`.
> +
> +6. Implement the "inspect headers" heuristic to reduce data downloads when
> +   the `bundle.<id>.creationToken` heuristic is not available.
> +
> +As these features are reviewed, this plan might be updated. We also expect
> +that new designs will be discovered and implemented as this feature
> +matures and becomes used in real-world scenarios.

This plan seems logical to me at least! :-)

--
Thanks,
Matthew
