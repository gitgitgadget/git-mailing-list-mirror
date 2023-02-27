Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B221C64ED6
	for <git@archiver.kernel.org>; Mon, 27 Feb 2023 17:18:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbjB0RSa (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Feb 2023 12:18:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbjB0RS1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2023 12:18:27 -0500
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01olkn2024.outbound.protection.outlook.com [40.92.66.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61F5722A3E
        for <git@vger.kernel.org>; Mon, 27 Feb 2023 09:18:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IC7tCpXnwh6vw6CXr9S2lVQ0MRVHGgc/emN3vx54KO5ujvdrwdkn7fS81H6D5T2Wv+mLzS8lgPwijM5TRV0c2gt7/ObVx7OqVIMTL89TUtpceROtRktTcn34zioQFAzsJYTnupG6RE81339hssuVJ5kUwqnRYU7hpKznLxh9TN71G8fAlKsjw0Pq+2amlEtufmi0r29NxR7vnLFsCMydfm1rjOnxVE0aEpAxwZhTGHkoQOlRGKQRlK29xKu+j7EzgaaEgxiFwCJtCaPe9Fzig07RyY1wWqS4lJNnj/i6mrb3pMpMgD+w9ekOB7xRjEsG8OedB/XcGkVrlKBjEb+0Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EX3uIiqeq3B0NfcI2FTjzC82Bn3Onc24zoyssNIhJqE=;
 b=k7ZOl5uSPlJ04w3EpKjkDWWmU60LVSQO0hmNlfVzOCAc6oMbGQPmuVeDnTvFCZiA5VUCTTdLnGYeZ3EquXFL/Dl3tYbM9fNmcQAqrkoFlFoIsJHBTE0gzHnhsv/J8l4Rr/87EhwkNhDi9qhYR9DLi+LuO9ZGEUX34UX/Xrgi7g1aFP2M+aV41hqt5cyc4G7JjA8JZ18tX+Bd4po3bq4dvYm/eh+Y6oiDId9BmR01hROdVqjMQYZTfhjcWwSSEQ8ksQBg9tRPXvtDe9k9CX/R23JKUvjBo/ltPURccsT/U05sN2RRVxsuhB0ypzFDEE9MOXVJyN6Xlmc+WKk0oheE0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EX3uIiqeq3B0NfcI2FTjzC82Bn3Onc24zoyssNIhJqE=;
 b=eVD3Yzazihd1hf2aJtdkAlnIaSsNBtTefiffPWUUelQR8IZERCtnv2aFwPrvvzlWkogzr4WI8dAEyZahkA10a1/uVRJtwId/NiqQDiIrH4MdauWrTrHaq1aDeXKgbr9IQhOipR9tqkJykl0a8CkIwIQ0wVh2kkNZqKDZBKWSZcy+cP+cxClzTMzslhbbL1/LyECEatRl54uM6sNzteQrlzLN7vufVuIrbB8/Z+k9HpZa8ISFLEOrCahXHYhDAm1nFRLDslHGJLYYmmLYYOFH8wpH0OVuVBombfBGY0OGT+CGn2/GRa8lqiNNIJaFt9jP6N5wfepqbGVGscv5+lKY8g==
Received: from AS2PR03MB9815.eurprd03.prod.outlook.com (2603:10a6:20b:609::16)
 by AS8PR03MB7351.eurprd03.prod.outlook.com (2603:10a6:20b:2eb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.29; Mon, 27 Feb
 2023 17:18:18 +0000
Received: from AS2PR03MB9815.eurprd03.prod.outlook.com
 ([fe80::7674:1fe5:785:a469]) by AS2PR03MB9815.eurprd03.prod.outlook.com
 ([fe80::7674:1fe5:785:a469%7]) with mapi id 15.20.6134.029; Mon, 27 Feb 2023
 17:18:18 +0000
Message-ID: <AS2PR03MB98155ADC85C730AF0651A3C7C0AF9@AS2PR03MB9815.eurprd03.prod.outlook.com>
Date:   Mon, 27 Feb 2023 09:18:11 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
Subject: Re: [PATCH v10 1/3] t5563: add tests for basic and anoymous HTTP
 access
To:     Jeff King <peff@peff.net>,
        Matthew John Cheetham via GitGitGadget 
        <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        M Hickford <mirth.hickford@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Glen Choo <chooglen@google.com>,
        Victoria Dye <vdye@github.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFz?= =?UTF-8?Q?on?= 
        <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <pull.1352.v9.git.1676496846.gitgitgadget@gmail.com>
 <pull.1352.v10.git.1676586881.gitgitgadget@gmail.com>
 <f3ccc53055acf5d5c25d0ad3eed3867ea8670e55.1676586881.git.gitgitgadget@gmail.com>
 <Y/cu7K5uFjvOMXLu@coredump.intra.peff.net>
From:   Matthew John Cheetham <mjcheetham@outlook.com>
In-Reply-To: <Y/cu7K5uFjvOMXLu@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TMN:  [y/HfbobNf80TPJPkXGNGzcCBL7o6NWxqXybCVIJXppicFf+qXQKIZlh81tA9GhDZ]
X-ClientProxiedBy: BYAPR06CA0024.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::37) To AS2PR03MB9815.eurprd03.prod.outlook.com
 (2603:10a6:20b:609::16)
X-Microsoft-Original-Message-ID: <81b9bb94-689a-bc8f-1725-b6ca550a79d2@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR03MB9815:EE_|AS8PR03MB7351:EE_
X-MS-Office365-Filtering-Correlation-Id: a7845e64-e9e7-4a4f-3d2d-08db18e69e4b
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G+eyZ3NHKlNJm8/YugcqrV9lAjACYUOqSVnGB8Sa2NP08AcXa604nhmDdAErS+YVOQnOR9ZAGiirnSKfuVwQIelb/HVdLDifQjjnYs6YaJTQfuHrgHV/tkrFc0AYJCdClUUBqI/L/WP2Y6RYR/pa2R7biDUjokZnaH9+M0+uDJhIeCnP8VJUXGthPbXPtEyWPQ6I9BdZsBi7Ue2ypplbkDZ9eWr8iplHuc86g3Zi1v14qCx/8AkzJINbEwcxDbnQLs3aA9StQiJk9V21CAGj4U2pqlkpMuXNd9iAr+NGjiYBel4uoMG6+6LuEjcQk8XJjD2hG2PzU39wC6SxJr/qkjfzfmdcBwbb9HdWbyqyESR5c1gqrS83uZoiYhBFdv8o8Vi2DUez4ErPfqOwR1id6OEUCDiIJobWgD9Acnirv/GK/CmZ9M9zo4WJxel8n7ZeETSm29QAGXfHckeN9tdrMRDIn+PMrk13WESLuUgUPHBhsQY+jtjeAby7r7hePbAOHwg8tJoc8RCcKi4uY7KHnS3zeFB5mUKxX9G/p9v8R7jSD6jBqoHku6I1aaJ0YPdPGSdGqRNah6ty01/Mlg3/m2zEj10xqnxIRHySGv9I2pR1DlMu6w5J/boIe4cBWecwjnk75N8+3HhUfypAuA1Z6g==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a3lGRHFLWlJMR2F6bXNHVnBYaGx6aEo5alpWZzVHdUtqbkRhWlcyRmY5dk9V?=
 =?utf-8?B?cVZGZHVKODd6VkJjdExWQ2dsY3YxSElsVDdCNmdyVW9nc0g4YXpsYUp4Slpo?=
 =?utf-8?B?NVBPQ3ZZMzZJZjVnMWlKRTNoVTNmZlpOblVrSTJiWHFpUGZxS3FhSkxhN3dv?=
 =?utf-8?B?Q3FSSnNMbXF6aTEwbW5jZVhtT2ZNK0J0NmNjOGhWV2tiYmF2R3hFcnhKaUtP?=
 =?utf-8?B?emNGZ1Q4UmxHRFJkb3Z3aEpUT2JTc245N2dlcWVzY3l1YzAwSnEweENSSGZY?=
 =?utf-8?B?bWQ2emsxRmVEVFZHUG5IbUxKUnArVWJiVjgwb2w0eUxWZFhPaStkSndlZUtX?=
 =?utf-8?B?dHBwclJWV1FUWXB4K2FxVHBpb3ZOUFdjeVBpT0VmRW5Bb1pXYWtTaC8wbVBL?=
 =?utf-8?B?Z3dMR2RiVXdLZUpEMDhrQ1VrKzJucUF3WVlhd2N5clVQRGxQMHlmd0xkSzl3?=
 =?utf-8?B?MnB3bWV5c05ocEdvSWVpWHM1ZXV0dzlmanFXcDF6NlQwa2NhbTdnSFFEd2tj?=
 =?utf-8?B?b3ZkVVZScDB2Tk54aVRsb2RheHcvZUkwZ3NjL3d5SUlsK3FPMXYwMmJ0N0pO?=
 =?utf-8?B?TXBtUWtDZUVEQWlmcUhDZjcyZnpKWkEzV3hmVlRmWXQwdlhQa2hjcUxOZHcv?=
 =?utf-8?B?NFkxdFFWNVYxcDF5RytidWgwTndBVHAzcVYzaW0xaTdHSjBsMFBXMUU4Wnlo?=
 =?utf-8?B?T2Y1eHR6ZDgrQzBraXYyRnRMUGhZY0ZueTBVUlJIWGVRRitZeW9LSWY2Q1BW?=
 =?utf-8?B?eVNmYW81VUVMN0szSDhyaWlYRHJld1czSzhLZlBORWVqUTlEQ21hRDE1NFVl?=
 =?utf-8?B?TkR3ellPTnRxemIvQ2dYUEUwT1BJT1lyVnpVbzhzY3hWdGFzdXREVzhaQlBE?=
 =?utf-8?B?WFFncVVON2crMHYvR3lmZW9oRzlCbERwNUxCYmtjdDZEVlZmUGV4OFZnMUl0?=
 =?utf-8?B?ZS95SEJjcjZWOE4xKzBSS1c4WUc2bGRTR3Z5ajJBNjFlTHJGT3lSQjhVWkxM?=
 =?utf-8?B?bWdiUUV4OTVhOGMrdWVhRjJrS1k2aVUvZnJiZXZ1WnFTMHBoa3MzT1dNNDV4?=
 =?utf-8?B?bmd3eXpDa2lYMm5lcTJ3MStHaFVrOFlNT0JXbFBpOWxXK3dId1crdlR0MmdU?=
 =?utf-8?B?clJxVHQ2YzcraE9icVhNaU1URE9ybTJ3SW5JZGZkcExrOHZIOXdWSUlPcXlM?=
 =?utf-8?B?TVNSanA2Z1VtSzJsY0d4ZGxTRW9Oa2pobU5QYTBvN1Y2MlZIR0hPdURtSStp?=
 =?utf-8?B?ODZtb2k0c0JJL1crQU95UVlqbk5WaUEwc1VRV1phcXJQeUhwL1ZPUDRDSm45?=
 =?utf-8?B?bzBDUHpOVlFkd1ozL3F1WjdoUDJTZC9iekhwc1ZuS1RKeVovT0dqR3F2dFJE?=
 =?utf-8?B?SmxxaUxjRTZtdUJvMm90UTdDdGNVa3JwTHF6WVhwVUR4bGZSblc0QUtFSVVY?=
 =?utf-8?B?NmF1NzhoRjhQa1IyRXpQZzVHdEd1VmhiclFzckpHc040a0pHTmV1eXNxakhV?=
 =?utf-8?B?K2J0UnE1RXpYSEVhbm55OVlQY2RiZGxQWWljWks1dHBENHYzUFgyeVprVjlU?=
 =?utf-8?B?WHVTOEJMRyt2RExzbDhsZHJKZGpSOVM5eTNmYUFBQmkzVGluelJBRVUxQWxr?=
 =?utf-8?B?TkFhMWtERHY1bDVSQWtUWEljdnRZaXg0VjJXcDYxMFBoQkg1TFc0S1A5WEtO?=
 =?utf-8?B?S0taSHBiWkxGeGo5TWc1bnFLT2tab2ZEMld3U2V1ZC9sLzg0eUdubElRdU9h?=
 =?utf-8?B?MlhwQTkrUTVIRFhJQVM1ZEV1VVlkWThBZG0zUW1WaUVsVW1RNjRCZk9LdEsy?=
 =?utf-8?B?UEZEL1kzM2lzNjFET2dOQT09?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7845e64-e9e7-4a4f-3d2d-08db18e69e4b
X-MS-Exchange-CrossTenant-AuthSource: AS2PR03MB9815.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2023 17:18:18.3614
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB7351
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2023-02-23 01:16, Jeff King wrote:

> On Thu, Feb 16, 2023 at 10:34:39PM +0000, Matthew John Cheetham via GitGitGadget wrote:
> 
>> Leverage a no-parsed headers (NPH) CGI script so that we can directly
>> control the HTTP responses to simulate a multitude of good, bad and ugly
>> remote server implementations around auth.
> 
> Hmm, today I learned about NPH scripts.
> 
> Obviously it works here, but I have to wonder: is there a reason we need
> this? AFAICT the only thing we do is set the HTTP response code, which
> could also be done with a Status: header.

Yep - I think you realised why in a later email. It's because Apache is
doing some CGI -> HTTP header normalisation, but we want to control the
exact byte output of WWW-Authenticate headers for exercising the new code :-)

> I.e., this passes your test:
> 
> diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
> index ccd5f3cf82..1eadfa4bbc 100644
> --- a/t/lib-httpd.sh
> +++ b/t/lib-httpd.sh
> @@ -140,7 +140,7 @@ prepare_httpd() {
>  	install_script error-smart-http.sh
>  	install_script error.sh
>  	install_script apply-one-time-perl.sh
> -	install_script nph-custom-auth.sh
> +	install_script custom-auth.sh
>  
>  	ln -s "$LIB_HTTPD_MODULE_PATH" "$HTTPD_ROOT_PATH/modules"
>  
> diff --git a/t/lib-httpd/apache.conf b/t/lib-httpd/apache.conf
> index 2aac922376..0f9083dd6c 100644
> --- a/t/lib-httpd/apache.conf
> +++ b/t/lib-httpd/apache.conf
> @@ -139,7 +139,7 @@ ScriptAlias /broken_smart/ broken-smart-http.sh/
>  ScriptAlias /error_smart/ error-smart-http.sh/
>  ScriptAlias /error/ error.sh/
>  ScriptAliasMatch /one_time_perl/(.*) apply-one-time-perl.sh/$1
> -ScriptAliasMatch /custom_auth/(.*) nph-custom-auth.sh/$1
> +ScriptAliasMatch /custom_auth/(.*) custom-auth.sh/$1
>  <Directory ${GIT_EXEC_PATH}>
>  	Options FollowSymlinks
>  </Directory>
> diff --git a/t/lib-httpd/nph-custom-auth.sh b/t/lib-httpd/custom-auth.sh
> similarity index 94%
> rename from t/lib-httpd/nph-custom-auth.sh
> rename to t/lib-httpd/custom-auth.sh
> index f5345e775e..8bf07e9398 100755
> --- a/t/lib-httpd/nph-custom-auth.sh
> +++ b/t/lib-httpd/custom-auth.sh
> @@ -27,11 +27,10 @@ then
>  	# status line.
>  	# This is only a test script, so we don't bother to check for
>  	# the actual status from git-http-backend and always return 200.
> -	echo 'HTTP/1.1 200 OK'
>  	exec "$GIT_EXEC_PATH"/git-http-backend
>  fi
>  
> -echo 'HTTP/1.1 401 Authorization Required'
> +echo 'Status: 401'
>  if test -f "$CHALLENGE_FILE"
>  then
>  	cat "$CHALLENGE_FILE"
> 
> 
> The other, more invisible thing happening behind the scenes is that
> Apache isn't adding any of its usual headers. But I don't know of any
> that would interfere with our goal of doing auth here. Is there some
> feature you're planning where it would?
> 
> I think you could argue that it's mostly a matter of personal preference
> and doesn't matter much either way. But all things being equal, I'd
> usually go with the thing that is simpler and closer to the rest of the
> system (e.g., I think you kill the ability of http-backend to return a
> non-200 status, though I doubt it matters much in practice).
> 
> So I dunno. We are on v10 and this is arguably a nit. Mostly I'm just
> curious what led you in this direction in the first place.
> 
>> ---
>>  t/lib-httpd.sh                 |  1 +
>>  t/lib-httpd/apache.conf        |  6 +++
>>  t/lib-httpd/nph-custom-auth.sh | 39 ++++++++++++++++
>>  t/t5563-simple-http-auth.sh    | 82 ++++++++++++++++++++++++++++++++++
>>  4 files changed, 128 insertions(+)
>>  create mode 100755 t/lib-httpd/nph-custom-auth.sh
> 
> Most of the other scripts here don't have an execute bit. They get one
> when they're copied by instal_script in lib-httpd.sh. The exception is
> error.sh, but I don't think there's any good reason for it. So probably
> not a big deal either way, but another nit. :)

Oh.. that's something I missed. I just added the executable bit by habit.
Will remove to match the others in lib-httpd/.

> The rest of it all looks quite nice to me.
> 
> -Peff
