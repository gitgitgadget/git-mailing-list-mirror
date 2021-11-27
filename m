Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B556C433F5
	for <git@archiver.kernel.org>; Sat, 27 Nov 2021 12:49:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234050AbhK0Mww (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 27 Nov 2021 07:52:52 -0500
Received: from mail-eopbgr10077.outbound.protection.outlook.com ([40.107.1.77]:25088
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234018AbhK0Muv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Nov 2021 07:50:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HVG260xTDwEF67P/GUkByfMmnY9YPyY83hDbCm+Mpg0PrLdr06JgKZEi2re75WGxIeZPnjd5n3Nk9WEQw2TRzbFDK9GHTgtSjVvO5uOPlbFto2kc2370bsULc2gbILmJOEboKWx/X1Fcm61JRNAAlzMtw7zIkMrWCGMgvTc3sfwvhgV4k8waFd1xAbBtGmSEdHvkgHRn9GzclCRqyHfswwe8qsPl0C9UCZFLBZvbItS7vtBiJV8MqT1Rh4rBTwWdRo7BzWbti/KysdwPfLZuqMDsbvxZ/kOd2Oo+Oi5coKpOpeALz51ZMgt/SNODzIuiJE/en46iUODOPkEsP9HIGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=McPw57D2/wT+BOBYCjMlB6G8MDOmgh4N7fgTMkQMxlI=;
 b=Ylr3VcPbFTcFv/NbyBI7o/ECDB2ZnOvJWQNU7FCOOr4bf4ouhplQB+PG9BJZ+Gi/DmQUmM85EbOLC+HqeqFPb3JW2Ab09JmSjN+xKHgxZXn9cBVCzTm62jZBZeJnmtudTkIpVKzJym96FnIqmZsrBKKGXILNM2X67+4roMSfsD4dCGzlE4vrXj57ICGzl33jf7WI7/Zw2V605h3IqYlCSm0hjnA0uRP7/hz8MLuaGu/NS0yJtqYnZONVClwNq8IRBqjyra4OgCDkfdtghn+fwxhp0sKLftGg76wqL/vZOeMJSr/mAhK+tGiz19OKxftad3Cp31B5pA2Bt+fUNdXNyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=McPw57D2/wT+BOBYCjMlB6G8MDOmgh4N7fgTMkQMxlI=;
 b=q0Y37MUKbKQ680ylh/+umYBpA5Cyo0OjerYGqxsy9GJsxXGFgWav5WIy34yccGNGZ3FRemvI3VfUmZ7iU6hDAYAgBKN3ZzmQXydihZ80oWS2dnnr3JA8KgX/Pwl3evizIpSisDNMQTfh06vI8DMbLZLqH/65jSLqYHSlDr+RGWQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PR3PR10MB3998.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:a5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22; Sat, 27 Nov
 2021 12:47:34 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d9de:b41b:461d:fb5b]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d9de:b41b:461d:fb5b%6]) with mapi id 15.20.4734.023; Sat, 27 Nov 2021
 12:47:34 +0000
Date:   Sat, 27 Nov 2021 13:47:33 +0100
From:   Fabian Stelzer <fs@gigacodes.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Adam Dinwoodie <adam@dinwoodie.org>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 3/3] test-lib: make BAIL_OUT() work in tests and prereq
Message-ID: <20211127124733.ulicqyiudur3s5h4@fs>
References: <20211117090410.8013-3-fs@gigacodes.de>
 <20211120150401.254408-1-fs@gigacodes.de>
 <20211120150401.254408-4-fs@gigacodes.de>
 <211122.86y25gz9q7.gmgdl@evledraar.gmail.com>
 <xmqqh7c4i0jh.fsf@gitster.g>
 <20211126095509.weeknmg4p6sx7bdn@fs>
 <xmqqy25a636c.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <xmqqy25a636c.fsf@gitster.g>
