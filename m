Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBD76C3DA78
	for <git@archiver.kernel.org>; Tue, 17 Jan 2023 04:36:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235303AbjAQEgB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Jan 2023 23:36:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235347AbjAQEfo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jan 2023 23:35:44 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2043.outbound.protection.outlook.com [40.107.223.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A499E23C79
        for <git@vger.kernel.org>; Mon, 16 Jan 2023 20:35:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QGaImvoADlA4RkmODC0ByMObvVrGQH/WauCIkRI5F6SC6v2AZ/QGnUVPG30ofDPEd69e7MxCB/ujsBjInquTSDzGbkd8YQrA3mixmaZmCdr73OQjjtnMMq0eGXRJ/juKpQz+lD9tfhOzGdQtMQmludEymlY2/Rr9B4UuE5BDiAfelObgZ3TJfheSSt4bee0Qu+BFMzDChgqSfh9Sg+YjFzxMsj3wW9l45YlW4nIlqm8dDYkAWjYh7HWrJW1b9ONGM5cB2FX8gYG8+uIrAg7u9x2yyOUh373jUIU4VSOeEZGXUJABXRi9xM1ZODADxQdPesckKl+Vb6/EGm271tCGCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nWXG3/HSl/4ghryt2uCnmBQ/j5ybR8DAgP4JN93medQ=;
 b=YJzopLRu0PRaywRkQCuPceaUzE4j1sgIOhBOneMXdamgQCsNe49G+K+HMCPADa2DtBVp3TpKne0TmYAPVUWagAqz324gEVNO+wTaKbPP3PYmahft3sSrry4FsrTVmpyF4jJkpxBOcTP4Eam5ADIJlG+BmjVVkOP00q8mgxkK4lHPw8PxuqI9OqrDjqmYL6Nv6+d5lWa2R3fZ7r7XQF0S56EqG21Z5ik4DG56aK8l7P8uE1M55DN9y6WgWT0cpD19yqAjfQ4gzezkAETnp7rCr2FofJm/awVuOkFIvtdmmuo0vhvE4FTyGiBfrLVhAWpw50Z9vs54E6dtvxHW+0LLOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nWXG3/HSl/4ghryt2uCnmBQ/j5ybR8DAgP4JN93medQ=;
 b=cQepU99iEsq6dwY2h1dqfXTTzw6AKKwefNOjmGtWMVhPmQS+G40yvCOa/pGgI50MIoCHH6TkYjZmbJLUwjacL1L+KG9utvXRfl5QAMMsJBK2Xm42SXKpf6jW0eyzaRC4Ef4AQ2+bL/s5XekJwhD28UyWy4LJ3A1RY0OqQ/3Tm1M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 CY8PR12MB7244.namprd12.prod.outlook.com (2603:10b6:930:57::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5986.23; Tue, 17 Jan 2023 04:35:39 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::2fd1:bdaf:af05:e178]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::2fd1:bdaf:af05:e178%3]) with mapi id 15.20.5986.023; Tue, 17 Jan 2023
 04:35:39 +0000
Message-ID: <fe862ffd-aec4-932a-73e6-e7ddb0b97ded@amd.com>
Date:   Mon, 16 Jan 2023 23:35:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Content-Language: en-CA
To:     "Strawbridge, Michael" <Michael.Strawbridge@amd.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
References: <20230117013932.47570-1-michael.strawbridge@amd.com>
 <20230117013932.47570-3-michael.strawbridge@amd.com>
From:   Luben Tuikov <luben.tuikov@amd.com>
Subject: Re: [PATCH v6 2/2] send-email: expose header information to
 git-send-email's sendemail-validate hook
