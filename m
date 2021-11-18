Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1C0BC433EF
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 15:16:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90C3D61A88
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 15:16:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231636AbhKRPTL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Nov 2021 10:19:11 -0500
Received: from mail-eopbgr00060.outbound.protection.outlook.com ([40.107.0.60]:65509
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229583AbhKRPTL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Nov 2021 10:19:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fq+mXM9FG6q/+wq6uJcQR+rtcp3kBaWWWTOGL57tgZLu+3JEAnaxrEMbpHXqrahhoMNt8X3RBPQeh72cMT3JSZpD3V/+GdllY6R416Ds27nkIVE51Z5M46npY+1xq6Q2jKeXe0DxW4RP5b9bis8AnK4Jv6ljmVTgZBanqgr56M2z+p2RFLF4bnh0PyrSPJuA9Mthk4rc+s2ghMrfBsDjiKpf8JEnNG/jQ1JVqijnuNcO5BsA/7WpPT8HMTfxU+1CIT8zVwDen/ImMAhcOCExMGrPPLjTA7MMEpssIGI/aT7Q7AIEqova/epEvYIHgOUPIhdPB0vUOR6cQ1zXztFClA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QJolcVn/Rq40+2IZE8YxXVNqrCX2FYQOxfozbjwQpu0=;
 b=EC5bhfdOEfTV/cT6v4/bt0pY7HNnthCI18iZSHQgz/RsK7drahd/wdKmPiL8c1921+l9W+n4WaMRJnrevSuNIIKGmZY+dD/2EY0RvXwIT6KKGYQapc42qOcS2Cog2tTdWfhE74o0Bwx3ewx12aBiYJHLThHga7EOkxwrqEflI9azgSJOo8tNN2ptxBR2e/5rk//DOHOTjw/WcSb19P7YtV0bj3XIXQj7MW/5rDKv/o0J8SXd82LIrlu/NJ2KrerAle5l+u6M79uJYWZQbNuD0iO3nglSmQetvKq/gIEn6kOQTFcsHJrYYDilFo6r6ftRGYVkaQ0/cvLYoN+1Hs8xFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QJolcVn/Rq40+2IZE8YxXVNqrCX2FYQOxfozbjwQpu0=;
 b=shvHwAGJ5ZS+vkAyHo/kVe6/srbl7XDg5M8DBwQ7AfiV7R/PtU90TaodHy3pvGiu5ym3prrw5WdSjgKFYNYPwmAxzGU0zFR48da9LD+Vuh/VVqID58/YQIClR1unDpV+o4ZRV16rvsh6thlm07jHtvRmjMt5MMerOGMFM8GdH7E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PAXPR10MB4766.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:158::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26; Thu, 18 Nov
 2021 15:16:08 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f9d5:61ab:5756:b391]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f9d5:61ab:5756:b391%5]) with mapi id 15.20.4713.020; Thu, 18 Nov 2021
 15:16:08 +0000
Date:   Thu, 18 Nov 2021 16:16:07 +0100
From:   Fabian Stelzer <fs@gigacodes.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH] ssh signing: support non ssh-* keytypes
Message-ID: <20211118151607.3mgkptt33ktrb2eh@fs>
References: <20211117162727.650857-1-fs@gigacodes.de>
 <xmqq4k8a2m97.fsf@gitster.g>
 <xmqqh7caynlf.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <xmqqh7caynlf.fsf@gitster.g>