X-ClientProxiedBy: AM6P192CA0030.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:209:83::43) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
Received: from localhost (2a02:908:178:20a0:d22:c58d:d0a4:a83a) by AM6P192CA0030.EURP192.PROD.OUTLOOK.COM (2603:10a6:209:83::43) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.21 via Frontend Transport; Sat, 27 Nov 2021 12:47:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b0c850e2-2d00-4bc5-a2c8-08d9b1a41574
X-MS-TrafficTypeDiagnostic: PR3PR10MB3998:
X-Microsoft-Antispam-PRVS: <PR3PR10MB3998A089936E80D0C7F908F0B6649@PR3PR10MB3998.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x3gMR9wEbMQ7UmnAvoj6ZucuFIpddvJH9FMlxUP30rE6EJe8iHwK+ZQkHvXheyZVkQ0UQahQ232IYr6okaMxJY8jT3VD9jSz+G5maCEs1zVyNQ1z3CWgqqvXSxMIulf1qNMlE2YtCbn+ie4mHHK5OgoEjKfGHYO1/ZhXSctXtDuqJlPZm/tZmWTvv2UJPiQ+eLkc6lf8Q3NRiNgPXCML/KeKsX63oZr5EYv+FDkpf4524HM9ZLQUXyyTebyWwqk3PUDLiggQEW/LvRrmZbSSEq6nbjvGPZ4MAlWV1mpHKAFvoc57QG1zOMPD+y0D6anizBlGpfMup1KdmTEavRJOdIT+jx1JxdzAVUTrzowUAzkCMy1Z09Cs2dnDiBcsYMfK/+cIfKWo3Ea6TRucAFmLAHWt/JzOJnacNWRmQuvtl39WNNwIQdqrueykWdQD2vb2kNilWaWPByiZIE3z2AI1nUjdRiziVf36FFtXwdz+RtG5OtMnHA76sz4cj4RXxQOx/j+TR30ZhN6fzYN1T1sm/u/QGMN8BsLIfPgJrX44onPgOc1P2oVyT8Ti9QAbwJjocjSTKVXYDxkOZW+/Yg+lUJ6UTEi9Ka4HQYcjb3nJS/VeDr+myl+Pld+YwSpBsWJUFG8Xa6bwqoB/xB78+KB2Hw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(7916004)(4636009)(366004)(39830400003)(396003)(346002)(136003)(376002)(4326008)(6486002)(33716001)(8936002)(83380400001)(508600001)(9686003)(6916009)(1076003)(8676002)(52116002)(86362001)(38100700002)(186003)(316002)(53546011)(2906002)(5660300002)(66556008)(66946007)(6496006)(66476007)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZXBOQk5xc3ZEOXFXTmFtOWQ3clI0dVhDVWtxbmQyYkxaS0N3bGhzc2RDdkht?=
 =?utf-8?B?b2ZaWXRMZkpCdHVTSWhVYjd0bWNhRE5aS3k5RnF5NjZmaFFKa1ArT0trZ3cw?=
 =?utf-8?B?WTR3MVBsdGNlV0tDRWFtU0ZPSUpGN0NYMEVVdkZVbWk2bFdVTmRSSnZWYmQv?=
 =?utf-8?B?TDZJVGlzeVE1ZGQxbU04Y2RiUy9HYTlBbXhzMU15am9hTTNyNURINkFpYUxx?=
 =?utf-8?B?S2Q3SXJTOUZZNytsUFJzelNIZ2Z6Q3JWVGFXR20wcjY4OWJSTFcybVl3NVY3?=
 =?utf-8?B?cEdJMHNHTURvR3ZRNGw5bEgzSHpaR3UxY1ZRcmp3MjFEd0VDYjBnMStRUG9C?=
 =?utf-8?B?Z3JJcVlxUUhqODFwd0lTSFNBVGVrWHRRcGRMS2lrY0Z6OXljMlNsUlIzMExO?=
 =?utf-8?B?U0ZhYWp2cm9xNWFpSDdhb01KRzMrVjNrY3FmVmZwWE03TUxBazU4cUZmVzM2?=
 =?utf-8?B?d1UvU05udU9PaytrUEJ4TXFCMThBanozWDN2Uk9uS1NGQTZqekxSZVdUbFVl?=
 =?utf-8?B?Q3FMeFBvRHQza0VIV0ZITGJPT28ra1h3dXRrRXhoM3hLczFnWmZmdnFwZUdr?=
 =?utf-8?B?L244emUrbkJGK2lQRTVBUzVud2RwNld2ejlsT3YzTXpNMStBdUxWNFYxYUpr?=
 =?utf-8?B?ZUh3NFNhWmpFelc1MjdaWWJ5dEZNKzNvR043RXJrT3hoSWRkSWswNjRRY2s0?=
 =?utf-8?B?MmNTU2I1MVNWbXd4RGNKbm8zb0U4d1dSWm5tMXZPS3R2VWtFaGdPN2F3RWJZ?=
 =?utf-8?B?NjVpK21vbFpObDZycWRUbnFDZ21rNlRKZHBTUEZmVDhDdzJjNHZRZ093d1N6?=
 =?utf-8?B?WCsva3A2bXl5dWM2eU91K2REVzZwYWxCNXQyWm5YblRGc2FrZHlNMnZwRTRJ?=
 =?utf-8?B?Unp2UTBQeU5MNTR1YTJaS21ReXF0L29DQ2g3djAzWXJyc0owcTVDTk5hRTlu?=
 =?utf-8?B?QzVId1dzODhpWXl6dFhzQVNmdXM0SEhxTHFqMW14Vk03eklrR0JjVnY2WDVU?=
 =?utf-8?B?MkVyOTROZTR3bXF1WG5BT3h6MVhtMnp6VURMck5RcnA1L09IaDcvMmtPY3Ny?=
 =?utf-8?B?VTNWKzJkVDFQMWtiQmRpOTM4Y3orckYxcXBleEx1K1JtaXdydUZnM1AzZS80?=
 =?utf-8?B?Y2xzTkk1L1BLUitQdWRmbmgrVTR4QTN0Qk82MEVKZ3BEQVRld3hzTmRlTTdO?=
 =?utf-8?B?am43VUsvTEEyeVNzbFN3aU5qWG9Ebkt6M2tKbWt4dytEVjgvVHJSSVdUWWhW?=
 =?utf-8?B?Z2w1aHlDUTUzM3pNZEZmU1FvOUFVeXJjdXpjZ2Q1a3BNTE5Zd3k0ZThxRXZH?=
 =?utf-8?B?eW8rNmFJc0NKT3RmOXIyeEJvcGVPaTgyaDUrNW9RakJodWtGTVpQVzI0N3Bs?=
 =?utf-8?B?ZkIrUmdzaU5XbjhUS01nMTVraXlrSUh2ekhBMU1sWURYenBTZGRmRjBLZ0tD?=
 =?utf-8?B?NmpuVkMvRjIzall4V3B0Sng0TFBMSXpoZU5lQ1dnaGNoaWR2a212UkdXTnYz?=
 =?utf-8?B?TG5nZFVKc3R5cFpCK3A0S0RCdSszdk9CUStJZ3ZlNUFSN1B4a2h5amNyaFhU?=
 =?utf-8?B?ZThNZStuUlhPNXBuWHhEeTFFRnlZc2lBWlVYOVhiejVmWEZRQ3E4aFNTeTNU?=
 =?utf-8?B?cmNsYlk1VVZnaER2TDBQdVZVMExVMTc4L2owQnJjRFhiRjROSE52YVB4K0lS?=
 =?utf-8?B?emt5NDhDRCtDZjY2bE0xZ2dKdDdZZ3d5NnU5ZHZySnd0QUJRZXVJYlRVQk5u?=
 =?utf-8?B?aFlIek9LclRkSURGMnlnUGFGVXova3FscWRuUG5tM1pjcE40NjM4RUlGUnpu?=
 =?utf-8?B?UDlnWkpZbElGQUhYMzE0a3RuZmhhYUtxby9rODJDVEhUcjZwYlhicEd3cDEx?=
 =?utf-8?B?TkhLVnJDbzNhdGNpUUtIcUtQL3NGQU5jdjVQNTdibUVxYUpQUGlUcE54ZFpK?=
 =?utf-8?B?b1JUWDhXYUFqK0NVblc3Y0dNWSs1a3hUVUFWT0w4ZG1sME5IWVpXcVZyNkpm?=
 =?utf-8?B?cUdtVWJTVnZKNmJlZU5McXJkMDNXTitVVHQ5aTNheXN3ZTczYm9Oa3FURWo3?=
 =?utf-8?B?cStvbHVnZFRKZW1mN3lnWnBOQTRKaTBNNk9iVWZZR2p5aGJMVzVyZ1RkT1lz?=
 =?utf-8?B?V0NsbDZ6T0ZZSVArYUJNZVVZdjV3blFmN1RjbVZ4OTdIRmlWL0hja0t6MXR5?=
 =?utf-8?B?N2tDb3lsRnBnNkRWc2R2dHFyeXA4TVpnWmFLTXB5b29SUHJpVEI3a0N2ai9I?=
 =?utf-8?B?a2l5blBUM0VQSitmczdpU3VJNW5JTENMdyt6NFZWdklwc0JyWVhIOHFuOEJs?=
 =?utf-8?B?MGpXNVh6MGU1bDQweGl4ZG5Uc0s0dGppTXNpNkpnN2JXaVFNYkN3UT09?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: b0c850e2-2d00-4bc5-a2c8-08d9b1a41574
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2021 12:47:34.4166
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g/9o5agKDZtuXHMA6Psa3aW/oOZGWRyIokqIQV3+9H2XXlhLhK8x/fofZhySXvvyQDH3gbDJUfKn9TIkgd2BSWWV40G93NplQk8WCkra1TE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3998
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 26.11.2021 13:02, Junio C Hamano wrote:
>Fabian Stelzer <fs@gigacodes.de> writes:
>
>>>In any case, the comment in front of the block of exec wants to
>>>become a bit more detailed than just "# Set up additional fds", with
>>>an explanation about which FD is used for what.
>>>
>>
>> How about:
>>
>> # Set up additional fds to allow i/o with the surrounding test
>> # harness when redirecting individual test i/o in test_eval_
>
>This does not quite say how "setting up additional fds" helpss the
>test harness, though.  And this ...
>
>> # fd 5 -> stdout
>> # fd 6 <- stdin
>> # fd 7 -> stderr
>
>... is literal translation of what is written below, without adding
>any new information.
>
>> exec 5>&1
>> exec 6<&0
>> exec 7>&2
>
>I was expecting something along the lines of ...
>
># What is written by tests to their FD #1 and #2 are sent to
># different places depending on the test mode (e.g. /dev/null in
># non-verbose mode, piped to tee with --tee option, etc.)  Original
># FD #1 and #2 are saved away to #5 and #7, so that test framework
># can use them to send the output to these low FDs before the
># mode-specific redirection.
>
>... but this only talks about the output side.  The final version
>needs to mention the input side, too.
>

I like to use the term stdin/err/out since that is what i would grep for
when trying to find out more about the test i/o behaviour.

I understand that you would like to give exaxples what the fd aliases
are used for and I think thats a good idea.  But I'm having a bit of a
hard time understanding the use of the stdin alias. I did not find a
single use in the test suite - but my grep might not have been complete.
Or if it's just there for the sake of completeness.

As far as i understand the test framework runs the individual tests in
test_eval_ redirecting its stdout/err to fd #3 & #4 (with some xtracefd
logic for -x) and passing /dev/null as stdin to the test.  What would FD
#6 actually be used for then? A test lib function being called from
within a test that expects user input?
