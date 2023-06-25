Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4B8EEB64DC
	for <git@archiver.kernel.org>; Sun, 25 Jun 2023 13:41:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbjFYNlL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 25 Jun 2023 09:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjFYNlJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Jun 2023 09:41:09 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3456E42
        for <git@vger.kernel.org>; Sun, 25 Jun 2023 06:41:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ct26Jr0nuj7WFuWMwe0nmPlV0m9nZWV9cDgKi1waGK2nN3ygHCCMHkTZwCRs07E0/PfWuv8TMhop620NV6eD2GJSP5a9tDDKJWjm2O9MsO5fAilTeY6J05IABZ0RZKRwhx2kJrDFEFvsiTXkDfha937QOzlCRIxNp1V6nSxfwZrM5hPxYjuYKXIOmCseXxfxA3tp7mmP9VlWk0cQoNzR19iJUq73HC5lkd6oERPG/V8KLEUzdVOEr54vk3hjkS/clWGDewXKWseVkLVe2i1PCn1MuDqzmUtv5xTpbpcNfaKXWpAAaSZiVd+l7/tHDRFslgb6AD9JIsQIx/6wxeWYTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rxrFuv1OI/APSqtGNnjxReJ92MZLM0M6I+HJwB+sNVI=;
 b=KvhBBSO/ClitPdOzQIMx16/FI3Pp1G2je6eY6Vxk1Amlr0TLuu2vDjYPneYHi8r3uwo9dJY0gGwjj3hn77/tQWOvsPjoDMfdRGpLLc4fYb0neWDbVxmpFOj5qImywZZOho7BsWNFyr/mvEkl93iu15mPPwXCVPNihLPo0S2NY/TCNsb+0+6qfZUdpA4nfehZp9GD7y7gkoo1niYHlTkWW6cYGTv8rLntw+kt5YahkcNlYIzsDLj6Pfs6xCx/kYj0i90CY7ebIwD3oktiQjSqYi6MBVLvgyGbY6IF0DoSbaMxCG3IfB4fUkR+hM4fjE1WhbmKrDsciOCWLi7LgYTLbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cedaron.com; dmarc=pass action=none header.from=cedaron.com;
 dkim=pass header.d=cedaron.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cedaron.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rxrFuv1OI/APSqtGNnjxReJ92MZLM0M6I+HJwB+sNVI=;
 b=Bap90utXd79siLCZ+bB7U/xOA907DkhxSKVNx1Rusf++yiRt2u/qERi/76xckghZH7v2EK+LlO9AJM9FkyW5kBejvZF2IyheZjbAz9GVpO4g5m0boITkLRxU1gZtRH6KZxfoF96IAR5mwMWzFkp4OdnbgPrzPrzcInFwgO1v+v3uJWLumZkGtFzusnSvvhko4s72MENR47s4uR7BD4Sg+YBGeWQjYHJ3YwqJRSTJSRUajhmFWlTP1UnZnyZe8oFzkosTVN+Dnp1Ix812ec+YkQ+OWMq109MnsKQ9FnG8SUdOZvodZk3byloMCoyjO5QZfeHPifhBCymIi7dn+M4a9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cedaron.com;
Received: from BYAPR20MB2758.namprd20.prod.outlook.com (2603:10b6:a03:fb::15)
 by PH8PR20MB5413.namprd20.prod.outlook.com (2603:10b6:510:22b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Sun, 25 Jun
 2023 13:41:01 +0000
Received: from BYAPR20MB2758.namprd20.prod.outlook.com
 ([fe80::90c:ffc6:cad4:993]) by BYAPR20MB2758.namprd20.prod.outlook.com
 ([fe80::90c:ffc6:cad4:993%7]) with mapi id 15.20.6521.024; Sun, 25 Jun 2023
 13:41:00 +0000
Message-ID: <ac9b1ccb-82ba-4046-dd2a-e10b38a528a3@cedaron.com>
Date:   Sun, 25 Jun 2023 06:40:57 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] ll-merge: killing the external merge driver aborts the
 merge
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
References: <6e1b9ce4-e86d-fe30-e5de-27a3be57eefd@cedaron.com>
 <xmqqttuze2fh.fsf@gitster.g> <xmqq4jmzc91e.fsf_-_@gitster.g>
 <CABPp-BG-KDu0fAC=bydz9A56xguSmgwO6SFDdxZ8h=90qR1PUA@mail.gmail.com>
 <xmqqv8feb0vo.fsf@gitster.g> <xmqqjzvt92nw.fsf@gitster.g>
