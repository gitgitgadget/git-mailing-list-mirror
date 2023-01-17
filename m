Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2018C63797
	for <git@archiver.kernel.org>; Tue, 17 Jan 2023 04:58:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235376AbjAQE57 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Jan 2023 23:57:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235597AbjAQE5Y (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jan 2023 23:57:24 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2081.outbound.protection.outlook.com [40.107.223.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57335298FB
        for <git@vger.kernel.org>; Mon, 16 Jan 2023 20:57:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YM2kLcCtdAWOK7mLF1gMiRAClBUiKCtpGzxeUxKOOhK+6HqQ1nS01MkYIo8xQ1/g7uY4REQnYSJyb03Hy66RK8pEsm3i8JOc9P5NOaAqLSpvPMEY9Qj3N6YR1KV3rrC0HbBtUgMk4mor5iMSME8lB2Jc5o4UK/PN+jhtMQexIXYDumlLep+xcAaen659aypLiQsVlpOsDc4OleVb3JEZlieFUazS6vD9nxG8AspvtOActNQrXnM2juMqQR1fIX8mj6rVir9eXuPckQdaZSTn4J4oQIFwe9KJsyEq9SYAXnRmQKcA4UGS93Z3+VjD0tVZroXlcFKwYv87wHCfnVPN3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rs8a9u2szRP3YUq94gyK7pxJkXLmibggRceWnkqogz4=;
 b=QIFPx+0umunMPN1Tzt6ms2rITSacOV1Tbku/XST5z/iAY/dzCl5AP3WCLGO6TScIrDV04fC/DMkzUEIfRvXP7G32qgovJhyG7inIcBMKjwta0OfQ51zCg6T+g07ycx5Bgh622pHI57XPJoVB+mKRemqQbBl+qm5TkO+g5ZvRLq6jWVzN2o4D/H6/n9QJVUHsMZbbUlkFgqaJB6KmQ7ZRXiTydLWc8x255/wELBcsRT+bc7XDGtIF67PRhrX8W7/TuQ2ViMoOZaLHoZnQs9HBbUWyEamilJH22eO89BixGZ/7ZbaWWrz8usWMKnys+M4rUYybxCFXwJGuP6iKmOL0ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rs8a9u2szRP3YUq94gyK7pxJkXLmibggRceWnkqogz4=;
 b=0xyEmHRL96QLYlXi/Y9eW/dnsB7JjSs7ka2MuInMm/f5tu8Ric7f+sxNfljziJ5pqPu8Im6T47c4t7CG5XcF6hqTNuUsK19E1AYOnyhQIzFFWZ4kqr5FTzY/Sf4shOdMhCFnuDpRntHdDa3KGZAkD7Bpi3EMbqMvxIqIog4bs0s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 IA1PR12MB7760.namprd12.prod.outlook.com (2603:10b6:208:422::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Tue, 17 Jan
 2023 04:57:02 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::2fd1:bdaf:af05:e178]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::2fd1:bdaf:af05:e178%3]) with mapi id 15.20.5986.023; Tue, 17 Jan 2023
 04:57:02 +0000
Message-ID: <ba987147-6b13-e1f8-e6b6-4efddcce6a37@amd.com>
Date:   Mon, 16 Jan 2023 23:56:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Content-Language: en-CA
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "Strawbridge, Michael" <Michael.Strawbridge@amd.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <20230110211452.2568535-1-michael.strawbridge@amd.com>
 <20230110211452.2568535-3-michael.strawbridge@amd.com>
 <xmqqedrxm7bn.fsf@gitster.g> <xmqqa62lm76t.fsf@gitster.g>
 <xmqqfsccii86.fsf@gitster.g> <f31f1480-d611-f4b4-0e7b-589574943eef@amd.com>
 <xmqqmt6hbx6y.fsf@gitster.g>
From:   Luben Tuikov <luben.tuikov@amd.com>
Subject: Re: [PATCH v5 2/2] send-email: expose header information to
 git-send-email's sendemail-validate hook
