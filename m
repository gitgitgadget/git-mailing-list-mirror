Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 123B1C6FA8E
	for <git@archiver.kernel.org>; Wed, 21 Sep 2022 22:48:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbiIUWsj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Sep 2022 18:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbiIUWsg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Sep 2022 18:48:36 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05olkn2100.outbound.protection.outlook.com [40.92.89.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09F6DA4074
        for <git@vger.kernel.org>; Wed, 21 Sep 2022 15:48:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n+MKiL6PG+8vov9a1tJjjyLx6TQxspNDWt/LTiMdP1l+iJKTYU5AHXVwsvaU8Z2NRENf4i//MpDEOk9flsP88ZGQky/XpWcfsWn61LzcEg7LrEIyW2KYEyNBRbovmC6waP44sfvXEdp1Dps0bUM2zCsF/V0Pskgr67Zo+zpvQESe4opnJAH8BQsNblHNWACtEPg2zyJKCYfxqS0h5z/wy/NFWbswGu3Xk7f/J1HvnLasGyDuGWo3ulOnKrt5qMctWfMroM88vmvYgPeuM+rupV6wZbKunOlnEzZFr0fuDFy8BLMggrmOwXzvWdC2b7Sl8CN+K667IyfdatJqYwCDYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ur90yowCy3F1C8+wnTyBr2pNnty/HhacVRaekO54Fp0=;
 b=U7AcckX2JqzR1gy0x0CitO6Dz5UwR5QIM+mecIIowtKlLJYlt7n++wA9qzoIc/iOwjd2QAXddNF0AUQww4I3pkdsunR+zoirVMZkcHCnhfXlnac8DUzMqe6gjwpuTVFbpHB5DwGkV7XS+sKUeyrqS0ntBCJd8y2aYnHNB4qcSq4ExI5ZwwZJ+ThJRWJoS+y+X1CFsYFcx4wCmmlFGCYvAkZ2aRnlP+51XVtLN8oOsuyWw2H5f4knLLRGrCwycHCV/jece/hgLBH3vQ+sWwm3U4SwD2YhwqYUy6H8hcjB0DtfVrMiljT70cRHERT4hWWFCLh5PEKqAqHSfZs0fTBvtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ur90yowCy3F1C8+wnTyBr2pNnty/HhacVRaekO54Fp0=;
 b=n3eboJN/fbcllxu81YwkEagWTAr0vApluDpryzOYXyK/bN40Db9Ag82hvWcVeN4r7HOhwy/vpw8TMnuq0ZQWFp3CQ/zZO40vigDIfZe4qxMrOAzuntACxC+GkM/u31ym/cP1GvyS9VNfnmXR355dRrwx9HREDpxOST3wA4YYISqMTQG0xviNqe3ykQTRvIbKfACMidlyZPmxifBJLFaDH10hYECyLebuKVHi9FvOI8UeaNKIIP3n0CNCXIDd5s7FQKSG8sORGL2/38rvQEI+FUwDgBK/rFmPhze2+0E7khS1wA/X+1v/61GsTlm9ony3wOFiNSV8L+3iHKSVmWulug==
Received: from AS8PR03MB8689.eurprd03.prod.outlook.com (2603:10a6:20b:54e::12)
 by AS8PR03MB7414.eurprd03.prod.outlook.com (2603:10a6:20b:2ed::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.16; Wed, 21 Sep
 2022 22:48:33 +0000
Received: from AS8PR03MB8689.eurprd03.prod.outlook.com
 ([fe80::10:9a9a:64a9:612d]) by AS8PR03MB8689.eurprd03.prod.outlook.com
 ([fe80::10:9a9a:64a9:612d%4]) with mapi id 15.20.5632.021; Wed, 21 Sep 2022
 22:48:27 +0000
Message-ID: <AS8PR03MB86897FAC3E1E4F03D4420644C04F9@AS8PR03MB8689.eurprd03.prod.outlook.com>
Date:   Wed, 21 Sep 2022 15:48:21 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH 3/8] osxkeychain: clarify that we ignore unknown lines
To:     Derrick Stolee <derrickstolee@github.com>,
        Matthew John Cheetham via GitGitGadget 
        <gitgitgadget@gmail.com>, git@vger.kernel.org
References: <pull.1352.git.1663097156.gitgitgadget@gmail.com>
 <2ece562a5952b5752de5040b17ec36076164c72f.1663097156.git.gitgitgadget@gmail.com>
 <ead6293c-8906-04c9-6566-e47efb624385@github.com>
From:   Matthew John Cheetham <mjcheetham@outlook.com>
In-Reply-To: <ead6293c-8906-04c9-6566-e47efb624385@github.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TMN:  [778rOkb+OLLPN3KIi+gsqoOSi5rAt3U8ROsF5/I2En241TkdKXZMGDdhSuBsFHTy]
X-ClientProxiedBy: SJ0PR05CA0075.namprd05.prod.outlook.com
 (2603:10b6:a03:332::20) To AS8PR03MB8689.eurprd03.prod.outlook.com
 (2603:10a6:20b:54e::12)
X-Microsoft-Original-Message-ID: <0bdfe12a-9e8f-ca9a-3c34-47be19c0e79d@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR03MB8689:EE_|AS8PR03MB7414:EE_
X-MS-Office365-Filtering-Correlation-Id: ebd07a5b-e758-47b3-c0d9-08da9c236546
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aW6X5id+5oAm6+xW2XfASx17UMAtQxVn41d/Xkz4S3ngO4PWgyzQstnD0VrTtJQxN9wYbcNgb9ZnhAIwBKfTjYzei5bk8HwzeGuC0kGQuQ3BTMy1ZwPl3FGKGE15/Mb5oMspC+pWdEL1Kp4LOEutFUTCw2p1lJwlT+AwkX3RlfZbUWF1OXTJQWbD+AiI7YQewbRuqX5c5nj0M9cmIKrjiGANXl2cJrTM5vQ8ADf952HdedDuRJOFvTIXVgcLoqrqybR3t7Got9O4Iq6AUvtwDvcANbtGTNX1O+k3YymQ676eoWLE74VVw0L3fHn6Je4oDyOi5YIjBMYDR5u8jsGUJ0bwW3sJr2u29d5rvOoHC1r80S2DtjA1jVkKL4e0GBRsaANd68XyY2JzgoqR1Q7z0Fsph3TNFDmpsOHDm1jd1fEdP41GwZZjX4mNAJPT9EA+rZNTscVjaglZAnCpLGXu4xADcHB5N7Krws2CRbUjL+JX6uhX/J25Aqh69Fyu7/E45q8pQW0PQ8tPAPjYIYFA3MJNMihS4Krw01iYKgZeIiaCfNhPoImY3CBPf5/OnZ0xG8JS009NzUWxswzvHbSXtns8pLRBrOx/9GOwpy+j2J7Nhs5kHFWzII53JywyLKOmILPLpP9ZDWxfjUbdEJcbMgqU4tAWWKJuFZL/P6dUPH7NvJrrSXJnECpij2HB84UT
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WEQwdVVoRHJieW1LdHJ5QVNLeUsxMDVWWE5CYXdUaTc1UVpjbWQvMFdEQmZh?=
 =?utf-8?B?aE91MEpyOXBKdEppR0cxdHNBcERkSXlvQUNDT0IvVSt3R2lSYVVZNUd5OGlj?=
 =?utf-8?B?M0djQ2FRR2t5Y21BQUNTTE1NdVU2WTJmS2dmYSs3N1RaZDRnY09zUjM2WTlZ?=
 =?utf-8?B?ZDNYTGIrZzQ1NFpJdzBQK0hnaXVOT1FsaWo4TW5KVkZmMDBSUVNxUnFjbE92?=
 =?utf-8?B?cFFwMk15eTFWb0tvY2Y3VG02a2hHTmk1TVZJN2xTaHVYUGYwTXQvaCtEWm40?=
 =?utf-8?B?M1lYRlByd3ZEN2wzZk44L0dWUGYxTWVndVBPVkwzNkJXS1plZkM2cEpjTmd0?=
 =?utf-8?B?YUJUN212NFBBYUhiUWVoWjExMS9JRytTU0xWczVkNjBlLy9iR29QNlFiNDZC?=
 =?utf-8?B?bEw1L3VHYWRnQWZ1MEJUYkEyQVZxblFROFBUZVc3aHRydHdCOUluaWdra014?=
 =?utf-8?B?RFRaL2hqRTRmQ1lzaDhPVUxmK2RCUlF5YVNUckdGbDNsTXV0c0xWbWtURXF1?=
 =?utf-8?B?T2Yxb2lMRXpVWjBSRVlhQ21zZXJ1a3ZoeTlZNlpxbUhVWDNkb2VXVW5yT0Zk?=
 =?utf-8?B?SzgwVmVuMzlOaWJKMWYvREVwdzZ0YmlMUEtZREQvYTlUMnpjZDRNWDJXMGt1?=
 =?utf-8?B?MWJoMmlYVTlzenNQZmNkSjFXejFNQnBib0pGK1oxazRuQ0d1cWtmM1g5a1Ru?=
 =?utf-8?B?UU4vTUFIaERSTWMrZUNUWU02WWtWRDQ3cHpJMFNpK3V3Y2NuTVNhR3BmMU01?=
 =?utf-8?B?WmFOY3RJZ08wSjV5OXczazJyMDRIZkJndlhNdHRweUF5WTZQVTNwR1QrYkk2?=
 =?utf-8?B?MXEwalRXc1BPNFVrcEFvakhLZnNQZnJ6V2lSZnhHOEN1Rmllai9MTVl1dW15?=
 =?utf-8?B?WXFJWHNQTHZQek1iK2l4YWJOSTlUaXoxZVQvVEljT2EwVkY1cVpJK0xDV3c4?=
 =?utf-8?B?VHlTRmtiY0JIVFkzS2pDVXI3c1pTTDd2QlIvVWRSQTdrdmtIRFBGTHVnUlE2?=
 =?utf-8?B?UHBBT0doMXdwNWdIUlc1MW1lclFLdEtpUXgwQlhxN0x5TXBTVXVlZXo0T0xa?=
 =?utf-8?B?bWF3VnJlNmZ6bFVWSEUzcUVWaFpKL0FMSERWd2dJY25DcEQvRHlvV2Q1STZ2?=
 =?utf-8?B?b1JEUE1pc1hJU1EySVROekovZEhJMEp6NGUzcjlqQlkrUzVLeGpoc0JRS1U0?=
 =?utf-8?B?Nnc4WGQxdWZlMC9idUlJS2JxUmJsdFJla1U0c2d5MVI0WE9VWFdLMlVJZjhH?=
 =?utf-8?B?RnZQQ015eSsrQ0t6cGFINTFVa1pwM2FyNG85TFBYMzFodmh5NEFjMENyOFNh?=
 =?utf-8?B?UDN5cmdObkQ4TEcxWFRXUlk3aHFyWm5HcEtycjlyT2tsOEFnS0w5YmMrSHFP?=
 =?utf-8?B?RHp4WGN6M3dEdTFVSGFFTEVHSTVVcnYvYzlybTNKdjRaU3JTdUg4R3dTQWpQ?=
 =?utf-8?B?clhPRlAxYnZmd0NTWENKTGZ1NUNwR083T1pOODdBM3ZxK0hEYTJGRGJMbGJR?=
 =?utf-8?B?ZVcxT1k5K0Y0N09EdlVJUjA4bkVUNGFobUxEc2V6RTdSVVRqM0g4NUg5bDVY?=
 =?utf-8?B?ZWlCVTk5SGpRNUNiMW42cTBJRW5SKytwYWVib3YwOHBGbStnbHVVMnc4ZmpK?=
 =?utf-8?B?WmdSRWVQOXBtQ01XS3l0ZTVJODZhMEVxaFhSRzluSEF5TnBPVHRkamg3QWxI?=
 =?utf-8?B?U1pnM244SUdPc1JLREMxMUR3R3VyYVo5cllFd2FFNWdPMDk2Q2E1Q2xYUzFJ?=
 =?utf-8?B?dWoybVZtbGRTY2xWenEzTEswUngveHpvbFF5clJYNjA0TmcxajdGeWJ1MHNq?=
 =?utf-8?B?UmQzeER4cXZHNm1PU3p0QT09?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebd07a5b-e758-47b3-c0d9-08da9c236546
X-MS-Exchange-CrossTenant-AuthSource: AS8PR03MB8689.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2022 22:48:26.9676
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB7414
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2022-09-19 09:12, Derrick Stolee wrote:
> On 9/13/2022 3:25 PM, Matthew John Cheetham via GitGitGadget wrote:
>> From: Matthew John Cheetham <mjcheetham@outlook.com>
>>
>> Like in all the other credential helpers, the osxkeychain helper
>> ignores unknown credential lines.
>>
>> Add a comment (a la the other helpers) to make it clear and explicit
>> that this is the desired behaviour.
> 
> I recommend that these first three patches be submitted for full
> review and merging, since they seem important independent of this
> RFC.
> 
> Thanks,
> -Stolee

That's a fair point. I will submit these independently.

Thanks,
Matthew
