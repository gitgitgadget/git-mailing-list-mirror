Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBAC7C77B78
	for <git@archiver.kernel.org>; Tue,  2 May 2023 18:56:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbjEBS41 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 May 2023 14:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjEBS40 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2023 14:56:26 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2040.outbound.protection.outlook.com [40.107.237.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74E2EE78
        for <git@vger.kernel.org>; Tue,  2 May 2023 11:56:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fbrq1RVO5PxUdR/c0wnw4KzxxOxEQRx6Ztd7J3NaqG4cIAXobT26BNj6F+KLYPLAit3IpHEiNrZP3+wtGibseOZGIYzbLRAC0oZHoG3KNYCLG98jALowekbP0Bzfqh6EFUvJAF+k9/OpJCaQw7rUMrx8fBFZtZPmXKljnpfXDPqsF5gZ5LRtxqAEJcfmEs3sb+yJea/VDYVMMCWAOQ7PR03X7xsJuXqZbNHrcxbfL7QtvZxyl7nsJzLqrBXQAbBEzaZEvsOodP+Idt8n/6dU+nvHhgkPWdYU+e11XxBHHnO8Y/12oyVWKtrGh4M4EIt6/XGWzVfUc4gJGGgdf2iivg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gEu5J6HqnYOlO24hMJSJ4WzxnYZsVBsW4ZL4TKBp4ag=;
 b=hMHknWqE+dEUFkrZ89QS8tayvSnDCeJkjPJpcYKRYLD2nraLtK5Yc65uGlvu6egUsuHQcLJdFgAXcSfNudRLF1LECXm3RH11cJ1qc8oIQqJjCvHF/mK/MYQhVAmxdYe2tTFvYl+BQf7kmZcRm5j78WWybFd+VnCIezdI4XVazsAEoIdvMM6REKYYKBe1AUOwaKW0fLte6A52+xdNWSjVgp74vPEekvEIUHYQXMEQs5CztOlDSRDwbmcHgqi7lngD2R+uRE4FcRT6by+MQy7efV7PPS5Xtt3IpVMZl8jrF+2kGD2+0P75P3TBcL6dPIWEOmFhHS7CKYKnVJ6kXd62FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gEu5J6HqnYOlO24hMJSJ4WzxnYZsVBsW4ZL4TKBp4ag=;
 b=YmsQdOCTSkz70efCJDReGv3Hz8kly5is0UQxTIyDbrvhQSLkgnOrOOK3bxVrVxLV7K1uZhoV1jrRpsHKG0atXJKrnNmmH0WNSGqPLaeWGouvcT6jTSlfnxGskFLmyHVmJXffSmSHfCxqADsS8erPHmW2Z8QhbtF89QG6nRFRsmc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4356.namprd12.prod.outlook.com (2603:10b6:5:2aa::8) by
 DS0PR12MB8815.namprd12.prod.outlook.com (2603:10b6:8:14f::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.31; Tue, 2 May 2023 18:56:20 +0000
Received: from DM6PR12MB4356.namprd12.prod.outlook.com
 ([fe80::772d:1598:5b3e:e14]) by DM6PR12MB4356.namprd12.prod.outlook.com
 ([fe80::772d:1598:5b3e:e14%7]) with mapi id 15.20.6340.031; Tue, 2 May 2023
 18:56:20 +0000
Message-ID: <b82443ad-36e5-291d-3335-2f69fed7fa74@amd.com>
Date:   Tue, 2 May 2023 14:56:18 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: Fwd: [PATCH v10 0/2] Expose header information to
 git-send-email's sendemail-validate hook
To:     Luben Tuikov <luben.tuikov@amd.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <xmqq354f4sts.fsf@gitster.g>
 <41F7913A-E91B-4442-9531-5EE8EC2CAA9E@yahoo.com>
 <fae69ed7-5b5b-0920-73f2-a0e72795c032@amd.com>
Content-Language: en-US
From:   Michael Strawbridge <michael.strawbridge@amd.com>
In-Reply-To: <fae69ed7-5b5b-0920-73f2-a0e72795c032@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0056.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::17) To DM6PR12MB4356.namprd12.prod.outlook.com
 (2603:10b6:5:2aa::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4356:EE_|DS0PR12MB8815:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b12d30c-5c9e-4aca-de94-08db4b3eeae4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WGibGhz13N725KAgycxOGyEKi9WmwCzXs0lzZr0enZRLMuYgaw0L7Lszdgp3bqFYk7gvJkAerWJDMvug1Mp8JeGGO6DAYlrK6pnMj9pBAB2lZeQtn/Ap+Wn4/o5vs1TtrYnZA1OpmWWMW6f9dn8q9HL/+ju4C3DLwKJBaVnaj1x3LgObE6TOJzqJuyhnjJT07tselVjpg+tdg7tlZyFibgEQcZ2ouT0tDF1t772LlN9Xp9o3iY86wy4W+zGGd0GiryTSByuS3r1ovSLB3luPJvY8YybI9yCnF5O6cxYdpSVohkHwPYlWjLNNM3ixPchS+oBIsKG9A/qoRKhNOlwne8QhI0g6+8HgSf9Dlmpi9BJj6TTfTGipjPDB2mxfOkZBxq/c7BmyAH8Ox7aaETA3woFD6KEUgB9rJ5x4ts8qpSYCcJKViIVHSUMm+a7tr1tyiG7jxPTzUM/jmXyNO4PQcUJ9wTuR1Dy0++1a1wlsZxnG2z9ICC1PrVUlWWJaF955C9lOzMTyNCnYcQwBQKAqxd+8vKR5H4I7BITxxAWR8lukcI8PB4UAMNCLvGCDJHzLF6MjvDNhILjbqrL995blRUqU9u0mueC3BtTegCahC+O1O4QpTkx47LGKjQJPgZjezKeCzw51PMqWBLg/H9Ov0g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(366004)(136003)(346002)(451199021)(6486002)(54906003)(31686004)(110136005)(6506007)(6512007)(41300700001)(186003)(15650500001)(26005)(478600001)(2906002)(5660300002)(53546011)(38100700002)(4326008)(2616005)(83380400001)(66946007)(66574015)(66556008)(36756003)(66476007)(31696002)(44832011)(86362001)(316002)(8676002)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WjN0cWQyS0dZazRXYWN5SWtoVnBxT0Z1REFMUkJSK3RTNlNRQ2NFSlloQVlV?=
 =?utf-8?B?MTRGOGpIU3l0c3NUalUzNDZ2djVnb1BER1hSME5pa290b0lHVGtFbEVIK3hs?=
 =?utf-8?B?QlpFdDZzNmdRSm53ZkFKSWkxaXZMbVJ6T3FVVGhDN1l5K2NmSTRjeXpaNjAw?=
 =?utf-8?B?b1FnYUNkbDJ2emFkeHZ4VmFGWnN2TzcwdUl1WUY5ckNGdkNxa0ZaWEJLeDE1?=
 =?utf-8?B?VVhyQkxQbCsrajQ5YzBpZXh4ZUFPMW44UjczR1hyOXJwbGxyRGV2d1N6clRu?=
 =?utf-8?B?M25SeFdlWmNvQWNHMkVyN01MTDJMY1FEeHhCbVdhNW1SVXkyKytUTWZ0REJ1?=
 =?utf-8?B?d1RtaGYweCszUHdueC94aHp1RC9aUHVXL2w4N1k3UjlqL1MxTWFicnZ5eWZh?=
 =?utf-8?B?Mi8zckxOUGtFek4xY0ZTdnlwYTRoU3BoR090Y1JSUGlMTWpVVUpoZnJkNkZJ?=
 =?utf-8?B?VFJORm1GcFpWSVJxTlpGQy85Z3RpZkc2ZDE1RkthS202TFJWS2s3MlQwTTc1?=
 =?utf-8?B?djMrNzBIRkdDcXc3amJkMnlSc1VSR1RLVFQ5eE0wZ3VNcWwwb2FmSXRsWklJ?=
 =?utf-8?B?L2xEU0hrcTVpNnZYY3I4dmNSWkE5RTNGWmZwMitkY1FpaU1vKzlsT2V4WTJ6?=
 =?utf-8?B?V1BVYmtGYTZDRTVuSVZZeUZadjVRdzBFUnovR1V4dndoYzVOaHJrbXRCUk9I?=
 =?utf-8?B?WkVaczdKbGlKZ21zR0toTVRoMnYvYng1NURyRmNFcVlISm1jRW81SWlCRlVC?=
 =?utf-8?B?VDVSTzg5NVFNZHFjbTZIL2c5M0dxNjZWMjJzSzJ4L0JpU3BnT0RPcWhOZjMr?=
 =?utf-8?B?RXdKVmR2b0ZROWRrMlR6QzZvd3lRZjBSSjNHZzM4S09aMUZUeW9uQUwxMy8z?=
 =?utf-8?B?aG5ieWs5bWk3U004dzdtNklLRFMrWTZYS2JlTHVnakkvVHNBYk5JbVA5M3NN?=
 =?utf-8?B?dUxhNHFoeWpWQ2xoYmMzR2JTWG5HZERlV0YzanB4MUw3RGxsTENDUk9MOWdR?=
 =?utf-8?B?VlNBZ3F6bTFCSlV5T1ZpM2MxWnBhcmFTdTU0MkVJL1g0QmZKZDVybld6QTJs?=
 =?utf-8?B?WUhwNDh6TGZ1Q0JMeVF1aWJqYys2UW94elJwYWJXTThSem1taEhSaXBWVkJo?=
 =?utf-8?B?V1AwS0czaEk4N1BWdVRqdE1mUlp6Mld4VmpQNGFZdGN6ZHFGTnliNmMzWWJU?=
 =?utf-8?B?eUlmN1laVnpBTERpRkwrbjVIbG81czhGWjMyKytycHlTd1dqdW83NjBxTzBp?=
 =?utf-8?B?enpoZkJuMFBhY21lTG5VZTJWOTBnQzFuc3lrVmdYRGNGQTRsSmdKZm9oQi9i?=
 =?utf-8?B?SlBiRE5xNlpOS1F1WnhFME1GdHNncCtKZnRjYmtOclFMcUhzaHhHT0VrTTkr?=
 =?utf-8?B?emFUWmdtcVVFY1d3WHpBb0J4TEVNZ0tMREdKWDJKZVBBOW9ncVJpUElBbzFi?=
 =?utf-8?B?anZCL05zRUtQVGdKblpoM1RGZlFodlJTUThWcmtxSXBVMmdCdU9od2p3QnI5?=
 =?utf-8?B?MTJHNEJlOWNTWjBWZmVHNUN4ZVNucWY2ek8zUU1qaWZVcDFKYWE3eG54b3dB?=
 =?utf-8?B?Q3VteXpDQ0V6ZVd1bkFhYW5YOTJzdCtwNEdueUptRkx2SEtteXhGN2dSTWh6?=
 =?utf-8?B?bGRrdnFSM1ZrWXFhNHVtUFpVRXFNaXh4QmkrSWNyS3N3aHRHTk9XUDRQbGVT?=
 =?utf-8?B?L3FhbHdjSnQ3S2ZUK3VLZHhlZ0Y0dm1GV3lwcUJOTGNsRGxWdWgraVZ2WEVL?=
 =?utf-8?B?TEtUUDFsZGdLdnArTEk0NjFEdlZtdVU0WThIdjlkT3JSdVlLVUZKVTl1WDJ2?=
 =?utf-8?B?ZDNnaE84cDB6MXA3VzMxVXNKRitNSFV3ejZaQ2tsNFBmZGpTc0tvWmxVVkhz?=
 =?utf-8?B?SXJrTnIxNmdCRklSNVIyUngvUGJvQktuT1IrVi9DamFGOTh4cXZsOTkvUE1Y?=
 =?utf-8?B?dVdRYnVyTmc0NzRIUCtXVldhV2QyL25JdFpaamsxTHp2ZENucTZkV0gwcG9H?=
 =?utf-8?B?eTFVbDAydis5Q3YrR1N0VkM3SUdXNjVuYVdPcDdGbUVMSkErM2dPU1ozVlBG?=
 =?utf-8?B?OFZodk84R2p5ekhTblJ4aVJUTk1IdUNIU2lpNnBsZEdEdC92ZnNJWVVYbHZT?=
 =?utf-8?Q?DNLxr4XP3LQ5HOsi4L6OFz9hK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b12d30c-5c9e-4aca-de94-08db4b3eeae4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2023 18:56:20.5575
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fPGApCssNSbZb4qvzk2xroRBVyGw46Cp830aeQwhYhrvZmjFcsdO6tT6naltr3oZFLyJKqLXHKOqCvoCnNjkQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8815
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks.  I will do that in the future.

On 2023-05-01 21:05, Luben Tuikov wrote:
> On 2023-05-01 21:01, Luben Tuikov wrote:
>> Begin forwarded message:
>>
>>> *From:* Junio C Hamano <gitster@pobox.com>
>>> *Date:* May 1, 2023 at 17:58:41 EDT
>>> *To:* Michael Strawbridge <michael.strawbridge@amd.com>
>>> *Cc:* git@vger.kernel.org, Luben Tuikov <ltuikov@yahoo.com>, Ævar Arnfjörð Bjarmason <avarab@gmail.com>
>>> *Subject:* *Re: [PATCH v10 0/2] Expose header information to git-send-email's sendemail-validate hook*
>>>
>>> ﻿Michael Strawbridge <michael.strawbridge@amd.com> writes:
>>>
>>>> My appologies for taking a while to get back to this.  Here is a reroll
>>>> with the latest suggestions from Luben.
>>>>
>>>> Michael Strawbridge (2):
>>>>  send-email: refactor header generation functions
>>>>  send-email: expose header information to git-send-email's
>>>>    sendemail-validate hook
>>> This round did not see any further comments.  Is everybody happy to
>>> see us declare victory on this front and merge it down to 'next'?
>>>
>>> The topic does not make itself a reply to previous iterations, and
>>> the cover letter does not CC: anybody who gave reviews to earlier
>>> rounds, so it is a bit hard to answer the above question myself,
>>> unfortunately.  I manually picked off a few names after finding v9
>>> and v8 from the list archive and added them to Cc: of this message.
>>>
>>> Thanks.
> Sounds good to me.