X-ClientProxiedBy: AM6P195CA0022.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:209:81::35) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
Received: from localhost (2a02:908:178:20a0:d22:c58d:d0a4:a83a) by AM6P195CA0022.EURP195.PROD.OUTLOOK.COM (2603:10a6:209:81::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend Transport; Thu, 18 Nov 2021 15:16:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9dc073d9-8276-4296-7cb9-08d9aaa658ae
X-MS-TrafficTypeDiagnostic: PAXPR10MB4766:
X-Microsoft-Antispam-PRVS: <PAXPR10MB47669483AE246C7DDD01CDAFB69B9@PAXPR10MB4766.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vKnFkwKH/tzFebffo4fmbSNHwg0T79NOqz+PrAOP1aJrRedBbHTc8v7cycyAx8QmmJW8VXXwHXA59nIZc/LswQTge7ngNuRJrEnr2GixkP0Yz+EyUyIXk88kPaY37iajGSNObT0bU+RDWMVYnxZ3Fle0OgJFeaR/NTmGqpzqePgHOV/iSU8p7XH1pPc/Oxf0lJ0BpQpmOujaoVJ0uKj+VmTwzqRa2bP7G6Q7jrCmMXw5P+bCyLTQMYYzngDUhLTqI5wrhJC1YLY4/VsvyXsckg7X7FlvlNy8Rj4zYHXAjU+Z9sXb3+PSEtb1fbqVnMWf2nbiS7UfnMfpskTP0VIPauFs959mtEnH/fp7ngpXvOqvWDG8orvuhf8GfQjrQ38dspvnNed914Np0Q7oNww7kPt6CDAWjSCWd7z83LfN9AyoLXiBAhSJ4/ENtnZjb0Hc+33d7RLwsytOdgyOIZLP0DQxep//nQZXmLix6E2dZXeEIJ6Fu3n0MeDTl1RcPLXMKnMxr8gKL1LeWOtLVYbbjYK24JS/FkjV3yBSb3h7A2WR8prqpJspCSOZsHW0epC25tRwEo2veCBskh7BMm+WvZhv1TR3kpVnMgo0YIA7Mg8Ww/BwcnJlFHH2/fwP0exhfp7j9ph3bbOmFiBCUVbGtQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(7916004)(376002)(396003)(39830400003)(136003)(346002)(366004)(53546011)(52116002)(9686003)(33716001)(1076003)(6496006)(508600001)(8676002)(66476007)(8936002)(66556008)(186003)(316002)(66946007)(5660300002)(6916009)(86362001)(2906002)(4326008)(6486002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eW1lUUVVQTdTcUNvVHNsOUFVTXFhSnlWUkRJK3FWemlpSDVPQ1JhRWxyWDJG?=
 =?utf-8?B?KzZSSnRucnlYd3ZsOHRMUHZKTXFHNC93Szl3N2p3Skl1YlFjRmVaVkVkNit0?=
 =?utf-8?B?WThhNDZtQkdCendGMTZwa2tSb0l2L0hpMERCZ1dCaGZwUGoyK3VkbGZkUEJV?=
 =?utf-8?B?RlorTW9OeGZRa0lOL0RycDdxRzFTSVFhbDRuTjhWT1JpTUZwK0VFd2loYW94?=
 =?utf-8?B?Ymp4VmplZUdmSFplYnA5NHZydUNWZk9aOWFPdFZtR09YRk5KTVdBSXJiWWMx?=
 =?utf-8?B?REZydFBHTWM4NDEyVTRoQXg4RlZuOFJjcy94S0hhaldxZGV5dnFrRUFEWFFw?=
 =?utf-8?B?eWtDRUtQTFRvb2tQUVkyc0FwZW9tL0VLLzdZd2NETDEzRHdGY0FCc2lTOVky?=
 =?utf-8?B?YWo5MW16T3N5WG5qTDBsOENlSkU5U093Y1JPK294Y1JDemtzbk1ibVdIb20x?=
 =?utf-8?B?OTFXb2hTTlphN244MFlDU3pGMEtLNTNmUnAzWDA5c3gwbEdOY01rWjM1UlVK?=
 =?utf-8?B?YlY0cG1TaGhJWXl4U2U1Tmt2WkNqQzJ1QnB0Q2p5SStGWmhwVWZOT0dUY1VF?=
 =?utf-8?B?TkRLSkMvc3pNWUdhdDV3cklnQ040dGxkNDF6dlJSUjd6WVhuR3dHTDlWTmxj?=
 =?utf-8?B?T3FTYTZMeFNIOENzVUVDcVU4cHJHMERmNkhsN1J0YUM0RkhBSzdkV0tzcU82?=
 =?utf-8?B?NDhRS1pSVU9XWkh5Rm82aXdxOVlGd2cvQzZUTEJnSEtxNVBZQnhlUWVFajd0?=
 =?utf-8?B?TkRwRlh5UXlEaGgxM3FOaXJ5QnVIUkNySktvM2lxMjFwTndDcHJvY0J1M0FB?=
 =?utf-8?B?VUpuK1BGRVh5dytibGQ5Wm1ENnlaNHRZakh4UnB6bERHSU9OWllwVDdmRnZS?=
 =?utf-8?B?Uy9YV05zWU85L1JheWVBaFk5MEM1MFZvRmhlWG93U1N3bGlVM0pCaDVVUGhM?=
 =?utf-8?B?THFLN0ZMc2pqdWY4OTgvRy9FdnYzbm1nNG5Id3BpUlBubXZPL3kwWWV6UlpX?=
 =?utf-8?B?UWlaTSt5SDQ5c2JzcDRyMjg5Q0gzV2ZVVDdLT1JmTmR0aW5rUDhTZlhJRXBr?=
 =?utf-8?B?VGlFbDMrUDdxUk9BN2h2eHl0alVrZjQxYytzWHAzREI4dktSUWNyOFdHS21H?=
 =?utf-8?B?S05MMmdYcTN0dlFMWEM5bnBrelhJaGljaFZkMDFpMi9mMlN2WXZwZW4xK1pK?=
 =?utf-8?B?YXVobGRWVlo3RzdyNXdZTERENzFIOWlibTBtNU1lSTJjQXVHV1ZDK3Vuc0tE?=
 =?utf-8?B?c2Q5Wk9sOXR4c1ZwNnBDR2NYZXBSTmNNTE84djE3ZXdTcTQrNnpucUptMUtE?=
 =?utf-8?B?UWxXM2JXMy92VEpHVWs2bVdwTmswS0JmOXQ2NmhGYklEWkRMTGFtWFFyVnkw?=
 =?utf-8?B?T3Jma3l2YTlOclREZ1ZtMXFGcE1VUDBSa1JFOGZIQ25UbXN1M0puZ2JDRE1t?=
 =?utf-8?B?blRHWUREcThYbHVHMm1yY1lVZHRLYUUvUkk1SGVKVWNtWG43NVlCbEZIa3JO?=
 =?utf-8?B?ejROZy85KzJ5MFRyMnh6OWYzcUJISHJGcFFydVVESEt0SkxlakJxd2xaRkRj?=
 =?utf-8?B?Z3RCUkt3NFNBWEw3dXhUVUJRYlltWkJ3cjhtMG9CNFNsOGpFTUp2MEordTIy?=
 =?utf-8?B?bE96VlFnbmcyWUt0WnF5cUZqVStBQ3JQQitpWWh4enliSmpkS1phVlBMc0pI?=
 =?utf-8?B?K08vM2xQZWE5SmZvY1l1clU1QzMveGVtZVNLeDUyUllhZUQ2dzRXbW1oSWlx?=
 =?utf-8?B?RHh5bU5MeFU2Y2NkVmMzYUtDY3JzeUsrdnpiaDUxdUhWVm45RFFleW9wYlF1?=
 =?utf-8?B?STlsNkl4bnNKMEgvVHFhdHJzelJaOGNBS1BjTTduSEhTSVVVazhRR1VMdE5m?=
 =?utf-8?B?Ykh2MWZpcEtmN3BoRWFIYTBzV1RIN05hYi9pYWNvZWs2MHVtMkJmMFB0ZDQ0?=
 =?utf-8?B?aTluZThJejlneUZadm5DZnhadjFQMCtZMnVQNTdYRUpYOEZwZVhJdjMzSjBo?=
 =?utf-8?B?em1VbUVPSERlUUhRRGVJM2VpUGUyVzZGU0Y1L0hPUG9FNDFhNGRnMGtRUnFM?=
 =?utf-8?B?V1BZdko5bDBrYVR4ZWtqdUh0VThMWDVXdUlpWVBjRkFGOWF4d0FDSlBDOXhO?=
 =?utf-8?B?L09LU2V5eHh3bFRhYUpzZExPQUNqekRhWXhGNkZYVDgrMm5NWWxOUjVyN3Fw?=
 =?utf-8?B?bytFdUtQNUNsUVVzTGg3ZThqelh1MlA1MVRDRHBCT3ZnR2FCTkxoVHVUMjJY?=
 =?utf-8?B?YVdJTjVRNlNtTXVLSmxZUmRMbnU4WHlXZEpyVmhHRW5ta3ZESlc4QzNNSjlw?=
 =?utf-8?B?YllnQ2tSNlFEY25GS043VzJxek1vc2lWc3ViTUp1SkdmaWtqRzFwZz09?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dc073d9-8276-4296-7cb9-08d9aaa658ae
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2021 15:16:08.0869
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FX6CG/t0Lsj9ezG/xMiixP2+sh/D5+nZXb9POfBYNTcoT3FJiphBz6p4B3O5/2lG3w+JNPWLf/RUUS+GjrDM7BPeUtaU8AP0l+/sGx3q67A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB4766
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 17.11.2021 22:39, Junio C Hamano wrote:
>Junio C Hamano <gitster@pobox.com> writes:
>
>> Fabian Stelzer <fs@gigacodes.de> writes:
>>
>>> +/* Determines wether key contains a literal ssh key or a path to a file */
>>> +static int is_literal_ssh_key(const char *key) {
>>> +	return (
>>> +		starts_with(key, "ssh-") ||
>>> +		starts_with(key, "ecdsa-") ||
>>> +		starts_with(key, "sk-ssh-") ||
>>> +		starts_with(key, "sk-ecdsa-")
>>> +	);
>>> +}
>>
>> A more forward looking thing you could do is to
>>
>>  (1) grandfather the convention "any string that begins with 'ssh-'
>>      is taken as a ssh literal key".
>>
>>  (2) refrain from spreading such an unstructured mess by picking a
>>      reserved prefix, say "ssh-key::" and have all other kinds of
>>      ssh keys use the convention.
>>
>> making the above function look more like
>>
>>     static int is_literal_ssh_key(const char *string, const char **key)
>>     {
>> 	if (skip_prefix(string, "ssh-key::", key)
>> 	    return 1;
>> 	if (starts_with(string, "ssh-")) {
>> 	    key = string;
>> 	    return 1;
>> 	}
>> 	return 0;
>>     }
>
>Given that this ONLY gets called from ssh codepath, I think the
>special prefix can just be "key::", and when a new crypto suite
>is introduced to sit next to GPG and SSH, presumably the code
>structure to support it will be similar to that of ssh's, and it
>can also use "key::" prefix for their literal keys.  That design
>may be cleaner.
>
>Thanks.

Thanks both for your review. I will use the key:: suggestion and also
add tests for this. For now i guess we will have to keep the ssh- since
it's already out there :/ Will reroll soon.

Fabian
