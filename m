Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBC19C7EE22
	for <git@archiver.kernel.org>; Thu, 18 May 2023 00:51:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjERAvR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 May 2023 20:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjERAvP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 May 2023 20:51:15 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A2E840C7
        for <git@vger.kernel.org>; Wed, 17 May 2023 17:51:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cQu5jcftIWrKYFgdRvq55cKrVAs5zFk//I/4WPXVeH0kMuEXBLzhl1o7kBb3g2MZRSS9OAPai7ZdnpbKEDTxbzVGl5Xt0VYzKjmFVa/9PqC0U9mGIuPBdTzG2knv3l4yLyu/ShOEZP2r51WW6tudFrHGLzfef7HptdZrBFGRIdhCpmzgKdjs53+pHGBCeAS+NLqYaVdI5N7abtEzZRJyYb0KJHBWVTEl0UkqKiT0bXydShacFxW6GI3G+0UMZXjAG23r3jAGvz27+Ne92+oq4a9uAVga8U9Pxnuj0gO+IOCrcg7vxLLgfWLvkXzt/PkAwOSq8cdZ97nba0D3c60kAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FkKC9RmMRIUZpPPiGS7b0952iU0OCK4Bifc2SibhI/k=;
 b=Ntw3zQFj/X+8PlNkWoOST7mmh+Cf7D0DCRhOnSdK5RBKsb2ySszYfudsL9185QCOQpfOI4hv94GqwDvIKIumcf8Vn96E0EdEwOkAwQBqUBPC4X02WcoJN1x5ENuyTQK7/0V9ogjijLCHTGjkTjSizin2MO8tVz9jATSgQc71Nt4+niyoOKojTBsrU24WaXEEMM7hDut1u9DiFqcUMZ8RNK9SfYNckf3R7pg7xVBbTAEfLXwpRjqVot4jFiF/e6WGAlBppA7vaHSdkbc5XGbAlQ/gATKsHOn4W2L8ZXEqigyxqTPon9ZRovCXirEIYju0E3C5zYK462Seu5DGdYMUrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FkKC9RmMRIUZpPPiGS7b0952iU0OCK4Bifc2SibhI/k=;
 b=2Gw06ZXhnDmRbb7l73U6pdnzqCXeu5BfGM7SX0QY5z2k9bRRedl7AhcfrVQawGgm3i1MbnYft1sfl6yXAELdeKXxO7CZDyaObIwRKrNieCElUwNJsQwHtjPMrk0i8g28L4Ys6chvB83cv/D3ACEwhAgJ6LTUuc4vD3ofH0bXrCU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4356.namprd12.prod.outlook.com (2603:10b6:5:2aa::8) by
 SN7PR12MB7201.namprd12.prod.outlook.com (2603:10b6:806:2a8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19; Thu, 18 May
 2023 00:51:09 +0000
Received: from DM6PR12MB4356.namprd12.prod.outlook.com
 ([fe80::677d:1c63:3ccd:acde]) by DM6PR12MB4356.namprd12.prod.outlook.com
 ([fe80::677d:1c63:3ccd:acde%4]) with mapi id 15.20.6387.033; Thu, 18 May 2023
 00:51:09 +0000
Message-ID: <05888c33-612e-3c93-55da-53b9f35cfc2a@amd.com>
Date:   Wed, 17 May 2023 20:51:06 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: bug report: cover letter is inheriting last patch's message ID
 with send-email
To:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <nasamuffin@google.com>
Cc:     Git List <git@vger.kernel.org>, dianders@chromium.org
References: <CAJoAoZ=GGgjGOeaeo6RFBO7=6msdRf-Ze6XcnL04K5ugupLUJA@mail.gmail.com>
 <xmqqo7mipyt0.fsf@gitster.g> <xmqqjzx6pxuu.fsf@gitster.g>
Content-Language: en-US
From:   Michael Strawbridge <michael.strawbridge@amd.com>
In-Reply-To: <xmqqjzx6pxuu.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4P288CA0074.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d0::7) To DM6PR12MB4356.namprd12.prod.outlook.com
 (2603:10b6:5:2aa::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4356:EE_|SN7PR12MB7201:EE_
X-MS-Office365-Filtering-Correlation-Id: b8a90f3d-b30c-440f-3c57-08db5739f837
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BCR7b8dyxJmsERNEr+0vstoWW6JRfeA9j9AhCflXsiIZfy9/+t3de3niwVexRvMeWom33ehuGbSAfkx2kgZ0bceoN6+FYSdMaQNT9HR9iVNsS9eqvtMJmDWQbNUPxH7FfrRz3MzSsxKgPsYx6T0OxaH6/IFZVD8ZXcwzf5eEhLGEC7SnF2g/Dk157RexyNV0VmuOlVw1mCHzQ5zJuCZ8y4xKhvFobIO13ZqkQQkwrp6qDUNtMoztgiwO+19mgdz4uLZ87N3wTrzqMMtMfPlzg7u1n8tyOI2Z+yQ/VaKLHZs64uaFOw38XcXwKonooHbsgn6gneRN+jlE6dpY+jJ8UcIXcyuRfYC584h6TioC2fdgIw6wU1+coHl4OKJNaB78DJokkjMcztCYzHHK4TwA1dg6r8UB8eV1HywQzpVWOlPu8KsFKnu0685iiwjTwSTdDJGPLaL623+dba1jKMj+NSb4Am7IRuxRemMuYPQXoonmpgkp6XtikMXZTM/mVmL86FCFiQg+j8WprwSVnwOLjHdgKoLM8AL2oTT6Me25VvdnWSrOROvBFVdRxsE37NZS0iOMT5B+LMJCvAPIS8V53s8DhattPlNmdAqsPUx4XpfRl9Xl1u8dB4Zu23/0+2U4ElK+t4bphI761VtL4c3xF03mY4qKlWWGiPONWsfBnj4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(396003)(39860400002)(376002)(366004)(451199021)(8936002)(8676002)(31686004)(44832011)(5660300002)(15650500001)(316002)(2906002)(41300700001)(66476007)(66556008)(66946007)(478600001)(110136005)(6666004)(6486002)(6506007)(26005)(6512007)(186003)(53546011)(4326008)(2616005)(83380400001)(38100700002)(36756003)(86362001)(31696002)(750200009)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eE4xRzcwbmxGR2MxeFdHblNtR2k2ZFN1VWJtVGZ6MjJqRS9odFVrTnhzWUh3?=
 =?utf-8?B?YzJhNlQ3ZVJzR2k1NitqV1dzS01hZzhYdHFpNlpGc0pTV2M3b1hUbyt1Qmw2?=
 =?utf-8?B?RlpHNWNGY2ZZRlNoVWpzLzRqRTUvaEk0aUt3YkM5RzBUTkpYTHZidlEwbWtI?=
 =?utf-8?B?d0dDVDdQUTAvaDF2S1JiTmhMK2tMK20ySVlLVzVRaDhEMTZpMkNCbWhxQ0s4?=
 =?utf-8?B?T1dXTGVKbG15OUh5WEI5bDdtUkUvT1hxdWtDb3NKQjJLeHQyVldhMWlwVGpi?=
 =?utf-8?B?UjYwRW4wK2hFMlRFTTFyWGh4Mk5DaGNGYWJrb1AxUUl2ZFQ2eUxTYzZyZ0pZ?=
 =?utf-8?B?NFYzZ0FPTnJDWmlYc2U2SEU3aThMWXRWYzIrVEx2enJEcnB0RUpxMHhxamVI?=
 =?utf-8?B?eXU0dmVGYmZNSkcvdFhXeld4ZkVJTlgrc3p6S3YxelRpbmlhYVNVRGJjN1RU?=
 =?utf-8?B?WmdUYzlMZXhxN2xQMnZubXVpZTZ6a2doOVh0dzdqN1BYeDhSMmtFejJFekpS?=
 =?utf-8?B?WHdMZkJKdFIyTytpek82bmlYYVNKRi9ybmZ0b0xYTTV0ODVvZWluYzFOdmNM?=
 =?utf-8?B?TWtzdzVYMHVkTzY5R3o3SHhyZ3FCMjc1aGYxb0FXWlNRa0NNZTZMZTArWHRI?=
 =?utf-8?B?bHRGc0w0SHhPdHo3bHJrcTY0R3grVFFjZUpaSzNNbFJBOWtCMGRCZTlCMFFB?=
 =?utf-8?B?TXAwTE9uY2U2dU16RnArSmt1T0FMZk9jVDF1VkhZZ1pzTnNObi9LUTMybWdI?=
 =?utf-8?B?ZFJQK2VHeUhnNEEzaXJnRnE2UXdEZnYwY2h1aUl3NDNmQXdyMlpUMG54clo0?=
 =?utf-8?B?ZmtzM1g3RWRMWHc0ckpPRzVPVGxmRXY5QTlNRUlSTFl5RXFqOHBwOWFvUlBY?=
 =?utf-8?B?QnBzak9ndjNmaUlid0UvekI1SG1KUjdVaXJiVGJ0MTBCQ2NlR2VnVHFYK2pV?=
 =?utf-8?B?b29IeXpNZFFtK1hhR2oxeC9SZWFkMzZJbXBTeUNHWExrdlovNFFUMy84c3lT?=
 =?utf-8?B?ZVFERlkrc1JDaWNqWldrc0xkb0lMZDczVU1hMXlCc3N2bEpGSW5GQWFJRUFC?=
 =?utf-8?B?bDQ1ODZZZy9xVVFGbmdld1FvN1BVQXpUOWF4RnFOc2k2bk50YUd6Uy9oSHBj?=
 =?utf-8?B?V2cvaDZIVFFFbzNWNStUWit1Yk5rSUVnclgzdVVFMDhkdGRzTlNSVlN0QUoz?=
 =?utf-8?B?L282cDhENllQdTNyTllmVUducUNmd2pFTHk2N1h3S0kyNndhVFBMMGk0RUlS?=
 =?utf-8?B?b1R3R1dIRStjTVdlU3R4N0V4ZDNvcTdSRFcxRFlLRHF6Nm9BVVlsRjdCb1l2?=
 =?utf-8?B?ZGxvR1RsNk9URmM2OUpSYy9xb1gvZmo2UnRVaEZJWG1LaUNzTzZwamlsOEtN?=
 =?utf-8?B?RzZ4WEUvWDZYZVRZMkZwdGp3WVE3azdQYXR2dTJqQmRScHZIYzcrNGFwYk5P?=
 =?utf-8?B?Ykd2SU1GNnd4M1Y2U0tKVXU1K2JLNSsvenhjQ0xFb1ltNVMzUDhQY2kxU0kx?=
 =?utf-8?B?NDZIYTBZaEMzeVlXMjhReUdKMlhWSHJxdHljd1NBOWpyMHVINXBxRytxM1M3?=
 =?utf-8?B?MFNieGdGWnRNaUZBZXRldGZBWEVpb3VqcytHODg2M2JNVTByNnNiY2gzWnIx?=
 =?utf-8?B?Wnh1QnRVQ3AxblBtNzlzZDRwa0x6Z1VYMU9PdEc0bUxjM05zanRRKyt6clZV?=
 =?utf-8?B?a3RXZk9LUytHeUFEaFM1RkgwdnczVU9zanI1QktXM294bjRFS21EUXg2aWZk?=
 =?utf-8?B?OEQzWVdQYk1qNEZDUk43QTBPcmFQbEdISFVOQ29EVFg1cnZUV3ZwcFZ2MVNo?=
 =?utf-8?B?cWZieEN2dVBBZDFFb0pyOXJDYjZvaGVIWUJJWEdFK0dlWXpRK214Q3hwRFhE?=
 =?utf-8?B?QS9TaTNMbG12RlVka2VFNTZXRnByM1JVSTVKM2Zla0o4aDlEeHpOT2lRRkM1?=
 =?utf-8?B?Q0UwcVlIM0hZN0d1V05vYkJwc3hWS3paSklPTnlFNXRXQXQ1UHJyOEwrNDho?=
 =?utf-8?B?WXVDQ3ZoUVNHRjk4SHRHVVFNZ2YxZWMrOWlwUUdCWTJvVnFrOU5NWDFyUmhz?=
 =?utf-8?B?cjRDbWpDM0UwbHhEWXE2Z3Z1ZmtFcFdJL2I3YzU3S09FUTg0RDRZalRiR1d0?=
 =?utf-8?Q?GigOHyAU6h8S1aAYKW+tPaftl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8a90f3d-b30c-440f-3c57-08db5739f837
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 00:51:09.4573
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /nn3ON2Ny2CRKJ7/6DlouaBLBDgRrXFspwGQSVlGhFIyov/ntnMBSK7EfW+CzLRQAHhaNgDZv4QtWPxKT9iGVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7201
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2023-05-17 15:22, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>>> # With the attached patches, where all of the patches have a
>>> # Message-Id but the cover letter doesn't.
>>> git send-email *.patch
> I suspect this is a recent regression with the addition of the
> pre_process_file step.  56adddaa (send-email: refactor header
> generation functions, 2023-04-19) makes all messages parsed
> before the first message is sent out, by calling a sub
> "pre_process_file" before invoking the validate hook.  The same sub
> is called again for each message when it is sent out, as the
> processing in that step is shared between the time the message gets
> vetted and the time the message gets sent.
>
> Unfortunately, $message_id variable is assigned to in that sub.  So
> it is very much understandable why this happens.
>
> I wonder if it is just doing something silly like this?
>
> --- >8 ---
> Subject: [PATCH] send-email: clear the $message_id after validation
>
> Recently git-send-email started parsing the same message twice, once
> to validate _all_ the message before sending even the first one, and
> then after the validation hook is happy and each message gets sent,
> to read the contents to find out where to send to etc.
>
> Unfortunately, the effect of reading the messages for validation
> lingered even after the validation is done.  Namely $message_id gets
> assigned if exists in the input files but the variable is global,
> and it is not cleared before pre_process_file runs.  This causes
> reading a message without a message-id followed by reading a message
> with a message-id to misbehave---the sub reports as if the message
> had the same id as the previously written one.
>
> Clear the variable before starting to read the headers in
> pre_process_file
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>
>  * I am not surprised at all if there are similar problems in this
>    function around variables other than $message_id; this patch is
>    merely reacting to the bug report and not systematically hunting
>    and fixing the bugs coming from the same root cause.  If the
>    original author of the pre_process_file change is still around,
>    the second sets of eyes from them is very much appreciated.
>
>  git-send-email.perl | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git c/git-send-email.perl w/git-send-email.perl
> index 89d8237e89..889ef388c8 100755
> --- c/git-send-email.perl
> +++ w/git-send-email.perl
> @@ -1771,6 +1771,7 @@ sub send_message {
>  sub pre_process_file {
>  	my ($t, $quiet) = @_;
>  
> +	undef $message_id;
>  	open my $fh, "<", $t or die sprintf(__("can't open file %s"), $t);
>  
>  	my $author = undef;
Sorry I missed clearing $message_id in my initial patch.  After going
through the variables again I believe it is the only one that is not
reset properly.
