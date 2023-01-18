Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 806A3C38159
	for <git@archiver.kernel.org>; Wed, 18 Jan 2023 16:36:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbjARQg0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Jan 2023 11:36:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbjARQgI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2023 11:36:08 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2065.outbound.protection.outlook.com [40.107.244.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 177C44F364
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 08:35:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oKtAtTAo8jEVy5Ppma9cbMZ6mOcKR6UWvZLi4Jw0oMDlnHPrqgaF+cKkuJmUflJzxHuMqI5KMubtdbe3G/1v5Xr8GUJ8Sw1AvKXK1X2Jlz6ySrlG1Upcuo7pRB3SpKZB+dQXgwxLEzKw2xntG5dHJocfjGOsa6S8+yknLEAZ87BpyHxQ8adyCO5bqCQokPCJjDapOI5zNsSbB5uoLDK03o+88eavKN1d6wKfZKfseShZQfURzGQwL/ngwV2HcPThK5aP6yVJdj/KDqK/iESfV6KQZ6B+XOQLwiPTzXYwqzQKogUOSSfg2vscyA/JrUHTGBzCMARz87Doy8AtlLxuGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+HkRdTane9TurdIM+LtE+phMz8IHDUYuOnYNpMVciCU=;
 b=AOpyRHjEL8ibE83Jol3IF8bMvdUqkc7PKNRs83TXZv8Ic3GZsYIudk4PfH0kOj0ITUfLcz2KTJ/xWEl7e6qGk+4aK7xECVLSnA9B/uY643vXV5Fp2zRAluyCPFCcLZIH6MwVVdcMIcVhIUka0B0v01SrgDwS8rrUJ1LP9blsTrn/3aTZCF1xQgbX6yb2mr4vV8HvwT8O+esmf4qU1LoLkpV6rzERs5k1AntdXpQ5MPOAXaBsQVbOGZa9766jjaGaas+OqiV5fHQcn0CzqKMAFOgq3OZJkPX2xbyjYC+yIm67/+tVJJ3EPleUZQLHaSiu357DQ3DSN+0DVRJjIvjk4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+HkRdTane9TurdIM+LtE+phMz8IHDUYuOnYNpMVciCU=;
 b=Jtdlb0EOPOyb264SWrGSe7uOD9bacaFLjLn1191aQ418s7yw9NQ6Xxzwdwt9Ew5YZsEXDVnepSbTGLAvIGkkAnkGYbHXGMmncof+y1TV0mAHV8sieC4iuS5p0P8ikK7lSzYNW41arlk3tXWoztlj+yJBulM++l9KPBt3ErwuBqM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 SJ1PR12MB6220.namprd12.prod.outlook.com (2603:10b6:a03:455::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Wed, 18 Jan
 2023 16:35:21 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::4df2:b32a:e628:c57e]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::4df2:b32a:e628:c57e%7]) with mapi id 15.20.6002.024; Wed, 18 Jan 2023
 16:35:21 +0000
Message-ID: <fa9b1371-0a61-147f-637e-cb09f775fe22@amd.com>
Date:   Wed, 18 Jan 2023 11:35:19 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Content-Language: en-CA
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "Strawbridge, Michael" <Michael.Strawbridge@amd.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <20230117013932.47570-1-michael.strawbridge@amd.com>
 <20230117013932.47570-3-michael.strawbridge@amd.com>
 <3a2d4559-fce2-80f3-bafd-5eb8ac1a7eff@amd.com> <xmqqbkmxbort.fsf@gitster.g>
 <71623e1d-805d-cdc7-d872-224821c1383c@amd.com> <xmqqv8l34xkp.fsf@gitster.g>
From:   Luben Tuikov <luben.tuikov@amd.com>
Subject: Re: [PATCH v6 2/2] send-email: expose header information to
 git-send-email's sendemail-validate hook
