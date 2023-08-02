Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30B0FC001DF
	for <git@archiver.kernel.org>; Wed,  2 Aug 2023 06:07:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbjHBGHr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Aug 2023 02:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbjHBGHp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Aug 2023 02:07:45 -0400
Received: from AUS01-ME3-obe.outbound.protection.outlook.com (mail-me3aus01olkn2140.outbound.protection.outlook.com [40.92.63.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E047F139
        for <git@vger.kernel.org>; Tue,  1 Aug 2023 23:07:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XZFCfEyPM+1SMuKe3XdJpsMkLcXXpUyEMAGk2RgSs+kzxAD/454cvqze+pPOYLy5enJ1103N2hNMoy1k5o3O4I4EX6dCx2SP9qxfMMXxgvGVEjj4C3tv3WnwXq9imUQ98O/V/BufmP+RZdJATlz7iXyk011JCviPAD5EZ6tkxeWLU+x7KNB0VoX5ME18hd221Uq+nL+f2//c2MVWifnWGT9ERoD7KwQV5Q6X7a3cGG0Pfa3zJ/CXzbqx85XkWLY2HPUuTJvpxXSQYOXIu0sJZyLqijp9JhYc1HJLnRF4x35KoEZmlaeyFm6+XsW6zBlH1xQy3F9GJ0YgMV6Tm7tHaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ORuFp8q921xkIl8ezxk4Iq4+GqqVN7TtJ/wIWqmtlUE=;
 b=Oj3DNTzsKy83/Wo1HJ7BdpJcOovk5IdecjjKvO3nj+cByPmIM6gRowCis7eWRa5lbKxcSUeJ9B+46fVrpRSVEWUtw3NMURxbzshsprakZHeRlfZveyNEFL8yG7uIovMR4lG/MaO7ZkXU+LEFFp2tvFZgO1HS1GUbyFzCmXHzciR4sb4CoeUiKLuozM619hysXJulJfZvmUFy3dLnrTGMTrZMDhGe/d4SlpfiGIj5/PAVzLxURJ5WjLVad7p4B9h+xDMSwoljIl+3ICbvV3PwMcdqwMfmf59yv3NDj/FI0bQEWpdxBp4M0qSRwJlUGokUKKXljQdkppVoYWe97KsUog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ORuFp8q921xkIl8ezxk4Iq4+GqqVN7TtJ/wIWqmtlUE=;
 b=jYeQtP7ajB1+sETWggRM9ghTGLpVLjh0NRwEFeLXOdOQym9IkhjqWwDA7i8EXl/6Z8Mhb4Dkigjh5q/GVNE/RRfVYqjvX8GjkVOlXQMFOBw9wEW2fV9H9CzrtqWN8FSDmmndCq8a/bqxF0bbUvrZWdonpVl+EpDPsR8CQW0PCJm9kK60fTI/AGUE3JX8x32orJHlmnypobZ0fWw9y5optjX1kHSvk2sxxbMkP2hGx8W3xcoOLPXptMCcDD/+VG/JD9Uyi/zOiswjJgZwltJwmOmztrWs7zaYBGFVKBYQJ/NWDhRpffNoTBwhFE5GZAWa4xQ7QWYLslLESuRYnCyC8w==
Received: from ME3P282MB2274.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:104::14)
 by ME3P282MB3035.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:150::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 06:07:40 +0000
Received: from ME3P282MB2274.AUSP282.PROD.OUTLOOK.COM
 ([fe80::1b3f:c965:e012:b4ad]) by ME3P282MB2274.AUSP282.PROD.OUTLOOK.COM
 ([fe80::1b3f:c965:e012:b4ad%6]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 06:07:40 +0000
From:   Yucheng Zhou <zhouyucheng98@outlook.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Feature request for shorter relative date format in log
Message-ID: <ME3P282MB2274D11DC15DF1FDBBC36C3DBE0BA@ME3P282MB2274.AUSP282.PROD.OUTLOOK.COM>
Date:   Wed, 2 Aug 2023 14:07:16 +0800
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3731.600.7)
X-TMN:  [QRJrjng3ZBL/PiwhI5DXtKelRfH7i2Dw]
X-ClientProxiedBy: SA9PR13CA0029.namprd13.prod.outlook.com
 (2603:10b6:806:21::34) To ME3P282MB2274.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:104::14)
