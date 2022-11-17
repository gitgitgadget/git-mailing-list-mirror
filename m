Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BBD4C43217
	for <git@archiver.kernel.org>; Thu, 17 Nov 2022 17:29:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235093AbiKQR3F (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Nov 2022 12:29:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234641AbiKQR3C (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Nov 2022 12:29:02 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05olkn2092.outbound.protection.outlook.com [40.92.91.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85E1E2CCBB
        for <git@vger.kernel.org>; Thu, 17 Nov 2022 09:29:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SkpRs86VxwLljCs7x7PtHMTnXkkiuNe4bdt9foY1aG601txNpb2/yvo9szWuAMdE+NXWXOdqv1hX59+iJvEgyjMSixF2gdtWDnxBKva8jwQTdtnITjO9wIk5X4Hcx30AjhMsmpeBuuv1EDB8FSTKKQqytl1xJFifR/fxlGO/toJeAn2wz5mWun9Hfw7y+LB8Gh+oA6PkSeL5YSbuDF5K2bFbA2+Iidv4mnVTTVzpsQngXbDDjjgPfNZYLx4UOSM+oN7ggLhWuYd8BqJUTm5sAsZIcXNl6c5l4348zXkVew3+aap+eLE7yQGfoVY5QGDp85NezOEINTa7P6nkmnSzpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vmE0RDIfzOOBFxHnFmli6NBUiWt6KHTvbJzpL+8Y5R8=;
 b=V8Bi+P4VJQ3aZZnwnYNuqflosRmYuRnM2CvDdscFzao9xuSZXBIiUiA75PK/iNzmb9u2/ySTuAopedhSDI2K91OoAtyzd4NSHg5Iqqvwe3eg3Z8lOxV8SXkdJRHqpdXCbj4k0WWA9osX4jV+NkRyLi5ypWYMuFpJ0HZIZmjhbZQyNlG3IrFb5rnRmHofO442mAeNf9fTZnlAt18Ymnh5hQP6DKNUAwtQoGDztBjiEbsJxicAgWCpM6xYsRWcgNcBT9aAdStXxC9pyJMBAchS51lr4zWJXa1/c7313tYXIX9wWPiDnJdSfzgh+CWOLZiktDDPzj0DYUCGyPbfbvr67g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vmE0RDIfzOOBFxHnFmli6NBUiWt6KHTvbJzpL+8Y5R8=;
 b=eHuDu9GrNZlTgqHUdh2ype0z7eTaFICnLgYiFE9ZMOmgfqF9PdeUjzDWx6VMPJazFVQKYUJt/ja2dDtOH047penc3XUY2KF/U5/2UraA5eEveao6NBLKfbiGfKcmkG6KhRYlPGkd4Ztcx4jux+/cxfTz4SGtPKXegAY7ZJ5BE0AvViMhIVlgq/r6NqxFzfVusghqa18+RUVQZ1mdNYzJHQpbyW8vBYaGx6f2YFfFj+Ow1t4B7PSpELrD+7MZ+OzEs+sYMjGpHkVwnqjFypIVMdux/VUh8yjfedhoYP7W+R9s1gN/bE6gT63u+eY3c9qUVfmN2d3TsuP5cKNwgZAYNA==
Received: from AS2PR03MB9815.eurprd03.prod.outlook.com (2603:10a6:20b:609::16)
 by GV2PR03MB8726.eurprd03.prod.outlook.com (2603:10a6:150:74::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Thu, 17 Nov
 2022 17:28:59 +0000
Received: from AS2PR03MB9815.eurprd03.prod.outlook.com
 ([fe80::e829:a187:754:6a85]) by AS2PR03MB9815.eurprd03.prod.outlook.com
 ([fe80::e829:a187:754:6a85%3]) with mapi id 15.20.5813.018; Thu, 17 Nov 2022
 17:28:59 +0000
Message-ID: <AS2PR03MB9815DCB5C310C4AC7B82D3A6C0069@AS2PR03MB9815.eurprd03.prod.outlook.com>
Date:   Thu, 17 Nov 2022 09:28:53 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: Re: [PATCH] Docs: describe how a credential-generating helper works
To:     M Hickford via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     M Hickford <mirth.hickford@gmail.com>
References: <pull.1379.git.git.1668217470500.gitgitgadget@gmail.com>
From:   Matthew John Cheetham <mjcheetham@outlook.com>
In-Reply-To: <pull.1379.git.git.1668217470500.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TMN:  [j3rS2JeyeIrqnihz1fdgfQgm/TamJtf/RRytL3en7a8t2lV0XNhE9/dcvmvwegVS]
X-ClientProxiedBy: BY5PR13CA0013.namprd13.prod.outlook.com
 (2603:10b6:a03:180::26) To AS2PR03MB9815.eurprd03.prod.outlook.com
 (2603:10a6:20b:609::16)
X-Microsoft-Original-Message-ID: <1d69e66d-81fe-3b30-665f-0f07c0043f57@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR03MB9815:EE_|GV2PR03MB8726:EE_
X-MS-Office365-Filtering-Correlation-Id: 54d6ac43-486b-478b-371f-08dac8c13628
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sMRBO1j+u5hoXuisDg4nTkV/ILQTUjI1IR5OicUe6Doj6lVE3mGNdW5MIAqV96MRQynZxE6Yqyf2HTNsK/BhLEziKgj78YU+mpoCR/rqEDEnTNnH1taP+0X/IhYrt2IWx+lTVPcMSWew+4gX2Qa1AMaokn3MwIiVfTh1zEQ1jGwMiDhqDMt16UiGDN1Pwzd39c56halK7hHnfINGA/K+tXBcrKiEjhBqnq5VnqX2XdDlNaQcOx5oH5250Rlzky1kvHdegbtLC+v/7g+iPZzAx4U6S81aebMeCJtBCX7Fp2IM5UxRuRR815ONRECPjRFXGgnm/VFIsyP7xq2axx7aQcNIR1gd1P07aaglQJ709eH9Cjno4Id6T2+H77CWUf7oqP5mWTtP8evWMJPTLzxsfcqc0HGqZX20VjQEeNwEpxI7to+YMGI+zznYwgQgTKNzX7BI+0cceINFpJ1DuqWSzjYxneSzLHuvSLbmQ201zCajMBCoaRLl8D0jqKTkwqJmjeJDv+GpZyRbNoNapadH+2jfNdWvmZ1INdGYHvTKr+7io9tZdOH+j6+Mvbs0Q1xEyQz9g9Q2d0I0CGMc5BQqM+FVJDUEiDMUSJ2FE6fNnO+hdLrisDJvLxK4hQAqyKIWEuRxFJ/l+q9sxQuiwa+AkRE27njwU54Z1jUDPTBE6HVMtNzMOvSZR75lECcW7ZEm
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Nm54WU5HVkdUanByWk0xTTR4WWZtTU1JMXRuSDBsZGtVK0pMWGIwYi9wMTdC?=
 =?utf-8?B?U1haTjh0cG5sWUlhenRaN2RHT0NWNmQ5RFgwcHQvRXRDOXk5SGgyUXgzYzFp?=
 =?utf-8?B?UzVISFdXank5N3dub1pQdXdVdFhtSmdGYlZyQ0FrZ2E3NlBEM29lajV1dXYw?=
 =?utf-8?B?Sk54b3RobGk4dXN6OHpLMUpjKzNnSzRwVW92WG1Wek15NWZtTkF1OVZxQytz?=
 =?utf-8?B?WnV1eXI3cXE2b09EZVRrQnhvZjVjeHlhNkFQVVc0WWxERTVUTFBSYXZBRlN3?=
 =?utf-8?B?UEJsVy9qeWxPSE42d0NiYmpJeFhyVnZVTUh1dEZQcktJMEhyUGdXNlRzNDVH?=
 =?utf-8?B?VWxHY0xpK1RiY0YrSGlUc29WN1RyckVBako4K0IyMUxncjdwOXJ2WG9Qcjly?=
 =?utf-8?B?ZDhGUnM0RjBBeTZwL1lRSi9UNGRLVnV3UmZmRm5UODczYUFqem5lTUlSV0gz?=
 =?utf-8?B?bkhQU1I5eHM1L2pGeitxRGRNdU5KV0ptMkFKVUpJS0lZUnc2QnQ0bzByaXE5?=
 =?utf-8?B?WUJvcmJieTdpWjFjU3lPYUM3NjJwQU9TYklhRUxVdU83c05NbjRhWk5jSEk3?=
 =?utf-8?B?djRpNUEra3VySnNyalNlQ0tDaEY2THdQOUY1U2h3LzRjNGp2dzBSNm03Vjlu?=
 =?utf-8?B?azNaMnFRVzVmbnIyMy9wcnRMZEM0bXFpM3hud29CMlhZUnJIS2treUMzZGgw?=
 =?utf-8?B?Qm9xSWw2SlpTYnRHSWw1VUFoRVFtOGJyVjZydFZDN0RpcnhvYzlPd1lWd0NK?=
 =?utf-8?B?YWRuTm80eXd2a0ZpdEFuTkJGc1RUdFFTanpqemNHc0lGY0YyUVB0VXg5azZY?=
 =?utf-8?B?Y1hvQm1ObmNNRWpQamZXd0FCdDV6b0swM2hFakpmWEdmV3VIbUo0UjFhMk1h?=
 =?utf-8?B?UitLWnIzc3UzeXV4NU9Xb2k3VzBzR1pqYXlrUUZveDZCVzBMMFk2SHdyZjBC?=
 =?utf-8?B?ejZ3RWRIdjNvb09rbkRCUTYxUzN3MmpxWGwxQW5jczdtN3dKcEQ1S2pEZjdu?=
 =?utf-8?B?bmQ1ZkVXQzJ3ZHdmb2ovSEd0ZEU4THlEN25Ja3dWejl1MTFVKzZoTHJTdlZ3?=
 =?utf-8?B?dVdCZ01LR2FKMzZuNXBrZ25IOHJTNHd3UlpEeVBPdElsQWVOYllUUnBxRlY2?=
 =?utf-8?B?dTNZOWxwN3BpRm4wN2RhUGg5Si9rSGdtaEVwM2JOR1Y5UVlXNG5mRnJibDkz?=
 =?utf-8?B?Rjc3NFBIUmVGMG1LeWt4cEFJbUxyS2FCWE9sRTZHeDQvaHhrMlF2SDd6ZHJW?=
 =?utf-8?B?WHI3RzROcFVQR3Q3V0RtSHNzdnhEaVVDNEJIVnlSb0kxVW16QmJiOFVhbVA4?=
 =?utf-8?B?QnhPYnYwMjM2ckxBYllqdForUWVlNG5ia2trbUdUZUR2TExEK25BYWhyenF0?=
 =?utf-8?B?TVh6b1pHVzQrRVZEWHBaalNTYTRhM0pXcEdGLzFWOS9pa3J1UWI5b3BWR0VY?=
 =?utf-8?B?dUtidktCbFloeUhHdWx5VjI5b1d0QVhYUjFoZFg0V05mMEkzc0ZmYUhGRE1Z?=
 =?utf-8?B?dm9nSkQzZlh4RmlKdkNCK1BzcFE5RFAyRkdUVDR2b0lScExFR0hidzFncEtr?=
 =?utf-8?B?TlErZitJVk42Q29GczNBeEZvbVlpNHdOQU5qeXlMeks5MHpkQ2tUR3VXcUJQ?=
 =?utf-8?B?YXNYdk5kejUveERtdWk2bGthTVluc0J1cno5ZEo5cmJnY2lNRER6OExYRUFB?=
 =?utf-8?B?aExVajZ6R0w5WklBcXRFeGlEZmZIVWkxZXZMcnhkL0VvTTRicFYvb2s0eG51?=
 =?utf-8?B?OUtTVlNZODR1RUtRN1FCWlR1MFlNUVF1ZzdrMDh1K0VlamdKWHcyNkc5N0Ru?=
 =?utf-8?B?TnZ2c1V5TXMvaXZiWUhUZz09?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54d6ac43-486b-478b-371f-08dac8c13628
X-MS-Exchange-CrossTenant-AuthSource: AS2PR03MB9815.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2022 17:28:59.4206
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR03MB8726
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2022-11-11 17:44, M Hickford via GitGitGadget wrote:

> From: M Hickford <mirth.hickford@gmail.com>
> 
> Previously the docs only described storage helpers.
> 
> A concrete example: Git Credential Manager can generate credentials
> for GitHub and GitLab via OAuth.
> https://github.com/GitCredentialManager/git-credential-manager
> 
> Signed-off-by: M Hickford <mirth.hickford@gmail.com>
> ---
>     Docs: describe how a credential-generating helper works
>     
>     Previously the docs only described storage helpers.
>     
>     A concrete example: Git Credential Manager can generate credentials for
>     GitHub and GitLab via OAuth.
>     https://github.com/GitCredentialManager/git-credential-manager
>     
>     Signed-off-by: M Hickford mirth.hickford@gmail.com
> 
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1379%2Fhickford%2Fcredential-generator-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1379/hickford/credential-generator-v1
> Pull-Request: https://github.com/git/git/pull/1379
> 
>  Documentation/gitcredentials.txt | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/gitcredentials.txt b/Documentation/gitcredentials.txt
> index 80517b4eb2c..72888402e73 100644
> --- a/Documentation/gitcredentials.txt
> +++ b/Documentation/gitcredentials.txt
> @@ -61,7 +61,9 @@ for a password. It is generally configured by adding this to your config:
>  
>  Credential helpers, on the other hand, are external programs from which Git can
>  request both usernames and passwords; they typically interface with secure
> -storage provided by the OS or other programs.
> +storage provided by the OS or other programs. Alternatively, a
> +credential-generating helper might generate credentials for certain servers via
> +some API.
>  
>  To use a helper, you must first select one to use. Git currently
>  includes the following helpers:
> @@ -286,8 +288,8 @@ For a `store` or `erase` operation, the helper's output is ignored.
>  If a helper fails to perform the requested operation or needs to notify
>  the user of a potential issue, it may write to stderr.
>  
> -If it does not support the requested operation (e.g., a read-only store),
> -it should silently ignore the request.
> +If it does not support the requested operation (e.g., a read-only store
> +or generator), it should silently ignore the request.
>  
>  If a helper receives any other operation, it should silently ignore the
>  request. This leaves room for future operations to be added (older
> 
> base-commit: 319605f8f00e402f3ea758a02c63534ff800a711

This looks like a good, clarifying addition to the docs!

Thanks,
Matthew
