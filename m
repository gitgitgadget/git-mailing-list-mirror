Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E8D4C4332F
	for <git@archiver.kernel.org>; Mon, 12 Dec 2022 22:03:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233715AbiLLWD0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Dec 2022 17:03:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233606AbiLLWDP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2022 17:03:15 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05olkn2025.outbound.protection.outlook.com [40.92.90.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F78510B70
        for <git@vger.kernel.org>; Mon, 12 Dec 2022 14:03:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RaAc4AECIP7UXKlN1ye8W1QRShZMO96cEjUxch+oPlHuEZgHvdqoYcmR8DbrkI8l44R/0Thvxk8aAy2Wc7/D9dvmVVFJ/iKAps7/NDVBeKgrmSic4rgQPFH1v1VXU5Gq17Z0qbPlkCROPOK9ieZq4yDREnKp0Pe72Bbd0tDjPG/ojIXibMEdhiNPnaaVGlLEIowfQ6Eycwe8v2qVRNIaDzq3mMRFnbU9l2E1wOEh/cmZ5Q+f6UxUvgD+HbbPgYjNpEvmkCItFSO5N+BYNvhY3HFVZXRKcpeiS2OlN23GCpGpTycdqetpCS3IAhFQ5AweHV9KEuTpmDTVuSxfYsuiXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=usMqvDOuEWUP6IYreGe8U8l3SQozyybCRuhVK1c816w=;
 b=fRXMPj64ZrkUksD2xB8FoXWW8LOKin2uYcR1bnuyaNWFOSd0kxRuQzNedkvlufNh0HnbBXWBQAI7gGvGE49ZJn7A+EjE+R934gJQY9e1FkO4++yqWTC+/KnrmDttGLE2vkDkjRPH1YDVY4rqZCx9JWwUDvqvJ2rPnqhXmnrkZWiIhsFnvPR1CAKRxZ0NxIMNRwjIYf59Y4ehsiTg1Ki5qZZac/ylsJ9q3pWNOKyQhMHkBVfrGrbDxgWV7XacE2iaJP9w87r5B2KuIwZAy4sDXPPpcXs8RM/cLvJedYsDhgbRCJi/2QSeJ7pd5x+i76dbn1h1xhcOF0vJCk20fjEjDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=usMqvDOuEWUP6IYreGe8U8l3SQozyybCRuhVK1c816w=;
 b=KmUadr0StcLyJ99q4P9IJTxAjA1fe1TJpcVSzuA9a1gums51tRzsSU9fhchAENTlnK314FsEBoDTXyx37YWpapVaATlNwh0lZniPknwOP+pbUO5+8kkHxK/wfvqiSlQgtI5rOEM06u+nQ2GUas8HLOJoYz3gp1aATB3N2PCRICMVPAo4Bg2VZqJ3cnb8vF1Y4WePBPGKuyNKs/M78OzBJGV8B+nbWNKTkr8iAHbrYzP/iHVuwScS+N75lmhyajgeuLRakEOb1mPn7EotQKDDHd3ubvxZnqnnur+nOWbQc/L7JEAFYFo7w5i3scGik8N/fJoH3QF3Am1zeZK0g0UjFw==
Received: from AS2PR03MB9815.eurprd03.prod.outlook.com (2603:10a6:20b:609::16)
 by DBAPR03MB6407.eurprd03.prod.outlook.com (2603:10a6:10:192::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.8; Mon, 12 Dec
 2022 22:03:12 +0000
Received: from AS2PR03MB9815.eurprd03.prod.outlook.com
 ([fe80::e829:a187:754:6a85]) by AS2PR03MB9815.eurprd03.prod.outlook.com
 ([fe80::e829:a187:754:6a85%3]) with mapi id 15.20.5880.019; Mon, 12 Dec 2022
 22:03:12 +0000
Message-ID: <AS2PR03MB9815D67BEFBE5E48B83A5406C0E29@AS2PR03MB9815.eurprd03.prod.outlook.com>
Date:   Mon, 12 Dec 2022 14:03:05 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: Re: [PATCH v3 00/11] Enhance credential helper protocol to include
 auth headers
To:     Glen Choo <chooglen@google.com>,
        Matthew John Cheetham via GitGitGadget 
        <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        M Hickford <mirth.hickford@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Matthew John Cheetham <mjcheetham@github.com>
References: <pull.1352.v2.git.1666372083.gitgitgadget@gmail.com>
 <pull.1352.v3.git.1667426969.gitgitgadget@gmail.com>
 <kl6l5yfn4tj7.fsf@chooglen-macbookpro.roam.corp.google.com>
From:   Matthew John Cheetham <mjcheetham@outlook.com>
In-Reply-To: <kl6l5yfn4tj7.fsf@chooglen-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TMN:  [ITS6kFm4pr0L6POhYBMRf5O+Vu2nr4XDsd2xs8ZrD9SM042RyP0jNoC6CkauXE/q]
X-ClientProxiedBy: BY5PR13CA0034.namprd13.prod.outlook.com
 (2603:10b6:a03:180::47) To AS2PR03MB9815.eurprd03.prod.outlook.com
 (2603:10a6:20b:609::16)
X-Microsoft-Original-Message-ID: <8423a6d4-50c2-151b-57c7-b8ca3d95ab5d@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR03MB9815:EE_|DBAPR03MB6407:EE_
X-MS-Office365-Filtering-Correlation-Id: debef604-87f4-4c85-d3af-08dadc8ca90a
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4RF9vrb5CY9lGxyTXGwa1ifthnLKyfxHMzjAm/rxXX377frLZkBju/Qp4yzDC8LfO0+SO63eTl6FCN8UTghLKGgKhONiFWTtztgIuP5QvwW82Qbfxdo7x6x97gvLQHINd54lSroz0n9tSrrh56PZKoXoVAkkMPw4sUUCXrYD8CGT/o6ysI7xj0oXL5xP9CtcTwUhGSWjFTavMqCofMImfxK0d1PFub+ysR/Q6hYjTvLCfDAU1Rv/YHozZP+jZr9chjzRUqvxObFhwzd+cIApcVrvswNUhlgSTh0Bc4ROxo9pM1M1L7Gvr2roTtzrPahA5gV+X3mGtRKuihE4RslFijsgRP8vCSrXkh9IoEggfx5doiGFWx42LKuwJ1szf7Kp9miBmvIDsl3CZBjhPr+cUL1BIuYTjEuleYaDZvDEmIZEmJ9xZ+xv/mel9IFKeMy+0v9sx5n8vP6GivEx612X3FWDJKVPFFXcteVwjg43BhyrLN9s3NyF59kRiOw7tt+xINvHGYP6E3DeUPgxmvLm+oYdDCpxK0FtgJIQUp/c7GYZshrrvYKo6J+sj4cJ8dhoF1yW1NAyv3T20tgqpbgj7mK6qlxwvyo8YrgZN7uWlz/a2FmEDh56TlYh7wFXweba5ci0GINh8tWhEER8QhuAN0cuAHM5vh/v9x6pkrs4UvU=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UG9NSEtIWVBrMWtLaHR4SU53OHE2RkxWc0s4ZWo2VXd0SnBvem5DaU1xbWsv?=
 =?utf-8?B?cVV4QUcySHBFbW1lZFNWOUJuNWhmV3V2K1Q4UUlmbTlCZWVJRHlCRzc3WFlF?=
 =?utf-8?B?ZnBZa3Q5c2xuMnR5RU1LOE9KYnYrRGpZNWo1aTduOTdlcWZ4cGVUNEw5ZU1W?=
 =?utf-8?B?MnlvaGpxREdlZDdNNmhZRWI0SmZhUStlTmNvTEZnU2tEN0lVQ3cwYmhBdzh1?=
 =?utf-8?B?ZWNwNHluRUNXRnRoZVNHbm1RWDdsWCtKeFNmTmZXMG40Z0xMdUhTTXhINTF0?=
 =?utf-8?B?Vnc3b2hFbnY5Zm1kWXFQVmlpUktNWjBTenNsK2U3Q2hwN3ZOaTM0RFhFb0Zu?=
 =?utf-8?B?azN5NzJ1d1lnYWZpVVNUQWtacGRVSXdaZ2VBZTVWbXlKcFdRdS91S3pBQjJ5?=
 =?utf-8?B?SGVja3pUc3NUUytOM2h3TnlSSE0reWxjS3dBZmROdnNtdEtIQ1h6b2srN1lt?=
 =?utf-8?B?TktWK3hRbWJzUlk0TWhRVTZmVnU2VTgySURmVE5EUFZlbkZwM05uNUV4ZUN0?=
 =?utf-8?B?cURwbWhGbGRGKzRGbnFwUXJiRmFMbTU4WFYvMXVtYS9TSWNPTEhLNjJzWGZI?=
 =?utf-8?B?cEE5bVpaSVQ1YzNvQ0QzZzFaVmd2SFRMMTFrejdHaUs0bWx0QmZxRDViSHd6?=
 =?utf-8?B?S0dMT3pIRWhnUzkraXFxWkk2U1g1cVN2RHhiQmVXOExJQ25iNUgyNHhETmVk?=
 =?utf-8?B?aEorcW1DWHN0VEpLcjRjdmhUSVl6dSt0OGNXdGpsczBGWWxGdnNUYzd3U0Jx?=
 =?utf-8?B?bGVBM3NXV2k2dDg1WllFOWNEQWpvSjh1ak9xQ2luZ2pRUUlKOXdjY3JGbDQ5?=
 =?utf-8?B?Ry9OaXJvWm5uZDJsOEtGZTRIUDBxcC80SXJhdlpoVjBneUlZdVhNYmlnTEZv?=
 =?utf-8?B?V1RIMG1iQkZnZFFhaUd3NHpKNHlEcnB2M3FQSklldGVubU9YQVppOGxlQm9B?=
 =?utf-8?B?amJHdTBRT0t6T09nQ1RhN3VrZERnSkVmbG1mQks4N2puY0hTZ0JKeGFsb2JD?=
 =?utf-8?B?Tlc1dmxBc2E4NDQxQ1dtdmFMbVB3emlpbC9oSnNyWEk3UWovWU56dnJvYlNO?=
 =?utf-8?B?VlFQeWVTSlZLZnpyUHMrUkFDdWJ5c3dEMVhUeCtyZGVRd2Nla010VzdGSDNa?=
 =?utf-8?B?V2c5Yzl3a2htZUY1MFNMdzh2QVN6aXhhazd3NURLeXB4amZ3L0kyS0VocWpk?=
 =?utf-8?B?alNJM2t1ZFFEYmt2QlF2S3Nqc0cvNWhZbUZKaTlNYmtYNHdpeWNNMnJsLzh6?=
 =?utf-8?B?YjUrRGF3NG5reVI4NXRHelFJNWNtMHpOVGNYWHBhWlNRTnNLWDBaTFh1b1FW?=
 =?utf-8?B?dkVjK003cmdZYmFheUh3TFphbi93bENiNmxncnNvK0dneGhnaVZtN1hrdTcr?=
 =?utf-8?B?aFlxQTk1eEFlOEdPSHVVeFY4WGJ3RVZ4TTA2eHI1VHlHUTg1bDZMc2ZrZCtP?=
 =?utf-8?B?c2RHcFNWYjg0N0poT1AvckV1SDYzVWVYL01PR2c5akZsaWZMUWMzM21JOUdp?=
 =?utf-8?B?eU91V2Y2N1VBTkpHVTQ4VXEyVjJkN3JZUlFDZ3YxcFA3V1hpUDJzTTdKekgw?=
 =?utf-8?B?RlpibzNYNkhNa1k0M2FZOXU2b3JiQWxYS05lQ3NuaUNyb3V0NmhSdnZUZ2pk?=
 =?utf-8?B?UXJKcHlzWENtT3dPTWtYb3Y0K0VtRWVZVk8vckZVN1VkNU9pc3Z4c0h2R2Ix?=
 =?utf-8?B?TkFPY2EvZkpUd1UyeU5TRnZhbkttYnhIMmxOWm9lRnh6aEVSeksvdDRUdHBh?=
 =?utf-8?B?clFqMFExcTJ1UHI1a1hhV1dBMllGZDNmRnNidTJRK3lVa3JVa2NicnJYbGQz?=
 =?utf-8?B?Q3pIdlFKdlVsTVVOcVkxdz09?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: debef604-87f4-4c85-d3af-08dadc8ca90a
X-MS-Exchange-CrossTenant-AuthSource: AS2PR03MB9815.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2022 22:03:12.0312
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR03MB6407
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2022-11-09 15:06, Glen Choo wrote:
>> Proposed Changes
>> ================
>>
>>  1. Teach Git to read HTTP response headers, specifically the standard
>>     WWW-Authenticate (RFC 7235 Section 4.1) headers.
>>
>>  2. Teach Git to include extra information about HTTP responses that require
>>     authentication when calling credential helpers. Specifically the
>>     WWW-Authenticate header information.
>>     
>>     Because the extra information forms an ordered list, and the existing
>>     credential helper I/O format only provides for simple key=value pairs,
>>     we introduce a new convention for transmitting an ordered list of
>>     values. Key names that are suffixed with a C-style array syntax should
>>     have values considered to form an order list, i.e. key[]=value, where
>>     the order of the key=value pairs in the stream specifies the order.
>>     
>>     For the WWW-Authenticate header values we opt to use the key wwwauth[].
>>
>>  3. Teach Git to specify authentication schemes other than Basic in
>>     subsequent HTTP requests based on credential helper responses.
>>
> 
> From a reading of this section + the subject line, it's not immediately
> obvious that 3. also requires extending the credential helper protocol
> to include the "authtype" field. IMO it's significant enough to warrant
> an explicit call-out.
After some consideration I've decided to split out #3 here to a future patch
series. Parts 1 and 2 surround Git to credential helper contextual information
which is still useful in it's own right. Part 3 should really be expanded here
to better cover and explain the reverse helper-to-Git direction, whereby
helpers can modify Git's response headers to the remote.

With 1+2 most of the benefits of having an enlightened helper understand the
auth challenge, and intelligently select identities is still possible. Remotes
just need to continue to extract tokens from the basic Authorization header as
they do today until then.


Thanks,
Matthew
