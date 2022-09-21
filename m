Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C677C32771
	for <git@archiver.kernel.org>; Wed, 21 Sep 2022 22:19:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbiIUWT5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Sep 2022 18:19:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231185AbiIUWTt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Sep 2022 18:19:49 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-oln040092075034.outbound.protection.outlook.com [40.92.75.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3E6617045
        for <git@vger.kernel.org>; Wed, 21 Sep 2022 15:19:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JBA6ksX8nJE5TWhYjZA2BtBFdqA85LQ3gCXyuWVXL5edhFntY/HOIHSl8L29E7VwESosXtIdl4Ey5hUYEKur3c5Pv+14cGvgxLqL+Z+QflpziDugA4q0A3Doy0bt3wy8P0mxKjbTtXNSubyGenzsBy1jf0BsfVIb4Umo1ap8LOn8/15ki0LBGzKHeI4Yiq1UAZF4VwhJ/tYd+h5pvY3/cBd4H7XtOOg0saiilGAT8IIz59pWpcN/M2aUsvCxh8L731tTjPQWdNnNIQiMlCKEUZ8t9EeEUdSSvj7rLE/5mlu6okeGw8lQghLskO+6GmqeleQMiGEIsOmXGcdszMr1dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H/DAiJhDMqn7A8aBJ4M6W0BGmINytFyF9PQbodhEUUo=;
 b=eDsB8kRiKNOlTicIdkmQQH5+dKh6UNsTKtAmskeUAEUQPrfzx3bLI2TxbKtOep9qEQkUhbJx9UBv4X+CZQNHgqK/LuQasE60IVYZw4oyqJs9/AO6Y8/2UMmxaCTGvAFZgqJlJZJRsCB19e5VjMUcxdbgIhgEekaeNCwA6AThMYOwz2npRu7PCrYdC2sC++YsOS0PlGVISLsdD0iE16oB/0jfEkZOPBFFkyuIMx3HNLe06tjf9ZNY0e14qBD+uP2BarRs4wW28jhMR5Ij45vrnvz9QIkqeo4yd6G3urKmo2dE6qu1Wjb7clqNZDQ7MdNmcSNBP8w2ysf4WihPx7W/Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H/DAiJhDMqn7A8aBJ4M6W0BGmINytFyF9PQbodhEUUo=;
 b=BkjM680jdijew9sQ9ZgPShh3IsWxfkxLbUwRfihRZPJqpcleJYqUf6Fw6bIaGUsUlpSW/HtdcP5PeGXJF5XJMkxpbXfNIyDcFLzb/U6yorKbehwou70vUEFXa3kHXlpfOteo/r4qz6rCKpaEfdKecGxy4d+8BodpsbvjRCCtEIS/a7KEonCFa6HqUzzVxJzJ5dJ6SOpiN1hkK1RFTFxaVfnH81lUN3OdugvcNOgoKj+Kc5kaO6F5tsubTfRQpmidt0trg4bLoMB5/LKZclXQ/Us/Ni4obF0zlLVfO/+1vlDANSqnhoNqLLYibtPwEfaPGiVXEsYTE46+r2I9omcZqw==
Received: from AS8PR03MB8689.eurprd03.prod.outlook.com (2603:10a6:20b:54e::12)
 by PAXPR03MB7917.eurprd03.prod.outlook.com (2603:10a6:102:214::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.18; Wed, 21 Sep
 2022 22:19:43 +0000
Received: from AS8PR03MB8689.eurprd03.prod.outlook.com
 ([fe80::10:9a9a:64a9:612d]) by AS8PR03MB8689.eurprd03.prod.outlook.com
 ([fe80::10:9a9a:64a9:612d%4]) with mapi id 15.20.5632.021; Wed, 21 Sep 2022
 22:19:43 +0000
Message-ID: <AS8PR03MB8689B42AC5CAD6D4002C3C2EC04F9@AS8PR03MB8689.eurprd03.prod.outlook.com>
Date:   Wed, 21 Sep 2022 15:19:37 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH 0/8] [RFC] Enhance credential helper protocol to include
 auth headers
To:     Derrick Stolee <derrickstolee@github.com>,
        Matthew John Cheetham via GitGitGadget 
        <gitgitgadget@gmail.com>, git@vger.kernel.org
References: <pull.1352.git.1663097156.gitgitgadget@gmail.com>
 <452acd3b-14bd-a3c8-df58-39b5e9edfd0b@github.com>
From:   Matthew John Cheetham <mjcheetham@outlook.com>
In-Reply-To: <452acd3b-14bd-a3c8-df58-39b5e9edfd0b@github.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TMN:  [f5zv0G4dJfPTVNoGXbTf5CzW2zSH3A1weFNIsAmtLh+9Zmj6YQURMwgop6NLrOfs]
X-ClientProxiedBy: BYAPR06CA0033.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::46) To AS8PR03MB8689.eurprd03.prod.outlook.com
 (2603:10a6:20b:54e::12)