From:   Joshua Hudson <jhudson@cedaron.com>
In-Reply-To: <xmqqjzvt92nw.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR03CA0012.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::25) To BYAPR20MB2758.namprd20.prod.outlook.com
 (2603:10b6:a03:fb::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR20MB2758:EE_|PH8PR20MB5413:EE_
X-MS-Office365-Filtering-Correlation-Id: d2b53603-afc0-430e-398a-08db7581cfcb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: spZIMmOaOYuyPFRN+P2XDCjA574FWkTtUAMVqW55UHegb0hE/mliDd5RCoaINpqhPXqTkkJQvkPGs5f41H+1Y05/32mPUgfx5cIvUqtw6ErHvykzCWutAyGJxDd0B4AqeWGIDr2QIL+7tfr40wKDG8ZSv68+JC2WgAgvLbO23qzL5o7XIfocHEKny8PkDyMhig8l3e5GKLiLf/lHGKXMnH2/u44MS6HdPOY1Ce6ZZgXiI9YitM2pnrvQYQk8rJquirV+vpSrbLtYv5ooRTvr5ntqsp/Dkf+3Rh5pma5lKjT3yuf3HO55KDcnBztmZkcGpXPV5cDjEE3ngBw8NGWp7g43cWRs1Gz0CNGGtiT3OQvYep8+3T2xAl/pt8pO6GChaB1HUpm4gfzVZuzP2Dc6pSFT0DX1KqZr5iACpriuZYiqvW9XWJBFH/s4r76Marx7RVHhO7/oOtatsuOEVoSufHVvIXNr7C46GBJLlUsfjLVLwquUirneHhNeAo0xX4nAj4f1oed+VUISGrNbMq/U/2K2eM+8nep+aiT1wdLbes1pmyMiwRPTdDD5E+LBj/ZGz5gyku6/IKYLEfgTWdfpMPXgoKwFgYzAOVXYw/uW3DG3+X7mrmkQuIkPJTYBLb6wuPikwPV9kwK9sUejqPn6Yg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR20MB2758.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39830400003)(396003)(346002)(136003)(376002)(366004)(451199021)(31686004)(5660300002)(4326008)(66946007)(66556008)(66476007)(478600001)(36756003)(316002)(8676002)(8936002)(2906002)(966005)(31696002)(86362001)(41300700001)(6486002)(186003)(53546011)(6512007)(6506007)(26005)(38100700002)(6666004)(83380400001)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ODl5R0lRTkRUVGlDZ1p5Ry9KSC9PcVNaRDhzOFMycHNnT0Y5NjZQMTlXNkgz?=
 =?utf-8?B?K1RZNlU1Ry9HVmxUZDNoNE9nRXZ5Z2dKdXF3SjhTMU1lN0cwNDlERlRJMmJz?=
 =?utf-8?B?UE1NYVRTK2Z2Q0tTeHZYdWliK01UaTVVUnNIU1BCaWxxd24zYVQwNVJFQWVj?=
 =?utf-8?B?QzB2aWZhNXI0UVRBS2NXWThjRFJxek5MY0ViSHNWcXlza0xFNk51T3RWL0JX?=
 =?utf-8?B?WVZmdzVtaGFDbTNBZXFqQkJ5Y0wrQWhNSkkrR21BNFFyOXdTTXRqUHVqU3VN?=
 =?utf-8?B?Zmx2REhteVc4aVVKUlNucC8way9EbW84UkpFcUMyR05jUW94dXZxV2tNS0w0?=
 =?utf-8?B?V2pjODVydFVZaFk1aHR0ZHdXNXFvc0JZQkdyTHFlSDl2Z1ZVSW9SM0lGa2oz?=
 =?utf-8?B?eWJuaGFkaGtYMGZKK3E5c1cxaGd2OWJkd1hwM2lhYUJCMkZlYTZOQmRLTUtJ?=
 =?utf-8?B?M1RYOFVRcCswb0FTckd5UEJCR2h3WGVWcG1OQU83cDJ4ZTBLY25KRDdWMzM2?=
 =?utf-8?B?M29xRUNJSTFCTzNHV0E4eUNQVlhtYlN6L1pkSTU5emhqeVMyUkVSZnZVQ1Fa?=
 =?utf-8?B?Q21LdWl6UlNrUGg0LytOclc5ZTJlOUV2NVhSeWxPdGk1NDRxN25jUWUxTkxW?=
 =?utf-8?B?ZTJ4VHpXd3A2SGF0eGpqRVJXWTVMOEdWWHdueGN3T01HNGhES2E4Yklsa3lt?=
 =?utf-8?B?Rk9HNzlaNzlvVzA5TUM0aWRqSFhBVnRPQ1dqMEdLVDZEamZRN1VuR0RObnE0?=
 =?utf-8?B?czNFT3NzZ29mOThCbXNtanhkVXFJL3JheStDVWtNZmZ1enB0VUw1T1RXT3g4?=
 =?utf-8?B?cUphWFJmSTRuc0lBNkJxL0FrUDhSRjlBWmU2OGFHSjgvOGxZYjRBcGZaUlJp?=
 =?utf-8?B?WlBMQW5TVTlPRzF1Y2d1NlQ2aUxHSjVSZ094c0RDamcrb0ZEbTNDdDVXWFpC?=
 =?utf-8?B?ODRZY0pqelpDVzl5T0s2RG5zVGIxNUlEdWJGcFF5YzAvN2RkRmZvN1FuOGhh?=
 =?utf-8?B?ZHduV1IrMnFRN3d1WlpXTm95OHVJOG1tNHFqWE4wajBXRDI5VG8yR0xFVHk1?=
 =?utf-8?B?YWg1L1RtUnNvbGtsQnRwTDN4cDZsOUxtM1Z3VEdFalYyQkkyNkFKL3phM1pm?=
 =?utf-8?B?aWhyMmdLblYrSGJrVTVRcjZPZU9JOXBjZUNvSE8xZGVjbTJOMXVlQ01qZGt2?=
 =?utf-8?B?V1d1K1AvZ3ZCclpKRmZkYStKdnJMMWw3MWdPTWNzeHo2TnJub2NMcEtaY0JU?=
 =?utf-8?B?OHp0Mk93SjFSMms0Ui84di9rRFpRWkZvTWRrUHlUT0tOVDF4TkRmS3B6dito?=
 =?utf-8?B?K2R3NkpWMXBXSE1DL2hsb2ZES2Y5WWFlTjlrUU1Kb1VMazJVQ3JjTEExbU0r?=
 =?utf-8?B?YUZ2NGlWUWE1enBKMDBXdkpkdGVoWW5Ka3FwZjBJSW5zM2c4a0wxVHE2VDlT?=
 =?utf-8?B?SEl3VVByc0tuT0F6KzVmWEpESlBwNTB5RWRwNVNEdUUxR3ZCT2lXaUUralJW?=
 =?utf-8?B?MWNzMGNYTHRvNFRJUGFhUCtuYVpwSldXWC9hSG5xd00xMnUvejBLcUF1em95?=
 =?utf-8?B?WVhaZDArb1BQME1senNQTVV5VEY0NHk2MlFpQU41cDVBTktFRm5vYlBBMU1n?=
 =?utf-8?B?akpzR1BPSG1xak52M0hRTC9HcHI2ZFBwQXB1QTF6QVNWVUhGWGZNMzZML0ll?=
 =?utf-8?B?NVYvVnFvWEZGai81TDJiM0Q3RSsveHZhYWRkMkNyQ0dEL2cwRDVCcVdkYmFL?=
 =?utf-8?B?VTB6TDBtZTJzSXhKY25ZUi9ONnVHajhBUWlQSmxQYkFKUzZjNVV5VlVpZ3Fl?=
 =?utf-8?B?NTlUbFlFZ3V5U3FvZ1FsRWhxUXZxUjFvSmdySU5ZVTRJNkpNRmRqNDR6bHVx?=
 =?utf-8?B?elQ0V0haNUFWQzFyYUM5SHBxd05iWCtSNktEY3dQZFFlWStOcTg1RDZ1R0Iy?=
 =?utf-8?B?WlZaRTZYLzd3ZEtPNHZ3Z3I2TTgyZHBoQnhHSmxEbHU5S1hERmJkS2pSMmxQ?=
 =?utf-8?B?VFdYdlcwOHYrT1l1TmFJUmZrUU16eTJMOUFjdGtjNXFBYWZFTDFUUUhxQktR?=
 =?utf-8?B?KzhiRkhXcXZObFY5MHV4VUFzR01DVWVUZG81UnJ0ajVDdnRkQXVrUy9jV1Ar?=
 =?utf-8?Q?oIUicmh3Vxedi+ePGtHxPjL1H?=
