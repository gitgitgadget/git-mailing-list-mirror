Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3291DC3DA78
	for <git@archiver.kernel.org>; Tue, 17 Jan 2023 04:09:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235228AbjAQEJL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Jan 2023 23:09:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235150AbjAQEJG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jan 2023 23:09:06 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2044.outbound.protection.outlook.com [40.107.212.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A86271206E
        for <git@vger.kernel.org>; Mon, 16 Jan 2023 20:09:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EFnf0DbjiNsIJDkgJ9T3+TWHIh1AMe5CRMWti+otDvcaNV7c5hvNAvKK7FW0wKiw7FbVKrovpQfZjYTH7QZfK2azF93N6gMl85D/h6X4MJouYsYq7cTuzVyYdQXT2JIgUJvtmDi95AxA8eV4Hd8pY6KqdO9Dly4A9wjSrlmZF5Xij+BE6ZeNv8H7e+U74gHDdcCnzv9VtwCQ9aUZ7sEnu9IGuXvcvT3T9Uh9J4W1D3U8e0unzKMY0adHK69pk/dHX1HC+jpiyMGLnNN4WI1K1zjyI9RkP2yCXxYd1cLnl/rZhdbgiN3rUfPvnxnja9maN3tLY0SH4A9aK/efU4YynQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uy0x+hVF+1TLynBqVFuaWO1KtVlarKIfpXxAiVDU7L0=;
 b=JAbQJDttzy8+V1LUMQ688K7ofMXi74NDAuM6LJItYufVCIs1IjQvW86vL964csQcFNziFnp2ksfLQUsun8dNMVNxk+GRItBdJdG7dNN0z7NTydV5WfPR0KhAZP3lS7ohBPd8v+Yxtz6HTvZ9dxc+Jpqg+3nvYP9mm60/At0JNpVcVc3VNirevUEEZLB7oTtjXoJp2ixtNEriPlW+5C5d2rDty5QlHEyqKFSRzgEJdc4nUD0Ye9/pm8Yh5atUllxnHogKkjcTqSc6cthj9EW9LKKDlN/pfo0RS+F3/QPs6jdmF6PGsaszHZvX3/kMa/eD/ZjzgRRWsNRM8vG9xwuYXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uy0x+hVF+1TLynBqVFuaWO1KtVlarKIfpXxAiVDU7L0=;
 b=GY8Z+eNnaFTQgZNeHVjnS/VsPC150QhrdnKFqy49/8Oa8s+udmDoejtU5+4rZz7IEsHyoyN0lQEQ7Q6G5VTPIbu0YMd0WfJh53jSdpyLox4gOTN5ZAGwCLFptFe5B4O+jnKaRIXhR5Oy1cvPPq7qLUzBtTXkkJ/ji6gv1Rrq56k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 DS7PR12MB8081.namprd12.prod.outlook.com (2603:10b6:8:e6::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5986.23; Tue, 17 Jan 2023 04:09:02 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::2fd1:bdaf:af05:e178]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::2fd1:bdaf:af05:e178%3]) with mapi id 15.20.5986.023; Tue, 17 Jan 2023
 04:09:02 +0000
Message-ID: <f31f1480-d611-f4b4-0e7b-589574943eef@amd.com>
Date:   Mon, 16 Jan 2023 23:09:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Content-Language: en-CA
To:     Junio C Hamano <gitster@pobox.com>,
        "Strawbridge, Michael" <Michael.Strawbridge@amd.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
References: <20230110211452.2568535-1-michael.strawbridge@amd.com>
 <20230110211452.2568535-3-michael.strawbridge@amd.com>
 <xmqqedrxm7bn.fsf@gitster.g> <xmqqa62lm76t.fsf@gitster.g>
 <xmqqfsccii86.fsf@gitster.g>
From:   Luben Tuikov <luben.tuikov@amd.com>
Subject: Re: [PATCH v5 2/2] send-email: expose header information to
 git-send-email's sendemail-validate hook
