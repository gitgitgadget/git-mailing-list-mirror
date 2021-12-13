Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1CD8C433FE
	for <git@archiver.kernel.org>; Mon, 13 Dec 2021 10:24:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242919AbhLMKY3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Dec 2021 05:24:29 -0500
Received: from mail-am6eur05on2058.outbound.protection.outlook.com ([40.107.22.58]:33082
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S245707AbhLMKW1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Dec 2021 05:22:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UdNDmMq9cHZEnoXv1JaUSAirHjwca1TFuc1nB4uY6FqyeZ1G8JIgbaOYIejXAbGUPwulqdC32xuvkLI3q2krjkgjzR3V8T0EAo8+nTMyniy3bnjFenRv5jjGeMv9/IZ9ItvRnKx5I8psFh8zBWAo27O/UAoEfpr4KmzrFG9mwp/cSB1ol16uDz/C4+YQnnIG3Uv6BchfWE8g1fo/RDUYj4IWbnqgiTfFYuHis2ga5Wr6bpuzrBbkpQVOFatt4ILG22aTQMsa00dMPQYOBz8iJjLyA4LXOEGixIxaUmLBKMXWH6VMZ6VZQ8tFZ3LquJX8JpIVAavjpn9BTTDPb0RRsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RdqUVb/uzBJOwZ9DvA9ZPYmBF/Pu62b9voyfQ2Lj99U=;
 b=IU3fji2ATrI9AG+jK9lhNkR+Y19IpiLOenuKMNouMrg8yljURYBasHN/z8PmS5poero1hUd/U+1AcYjfy4T5PiJA86P7X3271bO52rFX29HhZPnXW3ADDUktQ0mSBs17qCA1T0NYzEuGun/s97doQkH/6T7oRXO4xPheB+a4KnxFKWTH+Z3URy8k35SNdmVpmX0mbZJ7NLjNqfqijZOz9TVeQjIv9ABReir/dJtcNElOcxrYDLUdHoTvweCh1xrCAzjNrrzKm7c0SprdgQJSUpFBztYykzZeUWHceaXP21PIKsyf2r0UHCQp53GGNug9FHO6Qc6wHkstZEs715hnwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RdqUVb/uzBJOwZ9DvA9ZPYmBF/Pu62b9voyfQ2Lj99U=;
 b=qn8uFnCsSft1Eciu3jt/0yLbBFT+Jg7WQKrmBVvfPad4OhAyzBR6r5uMUfGIMRzZsTwCDNq1RumkNGH9QRn32kpW165JPa6ANPpZReJ5QHqrCvT9X94vtO2j1XoMZJo/Ovy0wjKX+WOy3j69P04+Cvj68H9PsEz2b8Ko5EjcPKU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PR3PR10MB3998.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:a5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.12; Mon, 13 Dec
 2021 10:22:25 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d9de:b41b:461d:fb5b]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d9de:b41b:461d:fb5b%8]) with mapi id 15.20.4755.028; Mon, 13 Dec 2021
 10:22:25 +0000
Date:   Mon, 13 Dec 2021 11:22:24 +0100
From:   Fabian Stelzer <fs@gigacodes.de>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 05/15] t/Makefile: optimize chainlint self-test
Message-ID: <20211213102224.y5psbojmivlxe5px@fs>
References: <20211213063059.19424-1-sunshine@sunshineco.com>
 <20211213063059.19424-6-sunshine@sunshineco.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20211213063059.19424-6-sunshine@sunshineco.com>