In-Reply-To: <xmqqv8l34xkp.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0092.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ff::26) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3370:EE_|SJ1PR12MB6220:EE_
X-MS-Office365-Filtering-Correlation-Id: 98acbb75-9f85-4bff-f12e-08daf971fe0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aEdNXTJGBSudZVhReJPxYVIyCkr6WfmDcpBHlWSDvweJpn/Bu5CXHJ7Ite0loACbWhpFbc7feH/rJI2IcTfaT2UxxbxF0WgUNdSsPRvQ+itcxwseBVnt4t0KZnc7bHL0TUj2HZyZO3oVnMdCty/wLFJO4Y35TCXElVSiMgn1o2Lgdpjlc+kSS+K56y+0BkETFC3FDG26p9R73G8uTYv0BVQ4xP2p9jOCRuG2fpWJ5NwYBHeHtxlJTlj9Ci5QySZwHSW3838ltVPhn5EOTq/B3Kslsp7AAznNvEQ+2EV7nn5+GUtJqfEK2wINh7a1VUe5NmPGYXZneyJuN281SCx48amPjZ/nn8es9WIRtWBCRxs8o7TfDKVZen3qT3TKBN/ztVnGaB+mdDhiI2KVSWAwstfHiEC1qO6lZjelH510avtPIU7cS325mQYRttvJh5MjdS4H58AxsWZypX7jfRCDcDBE1kbq69Xj0Vu9nGh0Hk8Rh+BuleC6PztcMhoW8lj5bKqGVmSEKmTmwsgzGDCz7OxiJt1eFA+vSLRbJGdz0GTt/jO1FMkNVmVuzN3KNX43cSAz+cnPrklhwV9C9rHkG0wrb4nIMGHxpgKzMyUfPA4ud23YLy9sHIKMCuBJe6tim750VVLcm+L0cRR27b4AlLFbceyHj8ru76YLUy9b9HoYfKbZ+x8J3x4rG5nyHVqwGgvF4qIVzmVh583FBrr22CokdKWQ2gmYUO0FogZEZxU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(136003)(396003)(346002)(376002)(451199015)(36756003)(478600001)(31696002)(54906003)(6486002)(6512007)(6506007)(44832011)(2906002)(26005)(15650500001)(8936002)(66946007)(316002)(41300700001)(5660300002)(6916009)(53546011)(66476007)(8676002)(4326008)(66556008)(2616005)(38100700002)(186003)(86362001)(83380400001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QkpJV0ZTZHk1UG9jcFZteTR0N3BSdVAxUG1DTnpxeS9ORmkzMHdkWEVZSTNS?=
 =?utf-8?B?V3RFbUQ3TFNKUXo0Q3YxeU5EblQyd09BSWtodXFUaGZPekwvYkEzd3IzR1M1?=
 =?utf-8?B?U2Z4b3AydFNrRzgrc2tkR20zS0h4Y214TVA4emowWjh5WHFsd1J6czBEUFJt?=
 =?utf-8?B?dmNOcDd2QmVCUjFNQ0ZrelRNQm5NajZHSTQrcndyanZSbytMbzdraXcrODJZ?=
 =?utf-8?B?QU5HNkZTZXYzKzRLVlNIcnM2K2ZodjViTkV6Njd5azFkdzJtMDRIYUZRQU9I?=
 =?utf-8?B?NEwyU1d6SkJ6OStsN3RPQi9ZakRxZXZUeENOOWdwYmRjVE0wdFFydnJHTFhC?=
 =?utf-8?B?NVNFVk9qMHBTaWJpU3JTczJhSmdzVUh0Slp0RENkSy9IeFZOVDJEL253TUlu?=
 =?utf-8?B?dmhFR05vQjg4dnE5WTl4RVdTeVJ6dEJMdDFNQkRTdlJ0V1ozRXFLYnIwZDdU?=
 =?utf-8?B?djZCK050eTFKMG00cFlDOHMxcm5ISm1BK2NKTVhibXpiVWR6dVhQYm9Uakov?=
 =?utf-8?B?VjhpdkpzLzdCd1R0UkhyNk5tRDhNK21wK09QVjVWTUN4S2RRaXZqU2tXclJH?=
 =?utf-8?B?NjVMOFYxaVhwaGdQQWlRVXVCTUV0VExsOTZzNEJyMXpBMkxZalE2OFVGOU02?=
 =?utf-8?B?MFJhNVVoNmVOczltUldVdEk2VG4rNHNCcHFkUDljZTZvYUV5KzBMbHlveVE5?=
 =?utf-8?B?VFJpdjBCSXQrSU1oUURWSlA4ZWJtRGNtV1Qwa1ZhMlZoS3hhSE9hWkdxMVpU?=
 =?utf-8?B?eHNYR1FyUkxXQmJwMnZxa1F1WjU3Mk9SR3dBd0FvMW83dmdqN0pBTjhYRy81?=
 =?utf-8?B?NitRcm0wNEZ0QmlyeUczcFRpVnRpeGZRcDM4QlovMWpKNFhUTklCNHNZOW5E?=
 =?utf-8?B?Z0g1RzBSeGtVcjVyZFJoeTJvUXFzQm5oYTJrcitlWENHUVltM2lRK1d3T2w3?=
 =?utf-8?B?S3p4Wkc3ZlFBNW9BLzd5MTM0R1oyd1BWUkJJd0swOXhFYTBJM0xBUjJleEFv?=
 =?utf-8?B?SXdOUzcvSlZDU3RUTWFmMndhc3hkU2VUUW1uK2xHT3BjK1plR3dYYndBNXBx?=
 =?utf-8?B?VERDRmw0Q1BtT2JKeVd0ckV4cFptVVoyd2xZam44aCtzYWI0WFcrU3oweE9n?=
 =?utf-8?B?K0ZhVFpQc1pOUUxFZHVmdWZ1UURJTFE3emhBb3d6aXUreVhhTThSS3dkSXYy?=
 =?utf-8?B?RVl4NUxUQlZiL1pOUXNIc01IQ3BDL0J0RHVhNm9FaUdpTHN4UXVJZmJIMlZy?=
 =?utf-8?B?UG4rQjJZK1ZBS1l2YW4xcEx6ODB6Vzd5R0pISkRDVHA1Q1p2azdFVVk5VHBZ?=
 =?utf-8?B?Z3JaY0Z6UHdhZnFaL2hPRmZvV2Fsbk5JK2JlRGdCTWtMekZZQmhFbTFCWTVR?=
 =?utf-8?B?L1c0ZjVyeWhuWUh2Yjg5R25LU014dkRoTWZMMzZVVlViSXZTNnl5a2hRdEFR?=
 =?utf-8?B?QTdTdzNKSFBzVzJKZGU5a0wyYVJFcURwaWlyeHYwc2NZOXFhT1E0dVV4ZnRG?=
 =?utf-8?B?d1FSRXZXQnlQTmFVRUpEVXI2UFlUZ3NHZlk1S2t2eWtvVHNJNndobGJaRytN?=
 =?utf-8?B?TGVvSWJBckZGYXFBVVlTMnFqYlAzbXFrd2hNbFdLb0NOdzJGOExHWHM5cDFS?=
 =?utf-8?B?TUtxQ2w0d2lGQmxCS3NqUlM0Y2NNY09tZE5LblVmZ3ZZaE5MS0NDUXk3RXVN?=
 =?utf-8?B?WVMyd1F2dmIxbU01UmJNVkNxaUdHcXYvK2taYXJUN3QyaUJtWGFwRWtsNzRs?=
 =?utf-8?B?UjBERVZIYWFOYUI4SGZKalBMcHBpV1ZEWVBMUmtvRndXd1VqMGpKbHpWYmdx?=
 =?utf-8?B?emxRZWJaOVdCLzk5UUtzRFJBaVRCZ0Z5MGdSN2JFNCtITFNpcW1GVDZaR2NO?=
 =?utf-8?B?MHY3OE5LRDRMNVFYK2dhUlFoZnFWenRTbVpMVVo3cXVSdm1TUlZRbi9VRnNl?=
 =?utf-8?B?dUpGZTJONEF2TEZCaFVkRzR1TzZuQnVRVGt2YlR5K0NZeldUTFJrSFMyOHVx?=
 =?utf-8?B?cHgxSzVBUGNWVFYvcXR1UlpCRnNBN3RQd1E3emtmNWRwZGI2bmx6MmMxV2JD?=
 =?utf-8?B?c2xQUzNJcmlBSWw0K3p0RDJCREtzQTZ3WTRoMjhHSnpxeHYwclJDMHVKWTZD?=
 =?utf-8?Q?wF+9Qlfu1i81EbtUuMmCy9Jri?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98acbb75-9f85-4bff-f12e-08daf971fe0c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2023 16:35:21.6634
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0oqoe/U3R7hI+fsSDn7Qb7Fm6/u7/QqR9akPVhNCWkjyTl7xHsuiCAj5t+OcvJiQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6220
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2023-01-18 11:27, Junio C Hamano wrote:
> Luben Tuikov <luben.tuikov@amd.com> writes:
> 
>> On 2023-01-17 02:31, Junio C Hamano wrote:
>>> Luben Tuikov <luben.tuikov@amd.com> writes:
>>>
>>>>> +test_expect_success $PREREQ "--validate hook supports header argument" '
>>>>> +	write_script my-hooks/sendemail-validate <<-\EOF &&
>>>>> +	if test -s "$2"
>>>>> +	then
>>>>> +		cat "$2" >actual
>>>>> +		exit 1
>>>>> +	fi
>>>>> +	EOF
>>>
>>> If "$2" is not given, or an empty "$2" is given, is that an error?
>>> I am wondering if the lack of "else" clause (and the hook exits with
>>> success when "$2" is an empty file) here is intentional.
>>
>> I think we'll always have a $2, since it is the SMTP envelope and headers.
> 
> We write our tests to verify _that_ assumption you have.  A future
> developer mistakenly drops the code to append the file to the
> command line that invokes the hook, and we want our test to catch
> such a mistake.
> 
> Do we really feed envelope?  E.g. if the --envelope-sender=<who> is
> used, does $2 have the "From:" from the header and "MAIL TO" from
> the envelope separately?

I'm not sure--I thought we did, but yes, we should _test_ that we indeed
1) have/get $2, as a non-empty string,
2) it is a non-empty, readable file,
3) contains the test header we included in git-format-patch in the test.

This is what I meant when I wrote "we'll always have $2 ...", not having it
is failure of some kind and yes we should test for it.
-- 
Regards,
Luben

