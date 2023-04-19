Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45BF4C77B73
	for <git@archiver.kernel.org>; Wed, 19 Apr 2023 18:05:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232588AbjDSSFS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Apr 2023 14:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbjDSSFQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Apr 2023 14:05:16 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2084.outbound.protection.outlook.com [40.107.244.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8602159FF
        for <git@vger.kernel.org>; Wed, 19 Apr 2023 11:05:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aJiu10HRUZLihuGx2HY8xjrNQ3RBVXcBN41+gqKlR3uwlyIlYho8IuMfR3QJm0rPXO6op2w3T+4ezf9zcNQRUY54FuOfnGeyJUtb6xCZBc/831BceOOp4f6HlxMW5881IicJcY1Zee4SkV1qnX7e3pWX9miDln6LW2+4YFObP9iAa0f55MI9fxU5FEGC4Qp+M8Hhs1zt8LD6ZRLpi//eh5kNXbymb3m9Q8MRf7FwyI5+0tFuj8ZANQmKgkBMbqxZ1pa7qhDWCclz7/TaNPlkX9kmit52sM6be5bmmJZrtPas9A/yWL56671mST+aowTEFU8AlDlQ7Omszur5ik5KIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HoXEyr7PbGMTKLlGinzs+v5qdrrJOdaoHVwpoT8McGw=;
 b=OkATkxk+qUMl02PuwijJS2VWGItvRge5e7VSRTpfyP3WuQl9W/YESo7WH+I3yepsP/4hGADADYaDat4FsKKrBB8v3XNRqpmK5yVI8jqVqyGi5cnfGyXV2iYGLwmlj65n51wquW0gNHCOpnAniM58LY2d0eS9G30jsQMJBYRNIjKG42zEMgXl3C1qxtLMm86KNav4Kf2YlilVsooqxLRu4CubjX5u+UuxyExmWvtNuDPtXqdS45v4hxuhvh0QprsDtqmJot1cY2bSlhd0AWREKOlYNeNbnrnpeoiAwMTu13Ne9mDz4HRzc2NQQFEsVq6YKPClBlvUiq116O9SGd3tWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HoXEyr7PbGMTKLlGinzs+v5qdrrJOdaoHVwpoT8McGw=;
 b=0bUWPBWLWkGSoCayCE/qfnc5d8grnfZ9x6WnhtWL5W1X9JN/TZeG6I9qLMQyHPIHEftlVRaAUeKilUzfAPKRZVVob264TrGXsP7uNJldQ6MoaUcO9h9hnUad9l9fd541o7LzV3lMe7LYlwW3y+wCV7w1QXVp8eWbvOwOAXoBygM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 CY8PR12MB7515.namprd12.prod.outlook.com (2603:10b6:930:93::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6298.45; Wed, 19 Apr 2023 18:05:12 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::8299:158a:c296:de80]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::8299:158a:c296:de80%6]) with mapi id 15.20.6319.022; Wed, 19 Apr 2023
 18:05:12 +0000
Message-ID: <668c657a-34e1-fa70-e448-5c297fc506d4@amd.com>
Date:   Wed, 19 Apr 2023 14:05:09 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-CA
To:     Junio C Hamano <gitster@pobox.com>,
        Michael Strawbridge <michael.strawbridge@amd.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <20230120012459.920932-1-michael.strawbridge@amd.com>
 <20230120012459.920932-3-michael.strawbridge@amd.com>
 <e353df62-c189-755f-5536-5ea91177c55c@amd.com>
 <c1ba0a28-3c39-b313-2757-dceb02930334@amd.com> <xmqqttxb956n.fsf@gitster.g>
From:   Luben Tuikov <luben.tuikov@amd.com>
Subject: Re: [PATCH v9 2/2] send-email: expose header information to
 git-send-email's sendemail-validate hook
