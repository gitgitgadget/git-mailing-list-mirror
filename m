Received: from mx0b-002c1b01.pphosted.com (mx0b-002c1b01.pphosted.com [148.163.155.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD0B1E4A9
	for <git@vger.kernel.org>; Fri,  8 Mar 2024 17:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.155.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709919845; cv=fail; b=quAI8c6phohfQRTN/briNJ7A1cLKBPOgL1hhkTdW2N6JXnP+lYxVY6xMTSickmorFsv5yqXQ0oZSBlbdD66OFYjT1+d3vy+ksQISMu5JUI7+iFHKxpXNQNV+YQm+9JfVeNmoUGlV/rbhQx2u1NEx/omGB6vUhPj3o0tYEGHpo9s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709919845; c=relaxed/simple;
	bh=MXsGq4/kS4QugMcLmb9AwqS2Bb72IYYOkB2Eqt4kJ0k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hkhEXZm1PYvIFq/P703YImWxW9v8PC6g7bYnOUnES1FAKTLNh0SmbJ7OEikmXRmvEzmg/yUb0EZtlrpl6rNk3rsdvV8Ry6wP5dsr0H3huCNXjUfUMgqvZbTlryMJWpsJIbwd1k1WQnOs5mKF3CG2Hv7WOL78JWFt0qnYcbQViwo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=EZNNlBdp; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=yNCms0ge; arc=fail smtp.client-ip=148.163.155.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="EZNNlBdp";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="yNCms0ge"
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
	by mx0b-002c1b01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4289Njfc011443;
	Fri, 8 Mar 2024 09:43:50 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	proofpoint20171006; bh=q/zSbNQKscIiH4g8HdvmIa3jo9FjSWgVlqh3JV2Bu
	yg=; b=EZNNlBdpVkTuw5EVuJ/ddyf9eOB6xIWigVDupm+MnMnYFdB9QrxQ3/ZCc
	75Ypq3TEVpY4bOCbSIpFSERejHxHZMKfgFXiC5MChfaVUIA3uLNFfLMSkzpOZ+Le
	A4TFfMTlQGZDVShoMPp36zEjh7znF66ZnjMxZp8aAZYw0mEUFURt60L2xPs3XlgN
	XxxyaXDwmMJ6D8KkXiOfbAgZ73JU+FNp3siL8Pb0ePpYRxt+vS2sN8COW17bvmNs
	/n8uTs/GoI3PXQn3TGtvjBG5H1bXzXm2yJ5d0ijE96wobk44Up5mu0STmCNiTw9M
	k+bM5umuvzc6d3PpXVkT7Zz5XuZWQ==
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3wm4agehkr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Mar 2024 09:43:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y8DVvu3LPFMu0Ii+aF0qKT/4CjiQ8755XqAujesoIxfLi5WnXWOImWccLfUJ+a+WiSviSUMgByqqgcFQJrBggi8MPBqFXYMaGtHm0cxyZhHkrk760k8n8dz1U5KZWQXhsvP5+MgTjth+xxr0jO4rB5sFabZLOGNPwPD2fph3w5m1VKtWp98eWFfIBrimxnWhZ5qy2xTRWItNlbDOWoHHUV+vTsNhXDDaO5O1lC3KcjJTp12grV7ZgInSZ+pW+HdC7AlFtYPVKPfqBdKGe0V/tvi+OS2twFJ0ROk6iwh/+k8soXzBLSuhEDM1S8o/eA05UabjkUjgyOYU0cZ/3vLsCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q/zSbNQKscIiH4g8HdvmIa3jo9FjSWgVlqh3JV2Buyg=;
 b=EJXWzorn1XeEsCmIwNPD4mxKCgdwT+aisSpVzrwKL+gRTxUyiWj9hv6LKRJm/+SKHvHFX88gKk8Ey4TPkigOfw0J+g0yFQWmzmAZRLWEissJ0yNOSUxDYe/+HldntYjxKRJ8x6SZWpCNKGe5GwoIXNGBA0bBkX1eQAGQjRYFcql7pgOLRak1wJRpHMWVrOfHVd9mvGwUgZ479oabmMsl89gbXYhDLyiccRHIEMGXfZgEPjiopNIUYj72pQbwRTMbvcNBcTlHWvoh9POfBVJvI+1mvvAJA8n/PHdGEI6Ju0rEt4n57fsiYX1mAQTa2rikpqWRvjVXDy+iWOpU7Lnkqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q/zSbNQKscIiH4g8HdvmIa3jo9FjSWgVlqh3JV2Buyg=;
 b=yNCms0geRFmcXup9h3obfilHPSdnztWyUOWUg69SN0BiZZOuQz80eGwoum/wC3mfmTSiWcSdglghhbWOirDUj57O4PGdElEAk6yFpHmZb95CoExJUMn9QNEvSv3TM4aZt9/py4sq0xH4XCsE+v/IwdTsxGFn+pCp7Fp8KuTPiY3bMMakYFQo8A6ue6sKXF18kgfQOUc3/5rgAta2Y26yYOhqLFCrtO8Zw2MFfyrjdffkxJHgYzktfkICIZNegvWB8Bzkanf0PJXb43bVF581u42lvs5pA5WA/mdjnPd48RiYXTeJlETUh2pkwJlAM2eOzBTuNI/CeRqQAqukSe/gfQ==
Received: from BL3PR02MB8217.namprd02.prod.outlook.com (2603:10b6:208:33b::20)
 by MN2PR02MB7072.namprd02.prod.outlook.com (2603:10b6:208:202::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.28; Fri, 8 Mar
 2024 17:43:46 +0000
Received: from BL3PR02MB8217.namprd02.prod.outlook.com
 ([fe80::8c3a:4141:fb11:c684]) by BL3PR02MB8217.namprd02.prod.outlook.com
 ([fe80::8c3a:4141:fb11:c684%7]) with mapi id 15.20.7362.029; Fri, 8 Mar 2024
 17:43:46 +0000
Message-ID: <08b9b37d-f0f8-4c1a-b72e-194202ff3d9f@nutanix.com>
Date: Fri, 8 Mar 2024 17:43:42 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wt-status: Don't find scissors line beyond buf len
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jonathan Davies <jonathan.davies@nutanix.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Denton Liu
 <liu.denton@gmail.com>, Linus Arver <linusa@google.com>
References: <20240307183743.219951-1-flosch@nutanix.com>
 <xmqq34t1n91w.fsf@gitster.g>
 <1ff36e64-b993-4cbb-ba0a-01aca5396ef6@nutanix.com>
 <xmqqedckiw2r.fsf@gitster.g>
From: Florian Schmidt <flosch@nutanix.com>
In-Reply-To: <xmqqedckiw2r.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P195CA0010.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e2::20) To BL3PR02MB8217.namprd02.prod.outlook.com
 (2603:10b6:208:33b::20)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR02MB8217:EE_|MN2PR02MB7072:EE_
X-MS-Office365-Filtering-Correlation-Id: 10e0d102-baaf-479a-5a1d-08dc3f974e14
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	lLLpCW0dSTHkkHYjwvoibZ8/yAJWllbW8xGCPY00zWJ8t1PQh4Koc2tO4y3jLNCxHdEKHtdtMLQL+SlLGxmr88xf/7e9z4vzry7clQaM9N7bKvNSVxSTYhX655/ISkHT/EYQ69z0TDUENFJmTBDDAX1SAg7Uz2ID2E/s4uGCHMzaBP+FKhhxCZrUAbP0mwCEPJ2270lblPUskcrG4rXWOCXtrJPPUUXk9rhVQ8wlhYmw7NtZW146KIbL5RLC0pfdli1O6PeHcVMdsOa1Ht/CX+yWMK8l1viIhQrq6RPnVcrrGVncUSg6E0h8up1yStqhdhmYOfoHs6YOjQ+szlKkv5kWesvfPwL0UziYXy6HeWlhVNr2ELqKT3O3xAcRwh7G73QNo+9yV8K6anrf4j29b/CZX3xe+wIRxDjhmhbohPrnacELzjcijE4IpVUw5F32aCCqyee4H/3F9M9qzuXyoTNvKtspxX+wsg3yZcDI+O2j/m3QxZhwTRIA4CAjmoaHp6KANEYOrsW7DlC5Wm5p0vt5fQVyW8KYLcd8UciMr6PYt2ooqD42yTPKDcDqyxYuRR9f2Aoer8RcE0Ptjhxz1/sOwvTPyi9vA1yXzIVh2Ca7Kha2NRHVEl8qHSCKWj4JgnW6ZfBfgTaTKEVwb8IbI3yqgVb3FRVIm13l7MlE0Vo=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR02MB8217.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?THV5SmRJK0F5WjVFUWlGeFB6Z21KZFRvVXZiZ0NKeVAvQktKVlMrM0RIZCtG?=
 =?utf-8?B?Q0hlRGdaeURzcS9IM1hyMDY3UWp3d3BNL1BwUDl4OEx3SnFMZDBsbHM0enFr?=
 =?utf-8?B?c0Rud1Q5VzZwbW9hYm5PS1hhRW1OVnR4UkpTbW1JOFJ0M2FCUzg4TGpPdWFX?=
 =?utf-8?B?Z1dDakd2emFpSHpBRkY2NXNwKzlYWWlVT1pUUzM3UUxTMTYvZnB1M1lxSW9k?=
 =?utf-8?B?NHhNVDBwVEp4NVdBMkc2UFB1bU1pb0s5WjlYYitTVGRNUUVxbEVaLzFwU3J4?=
 =?utf-8?B?d2h6TEg2TVRjeFdTMzk5QWY2STRSYjdsSUtIZXZXN2FsYVQweEVCcDVjQ0RW?=
 =?utf-8?B?WDlIR3Yrb1owbjMxRllDbGg5aXRBSEZzNlZxRzBFc3YwMHZpSndCNXRwdDBa?=
 =?utf-8?B?L1lqL2I1ZGhSZzRZMXZ0NGF1Wk9TRFB6Nit4eWFCWGEwV2dhVXlvSXRjd0Qv?=
 =?utf-8?B?Lzd3eG9KOXNWNTJJSUNMb3o0SlhxWTB2U1hYRm9WUjRwekpPdkZJVXJGWFZX?=
 =?utf-8?B?WmR4UW1EUWJOZXhhUEFvZlZLNExZQ2s2NXAzT0RWSUVOTEl1NDJPdFEzWjVh?=
 =?utf-8?B?WllKK0xxQlFlZFdTMmFpOTJyeWxpaUVKZGhONjN2QkVHOEg3NVVhS1hiRWFO?=
 =?utf-8?B?SE5ablpsYk41Y1VJKy9sR3hJWjRLZDBKdzc4V1luRzFvakNxRjZUTm1JL2gw?=
 =?utf-8?B?dUpRNVRWZHJjSHkyMXVlRGdzZHozUHVpTzFPYlZtR1hsNENaaVRsQm01cVJ0?=
 =?utf-8?B?cDJmcnNkL0hJWHhTTzZYTUIralVKd0tYVldwMzJtUEwyZ0lYVGFCTTVFQzI1?=
 =?utf-8?B?TUJLVEhxL3BlZHpKWGl1MXhXaHplTnJaTUFUOCtiWmhVaHpVMHNPMzg4UDVK?=
 =?utf-8?B?WXdxZ2RoZ3BpMnc2T2lzSFM4cklkT0FXdVQrTEZXQm5LZmNWOHdEVkNGWSs1?=
 =?utf-8?B?a3BPRXhKalRqN2N6RS96aTFWK0t4VDVqQlVmcGNqK0JZQnRIMFh3RW1WUlZF?=
 =?utf-8?B?Z0RzakdVbnRQMC9LSkxSOG9YeU1EaU1LTlJkck0vMVI5ekIxMkdQUnhPazJx?=
 =?utf-8?B?cjdpbFVjNEJVcG9Xd1lhWXBIRHJFRFVLMEQvTkI1NE1IZUtSUlJLOEgwZmpz?=
 =?utf-8?B?OVVVZnZ0Vytla3RYWWxDcWhheUh6bFNUQmxrYjY1cXpzRkp2R2t0NFNWaHdn?=
 =?utf-8?B?eXE0SDZrYWdQUXkrMDd1bWZKVENXd0xTVXNPMHF0dE5hQnkvOUg3TjFFb3B2?=
 =?utf-8?B?eDZVclhxOFBwQmlVL2VYMXIwL25ncXF6ekQrb3dKNWd5a0k0NGcyNzFQajNj?=
 =?utf-8?B?UUxtZ3lhSlUvTG9rWVJCVnQ4ZWZDN3ZBdWk0c2E5MVk2QlRIMDF1Q3FGd1ZK?=
 =?utf-8?B?L25uSzgzL3c2U0JIS2l6NDZyZno4Qm41MlFJS0NOd2FCSUNmRHA2QjdFSVJv?=
 =?utf-8?B?bElZZE9Uc2dqVnFJZjhqa0VJMmo5TlRQeVlqYldOSzYvQnh4a0Znc3JNTW1y?=
 =?utf-8?B?OFZSaUpYZWpSRVlOZHhTYVZPQUpPTWdwWDFtM0ZxN3FzUHNid3ZBL3FtVW81?=
 =?utf-8?B?eEJpbUM2TzQ3Z2IrMjlFbkxqRjM5SnBDSGYzODY3TlJodVMxdXFSVW81cTNS?=
 =?utf-8?B?aktkYkxGTWtMcWwzVDJPS3plSUhyZGVGMFhJcnNFSWM1UExyTWU5NktTNWhn?=
 =?utf-8?B?c1NOYjZ0UysrZDdtdFJwMWpZV1YrVVhPdEVWdnBseTNENllkVTlyOVdOS1NG?=
 =?utf-8?B?RkVtZlQ3cVFaS010QWtkZlMvQzZlaUpJMmFoODlXZFFZUWlqblBtc2pFb0to?=
 =?utf-8?B?MHJXd3Mzd3lNenlDc011bkJOL3cwaUQ3YmJ6Q1FiNGpoejlwc01QeXVKMS9v?=
 =?utf-8?B?QkMzQUxXRWN6RjVnUFNhcG5nNlRCUlF3allQQ1IrbWhLRGpWdnR6cmtGL3N0?=
 =?utf-8?B?SkhDMjZid2xUelZWYjBYNXdGVzQ0ZnhzaC9wdGZlRllFOHR0UXIxRFVSWEor?=
 =?utf-8?B?b2RtcnJVRk15SnJUS25VbHk5T0hkalV0aEhSSC9vY2V6em5NNEJkbEdJdStQ?=
 =?utf-8?B?L3RHQStMc3I1RFB1K0JVVDlDMXIrT0xva2NZUk14emhaTEc0R2dOQ1pvUHV0?=
 =?utf-8?B?QmxuVEN6cFA2YlJ2ZTgxZmpPZzdCNnJFSWR2Y0FUQ2FXVUtROTM1VzVreWRl?=
 =?utf-8?B?YlE9PQ==?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10e0d102-baaf-479a-5a1d-08dc3f974e14
X-MS-Exchange-CrossTenant-AuthSource: BL3PR02MB8217.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 17:43:46.4416
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nVNACEENATYOgkDiPdK2ys+c3z5BhF9/Q2av4D5FFnqeZQZjhxfNmf6mG3okJ6WXCSPGMFBKDRdKJIXTRrCvqOEGXwKtI4Pe3ln/NhdzYUY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB7072
X-Proofpoint-ORIG-GUID: I_lfw2BEhZWD0qRJXIUgB1LFuuwG7iqT
X-Proofpoint-GUID: I_lfw2BEhZWD0qRJXIUgB1LFuuwG7iqT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-08_08,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe

On 08/03/2024 15:26, Junio C Hamano wrote:
> It would be the technically correct way to do so, but as a short-cut
> to reduce a round-trip, if you are happy with the version I queued
> (should be found by fetching the 'seen' branch from any of the
> mirrors), you can just say "that looks fine" and we can be done with
> this patch.

I had a look, and it looks fine (though there's the one typo already 
pointed out by Eric: s/exeption/exception/). You can go ahead and use 
that version of the patch.

Cheers,
flosch
