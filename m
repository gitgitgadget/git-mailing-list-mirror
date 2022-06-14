Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A69A0C43334
	for <git@archiver.kernel.org>; Tue, 14 Jun 2022 16:33:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344328AbiFNQdx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jun 2022 12:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243953AbiFNQdv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jun 2022 12:33:51 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2050.outbound.protection.outlook.com [40.107.220.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A62FD248EA
        for <git@vger.kernel.org>; Tue, 14 Jun 2022 09:33:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ByHcZG8RhcYMeGozSYXDSqZ1AaIvCMBlMvXao6Oh9L/sibK9dlokwxVoM0PkwWlCwOkh93CmkdodVJ+XzarZRgv28K90JM4jP1zcWO8vMnRErSl5TNMqktJ9pn7cRo3zGh12x4cXVbTH7QDpFvH8HYshDayyH3Qj6v/5sHztioHEp9L7Y5Gnp+FeHjKH710uk8ABLvb28uA56Vi4at1D9t7P/ThrkQxFgTpy/Esox+xz/JCe4iWup9iD52rvb8A27Qb8JfnB9kv/+yALmzp+/RMcIQ4aWLC2j30BY39wqUFS4tkVyaLNnsP1WRHEmbEO7L+DPlZbubioeEMo7ECyHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AiDrk/Jh7Jgpcy5rxOUWpqG2fkNZyh1NUbgTcA8mAes=;
 b=hL7rs3tIcEhBF+Rk+SShdtrk9nk8tTF8gGHniyfJqAlHAIVb5z3eEsCxEm/gXVxpk7h0x19JzoeXfliD4bTmrsBe6yqJ+R/zXdlnarWfXGBzVx5niHuhLmuJO9gjaXtXU9/5QoeYYKCOkDifSbH+Fep/q8LNBq1FFxIaSgFGJGIG7uQzGmMvwgM6j98t42sW5g82QwzzuXRrZ0I7m605NhGq35BgVjLzgtorMJuCtrmQkA5sn3M0lJtMw2b/xnSmh7kPyRJTMnycTyJjXJtlfW8QoE2oHLj2o2h6XfSHhqXcInyP1FP5XbG7FadlSLql/7u7eR0JtT4cfHjQgGjS2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=roku.com; dmarc=pass action=none header.from=roku.com;
 dkim=pass header.d=roku.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=roku.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AiDrk/Jh7Jgpcy5rxOUWpqG2fkNZyh1NUbgTcA8mAes=;
 b=MvCp0Fh4IF/8ExRAj6esmEhd0HsBTBw0uHxaT9uSiOK2tG7fS6lgUKhb7mKnernm/9vkZJA019OaV4pf0yNzFeXvK3lZYjblxxcq0f8925EoSZebmNozYLIER61oKEidSMdpKDK41Br4P1NHhhh7QdwmaiofxpeMY+TwTHKi24jYILmSiOUbeIOwOUDkDpHi06TR3cplhPvDAC9W54kBKitZJ5BaZjXCsyTPXxKDIBV0P85EG9gWn6a5BiaAOEZyx0JyS/vVCDtmPSDVJEWSNbhi79ukA9bbKgZnrSGzAkAid5aO+2P747j61yjRkh/v4rRTn1TaNmV96J+dy6koaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=roku.com;
Received: from CO1PR01MB7225.prod.exchangelabs.com (2603:10b6:303:160::21) by
 MW2PR0102MB3498.prod.exchangelabs.com (2603:10b6:302:3::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5314.12; Tue, 14 Jun 2022 16:33:46 +0000
Received: from CO1PR01MB7225.prod.exchangelabs.com
 ([fe80::1062:158b:2993:5535]) by CO1PR01MB7225.prod.exchangelabs.com
 ([fe80::1062:158b:2993:5535%8]) with mapi id 15.20.5332.022; Tue, 14 Jun 2022
 16:33:46 +0000
Message-ID: <797af8c8-229f-538b-d122-8ea48067cc19@roku.com>
Date:   Tue, 14 Jun 2022 17:33:40 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH] mktree: learn about promised objects
To:     Derrick Stolee <derrickstolee@github.com>, git@vger.kernel.org
Cc:     jonathantanmy@google.com
References: <77035a0f-c42e-5cb3-f422-03fe81093adb@roku.com>
 <0067c46a-7bfd-db9c-5156-16f032814464@github.com>
From:   Richard Oliver <roliver@roku.com>
In-Reply-To: <0067c46a-7bfd-db9c-5156-16f032814464@github.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0042.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:152::11) To CO1PR01MB7225.prod.exchangelabs.com
 (2603:10b6:303:160::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e4a6377c-495f-445b-bd40-08da4e23a712
X-MS-TrafficTypeDiagnostic: MW2PR0102MB3498:EE_
X-Microsoft-Antispam-PRVS: <MW2PR0102MB34981714AE88683D20E4CF4FCFAA9@MW2PR0102MB3498.prod.exchangelabs.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DUGkHbOHZHdyqj0lTmIGzpkROiL9b0rRGPVlWk3fHR0uEntnQG1j3h0rPEWr4AcAtRh6trDUzCZ2lHfJuzzkBS3CC6kRewMb8IE9YmYynY/7CPRNDq2sygWA0USOnAx7AEjhFY81pkDAtBiyDaC60PPf2XnqhZl4Jzo/hiMRRIRar4ohkAcIXA0NHCS8xBnJk0ajM3jO8chWgBdvZ4fb16Ow9Tm+SKSK+OmPj6uqqi6nlgHuxmFwHmpqjCbOkTBFbSF8+LiL2DCyJost1YXs4elNTcdo5mc1qCUnSF2HEGyaxHSzmDsSL01OfjAWlNFuiski5n7LfWeJXvInPP0TRCKBwMb+gEBJgPCg9pInp09+riX7HGH/nYUaJEigiLZABAcozatRuh1mOUBkQbkvFspNKBxjLkkImVEL2RMx1i0BbzcahMxQVJynIbTYHBduCL3/UP8PbiA+sr6cVSKhuEq/4jJFYeOOxIQ6hkNxA0oHGjPfeD23g9zZ0+tt3sKQ4tHKXckbJeqMn0gySnCDefi42FT4Iazxho4plhI7inf0+/xh33W1TcDX752nsp9LUIjXMW/yvMVrEp602x6QcP4qSorn1AbejulHJgJNudT8WIxIw0uS9ScbbxBgIjEZws68l1mR16Tm9Z+w0ZMw9sDZZI/ge4gRSJSDn4uSotKBzDylZcVAwHHbcrwcGoXSI/LX9YkU1CB/9mphjsVNkgH1nP8pQWAiyPeteCfDwG/CyKb1NMYapPtqYwJzFZIXgo7qgA8k0dUx6LJ5hoDRQqeKs4LVAZp+/gXFcG3KYfU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR01MB7225.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(38100700002)(316002)(6512007)(8936002)(8676002)(966005)(4326008)(6486002)(508600001)(2906002)(31696002)(6666004)(53546011)(86362001)(66946007)(66556008)(66476007)(26005)(36756003)(83380400001)(5660300002)(2616005)(31686004)(186003)(6506007)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y2pTWTFpZnpzbjhzL2JHc01sRmNFMWUreTVJa3FGYitvWXZTaUtwM2kvdXZB?=
 =?utf-8?B?RWtZQTVWdUs3bEt2bE11WDlScjROUTFKQlBMSzc3NGxQOUlaT1B3NExJbEVx?=
 =?utf-8?B?N0NBK3MycUpIbUFEYkYxN2JhcExSdXJ2S3Rhcml4WXNGMy9VL1ZIZkR1bGhp?=
 =?utf-8?B?aXYzY2kwb2RkUlpXVGdORkhETDZPRWVGRlF3djJsR1FpYWNKblV3Tzh6bTFa?=
 =?utf-8?B?eW41OE1yZ1FxdTJITGlDczRYNDM0YlBtYkdqa0tqYVdEcE9pQ3JNVEc0QnBZ?=
 =?utf-8?B?UXJJd1pZQkt3QjF0dXJrVFBidDd1dkdHRHNrSmlYUG90SWJidGNCcGRvMTJ4?=
 =?utf-8?B?b0I2Unc5djZpREFIVU1jVXMyU1RHM0gwUUFOM2RGeGg2YU5TbW1STUhVdjVx?=
 =?utf-8?B?dExwd1BMbXJJQlhnVlRIaDloT2xCMDZydndPM0JTY3BBeUhpWGo0STVpZjFz?=
 =?utf-8?B?ZXpsUldwS1RsWFNpYlBESFdDZGhKY1k0UUhQdVUybUhJWDBYUm1lbVlmOWVX?=
 =?utf-8?B?ME5aV01INnQ4a0ZYc3N5Z0V4VUZmYXFiczZRZFBGUWVIeElIQ1FGSS8zeGxF?=
 =?utf-8?B?WUVLZlMyTm5aTXF5OU5LRU5pYmtvVzB5UUZrQU9oWCtIMi9GM2d3eU1lNDZM?=
 =?utf-8?B?aWE4aGxXaXVUcmpxMXptV2RDTkdUQmhGak5OdXFvOE5qVmF5c08yZXZVZmYv?=
 =?utf-8?B?dFRPL1VRZyt4WXVlUVFOUlV4SWR6R0VpZ1RrZ1pnaW9ncUZrSk9hazVPeDdn?=
 =?utf-8?B?K2llK1dHZkFzNCtDS3k5ZWlPajlXOE8wQzZzOVUvWUU0cDRKUmxrc3NxY05a?=
 =?utf-8?B?T3FPRnoyTXNuSVc3RnNoTTYxUXhaYmUwdzA1czg5ZWJOekxjRkVMeGxxeVFS?=
 =?utf-8?B?VEo1WitsWWtNOGsxS3V5ajZOSFVYRzRsRDBQdW5FMGZrQUhtOVd0c0dFNFRC?=
 =?utf-8?B?V2RsNHVnVlBXOURlN0dqRWlkVHZhNml0ZnNUaTJMUnNlaWpRRTRvUk9EZW9s?=
 =?utf-8?B?Rm9VTFVRSHRDa2ZxMytYT2NsNE41RExGd00za0NjSEdjaTk0cjVpcUJyOERV?=
 =?utf-8?B?U2c3c2RJUFFORG5lS2YyTnBUV0tiejhiNGZmM3lDV1B5aURCQXFCTVU1VENv?=
 =?utf-8?B?YSsydjJoZzdJQ2VFV1RCQ0dJMXNkM3FNZFNMK0ZZSW4vWmJHL1VzTE5zY3pO?=
 =?utf-8?B?ZlRuU0VIbFRUSGZmVFFmRHNYaHZaQ0o4SFA4ZWNuMnRUbG9QeVFkNlEzVk9i?=
 =?utf-8?B?ZXQwWUVMSnJXOSsyT3kxaVVGVXRuMXdDQktzYVdCOVUrTWIxNnVobHhjRll0?=
 =?utf-8?B?dmliNnpHMHdiYlBzMTlDVmZEcUhEUVh3N3lHWC9HUzZyM3F6QXdVNXZNcENa?=
 =?utf-8?B?WDFDN0tybU5hSiswRVNQSDhSWDBBc0lHbTA5Njc1bnBKQ0JucS82UWM4VlpO?=
 =?utf-8?B?WCsrS25PRksyVER0Qk80MndONmtud1RCL2VaZm91UE1vaWVVbmVZcWZ3SENh?=
 =?utf-8?B?TytpcFRyVzF6Rm9hWWhFa2lGWi9PYU9rVGdubk1QRzBPWE9xRFowUmsyQyto?=
 =?utf-8?B?clRZQzloYnVhbG84blczSGFudWIzZ1BrQmZRV0Z6bGcwYVRqNUU1M2RQWUVR?=
 =?utf-8?B?M0FnaStNbXBBRldrWC82RWRXYUNNVE9aYzNJM0FBcGR6UnlpOFNNV0VEVklD?=
 =?utf-8?B?dzNCbmI2dW4yZUtTQmIybzh6VWxqRGoybGMycUltWm9VVE1mcS93Z0lPZGEr?=
 =?utf-8?B?a3J1aTB0MFkvQ1ZyV3JyVml0T2tPYnMxWG56MkJ4MUoxQmhrLy9aRTNRb1ZQ?=
 =?utf-8?B?YzMzc05QVDZHTWxpd1AyTUFxY1dUemN1RUsvTDg3VTMzSGt2MENlSGJ5dkFy?=
 =?utf-8?B?V25id3pGSktNSFFPM2l3bFpYV2xEWDVsM3FOenBhZndxeURwZVMwUXcvaFo5?=
 =?utf-8?B?LzNHT082TGUyTVlIenJyU3kwSmZCRlR4VFVsUWlycFNjTmtzTWxrUzZjRzVm?=
 =?utf-8?B?TDdEUmdDNmFDcGZnSFdTUUxlL2EzVkNZdm9lSFdLM3FRL0FIWDEzS1RJdTQz?=
 =?utf-8?B?T1JFT0EwQkpxaVlPSmRUS0d0Q3N2alBnek5VVHkyZHVBRWVTZ1JZMEFicVBp?=
 =?utf-8?B?eVludG1ibElmQ3JqaGhhVUw0cEtNWnZ0czE1MlRTd0Z5OG52eGxWZGZqNG1s?=
 =?utf-8?B?R0RFRlZ0RmpvKy83VDNYTUFrTU5zb2RNa3ZmeXJnUnZhcGREOFNHTzBBci9x?=
 =?utf-8?B?eDZoblU3am8xUDRWQXRWMC9BTmNJSnNqUkxQckJLNG9JT3pSTUxRdjJadnlw?=
 =?utf-8?B?eWZBNWF6VkNHeEJoT0Z5bE1pUGI2ZjM1NFFqaml1WlIrb2Zyc0k3dz09?=
X-OriginatorOrg: roku.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4a6377c-495f-445b-bd40-08da4e23a712
X-MS-Exchange-CrossTenant-AuthSource: CO1PR01MB7225.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2022 16:33:46.3159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00fc7e42-ad65-4c4c-ab54-848ba124a5b7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wOPtOu7Q76wD1xqagNG3+izIxGLWP+CvLq/gEJsVkT6facol5EmRNyDT6lxRrei5UNhPS8M0EC95W3JH8qt58A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR0102MB3498
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 14/06/2022 15:14, Derrick Stolee wrote:
> On 6/14/2022 9:36 AM, Richard Oliver wrote:
>> Do not use oid_object_info() to determine object type in mktree_line()
>> as this can cause promised objects to be dynamically faulted-in one at a
>> time which has poor performance. Instead, use a combination of
>> oid_object_info_extended() (with OBJECT_INFO_SKIP_FETCH_OBJECT option),
>> and the newly introduced promisor_object_type() to determine object type
>> before defaulting to fetch from remote.
> 
> Have you run some performance tests on this? It seems like this will
> scan all packed objects, which is probably much slower than just asking
> the remote for the object in most cases.
> 
> Thanks,
> -Stolee


Hi Stolee,

I've put together a synthetic experiment below (adding a new blob to anexisting tree) to show you the behaviour that we've been seeing.  Our
actual use-case (where we first encountered this behaviour) is updating
submodules to a known hash. As you can see, the round-trip time of fetching
objects one-by-one is very expensive.

Before, using system git (git version 2.32.0 (Apple Git-132)):

> $ git init
> # Fetch a recent tree
> $ git fetch --filter=tree:0 --depth 1 https://github.com/git/git cdb48006b0ec7fe19794daf7b5363ab42d9d9371
> remote: Enumerating objects: 1, done.
> remote: Counting objects: 100% (1/1), done.
> remote: Total 1 (delta 0), reused 0 (delta 0), pack-reused 0
> Receiving objects: 100% (1/1), 13.12 KiB | 13.12 MiB/s, done.
> From https://github.com/git/git
>  * branch            cdb48006b0ec7fe19794daf7b5363ab42d9d9371 -> FETCH_HEAD
>
> $ NEW_BLOB=$(echo zzz | git hash-object --stdin -w)
>
> $ cat <(git ls-tree FETCH_HEAD) <(printf "100644 blob ${NEW_BLOB}\tzzz") | time git mktree
> remote: Enumerating objects: 1, done.
> remote: Counting objects: 100% (1/1), done.
> remote: Total 1 (delta 0), reused 0 (delta 0), pack-reused 0
> Receiving objects: 100% (1/1), 334 bytes | 334.00 KiB/s, done.
> remote: Enumerating objects: 1, done.
> remote: Counting objects: 100% (1/1), done.
> remote: Total 1 (delta 0), reused 0 (delta 0), pack-reused 0
> Receiving objects: 100% (1/1), 2.01 KiB | 2.01 MiB/s, done.
> remote: Enumerating objects: 1, done.
> remote: Counting objects: 100% (1/1), done.
> remote: Total 1 (delta 0), reused 0 (delta 0), pack-reused 0
> Receiving objects: 100% (1/1), 256 bytes | 256.00 KiB/s, done.
> # ...
> # SOME TIME LATER
> # ...
> e26c7ce7357b1649da7b4200d4e80d0b668db8d4
>       286.49 real        15.66 user        15.59 sys

Repeated experiment, but using modified mktree:

> $ cat <(git ls-tree FETCH_HEAD) <(printf "100644 blob ${NEW_BLOB}\tzzz") | time git mktree
> e26c7ce7357b1649da7b4200d4e80d0b668db8d4
>         0.06 real         0.01 user         0.03 sys

Did you have any other sort of performance test in mind? The remotes we
typically deal with are geographically far away and deal with a high volume
of traffic so we're keen to move behaviour to the client where it makes sense
to do so.

Thanks,
Richard