X-OriginatorOrg: cedaron.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2b53603-afc0-430e-398a-08db7581cfcb
X-MS-Exchange-CrossTenant-AuthSource: BYAPR20MB2758.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2023 13:41:00.2498
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a1e0d90e-c09b-4bb6-9534-4bb03188f5a0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kzAKikml/O1s5MZXyPbGIv7qUI2J/c8SdwLxWDC7Y2uioAwfMLyeHaRD1HbGmVnW1vjORC2PoPC2ENtFGbfx1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR20MB5413
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/23/2023 4:31 PM, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Elijah Newren <newren@gmail.com> writes:
>>
>>> Reviewed-by: Elijah Newren <newren@gmail.com>
>>
>> Thanks for a quick review.
> Unfortunately Windows does not seem to correctly detect the aborting
> merge driver.  Does run_command() there report process death due to
> signals differently, I wonder?
>
> https://github.com/git/git/actions/runs/5360400800/jobs/9725341775#step:6:285
>
> shows that on Windows, aborted external merge driver is not noticed
> and we happily take the auto-merged result, ouch.
>
> I am tempted to protect this step of the test with a prerequisite to
> skip it on Windows for now.  Anybody with better idea?
>
> Thanks.

I would suggest putting in the correct test harness on Windows. abort() 
doesn't work very well.

(Sample code only--read description below)

#ifdef WIN32
     TerminateProcess(GetCurrentProcess(), 131); /* something that looks 
like it passes the test */
     TerminateProcess(GetCurrentProcess(), 0x80070485); /* actual exit 
code for process that cannot start because its missing a shared library */
#else
     abort();
#endif

I only want to fight so hard with the Unix to Windows translation layer 
you use. Strictly speaking, the second TerminateProcess() line is what 
should be in the test harness, but if it doesn't work go with the first 
one. Then I at least have something to work with.

I'm not going to lie to you. We are doing development on Windows, and 
the merge driver is written using a different portability layer. I am 
prepared to build a native shim to make it work if I have to. I am not 
in a position where I can build git and test any development code; 
getting the fix to us will be a long journey.