X-Microsoft-Original-Message-ID: <6988aebf-5aee-3f84-734b-e73eb7ed6992@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR03MB8689:EE_|PAXPR03MB7917:EE_
X-MS-Office365-Filtering-Correlation-Id: 85475d8b-51c7-46f9-ade7-08da9c1f621b
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l6RMayPaF9kLDvJlIQc8+Utx6nhSLvoNfeRRZIy2HBsYNpbnj3NUIOHWqjQ2Z7hJnTiZBFXllH/zsnlEEKvv4jNL9QoVGtoAe7xmVeBpzXIb/3zMhRJWDf6lIvoAT9nxJHj+loZC7tQYPQcvQF1NU590HLGUL3J4so0l/V6C6cNU6XjBb1M/wTPh5zprbhNAqMH2lAwyLIgqBTtJQfxCib/hCIbPU/i1Z2/md4Sw/Bdd44OoK9hzuwpJuHtizmlcCN104RiEJPOzPKwpjTcJbl0EKK41qlakluvQS34AqE4rDHrEoVyXFCMQsYUR/DVgHv2QaAZPDEjSdPSbO83TIXwzltxsk/1URAOPJacAqdZSkctbpvyZEnQ78BEtRiqz2WI7jdDVTEJ8Tkm/Gsgmvv6eWsaUiSp0Ja8L4KugWpDsiZ0h3LxPD0bCaZIzLE5Ec6zCAuJObUUpduB9i5yIpzLYOZo1eZGqSTBGRAKMfYbDm9kV0A1Ibw6kyHob3ovn8+/Dpk0EB43YS0RU9knnejhMcBqqm3wa+IRxa3QyKV5W1Eoq7GnijyzxcVNsY6bsbv8ZbOeBvVNBgtVyn3dhnNWXVuJhB56ZnX8QhaMDyi1QO3rKUMIsZOyzURmfzvS6LEfRs411I/OWnxX1d3BcUEusWP3lKFkY7p101CjoJMue5irtG29fmDkNn44BhI50
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UkE2aFZPZmdjSmw5bGw2SmV0VlhsU3dieWhwNFp2M1hBeG0zSFpmazYzTkJn?=
 =?utf-8?B?MkFyMEgwWWhWNGhCMVpWZGFQQjZ2Z3pSc21HbHJXNnU5Si9GWUlaOWRLYjVE?=
 =?utf-8?B?bUNPQTNlc0RaUGpMdXplY0huekpHNys2WVhkeWF3VHNNbUFXQ0svYUtRYStT?=
 =?utf-8?B?ZE5yWHpkNlhnVnpsQnR0Kzgrc0tRcEh4VmVwdmxQTmpyRndNNHJFOTM1S1RT?=
 =?utf-8?B?NGNHRkdlVmZDbjlVY05sZy9Ta01qdFMvRUdWeHRWQ2pReE50dE96b2RpaUhh?=
 =?utf-8?B?YWpiaTVEZnFCQ09wUGNWWGRXeWxCaTNxTnBJMi9JVHozTEN3RGNlNU56SG9t?=
 =?utf-8?B?UUVnckxiamxBSjNBVlM4SXdHcVBNcEdrL2ZhV0lHR0Noa0FDaUl2dzllVkgy?=
 =?utf-8?B?cmNIZkNWOXZraEFuNEQ0c3E1dFdCWUJFdjN0amtHTXBFTjZUQ0lnUGl1eUlV?=
 =?utf-8?B?Y0tJMCt1VDRldWpFaWt0bEhSa2V6NFdIRERHVmswT0tpNUtubndxLyt6UDN0?=
 =?utf-8?B?VXJ4amFuRzd3RVhRUjh0VWc0V2dzWHk1ekxtNHM2Z3p3ek9nSEFQSFJ1Smdj?=
 =?utf-8?B?Y3pNMnZiVXlxbFFYTWJkbTZFVXpvM0p0MExUS1IyUnkybUMwVFdlazcwNEI0?=
 =?utf-8?B?L1loZXozZkhqclJzTVY2Z2xmR2ZGK3VmQXVORWk1dUtVNUxKcVV4N05BYXdn?=
 =?utf-8?B?SHdDWkFKSXo5bkZmajNOOVBod2NLN3N1VFBlOU9Ud212S2NMWEhvOEI5TXVt?=
 =?utf-8?B?QWtVbVQvNEFnOGZhaDRLUUpYWVJ5SkVJL256TCtiQ3Z3MExRZ1FQaXowSlVh?=
 =?utf-8?B?RTlCenlnVFZtR3NYY1pIdFRiWU8yZFV2TTNkS2l0Ky9SdmI0djBoUEhVcGJk?=
 =?utf-8?B?YnlrR1dWRDYvcUFLakR6Rm5NL1FHd0hUdVg4M3FsQlFHMklIRWhRTGo3bmwz?=
 =?utf-8?B?blhXekJyNklFMUpSaXNqY3hZSllZeW9uMlRTYkJ5MUF2bUZWaHdsSEY2M05u?=
 =?utf-8?B?UXVSVmR5SlcvR3ZyTG8reU8yd2tMVVFVdDNXaEhIZi85amRxbGFjV1RSZUd6?=
 =?utf-8?B?WFErUkNKZm91Zk5UNFAxaGwvQUtDVTQzVWYydmE1cWs5bGhaWHcrVkRTc0JE?=
 =?utf-8?B?OTY1b3RBSVg1K09vNmVxaks5OEl3YnhtLy9DbXJkRVFaMGE3UVVvVmRYR01Z?=
 =?utf-8?B?MXNFUmZTTVQwdXNybGpoUkdCQXZYR3lKT1l5MlU1TkV5L3N0d08xNytrWTVo?=
 =?utf-8?B?aGxuTVZWTkFhREtyc3hZWjJ2OHdNKzBDdXVKSGRXY2NPQUhQZW9iVGFLZXcr?=
 =?utf-8?B?Y0pCbnViekFuMFVLQkE0Q29lR1FaNkkvQVZCU1h2K0ZaTlJyQStDMFY1NkZ6?=
 =?utf-8?B?QWMxYWNSakUvSFZQOUNzNTNidjR4RXZMYVh0K0lTK2NPWnJtblEvMDlrS2Nv?=
 =?utf-8?B?ZnRlbW1EOHpGNldrMGFobEEvWENBNWE1aEg1RHJVV1BrTm9lV1lJV2NLOUdW?=
 =?utf-8?B?UzBaaW50YTN5ZElnQ3pPQjlxa1FkK0E2YiswSFdtc3c1Qi9zRnJGbHdockJZ?=
 =?utf-8?B?VVlraCs5QXNrekhPT0RDbWtNRjZ5VHo3M3JJWUhrUjdnZTIwbDZ5cldoQTRp?=
 =?utf-8?B?VU8yWk93VHJKOHlRb2pCMzBhT1lyVldjZ0xRVmpaeFBmTXZYRUtGZmVsYVZO?=
 =?utf-8?B?S2FQTG40TjgyNE1acTNPd0Znb3hqb0NrZkdiSUVJZnZPQXVyckV4WDU3aWJF?=
 =?utf-8?B?RWhUcFIySDljaVUwZ0NMb1UvT2RLVFR0czhPcHUyL1VaS0ozck93MFVPeTE3?=
 =?utf-8?B?U1BMd0R4Skk1VGNmOExIUT09?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85475d8b-51c7-46f9-ade7-08da9c1f621b
