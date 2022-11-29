Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C150BC4708B
	for <git@archiver.kernel.org>; Tue, 29 Nov 2022 15:57:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236054AbiK2P5N (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Nov 2022 10:57:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236059AbiK2P5C (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Nov 2022 10:57:02 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05olkn2098.outbound.protection.outlook.com [40.92.90.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96AE531DCC
        for <git@vger.kernel.org>; Tue, 29 Nov 2022 07:57:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q+chDXJ+eBW36b1oilq1OHt2NFZI+PAeWxyq30SDnJXKebTTjGK5f9oy+h7Y5e9Iib7fwbjI9v4pPNYcgbeA6I93qzD5qKzsvYd8lj+ldRXwgZbbmbf8s1DLB7c8vbNTe84uUd/ii8Ko9iu+fLm28ewb8M4DH80YmpM8/7L5YWVW+BcmkYMd0bYI7yJq1pQxw+5uxnsLtycHL4Iow8UgsPBK/G1sUE9kg0H+58hpm4gMsJsTlArQz0MqWbkSR3fBgEhEwag+EyS/lMJNSuFebquWJc613bADKtb/hhlxozCKdMk0kcJTN3G50uMYpZOtngYxh+qTPII2y5DS/2lmqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N7rNsxT00SVoHI8J5vAojmtwcMQMt1sAgISb1f2fsxA=;
 b=YQt3XS26rt+CDoJDEHOcYj0AlY1Sg1YYWQGREK4jc73CGHlRPbs9V0Q4qfRZJMVVga4TadTADBZhBYRpTLIDmCQh9OTxctvEwzR37dI7juAPUE4WPqaLJLNmmjX45Up5t3+fGdDDZ5CFnA/LnSCTlw5/q634yGvyFXvQtGjrRkh+W1L3zCjAnshtIJdyORWj/xZehPBn4C89LaRXsBMD9QgYXaNhRrEpKuhIvXzdfxG3uYJTKo9W7uPE2KEQnI2H0uncYxJEUgc5m2tl3X1yT0dzm3yezSNDzyzNK8f5mRAyXzg9CEl6folX7nreqZAgwkfxruC3SInBK+Y2N7+Gpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N7rNsxT00SVoHI8J5vAojmtwcMQMt1sAgISb1f2fsxA=;
 b=hgAzI7weYpCbNbDk3d1dnc/ubTW6Z3bJjGi2Zn3e0k+NIe4Uccp49xew7uGnGh/NX42nbNk4rTEg6ao5JhKAc/XkG8itHmHzdIl29rhJkkz0rfNe69pa69kOv6QqW4mheUTQSzME71MRvN5lJxT/qJ+74DeEXDOlz7fHlPJUtizRhWFtWODsT5c8vkwX41g/8MnY2uMGtClOgOVC8br51K1a6TrGrraTpLbQUz7YZgbopieKbewQP6teijIkcKBjYLX1nviNTtZQqsSO+67BDvScwrPExgW3UiZz+y30KzATsIFjskvStQXs5XRfxb4/zVDUdS4a839nXOowwaIT0w==
Received: from PRAP192MB1506.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:29f::9)
 by DB8P192MB0806.EURP192.PROD.OUTLOOK.COM (2603:10a6:10:16b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Tue, 29 Nov
 2022 15:56:59 +0000
Received: from PRAP192MB1506.EURP192.PROD.OUTLOOK.COM
 ([fe80::49d0:ccf3:d2e2:5f24]) by PRAP192MB1506.EURP192.PROD.OUTLOOK.COM
 ([fe80::49d0:ccf3:d2e2:5f24%6]) with mapi id 15.20.5857.023; Tue, 29 Nov 2022
 15:56:59 +0000
Message-ID: <PRAP192MB1506B74F9BB25061419FA228DE129@PRAP192MB1506.EURP192.PROD.OUTLOOK.COM>
Date:   Tue, 29 Nov 2022 23:56:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 0/2] add case insensitivity option to bash completion
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Alison Winters via GitGitGadget <gitgitgadget@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Sibi Siddharthan <sibisiv.siddharthan@gmail.com>
Cc:     git@vger.kernel.org
References: <pull.1374.git.git.1667669315.gitgitgadget@gmail.com>
 <xmqqedtm4h93.fsf@gitster.g>
From:   Alison Winters <alisonatwork@outlook.com>
In-Reply-To: <xmqqedtm4h93.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN:  [7l38In1VHWwoNxHfjWbYjkaMwzapqJdM]
X-ClientProxiedBy: TYCPR01CA0045.jpnprd01.prod.outlook.com
 (2603:1096:405:1::33) To PRAP192MB1506.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:102:29f::9)
X-Microsoft-Original-Message-ID: <87e6b33f-a921-6706-f037-b02c32297dfd@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PRAP192MB1506:EE_|DB8P192MB0806:EE_
X-MS-Office365-Filtering-Correlation-Id: 78e78cdc-d04b-434c-ff4b-08dad222491e
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rJLiFf4F9T9LM9GclbpPtw4VRX6kI9EiDAbRk8vjV2VarxasOgNLn5Qui6ODT3eweBt/Pta68WucO3kAbKX1aXu8BaoZnB/UEnJI4sXGx+4eaIlu3kyt0iSPVOerHUbXvXcRfTKL9lEn+pvS9eiGVVkjA7mTYDbiqLG/P7k6c+SGc01HBEaCireu5OFON192PtdFVil+yoU1ehLmxJdrZlBCyUXbrUSpcZilIeD65HXSfsOb9Y2dF4+ZB/EnLiIs0+agldA4FS3JZoEEmnfvz25517kSDb3QN/+9LCllIpjt+qH58CoW9VA6+Yn+l5GYUwJ+7m47Rm9a7qQ3wSYtXmv/QsDQOyJaWg1M0uDlqS1k5adLO+FZ2s8aDFIbbIS7F46NLjzb0yAwe79t/w//+teBwnqIncpKiBB+g8C2+4pCyaaoO0F3eAbJioThNrJdsbFbzOxGIrIlbgzjTTironFGuIyE+Y4E0O0fNoZv3uv0hiEi3tJg2G8KVB6Xl+cgmMpYRbZaVdDwepE/vXNU+SIt4f8WYIU+L23tNcN5ZnNFvFvAIbXFpBqHhmf98Uk71AAIBZ9pEiXqqHpFUyUjdQUciRtifGCZgjt37Jy/yajGxtKCKij5FBT/ZmlY3aFZrlTXU7az9cKdnEkh29IQ4A==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZzA2MnlycW5jckFoT3FTeVlDa3N4cll4UVU0NzMwMkJhUGR6Mkl0b2xzQjlj?=
 =?utf-8?B?VURUaWE2dFQyYU5KS05teDUrZk5ZZnU4YlRBQ3JCbW5rUCs3d2tvcGtoS3Ro?=
 =?utf-8?B?L0NnOTFuZ1ppQUIwWUwyV0U3U05GcmV5aEhyelpPZm81Nk1CdXluRWQ2dEcw?=
 =?utf-8?B?eUx4MlBLVGN6MHl5Y1pTVFJQOHcrT1Q3dUJLdDNPUG4xcTlPQmJibTRnQmk1?=
 =?utf-8?B?T1poTTNBRnQ4dy9OQkxwRjhxbFQ2S1hlMXJoRzR2Y2lGdTA4a3VWa2F1Vndr?=
 =?utf-8?B?WXFVTHN0WS92dWZkQThISXhpZTNLeWpOb0dDZmFXWFNKTEtwMStialpNR2Zo?=
 =?utf-8?B?SmtpVUU1aTArVG5VR2xiWUlzNTZQQm84c3F5L005NEhCMERlQVJLWVpKS1pT?=
 =?utf-8?B?RjJ4ZkhoRzBIY1lDVHdQRjM3Q1BXZnlsZVVsNUN3V0N1YTZjdlNudVlMd2dx?=
 =?utf-8?B?ektHR1Y3aHVjWWg4bWtSa1IxOHlsZ0FlcEhTWUdPZXl3WjFpQ0pHbmFhS2xR?=
 =?utf-8?B?WkZBeThsMktRcXVWckE4b2JldnRWOERZeitoVXFPM25DQ2d5cktqZmRTODlB?=
 =?utf-8?B?Wks4VTg3Y1REa3U3VERuODlPeVIwZ3RENlZmc3ZpWjljVUJSSFlDOWZHTlR6?=
 =?utf-8?B?RkVxcnZFVVRmSzBITndqS3hlNzg3Sm05U2lpZFJoQ2VyYWV0RG5OcEFZdzJh?=
 =?utf-8?B?K3k4bWp3ZTRXVFBCQW9FbkQ2RU0rRWlLTHhHbHBZTnpRSzJDRk9tSFgxL1pX?=
 =?utf-8?B?aFVkQmpXQmttYVpoSG4xRFI3bDhka1BXSTA3Zi8xSW94R1dnYTg5eFJSaTY2?=
 =?utf-8?B?SHZIOU9BSXd0MThlSlpKSERqS09oT3FIelV4RG03Y2MwZU1NZkJTV0lURmYw?=
 =?utf-8?B?M08ySTBUSFpVVHFoK0N6YTAxbTQ0c2ROcnBNaFZ6WHpFdzVmUGloU1VYNVJ2?=
 =?utf-8?B?N1dvMjdnUUN5U0RqVTNYSTBrcER3TzdFZFZyRjEzQ3JmeHNEN25zL2RmcW5i?=
 =?utf-8?B?OU9XcWdLU0dGallwR055T0lnZVJOc0NSaGJoeVFLd0RCNkJUc1NXeUlIMTAz?=
 =?utf-8?B?MTlTZEUvbHZBR0dLMXIvQ1o4R2c4eUpvdE9vRkxob2Jpcnl4WXVuSmNLRE1K?=
 =?utf-8?B?VkdqTy85MGRQemdtRncwUzlkMHMyYkNoTUw2TzBTNTBCV0pyWHhLdVg5UG1D?=
 =?utf-8?B?Z0lBZytjbXZGWG4wUjRaa2gxaHAwcTJQMnNPYjZtR2laWEJENEo0Y1VrQ04z?=
 =?utf-8?B?U1dLa2JweVo0QUJxMGpQTGhLWmZpbU1tUTlna0F2ejJDS0pXL3E2WGJwZEU2?=
 =?utf-8?B?dm92b3BDU3lFNWFIQ1ZIbXhFR3FOUzFIc1RuTWkxYnpQcUNzZUt2VVNRejhD?=
 =?utf-8?B?VTZWWVhFWWY2ZVNmU1crem5JVSs5R29RU0VUcGUrS1lMaWVvUVhVT2MwWlgx?=
 =?utf-8?B?bzJSaElRYTBQK053YlQvS3kxZ0RmOWlRK2tOdHhRazBmbmdwNVVqWEFyamtW?=
 =?utf-8?B?Vm5NTTZSYUl2akZUQzlVcDlJdmdXaFlyUEtGeHJZZ2FNRXEzbDdwZDhsVVc4?=
 =?utf-8?B?QTZqbUNFUHNuVEdiQ1NRaFpLTFllc3dKL3Q0TWluNEhvMTRodSs5aWZUS1Vs?=
 =?utf-8?B?clFOZW1GSkw1WlRjYm5GUWFxZVQybmlqclppVnhITzFaVmxMRXE1aFFZUDV2?=
 =?utf-8?B?d0QxdFEvTmFuTDUzMGNDanRDdnc0NnZWYVpsS1RYSkZXWTd2UW1HalVRPT0=?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78e78cdc-d04b-434c-ff4b-08dad222491e
X-MS-Exchange-CrossTenant-AuthSource: PRAP192MB1506.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2022 15:56:59.3307
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8P192MB0806
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2022-11-29 10:38, Junio C Hamano wrote:
 > I did not try to figure out the reason but the topic with its tests
 > seem to break in 'seen' the linux-cmake-ctest CI job.
 >
 > https://github.com/git/git/actions/runs/3570230611/jobs/6001013549
 >
 > but the same test does not break under usual "make test".

I cannot speak for how the changes of the ab/cmake-nix-and-ci impact
the aw/complete-case-insensitive branch, but the failure seems to be
pointing to a test that I have since changed in the v2 patch, on the
suggestion of Szeder Gabor. The variable is no longer exported and
the script is no longer sourced a second time. I don't know if those
v2 changes would change the results of this test, but they might be a
starting point for the other people CC:ed here to consider.

Alison

