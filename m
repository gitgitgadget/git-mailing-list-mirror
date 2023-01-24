Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 933E9C05027
	for <git@archiver.kernel.org>; Tue, 24 Jan 2023 00:59:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232517AbjAXA75 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Jan 2023 19:59:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231559AbjAXA7z (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jan 2023 19:59:55 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2079.outbound.protection.outlook.com [40.107.212.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A61D2303C8
        for <git@vger.kernel.org>; Mon, 23 Jan 2023 16:59:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K7sAxzyX5jv2rwUyijGSvOad7ayEuGfx1vQqx08+hMGWPW5lWvkR/geXncjYnIgo9P1mzzPEG+S5g4X6Q0qzSc+quXE7JyxWVEddSgfvkyPbLwlqMpGRTxoq0SPX0BgIqYrInvbRtirpZcXmY0I7N8Tf36YmpX+I/1gUpFpUVEzVDAaBDJogrIflNNLnWY7jzXrH9buxr5p83JDfkK3U2s3WZ5AXfc1URmb9y0GgGAC2uZt3h2IFHgcmH6j58sLcsNcvBnTkYMx1/kl+fqaJhFe63qoYAFrXYTnRHnYEnoDopZfjmSxiR+TKVCly2ppKEz+MFCmek5yg2Xf2m312fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mv0ExZAcV4F4c8A6+K9cKrmqpMWy3WvUZHq6uupfrkw=;
 b=mPecKjVWFFP4DCFPLqxGjNVpdr07OVPR47mYFULj2wHQftd1JR+ZQiAb/G9RxgEoHZ402J1V2lYSTR14gyfgDyTVcgLCii9Ag07Zwdw6gtNzcVl/x7u2k49E4XJ9CkG44vhDQ6sm6HcVUleHCZBoqzgGxKGZN4wBME0lW9plPgU8dqE85O6ujh2nnO5xFVWe/BeicRHr/KyyCUStJwx5QMmM+zJ6iVYJJQ3OlJV/piq8Zko0stsAPTXWi84GmXFQjHjkGUZew6fqPXxKJT+4lTtvS6HEGlB15PDpOYOGc3OHcFyAhCwermWX0fUcyJveNN9GXP7tY/mg9yVwmX/viA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mv0ExZAcV4F4c8A6+K9cKrmqpMWy3WvUZHq6uupfrkw=;
 b=3tq6uVH/hBwAU2dnwEJh0dN7xiBgabkYYK/VJr7/UWWCES+CxtHmf+wtDEDsAfxtKC1yhP2zR33wvqCYpFuHPmW4BmKvxIZUMJHKiDoNoQVKOt/IlHcOycYLSp8jbhpIDtCUe2Ua7dbEpxClHXe+hQHszz3hJZWsmGHOnAvHO4k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4356.namprd12.prod.outlook.com (2603:10b6:5:2aa::8) by
 PH7PR12MB7820.namprd12.prod.outlook.com (2603:10b6:510:268::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6002.27; Tue, 24 Jan 2023 00:59:51 +0000
Received: from DM6PR12MB4356.namprd12.prod.outlook.com
 ([fe80::5484:99ef:2b52:eb77]) by DM6PR12MB4356.namprd12.prod.outlook.com
 ([fe80::5484:99ef:2b52:eb77%3]) with mapi id 15.20.6002.033; Tue, 24 Jan 2023
 00:59:51 +0000
Message-ID: <ad152e25-4061-9955-d3e6-a2c8b1bd24e7@amd.com>
Date:   Mon, 23 Jan 2023 19:59:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 5/5] hook: support a --to-stdin=<path> option for testing
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
References: <cover-0.5-00000000000-20230123T170550Z-avarab@gmail.com>
 <patch-5.5-cb9ef7a89c4-20230123T170551Z-avarab@gmail.com>
 <xmqqtu0gkaye.fsf@gitster.g>
From:   Michael Strawbridge <michael.strawbridge@amd.com>
In-Reply-To: <xmqqtu0gkaye.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4P288CA0054.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d2::11) To DM6PR12MB4356.namprd12.prod.outlook.com
 (2603:10b6:5:2aa::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4356:EE_|PH7PR12MB7820:EE_
X-MS-Office365-Filtering-Correlation-Id: 6698c607-96bd-4c21-904c-08dafda64c43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q7y2AJhIdR9mHVIpTzF7t0FOCVhpks3icwU3hxDSmsgQAU3kqTUUA6TpdDwyNMZ7zHKCe8Xo6STv8ert+8qp+hu4npvYonczkpjOLayR1A/iL4Bf5Pe9mNoK+6Epqkn9hgE2ydCR3DN1J8FWvFgx++QGVp/f1F1UYk+/MRC5gYO8xb93XajVmqp39NuL6BIVB19swr7ODK7IdbDP56GeAqNDGgbBw9jo0ZjODXDCUxlVH3WsibK+eBrBFbxyW9EGjmoNrtRwHJZvsqKvkpuALwkctxWWQorPCMG3ZNEj/2vwh8txZ7BeQg86XYTawG8JKod0dVBk0LLTmy/4N90T9osDObm8azhDT6PS4OeSWHP4/xB6d1bza8TaS1LRYZUYvdtvy5iG6dKKNXe+JV+xfG+wN6DQiCzw6kFu/+QrIb70MfyKP4wnDmJUVcXcgHF3WNgaoOiLMsNVqGKZR5CE6wEiRcVnBXC1oO03kBYjJRTKp2jdDhsTa9527D+y3PB2cRbA81+I67UORgZ3xSx0pw7GSNAxFKmVaqmMUJN/eMHO9rvtuBaqwOFe09rHIDRflfjHYD7Oe33peE8rp+7YxGvbFvb82Y573uf536qjhHC3/u3PFGr0XdLtc3GbO7K4OKZ0Csj9s5sTlGNQ/g6vz7/n+PqDBMB5rdTvzpx/V/DN6LGLVaoFcjJ+Y//e2DNwyLzKeKOWRHvvfH0H5GvdtEuuIarWO5iSHJ7WXhSDsBU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(136003)(376002)(366004)(39860400002)(451199015)(83380400001)(31686004)(6486002)(110136005)(478600001)(86362001)(31696002)(26005)(38100700002)(66574015)(36756003)(2906002)(6506007)(41300700001)(53546011)(44832011)(186003)(6512007)(2616005)(8936002)(66476007)(316002)(4326008)(5660300002)(8676002)(66556008)(66946007)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z2JiZnNtakZpTlhkYW9KQmg0M0JrcTE2Y2REeHRRZ0dyOGpENzZSb3dISTU2?=
 =?utf-8?B?cXRxaEVUTUFZV0hqQ1NJT2lNalV3TTgvYlpwRDNGdVNheWQ0WVh1aXlCLzNx?=
 =?utf-8?B?alY2dWlPYTBLOTR0cmR6bkd3OVVTNk5mZ2pxSk56QThqMUJ6UjZmTWMwd1k5?=
 =?utf-8?B?NTN3RGE4Q05BemdHRjRkV3FCUGVYY3IrV2lKQnUyRmtFRXZRanlFaUlTZkJp?=
 =?utf-8?B?VjlWajByNzBYU01PU2cyWkpRbTJVOFRLM3RoOW1NbmtCQWhRWGxNVTJUVjBM?=
 =?utf-8?B?dCtTT0g0dGxkUm43T2FERXJKOUxISHVlTmtwOVNFRS9jZzFnODBFMDd5L2Zn?=
 =?utf-8?B?NmdNeTdwcFZFR3d1T1VCVmV6SGYvR0l4cFlHdENtTjA5SWV6SC9rYW5BcHZ6?=
 =?utf-8?B?dVNsM1hMbG1SSUFmRWxDbHRIOFVtNktFN3dwQTNpbVRyQnpCaVJuMlBvV0VZ?=
 =?utf-8?B?cjFva3U4M0IyaUs3QTNxTzE5WWFTOE9vMTViTTJYbFlhYm5oZmVKMzE4RmtN?=
 =?utf-8?B?eW52NWV4MXQ3ZzRTRHhiNDRlMW05M0VqY05TMHNCdVYwQXVsNk9oZDlhSEsw?=
 =?utf-8?B?amRJbW9ITmliazlUdDFndUQ2ZVliL0J5Z2ZpN29EVjBLNmZPRndCbnRIdWVM?=
 =?utf-8?B?U1hSVDlISm9ndjUwcXpIRmkzZ3hpRFFrU3lQbThibkl0OW5hWml1MjM1RXph?=
 =?utf-8?B?ZW55MlMzY2hkR2dpVmV6ZmRFdFRFd3FBNENhNzl2OWY2aTN3ZjNMTkJLR29w?=
 =?utf-8?B?b0NXMHNTakJJeklCMGRQM3NnSThicDNiNit1cEJialA2SEJhS0FkaFZLdUM1?=
 =?utf-8?B?emt2N0k2em5oWGp0ZGZaaFhNcEJMRnBVSXhGSTBCT3B4eDE1eVgzMGNBNEY3?=
 =?utf-8?B?N1RhVUN0R3oyOGJjVXdIT0pLREtTL3A0VjlKNFlvc0NvMUhPSlZsVWRaZ0E5?=
 =?utf-8?B?bXJXMm9iYnFiZXNyQm0vMWhLY3pSWFlTZHZwMDI0ZlI1Zzk2S29JallWUEVz?=
 =?utf-8?B?N3JoZkV5NU9pZjk2WTZ6YlVERTNQNjl4cloxb3htZ3Mzd2dDOFNQdU5DVXBR?=
 =?utf-8?B?ZzdQZlJjS2Y2cS85SjBvOVZSeDR3WDBrZnA5Sm1TeUM5ampvdVphL0I3N2FK?=
 =?utf-8?B?ZmpUR0NoSGdkK2QrMGNDSTZLZFJyWklTdUtJM1gyVGYwNVdZMmpzTHo4T25a?=
 =?utf-8?B?bGp0Njh1ZTY3R2VlZjFRT3dIQ3RBMFJSdjJ5WHB1T1VGNVdpQlAzeW5XaWVr?=
 =?utf-8?B?ZDNZdDF0dk1RTlBKWGJ5RmJwbG91R1JQeTVyMkx5eEhDSW9PMnowZCtmbXlu?=
 =?utf-8?B?Qk01RUQ2QmRNYWE4YUdRTmxmL3FBd05YVGdnbnRSNFQzQXNVQnFPQUpHSytW?=
 =?utf-8?B?WlNlWWVEa1JRdzRBMHpmUjJSaTZNcVdtU0Y0aDBHd3lYNGxsTlUrLzlsSHdM?=
 =?utf-8?B?K3NZNXNML3Vha1lmNXdvUEdJc1ZEcUx1dGRFRkVkUlYrM241czBvcTVEekUy?=
 =?utf-8?B?TVhvOTVFMk9VaXBPVzRQMjhRblpMNnAwSUY2YmZ5SlpuYW9vbFFmcHpWTE13?=
 =?utf-8?B?MHNGSkM4NWRyUWdpaHEyOVI2Y1VsRmx3NVRVMGdScDZ5bWJVaUtBTThERmVX?=
 =?utf-8?B?QmNkSkkzaWxLYVhGb2t0RFJDL2ZFeTZSU01BYjlheENmOUhNanJpTDAxeUZS?=
 =?utf-8?B?VEh1VjZTSUZ2K3dxaEw5dU5TVHl6dC9SVFZHYmtXZGZ2Q0MrWDcyTk9WcnJq?=
 =?utf-8?B?bXJmMXhQeTlvMWhQUVgrWkF5eXU4UXl5eko5dnBRVDFiU09ySk9BSUF2WThv?=
 =?utf-8?B?S2t0VUY2V1JRdkVYSmxuS0dBWENLSFQxRlhrUHlKL29MTTR2bTdqMldHb29U?=
 =?utf-8?B?djAzajVYQkE4VDJUZ09NS2NHVkFOaERONFgrRHpwSlZaMGNlekkwNEY4MFZz?=
 =?utf-8?B?Q0VoZEE0OWJxai9maWNtUXp3NCtCUzlvcC83WkR5QnBQaDFqZ0FJTUwvenBJ?=
 =?utf-8?B?TXRLOExxR0R3UFQ2S1VLVHM4SjhCdW1yTG1NZ1VnbUJCZVpnSzJPdTN3ZkhC?=
 =?utf-8?B?U2RDQmNuWVJkaDRyVnVuY2ozQ3ZpTklWdVNUMVBTRFgyZE1xVERUK3JaOUpJ?=
 =?utf-8?Q?0h7oIRgSTZGA70fnymzeclP8l?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6698c607-96bd-4c21-904c-08dafda64c43
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2023 00:59:51.4428
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k/9ybppnNmVYFUz1q2SI+Ic+/cb7aWjhjm6CJXRzuhsnvPMwQHOdzJqXCGxrasurdqgBZTMdmZd9o4/98qzBiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7820
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 2023-01-23 19:55, Junio C Hamano wrote:
> Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:
>
>> From: Emily Shaffer <emilyshaffer@google.com>
>>
>> Expose the "path_to_stdin" API added in the preceding commit in the
>> "git hook run" command. For now we won't be using this command
>> interface outside of the tests, but exposing this functionality makes
>> it easier to test the hook API.
> Presumably, the send-email validation topic would be using this
> immediately once it becomes available, no?

Yes I would be trying to use it for my send-email header patch right away.

>
> When "git hook" finds and runs more than one hook script, do they
> get the same input?  What I am wondering is if "to-stdin" should be
> exposed like this interface (which may be sufficient for testing
> purposes).  I imagine that scripters (e.g. send-email developers)
> would find it more convenient if they do not have to come up with a
> temporary file and they can just run "git hook" and feed whatever
> they want to give to the hook from its standard input.  "git hook"
> command, upon startup, should do the reading of its standard input
> and spooling it to a temporary file it uses to pass the contents to
> the hook scripts, in other words.
>
> Other than that, it surely looks not just handy for tests, but has
> immediate uses.
>
> Thanks.