In-Reply-To: <xmqqfsccii86.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4P288CA0038.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d3::16) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3370:EE_|DS7PR12MB8081:EE_
X-MS-Office365-Filtering-Correlation-Id: de53f4b8-3de3-40f6-37c2-08daf8409141
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3td/fdKk7Zxpja3f6Dv8tCqhY8FGp6/mayBzmMQ1wdzEAUbLCxR1nViGlvopVtAVRDqNB4Dkya382BJHbyfnWBBcSonOi6zWFjtqdUJI7+sYc5uzUhYeqM9ZaSi50TmIPiKEHtF2AqmXSqAJWKX4AH3zSVo3T7i8qCXQctsTGmFyysVrym8c99I8LTLrxz/AsZm7m0rXaU0WeWwUzXvy1w2nDtfrFJt8f5JXrv/ktmuAqCA7n3ZOJVUxYDa/YXq88Y02C8PMs/j+QzAFdKCc7TqZefj2K0BKNpqxO23zn6CY8l/2b16tBUZpp6QcNG98qSFPAWYXvW3YJt6Vr+PJTIxSF4pg1aR5vXXggGu/V2DbZEkVhDSbY4t8OiLHzWBnC2cAwWTp110t3uFmR0v1r8RAcROORFqRw6/3y7FMOHV1rfqYOKQO+BFFVgOzl4DMgGMSFIwJbXiEofONZT4wAmaT6K2QhBKiX06TypFNJdLzQZlznFuQkg2E994iExb6wMLdFLp/G4BEWB9H7ouPYHBc45Xm6j4BrhwxXh3J1MIVaqXT38jLupNwtd/OAiNN3Ss/AwuKLOBf8iAZ/CklXJF6qerokkUEruu4/nXyg0Os0nmiBRI0J364/GwcCffQhiJXAdr0P5HlqbK6aAUgFZYyzK8N2VXKze154z4I/ZaW40ochN42xobnIHoxg0xtCItrjcNGrNlEsGzdaaddez+UmXNofZ/S7EroXF36mho=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(366004)(346002)(396003)(39860400002)(451199015)(31686004)(478600001)(6486002)(8936002)(15650500001)(44832011)(5660300002)(4326008)(66476007)(66556008)(53546011)(26005)(41300700001)(36756003)(66946007)(8676002)(2906002)(6636002)(316002)(31696002)(86362001)(110136005)(38100700002)(6506007)(6512007)(186003)(2616005)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RjEvWmhYVEpldCtnclV0VFV1a2RKQk9VVDN0V25DUU94NUw4RTBjY3lOaHlu?=
 =?utf-8?B?N3BDdEw4YkdRbFN4UnBhRGFoZ09YRGlVVEVuNFVkVDZpeHQrWHFpbk9IYTNi?=
 =?utf-8?B?dzNud0g4S05OcmpFMURBZCtLVkJHL1A5cU5ZN09sMmRIWWZleTR5Y054QVEy?=
 =?utf-8?B?Y1hVK2RwUmRSOTZWNWMvVmFFSlZVYjA2TlhVOWQ2N01YajJPa1J0UmJyZnZE?=
 =?utf-8?B?dUJkYkNqS2YzSVhCNE1meGZQMHo4eGdCd0Exa3NHWlRqMlliMVozYTZ1NXUx?=
 =?utf-8?B?SGFSQWczSGpmQ01aT05UQlcwSER2VlV6eThVRTEvOG5XVjRQc0JwYk5CQ1ha?=
 =?utf-8?B?dEl3OWE3cE4wQitlQXFHYTdCZFV4b1VwbEtrN0RYWVdXRHlCTnpSUjhCWm5p?=
 =?utf-8?B?aFBlaVpidHF0TDA1R1JySjRHWFNibVVLRkhGUTVDWi9FYzAyWEF5T0JmY2dl?=
 =?utf-8?B?WmF6SWkweko4ZmJnYTBPRTZERjE2V2QzL0lTS21ubFkwKzVuSGVCcjNjVlQr?=
 =?utf-8?B?Rlg0eXhUbWtSaHhzZ05FZUw3c0plU0pjQlFPUnZTdG1CSFlFQ1ZlTzU5Smdy?=
 =?utf-8?B?c0w5TDBveUc0ZGpZd0tJMVBNbzEvcjlvc1dkY0ZlTkp4TTY2eUVkNVdod0tp?=
 =?utf-8?B?ZXdWTGdtbmFHZFRzUnJZSnRUYnZzbmZMbTFwc2pPb0t6cUlLS0lqYnNhamx4?=
 =?utf-8?B?dWhqQWVCdlArUDFDVEtEbkNkRDdHMHQvYWtka21LMnVTcU50aWZhZE03bTZ5?=
 =?utf-8?B?aUUrTHpQYVNuOVAxeEl6Z3loME9wbG0wUEVKNEZmaGplMGNlTjg3cndPUTFm?=
 =?utf-8?B?SnM1bVEwWm4rZVFRMUQ4NDE2bnk4Y1p4NEtpOVlQK0Q2YXJWTW9WL092TFdx?=
 =?utf-8?B?NjN5OFduWUUxbHdKRFJvSWJFSTF5Rmh5QjJsTjVzSi9pVUUyME1uN2pMMkVa?=
 =?utf-8?B?UTV6WkV2TDNFQitpM2dERG9oRlY5aDFaT21kb0piNlNvNXd2VmFBUUgyajdF?=
 =?utf-8?B?S1cvOUlHaXBYOERVU05qOHZXOWlZQTRROVRSVlJvNzI4VnpHaUF3NUdVV0xJ?=
 =?utf-8?B?UGE2VFdIbHBkR3hybk9DWmRuRE1laWxSUHdzNGY3NDgzL3dyczhwWUp6YUlU?=
 =?utf-8?B?TW1KSThXRlVyNE1DWEMxS3habG9SNVhJRG1vWGxMbVI0bWhJS1B5SnR3c1dV?=
 =?utf-8?B?NmNBRW1JRVpwUldJbmRCekNNL1NNODBjWHhjY3B0T2NKU1JHam51T1dPOFZF?=
 =?utf-8?B?WUZuMEZSRUo5RzVoSmJaT1VVRXp5TmplTHB5Sk9hRjZhTTVxTVFRSFJPNFl5?=
 =?utf-8?B?RXFBMktRYm9NZjNLVWlmQk9LeUYyYjRoUkJVT0VYbFFtdXR1YVpZWjltdEtS?=
 =?utf-8?B?S1UvT0NFQW5KQUsrb3JmQ1M5bWF6NUlqNHJobFhrNEEvelpYdEY3dFZISUJZ?=
 =?utf-8?B?TG5jc3dJd2J5dGR6MTFVc1VoNjVOdTBoRkN2TkRUbzdvTkpZOWQvdTUwYkFX?=
 =?utf-8?B?UW9HMlE3dWNpMDZZQmVsd0tHL0dicFlRTHpzZ2piRHBaNVNST1o1MmsrcGE2?=
 =?utf-8?B?UGtQQVpLUWtVem01Qnc1YzRXbjMrbU52alpUOG1lejRIV1RnS2VPdWo1d0xz?=
 =?utf-8?B?NHNqZVhkMk1tYndVY21RYkJhaVk4NHNHd24yaFYxVjNtY3RheG9PeXM2NTI4?=
 =?utf-8?B?R1piWFFvUXFaQzdFbFYzeHpVdHVFNFpxZkNQZEZRSjZESUFTTDVORCtYQS9I?=
 =?utf-8?B?MlNkZnRHNkE5dVJhaFloZ3pxTGxHaDZlWXZkUGVUbjV2eExoVDFMK1c3UE9o?=
 =?utf-8?B?VDE4L28ramNRWkRDYmNWa3NVbXMxMEhKOFVLTjNuMkxoUC96bjRGdlg1d25m?=
 =?utf-8?B?MGNCeVNkYmJZYm5WSnJwNlBlbWl5U3hydDh6M3VyenRKOEg5dVdTTHprdnZw?=
 =?utf-8?B?azM1ZGFIc1M0M0dsMUtsQ0JQOWp6bjFpMzB2UzRjeDFna3crVGRlWHlGZEhL?=
 =?utf-8?B?dXNHSlg4Q3phQ2JoMkcrVjFheVNQYUlmcWVLdWFyMXkvSEZBSy9tdVZGTTBO?=
 =?utf-8?B?SFhDUWN0TnB6VzRyN3RNWFFTMFRBSGxpWXhJOWU4RlA4NEFEbWYrbnRRRWNx?=
 =?utf-8?Q?5TjSNMEyoeh5ces63tEKpLT5V?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de53f4b8-3de3-40f6-37c2-08daf8409141
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2023 04:09:02.6318
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: loRbFHYvI1mEh/2Eu5h17i2h2tp/8Jt+eqAxyoGux8F0c+xMo/MA7P2cW4xg8DDk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8081
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2023-01-14 22:34, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> "Strawbridge, Michael" <Michael.Strawbridge@amd.com> writes:
>>>
>>>> +test_expect_success $PREREQ "--validate hook supports header argument" '
>>>> +	test_when_finished "rm my-hooks.ran" &&
>>>> +	write_script my-hooks/sendemail-validate <<-\EOF &&
>>>> +	filesize=$(stat -c%s "$2")
>>>
>>> That "stat -c" is a GNU-ism, I think.  macOS CI jobs at GitHub do
>>> not seem to like it.
>>>
>>>> +	if [ "$filesize" != "0" ]; then
>>>
>>> Also, please see Documentation/CodingGuidelines to learn the subset
>>> of shell script syntax and style we adopted for this project.
> 
> I'll tentatively queue this as a fix-up on top of the topic, but is
> this testing the right thing?  Should we inspect "$2" and verify
> that it gives us what we expect, not just it being non-empty?

Hi Junio,

Thanks for reviewing this patch set.

We're generally not interested in "what else" is in the SMTP envelope
and headers.

The extension this patch set provides is that if a hook-writer is
interested in some SMTP header, or the contents of that header, then
there is a way to provide the SMTP envelope and thus check the headers.

Currently, $1, is identical to git-format-patch's output, (for which there
are other hooks to check that output.) This was a bit disappointing, as it
is a git-send-email hook after all, and we're interested in the "email" part
of this Git command and hook.

The idea is that hook writers would merely be grepping for a particular
header they're interested in--it could even be a custom header, "X-something"
for instance, and if present, they'll check the contents of that header and
validate the patch, or perform some other action.

So, checking that the SMTP envelope and headers, $2, is not empty suffices
for what this patch set implements. We leave it up to the hook writers to
inspect the SMTP envelope and headers for their particular hook purpose.
-- 
Regards,
Luben

