Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0468EC433F5
	for <git@archiver.kernel.org>; Tue,  4 Jan 2022 13:05:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233266AbiADNFu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Jan 2022 08:05:50 -0500
Received: from mail-am6eur05on2054.outbound.protection.outlook.com ([40.107.22.54]:29818
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230512AbiADNFt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jan 2022 08:05:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ma6/KCoxnJWXgRyOLBSwbS9d5hfg0TpvpDA/ROaUwm2pYyiErkQLFJEne15aTMOyyLFhlFwLIsFIxQv81X52/iX1kA4+2WPndYEjmDnZwg+o1HyEEJHNpCqNpsPleo43u9ww+aHX6YUT1E/k6jo6uD5mM45kTNEhbBP7mhmmnEhnve60twQYcbVIb3aeAPYuubRNqW3c8UWMeKcQ96flu93aTOoTtCoNLG50GGzbnvguU7C0yx60NjV5nEkQb3IMsM1u/8Z2/inXtuKQ3z78+isYVlqFKDEJJh+brnl4BZRBUvvSKQlS+yLcBVL72Yc/9KIg2ZyxiWulEk+Xs7hweA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=An2FUV6MJG+lBreKXQ2Kte4ylwfbzz26GyGov/v1SOU=;
 b=jp+h52umjXpDLE77O+WP3eMMOGtBycPL3x8Om8M8Lx71PiGp/B7KUeCmFWfnYzSfwoltBuGH5oVwSA4Dk3nxP+CjeqZCxc20oJQAm5pWTUQ9H+k44WqKAlz0jWjoln7NaDROwCfJyFEerLF8c4ZqRY8oZY+FJwSOOG6cvPKF4CbDzmnSK2RNv4A3edVibUikkzbe+Fw2HiKpYKa1b+q5QZez5Uu0v0B3sL4YtMdbTQcWO+LCI5oM35X5Dai+gvEaxwRRfps3eVwa1mM/RG7N9+BFU5ITtzJpV+mFWkX6eYPuZqwguvm67WguAqvXtcx9h8YE8MPR2WumaNGh5j65ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=An2FUV6MJG+lBreKXQ2Kte4ylwfbzz26GyGov/v1SOU=;
 b=c39IHpwQ0UGj70zGWTSauX+96Yio6ALIyJKyxGiHtLoZ7oTT9eK5uNiUhY4c6mZtR1xe+86gX9AHR3mqqTMFfucHwwRjvAgVDQvGT6jYMysxysZiL0y/8dsJ2ekVid9r1uzXXQ1LOdlNmFJCNKJGYAWxzhhf2NbexyF2UaapAOg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PAXPR10MB4735.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:157::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Tue, 4 Jan
 2022 13:05:47 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::486c:1c10:65ef:90f9]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::486c:1c10:65ef:90f9%6]) with mapi id 15.20.4844.016; Tue, 4 Jan 2022
 13:05:46 +0000
Date:   Tue, 4 Jan 2022 14:05:46 +0100
From:   Fabian Stelzer <fs@gigacodes.de>
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 7/8] merge-tree: support saving merge messages to a
 separate file
Message-ID: <20220104130546.tk36zg4iju6ivdng@fs>
References: <pull.1114.git.git.1640927044.gitgitgadget@gmail.com>
 <777de92d9f166793cddbb383f497518a5dedb9f4.1640927044.git.gitgitgadget@gmail.com>
 <20220103123114.uuvpk4nley22gfkg@fs>
 <CABPp-BH4okfDXVC418HwfHVR2_NtbKFBOfyYGZ9mWnABMzSruw@mail.gmail.com>
 <20220103172255.54psh2e5iqzd37sy@fs>
 <CABPp-BEneaLnaTVo-Yb7fooLK8sQsDq_MdeBu-R2EporqCSqoQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <CABPp-BEneaLnaTVo-Yb7fooLK8sQsDq_MdeBu-R2EporqCSqoQ@mail.gmail.com>
