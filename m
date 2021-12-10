Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAE9FC433EF
	for <git@archiver.kernel.org>; Fri, 10 Dec 2021 09:53:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239602AbhLJJ4n (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Dec 2021 04:56:43 -0500
Received: from mail-eopbgr10062.outbound.protection.outlook.com ([40.107.1.62]:27780
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230255AbhLJJ4m (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Dec 2021 04:56:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TpVmtI+HfUm4E8hUan+eD2IHDW3nRmm3zLpZRBIgdYwDszbW6aXKllHzY/j7SsvP5p+ru6IOAbOnq0GAPOFYldCBehkW3gHjRdu655cOupCcJ7UsBblN5DOM5VZ3FDHIcPaZGOPCzRIFSbNSW7RvGVu7jFNQlPhph7NuT9oX9Sn9kUlJrFTeNRXabqTjzPArk2ulXQgpdhvXJPRvvUTRnVA1IISSk8rCYl3VfZdS3v4mvICM+/WVfofeA01Z0U7oQdpuImEIekvLhgom7QXydDxi+/BF/6EZUvMFg6NvKX1q9quSb65zicO3u3tCHI6NCgS1iMIOkPXjtf2bxJ7OCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M10DU8V7s4TpFOMJEdKQDzfrWdhuoxJCxZ+fZGB7Uxw=;
 b=B+aZ4DlZ3ai8gY/X7K2U/lniPWdfpB36092U7cgaPWPrzOWQO10xu24GhIBhoXA20oovTI47gTSJXn3P1M9IgWPrvWFWLKS1IG/RAGUP+D3SMikYLoCT+jqriJuC2aJYPI2o0AtzRGukVVa6Bh6RUWZ4PqWsvBsHyT9vIU9HimMoTdvcHvdmsjaNqZC7kMlFArivebYiaRlmH0SWkPCbH5QG3g+3NZpUc+dV6wEnbhFQex6SiENcnk1tJCjgV9Q1OP0/yRFFC7XQ7kGMGZLH4KXTZDILgCpiqU6yIIG27FKqbUEEoQFrTy3J72WOwNTyGYbUo074hPPORQMENM5kQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M10DU8V7s4TpFOMJEdKQDzfrWdhuoxJCxZ+fZGB7Uxw=;
 b=bl5Jrnuj4YWN2J4h2ePqXLsCCZcIir9ND0FGuHNoShc6+cyuVzP7US8IrTH0s2KXR25Jms+SfK/e3NRTzKYggtt8Ahgb6Mor0f3QBTxK51ubpSP9RnXaMbf8+vb/vtHSYesWtYKqfjVhA1xnJIivoV1XmDKYh6Yi4t194JglISQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PR3PR10MB3963.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:45::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.14; Fri, 10 Dec
 2021 09:53:05 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d9de:b41b:461d:fb5b]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d9de:b41b:461d:fb5b%8]) with mapi id 15.20.4755.014; Fri, 10 Dec 2021
 09:53:05 +0000
Date:   Fri, 10 Dec 2021 10:53:03 +0100
From:   Fabian Stelzer <fs@gigacodes.de>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Eric Sunshine <ericsunshine@gmail.com>
Subject: Re: [PATCH 17/19] t4000-t4999: detect and signal failure within loop
Message-ID: <20211210095303.xx3fxxtp5ww3s24x@fs>
References: <20211209051115.52629-1-sunshine@sunshineco.com>
 <20211209051115.52629-18-sunshine@sunshineco.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20211209051115.52629-18-sunshine@sunshineco.com>
