Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A5C1C433FE
	for <git@archiver.kernel.org>; Fri, 11 Nov 2022 19:12:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233900AbiKKTMN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Nov 2022 14:12:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbiKKTML (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Nov 2022 14:12:11 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2046.outbound.protection.outlook.com [40.107.93.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDEB35D683
        for <git@vger.kernel.org>; Fri, 11 Nov 2022 11:12:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kj23X7akSXg4KwrKRzcfa2CRz7c9zVnHCwlbPy02QzVqHAUn59LhgXtATRH/KBwJ0ZdjvKSFdy1MYUujfBx5p7rZ3qbSbLLULS5wrU35hvzOmyuVqI4TnoUrdaHlL+BX+iIwbYHVr5oIKew0gadCelFEM1kJYzX3thfCdjNVAru2lEM2pWZAfgRjy/XRkQrZ7Qq29rd/Ip6onW402ko9AwTeuU+/3tSy4oWWDfgHfmTh6K3XXVZLH+rRxA5e+PCxk51CuHci7oGA0pHda3f+gX4pHlj3S72Xowyc53KsE4s6rzv8XOFjPFeDcgLmfqXaspLX+vtkmXRg4Ewn6hSCXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0WEbwsvmnMZgoHwqrBtqReIJJpRf0xyj+zBkI5CrjVE=;
 b=j9UO3XNq3XwZ+C4ouE1ZVpRTRO2jHZvdLVhpw+eDO9Oxq137QLGR3aEH2Yl/JCXWbcEucj5NUx7o/VFYyh+q+5MA8Q3wPHf6COEHuCpxI2iFjg4WpKnOxjm2V0bIp2fcNWLv4cfJRlUYFu9aCbJ370CHakUw/MzoM8C9shaee+KOq2Q+3gQ8UEG1Ikf36J4PKJKF6KWyUZ+DYPCOeg6pt6lXYQrTykvIHkIdnwmlWxMhjFFORpPwHgk4A+TTStuxGqdhLJqoDy0nFd9i7bxjQj5rMq1ZlmoJmpUKnA60P/ERZTBFUYUvg8jsnZ+8rPBqF4kAhHHrRHCbK2rWtSXwVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0WEbwsvmnMZgoHwqrBtqReIJJpRf0xyj+zBkI5CrjVE=;
 b=beF1gUJh26sg21+tDRwQHROL+FrYRwLDNZjfTiMzXC9VlInhePZ+3xT6KkiIipTBlX3NLMCm5ojrmDozisQQTk7+R+c84+a/Uio7ZhLo0Vu/9l5rQL7ljGKWvTOeWIguCvOfyII1pCYbqi7N2Ls+FO0lt8nIGa42fTbGfFbJcBg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 MN2PR12MB4455.namprd12.prod.outlook.com (2603:10b6:208:265::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Fri, 11 Nov
 2022 19:12:09 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::d309:77d2:93d8:2425]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::d309:77d2:93d8:2425%7]) with mapi id 15.20.5813.013; Fri, 11 Nov 2022
 19:12:08 +0000
Message-ID: <3b73fc69-e6a4-125c-e101-bc0021801994@amd.com>
Date:   Fri, 11 Nov 2022 14:12:06 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 2/2] Update sendemail-validate hook docs to add header
 file parameter
Content-Language: en-CA
To:     "Strawbridge, Michael" <Michael.Strawbridge@amd.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Cc:     "brian m . carlson" <sandals@crustytoothpaste.net>
References: <20221111021502.449662-1-michael.strawbridge@amd.com>
 <20221111021502.449662-3-michael.strawbridge@amd.com>
