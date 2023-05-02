Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3C62C77B7C
	for <git@archiver.kernel.org>; Tue,  2 May 2023 01:06:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233296AbjEBBGv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 May 2023 21:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232772AbjEBBGt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2023 21:06:49 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2063.outbound.protection.outlook.com [40.107.237.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0C3B3584
        for <git@vger.kernel.org>; Mon,  1 May 2023 18:06:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hhOOt5qzTKx+UtIKhSbeW+UNXkb+wuZmy7zjQ1glo/Evwv8J9Ss/TeeicLu9VFaSKapF31fQVDuvkK/DLhm46E8j5BKGtN2fIg0n9wjWciKanCYux2EuacKYXx/AFaqALxZ8K3Q1gjt5fCmdm3PlAs6dUtpUFP07G/Hei53rP+BrFxzSryU/DgjdorKGH8MfKT7REPXzNOuieIavUVWBDElGMejG/TVapRkEccJvf5qAvsutzFZjQT2t5I6vOHRfOEps3vb8rwSLgXYNmipAHn1n9elCiltQiPXQWruDRZRAIe84Ci+3qVTbmdN+1wht9Zf/cvJHDr/fLWb6S5dEVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7p71tBvgdySA37LvHT6oUykPPiQ5rFPGy8Nwl8S/XYQ=;
 b=MNBXD8Qq7sRuAKqMMLiGrFL1XCotnY7uJsNxWbRVFpXDhIQA0NsAeOZLZ18a45RnuKBWpKvCmpHSzTRBxExUcMXrWZIf/6mZKg2boeLx124lFoqT+JE/EqK+/Ao1zbPCRNywWRetYkdnbe38/enxPZzqzlhoW0oQgxPgVK5PertOAJYFUe4rYaurvZj/UzQ12tS3rpvesg/h+ohrXhdyEWP2Kq/y5JAqujcM0IS6yQYkxV5DPyAq0iobFX2gwtZVFg6ce+UwRjXafsbux1mifjKbXh8qluWLcZSwAhWWO1b7IqpweUA7Wd2qvuoB6Z9aEjPPBABf5+8xOorhOk3jcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7p71tBvgdySA37LvHT6oUykPPiQ5rFPGy8Nwl8S/XYQ=;
 b=s1Fh2djJcqyMAjwttzhenSq9MHAIqRnvw2e+GVKnRehUZksXAoYUkZFBKLYawY4P7b4WSjDXEeQ4NynMfJhwGPrn9d5/bdc6tdzY5NsizmDzhHNlGy4ccOy8lPD0vBwyLVkY5Kc0STeRJPEuKxFbJDRDvGz26Zzdc9F6LpJppNo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 MN0PR12MB5788.namprd12.prod.outlook.com (2603:10b6:208:377::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.30; Tue, 2 May 2023 01:05:32 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::8299:158a:c296:de80]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::8299:158a:c296:de80%6]) with mapi id 15.20.6340.030; Tue, 2 May 2023
 01:05:32 +0000
Message-ID: <fae69ed7-5b5b-0920-73f2-a0e72795c032@amd.com>
Date:   Mon, 1 May 2023 21:05:29 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Content-Language: en-CA, en-US
To:     Junio C Hamano <gitster@pobox.com>
References: <xmqq354f4sts.fsf@gitster.g>
 <41F7913A-E91B-4442-9531-5EE8EC2CAA9E@yahoo.com>
Cc:     Michael Strawbridge <michael.strawbridge@amd.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
From:   Luben Tuikov <luben.tuikov@amd.com>
Subject: Re: Fwd: [PATCH v10 0/2] Expose header information to
 git-send-email's sendemail-validate hook