X-ClientProxiedBy: AM6P192CA0079.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:209:8d::20) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
Received: from localhost (2003:ea:5820:600:3e55:2984:f78e:8b18) by AM6P192CA0079.EURP192.PROD.OUTLOOK.COM (2603:10a6:209:8d::20) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Mon, 13 Dec 2021 10:22:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6e3ce832-6d03-4657-17f0-08d9be227500
X-MS-TrafficTypeDiagnostic: PR3PR10MB3998:EE_
X-Microsoft-Antispam-PRVS: <PR3PR10MB3998024397BC7AC68609AC38B6749@PR3PR10MB3998.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JkZ9Lnj258JsOcCRgqnix3ykjQOsHtv/BhIgLr350U8yrrZ87qPIC8ymq2rPdyQ8GSJ0OPsCA4cgCm5Em6dQV867gPQivJLHHbn1JZrfUZaEe0LulC3IMYyaCI49BlLHok5UYUrLifTBLwMzTPeRBiML+BExKNkPRsIaPU8wLMerys1oIVDWHKtDeCq6L3ZhOu+uGW2vaDHaq9YBAYg9SRrb31iZvu8gFvwpH3M4Ame2FzO9LGxnLwQcrOQ5qr8/nRaUVAkJ/cFTZFvwZQfoqsKAN1W+DlrVrgrJdtkK5PsGiw8rT5AFUjonSYz9lWOhFxcbEnw0Ku9Xp282CFB5XeSvLCCyEQneALno2xdcjEz8ktiyRdNlpZfLw/9tE3/OWnSyB579g3TziYL4Q4yG2aaVAgaCr1KV9c7qhjzS21gI1prPoltEtSNxgjx43qYAERPFS5m3zM1CjA0zopQYnw0imF8QScWvhouRCeOcmEMUuU1pwLv7kIcp3Mi2k23g/KAoMgIjtGG34PkyCIyVIe2LDK39t/go5NiPCfLk2POG8RdcUqujzVZzYypddYh91Ohp+mwJv2bHwKAS5xBpXMKVkc/ofLmkXNgKVK9esqwzInlgxko1sakUe8xQU1FzrWTW/hKehhZ3AvlSMFSMbQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(7916004)(136003)(366004)(39830400003)(346002)(376002)(396003)(316002)(53546011)(1076003)(54906003)(8676002)(508600001)(2906002)(8936002)(6496006)(6916009)(6486002)(4326008)(9686003)(66476007)(186003)(66556008)(33716001)(38100700002)(83380400001)(5660300002)(86362001)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dFRGc2g3c0ZwdmtCc2x2UFpSa0U0ZUhwMEJIdXpDTTJQWmtpSURPRDFHUzVK?=
 =?utf-8?B?Q3Q1NGJPWmZTbHU3MEJBMC9RYXlMeTJUMzI3K1FhM1J1R1FMblBHK25rSU12?=
 =?utf-8?B?MzZvWi9iZEhoVExUNHhFWktFalpZMS9SVXhlRU5jeTB5YkxqdFFlTnRoV0JD?=
 =?utf-8?B?cXhxYzk4SlZHTnN5cTBjVlJxVyszdFo5Zm9ROFZ3OXlNV3FBdWRVZnIyWDZm?=
 =?utf-8?B?dGdhN0dsOFNIVTBwSEdxUUhhanpobjA5MnJreUpOOTF0b0FoY3Eya1BsWXMz?=
 =?utf-8?B?WGRDdVR0VzNsZGdXNEx1bldVcURCem5QR1d0QUJ6N21mYXpEQTFPbExFK3VW?=
 =?utf-8?B?MW1OUCt2UnhTVS9nbG9TcUFMV2hhWDF2cDd3WVdraXo2Z0JYUTdmdFFIYytK?=
 =?utf-8?B?SlJUSlRISWJRZWRjbG9NbEhqL1VJK3pIUHZvUC9CY0l1dFBQOXI4Mnhwak5C?=
 =?utf-8?B?WWZFRXdIRTcrYjNBTHh5eEdHTFB2TWNXUURJbE5SakMzWklBYVFWRDFDbUNT?=
 =?utf-8?B?V2xqczRJUTlRVVdKaU14Z1l5S082bU1XbWQ2WnpsaUNRdzJoZHZLKzRST2dV?=
 =?utf-8?B?VTFBZXBzbnprYWRjUDNxaHVMUXMzeFFua0dWOEVqNm1jREpnRzhKUDVTUzhN?=
 =?utf-8?B?OVlvR3A1d3I3VytGdHhSc2R5dHdMT2VyZDBlQitadWxJcFNZd2FYSGFzOHlj?=
 =?utf-8?B?Q1BOaFFrNUU3ZUtEV3hROHJMTXBKeHhjN2oyWmQ3V0NIMkhuVDlXZUNpWW9T?=
 =?utf-8?B?WjF4cDJOOWovVTd6WmYwTUhRWHhvTDhWaXBBT2RRV0dHRWhNRDV5ZEU1RUl4?=
 =?utf-8?B?WjVKdlJhS3NtL1daTGdWNFJvNm12MllMMGx4cGRaNmljM2Y4Y2xrV3ZjeUd6?=
 =?utf-8?B?LzY2Yzd4azBIV2twL0pOYzlwZjJidXNnb1lMZG1HRTdDV2I3N0F1dHk3bXUr?=
 =?utf-8?B?eVJFMmtZakhYOWNpa0k0MTlwVHFRMmYzRWxtUlpIQzFNQ1pPeGhoVjlyNU9V?=
 =?utf-8?B?VFQvdUZwbzk5VnB3R3I2T2NhMExNRnhQcDIxWHVvbmxKNXpRSU9HQ0M2WkFi?=
 =?utf-8?B?S0VUYWdaYmNsUy9pRWVxQkZ3bHVHVGJkV21YeUNoNkxjdFpQanJxbHFVUFFS?=
 =?utf-8?B?SWNtSGsxS1h3VS9sMFplV1VHa2p4UUhaMXhNUk1ieEN2Nm0xZUY1Nmw3NFB0?=
 =?utf-8?B?MWxRTXhpcDlrbVArRzczV3RmeDVKTWlBdWFnbVhEVEhjc2gzTHo1dFhwcXo2?=
 =?utf-8?B?Ni9FQXhWY0dvODNzdmJ1K1FrYWNyeUdNOHhzNkxqSXFpZWlYdWJ2R1Y3NzRZ?=
 =?utf-8?B?MTk1TnZTSHIzeWF1eDJURDdhY2ZzZk9sTHk2ajhvUVphUmJWRk1kYnc5a29m?=
 =?utf-8?B?dWh6ZVg0a2szeC91VkFzQjFWMUVqdm42OFRXTFlqWjl6emNpeG9hVUxVQjBX?=
 =?utf-8?B?RzhIL1QwbWpxc2pCRFdnN2M5S2k5Y1ZIZ3VBQU95ZWNZV2JaWnhFd2lkdDd5?=
 =?utf-8?B?NU56ZHUzMVNpMjlHT3FOcjg2aWZ1T2dtQm9UM1luVmdlSDU2RUhGSHlKZHFr?=
 =?utf-8?B?cHdZQnpiZ25YeWZBOFpaQS9aMW16NlBMd0E2dStOSDJQVFpocE9GL2xCbWxJ?=
 =?utf-8?B?TzZRRjFBcWRWc28rbjZzZDJ3Zk9jazBQcS9qOFhlaUlqT0ZnL3J6Ym5FWnhE?=
 =?utf-8?B?d0dHcSt5ZFNWNyswaC80VzhDVWZkV1U0RENWbnljdGpzVU5DZ2duK2xlYkpS?=
 =?utf-8?B?TE9hU3BnUmhNeEI1bzE0ZloxRFcxL2h4clFOYmVHck5KRWpERUw0YjdRTUFM?=
 =?utf-8?B?VkF5NmxLcmRDcXNSSWw3dVEvdDdrdVlaWlA0K0tSOFY0QjFsZFJKOVYzaHNa?=
 =?utf-8?B?S2VRMmlkQ09xMTIyTFlxM0tBRXoxcG5LZlVaUEk4dU1zeUpKREFyeFlqQW1N?=
 =?utf-8?B?Y0ZNaW5HTkwxdjdGbkxGeEU2N2lOeTFKUjg1eGlNZW9CMk5YNmdvWHljTk9Z?=
 =?utf-8?B?TmN6TTd6RjFvRzQrNUdIQzByTG1CMWdoUTRwMFJSUDhaQzJzckRIcng0S3Iz?=
 =?utf-8?B?YVVIY2JLanpnNGJ6aDNhTE44QXRRSFBHdFVxVlVJUmR5RWhiZ1pNUzlLNDFW?=
 =?utf-8?B?SHV0RUZrUGN2QitpRElQOEtuSWVHYUFzNEsrNXQ3eHpBZUtOdGRqcHFjcWtr?=
 =?utf-8?B?Ym9yUXAvbU4vOHlzNmt5RmNNclA4ZTZWemZidzBid21zc3dqVG4xR2wyTE04?=
 =?utf-8?B?aklKYk04a0ZzMDhQcmJVS1BSVzA2VjNMWlpXczFkUVVudnp6UGR4eC94V1g3?=
 =?utf-8?B?VVlqS0pRaU1jc252R0NXYjN1NUJZejRXWVY4S0tvOUNhNTVTZWt3dz09?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e3ce832-6d03-4657-17f0-08d9be227500
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2021 10:22:25.2085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zBe4knvEYacatCPUDlh5I3+yc2qHAYDB5Ap3s3rXPrRKmT5wGVsv1+FpFqMTIjDu7oT+oYrNwN1eSNkxjBZm8T2e24oOkrh2i0z+P0fi+Ns=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3998
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 13.12.2021 01:30, Eric Sunshine wrote:
>Rather than running `chainlint` and `diff` once per self-test -- which
>may become expensive as more tests are added -- instead run `chainlint`
>a single time over all tests bodies collectively and compare the result
>to the collective "expected" output.
>
>Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
>---
> t/Makefile | 10 ++++------
> 1 file changed, 4 insertions(+), 6 deletions(-)
>
>diff --git a/t/Makefile b/t/Makefile
>index 882d26eee3..f4ae40be46 100644
>--- a/t/Makefile
>+++ b/t/Makefile
>@@ -71,12 +71,10 @@ clean-chainlint:
>
> check-chainlint:
> 	@mkdir -p '$(CHAINLINTTMP_SQ)' && \
>-	err=0 && \
>-	for i in $(CHAINLINTTESTS); do \
>-		$(CHAINLINT) <chainlint/$$i.test | \
>-		sed -e '/^# LINT: /d' >'$(CHAINLINTTMP_SQ)'/$$i.actual && \
>-		diff -u chainlint/$$i.expect '$(CHAINLINTTMP_SQ)'/$$i.actual || err=1; \
>-	done && exit $$err
>+	sed -e '/^# LINT: /d' $(patsubst %,chainlint/%.test,$(CHAINLINTTESTS)) >'$(CHAINLINTTMP_SQ)'/tests && \
>+	cat $(patsubst %,chainlint/%.expect,$(CHAINLINTTESTS)) >'$(CHAINLINTTMP_SQ)'/expect && \
>+	$(CHAINLINT) '$(CHAINLINTTMP_SQ)'/tests >'$(CHAINLINTTMP_SQ)'/actual && \
>+	diff -u '$(CHAINLINTTMP_SQ)'/expect '$(CHAINLINTTMP_SQ)'/actual
>

If I read this right you are relying on the order of the .test & .expect 
files to match. I did something similar in a test prereq which resulted in a 
bug when setting the test_output_dir to something residing in /dev/shm, 
since the order of files in /dev/shm is reversed (at least on some 
platforms). Even though this should work as is I could see this leading to a 
similar bug in the future.