In-Reply-To: <xmqqttxb956n.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0141.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:e::14) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3370:EE_|CY8PR12MB7515:EE_
X-MS-Office365-Filtering-Correlation-Id: b36ec79d-e662-47c9-5c69-08db41009e84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SVZ5UIseGRRBc07NTl/jugtP4U/JmZAO3yvwsNNNmr6VLLRfx2HoBDv24qcScuNuAQPeSvDO8a00ZAt+QOui0YKVtvfEZWGo5nFv8tQ56pvK3Agbw7s5FrsiglCRN28mGNyluj1ZOgyCs2dkWEEZv10MGXpQcos8uQ0OJ44PcFJPl0+364toobliWM6rQ5GpRYEOeHE7nV+PHlUrVuHcjxcWaxnup0Y0EWo7n77SzdO0NHmtWLgujykFGoAUqWKUerxLBrk4Cp3a6t+TKNocfpkKd3WYljQxitP+qJqN5eMw6yyV0VBD+qFOmR3p2fkoaiB+w4ajCoJu3FESrpHhQzlT6e05hpmH9ilw0s64FOu3s+zlCppdITAncsXpdcHueSHZl41uq4VtjUkh1iymJLazQ2IJW9spuJ9Q7BRNbQ+ZX6nLlgmiJoIf9svl2R3I2l4LsLXBeX7G3SLLtIoxnu1Fqi6PYPaO+KhzjJsCd8KUY1PPKs3zMb+fYU9cCTPA94+MJAydOMdPeDJYmJd9uxEmieTBlOksCoMu2e8yKPuH2X4x+X2jQAmSpBA6zjSjf9Z/2+R4SV/oM8F97e7gErrZ5h6CTJ1M4bMw3mOcUEGVUVI8mg+ITw9/23PDdZd6uT1cnX/6jSjMBf4Nzk3H7Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(376002)(346002)(39860400002)(366004)(451199021)(36756003)(53546011)(6636002)(4326008)(110136005)(316002)(66946007)(66556008)(66476007)(6486002)(41300700001)(6666004)(478600001)(15650500001)(5660300002)(8676002)(8936002)(2906002)(44832011)(86362001)(31696002)(38100700002)(2616005)(6506007)(26005)(83380400001)(186003)(6512007)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y2xqdkR6TStaaWVKRkJGdUZWcUFsa0JhWmZkN3drQXg2dVdRaEp6U0J2VGRW?=
 =?utf-8?B?c2h4UlBIZTRKTmNmd2NBbzJzbzRUb21TRFRwcGdLcVFPVy8vTnlXV3BsYWhP?=
 =?utf-8?B?YndzUFlEeThXRVIvSHE0UndPY0pQVHdqd09vbkpucTVDZ2xFVWlOMHkzbkNU?=
 =?utf-8?B?VnRUT0ZPc0xjNlozM2V2Z3RQSEFSUU9EYjk3OU9JTTdkVEVJTU5sUGs4RU9l?=
 =?utf-8?B?YnNScExLamx1YmZ0T0xOVUpidW5DZjdpQWhXMHV6V3lmNnYvR1djOEdjd2Fk?=
 =?utf-8?B?MUZLUnhJY05xd0NGZkU1WXdyUU1CWmRuUTBoMjNFYnkzbjR2cTdyRHBPdWd6?=
 =?utf-8?B?b3hMYWlxQVpxRUxzakRGZnpNNVM4b09zQ2ZHY1I0dStTbzVrbVJwTy9WQXFK?=
 =?utf-8?B?YnIvRFNzTFdxR2FackdHeFg2aHFvakQwbWhDclZ3OWVxRWNqc1piZmhzZnZp?=
 =?utf-8?B?Ri80bCtOZ2xTZkpJLytLeGZpUTF4bFIrVjNmUjJzdTRUeklJaWpmTlMyRkxD?=
 =?utf-8?B?a2Z0bzg3ZHA1S0d6cVlUd2ZXRDJwZ0JYMVNBNFYrZm5ieTdtMTQyek9lMDBw?=
 =?utf-8?B?MFpnUnVlWE5zUlUxSG1FeUR2OXl5MERhWnYzRko0cUEveG4xcERBTjZvWjR0?=
 =?utf-8?B?SG5sczFnWkdSanA4K2EyUjkxUU1hb1NtRVJHdnpKZjMzZ0l0bCtEbnpWQzlM?=
 =?utf-8?B?cE5uaXdEckNoSElXeXMrSVBCcHNuOVRNNXRFYWVuR081ak9Lc3E3ODlUNWdP?=
 =?utf-8?B?bFRLSjhlbGFUM2R1Uy9pUWxXTGRUTlZCcjUzUUtBZytrcWh2SG1NQm1nRzhX?=
 =?utf-8?B?VWVLNGlGTG5NMW9IL3VoL2h5ZmVvYUJTK3U3cnRqQ1MyMURzWUlIMlVLcWFQ?=
 =?utf-8?B?WjhGdkkyTDlxSGlHMkRFQ1hpQkdyaEhwZWlGTVc0UjZKdEg3NTNJeVBWRWl0?=
 =?utf-8?B?NURUYTZRaGF4R2dYYzZMbG94SjNFcllESU9aUDQ2d2VMaVdwejdMdXU5Uzlw?=
 =?utf-8?B?cmtBMm9SQ0VsL2F2V2hOcGdEQk1qeGVDbWlzMS9GRnArclA1VzhvWENNN3Zx?=
 =?utf-8?B?SFErZUwyNGl1ZFFqTG9HVjZCb1o4UHdURHJsSkZvTkgzSnpidFo3TmdpZ3Ry?=
 =?utf-8?B?ZGluMStPRmhqQWoyTThZQTNHNis3OGJGYmNMSHRSUWJyb1hIUStxTTBvVXZk?=
 =?utf-8?B?ejhycURJOUNTNE9BcSt5MXhCazlkK0I4TytqVEJRQVIvTGsvL3dzOWNmalNx?=
 =?utf-8?B?UFRSL3BRZk0yY2t1UWpDQ05mV0FyWHpDNzNFK090ODhSajlmRENWVGcvRmxS?=
 =?utf-8?B?djBONnpVRGlvUXpWYUZVRTVoTXF3NVUrdmEyUUNQQnNYUGVqTEg5VzlCSURP?=
 =?utf-8?B?VGFETnZadlczQ1lwRkZXbWk0MUd5c3N3SGROb0w2SlhnMFlsOVBoMjlZeGF1?=
 =?utf-8?B?R3p3MHhnUzJ6YkJ2ZnV5Ym5WOStDVmVkMTBFd2twNzBWS2VJRFk4U3ZwVzBs?=
 =?utf-8?B?TkdwZnJBK1kyb1ZBZ1FEc3paZ2VXUExkU20zdlZKN2ZKS3p6OFc1VFFnRDU4?=
 =?utf-8?B?eWZFdTB5ditUL3I4VUNHV1ovdWFyMmFYdktIcUNTUzFxUklzWXdvWlVEYk5t?=
 =?utf-8?B?NEdlQXlnRkFlRCtRa3owTGFDN0ptMFJkNmxvSHJRWVhVOURpYzQyOTZuclNn?=
 =?utf-8?B?WUVud0hyOFRGb3NxYzhkRldac0w2SkN3OTVsaUNZOHhLZmxQWkdsNkduWk1l?=
 =?utf-8?B?Y0gzbnFJcVhkek4zUFhlaTJOOHloRllDbHE3aXZWZXdNNUVUWS9vSE10RFlI?=
 =?utf-8?B?eWxXR1pqaDZ5VDcwWlZPRGN3MDhVUjFZejgyK0VGWGdZOWp3UEROZWQ3TVM4?=
 =?utf-8?B?OUNpdEdsMFhYUENxNzlQNVJ2amFvMEsramM3U0IxTHB1eXA2UjNUVjUvOUk3?=
 =?utf-8?B?d1F0N2oxQlVJLzZtNEpYdUZSQmVRck9MR3NKQmNtcjM0dGFSWEN0a2lYelhx?=
 =?utf-8?B?STZ6dlRDUkRSR1ExODlwSE8rSis0N25XY2lVR0JzeVZWSHo2M1lnL2hKZ3NZ?=
 =?utf-8?B?V3AvZVppbmZENGV1TFNqZTlpdE9oNlhsK2RiSjNoYU1acFJEcktndHBIQ0Y2?=
 =?utf-8?Q?GVWQbxh7LUmCVC3yn59P0dpCm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b36ec79d-e662-47c9-5c69-08db41009e84
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2023 18:05:11.9756
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7MabWOxHb52pbCcZG6ZMgNKdvThoqHXibUXbr3wOLVSodqXi1i7QU7buHYTHnvPS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7515
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2023-04-19 13:01, Junio C Hamano wrote:
> Michael Strawbridge <michael.strawbridge@amd.com> writes:
> 
>>>> +Below is an example for a few common headers. Take notice of the
>>> "example of" not "for".
>>>
>>> This maybe clearer:
>>> "An example of a few common headers is shown below. Take notice ..."
>> ...
>>>> +test_expect_success $PREREQ "--validate hook supports header argument" '
>>>> +	write_script my-hooks/sendemail-validate <<-\EOF &&
>>>> +        if test "$#" -ge 2
>>>> +	then
>>> There appears to be an extra indentation of the "if" statement.
>> Good catch.  It was a matter of spaces and tabs combining that wasn't
>> easy to see.
> 
> I was reading the list of stalled topics in the periodical "What's
> cooking" report and noticed that this topic has been marked as
> "Expecting a hopefully minor and final reroll." for full three
> months after we saw this message.  Should we be waiting more?
> 
> Thanks.

Thanks Junio for the reminder--I was wondering the same thing not
so long ago.

We'll re-roll it and submit it for inclusion.
-- 
Regards,
Luben