In-Reply-To: <41F7913A-E91B-4442-9531-5EE8EC2CAA9E@yahoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQXPR0101CA0050.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:14::27) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3370:EE_|MN0PR12MB5788:EE_
X-MS-Office365-Filtering-Correlation-Id: e2c0efd1-ba01-48a8-b59c-08db4aa95400
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wffj6RbbBN2j1e8eVwb4ycCN/iPe3oixCMM9PdEiQ24HLWcBRNAJN+jp/Wzg/ZIKGEO06M116el9nNOL3A//1c/vfwa6LBmNQUQnFJ3t1VTJ8vBpsvUi2s0v9cZQNUuK4xne5efubosOaXo0vnpMWZ6DvnM17xVX+nTJ80+4QwWa/2BeW7jMSwdOoP4bzJA1DNhfVS2mIspAixYLRtZwXZvBd2BAf3UFA0m7/z6OmNoNGM8xoWl3n1RNpqgc+zNYwF1mtV05JV0rtrzjDPoXKtqnsLMbbNfU1iJ8W/Et1il7gselV+Ru3lXRZuA1GP1CONnIEQHAnwPgYVXCQcwrjEtF3VDeefWhazDlLBjwaFip3PN08TVT7DEtP0+zBZb2tzCpeKjqnLGLnkvp+n/bOeiEEbRJf5UnmvQCU4BFVy+J5mQh1d2zPOcjBhPh9jWLkfBqNVS87duBYEGe3mXxAbk4RyBtisAcbTa6C/jULm/BUGm6es59wMs44FlW1QEOd+IVVh4z6Usvy4R/yQBBOdgEIdWH6IMsx7XiOICmhplGyJhCurF1MbHsPkRk20xHvSHv/B56xKjg0xmTAfRgzXvJ4WupssD3SlybpgWWeIPZGfmOLk6PAZArLDacWBxrutkMZhJW55dIe9cql3+iiw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(396003)(39860400002)(136003)(346002)(451199021)(2906002)(6666004)(6486002)(54906003)(44832011)(4326008)(66946007)(5660300002)(8676002)(36756003)(66556008)(6916009)(41300700001)(66476007)(8936002)(38100700002)(316002)(15650500001)(6512007)(478600001)(26005)(31696002)(6506007)(53546011)(186003)(83380400001)(86362001)(66574015)(2616005)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YVY3NFRmN3NHd2l1azdIZ0RNMG1aYS9Odm04bDhTQXl1djZWTk56b3pOM0tZ?=
 =?utf-8?B?WVo4N2hLVzFUYngxUDVyTWNqSy9wVloxMC9ZK0l3SjNiYVA2Zzh1SWZSRmR1?=
 =?utf-8?B?dEIzNm91UThkRno2blBFQnU5eVRuK2R6RGhGb2pTODZjTlQ0ZkdrZGZ2QjZJ?=
 =?utf-8?B?YmpRWHgzSTN6YVJUbnNRc2FMUmM1KzFJZHhMQTdLUFV6YXNDWUhFbUloNjZt?=
 =?utf-8?B?QnNEd0loZUNmMWtwK0Q1KzJ4RVJsN0NHbjNPTkxvcS9IaCtpNCtiMGZGZGZ2?=
 =?utf-8?B?VzM1R0tjeDN3REJCQjU3Yzh4Tk43S2UzRmtjbHNMemdhSm9sMnZjSks5OUpo?=
 =?utf-8?B?ekVnaGxUWkJISUR2aDJRTUFaeW5kazhzQVJ6M0FOSFFvNEZmckVWcDZmMGNU?=
 =?utf-8?B?dkJLK3FVU2poNHVQOE5xWHNwZDhZOFBFQWpvL2kzZTZhUkVqMXlvREIvOUJ4?=
 =?utf-8?B?RXpyR21HeVhMemhVVmVwTjFGYm5pVHlhREVEcEp6QVFhU0xNSTBESEFWMWVy?=
 =?utf-8?B?N0t1ZnlPbnlhNnY0VDlDajkwWG9PSTQvTUJYNnVCS0l1clBHOTFvRHZLVGpF?=
 =?utf-8?B?QjJoT2lqNEVYOVMrQmF5UjR0SWpQZlJMMVU0ZFVpUW51d0lPMGRyTWF6VHpt?=
 =?utf-8?B?WmIzdUp1ZG94V1FNUEl5WUkybnpDNnVtLzFWTjZOUFVCUk1GUkRXYmxkWmpJ?=
 =?utf-8?B?VTBCN2RkODUrcTRwU1MzUXFnWTRPODJxejAxdktOc2FKUmRaUk5oZGVJV1J6?=
 =?utf-8?B?dnR6WmVGNkx5akNlYy9Ba1kxei9uV0tIQ3pybXUwSDFXOUp3c2ovMGJ6YldH?=
 =?utf-8?B?VXpiVEZxQkVOZnR1TzhOZDU5MGhkQmltWUxSTzE4ZE13aXF2RldyeFNORWRz?=
 =?utf-8?B?NEdDNjN2eTVWUUlOakMybWhLS24xOHNDU0ZQYTBBVGp5ZUkrNzFDV1RaMTZR?=
 =?utf-8?B?TWg1VlhKRFR0TzZ3aHZYT3MvVlRDUVdwdXJsQTYxSWxzLzQvRHdQQXdxRy9C?=
 =?utf-8?B?V1R1ZHJzRnJ1WTBWWlZ6b0t3ZEQwaHduSTRTZFJOWndaZno0bGd0N1g1dTRN?=
 =?utf-8?B?ck9rWU16bFh4dHBvaWZXdVpJRjNuVm5XWCtjQXBybExZVXpsR04yTUFidFBI?=
 =?utf-8?B?Q05Id1Vjcy9ZNkIyMGM0Y3lMa0hZT2x6NlNYRmNOWE1mME9jZzAwOUJrTngy?=
 =?utf-8?B?ZmZRUFJQb3ltOXZuUEFFaTRQazFLeDViQnpmR1hRZUdPY00walM4YUJ6ZlJi?=
 =?utf-8?B?NUtLdUE4VGZDRWEzQWQ5bE1LYnZoNXZXVExraFJJOU1KL2dVamJGUGQxSXc4?=
 =?utf-8?B?QUl0L0QrYlAxaExoYTBCYnNMVjJKU3NxRnJEc1hzRThoNVZMS2kwSldHMWtZ?=
 =?utf-8?B?dEloYWpHZ1A2T1dmYTJTK1Z0ZXEzM3RzYTE5U1RoT1YwcENHVk9EZkF0MCtN?=
 =?utf-8?B?RTNWWU1XT05kN1haMmZJdzNZc0Y3dGxGZVRJU1VZSE9Sbm5OM0dCTjdTdS9J?=
 =?utf-8?B?MHlmRXRUUGptZTJxMnNBaVFHL0lEc2UzOGZHY1ZWRnI3d3NFMTRqZFBKQjFQ?=
 =?utf-8?B?VDNJc0R4Y0J1NnVwUmFqUTAxUXY1S0tGNGhjMElQbVlCKytYZjVoMDBCMGQ1?=
 =?utf-8?B?VVpCdnFqb1dGS2lUaHMzQWFnenVldVIvS2I2QzBnMUFBZG5sNmd2WFRIbUJ3?=
 =?utf-8?B?d1FpWnZSTnNZZUJDRWlxYTNXMHpHcnY3TzdJN2VYT2dJSTZxU0tNTVNTUXVM?=
 =?utf-8?B?eC90SlJmR3hJRm5yR2lwZjd5ajgwZDFLNkRPdmdRblpMWVV5cnE1QkI0N2Jl?=
 =?utf-8?B?SUFXN2tWVjZRK0pJOHhJMFFya1A2RTFMK2g2OGxrenlGdVZpeisyYzBoa0NM?=
 =?utf-8?B?Zi80NDIyVDNRdVRaeHlydThMNjBRWDFHbnBMWGJHUWhrUjUyWVN0akNlR3FS?=
 =?utf-8?B?ZFNQRzZiMFpUTWpqZW83QkJGWDF2aWNYaDV1aWlzKy81dFpvUjJhU3h5NHFM?=
 =?utf-8?B?WXdSdXhkSm80alM5QVF1aldYSjdBQm1Fd3B2SWh6L1hzMFoxSzdZSDdPZC91?=
 =?utf-8?B?bDlyTUF0VHF6YnhBRmNZQ3AzN3RaMWtvSFNOMzJwdzVyNWdHZlNPaUxmdDEx?=
 =?utf-8?Q?o+0JwCQQ2gft24GJdMnNSoMa5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2c0efd1-ba01-48a8-b59c-08db4aa95400
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2023 01:05:32.4322
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 683tibaZwch9R7IlHIFqXlGbhAXNCuoHToInPGZhyr4Zelsw+O0HbFRmVTkuDl2N
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5788
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2023-05-01 21:01, Luben Tuikov wrote:
> Begin forwarded message:
> 
>> *From:* Junio C Hamano <gitster@pobox.com>
>> *Date:* May 1, 2023 at 17:58:41 EDT
>> *To:* Michael Strawbridge <michael.strawbridge@amd.com>
>> *Cc:* git@vger.kernel.org, Luben Tuikov <ltuikov@yahoo.com>, Ævar Arnfjörð Bjarmason <avarab@gmail.com>
>> *Subject:* *Re: [PATCH v10 0/2] Expose header information to git-send-email's sendemail-validate hook*
>>
>> ﻿Michael Strawbridge <michael.strawbridge@amd.com> writes:
>>
>>> My appologies for taking a while to get back to this.  Here is a reroll
>>> with the latest suggestions from Luben.
>>>
>>> Michael Strawbridge (2):
>>>  send-email: refactor header generation functions
>>>  send-email: expose header information to git-send-email's
>>>    sendemail-validate hook
>>
>> This round did not see any further comments.  Is everybody happy to
>> see us declare victory on this front and merge it down to 'next'?
>>
>> The topic does not make itself a reply to previous iterations, and
>> the cover letter does not CC: anybody who gave reviews to earlier
>> rounds, so it is a bit hard to answer the above question myself,
>> unfortunately.  I manually picked off a few names after finding v9
>> and v8 from the list archive and added them to Cc: of this message.
>>
>> Thanks.

Sounds good to me.
-- 
Regards,
Luben