X-MS-Exchange-CrossTenant-AuthSource: AS8PR03MB8689.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2022 22:19:43.4932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR03MB7917
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2022-09-19 09:08, Derrick Stolee wrote:
> On 9/13/2022 3:25 PM, Matthew John Cheetham via GitGitGadget wrote:
>> Hello! I have an RFC to update the existing credential helper design in
>> order to allow for some new scenarios, and future evolution of auth methods
>> that Git hosts may wish to provide. I outline the background, summary of
>> changes and some challenges below. I also attach a series of patches to
>> illustrate the design proposal.
> 
> It's unfortunate that we didn't get to talk about this during the
> contributor summit, but it is super-technical and worth looking closely
> at all the details. 
> 
>> One missing element from the patches are extensive tests of the new
>> behaviour. It appears existing tests focus either on the credential helper
>> protocol/format, or rely on testing basic authentication only via an Apache
>> webserver. In order to have a full end to end test coverage of these new
>> features it make be that we need a more comprehensive test bed to mock these
>> more nuanced authentication methods. I lean on the experts on the list for
>> advice here.
> 
> The microsoft/git fork has a feature (the GVFS Protocol) that requires a
> custom HTTP server as a test helper. We might need a similar test helper
> to return these WWW-Authenticate headers and check the full request list
> from Git matches the spec. Doing that while also executing the proper Git
> commands to serve the HTTP bodies is hopefully not too large. It might be
> nice to adapt such a helper to replace the need for a full Apache install
> in our test suite, but that's an independent concern from this RFC.