From:   Luben Tuikov <luben.tuikov@amd.com>
In-Reply-To: <20221111021502.449662-3-michael.strawbridge@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1PR01CA0071.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::10) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3370:EE_|MN2PR12MB4455:EE_
X-MS-Office365-Filtering-Correlation-Id: c22cc0da-6555-4fb5-2565-08dac418a101
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yBe9Hh1f2yknquFCrWJbJl1PxQYoyDSRp0ZOpIJEk5Te4CcYl8vi09qk5K3IukFad07vzFEC6UPF7mGKO6ryANn6wwlkB5EMznZT8iBTwVTGebS4H3uWXsmX4WeRhWEvThAO1RWSNFJscOa5/dzdZUdJ4OU4GuXK2H7znLTicUmVD5lIvCzzbrSfI6+3BIdvGEvam5sqczJv1xPaCkPQrRIwatq+1lescr1Rk4ZEI9eRGD3zUAA/sYQ4/dt9o15d9tMXVJubq/chm2QGpMoZpwsuUCi5oCdC6oIPRCP+vlUuQENQGg8KfcOOIRAtOuQmXO7MBEL7/+8k97g3SyqKPj1oFQc77NPtJTwZdUuUa/kxfcfennaoxnJQ2Z7JfU+zQVvJ8h7F1lIHokuiGLMHtN4tfbqcZ8HJtJvp8GYnMHLcZZkIX5cmGjKuuznz5c5Fpjje4fY7bE6Lzm/gxnAhXPf3TR52/XRr3pPobki8TSqpiisxRHYDqoTgEKQsoUvUU+8bGoih2zB6AL+TPmuNV6FtQkCJ18BpDmJTyIhiVBcX1ZmGl80eq1Ch077AH9uv+nebmbqqzvSPZS/A/B69P/d1XkUlm7WYOKyEP+msdO+qD1iUpRXXZBRihGOw0O96cyPUu5OVZ04v6ADq952du4S4X9WGqcD/uJHIz1X2JorLOKggxBXaqeJz8qUB2u+OeyOYatkq/+iZVZ3VYW/fmeaAXHeYVsadQD18LEuYihSTiAKjKEw4ojg1S4T+fvQKvYIZVvmZ5Bjwo4LE1IvIA3mv/sFzvoa2FQlw+7rGmnA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(396003)(346002)(39860400002)(136003)(451199015)(4326008)(38100700002)(66476007)(8676002)(186003)(6506007)(2906002)(316002)(4001150100001)(66556008)(66946007)(31696002)(15650500001)(53546011)(86362001)(26005)(31686004)(6512007)(36756003)(2616005)(110136005)(8936002)(6486002)(478600001)(83380400001)(5660300002)(41300700001)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y2FmYkdsWjQvMTNQeXZ4TkxEVXJnZk1LZXYySnhkamI4NXdzNnJwTk0vNmJY?=
 =?utf-8?B?TkJkanF3NEVFb0Y0L3NacG5adHAxVFZydmtrY3MzUEJKK2MwKzhJTXB0eEl5?=
 =?utf-8?B?UzNBVm9sa3VreTl6M0tMWUNJcHV4blB1enRVcEwreTVKOXkxams2WDA5YURh?=
 =?utf-8?B?QzhnMFJIZkF0bUR1WVFMYTNIRSs5bjhnMHBBR0ViOWVIZkJaTythdERvdXZ4?=
 =?utf-8?B?NkNnNFF4blhDOUxwV21aWXg0R1ZpQWJHZDRORWoyamI5dThxZTV3K2trVzJr?=
 =?utf-8?B?ZXBUaEhtTGYvMUUxL0I3S1VTZkJ1dlVTWE9CWXdIWkQ3UmZCZ1YxemNxZVRE?=
 =?utf-8?B?UHRNTTdMTUh3Z2ZXL2RSSExWb0tRYlVmRkxFYTFFTWorekYzQ2laYkNXSUNh?=
 =?utf-8?B?bkQ3UEt4TFRabS85UFA3dk5XL1BtTXNBL0tMdkYyYlR0UWQxZmsxYTF4UFlq?=
 =?utf-8?B?elJ2U1dqRytDVklOcHJpZlB6eHlFNldpUGhQMFZ4TG90ak9QZW9ORzVkVi8v?=
 =?utf-8?B?OCsveUhNQnAyUzhxL0Z5cVpLakNhR1ZqZUorOElGeXB1QnUyRG5MUW15UFY1?=
 =?utf-8?B?UDhOV2xDWGpuZHg1aWQ4azVDQldmUUV0SUZ4dW53NFladzdPcEtWeVIxUXl5?=
 =?utf-8?B?ck9hQlhORTlkTGR1TFVwd21Ya0R3RWROYmJWeTZSbHZVaE0yOUJrc2IxOEhv?=
 =?utf-8?B?dkxCbXJ3emFZK3g3MW95ajBBZkRXUm5ld0dDK0FaMG94UWlaQ1hHUXB5bXhP?=
 =?utf-8?B?ZDcxVlBJVnN5MFVZb3NLOUNXQ0tBSlNxRVF4UElmWXB6QTVjMWNaMVVVa3g5?=
 =?utf-8?B?dVZ6ejJ0TVB3WFpCVDM3UGZ5NlMrMCtQRmFXVmFNbURvUll3KzMxZnU5cTh2?=
 =?utf-8?B?d0xyTWtXUWtWLzFGc0s4Z3dIdU0wTzRUOFd6RGkyT3h1NWlWYWJjZWlTOURO?=
 =?utf-8?B?N3lCcVBCTWg4bTIwQzE5SE5xZG9jQnd2cCsrZENXZ2lIMTlKRVRJanFKYkNn?=
 =?utf-8?B?ak5mTXZpdFphOEJqTjYzaHRTSFJBcXBtVlJzb2x0c29hMnk5WUE1NElBTW1D?=
 =?utf-8?B?THRqb3E4RHBkcS9ObE16aW5HL3FXWmNBREtCeFJKNEhHZGpkUStEYmJlcURK?=
 =?utf-8?B?ZFdYQmhCQUJxUUIwdlZGRk1kMFQ1OVhSdmxZZGI0N3FvOWVQU3paS2tDV2VN?=
 =?utf-8?B?UUV5QVBhSldlZ3VpQ3djQVpnWWV3YXBqZ0ROQmZWaytzTDV1cUxuTi9lTFpI?=
 =?utf-8?B?YWIvZFBHNzJkOXduS002MlpzcnJaa2lteDhMWFR0QXF1bk5teDRDU2N4QUw4?=
 =?utf-8?B?RnZuYkx2TUZ6MkhYRnRGZGFmcTg2UkhMUmE5aWRiZTVsaUZXMmVjS2JUbXF2?=
 =?utf-8?B?VTJISnJKeGY1b2w0aE1WSWdsYkRHWS93UGhJcXk0ZmgzV29BSkhsZGpRZGtw?=
 =?utf-8?B?aHZCUktUazkvVWJoNXhVeVQwNVJuQWd5YVREWDBveTdaK1RhYldpbmJ6NTZH?=
 =?utf-8?B?WmEyc3ZWZjMySTY2OURNRHcvUk1qUEErN2NPendYZVh2ZEFKOE5BTlBQZisr?=
 =?utf-8?B?YnJEd0xJSzVNTEFVNm5JNGk3d01iZThSRlRra0Q4UUNCbzQ5UE1ZVkpGalo2?=
 =?utf-8?B?azhBSkZ3R0dRNWEzM1JtZlVPakQxTnRtMEphNmh6a2dEL1ovZlMvdXo5SjBH?=
 =?utf-8?B?SjVjeGViWlIyN1ZlcnBTT012QjdwZFYzZ0ZKRWp0U1hJY0VKd1RIS3hjcWlx?=
 =?utf-8?B?aEhSY1R6NlVpaDVPRWZLazMxZitSNzdKN0ZYbVNwMGVOOU5sL0xQU1FlczRZ?=
 =?utf-8?B?K1plR1RLNWQyVFhEdkVWUW4yaWtDVFFMOWMrd0Vibnh4ZjdVdGExaDA2NW1a?=
 =?utf-8?B?cjBnb0ZJOXBqci9rMzEzREpaam4zK2xJQXVZMkNLUFRKSzgyWmFpSEgyMjh4?=
 =?utf-8?B?YTFDd3lCa2pBTWVETzJuNnQ2MWdvQS80SWdEb25FVU91VWF0cVI2eHN5bUp6?=
 =?utf-8?B?Y1RFUnJJQVk5aURrV2Rzc3VoMVhVUFMvaS83NS9ZdVFXVkdHcWdFR2tOTjZC?=
 =?utf-8?B?TEJDZnFSNXZ0c0xjeVNjVW4zcCtUQmxxWFRBNUdTWlBJcCtTWE1tdnRqWkx0?=
 =?utf-8?Q?kwaANYd86ownhO52K6Vl7How9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c22cc0da-6555-4fb5-2565-08dac418a101
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2022 19:12:08.7843
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZuycAogfoI5aWC8xYwQyaQfolAJ9SkoXrp5ebo9Fz/89THRTJHdGaZV39Yqtu7jq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4455
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2022-11-10 21:15, Strawbridge, Michael wrote:
> Add documentation for the new smtp header file parameter used by the
> sendemail-validate git-send-email hook.
> 
> sendemail-validate accepts the patch file as the first parameter (same as
> before) and now also adds the smtp header information as the second parameter.
> 
> Cc: Luben Tuikov <luben.tuikov@amd.com>
> Cc: brian m. carlson <sandals@crustytoothpaste.net>
> Signed-off-by: Michael Strawbridge <michael.strawbridge@amd.com>
> ---
>  Documentation/githooks.txt | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
> index a16e62bc8c..c1baf34454 100644
> --- a/Documentation/githooks.txt
> +++ b/Documentation/githooks.txt
> @@ -583,10 +583,10 @@ processed by rebase.
>  sendemail-validate
>  ~~~~~~~~~~~~~~~~~~
>  
> -This hook is invoked by linkgit:git-send-email[1].  It takes a single parameter,
> -the name of the file that holds the e-mail to be sent.  Exiting with a
> -non-zero status causes `git send-email` to abort before sending any
> -e-mails.
> +This hook is invoked by linkgit:git-send-email[1].  It takes two parameters,
> +the name of a file that holds the patch and the name of a file that holds the
> +smtp headers.  Exiting with a non-zero status causes `git send-email` to abort
> +before sending any e-mails.

Fix this: smtp --> SMTP

Regards,
Luben

>  
>  fsmonitor-watchman
>  ~~~~~~~~~~~~~~~~~~