In-Reply-To: <20230117013932.47570-3-michael.strawbridge@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1PR01CA0051.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::20) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3370:EE_|CY8PR12MB7244:EE_
X-MS-Office365-Filtering-Correlation-Id: 8edd1a46-eadc-4e44-b7ad-08daf84448df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cGYpSmUmpMhtMByBBpARJ69bTZeTmcR/cjlSu5HTDSyQ8Qo/febGBtc2qAelGNcwrAl0aYnhw/SgeQ1b9Bs+bYp4WZMxAAqvJx3cLcDdWL2rXgA4eNd/g47Z9ROi18SoAHqJh8DJUBobqKPHgd5gF4HqBh9t+/6TSMP450WjxrKilovfJAcO18sPXXLdp+Bqp5ZVcJBK7XaslRsNgdIjIXkL8g/qqTVIQHuzX0RjqhhKkOmKcXKkvDaby0H+ZPIjlqehl48kc+gr7bA52ZgkluPZK8WeT1ChM6Q/9wIWMubOtG3OwB3sGyW0M7tTsrDMo04r7GoWxfEm17+TrfM7QF5LEFN5s04SmmabjZ06naIaquUL6XrudUlqCyW/Z3CJYfpeDDSBscFd7eiu7jX/pjNRje4p8LJrVwO12TdbIIHwefG6eM1t8PCO0XWLEQbutS7uXa5ZJuzxJlqnqu8UHs4sbwLB1+aoj+Vuipwc0WETtRhEH/ygmLiaHCIkpn1j5CQNp45KdBPVAeO9pwRPq9AsfqAph1AzxeR5sX5cT0qJt/YXDcOvyY2H2AXUBvKBsS9evKw+Ik7IGS7Z7UcPDfD6ug7mEvw7o2DzecVMcD7zMldGVMGWX8CEcZ9JwX5b8odKuFTHsnwRD2+V1TOutvXovCk2ljVK5+33iSH2g8MkD/ZYGve4ZsPLkfS3NcoFT+ZFkM6t3qbd83ix8OINdA2PYpfbW8J75n/C19Gmdf8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(396003)(346002)(366004)(136003)(451199015)(2906002)(4326008)(36756003)(66946007)(8676002)(66556008)(66476007)(41300700001)(53546011)(26005)(186003)(6512007)(6506007)(2616005)(83380400001)(86362001)(110136005)(316002)(31696002)(38100700002)(6486002)(478600001)(8936002)(31686004)(5660300002)(15650500001)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WjJuNzRuTWc4UGhxNmtEMUhycmk1RmtZT0FueWFwNWtEMHFzY2l3YkU5OVZM?=
 =?utf-8?B?eVVpSVVYUEtSdmkzbDI2d1EvNitOaVNWeHBSSmZ5Vy90eHM0TzVrb3NTYmNj?=
 =?utf-8?B?TUhqanFaKzBROXNyT1VubitFZTJrcWVWazhPQnAvOGtndDBCSGZDOEpFeXQz?=
 =?utf-8?B?T0Y1bHdONkZnWFVpd1VxeHh6NWlVaTNGRTEvQWowYTh3Y2QyRXR4Q3Q2dkVV?=
 =?utf-8?B?Snk2TW9XSFVodFBmSytjSlBYbW5ORzkzSmlxUzhOTVN2b3VaN0YxSG5KU2Uy?=
 =?utf-8?B?SDAvRVNWbk92WmhpV1JzcW5RaGYrOVhxanNJTFdWUmNNa0QzS2F6VGN1Q3Vi?=
 =?utf-8?B?YzNBUW84dVc1NmlQM2U4RS9PZlFONUpwMXA0RWRnS2FLVk5HMXYwMGZUaGwz?=
 =?utf-8?B?V042RjBENm1RdlM2UDU3dXFZblc2VklSWTZUR0ZuY3ljS2FNTUMwNXIxOEpH?=
 =?utf-8?B?SEZTT1ZzOWFQaWxzL1lOMk9hVnc2eW9ZRDArT2hJak9VWk4rcGI5cVNHMk1K?=
 =?utf-8?B?cHIwRW5sV2hmcjBoU3FZRVdzMGhJckVBdVc2SHJ2UHFxS29NTmFOWEk2ZEVQ?=
 =?utf-8?B?SlN2WGh2UElVVnFlNW4wYjFhMzhCOUFKeTNaeEhvcUpkYWZ4Um54M0tvWDk3?=
 =?utf-8?B?WjFCTWFvanpnbjdFVlp0VFY4cDU1ZEVRaEZqZ1dFdU5NYVFDV2JlT0wyeUhq?=
 =?utf-8?B?REovbHh2OXVoc2NEVHNLblBWdkh0LzVCR01zYXlwZ0FaYjJLUDk0eTNJdGdP?=
 =?utf-8?B?Z3JNTTJFUjQ0Yy9YUFF4aVovV0d2T3JaOVhoM01odzlGb1ZMMmpiVWhySFFx?=
 =?utf-8?B?SkRvWmpyTkRSeGIwUDcyOVlrVUtMcmpEeXIrY1ZHcVFzeTZBbjRkQXZQSmFi?=
 =?utf-8?B?UkpFdkZUb3lTeWpBZXRxdUgwRUtLY1JGOHhQTjJPb1pmMDh6Wkd5S2NzejN6?=
 =?utf-8?B?U2FuZ09GN1MveFB5MlpDTDhRUC9SbHRUR3VoYmJUSDFoU0t4OHk2R21nc0hr?=
 =?utf-8?B?ZHYzWHl0OHVxeFQwRHJEY2FlYXB0ZlhLSXFZK3p1dnExMUNkcWpBcENsV0xs?=
 =?utf-8?B?dEFab0xWem9wekhIRVVST3pQNGtLWlE2UXlkRDFUZjEyNmNhc2k1c202cU44?=
 =?utf-8?B?TTJqQytIVUNlYVo4UHZwYjlBOXExZGxWb1JWNmZwalBkdFNrcHFuWDgyeWpq?=
 =?utf-8?B?R3BwWHhhTU9scm1nVXgvMVRUNUx0UFFiTEkvYkNHajZabWtkQ1U5TUZhNEFp?=
 =?utf-8?B?ZW1ubUZBeTJuUUlkVTlUclE1RXkrMjVtY0Nka3NFOURHRzExYm9idk1lL2NL?=
 =?utf-8?B?amhFOHIwR0VvNldrNFBvQjV1endyOC8vR0NXemZBanF0ZUEyOXcxdVFqRzZK?=
 =?utf-8?B?WGE0NWV1NnpRVDBSaFM5aGJ4RGVXeFdwNGlLNUkwMDAwUnhYVks4YkY5ZDRB?=
 =?utf-8?B?TkJYS3pydEVnMHZsTUZFWmdQNGx2QVlDUFZ5NE53Y250MWFKalRNSmlrQmp3?=
 =?utf-8?B?QVpNUGVreG9VSFY2UnNlcDU0ZXJVSWVVQVhwVXpFYkpnVUE5ejBjcXZTbFZB?=
 =?utf-8?B?VU96Q01JVm1qeFVEWm9RY0puY3dLdmp0V3B4QXNlNlQvNlhraDJiNmx3VG9z?=
 =?utf-8?B?NThZTWRPWFkzYVdIZ3ZDdHpEUGFUUE9haGZTellNTkc0azREckI5cDlTL1dB?=
 =?utf-8?B?RzN2RE1IVzRHTEgwS0hMcjl2ZExsZ2ZkS1pPZTFUYi9oQzlzbk1maXdvZnJr?=
 =?utf-8?B?N0R3cEwvRktFRmNoYWRmNFNBUlhCODhpKzNVL0Q2WGtnTlNQNGkrb0NzUGlQ?=
 =?utf-8?B?T0FEZ2NWOUlIR0xxRUY1U1BuV3Z2bEtBTFB4Yy9nbHZmOWJpNUxCQmZWNTBW?=
 =?utf-8?B?VEVkcFlLRjhmc2puUzdoS2MxTkYwQzNzbmltbDUxQ2xSc2xBQ0M1SVBOcEFm?=
 =?utf-8?B?YU1iNnVXcmxXcUpJbzRjb3VJU3AyMk5MOGVxb0s0OHduVkJNd3lEdXNycU44?=
 =?utf-8?B?cnlyY085OFkyRVhlYytGSzFYZWN1UGpyNkUya0drVlpBMmNUcVVoa1o3ZlpK?=
 =?utf-8?B?REtwZGVHcGE4bStqVWhON2xRWFRkSk5leXZBMXJ1YmNBU1F2OHJYN3M3K25s?=
 =?utf-8?Q?JIfOyGYW/tkEm54QPjXXIcoFf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8edd1a46-eadc-4e44-b7ad-08daf84448df
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2023 04:35:39.1525
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zdG8IsQgti3CGlsy/21EhumFaFr1f9Sq85lhWiDwq29PM6B7CIj/PpEoXfiBnnaS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7244
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Michael,