In-Reply-To: <xmqqmt6hbx6y.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1PR01CA0133.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::12) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3370:EE_|IA1PR12MB7760:EE_
X-MS-Office365-Filtering-Correlation-Id: c59dd0db-c332-41f1-07d2-08daf8474571
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9X2Q9sEz4FXZl9P4GRC03g1VKcY0oS84FIIcxELX+HkPC7IjpwG/nObQOvEzv0tI4kbC9yYs/n4+5bPkKxSqVbatEvR+CPeql1lSHGk3c8eLJ5gWsToogYV+Y7GbE+Plyg+4zVC2VJ8z1VxsZIgSMjaWDSsBq80m/U2A9LslY72/dI3XapjLJqR4xOjVpd7BOzbIo/6+WUi2jFk2+w8/lolw0XntsvGzxl/oPhK1QgBKGn8FT5YDAvxb9oL54vdU69+JdtUtkjtqxA2tBsMiaM+x21oK3IWIqj36y5lq5wNm5JgGE56RVTEEcPaW/iE2DWIuDZVivjucelKmOFViZCKIJ/YcxfDN6/KwR+D2brjUlI3t/CIanajuuZAU6sozAsj16frdBVOoFlEPbkfzNkswKhAk5CkAzAacNjbczFShIRK92WJpeyx+xElJ21vKOV9zy/pu8I3CBtLE0jHwacuuP81ue1IWYXbX1hbKkBurqVzStmItCM/Z6XjjZ3IFfHekD9YXAdYbpcKmdVnALYXnFvncNA3QJycLBtaDSuV173fPpkWKPGqbAYx1HXZLD6YHjF5OKAhk47xm+TgRBjbcR9uSGy2gE6ONg77kfpNhWp9X3TPsfMwya6zCtP/Tjk9Kpz2cHE9RLkwnnLRhuGEFlLrmtBSKSDSb2WHMsBbL/Z20EZnI6HdmXimkVS2U45X0NYJLhE54JTRFlTGcgeEyAWfutfiYXK95Su7rtac=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(39860400002)(396003)(376002)(366004)(451199015)(83380400001)(5660300002)(38100700002)(6916009)(86362001)(2906002)(4326008)(8936002)(66556008)(8676002)(66946007)(15650500001)(44832011)(66476007)(31696002)(478600001)(6506007)(26005)(186003)(53546011)(2616005)(6512007)(54906003)(6666004)(6486002)(316002)(41300700001)(31686004)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZTluOGpjUXZ5T2gyc3hxd0l2dDFSMkEzMG1EWWNvTXFxZE14NHZNVm5wZDAx?=
 =?utf-8?B?OTJ5QTliMTlDbDF1QkpMVjU4b3FNd0l1WGdSYUhQQWxQWmdUL05UV25EV1Bu?=
 =?utf-8?B?L3Y1ZGVEZnpVcmZ2WnlaWHZrYXkrUHlvSktHYy9DY21BclU1Q1lQTmYzbisz?=
 =?utf-8?B?Q2hnVENvZ0c0MTliQ3dDQmQwVURuVC9jM2FNUDAxWHdxWkRLN1VHM0MzV2x6?=
 =?utf-8?B?OVVMRU5BNmVaTTFJWVd2M2s2RVhIVEF0bEN5eTg0TGtvSFZQdGlJN2RvdE8y?=
 =?utf-8?B?Qy94dnkxL1lGNDVzQXl5QXBnb3o3dTNoSmhUNmcvWnJwUXZFNXZXWTZQVTZJ?=
 =?utf-8?B?SERiY0JUa1djaTFjc3pWVlRHODdCLzdSa1o3WUFXV2hHL2RnVVowK08wWGZl?=
 =?utf-8?B?RUdRenc4VE90ZHY0Q0ZUZUcrZXM0ZUJUbTNhM0ZjZk0zUU92NDBMU0pnTm9K?=
 =?utf-8?B?d2Q4ZzVZSlNPZ0pIeXQ3R0Y0eWhMUjJSN2Rob0R1LzNENG5FVitQZ2lKVURE?=
 =?utf-8?B?ZWE0OEI3VERMVnFSVENqeXVpQlM4cEtuTzVuSFE2Z3RCaUhwQnFsaEQ5TjBZ?=
 =?utf-8?B?VGxCWHBVRXp2a3RCWDFiaWdmWnY1WlE0UWZ1YUo3Ym9pT0NxOUpJRnlYQnFl?=
 =?utf-8?B?UXF2TS84T2FsdnlHWWlRWVI4dkFuTkZMejJQcU52dFdacGxEb0ZsQlhLWE54?=
 =?utf-8?B?TlN1SmJ0YzR6WElDZitQaUE3K1J6aG1VNitwT2tPNm5uK25HMU5mTFVCcVN5?=
 =?utf-8?B?bnZsWEsvWDNpazJGMmpoUklCVm43MFhMZ0o3dVNqZTV1YWQyNy9rMExieTB3?=
 =?utf-8?B?Z1JNV2NNRGJaTzJ0TnFHZWlUd0FFOUF3Y1ZNTWF4YUxGeW1DV0g1RFY0OEhM?=
 =?utf-8?B?TVdlNk10MUFzTU9pUkk4b3ZnQUpWSFhuV1pXV2gvZ2FUWFMvUmMxbDh0K1Uy?=
 =?utf-8?B?RDFEVXZQdy9YclYycGZGSSttQjBkKzAwV05ZckY4Y1JBVE9nbUU3L3VHWEZH?=
 =?utf-8?B?ck40bEhBNGd2a0RGeS9BYXBBZnlKTk1DdWtGQ0Z3dmNMYWErdSsyVWhVbUc0?=
 =?utf-8?B?aHRmMTdUTzA1Zi9JQitmS3BVbzJzUVZtR3cwL3M5K2xxN2JXRFJXME5ENVFm?=
 =?utf-8?B?c2xmc0MvMmxJK3ViL2JPYmIvanpKMGtJRy9YOUhjZnhOZTl4T1FJSXloTWFU?=
 =?utf-8?B?UGNaWDJGcC8wVGltWW0vN25rTk1RMjQwM0Y3N0k1bkNTMHBnaFFhYnYyKy91?=
 =?utf-8?B?cnp6TWtIU3A4MkNwdGpZMFAxYTdpdkN4ZnFmWFVvOG1LeWRqaW4yY1VDcWt0?=
 =?utf-8?B?TkJFNWFrdWVvN1ViS054T01nTm1Ia1NtdmMwOFBvM0trbzhZQnRlRXFNczd2?=
 =?utf-8?B?cmhhdldJWitmRjdaclNOaHovRDIxZXRoOFVXcE5taWtsbGlXYlZrNFFuckZ3?=
 =?utf-8?B?eTJpWTB1NE5oRDRJMDIxcko5MkFkUEg1ek1leDJyR0NhWWdUWU5lMlBhZnZL?=
 =?utf-8?B?ZVN3NUJPb1B2M3NJd2ZlNUNsZHFMR2FPdVZNT3BZNFRTR2RpS3l6endCckdC?=
 =?utf-8?B?VHZ6T2ovcHYxWXp4WTlrdHU3Q2VmM2JJMWxCcHV2blk5ODh5SUh4YlJMQjBK?=
 =?utf-8?B?RXM2dmZ5NlVrZVdTQzN0eWRLZnd2aWpERC9KWTFMSnBSYWJpbVJkTDNqQ0tk?=
 =?utf-8?B?cnYveHVJL3c5QThIWWs3WFZBLytEZHA4REppc1Z2VFp3RU9rS2FZTlZHYXI2?=
 =?utf-8?B?RzVTcUUvS3c2cDVxUkV1L05MYkZuRGdRcWJDaGhFaUhaWWxycXBYRXNUeEhj?=
 =?utf-8?B?OGEvbEt0ODNQQUYwc2NXUE5vMEs2NnZpTnc0R3JlWXFzSG90QzJlb0VaRnpk?=
 =?utf-8?B?U0lvUzJncFk1Vm45cWxteDRTUGhzY1hwbUFVMEJwMW1BdnJjdXVrZGV3QjBt?=
 =?utf-8?B?K051UE9GY2QyTDZ0eXcxN0RwNlhaWWlBai8rWGV1NE54L1VuM05QU2l2cGFj?=
 =?utf-8?B?eitvUi9vMmU1RU10a3BmaUxVVmwwWU82bTh5bnZ2QmxaMjd5RVcxTWcyb1FI?=
 =?utf-8?B?R2cxVU01SjZGTW0vb0Q4b1lrbkhSVlh2SDF4YkQxeHZDUkhveWlHRW1NdDVx?=
 =?utf-8?Q?5qr4zsNnpzERklEeijx3DKHuf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c59dd0db-c332-41f1-07d2-08daf8474571
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2023 04:57:01.9154
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bV6i/Lr3ZfBJMN/TNl5iFuKpAIVYqJwCdtpZD1URoSB3iG28c+xjr11ZyJOdf+nC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7760
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2023-01-16 23:29, Junio C Hamano wrote:
> Luben Tuikov <luben.tuikov@amd.com> writes:
> 
>> We're generally not interested in "what else" is in the SMTP envelope
>> and headers.
>> ...
>> The idea is that hook writers would merely be grepping for a particular
>> header they're interested in--it could even be a custom header, "X-something"
>> for instance, and if present, they'll check the contents of that header and
>> validate the patch, or perform some other action.
> 
> I am following you thus far, but ...
> 
>> So, checking that the SMTP envelope and headers, $2, is not empty suffices
>> for what this patch set implements. We leave it up to the hook writers to
>> inspect the SMTP envelope and headers for their particular hook purpose.
> 
> ... I am lost here.  To make sure that the hook writers' grepping
> for a particular contents in the file $2 does find what they are
> trying to find, wouldn't we want to have a test that looks for a
> "known" header that should exist in the expected output (or even
> better, arrange the send-email invocation so that a custom header is
> injected to the output of format-patch and grep for that "known"
> header)?

Yes, that's exactly how my Git is set up. (It's a bit more involved
than this, but essentially a custom header is added and a check performed.)

I'll follow up on v6 2/2 patch review with this.
-- 
Regards,
Luben

