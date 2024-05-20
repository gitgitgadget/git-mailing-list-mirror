Received: from mx0e-00379502.gpphosted.com (mx0e-00379502.gpphosted.com [67.231.147.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DFEE1369BE
	for <git@vger.kernel.org>; Mon, 20 May 2024 16:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.147.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716221466; cv=fail; b=GdRyrgpNJshbEK6VqDr9/xAFNaMnE3UCvcgM60gPsVIuOcVfCoL4dHW6NBv87+woQims84hI0oj2l0weD/9+sStC9xd1TkpGM2jmnoVZyhtU6AjcB5NCpoHSKY75wtY1hnvUM6faQ66VnEY0NV9RkWV7Btpy43ZpIr2UmbOs7X8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716221466; c=relaxed/simple;
	bh=9bcrCMlYBLMtKO1ILjuHuz8c2gy5dIfNqbxciTSUrzs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WRgvwj0f73IxZaFneExlj76Xx83BO3Gtp0HksOOkbp1VPATOuLPh4kzdGHv4tIEk0x/L2qHNS8afvtcfQc1CqLBRE/Nvde53DYO/1lER//KCZeTqPEIHkDNKEBYzFzNoJNkRSaI49m5IqETsdCE64KjYBScW3XIIqowLH4zqP4U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=llnl.gov; spf=pass smtp.mailfrom=llnl.gov; dkim=pass (2048-bit key) header.d=llnl.gov header.i=@llnl.gov header.b=NAphndkr; dkim=pass (1024-bit key) header.d=doellnl.onmicrosoft.com header.i=@doellnl.onmicrosoft.com header.b=PkD/GzUs; arc=fail smtp.client-ip=67.231.147.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=llnl.gov
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=llnl.gov
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=llnl.gov header.i=@llnl.gov header.b="NAphndkr";
	dkim=pass (1024-bit key) header.d=doellnl.onmicrosoft.com header.i=@doellnl.onmicrosoft.com header.b="PkD/GzUs"
Received: from pps.filterd (m0218361.ppops.net [127.0.0.1])
	by mx0f-00379502.gpphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44K6ouH7017552;
	Mon, 20 May 2024 09:10:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=llnl.gov; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=02022021-podllnl;
 bh=Sa4/kzX/Ukn7mJ7w5CEoe4dHjcJHZRuGrvPoeTv4HxQ=;
 b=NAphndkr59MixgPhpwTAwqs8FZGiFgjUXCy3VDuo4UP5WTVG5GC9Lz5hNTV8/KpOLLPG
 NXwANU/o9DzhrTujOLR64nb3HeYeWwfloME3st7ZyhoK4BLd3lBvejFtjZcRv4p01Z2b
 XKfHoluD+u60fgpOOnyXSyq727KMwli+Fx/Czq83gqzKwLcCITLp2U1GeLg+FfUFB8bo
 x9MKPkuTqckjkbbHuPiATdr+rKW/FU5+zqhA+vTB9y7S3eHwz0qig78tM9yoJBk9q6+y
 2X8KI6PUIHnZQl7BYQi1FY7UGKp1ezOOjeikzuG0VDOR3C/a8zW6M89sZO+9gMaah0bW Sg== 
Received: from gcc02-dm3-obe.outbound.protection.outlook.com (mail-dm3gcc02lp2100.outbound.protection.outlook.com [104.47.65.100])
	by mx0f-00379502.gpphosted.com (PPS) with ESMTPS id 3y6s16chqy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 May 2024 09:10:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d81KpOwhjK9AlVeJsXXrdDotNVdrkgw3/P/rjfvT9hjry1kdD9dffmhVtv50idlZy1l89Gpbi5POPBYn2wVX/fVn/+/OkMLbGuUSKy3Im33mCTtF6idb5lTy/lrgkVhXBd/mqC68Oc52En+aBhiTWy5uvu74+lZ1gp7jG2Sz6AEEjuT2NcbMnNmUzuH9jf3IR9qhNnKrOagXRPlrwOq24evTUKKnY2Q7ofr97boAXPoHvtUwxP4HSFiKM7CdNOaiNWqYKNNN80kgx2thkLvU3w3xyKJufVnK4Qc0OAWv9vBj/FbzyXPqZmShTRhaYt2azvNmZbr8v5tfh9UevJvhzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sa4/kzX/Ukn7mJ7w5CEoe4dHjcJHZRuGrvPoeTv4HxQ=;
 b=aM0eWcvxAD2d4D7JvMIsxJCd5WVl0vwa8RCM6eU8L7AKvIJM+1IJQ7qt6jFlXCRI5juiGOyMJPqspdG0P4fknVUNSfa6RA0qQ8PO4nRQBTfTN+yhuL+2UmxPkrxh4cFfeAUewouQxHdnGlwSrAnsDFfqSIz482r4yV79dMBEUSOebIVLxZ0rsHw9dEbA+uBKy78BWKPcjjXjxEz89n2zitKe7OxOogwlEOx0EI2b+pQ4KiIwRNaHHC3TEz3CNr8GZUpP97g2WAxb9Mnv+1NKTLK5jLLvngdNUieQlOn5er8mGOVhVci2IbtzPLK2y0bhlkud2YEqUPcPSScNRIbXww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=llnl.gov; dmarc=pass action=none header.from=llnl.gov;
 dkim=pass header.d=llnl.gov; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=doellnl.onmicrosoft.com; s=selector1-doellnl-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sa4/kzX/Ukn7mJ7w5CEoe4dHjcJHZRuGrvPoeTv4HxQ=;
 b=PkD/GzUs5KpRoY59HhA6Y9GbhL3aYG8srOQwmHUh9obRB0tI3UlbSXZgaRKAB25+ZgL03rJXgkj3bl4zFihbRsYPalDLGDRmb1pBJ7FG4wnzdTdpR7nUdYXgBZ1ZpPMcQVdn+0njY5oP6w6p0FPFjExNaqVs+RTz12DIvlTu2mw=
Received: from SJ0PR09MB7071.namprd09.prod.outlook.com (2603:10b6:a03:259::8)
 by MW4PR09MB9427.namprd09.prod.outlook.com (2603:10b6:303:1f4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Mon, 20 May
 2024 16:10:52 +0000
Received: from SJ0PR09MB7071.namprd09.prod.outlook.com
 ([fe80::5bfd:20fa:e427:31f0]) by SJ0PR09MB7071.namprd09.prod.outlook.com
 ([fe80::5bfd:20fa:e427:31f0%4]) with mapi id 15.20.7587.035; Mon, 20 May 2024
 16:10:52 +0000
From: Tom Scogland <scogland1@llnl.gov>
To: =?utf-8?q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc: Tom Scogland via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2] archive: make --add-virtual-file honor --prefix
Date: Mon, 20 May 2024 09:10:51 -0700
X-Mailer: MailMate (1.14r5937)
Message-ID: <95B94723-BCBF-48B4-A02C-A5C61FB060DA@llnl.gov>
In-Reply-To: <bc3711a7-37d5-46bc-979e-83bd0b2cf900@web.de>
References: <pull.1719.git.git.1715721327429.gitgitgadget@gmail.com>
 <pull.1719.v2.git.git.1715967267420.gitgitgadget@gmail.com>
 <bc3711a7-37d5-46bc-979e-83bd0b2cf900@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BYAPR05CA0103.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::44) To SJ0PR09MB7071.namprd09.prod.outlook.com
 (2603:10b6:a03:259::8)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR09MB7071:EE_|MW4PR09MB9427:EE_
X-MS-Office365-Filtering-Correlation-Id: 3797afc6-7a75-43b6-7c04-08dc78e76bb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?bDFTWTFQU0hXNVdubzJWd0NTTzNCTVFSZlkvN2Y3eWpPVEZlOU40OWtRRkUv?=
 =?utf-8?B?aCs4Q3VXWlh2RXJ3ODcvQXlrbnk1VzBtNUdzR2JtR2RZdVhSandxSThxRFR6?=
 =?utf-8?B?YkN0Ukh4UFYza1o0QUhabHg1VmJiaVZwM1V4b1dpZ3BVLzVqemVkYlBNeVND?=
 =?utf-8?B?NVMxNE96aEVjUjVnbG1PVzZ4c05mNEhkMVppaGtaU2k3dWk4bUM1N0JTa3pG?=
 =?utf-8?B?UkZRYjEwSXp2RWlhT2QyUjR1MkJmYXhrZ1ZMQ1JtbGJNelFsZ3IxNGJGNFJZ?=
 =?utf-8?B?U3VSdUwwRVU1eXBFajRVa0FmdTlkWXJNZ25Sd3RJZjNRRk5nNGpxVVhQa3JJ?=
 =?utf-8?B?aUFoelpET29tNWFBUzAwQnlSUlRLaEZkS0lSNWxZVzVSRkRoeE9MS2VHbCtj?=
 =?utf-8?B?Umk1c3ROOWRsS0VqNStxZnpvNWFHM3FCMGdqeWlzV0h2VnFyY05xTWkwWTVo?=
 =?utf-8?B?VVBmWU14SWJZRmFzMS9ac09abXQ3SHRBZ1F1eXNuSkZjcUNZRC8ydVZ3YW1D?=
 =?utf-8?B?M2NUSDJHVFZqdHBJTkh0aFhOSXdTSmFMb0JPN1V3WXA3amZEMEFmNTVGdlB2?=
 =?utf-8?B?Y045S0JmTnJad09WeUkrcEdtZUJpTDIzUnliTXl5Z0xLREJOMnlLWmJYT0l4?=
 =?utf-8?B?NmpqMDRZd0hSamRzNURwWnJlZkpYRTVkU2Z1K1JyVG51V2R6NDBYN1B6RHVJ?=
 =?utf-8?B?VERIR2Y4d1ltcTd3MDRtdmZXNjY5Z2hoMXJ6QVdtVGtqR0ZMeTFBODVRNjU2?=
 =?utf-8?B?c3ViaCtxS2dMeEI1NXRxSjhHQUZoaHBMaU1xOTVjcHRpc21JMy9XSWhiTlJt?=
 =?utf-8?B?WFBIekZCOXFOTWNWamQzdVRkU2t5clI1YmFUWTluOFNFdmV5Zllsa2dxOERJ?=
 =?utf-8?B?dmJ0S3dFZGU3dmY4T0Q5MWZubWpxSzlqdllIM0ZEckNIRTBxSTdtYXRJTFNK?=
 =?utf-8?B?TUZrNUkyL1JZWDNGckp5MGlxUnEzSnFBa3c1K0NJNTJESzRYQVpRU3FNTE5s?=
 =?utf-8?B?bFdGUDN0SWp2L1VkTC9ZdER2akFLUHdzWlRvTHFPcXNJK1dXN013SlBMR000?=
 =?utf-8?B?T205eDNEYXc4SWxPb1B1SFI1MWVJSUVJRXdEa2k5a21ZMnNBZmp1eXJ3aGdX?=
 =?utf-8?B?a0I3UE9qd1U3OFFTcUIwRFBTZ1dMUXRpdXBvaCtSUWo3QWZtSU9zNEpsK2R0?=
 =?utf-8?B?c29KSHpLSVVRdHYyR2h2RFdoK2dma2ZkWmJyT1pKOG1VcnhnWkhrWkRpNVNV?=
 =?utf-8?B?ZnE4S3hoMU9YSnAweUt6ZVA2cWo3OVROcG0zMHQxUWU1clNMQW5yUFd5TFJB?=
 =?utf-8?B?OHdjSWRZVXE0aGFNWnRnVDFJT1BRWVJzb0N2OUVENHQxdkxUTUd6TnJmQlVO?=
 =?utf-8?B?SVh6RWE1L1dLTXo5cXV0eXBneUxMK2NuVDM4c21weXR3N1h6c3hMRUxBemNh?=
 =?utf-8?B?MDhPbWJtSE9LSElJNXVId2txRmJCaVRPZ1NzSTlBMU5kd0w4c0ZSR2tSdTBI?=
 =?utf-8?B?QjJ2WklMZkN0ampYZ2pSN1hqYlZ6Unc0MzlnS2JDMS9lbm01VmtpZ0tZRXQw?=
 =?utf-8?B?ZWlmM3UwOE9NempPdGE2Z2Vwd0FCd3JFNHc2R1I5bldSWVVRUms5VDhnLzJz?=
 =?utf-8?B?VzZhZzZBUlR6U1ZwODBYWXFPZnllM1MvVmthU1J1VVNrdVNsak16Q212U2hh?=
 =?utf-8?B?Tzh1alpOOGM5Q3o5NXR5K2JzZlF0OTVzZ2hPT3l2N0l3QWQvRjhONzZBPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR09MB7071.namprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Q1hDSloydFF5c2tpam9NczcvTGpzbFlTNlkvRTVmWE1vZytUTTZNZ0VZR1dl?=
 =?utf-8?B?Wm9kNzVOZU95WkpFMXRNS3kyOWlndFNGcm02NEdTOGhyQ3VOK2JUMXJWdWJL?=
 =?utf-8?B?cUI2eWtYZE1EanNDVU9NSXkxelVaNFJQSWFhdGM2bnZUMmJ5c3g1N0g3Z0s2?=
 =?utf-8?B?TVhpY1lTWTlwdUYvZ3Y1a2ZWNEEreDhycHRoS0tvVk9aZS9mMmkvcjV3TFpj?=
 =?utf-8?B?OGtqTkwzbUdJQ0E4V25UZmxZbWhubENsaVA2Mk1JcGsxWU5rTUN1cG1CVW91?=
 =?utf-8?B?ZDdaQXRiMVl6MVlwbytkekNpZFQ0dnp5V0VTRVVBUW9jNFRoKzFLUlV5dlNh?=
 =?utf-8?B?L2VUcEZ3YjRoRWxkV2k4N0FXZEI3UjdhTEZva2Z5amlFVmRXSE9QZmtjZUVl?=
 =?utf-8?B?VnNzTGlXT2QrZlUxdzFxcWl0dlk0ZmV6MTU4RW03ZXpIK1cxSHVWNmVwZHZE?=
 =?utf-8?B?OUdBOVVwQkNRbG1qcno1OVdNalNLbWlSdjdBQVp5U0tkZFdXVlNVRTN2MW14?=
 =?utf-8?B?RHN5UEd3Rjk4bFJrc2g4S0U3djA2Vk9GSjhPNDc1SEdUejM3Sldic3drTWpk?=
 =?utf-8?B?SS9WUytkS2dWMVFiNzR3NGlBNEJJQ210V2hBVTBqbkdyZjF5NkQxU3ZHM2t6?=
 =?utf-8?B?SnhsT0Zxa2hiRHlnWXBaMVhtUS9RYktvMzR2NEFWYnZVcFdYMExEU2dwU2hr?=
 =?utf-8?B?UEY3MHZTTnUwNXNPK2pjbGhCV0oxVWU2SkRyOVMxZGxNNk5rVUNhcm9PV2s1?=
 =?utf-8?B?WldrL3JUVFFEOTJnNTd5dFIxanhLVGt3elFiV2k4cFowZ2t5bUc3UFNFMmFT?=
 =?utf-8?B?bGI5OHlqVTFyY1BPdS9MTjFzUW55Wi9iakdIQUNpMFdZN1VkQy9KM05sU05U?=
 =?utf-8?B?NDIydEpvY2U3aDFhalZ2dW1EYjNRNU5nSEV5ZTJsZ2lMN3BOMVExdEdhMUtn?=
 =?utf-8?B?eVZVWXhYRXlkNTJkb2g0cjN1WW0vdkJBbitjVGhUVkpINnBCMlE1VEdDbUNo?=
 =?utf-8?B?TmlrVytOTzhWT3NNZXlIQkQzak1qanpIWG9kMVoyY1J3V0d6Uzg4VS9oMFRs?=
 =?utf-8?B?Q1h3SHYwcGwyUW9HTlR0TFZ3S2ZoN1FTVmErM08rMjZCb0Fsam82V1lVbFA1?=
 =?utf-8?B?ZHl5aXZaOFR6d2ZLbzlLN0hwd2J3U3BjcjJEbFVsQ0JOR0RDM1NHeGo4S2Yx?=
 =?utf-8?B?UFVIZ1NtVEtSa3pSV0pWRFRBU1V0bE9WcjNwb3p3NFJHNFNaYlB0cCs5Q2tS?=
 =?utf-8?B?SHAvL3Uzckc1elB2STZKUVJvQUtBZFFsTFVUQUE5OEE3Tm4zYmV6ZW5lcFdZ?=
 =?utf-8?B?SHlsZjYveEs4STRPSUYwMkt5NHo2S0w5OUV5NWl3RVQxMnBNNytPWXpzVlFL?=
 =?utf-8?B?c29vcTBHOWpIQzFXRmNCajkwZEtRZHJvTE05d1JiM3VoRGM2ajJEYzQ3OEpp?=
 =?utf-8?B?amg5MzJnbHVSazN1c0crTVd6OTNUWTZsa1dBb1E2cEdNWTVka0JmZ3hDZkFI?=
 =?utf-8?B?SVJvem5VOHBEVXVORTdTUHRlL251SHhRZXB1QnNxQkEwMEUvc2lBQTA3cytx?=
 =?utf-8?B?eDZXTGR1RnVldUhaVzFISVQwTWpxbmZiMFFBUXErQzBHNnJLS1ZkdVFmaC8z?=
 =?utf-8?B?UWQwNG9GMEtHREJxK3hRTyt1N3VNa2E4TllyNk5vOHNBd1FqNDcwcUlYOEFn?=
 =?utf-8?B?YlcvL3J6a1lmbThLVVVSZWZJU2EzU0U0dHJMcjkrQ3hMbTllYW11N08vblJI?=
 =?utf-8?B?bm1zdTl0TU53aTFQMCsybDdRYjJTWnY3eHBiRW5wYjhpa3k3T2RhdWJnU1RP?=
 =?utf-8?B?ckE2ZU5ObEg4TFNGKzZQbXhXWFhLaFRZQWpPVzhjb1BMbEZoMDNYSGlBMnI5?=
 =?utf-8?B?cXFSY0hKQnUxVTJCWTNlMWh2N0k1aTdzbU80SnJuYTdwbkhYWWk1eXdSK0lH?=
 =?utf-8?B?U2V1YlcvZEtWUi9qa3ZWenFEeFdScnJwL0tYUFEwNlowYm9zUWNRd1dnUHhO?=
 =?utf-8?B?QWdNdDY0Z2FKbnoramE3NGdTYTZOak1pMC9LYXkveEVKNWZJdmpGcGZJaWt1?=
 =?utf-8?B?MHQrNE9FY0I5aFVKZDFhMnRuNldEaERsNGdrZG9XT3A2Mk93UEd4dFpLb3ZY?=
 =?utf-8?Q?SO6zwXSMSOYYsxaUmCQ7b6ctT?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	NGKyRjG+rVvkjO/JSSrUF0Rw6FEEbnPRJ/8sL1xm57wc2OIQDKAz0QmgkXKHOQ5Fxz/qnQRDnz6UPIyYS+mjNyIzbPpLx4OffYTPzSZBjzR6NeDaZOJi/xCOumsmLcAKYlFZViOdPot3z/yy2TvT5DSBERWGNV7AZ91y6/9bASrryse40MJh5FKoiil8TVFb04IV/A1Z13EdybBHHY+otgdmzMOhrivSbZ5qp8xmnsvmXYd7WRcLGz+1/U7oRZ7+qT8fJRGv+mkRNOdS3BDmY/gnS84N2XbksTpgXUk/aHLckLvC9fzHytkdjBXb8/BfpnhX0s6CV0z89cft+9Py867EJVZ0Ld9E3wodpRW3bNkALYflHhxoX5VbMS8uTvGbMDVx2GrMSaucUGCDLEp1T4wSmqFIS8+PzSL+qZ8h365ShVm0qW1m/v83wmgi0bmxl06093e8xwJWlqPFRRLiaQiBG625Fzn5eltFdwHS7ICBslpVKBFv/ufzZr/P8Zy5k1Skwsaz2+6Oyuhzv+sUtjpSpWgkPF1uqwQcR8rzppCYEqp0YS4p+M8/W3T9jk+X/YWJ/AAKUIGurOcMxOoSaV7Mt7RecKBOdi09AfPk3UHMj2tIRu6RXvaPb7vF8FQbMhLIwORO0RH3z5CW6HKSsQ==
X-OriginatorOrg: llnl.gov
X-MS-Exchange-CrossTenant-Network-Message-Id: 3797afc6-7a75-43b6-7c04-08dc78e76bb6
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR09MB7071.namprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2024 16:10:52.1112
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a722dec9-ae4e-4ae3-9d75-fd66e2680a63
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR09MB9427
X-Proofpoint-ORIG-GUID: 4KhX29e0HUjUXtWDMXtV14XeORx-VVJh
X-Proofpoint-GUID: 4KhX29e0HUjUXtWDMXtV14XeORx-VVJh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-20_09,2024-05-17_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 adultscore=0 mlxlogscore=652 spamscore=0 mlxscore=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 clxscore=1011 impostorscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405200129



On 19 May 2024, at 6:25, Ren=C3=A9 Scharfe wrote:

>
> Aligning code and docs is a good idea.  Have you considered keeping the
> code as is and changing the documentation instead, though?
>
> The two options are related in that they both add untracked files, but
> they necessarily have different arguments:
>
>    --add-file=3D<file>
>    --add-virtual-file=3D<path>:<content>
>
> You can already specify any path you want with --add-virtual-file.
> What's the advantage of honoring --prefix as well?

I came into this after trying to translate an --add-file to an --add-virtua=
l-file and being surprised that the prefix wasn't applied. anything else yo=
u add, in the repo or not, it gets the prefix. I can go back and explicitly=
 add the prefix, but it makes the options less naturally composable in my o=
pinion.  The specific case was packaging some software that uses git metada=
ta to set version and some other things when in a repo, and files in a tarb=
all. The tarball's prefix is set in one part of the packaging code, files a=
nd exclusions in another, and passing that through was something we didn't =
have to think about using add-file, but do with add-virtual-file.

That said, it sounds like both you and Junio prefer updating the docs rathe=
r than the code, which makes me think I'm in the minority in that opinion. =
 If that's the case, I can certainly update the docs, and I imagine we can =
backport that easily wherever it makes sense.  I would really like to have =
the option to have the prefix apply though, either adding a new flag or an =
option to the existing one that would be invalid given current syntax or si=
milar to provide the option.