X-Microsoft-Original-Message-ID: <C6D5938A-135F-4421-9186-4880A0EB6CED@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ME3P282MB2274:EE_|ME3P282MB3035:EE_
X-MS-Office365-Filtering-Correlation-Id: 71b10edd-eae1-4f00-87c1-08db931ec6d3
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SD4r2RcnXKaXwERpSMxX48k0cehZ4MB9/BeF0gZbUmo9s07mXFFLo+unA8zdh94igFVm79IPr5H/i5yLFBxB3EY6mffjhlBXGqpC3Ne0ZFKwpazvR3ZjYyAAZ/Y/kez9hDswGcfSKtGR/p+Ywnesk3iUW4jwg1cMGYZso4CoUGYSRDZYs+l1zThh2XiyXvt5Sb4c0HJxKoT24vCU4jFR8naVedQp92ThPN6lTwxrlTymSsLVkdMxPfLk28uuvXbFFnu4Kb2ekavoYy6SkIlWI11HveCmRWYlssUZJcw895eZzId1kV4X7Q6LWmtt4p51UBKwpHiU34VsXyki5E8ejlyQz2amOI2DGM7+CchazlK/NNPkdWuqzw5cKAFBKzRFh9Uzqi/QC0nG1GDJ6iGueZNIs92ZjRJZV++gyyDXsySN1GN3tpQRTbc8WohNz3RHVIL/oggDQng8yYo6qzsbZweCD7yz1/9HypwWype3jxVCzMBnmJBG1uUFn7jodEzfJL66Xpqj8It0pRfpqrzZDYaUhWkx3UKXYxfl90TwYOYcQOtfCl5laLMmlOM+yUK4
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TlhCSHE2MVU3bGJOd1F2MEFBSzU0dDVBZlRGOTdZNWFMbkVUWlFlcWlPaGhV?=
 =?utf-8?B?eSs2bGZUVVlCaVlvS25hdi96NHBjUnRLcWlhTUlTOTRDRVVzQ295ZzhIUUhP?=
 =?utf-8?B?RFk0a1lvMUdrODVGRWE1MUsvSk1GQmUvL25Yb1ltbkhnaEVyUjZWU2UyQ2dx?=
 =?utf-8?B?Uml0cDhFZ0plV2pXeW9jMGxyYklOaW9HaFpPNjJSZ0J3VjN3VHUrejYwVlpW?=
 =?utf-8?B?UWJINWpkZUp5Q0ExQU1sUGpBNDJyazBiRDBib0krcFdGcm1Nek5pUHNrSzFu?=
 =?utf-8?B?R3luU2gyUXFxaGJzblFwWGN1UWpveUhqOHZxV3lsZmpzVi9zYkwweitGSFBF?=
 =?utf-8?B?ZmdnY0w4dWZ2L0p0alN0WnZJc2QwS3VibFVrZnZEdzRyUkpqS0x4bmtUc01j?=
 =?utf-8?B?TzI0eEVNLzdkcEJhbXBJWm5jNENPRHprNWw4b2xjdm5jeEVXRlJUeXNHdnRO?=
 =?utf-8?B?aEo3aWd4S0lNcDNmeGFOZ0dnRWh1YUN6OUd2TWRqMHY2K3BMblJTK0Fmdis1?=
 =?utf-8?B?S2dpUk8xYUNQRE5QVC9nTFRTdWNuc3h3SVFTNzQxTWJmbWh2UTNlYVpiWjY3?=
 =?utf-8?B?TjFjQ295MUpUbWlJTHQ2TVVIa0xtVDkzYis0UzBGL1lrOUdhUWJIK1F2NHUz?=
 =?utf-8?B?bHNtc25rU1NpNmhCR2YxR2RUelpRakFVYU1qbmhwaG9RTjJ3VC9OSFlQUkha?=
 =?utf-8?B?SnhCVHlIalJEZHRsZnVtcnNwWWtPYWh5MFA2ODBjRE51RUl6eWxZcllhZmpZ?=
 =?utf-8?B?OG1TMjFISDVDc0dkc3Jxa2ttK3VGZVJOU1F6bVByY1VKSlNoeVN1cHNMYWYw?=
 =?utf-8?B?UUFxQ3E0RWpiT2l2UVdZWG5LdEZIV1Y3eXRFc0U5NTBycVVOdU1BMmJEaG05?=
 =?utf-8?B?RjdjZythcFBVOStJb3dwZ1dhMUFOMCsvYjhuaWJKT3cwU0QzazRiNlQ2cUho?=
 =?utf-8?B?R2IxUmtkMWxJckgzbTdCR3FDUC9UdmdoOG1DanlUNWp4NjFJb285cmVaVE4r?=
 =?utf-8?B?dDdhbm82UUViS2JEamdhVzNmTXpLOUwxcFVBU2k0UHFQZlVqcEtSZDlEUnhB?=
 =?utf-8?B?V3VCZjRTVXlRdnU3UTFxamF1RC8xOVNPK3NrR0o5N0dJMkRiUTVyYlZVczRr?=
 =?utf-8?B?OGh5djI0QlNyNFJFNzlWakh6L0QvSjVSL1FTaS9vVzM3OEU0S3BsUFNzNENi?=
 =?utf-8?B?R3NSdUs2dWtOWUpiRDBpekhpRk9qdnVkMGFpemJNbTNKUlNmU2kyQU5Wc1pH?=
 =?utf-8?B?Tk9ZV24xS3E2RG4va0dnSXIreG9lTHlrL3RLWCtRMGRLVlZUZTIyazRVeUk4?=
 =?utf-8?B?Yk84VkZGNGFGSm00aGVzK2Q5VHdSSWpvRTdwTThtVTdUejBIRkhJRFFzWkZ2?=
 =?utf-8?B?N09qNHRzdm1QYTI4RlRKbk1pcnEzcHZPa0dsYTJGTnZkYW85dlJHcnltcUZu?=
 =?utf-8?B?ajVXRGI1c3JhOXZNbnM0RUMrT2s3djE2bUNnN01yMlJaYWlwMnJtZXdRdW5l?=
 =?utf-8?B?cDNVMlhkQjhxL1MrUDlOMGFXSnNwMjBQQU5CS0ptanFmVlVqdEwvS2V5YVRx?=
 =?utf-8?B?Qi9HOHJFcTU4NUdoS3dzQXhveTltc21EbGlaUCtpNHZWWG1vMlA5U05zaUpt?=
 =?utf-8?Q?buVnH+tdYQgZ74rDsuErf3l++S29H8w4nr+MLsBstfY0=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71b10edd-eae1-4f00-87c1-08db931ec6d3
X-MS-Exchange-CrossTenant-AuthSource: ME3P282MB2274.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 06:07:40.7877
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME3P282MB3035
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello there,

I usually use --date=3Drelative in git log, but I find it can be shorter to=
 save more space and be more efficient.=20

First, the trailing =E2=80=9Cago=E2=80=9D can be removed, because it seems =
every relative date has a trailing ago.=20
Second, the seconds, minutes, hours, days, weeks, months, and years can be =
shorten to a single letter (e.g., s, m, h, d, w, M, Y), and the suffix =E2=
=80=9Cs=E2=80=9D for plural can also be removed in this case.=20
Maybe it will be better to give us a way to customize it, or create a new t=
o config like --date=3Drelative-short.

I apologize for any inconvenience since it=E2=80=99s my first time to use a=
 mailing list.

Thanks.=