X-ClientProxiedBy: AS8P250CA0007.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:330::12) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
Received: from localhost (2003:ea:5820:600:3e55:2984:f78e:8b18) by AS8P250CA0007.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:330::12) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Fri, 10 Dec 2021 09:53:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3363228e-3495-4d72-3c8e-08d9bbc2dc8b
X-MS-TrafficTypeDiagnostic: PR3PR10MB3963:EE_
X-Microsoft-Antispam-PRVS: <PR3PR10MB39634014F9A71DF77EB6FAABB6719@PR3PR10MB3963.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:632;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iRsJMA1hhWAF0QpSTFIzfL01RdFAEmiu7+JRI2PCZSh4q4rlLDLIxxAxAOuc+fCW9Kzkfk/ANzY8uuaX1rLOB0vK2Cz73vAWG5MzRCYJryxFMErSmMryDozfph+F6EqlgpJuACH3+BrXX5OZiO+X7UO1sykssVrVYTWMel3zfnQwbtEA96s4n/yki3SZiKXcROMPyB0zox9qvWlF634kqdD9Xi4lCKBbq11wxJHQw7yd4MnUFg+vd8xwPPnxIBCH8678dt/5pMqCBNJUxwQmrYrM3Cicy2tUjwNZn2Csf8Y4PwbJG+DuXrYc3UjeetMZp2cDr0GfkkswuFGdhE62W9MoxnqDTM81cm+gfqbX5uQOyznl8RzvEGx7VVema4CGcZ1FTKg02SfZBmdo620t011dXOhRzzqwfJXqNRwwMt094CZ5C0xruBLZ1TL9Qp5LK42Sc2H9UPqpgL4y5X0tZEHpS8IlYSPfFnTGeXyh0QmlQkC7W4cBT8uNLq6Ha7fN1bcCqegctXe9amQyPT/FkbBYnpT2/pEhsixbhgQsjmOiYEBp9tp0l+gfYFEW1QCeXjwuE87fOOKcUR44qiIlRjWfYjQv5+2vBCo6iojhBiVTX3pVdWmtp4qT9VDb57EMuiTmUIODyLFhSFIuCbr1oA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(7916004)(366004)(136003)(376002)(346002)(396003)(39840400004)(6496006)(83380400001)(38100700002)(6486002)(8676002)(5660300002)(508600001)(316002)(54906003)(66946007)(86362001)(9686003)(4326008)(33716001)(53546011)(2906002)(66556008)(66476007)(186003)(6916009)(1076003)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K1pJNWZETFhhU2dvRmExV3djMFNLVEVmMmY0bzZ0d1FSUEJXUGI0OWxCbmov?=
 =?utf-8?B?RTl5bUU2NlpvaHl6YkV6TUZpM29lRGxRa2dwNXlQdVByKzBiTFJQaStjeksz?=
 =?utf-8?B?TWluQVF1TEpZL0wvcDljdVkybDM3U2t1T3J3K1VlbEZBUnhsQWxCUU8wR3g2?=
 =?utf-8?B?aDMzKzVCRk1KMkVnV0UrbmYvZTlndjVqU3pWTEVDV1prWXRFbC9nM3RPaUtp?=
 =?utf-8?B?SVNMWk9pU21iWHZwdzVaV2ZsTEVlVENGdkRBRFZCSUlEcm9jTVhrS1czM3pv?=
 =?utf-8?B?dVdHSUNuVXBqNTc5Qmd5MWVzdzhvNXdOZm5LMUZuRGhpMVlVMlN1eXZWZUVi?=
 =?utf-8?B?S1RQWlF4K3B4Z0ZUUzNXVkFDeit4a002aWpBakpHR0pkTTlSVU1NeEExYmlM?=
 =?utf-8?B?eWtpbDhsTGgyY2RNN2xUTTZ2WGdPSWtva25WZzg0SXBYRHBkR1FuSnYxRkVS?=
 =?utf-8?B?bEhlTm1GTjhwYnliZ1EzYUQxUStDdHEvNnJSNWY5QjJJd0l4N0JFK1FNOFJt?=
 =?utf-8?B?Z2QvMHNtQXpaM0ZRUUd2ZlFnM3hBVFpUVGNlT2doV2tLL2pOV2NqS3NRMFdz?=
 =?utf-8?B?ZDdRaFJXekZOVmU2VDhDMVBiSHpmUnI5OGE4Uy9sZFBqNHQ5ejdvZ3pDV043?=
 =?utf-8?B?Y3liSHdCVkV2SFRWZHpiTG1iZHJKKzJZTk5rRWQrWXRhN2pUeVpVR3VSUXA1?=
 =?utf-8?B?ajJ2azAxR0Nla29uVmhGM3ZkYld0VzNuSWVkTjNOYVJlZlNtQzEvWEhqZzVB?=
 =?utf-8?B?TnpRU0daN0NYemF2WlB6UEx1aXBoYzRMdXcvVndEb3BPOU4vdDkyaTgyVVhG?=
 =?utf-8?B?ZitXRm1heEpuOHJxaDcvS3A5MGlKdVBteWtMVEhEY1pJTngxbldNUVpvYWVV?=
 =?utf-8?B?WXYva2FDUVRLSXpYTzM0Q0xVNXlMbWhSUXdkT1o5SDg0VXgzcXlHaEZwbXFr?=
 =?utf-8?B?c3hZblNMU1Q0a2JsRUVpTE0rZGRaY3oyODhsOGhtaDdkcjFCMkp6aFhJUFE0?=
 =?utf-8?B?bW83OFhOQnZzQ29FZm94anB0YzZ3Rk9kMXBHQnhwelN6ekZvSlZtQkFIeXgw?=
 =?utf-8?B?RFRwMlgra1dWSHVMeStJNms1NjJnNmo0bmtnRjJvVzZMcUZKbGhtU3dZSkxv?=
 =?utf-8?B?dGkraFBuM3pnUlBzL1dSdnpoeXVER3ZSeGppVGJnK1hMUkppTzczbHYzWkNr?=
 =?utf-8?B?aXFmbmY2cHRUbWtmRi9tV3k5NTJVSi9RUi91WXNDSkhtVU16M3ZkQzlTZlNl?=
 =?utf-8?B?ZHNLZE5MaUhKVFpQbmJ6aTBwV0kxVlhDK1ZOd1BmZzNFMXlJWm1VdnFtamxB?=
 =?utf-8?B?VGtEMjFRZ2N6cmU5clNMbVUwTUNBOElOenBuc2dlTkpCMDdqUnBkR1NYWlZy?=
 =?utf-8?B?cjBGSzc3QmhQNWExd0JlR2I5WWJRR3Z0VWtONFNabGxTU29yYnFVanFSNFRp?=
 =?utf-8?B?VnRVbGl2NFdMMXR1QTdCZ09pSkNjUnhOYXhOaWJlUk5CelorMDZyVXFuaHFV?=
 =?utf-8?B?bjFFQk1iMTFVLzRJS0xDVmJpY01NK1FIN2NIdWYyV0YrUkt3Q2pCQWQvL1FQ?=
 =?utf-8?B?cGVSOXFvRWgxZkgrYVA4MU0wcHNrRU9WODRTZHdyaEliWmNDQ3BJckxNOXZN?=
 =?utf-8?B?c0VBY0xKVzhPNWJ0NVFPNTdQbFRBRDdDZGlsdHlRenA0RTU5ZHZIZG5XMVdE?=
 =?utf-8?B?UWlUUHBpb1VBVG9CWkZJQUFWWkFIRmQ0QTFBZ0E5R0JXbVAwUDM1RzJ3TlpN?=
 =?utf-8?B?SnJ5SHFIZ1VOSjZpMW9sRUd4Mll4RDh0ak9FOXVCUzU0VFpHOGJXRytmK2Qw?=
 =?utf-8?B?dzk0WjNFWm1XeHVQdGprd3J0Y3FYMlNKS3NkbGF2cmgxdjZzbFM1eWFnSnZn?=
 =?utf-8?B?UisxcjA3ODBwUGJtZThqVDNkQytGemMxUGw1bU94OFdncVo2TWZvWC82a0p0?=
 =?utf-8?B?eHk1bFpVM1F6WHNRQmk1RDh5RHFqYzlYWFZHSVpEaEhOYWZDcE82WEpJM1Ni?=
 =?utf-8?B?bFB1MENoR3lsWHpMazFZSUEwdlhHSUorWlZTdG9QMUE2djJId2VlZlFLSUVa?=
 =?utf-8?B?NW8rUHdMSzBoWTkyMXNpYWNPc2U3cnlkSGkzL080MHFZLzcrYXBMU2tIRXF2?=
 =?utf-8?B?Tllqa3BiV05qdXZOWmFMRVI1L1ZOcTdCV0JxY3RvTURFOS95ejNHWHRrZ1JL?=
 =?utf-8?B?R2VvekdkeVUxSEZmc3BOL1NJQS93VE1hWG1NVzBSaXlVSXBScHBHVHlFbnM4?=
 =?utf-8?B?QzA1d2prUUl6RmZFb3ZjNWkwaWR1MmJETy9VaStLQi8xaHVSN0xJL2t4NFNU?=
 =?utf-8?B?QkpyQ2tZME55NnEzdHVKK2diZGVYU2R6MEk3MENISnRBZVNQaFJPa0hFdEFM?=
 =?utf-8?Q?7xccUiN08N7QaPng=3D?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 3363228e-3495-4d72-3c8e-08d9bbc2dc8b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2021 09:53:04.9221
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vRuVZGdZ9SlZR4B5ess0tLEVHU55EsQ/FMxUzwf2+zV7U0Foh+1f9/EB7PvMSc7bsacL7zjSe++nr5fktJaIbfG3Z3oXm6qJI5N1Stfq6lE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3963
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09.12.2021 00:11, Eric Sunshine wrote:
>Failures within `for` and `while` loops can go unnoticed if not detected
>and signaled manually since the loop itself does not abort when a
>contained command fails, nor will a failure necessarily be detected when
>the loop finishes since the loop returns the exit code of the last
>command it ran on the final iteration, which may not be the command
>which failed. Therefore, detect and signal failures manually within
>loops using the idiom `|| return 1` (or `|| exit 1` within subshells).
>
>Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
>---
>diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
>index 2c13b62d3c..ca5adabe14 100755
>--- a/t/t4015-diff-whitespace.sh
>+++ b/t/t4015-diff-whitespace.sh
>@@ -843,7 +843,7 @@ test_expect_success 'whitespace changes with modification reported (diffstat)' '
>
> test_expect_success 'whitespace-only changes reported across renames (diffstat)' '
> 	git reset --hard &&
>-	for i in 1 2 3 4 5 6 7 8 9; do echo "$i$i$i$i$i$i"; done >x &&
>+	for i in 1 2 3 4 5 6 7 8 9; do echo "$i$i$i$i$i$i" || return 1; done >x &&
> 	git add x &&
> 	git commit -m "base" &&
> 	sed -e "5s/^/ /" x >z &&
>@@ -859,7 +859,7 @@ test_expect_success 'whitespace-only changes reported across renames (diffstat)'
>
> test_expect_success 'whitespace-only changes reported across renames' '
> 	git reset --hard HEAD~1 &&
>-	for i in 1 2 3 4 5 6 7 8 9; do echo "$i$i$i$i$i$i"; done >x &&
>+	for i in 1 2 3 4 5 6 7 8 9; do echo "$i$i$i$i$i$i" || return 1; done >x &&
> 	git add x &&
> 	hash_x=$(git hash-object x) &&
> 	before=$(git rev-parse --short "$hash_x") &&

I understand why the `|| return` in loops makes sense. But for these very 
simple ones just using `echo` I'll probably be confused if a linter starts 
to complain about them (probably depending on how specific the lint error 
will be).
