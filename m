Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1D55C433EF
	for <git@archiver.kernel.org>; Wed, 15 Jun 2022 17:40:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241916AbiFORk4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jun 2022 13:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbiFORkz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jun 2022 13:40:55 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2083.outbound.protection.outlook.com [40.107.220.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFA9B53C40
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 10:40:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C4OT4DRd/KBYC+CX/Jb3kdb9IWNE4f00IxHhcpY4FNo0PGpvIig/XIVkafYmTPwONPcLByJPUwNhEtowqGkGf33qiOMEcWXny4IwSm+/rRoIb7hibKGrSB3N1t4RV1ZJg9MewJP/aVCVHgPsaiBIDOgsToQ2W3tADaXFtlLj7fg5DAEc6LRDgr6bwKo+S0p65iJhDWrxend90qBNEsIICQxYjAKxEftqDXjrlMtRchcRKNiazLeAw+TmhuWG6QNmzB8EujD2y91yYlqaBohEDaMbXrcGO40PovKTjfRq2WM770ZJJhtjkvuUULTzdZtZEDqFId/PXE7DX9EDzEL/5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QacNhMAt8XUpoqOmH01kAmW3FgXrwbOY8VnWpiBmLq8=;
 b=GURPky1i3bjgCioP+dhA+aEd2by1O086/I2cgIB1z8KDLgblckTBHp26JeMOgBzxUlfvlroUh9d68ee66tH0zBzXWGmg27ASJpKnsDmBXguN5M+Z2ZzpvIK1OAeuuxWM4OuHrADU+k47JAvBTDQfFExacZ/5vPHLSzqExGoHuhhpwjvZ56FwzwFs+LQ7RpXOLlK1ncz0neX/kcagEJezwhaz6j3FYDPImnBbo02ZPtPcynehyvuFGfVQKSV/DdvZ3ZOcZGyHjHtqrh2QWvXuwf+v1xr2IIbvWVIZ99O2tUTHciAE5vxZefIdid6pfDsN7barZ7dZnAJOwi9Nk2J8cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=roku.com; dmarc=pass action=none header.from=roku.com;
 dkim=pass header.d=roku.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=roku.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QacNhMAt8XUpoqOmH01kAmW3FgXrwbOY8VnWpiBmLq8=;
 b=faMZ978J1BHaI+RKmE+S641DXb6egOElMqsiZhbbC653/rKh87yFpucfyNYhB7TOhl3zYems/Qt422B+4obZGEtBm/Rn3my2XADOMnEtIZ1cF0/cAAbvi7LaazBQ2m/EIjagrNvL6zZDT/MeXVeGzJwtM1MwpGoFXRVhei8LXwhTStlRryWSdQfC5S33zOAqaW7frmd0aXRFqnbTE6rtMvTqim+/qqjWhtFsUVdu6GyhdYnijR+gzta8q7YKWVroNGFF59XoYwyu8Ws0y8+HsDUZtCYDBEbjvHZ8EDzkuSdKIKetv6r7im0stHtF9g4mfTQGhRdIor9sPVW+U6gAmw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=roku.com;
Received: from CO1PR01MB7225.prod.exchangelabs.com (2603:10b6:303:160::21) by
 DM5PR0102MB3416.prod.exchangelabs.com (2603:10b6:4:a9::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5332.20; Wed, 15 Jun 2022 17:40:52 +0000
Received: from CO1PR01MB7225.prod.exchangelabs.com
 ([fe80::1062:158b:2993:5535]) by CO1PR01MB7225.prod.exchangelabs.com
 ([fe80::1062:158b:2993:5535%8]) with mapi id 15.20.5332.022; Wed, 15 Jun 2022
 17:40:52 +0000
Message-ID: <ad9b5ec9-14fd-cd66-be87-2fe1eb24296a@roku.com>
Date:   Wed, 15 Jun 2022 18:40:46 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH] mktree: learn about promised objects
To:     Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>
Cc:     Derrick Stolee <derrickstolee@github.com>, git@vger.kernel.org,
        jonathantanmy@google.com
References: <77035a0f-c42e-5cb3-f422-03fe81093adb@roku.com>
 <0067c46a-7bfd-db9c-5156-16f032814464@github.com>
 <797af8c8-229f-538b-d122-8ea48067cc19@roku.com>
 <574dc4a9-b3c7-1fd3-8c0e-39071117c7f0@github.com>
 <YqkpRE8nykqVv8cn@nand.local> <YqlZb3Ycc71+dPu4@coredump.intra.peff.net>
From:   Richard Oliver <roliver@roku.com>
In-Reply-To: <YqlZb3Ycc71+dPu4@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0201.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:318::10) To CO1PR01MB7225.prod.exchangelabs.com
 (2603:10b6:303:160::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4868e8ff-3026-47fc-95e7-08da4ef6312e
X-MS-TrafficTypeDiagnostic: DM5PR0102MB3416:EE_
X-Microsoft-Antispam-PRVS: <DM5PR0102MB34161333064064960DDD2FC4CFAD9@DM5PR0102MB3416.prod.exchangelabs.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W1qZuppdgeoncDc5XC1uKAU6J1pkg+0QGtXaJtOkhFH9GgvD7yMEgRxZPHHl+GES/8ZTv3K4O7ns7ZNvl+mK9pP5FI1hy4ROzITIX060b78DqxtOcBu+3dApxuJJrjObp5pLJBeaYKUZUyg9ZtqCqbL/ePaXs0PDimHn8WzXtceU6KhOj47m0cBSJL0bWehY1/hFPoUJNFQj0tslCtQ5dDjQFE31O/AHiPG+LT+gklF+gZzPZCw4jwIF7WAYjvf394oBYGrJqd+Gc9WKYdylU+5IlKJKfxxvZALp9HHTxzgdxrXKzBd7feZtR8zIC2qWVPjSHPENIeyyevsxCwD9Ccz7OpZF1kEOUw1Ln0r8yNXiH0ee3nEArQ2lQLoU7gfsctigPpPleQEDC9j6+VCfOpWyvdMljypzB44jP0jtJ+UEA2pbUdad5s87hdW3BmkvgW6PJjeSy18q/M/1Po3rOVbIl90/rOKct8Ae897+sE2jLczk2l1L+aYFL73densmXvLZ0IoztMoxBIS90qzIA3IoZ+E0qJmv80yPhFwYVX16hn79gONDJ0oEiX+DLMI9j7mT9Y4Wa3A5pbauBLYdKEmqyvU+QkytLQjWlP6qtQdIguSaCgB3YKgSt2y2/K7zV0htB0tVq6jJfpaCvvKJLZdoMAcCTJKatusbAd5xY86QgZI31Go8C2S/7xmN4PjataKLew6OR9Ov4LX4DE4tZA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR01MB7225.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(31696002)(6666004)(66476007)(53546011)(38100700002)(186003)(6512007)(2616005)(508600001)(83380400001)(6506007)(86362001)(4326008)(31686004)(36756003)(8676002)(8936002)(2906002)(110136005)(66556008)(316002)(6486002)(5660300002)(66946007)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SFRkbmhGMFgvRlp1OFhYMDE4ZnBzWUt4RC9BbFlncG9vZ2I0T3A0akh0aDlQ?=
 =?utf-8?B?UjFnbzlyT3ZxdkdnbjZseE5PMFJraExSd0hYTjdwOVFzQTlGdTZtMitPcWVl?=
 =?utf-8?B?N25sWVlmUlRKdE9JSC9iQ3F5WjNoVlQrZzZvSG9WNjJjUkhWZG1EdHJ5Wk04?=
 =?utf-8?B?Y1BiNlFLUmdIbC9EREh3Z09ZQmNUT0kzNm5qUlV4NjJ2eG9EeWEvWlR4WnJC?=
 =?utf-8?B?eUxGaVg5L0d4emhENW5mNGZYSjBmMk95OWRaQ0lYM29ZdUp5eVg3NGd2V0pJ?=
 =?utf-8?B?VmtPbEswRmptV0xvVEljM2ZMQXpQU08rWjdWU3NtcE9TUityV1RaYUVnK2Za?=
 =?utf-8?B?WUtVYUpIR3lRUi8zckZZZkNTQmp4OGxRYXhHcC9KNXN2bStMVHdRYUxEcnpn?=
 =?utf-8?B?bE9iTzhPSzA3U2xTY25IZkJsdkVvdGdKQlo3QjlyWWRGTW5saDhXRVZHQ1hy?=
 =?utf-8?B?NXRUSmd4ekRaeUtQSDNad0djZk96cEdua0x2cXF4MldmSWlETGkxUzhYdG84?=
 =?utf-8?B?d1lmeUtPMm5mZE1UU2lRaUtnWGRrclcvdnIyTEE3VlhWOG1GU3VySVd3b1Vw?=
 =?utf-8?B?UWtnVmtnYmZxWnVIdUdoK3RuU1pDVWNVZGtkZ0d0aGZzNWtFZmJrWlVyUVVF?=
 =?utf-8?B?aERGR29HM05RSis1Z0VSRGJIWUxnVmhoMkFXK2FDdDUyUXg3cjNqa0hKc00z?=
 =?utf-8?B?UW9kT3RqZXJ1ZDkxOFFFbXBUT1k0Y3Vac3Y5Wlk0QmxRdjdlaWRiTVdnSzVP?=
 =?utf-8?B?QTBiVWRacSs2MmhzMXZpTElQWDROZWFjM1lwZFUwczhhYk5weHZFNXRNaEVL?=
 =?utf-8?B?REZ6RU12UjdqSWFlWHpUWVcvNmlyMzdrbmwrYmdSUk9zeWlIZ2lqT3o2K2hC?=
 =?utf-8?B?RENNMVl3U0dHSE1wdGJMM2dlbkIyWjlieUEyUlBXSUlxWUh6alpEMFJkL1B5?=
 =?utf-8?B?cWFkL21zbGRieXpKRENvVE9TQ00rZ1dwYVNxb1lmUW9GZ01DY0kvN2JmL1la?=
 =?utf-8?B?QllTNEx5MndYdVRFQUtTV21OUkJjSXg5dXQ1T3YvYVlva3B1c1ZKTmR6d0pM?=
 =?utf-8?B?L2VtWXJsdWZnNU5OanRJN2orY2RaRDRtV3J4VVZKOTdtYnRoUng5alFBOVNF?=
 =?utf-8?B?V2hIaU0xWVd6TlJtTVcvRXBlZ2g5QWxCTFRUU1ZLUzBkVEhQd2FJTFpMSjNW?=
 =?utf-8?B?RXF2SlZyRWl5VHpiWW02UGRCNlNXRmtpQVhrOVlhRlRNOXRMekVEUXZwNEh6?=
 =?utf-8?B?YXpUelFCYTVJdkpxRFB6QTNXOFFTdU9kMTFuK2NsOVZ5bDZKWEYxWGU3RlMx?=
 =?utf-8?B?Y2w5L1NRSzRTZnRyNHN2UEF1RXpjTXJDM05KU3MwN0ZibG1wa0dEV3pzYkZt?=
 =?utf-8?B?dVk5bFN4djZBVDdtTEtURG9SZG5vZEZJQ215WGM2Yzd0em5BcWw1TVQvZEpv?=
 =?utf-8?B?NEU0S3VrRkc2V1VHeTRYUDdzWllBSTBHUWc5MzhKZGhScTlwSk1vclJHdUpQ?=
 =?utf-8?B?ZkQrTjhPcnRMMzhjMXJCMHIxaDN2UkkxMGxBZTdLakZTcDI2QUYwNUc4WFRC?=
 =?utf-8?B?dFhtQXVKblRMazBkako1eVJEUVhMQ1pGalQ5MmNicWJNVTl2Vy9xZ2EwbHk1?=
 =?utf-8?B?bE1keEdkUjUrVWRzRFpkSlZhTkpQYjdna2xVSFUyZmlLczV3VnBOREZoc1M3?=
 =?utf-8?B?MjkwMUlZV2VrZnJoeDl6a0ZuNXJZSE9XYnF5dC9VUHNBUWFtdkJHL3RMVHVW?=
 =?utf-8?B?OWUzMDBWeVVkcklIZkl4emV1M3BlWU1Ya2dsS05FWmYvZkM0Ymx4UkpLTjBv?=
 =?utf-8?B?SGR3ZHo2N0c5STRKdTVzRVU3cXk3eitvY0pERFlwb0ZBMFNTcHlGcER2QmpW?=
 =?utf-8?B?K2t6cG40V0VPS2FodFZDM0VsVlpJNW02aWZPeEN3VFRvNVhYZjc4eHlwNzd1?=
 =?utf-8?B?ZU42alY0dWpKM1pEajhETGZxZVU0bkR4cHFtVVQyZmxqK3NnTWMrbUx4TERs?=
 =?utf-8?B?aTlHcURhcHJxNWxTMG84bUNEZVZmb0lMMHlhYW9pdXJqZ0pHU1VBcjA1MVAy?=
 =?utf-8?B?UlNxV2MzcG83Ty9Xais2ODhmODJzV1hYNjBkTnVVTm1oa1dMSWJybmVqUzlO?=
 =?utf-8?B?ZUZlL2V1cUNpaTEzZzI3Nnlhenc3M0NLR3BRUTQvS3cxdWFPTTRPYlVwQ3U2?=
 =?utf-8?B?MTQ0WDBXcDc0RDZ3dHo5UnQ1UldETThJMmlBVUp6YkpWcDUzRUg4bmVmdzZU?=
 =?utf-8?B?dXhydjUweFBycENqdmdXNllDZjlMUHJrVzMzVHNNR3RtUXBCcTgyakdZQVF3?=
 =?utf-8?B?aUs2T2tpL3R3ejZpUThlblNBZ3lMdU9YNy9CSXUvbk12NE5KMnVFSGt2TWpP?=
 =?utf-8?Q?7GOI6I+TGdr2kpILQv94FD5uFSO/BN7VgwX0G+Rs5ajuo?=
X-MS-Exchange-AntiSpam-MessageData-1: VcktrdOqJpZmnw==
X-OriginatorOrg: roku.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4868e8ff-3026-47fc-95e7-08da4ef6312e
X-MS-Exchange-CrossTenant-AuthSource: CO1PR01MB7225.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2022 17:40:52.3698
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00fc7e42-ad65-4c4c-ab54-848ba124a5b7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JpPezlI2M9qO91khOoMRvCTu3znOtwtqbJIB1TwLzq/WMvK2zx4c/ZtIOE9xAQJSzDtvupIP7n4WCWvArXu0xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0102MB3416
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 15/06/2022 05:00, Jeff King wrote:
> On Tue, Jun 14, 2022 at 08:35:16PM -0400, Taylor Blau wrote:
> 
>> On Tue, Jun 14, 2022 at 01:27:18PM -0400, Derrick Stolee wrote:
>>>> Did you have any other sort of performance test in mind? The remotes we
>>>> typically deal with are geographically far away and deal with a high volume
>>>> of traffic so we're keen to move behaviour to the client where it makes sense
>>>> to do so.
>>>
>>> I guess I wonder how large your promisor pack-files are in this test,
>>> since your implementation depends on for_each_packed_object(), which
>>> should be really inefficient if you're actually dealing with a large
>>> partial clone.
>>
>> I had the same thought. Storing data available in the promisor packs
>> into an oid_map is going to be expensive if there are many such objects.
>>
>> Is there a reason that we can't introduce a variant of
>> find_kept_pack_entry() that deals only with .promisor packs and look
>> these things up as-needed?
> 
> It's much worse than that. The promisor mechanism is fundamentally very
> inefficient in runtime, optimizing instead for size. Imagine I have a
> partial clone and I retrieve tree X, which points to a blob Y that I
> don't get. I have X in a promisor pack, and asking about it is
> efficient. But if I want to know about Y, I have no data structure
> mentioning Y except the tree X itself. So to enumerate all of the
> promisor edges, I have to walk all of the trees in the promisor pack.
> 
> So it is not just lookup, but actual tree walking that is expensive. The
> flip side is that you don't have to store a complete separate list of
> the promised objects. Whether that's a win depends on how many local
> objects you have, versus how many are promised.
> 
> But it would be possible to cache the promisor list to make the tradeoff
> separately. E.g., do the walk over the promisor trees once (perhaps at
> pack creation time), and store a sorted list of fixed-length (oid, type)
> records that could be binary searched. You could even put it in the
> .promisor file. :)
> 
> -Peff

I like the idea of caching the promisor list at pack creation time;
I'll start work on a patch set that implements this.

Meanwhile, is it worth considering a '--promised-as-missing' option
(or a config option) for invocations such as 'mktree --missing' that
prevents promised objects being faulted-in? Currently, the only
reliable way that I've found to prevent 'mktree --missing' faulting-in
promised objects is to remove the remote. Such an option could either
set the global variable 'fetch_if_missing' to '0' or could ensure
'OBJECT_INFO_SKIP_FETCH_OBJECT' is passed appropriately.

Cheers,
Richard