Good work on this. I've a few tiny notes following.

On 2023-01-16 20:39, Strawbridge, Michael wrote:
> To allow further flexibility in the git hook, the SMTP header

"git" is something different. You want to use the capitalization "Git".

> information of the email that git-send-email intends to send, is now

"that" --> "which".

> passed as a 2nd argument to the sendemail-validate hook.

"a 2nd argument" --> "the 2nd argument".
 
> As an example, this can be useful for acting upon keywords in the
> subject or specific email addresses.
> 
> Cc: Luben Tuikov <luben.tuikov@amd.com>
> Cc: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Michael Strawbridge <michael.strawbridge@amd.com>
> ---
>  Documentation/githooks.txt | 29 +++++++++++++++++++----
>  git-send-email.perl        | 31 +++++++++++++++++--------
>  t/t9001-send-email.sh      | 47 ++++++++++++++++++++++++++++++++++++--
>  3 files changed, 91 insertions(+), 16 deletions(-)
> 
> diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
> index a16e62bc8c..e80f481efd 100644
> --- a/Documentation/githooks.txt
> +++ b/Documentation/githooks.txt
> @@ -583,10 +583,31 @@ processed by rebase.
>  sendemail-validate
>  ~~~~~~~~~~~~~~~~~~
>  
> -This hook is invoked by linkgit:git-send-email[1].  It takes a single parameter,
> -the name of the file that holds the e-mail to be sent.  Exiting with a
> -non-zero status causes `git send-email` to abort before sending any
> -e-mails.
> +This hook is invoked by linkgit:git-send-email[1].
> +
> +It takes these command line arguments:

"It takes two command line arguments. They are,"

> +1. the name of the file that holds the e-mail to be sent.

"which holds the contents of the email to be sent."
Sentence ends and the next one should be capitalized.

> +2. the name of the file that holds the SMTP headers to be used.

"The name of the file which holds the SMTP envelope and headers of the email."

> +
> +The SMTP headers will be passed to the hook in the below format.
> +Take notice of the capitalization and multi-line tab structure.

Always use present simple tense when describing mechanics of code,
not future tense, "are passed". Think of when the user is reading
this long after the patch went in.

Also, please use "the format below."

> +  From: Example <from@example.com>
> +  To: to@example.com
> +  Cc: cc@example.com,
> +	  A <author@example.com>,
> +	  One <one@example.com>,
> +	  two@example.com
> +  Subject: PATCH-STRING
> +  Date: DATE-STRING
> +  Message-Id: MESSAGE-ID-STRING
> +  X-Mailer: X-MAILER-STRING
> +  Reply-To: Reply <reply@example.com>
> +  MIME-Version: 1.0
> +  Content-Transfer-Encoding: quoted-printable

Perhaps this is too much detail and unnecessary for the generalization
we're trying to achieve here?

Maybe the following would suffice?

   The SMTP envelope and headers are passed as the 2nd argument to the
   hook, exactly as they are passed to the user's Mail Transport Agent (MTA).
   In effect, the email given to the user's MTA, is the contents of $2 followed
   by the contents of $1.
-- 
Regards,
Luben

