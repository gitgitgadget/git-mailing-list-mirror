Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22C30C433EF
	for <git@archiver.kernel.org>; Mon,  1 Nov 2021 08:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F149C60FC4
	for <git@archiver.kernel.org>; Mon,  1 Nov 2021 08:40:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231741AbhKAIm4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Nov 2021 04:42:56 -0400
Received: from mail-eopbgr70074.outbound.protection.outlook.com ([40.107.7.74]:42374
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231664AbhKAImy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Nov 2021 04:42:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NqtXkn1eui0lvNaCEsjyqhwatj5WQgXQDb8P5gjYUzUnCkBn1OMvKgYQVWvbFsxrmv/MCOXruHYw7j9zW5mRdHGcyrCfZIUP3hxn9VFIfI2IBjAce6syUpGornKkThsXqax617fjrWo/PQv1c1ZPUvzMJgh7ChyzCXx3FoVbL7IEhDHke+p6Ht/0CO2pTA27RGyExcyAPmcYH5oQyNDU5zrsB/gIGV14mqcYargNJhJrrhogeonI/hXPc7xGtJdrHI9xtf5b/gmBE1+e56xd7ieLo0SRjYUNAGbZVta8dnexWLzUKMx5sXQkstM9s/dFE9ODA46WYVcKXOWgEFP5iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YLcwieDrtUlOFk0tUc0uA4nVPGYj32uo1y9Jj5cpqOs=;
 b=XHM5g7/J71QTfzc2NIRBL2qDdZMhOYF4M9fBY0XRCTRfBpw7xGRBKQygf/DBwKmu/s3mtoAuBxlnu3ssv4aZ53WN/AUU+aLQBrgkA9/3CmVBEgveNGo8gaMjPllErXht/PQd9eVxjf+odLo7Pqarwsa0KFY1QTnQqYr7vbGV4R7iKM8XqVYWBbVmZ6T+r0yv13EayK3Y/21EoEKCEYkO2o8BX0IipBqVjl9pEWCO5sCYN9K1UPRVKFsXQnAjwiYarcAbbwi2ugK7YmDgSW4A+iuzS233wKfp/F4nQKczTqoUqQQVJJRfkl0vTM0TDtVtru6h7mP3zroMq6CH3yTwGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YLcwieDrtUlOFk0tUc0uA4nVPGYj32uo1y9Jj5cpqOs=;
 b=ncj4CRtk5c95HibEejGsBL3j9IO6MIqY60KWs3vbCfb66ku1VfOpfy5mpDPOaBQG0jEmqIiBU2xi3/nUnubuNPrIjwaK2mwuP7wpjxc17c07vL5JPVicHalpDm6pFSRQ+mojMEHw5OHl4ctEv7xOYIXrG+GXRlG6B4FGZFrkpNA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PR3PR10MB4080.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:96::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Mon, 1 Nov
 2021 08:40:19 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f9d5:61ab:5756:b391]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f9d5:61ab:5756:b391%4]) with mapi id 15.20.4649.019; Mon, 1 Nov 2021
 08:40:19 +0000
Message-ID: <dedf3971-adb1-c355-0b05-4e94ad92e1f7@gigacodes.de>
Date:   Mon, 1 Nov 2021 09:40:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 1/2] gpg-interface: handle missing " with " gracefully in
 parse_ssh_output()
Content-Language: en-US
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
References: <f6fca7c0-079c-4337-23d9-cd970c79b8ad@web.de>
From:   Fabian Stelzer <fs@gigacodes.de>
In-Reply-To: <f6fca7c0-079c-4337-23d9-cd970c79b8ad@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS9PR06CA0085.eurprd06.prod.outlook.com
 (2603:10a6:20b:464::15) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