X-ClientProxiedBy: AM6PR10CA0099.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:209:8c::40) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 50bdc85e-2c62-46f9-e18d-08d9cf82ec61
X-MS-TrafficTypeDiagnostic: PAXPR10MB4735:EE_
X-Microsoft-Antispam-PRVS: <PAXPR10MB4735A9F839AD28DD8A2A0F00B64A9@PAXPR10MB4735.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BiXrLMnwX4ACAgz52wW0EBmkAoybvowohHiEQP8xOdsDvmSy4xh3TyrnTk2UytCnpiH7aJO4bEP7Tg/gwVQXGULUaSF+RheJ5Ks+o3t0eQZFgG7lVD6cEt3B1JqAPm2YRSo9kpFeytUa/feAfirAqYrVcxsC3H5+CDc/4UjItiY+cGLInAs9D9gyQO8dxOXapNKgFDfYK2YskfmYyYGmPf8ALQZXpSk1An1CepQ0l0LNuc3OzGkO8+aPa1kItPtYgeRt1UzSMDIGFRO4eqf7FVPXZsw0732uRgKSJ/EQMQLFaxyLM5nw3TVTaER12tEceXVejRprvuQIdAJqp1aKw8PV3utFSnVcrpKAtTHh8DjuhOwWY4ym2gSFqNAqbHgqdf+sI01SeyWZeH4VvXrusWrPRRYvtTjt9obPhySTSrxlmn6kMzSlCxmsuC4SxKl5s91HlY9hzQrkIduYZKaxSB2Jm2UYJYxsZ0ffMJzZ5joV+vT+L1TxDCvQz9eeKGICLS6hKNN0tx+7yPItmogI7vnXgBV2HjB/lxY0HyDY5RUWmkpYrIa8pP9VkGE9GOjiqBe4FBhsGM+pnQrNzouemrCeYzTkYdgWFyln/tD2fjzR3N9NJCaKVu6wUnzif2LH+cKSEo4lQldywol4zwgkcYkr1oLqN75KdayKrsBfHlqXGLuauSpLBSk4dXzVN7CWigMXhvp/VHtq1aWpEX9Rux1u3XlhCR0f4RoiYaJIzJI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(7916004)(136003)(39840400004)(366004)(346002)(396003)(376002)(508600001)(6506007)(5660300002)(66556008)(316002)(186003)(966005)(1076003)(9686003)(4326008)(15650500001)(8676002)(8936002)(6916009)(53546011)(66476007)(86362001)(6512007)(2906002)(6486002)(66946007)(83380400001)(26005)(45080400002)(54906003)(33716001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OGN4RWZuTWNCWW11ZnlDU1BmeHN6TU5JRDY5d2lMK1pUWVBzVFh6YU03OGVw?=
 =?utf-8?B?L3NybTF0UlltMkVMdmlrbTNNNVhtM0hVY08xVjVkZEt2OVByc3FmNDJJQmh1?=
 =?utf-8?B?WXpzeVFaTTcwMVQ1dE42SG95anlJVEhvcThxd3Fha29HTU1GamhuNXNxTU9T?=
 =?utf-8?B?THRaTVM4NWNoQ1YyemR1WVpRMDlmS0lxcVZCLzZGVEx3TENsNUFJcE53cXYv?=
 =?utf-8?B?M0kvZDlsNUZGbkpqN0lEdTVhRzEwQVNsaDU0UlFaZlJBZkZrL1lDSXdxaUth?=
 =?utf-8?B?cWlsNm1UbUpnbzRVbUZxczByVWNRMHpiUjZjWEY4ajVEc2xvdjRkK0JWWlVL?=
 =?utf-8?B?dlREbXlnS1o3REFnMnFNS05kNUtPN1RIemxPSjZwRmxtaWVQK09oM3ZLYWhF?=
 =?utf-8?B?U1J1dVE4RnlQR0pPTDUzVC91bEN2ZHcyeWgxU2JkMGJ2STJINjc2YzBlV1ZK?=
 =?utf-8?B?QlV0NjBiUVU4VXh6TDRLYnNaVEJIc0Y1YmZQVG1zdS9UM0xQSXVaYmNYRUVU?=
 =?utf-8?B?d2xGVS9xL0JGM0ZoMUZQcExqS2JBUHVmck1xZ0ltRVlld2tqcEN3M2NFMTBW?=
 =?utf-8?B?Wko1Y1N3K05YWkpSQ1R2eUVLeTRJZmdiT0VFRncxL29iS3J6UVRKK09JaVhl?=
 =?utf-8?B?TGN2TjJ5Zi9FZHRhVHRoMlprMkhnVk1RRXR5bkJrelhkaWt1ZUVCMzNYRmdl?=
 =?utf-8?B?NERBQVZTL3VHdjhibWtBNHBrU2JnUUljNCtOWEZBMkliYXJ6LzAram80SjZ3?=
 =?utf-8?B?SFc1ZWdndWFGTmJORHp5R0VxczkxUTFFSWNxS1lFZnBFT2srd3dVWGsvL05F?=
 =?utf-8?B?N2N6L0RpTi9PcS9aTVZ4MFV1Tm5DbkNsdnBuSUYzZkdva3BpTm9mTTRJR3px?=
 =?utf-8?B?Nm90SGpCTFBsTE1tTS96SXR1STY5bTkrTnRuNjgvQ3M4UU1vYzVTbjlIOGFF?=
 =?utf-8?B?MXJJMU9zZHRleno1Yzg3aDJyZHVkM3FXLzd5bjR6MFFIWWE3ZEFoSERnMTZv?=
 =?utf-8?B?blk1WjFrM2VTTzI0RkxTY3JTSDBIZkNBOFh0b0pkeml4MVJWZW9jaFBXNUQ4?=
 =?utf-8?B?OW90WkdCVlhKNS9RZXVuVGtNYTREa0l4anJJeWtsQ0MwSndZOTdjaXJsSzV3?=
 =?utf-8?B?cmVjV2pnclJWOW1yaitvUEVMa29mTDhoOFpDenduZ0dhYnVqS0huMi92NE1m?=
 =?utf-8?B?d1duUHFXcG0velUrZmVaOTFSN2pRNXdQdkJzUURvRDhsRTFuKy9uNmZZSFh1?=
 =?utf-8?B?UWIrbVFMZ2lWS3NPVnlVc0dzejJnUVlWcTMzd3FMZUZKdk11aDRwSHR2azlC?=
 =?utf-8?B?NTNEYWhqNlljaTZKRis0RHF6MXRHQmVKQkZJaUt4UGFucHltUUdXejg5VkQ1?=
 =?utf-8?B?VGNIdGFQVkJqOEF3QkZKVnJzZjhIQnIzUXdTQVpTZEJHRVNkUjlyVlRLNTMx?=
 =?utf-8?B?UUtRSDhKWTNjOExjMkVnMnhJU0x3WDU3MUFXUXpocGdhYlVHZkpWYjRoUG9p?=
 =?utf-8?B?ZXZxbnNPZjE0b2svdElaM2Rla2RQUllvY1RuRE04UzJ6YlQzSkRPekRqckRV?=
 =?utf-8?B?czhNK0ZFMUxyQytlQXIwTTRkUmFkMVRzNzlCanhMZTNjVVR2Szl5OVV4Zjlm?=
 =?utf-8?B?aC85czVxc3pGQVgwbG9SKzUyZEc4aEwzS2pMQ1RUU1Bnd3FZcTdGYW5QMXVR?=
 =?utf-8?B?RGRwNTQrNThQOGwzeFhmV0VtRU15dDRxaFY3U1ByaG94WU9MR2lRd1RHdnJi?=
 =?utf-8?B?ZmFqQVFYQlFscW1tZ05MaGxGbUZPaVo3UlNGVDlUTHBOV0xkL3d5cHdwbm53?=
 =?utf-8?B?UU1jQkZLa2xEcjRzTnNQQ2NlNW0zTFNxNGZ5QUR5c1pBZmUyN2JkYUJFWGxH?=
 =?utf-8?B?L28ycXd1Z2doRUNPblBWaEU1Z014QWN4Y045M2lLT1RESzdSeHh1bkF6aGVB?=
 =?utf-8?B?UXMzS1N6ZmZETzBMM1VMZlEwT0JmWE9CNlB4TFdyZE5EalhDbHlsOThxUVI2?=
 =?utf-8?B?dDIvY3BGNmNuQUg4Y2V6Mmxxc1NUdkFsdzRpM2VWam00N1A4ejRaY21qSjlH?=
 =?utf-8?B?d2EvTitpYUZGNktQVDdpWHdKdHRSQTZHdndNRnFtRzhyMjJySDVWR2dDSkNW?=
 =?utf-8?B?djNXbW5pQ2ZpYW5zdkJLQ0FvNFFlbmp3NjFmRHIwd29tYWRBQ090dkwrYjB1?=
 =?utf-8?B?bHhiK3NrV3NDeURHR2ZZMWoyT2RDbExPc0ptNUFJOXBoaENpQkh6dElNZFlp?=
 =?utf-8?Q?grVrQmVQdAGthuYj+r0JZwv9GjHg8tiJ8KqkRz+54E=3D?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 50bdc85e-2c62-46f9-e18d-08d9cf82ec61
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2022 13:05:46.9265
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MkX9Jyex/6tWVRAHLjE9aXXWSdlyzgGT/0lFwKYAHo7PDfyBRTlobp4WNSBYInIN56xd6E2B65B9UBxfFCTCrAJ90oLX/8b6Az+DXY4+aRA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB4735
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03.01.2022 11:46, Elijah Newren wrote:
>On Mon, Jan 3, 2022 at 9:23 AM Fabian Stelzer <fs@gigacodes.de> wrote:
>>
>> On 03.01.2022 08:51, Elijah Newren wrote:
>> >On Mon, Jan 3, 2022 at 4:31 AM Fabian Stelzer <fs@gigacodes.de> wrote:
>> >>
>> >> On 31.12.2021 05:04, Elijah Newren via GitGitGadget wrote:
>> >> >From: Elijah Newren <newren@gmail.com>
>> [...]
>> >> >
>> >> > static int real_merge(struct merge_tree_options *o,
>> >> >@@ -442,8 +443,15 @@ static int real_merge(struct merge_tree_options *o,
>> >> >        */
>> >> >
>> >> >       merge_incore_recursive(&opt, merge_bases, parent1, parent2, &result);
>> >> >+
>> >> >+      if (o->messages_file) {
>> >> >+              FILE *fp = xfopen(o->messages_file, "w");
>> >> >+              merge_display_update_messages(&opt, &result, fp);
>> >> >+              fclose(fp);
>> >>
>> >> I don't know enough about how merge-ort works internally, but it looks to me
>> >> like at this point the merge already happened and we just didn't clean up
>> >> (finalize) yet. It feels wrong to die() at this point just because we can't
>> >> open messages_file.
>> >
>> >Yes, the merge already happened; there now exists a new toplevel tree
>> >(that nothing references).  I'm not sure I understand what's wrong
>> >with die'ing here, though.  I can't tell if you want to defer the
>> >die-ing until later, or just avoid the die-ing and return some kind of
>> >success despite failing to complete what the user requested.
>> >
>>
>> I think i would prefer the merge operation to abort before actually merging
>> when not being able to write its logfile. Otherwise we possibly do a whole
>> lot of work that`s inaccessible afterwards isn't it? (since we don`t print
>> the hash)
>
>I see where you're coming from, but I don't see this as worth worrying
>about.  For two reasons:
>
>(1) I'm not sure I buy the "whole lot of work" concern.
>
>merge-ort is pretty snappy.  For a simple example of rebasing a single
>patch in linux.git across a branch with 28000 renames, I get 176
>milliseconds for merge_incore_nonrecursive().  Granted, linux.git is
>pretty small in terms of number of files, but Stolee did some
>measurements a while back on the Microsoft repos with millions of
>files at HEAD.  For those, for a trivial merge he saw
>merge_incore_recursive() complete in 2 milliseconds, and for a trivial
>rebase he saw merge_incore_nonrecursive() complete in 4 milliseconds
>(See https://lore.kernel.org/git/CABPp-BHO7bZ3H7A=E9TudhvBoNfwPvRiDMm8S9kq3mYeSXrpXw@mail.gmail.com/).
>So huge numbers of files pose much less of a problem than lots of
>interesting work like renames, and merge-ort is pretty fast in either
>case.  Sure, if we were talking about traditional merge-recursive
>which would have taken 150000 milliseconds on the same single patch in
>linux.git testcase (due to the 28000 renames), then we might worry
>more about not letting work get tossed, but at only 176 milliseconds
>even with a crazy number of renames, it's just not worth worrying
>about.

I guess I'm just not used to how good ort is yet. I was still expecting 
cases like the merge-recursive ones :)

>
>(2) Even if there is a lot of computation, I don't see why this error
>path merits extra coding work to salvage the computation somehow
>
>By way of comparison, a regular `git merge` will abort after
>completing the same amount of merge work (i.e. after creating a new
>tree) when the user has a dirty working tree involving a path that
>would need to be updated by the merge operation.  And that is not a
>bug; it's a requirement -- we cannot first check if the user has
>dirtied such a path before performing the merge because it's
>impossible to do so accurately in the face of renames.
>merge-recursive tried to do that and had early aborts that fell in the
>false-positive category and some that fell in the false-negative
>category.  It was impossible to fix the false-positives and
>false-negatives without either (a) disallowing ever doing a merge with
>a dirty working tree under any conditions (a backwards compatibility
>break), or (b) waiting to do the notification of
>dirty-files-in-the-way until after the merge tree has been computed.
>I wasn't about to break that feature, so merge-ort had to delay error
>notifications instead.

Completely understandable for the regular merge. In this case we are not 
touching the index/working tree at all though so I don't quite see how this 
is comparable.

>
>Now, the dirty-file-in-the-way condition is for a very common case
>(either for users who intentionally like keeping dirty changes around
>and doing merges but the branch they are merging happens to touch a
>file they didn't know about, or users who just forgot that they had
>local modifications).  In contrast, this case here is for when we
>cannot open a file for writing -- with the filename explicitly just
>specified by the user.
>
>
>So, I'd rather keep the code nice and simple as it currently stands.

Especially since the extra work penalty is so miniscule i agree.

Thanks

>
>> Thanks for your work on this feature. I think this could open a lot of new
>> possibilities.
>
>I hope people do interesting things with it, and with the server-side
>commit replaying I'm working on as well.