That's a good reference and possible solution to the testing question, and
definitely something I can look at adding. I just wanted another pair of
eyes and thoughts on any other options that I may have been missing in the
existing testing repertoire, before embarking on writing such a test helper.

>> Limitations
>> ===========
>>
>> Because this credential model was built mostly for password based
>> authentication systems, it's somewhat limited. In particular:
>>
>>  1. To generate valid credentials, additional information about the request
>>     (or indeed the requestee and their device) may be required. For example,
>>     OAuth is based around scopes. A scope, like "git.read", might be
>>     required to read data from the remote. However, the remote cannot tell
>>     the credential helper what scope is required for this request.
>>
>>  2. This system is not fully extensible. Each time a new type of
>>     authentication (like OAuth Bearer) is invented, Git needs updates before
>>     credential helpers can take advantage of it (or leverage a new
>>     capability in libcurl).
>>
>>
>> Goals
>> =====
>>
>>  * As a user with multiple federated cloud identities:
> 
> I'm not sure if you mentioned it anywhere else, but this is specifically
> for cases where a user might have multiple identities _on the same host
> by DNS name_. The credential.useHttpPath config option might seem like it
> could help here, but the credential helper might pick the wrong identity
> that is the most-recent login. Either this workflow will require the user
> to re-login with every new URL or the fetches/clones will fail when the
> guess is wrong and the user would need to learn how to log into that other
> identity.
> 
> Please correct me if I'm wrong about any of this, but the details of your
> goals make it clear that the workflow will be greatly improved:

Such a scenario where multiple identities may be available for the same DNS
hostname would indeed be improved (with an appropriately enlightened
credential helper of course). As you mentioned, credential.useHttpPath can
also be used to workaround such a situation, but that just creates another
problem in that users need to provide the same set of credentials for each
repository with a full remote URL path that use the same identity.

By providing information about the auth challenge (including parameters
like authority or realm if present) would allow credential helpers select
or filter known identities and credentials automatically, avoiding user
input.

>>    * Reach out to a remote and have my credential helper automatically
>>      prompt me for the correct identity.
>>    * Leverage existing authentication systems built-in to many operating
>>      systems and devices to boost security and reduce reliance on passwords.
>>
>>  * As a Git host and/or cloud identity provider:
>>    
>>    * Leverage newest identity standards, enhancements, and threat
>>      mitigations - all without updating Git.
>>    * Enforce security policies (like requiring two-factor authentication)
>>      dynamically.
>>    * Allow integration with third party standard based identity providers in
>>      enterprises allowing customers to have a single plane of control for
>>      critical identities with access to source code.
> 
> I had a question with this part of your proposal:
> 
>>     Because the extra information forms an ordered list, and the existing
>>     credential helper I/O format only provides for simple key=value pairs,
>>     we introduce a new convention for transmitting an ordered list of
>>     values. Key names that are suffixed with a C-style array syntax should
>>     have values considered to form an order list, i.e. key[n]=value, where n
>>     is a zero based index of the values.
>>     
>>     For the WWW-Authenticate header values we opt to use the key wwwauth[n].
> ...
>> Git sends over standard input:
>>
>> protocol=https
>> host=example.com
>> wwwauth[0]=Bearer realm="login.example", scope="git.readwrite"
>> wwwauth[1]=Basic realm="login.example"
> 
> The important part here is that we provide a way to specify a multi-valued
> key as opposed to a "last one wins" key, right?
> 
> Using empty braces (wwwauth[]) would suffice to indicate this, right? That
> allows us to not care about the values inside the braces. The biggest
> issues I see with a value in the braces are:
> 
> 1. What if it isn't an integer?
> 2. What if we are missing a value?
> 3. What if they come out of order?
> 
> Without a value inside, then the order in which they appear provides
> implicit indices in their multi-valued list.
> 
> Other than that, I support this idea and will start looking at the code
> now.

There are two important things this extension to the I/O format provides:
1) multi-valued keys, and 2) ordering to the multiple values.

You are correct that dropping the integer index still means we still meet
requirement 1, and implicitly meet requirement 2. In this proposal I was
just being explicit in the ordering - it's not something I'm overly
attached to however, and may indeed make parsing or identifiying these
multi-valued keys easier on the credential helper side of things.

> Thanks,
> -Stolee
