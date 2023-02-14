Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62F2EC05027
	for <git@archiver.kernel.org>; Tue, 14 Feb 2023 05:50:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbjBNFuA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Feb 2023 00:50:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbjBNFtt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2023 00:49:49 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12olkn2036.outbound.protection.outlook.com [40.92.21.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD18C1B573
        for <git@vger.kernel.org>; Mon, 13 Feb 2023 21:49:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PyEkC1LOWId7heALZzSek3kA7FeFABfYujGJHZmsX8lfybzlzHgMUwf8z9zb0qlbzhBLDegEzQiO0dqHeQks/6Lggf6LEca12kfyhEjt9tcZwTp5XSX2MDG8tRU7wzfYw/WtR2nQLKFO40wfmJxN32/uSMEKzX59RzKWBQjT5/Wy32E+TRvQ5CnlaqOYfaGfy3W7UOqzAMl2427iV8mR3STckcrhThVXBNnITGUgKMEKgTK4Wvw9ULUa6n01kCZ+cKQQxUbXXiYlSdzElpF0e4Mbcb+YQEe/FhRF/vE1c7W4Et4ckt4OGXxSqUh9+rp29H5wqu9+ozT/PH2W34NZBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tow+fGEXW+9fuK/OfNW/Q4pXV7jIbdfWCa2cDp+JmP8=;
 b=aeNR2k/R5qz4N4x1THXPg3GfGj+YFpgX3cA69x3hchyaJf4mc/Di4IqiKnyh0N0p9t9DydvaYRd6whwzgeMd3tZBJQz/JVp1lSU3ojLqFpO3JvBWB7SjNuuDGFwLuR/kuvLgVgFvNRUYMFXRZ2dNaWxMzWl4IAjsRydfv2yl8kgbmPjr1kPi4DhurKSUR/ghiQc9hA0bbCOlofab745VawafYXzzHcQKQ7nl63dQnf4JiqnZZA24GXHicLF2YXb6dqeDFH9XB0zou5JDLtArmTAInTdwL/liA68m6hErWMKY3dl8o08anl6TB4/bn7T/lw4nE5P96NuQbIBVENPzmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tow+fGEXW+9fuK/OfNW/Q4pXV7jIbdfWCa2cDp+JmP8=;
 b=mezJ6Vxww9s15wNn5LcxL+mbPZAn8C4KEWhc+tqN1C3ZhtCjgPpQ1yA5LzgOU57ZKROQrcl88r4dZLi8yZN812VguMlexPoOA0nQEx1R5uE9EMxu5tJqGG/k2DDGqwvMJk02rreCK5AkZb2YLZ9AioiY1CRGuj5b+nw8+zkGSJmqzferwhsE9FTunJyHV5H7dwk40GiJjhnpLlpgca6wIHdFB3BFvySpok4c2ajWP1hThaaRNkkJpc7CUYw4GQ3x07z2S0Nnklz5kHy6Jilxze8Nxo6WroZpicv4ZOrjcRptn9bL3u/YEuq1gC3xtZ7IH2uMM+RJeFNwSTP35wUoZw==
Received: from BY5PR14MB3560.namprd14.prod.outlook.com (2603:10b6:a03:1d4::16)
 by CH3PR14MB6250.namprd14.prod.outlook.com (2603:10b6:610:140::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Tue, 14 Feb
 2023 05:49:43 +0000
Received: from BY5PR14MB3560.namprd14.prod.outlook.com
 ([fe80::e468:409b:bfe8:4a00]) by BY5PR14MB3560.namprd14.prod.outlook.com
 ([fe80::e468:409b:bfe8:4a00%5]) with mapi id 15.20.6086.024; Tue, 14 Feb 2023
 05:49:43 +0000
Date:   Tue, 14 Feb 2023 13:49:42 +0800
From:   "L2750558108@outlook.com" <L2750558108@outlook.com>
To:     git <git@vger.kernel.org>
Subject: Git Gui error when clone
X-GUID: 7B0263A1-5AD5-4A4E-B83A-E2287C699A6E
X-Has-Attach: no
X-Mailer: Foxmail 7.2.25.178[cn]
Message-ID: <BY5PR14MB35604D33DFE7565A19932CBBB1A29@BY5PR14MB3560.namprd14.prod.outlook.com>
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: base64
X-TMN:  [uEiIVczFZdvvprG6kBYnCNb1KK2aPZycGVff+inWxuI=]
X-ClientProxiedBy: SG2PR02CA0019.apcprd02.prod.outlook.com
 (2603:1096:3:17::31) To BY5PR14MB3560.namprd14.prod.outlook.com
 (2603:10b6:a03:1d4::16)
X-Microsoft-Original-Message-ID: <2023021413493589526311@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR14MB3560:EE_|CH3PR14MB6250:EE_
X-MS-Office365-Filtering-Correlation-Id: aa10c6b4-4bb3-47ee-7536-08db0e4f4540
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ihCwDIjv4DedYkxEFmweqcf9BmZBmtT+FkRfTSLTC2o+n0vQCj91i2VS/eAINdZUbmxBPcW5SbBcY/TFHesEm+8g+9yH4+zbQM3KcQU6dE6Frs27WfcVCSrgVRX1P82dyL83pqJH0Q9DnkRvzjsT1/OkWkGAa1JEwH/zNZZdkk4e3awjVz8jGgJdoD+4BMBZXw8m/pZOyzfCf4iTO5Kri22qVijJHk9XbI6Xy0e+Fya8p0P4vyxO5gGYPRN/2giNxaZByeiorqKC+/S2PK9uqKQlCOibL+0yvy8t3wkjV58gSaiv+jjHKlmaA23lWzH5+ctFfggMY2CjY5EJAYQsNmMUMJ8AIslfHzO4VbDcyoaCiKO+wSJIs0BLjtYIRW/nKKOqAw5iUF4jPyxjS7nyj7Lj9sw6C30wsc7Dm/vA2AOFkKFmclXjlDuGvrOPbQmyp8Nn7oSIt7wefKo8/oMmbaXG9i3g9nndbTNLQ0UviDDiw0N8v1xU4P2hHEQ3Qq8jAONDRl2NcwkunVZMK0NiGYTsexPr157rmZIbOettMbRpPJPuxUeEEUHOKnS45PcJetr9Akku5CkS7jAryxLXsVCAQK/k4lyzQEhM8Sin8qA=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d1BpMEY4azhZaXlCaGtwOXQrb1JWVG5MRHRFQUtET21OZ0x1ZWlhVHhGNnRk?=
 =?utf-8?B?OU9UYkt3VVpOTXJmRk1Fa0VBdDEzL1FpZnNIZXRSbkd6MGJEVDdqWExvYjRW?=
 =?utf-8?B?S3U4Y0dJYy9EYnIwVEhKQnhJVFBKOUttaEQ2azk3SlI4dFR0U3FrMFFkY2xM?=
 =?utf-8?B?TTZScVNqS01zWkhEM1B3Z3hwS3ZQVUlHNWMxdTlhdml2endGbktFa1RGajcw?=
 =?utf-8?B?OWw5WDUzNHloZnJEQVlYdUVKdFZuajd0OUpoTDJIM0FaekdmTEZjL2NwN2Mv?=
 =?utf-8?B?K3ZVZ1JYRHZFd2IvZDB5TkhQZmtZVFYzNC9zUWhzYkJDbjFPVnhaVjNzYUpY?=
 =?utf-8?B?a0l6SHVaQ0ZGWGdjQlhKc3hSVElwS0dFZ3Z4RzBRbUdTcmlxbVFYTXlXT1VV?=
 =?utf-8?B?NkcwejVnaHYzT0lTRDNBK1NVMFluS3hzL3I3OE1RUWN5NlhjWE9IbEV6L1dj?=
 =?utf-8?B?SUdFM0JLb1M5cWFxQ0cwVFhkTEtLdThRdWY5ckRFTlZhNnBlWmpXazlBeWFI?=
 =?utf-8?B?ZWwrOGQxZUNleDFVM29UQ3BZdWp0clVvVmJETmpXdUozbXJLV1QwcVBQV2FI?=
 =?utf-8?B?TFFBLzJGcElrSW5JUjJlQ24rTTdHdDFEbjBDM21VNnRkRUt6N3p2SWdFc1VG?=
 =?utf-8?B?TStBZXlkM3M4WU5zY3hFNDQrN3hFOVQxM3FhWFllb1IwQUxRNjZXNXc4aStT?=
 =?utf-8?B?clk2dkRnSjZvd0JGcGQvaFZUT2xDQUd6TWJwYjNMNXduVkhHVkthZURzY3VO?=
 =?utf-8?B?a1gvUXlhUmhNOGJTazdQcEVhMVpLWUJpVnViOWxaMjBhY2Y3UGZDeHczMU1L?=
 =?utf-8?B?dW1OeWNYT1VKT2VJVkZXWHdiZFVSRVQyZjhyRUgrdkVLSTRSTlJyUTVXVE01?=
 =?utf-8?B?YzNWMjlndmpBZkJCcWM0N3VndU95QUVxUGZya0daL256Rjk1Nm1nOU5hOE1Y?=
 =?utf-8?B?U2tWZ3lpTUdUc1dEbFM0WkM4RkwxUFRVVytzVFk3UytueUx0bWd3Zms3blNK?=
 =?utf-8?B?Y1NCSVl1RTB0R2FRY1lMK1o0MXVzRWorMXdGQkRvYWtmQ3IyNmVYeGlvWld6?=
 =?utf-8?B?bU1sTU5mbklBS2orc3JyQ2p6cTYwRGJId3hFMXVkY2lxc2hiaFE3d3h3UEhU?=
 =?utf-8?B?NDZnK0tQcThXSG9wNE9ZNVVWVHNZRWpqejQ2Q2VaMFFFVElDWmJXbmlXTEVp?=
 =?utf-8?B?WEpmZml0ZE5jVGtycGx6VFp6UHlSTmV6N3hLbVYrTDlTZ3MrQVRubGF3MjJH?=
 =?utf-8?B?Z293RmIrbUZEdU1HQlVKWDBGMUpzd1orUk9jSXBzZlNtWk1saW9PRU1acGdy?=
 =?utf-8?B?dXFmczNaeTVFOUJWZ1BORk5JUlVXL2tpWGZOUmswdnNXQUJnK3U4dHB2VjNQ?=
 =?utf-8?B?YWJMekk2UENyZGVTeWdrWkpwd0NneXJKTkhXSzBXczJZenh4RjRmd2xzWkFw?=
 =?utf-8?B?WnN6anRsRTdUR2ZQRGhINGJtdUxiR0VDL1l1STY3RDFRbFFsY3NXL09oR3hn?=
 =?utf-8?B?ZS90djJROUhlTFF4SnEyVzN4L3dhQkRVUmhvUGJHSHdLaEkvTG1ENFpmb081?=
 =?utf-8?B?aG9RY0szU2FrR1A4eHEvSlZMaDc5R1p3bldTVVREbFR1bXpZWStNRHN5VHFR?=
 =?utf-8?B?SWM4WDZvWm5jSzlsUkNobjYzemVzcGZTcDdsazcxZ1dSOW9mU1l5bTJuV0NE?=
 =?utf-8?B?b3dPcm5UQUMyUXpwQ1lIMjlLbUY0S2ZleDBpQmRxVDYrZEJMeExsQ2JrbnhN?=
 =?utf-8?Q?IAQqYPRXTOq/hdvBuY=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa10c6b4-4bb3-47ee-7536-08db0e4f4540
X-MS-Exchange-CrossTenant-AuthSource: BY5PR14MB3560.namprd14.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2023 05:49:43.3395
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR14MB6250
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

V2hlbiBJIHRyeSB0byB1c2UgZ2l0IGd1aSB0byBjbG9uZSBhbnkgb25saW5lIG9yIGxvY2FsIHJl
cG9zaXRvcnkgSSBnZXQgdGhpcyBlcnJvci4gQWZ0ZXIgdGhpcyBJIGdldCBhbiBlbXB0eSByZXNw
b3NpdG9yeS4KCgoKQ3JlYXRlIHJlc3Bvc2l0b3J5IGFsc28gZ2V0IHRoZSBlcnJvcgoKCgoKZXJy
b3IgbWVzc2FnZToKCgoKaGludDogVXNpbmcgJ21hc3RlcicgYXMgdGhlIG5hbWUgZm9yIHRoZSBp
bml0aWFsIGJyYW5jaC4gVGhpcyBkZWZhdWx0IGJyYW5jaCBuYW1lCgoKCmhpbnQ6IGlzIHN1Ympl
Y3QgdG8gY2hhbmdlLiBUbyBjb25maWd1cmUgdGhlIGluaXRpYWwgYnJhbmNoIG5hbWUgdG8gdXNl
IGluIGFsbAoKCgpoaW50OiBvZiB5b3VyIG5ldyByZXBvc2l0b3JpZXMsIHdoaWNoIHdpbGwgc3Vw
cHJlc3MgdGhpcyB3YXJuaW5nLCBjYWxsOgoKCgpoaW50OgoKCgpoaW50OsKgIMKgZ2l0IGNvbmZp
ZyAtLWdsb2JhbCBpbml0LmRlZmF1bHRCcmFuY2ggPG5hbWU+CgoKCmhpbnQ6CgoKCmhpbnQ6IE5h
bWVzIGNvbW1vbmx5IGNob3NlbiBpbnN0ZWFkIG9mICdtYXN0ZXInIGFyZSAnbWFpbicsICd0cnVu
aycgYW5kCgoKCmhpbnQ6ICdkZXZlbG9wbWVudCcuIFRoZSBqdXN0LWNyZWF0ZWQgYnJhbmNoIGNh
biBiZSByZW5hbWVkIHZpYSB0aGlzIGNvbW1hbmQ6CgoKCmhpbnQ6CgoKCmhpbnQ6wqAgwqBnaXQg
YnJhbmNoIC1tIDxuYW1lPgoKCgoK