Received: from [IPV6:2003:ea:5820:600:c042:75a0:fd5e:1472] (2003:ea:5820:600:c042:75a0:fd5e:1472) by AS9PR06CA0085.eurprd06.prod.outlook.com (2603:10a6:20b:464::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15 via Frontend Transport; Mon, 1 Nov 2021 08:40:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d75733dc-6618-4512-389e-08d99d133c68
X-MS-TrafficTypeDiagnostic: PR3PR10MB4080:
X-Microsoft-Antispam-PRVS: <PR3PR10MB408023B729CE6DF2AB4DEBC3B68A9@PR3PR10MB4080.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kLgJZle9jrRIdAHiD0uvv+5JCRGfo+waksAGm9buIPHW0Ds7BUwZ1/rp936K+K3CZrpOSCrCmy/AGGK2QuwI2kseK3us8jX1UG9Lms+mrUpoMkkQJvr0yGjH2esRN7iZwgjaC7EIKqA18Dd9r3dn9B0U2faLyozOw+WB4aVoBFZrnnelz3WMXKyU8ycJ27JsaVNa2lINablmT7wXHts+TxXp2cN+tDLX5jQByaZVWv7mIGWuE0i+ZQ6Axijbs3SJ7t1EFGpt4CjEnWCgyEbMJ2iNczZUImo/8cqcHcJfqFnGrteqcpwZcr8a+CRy0WME+s9P270k0vDWbaOPcLpcVjh0qt4CT4I1kaIkXYiGW6XpdqhDfJ8kXsRgXfGxuY+vQgmp0Ats5/JQP5s/OVH3BwpsgGODGgy1jIqlFlKWCU+R+8MRjYdaI67PZgInuwS1OqN9DeJ29hSaVRbs/mciLWbb0zxrW7l71P0kUVFYrTiQFU5hIWARPdv1pgRX3nn+0A8kvBCVGIhQUGYE4nfod+9P9/FkVDc72KYUQnX5z1ZhPJnhPcKSeQlhttOS4/SzWgXRvnxG8J9xsetq4G0k3BngNndHZD0Zpr4qvDkojvx1V6GaxM+/eYpESjjB022vsyq9GpOSJN6u67a+eMqxqa0ZJYRtHTowsaFkLgMIVvQengn7UxjSAV6D1lU1e97ZCwYDFPL/o38O+BpRC2lnHA8vuQ6I2AQ6fCEurl9eq4NFe147BHZD62nrFoosQxfo
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(376002)(39840400004)(366004)(346002)(8676002)(2616005)(36756003)(508600001)(186003)(38100700002)(316002)(66556008)(66476007)(66946007)(110136005)(31696002)(5660300002)(4326008)(2906002)(53546011)(86362001)(6486002)(52116002)(8936002)(31686004)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OEtFZkFSZWVhdE9Wb2JEU0RwbmtRR2JncjRkMjhBcWttVFp2S2M4NkMxUnF1?=
 =?utf-8?B?VlUrSnE1Q05QV25FeklvN3VycmQ4WmV5L2Z3V2hhWDUxMkdZbU14S0trWlBI?=
 =?utf-8?B?WWV3dUhFOEhEcDNYL3VvKzh4ZEV4eENraXBtMnBTdTRtYlZ4WlVBQXNGYkJH?=
 =?utf-8?B?TzNjd1hvL1RNeERzTThWc0JsNC9vWnRBSzVjeTA5dFlMdGlBekUyZEJ3dkYr?=
 =?utf-8?B?TVNXVmxsMEVPVUZaS2d1T3EwVlNCdUpOYVU1ZXFUNUNrV3VicDZEanpHM2hY?=
 =?utf-8?B?VUlxNitjcGRBbGNJNzVHQmgrejk5cGMzYUJ5bktyZUdGeExObUFtMTdDaDc2?=
 =?utf-8?B?VVhzaWtLSUNITi80dE9HNUtObG5YVnVHNTROMDgyUkMyaWRRVThRNm4rUDIz?=
 =?utf-8?B?ekVCYlE0Wmw5UXBvaXpicndzVjlCSHA0aWJaZk5mVURaMGJYYU9DNFJYL1VQ?=
 =?utf-8?B?YWlLOGIxUVRrK0VCM0oyMWRsUElITkhnQjBqM3Y2Z3FmSmtlWGx5YkdMNWJj?=
 =?utf-8?B?TEVmci9iejV5ZEhhc2pob2RHZ053OU8zMWhTMzdYQUJodDMrcGU3YWdQUUlW?=
 =?utf-8?B?SExEWjg0NW9CMUpvVXdxeEJmWENLUWNGdTJwQlB2Nk42N2hua2N5WFRGZWlh?=
 =?utf-8?B?ajBrUnp3L0p6cmc3VTZQVERIUWMxMkxJSDlnWHI0T3JKZWVoV2tNNGJVT2ln?=
 =?utf-8?B?RS85NHFaaEE1SEoyb3JiNk1NOVFuVVZXM2NYM1gyOEJqZThpZGMvT29DWGZS?=
 =?utf-8?B?NU41UFRLdHNRQU5CVjBPZmxoSTdPbGRYZ0dTelZQdFdJV1N0OFhTNFVoVUJZ?=
 =?utf-8?B?cVdiT3FtcDJvRWhRWW1QZDZGYUdwbjRuVGlZMTFWUnplTGxFaStsbWt6WU9s?=
 =?utf-8?B?ZHZiSnNIQzFyQVRpZ3RRYVpra3VLbWxVajVndlFVa1hWR3lOYUlUTk8wYUpJ?=
 =?utf-8?B?NmpMVUhrdC91KzRocTUybVlFemdQN1RNK3NoZ2E5QTJPcGJ2Nml2cy9ZT2U5?=
 =?utf-8?B?M2taT0c0am4vN0I4dUVQKzJYaWFUVGttdnFZdzlINlZTVWpsQ1hacTkzRlBW?=
 =?utf-8?B?bWVCTWdOeHV0cktZSXdiazc2OXNUeTh1WVRjWTNrak16Sy9KemFWakYrNTBU?=
 =?utf-8?B?U0hxTU0zbGlVeU1rV2VFaGp0UVVuekZNeFpGWGg3aUoxem04ZDVNVEtiUUZv?=
 =?utf-8?B?czE0cmIvSk8xZFJTN1Mzang1THEzMlpndGhxNFpvU3JRSk1aRXgvbVQrOHVi?=
 =?utf-8?B?ZmRCc3lMbEdhczJ1c2JhTGVpaE1LOUNQRGxCdVJHTUh1Qm9SL3JyTnlFdy8v?=
 =?utf-8?B?RlIwSXZqVE9wMzNWUGRTd0JiY0tnWVI1d2lUTy9GWUZxWnZRdEkxdGUvU0Ns?=
 =?utf-8?B?Sk5vVzF5cWJwUUlMcG5qNFJkdXBZR0UvTXY1TUxaREVadENXQU11blR4SWZQ?=
 =?utf-8?B?VHRWcDQ0SjFRRFl3Y3NGZURIeU9LYVBPQVo3ZG5BNnlGUDlOdS9ydGFHR3B4?=
 =?utf-8?B?Vnl0a3NQbk15dE9GN28xMEkwOVFqOEl5SFY5STFHb2VERzhoeTJ6TXVDWWU1?=
 =?utf-8?B?RXVhbVM4TTRDdXBieHB0ODh6eVZRUzc2ZkZNd3FKeU43SmlZNTlJMTNhN01Z?=
 =?utf-8?B?N05icWFxOFRydjdrTXQ3UWRPNmhBWjIweHRrVENlT2RzbUMzRXEvNjMrSGlI?=
 =?utf-8?B?NmEwWG5FM0FocUtLV092R3pzVjc4OGo5UFhLaExnT1pSaHhsRWhublZiUE5G?=
 =?utf-8?B?NXJ4U3Z0TGdKWmNtajNzTlIrRzBEN1c4ZGE0dHBMcGlGYkZKa3c5elhQVnZu?=
 =?utf-8?B?ZXNiNkVvUE56L0dmMkkrbjlTWDIyd2dBZnBVTGtlMFFXcCt0alF2YlRDRCtr?=
 =?utf-8?B?TDFMSE1iNlcxR2dOU09RUmpBc0hMV2tzRU9kTVFyaGhHdmdlekhlVEZUOUpx?=
 =?utf-8?B?TjRwcXlLZDMzZjRWUG5xUE9OYVBNUk1tTGpJck1oOGRlVnNTMTZPYmhlYms4?=
 =?utf-8?B?dnMwZmRRcDJtR3BYTVc5MFZDZlNtaGdlWjdLN3Q0bFloSDJtbTdtVGtFdVlV?=
 =?utf-8?B?M0VpZXNHbWU3aGtvYmpncFNwNmRBa2V5V1JqWFVlMTM1cWFTMzlhZ2xLMCta?=
 =?utf-8?B?OW9EVmtkTExGdWl5STk4VHA1TGtGdjNtaUFHYktXc0FQM1Jhb2NZSXhKVmo2?=
 =?utf-8?B?WEt1Qm9BZmVNZFlpa3h4Ykp0cnE5OGtYMEpNbEFuT3FmUDQrVlFjS2cwK1Fa?=
 =?utf-8?B?Y0lwZWs4MzNjY3pWc0RMeXlwS2VFVkdQZHNCWUtJUEN2WDdJWU5QV3V3NjJ6?=
 =?utf-8?B?QVlVb1JqVzJ3aXMwT29jVnNqQmh0YU9vVmxkSEJKSG1WME51ZjQrQT09?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: d75733dc-6618-4512-389e-08d99d133c68
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2021 08:40:19.4024
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fp3Zvz/cikPZ/t6huqCPbLvD6Ns1s2kuT7m5xgB5s5dzJauAaW841bc2df8JBMFcNIUkc5Bs/TF6C6+cZX5PuvQGa94Z1T0EV9a520iAXds=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB4080
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 30.10.21 19:04, René Scharfe wrote:
> If the output of ssh-keygen starts with "Good \"git\" signature for ",
> but is not followed by " with " for some reason, then parse_ssh_output()
> uses -1 as the len parameter of xmemdupz(), which in turn will end the
> program.  Reject the signature and carry on instead in that case.
> 
> Signed-off-by: René Scharfe <l.s.r@web.de>
> ---
> This code was added after v2.33.0.
> Patch formatted with --inter-hunk-context=2 for easier review.
> 
> Silly bonus question: What's the purpose of the "+ 1" and "- 1", which
> seem to cancel each other out?

They do. But only for the xmemdupz. It is important for the strstr() to
skip over already found strings (" with " could be in the principal name
as well - multiple times even). And doing strstr(line +1, ...) can be
problematic for the first iteration.

> 
>  gpg-interface.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/gpg-interface.c b/gpg-interface.c
> index 800d8caa67..62d340e78a 100644
> --- a/gpg-interface.c
> +++ b/gpg-interface.c
> @@ -387,17 +387,19 @@ static void parse_ssh_output(struct signature_check *sigc)
>  	line = to_free = xmemdupz(sigc->output, strcspn(sigc->output, "\n"));
> 
>  	if (skip_prefix(line, "Good \"git\" signature for ", &line)) {
> -		/* Valid signature and known principal */
> -		sigc->result = 'G';
> -		sigc->trust_level = TRUST_FULLY;
> -
>  		/* Search for the last "with" to get the full principal */
>  		principal = line;
>  		do {
>  			search = strstr(line, " with ");
>  			if (search)
>  				line = search + 1;
>  		} while (search != NULL);
> +		if (line == principal)
> +			goto cleanup;
> +
> +		/* Valid signature and known principal */
> +		sigc->result = 'G';
> +		sigc->trust_level = TRUST_FULLY;
>  		sigc->signer = xmemdupz(principal, line - principal - 1);
>  	} else if (skip_prefix(line, "Good \"git\" signature with ", &line)) {
>  		/* Valid signature, but key unknown */
> --
> 2.33.1
> 

The fix looks good otherwise.
Thanks!
