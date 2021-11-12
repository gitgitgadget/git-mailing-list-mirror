Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C2D1C433FE
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 16:01:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3994560F5B
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 16:01:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235299AbhKLQD5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Nov 2021 11:03:57 -0500
Received: from mail-eopbgr40041.outbound.protection.outlook.com ([40.107.4.41]:18436
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235269AbhKLQDz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Nov 2021 11:03:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZyeqYSCKJgCrkaw0oTVFlLnexgDBHZe58DX/OSy3gvwi+VqrmE9IRWQOVVES8pAsSAd2ypfFYCpOSftjXr+dxbm9y6ICVymZ24PUpRujW1DjeS9AH4ZwC2HfgodKlK31an2HiG9olsDjiFCogjzwR4NeLccdJa1gQGefF75FU0Y8NONu3/NtJpTiJbSiyQGikvaxx6WCx+x32WJT88+aeMP1tjUrIocpHlWWIzLkB4JQl82t8/4WTPjFjRJDVQtxRMVFjOkDfrqTBcVry64H8saNpRElzFm4T/6V6NLUlSwNsgy0xs3vshUblhBXbGQjpOo4uoSy7/r5DGW+/TS9kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pqdFZzy1IHlXAcn/1VvamsgljM1SxRoefEXzmNmWhP0=;
 b=IWJYJbRattL/C6mhLEh+UBLZ0W27mAGWpwjM9QR2+rJLv6yNoRa2O0qZFa0nJSgqo+1S4bQL/bhleLx06lfjafIULccSzfKqGTnHjtX5/0ohMf4m0byb62p8ifio/Mdhl+7oZtIYCsqqjOZUAIo0K751XnbKOvgX00jlRbvzgft6bo4ZclaLo/b9BThuCFr5gUyOvmeuhQazWUqya0md8DsrIhwBcq7Pl1tc53H3TuXp+pvpEu/PmAPla8Fi6NX/WE/jDcSQa6sOUiPGi9IJYxuBJhFIkszRxzK7aXMSyy1do8b/LjibW3vuiHWvF/mkzIpL1Cc5dsc3eMlGsLiW8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gigacodes.de; dmarc=pass action=none header.from=gigacodes.de;
 dkim=pass header.d=gigacodes.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gigacodes.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pqdFZzy1IHlXAcn/1VvamsgljM1SxRoefEXzmNmWhP0=;
 b=d467DMypcfDa3cX5WJR+nXf/yeeHGgR0v+gVAD4nKrWo3RlHzQ3+CT08DQusB27LjU2Urzc2IoyVJoIdfARTn2NxdpzLbtpjM2PO5uwoscNva39PNHgsflf3xr6PaLRsDTwu0qjJDqjoHS65Ecef5sG7+QHfURHfZXI1KUrVcQ8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gigacodes.de;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by PR3PR10MB3756.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:4a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11; Fri, 12 Nov
 2021 16:01:02 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f9d5:61ab:5756:b391]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f9d5:61ab:5756:b391%4]) with mapi id 15.20.4669.011; Fri, 12 Nov 2021
 16:01:02 +0000
Date:   Fri, 12 Nov 2021 17:01:01 +0100
From:   Fabian Stelzer <fs@gigacodes.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Adam Dinwoodie <adam@dinwoodie.org>, Jeff King <peff@peff.net>,
        git@vger.kernel.org
Subject: [RFC PATCH] lib-test: show failed prereq was Re: [PATCH]
 t/lib-git.sh: fix ACL-related permissions failure
Message-ID: <20211112160101.xm7xi4474pgybrh4@fs>
References: <20211104192533.2520-1-adam@dinwoodie.org>
 <xmqq7ddn3dlt.fsf@gitster.g>
 <20211105112525.GA25887@dinwoodie.org>
 <YYUeKt0xQm/6QT+w@coredump.intra.peff.net>
 <xmqqk0hmxyw0.fsf@gitster.g>
 <CA+kUOa=vqFNXe2QKc8K31OLL0zkEsK7wAk6hPMxjQJNVM7PsGQ@mail.gmail.com>
 <xmqqv916wh7t.fsf@gitster.g>
Content-Type: multipart/mixed; boundary="emckqdvape7dnb4c"
Content-Disposition: inline
In-Reply-To: <xmqqv916wh7t.fsf@gitster.g>
X-ClientProxiedBy: AS9PR06CA0168.eurprd06.prod.outlook.com
 (2603:10a6:20b:45c::20) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
Received: from localhost (2a02:908:178:20a0:d22:c58d:d0a4:a83a) by AS9PR06CA0168.eurprd06.prod.outlook.com (2603:10a6:20b:45c::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.15 via Frontend Transport; Fri, 12 Nov 2021 16:01:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: df8ff518-a31a-41d7-3c61-08d9a5f5a052
X-MS-TrafficTypeDiagnostic: PR3PR10MB3756:
X-Microsoft-Antispam-PRVS: <PR3PR10MB3756FA775F8281E21AF4ED1CB6959@PR3PR10MB3756.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tFxjeKHMT4z2d9E5hJmG3AxAj7J0i/s7SKp4zQaAP3g5JNq7bRh9vvcDyoqu3XIc1EHTNHZrWnGHFNNfl0/TpYWytbtnxIVfLA9G/0XtTADL+PQlhGuxwkG0+Xd6cls9Sv3Z4UeB8Q6u1j1Sz2obMF43wmxqZMawG3YNGVYMFkSfq+PFUEgg4aCvkvccb+JB8tDfFJYZRO09S0HkCuB+EdrXk6C9sa8rF6Cqao9FJkgbuaWso0V486MnecKav/S3pEyv7LZ/DBNKIeJtQTnE6SsNcx77ZXPqcTFjOUGJjaa3xzI4Jh/ElqNzHdKv+YuWDr61197jonivh24UiGFE2+t8LMtN22KWnYG1sv6a3U6fAtlFRMpNcgEetshMk64ngvO/ivhHTHHHe1Uja/ALgeNuJ5wd9xWEyQjaJ1HyAHcP8LYpazOyp0+kZKJ9DCKLoDjDkNT5CXW5mYwBoPzbE6f0BG4Q4ZV+wWjErt5HUcjJkgkIzh4Pxpunv9UepOlfUH/8MjNB9BOA2k5fU0ifPVcBEv62+guzjuFET2gWjSMKyDxoaa4rVzQGtKB/CTmRZXSEP5PA/RaYt+HJHTG3clZtfzccFpRQWxkBfypaDiwlUHzSW66l61fa/rbbPlvAsJPsaKWcAYJqXBSOvcCGK7av5JEIWe69FkUPYAmDjvamx1dQK7wlb/F/0CRkMzS602ETB7zqOTZsLSxL3fHciw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(7916004)(4636009)(376002)(346002)(396003)(39840400004)(366004)(136003)(83380400001)(8676002)(86362001)(5660300002)(6486002)(33964004)(6496006)(2906002)(1076003)(4326008)(508600001)(38100700002)(52116002)(8936002)(53546011)(6916009)(316002)(186003)(54906003)(66476007)(33716001)(66556008)(9686003)(66946007)(44144004)(2700100001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RFMrQmpYVFlvaEU1YnMxMThMaEdDWnY1NnB5dWUycUZ3SXh2ZWFuc3pyOWdq?=
 =?utf-8?B?WU02UGxKaXNjV083ellNbnp5dy9pbDJkcVJoZDdPSVJUSzF0VVBPdFZpRU1w?=
 =?utf-8?B?MkpnempncFVUUndDOUdTYnJBUGNPaHBKOG9YUWxFMFlFaCtoVFBtQTFpVHhE?=
 =?utf-8?B?cXVBYUFhZjZXcXpuNWl0dnlxYUs2L20rWGx2S1FJWGFTUWwrRlE5QTRVZm95?=
 =?utf-8?B?dkVPWUJISlArRHJEUWJSMTh1MTVpTkRpZkZNL28xSlVxY0hyYzFweGpRWG9D?=
 =?utf-8?B?Q0hjWHVJOFZXaVAvZjNWdkY0Z2F1d1pVVWVQSlV4czNiaU9JSitacGlWdnd1?=
 =?utf-8?B?cDhERkFybHZiNkY2OGxKRm5SUm9FM2NTVlRiU1VIQ2NBSmthZ2x1U3ora1dT?=
 =?utf-8?B?Nk5NZUFXNmZsbmRvRndqaW5IdG9jZTJXWXFwM0kxdzI5VEFVWkVaS1lTMnVr?=
 =?utf-8?B?UTdYL0czc2Vud3dNaGJoeGtaOFl1YUt1ZTdMKzRKaDZvckR2dUhSNTg0aHJo?=
 =?utf-8?B?bHM2aFFsOFV4aXVtTjlEVU9FWFI2TzBMN213bXcxRU04T1FEbjhDUWdGZFJu?=
 =?utf-8?B?WWpWSXF4RmhoL2pZMklwemVmWVBxVm5iSGd0ZXZKaHMrTTFFcDNvV3JtUVpk?=
 =?utf-8?B?WWJQMXVPVElseDAramRWZ05NcFZtNWNQWDNVR0hrakwvVzFWbFM4T2ozR2Fo?=
 =?utf-8?B?VnNPWituOHZtM1VacVg0dWRhdzRiSUNjQ0JyaVowYkhGRHc4dzlwUk8vQm4r?=
 =?utf-8?B?WkFpSHErY0NDRFhiQzgvTUJVTnFoOXRiVVE4RytoTEdzRXhueWhBV2dsZTdn?=
 =?utf-8?B?Vlh1cVB1RHU3OHVnclQxS1kwSzhNbFAxTHZpalAzQUVrNVNJVEZMUm9nWTk2?=
 =?utf-8?B?RkloVlhhQlQ0N2xEaWFhZThjUlduZEEzRVhGNjhqUmNOUTFJQXFQOGhlOHMz?=
 =?utf-8?B?VnpsT2ZrVmFmYVVic0RBanliN3I4RDVDbWdsa2poT3RZTEVZTzVuZlBZQzN2?=
 =?utf-8?B?NllSbmszNHBlRmdRWXBQYmFjdkY4QTRwZHlCMzVrMW14Z2JNR3kxZ2d2alNL?=
 =?utf-8?B?cFdUbis2TUtyWTk1bVE4UlMrTmlwZ0xBY2toMjJSQmE5NFhubG9VcGJOek5z?=
 =?utf-8?B?dUJTQlVTQUQ1N3N5Y1puZDFVQVRrZXNaRi9rZnpDREIzY2JicGEwUDQyRk55?=
 =?utf-8?B?S1Mzc2xEdmNOM2JoL2ZOQk1wbkNwRXE1bzFQcW44bE9KbHpSZEp2QlRDTUlw?=
 =?utf-8?B?K2MrTS9FY0VIZXkrNFVmV2lHVXFRaW9MdDRKY3BEQmpLWlhmWXRoZjNDMnJ4?=
 =?utf-8?B?c3o1ZEJ3VXlzWEN6M1BjcVJrSndLY3lyYTJBMGRxTDJwbklyVksrc29yV2V2?=
 =?utf-8?B?YURMMFV6YmNnRjF4cjE0MGczdktqOHV0MGMyZGs3RCtWaGU3czV4QzU3c0NN?=
 =?utf-8?B?dG5zaGVLS2Q0UksyOVdCWlBKZkxOVG8xU0k3Qyt2MnFualg3Z2lHR1FLaE82?=
 =?utf-8?B?ZXhSYXR2dnhSTm1GRW9XczFzWjc1eE44TUtlY1JXczIwQnJXTXRLRm55bGQ5?=
 =?utf-8?B?TnBZRG9oZEZLUHd1eFlmZUp3UG1NS25CQ2UvNG1qMVc4VnR4RGhyKzdGMnZk?=
 =?utf-8?B?aDd6WEZtSi83OG5wOHppaTJ3d0tjY21tTC85VERuUmhvOUM4eTV4T3BLUDNI?=
 =?utf-8?B?VENwNjlFaXVCdURNYmZqTWVKQkV5a2huMEZ5Y2x4d1hYMW1OME8rdnpaZ0l4?=
 =?utf-8?B?ZXhRekliSjFiaC9rRHUxUmFSSGZSUFFWVHk5SkdPa2xaYkw3UCtzSXpLUm1X?=
 =?utf-8?B?dVBvWkw4ZVV0OW9Sc0Fla2t1L1ViSmJ3TkZuaG9ZbjJCOGpjZ1cyU3hjVHZ0?=
 =?utf-8?B?aGppaTFqRE5OVkIxRjd6WkpPYWVsbEVPdVEvRlJYQSt0UG9JbXNaM3FSRXU0?=
 =?utf-8?B?THR2QjZhS3I3RVJLblFHbjkrR1MvNWlEOHNNaDArRldNdjh0VlA2MjdMWFBm?=
 =?utf-8?B?d3A1L1FyVnlidm45cFVjT0JwakVOUDhkT3RnSGhid3JaRVFoSVpoY3FQZ2Nn?=
 =?utf-8?B?alFQRGpSNjJ1UmExWUkwZy9Jd09qdndhbEdJTlo4N3ZJeFJyU0FUWFFaR0h2?=
 =?utf-8?B?dDhiSW9pYWh5RE5qdGgvMEZ5S1RSdXR1Y2tHMXdKeE15RmtrVVRGVXU4YmJv?=
 =?utf-8?B?eVE3OXl4ZDZZR3JTTmN2M2Yrc2JOd2p5WHVxVlNUZFpCM1E0Q2NOV3kraXkr?=
 =?utf-8?B?WXV0SGxwa0pELzQrd3haQmRTU3cyMlhiQ3p6cS9CNUErcE5EZnJWU1MvU2hy?=
 =?utf-8?B?MEo2M0ZrMk4zaGVCSExQRGxiUmRUV2tuMnJtU3l4MWhxNmxMcGkvZz09?=
X-OriginatorOrg: gigacodes.de
X-MS-Exchange-CrossTenant-Network-Message-Id: df8ff518-a31a-41d7-3c61-08d9a5f5a052
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2021 16:01:02.6483
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 80e41b3b-ea1f-4dbc-91eb-225a572951fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BWEFyKSvmv+gMhUchRsEQaVHiZQ9eC3kXX951IbcHpf437X0CJPRF5kZ0712/GyMYYmu1Y0IHEMhrxkUQHmYvLoPg1hoO2Y0q2yiuKO1GzM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3756
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--emckqdvape7dnb4c
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline

On 05.11.2021 12:11, Junio C Hamano wrote:
>Adam Dinwoodie <adam@dinwoodie.org> writes:
>
>> This is probably a much broader conversation. I remember when I first
>> started packaging Git for Cygwin, I produced a release that didn't
>> have support for HTTPS URLs due to a missing dependency in my build
>> environment. The build and test suite all passed -- it assumed I just
>> wanted to build a release that didn't have HTTPS support -- so some
>> relatively critical function was silently skipped. I don't know how to
>> avoid that sort of issue other than relying on (a) user bug (or at
>> least missing function) reports and (b) folk building Git for
>> themselves/others periodically going through the output of the
>> configure scripts and the skipped subtests to make sure only expected
>> things get missed; neither of those options seem great to me.
>
>I agree with you that there needs a good way to enumerate what the
>unsatisfied prerequisites for a particular build are.  That would
>have helped in your HTTPS situation.
>

Sorry for not replying earlier. I've been sick the last couple of days
and only slowly getting up to speed again. I will improve the prereq
tests in a new commit in the other patch series still in progress that
i'll shortly reroll.

As for the general prereq issue i ran into that as well during
development. When you depend on other patches / a specific version of
ssh-keygen for git I always have to remember to set the path correctly
or the tests might silently be ignored by the missing prereq. Usually
not a problem for single test runs, but when i run the full suite before
sending something.

So, here's a simple rfc patch to maybe start with addressing this issue. 

--emckqdvape7dnb4c
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

From 0e7e57e546ec969d31094405aecafd1b1f3cf4d8 Mon Sep 17 00:00:00 2001
From: Fabian Stelzer <fs@gigacodes.de>
Date: Fri, 12 Nov 2021 16:41:30 +0100
Subject: [RFC PATCH 1/2] test-lib: show failed prereq summary

Add failed prereqs to the test results.
Aggregate and then show them with the totals.

Signed-off-by: Fabian Stelzer <fs@gigacodes.de>
---
 t/aggregate-results.sh | 12 ++++++++++++
 t/test-lib.sh          |  4 ++++
 2 files changed, 16 insertions(+)

diff --git a/t/aggregate-results.sh b/t/aggregate-results.sh
index 7913e206ed..ad531cc75d 100755
--- a/t/aggregate-results.sh
+++ b/t/aggregate-results.sh
@@ -6,6 +6,7 @@ success=0
 failed=0
 broken=0
 total=0
+missing_prereq=
 
 while read file
 do
@@ -30,10 +31,21 @@ do
 			broken=$(($broken + $value)) ;;
 		total)
 			total=$(($total + $value)) ;;
+		missing_prereq)
+			missing_prereq="$missing_prereq $value" ;;
 		esac
 	done <"$file"
 done
 
+if test -n "$missing_prereq"
+then
+	unique_missing_prereq=$(
+		echo $missing_prereq | tr -s "," | \
+		sed -e 's/ //g' -e 's/^,//' -e 's/,$//' -e 's/,/\n/g' \
+		| sort | uniq | paste -s -d ',')
+	printf "\nmissing prereq: $unique_missing_prereq\n\n"
+fi
+
 if test -n "$failed_tests"
 then
 	printf "\nfailed test(s):$failed_tests\n\n"
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 2679a7596a..472387afec 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -669,6 +669,8 @@ test_fixed=0
 test_broken=0
 test_success=0
 
+test_missing_prereq=
+
 test_external_has_tap=0
 
 die () {
@@ -1068,6 +1070,7 @@ test_skip () {
 		then
 			of_prereq=" of $test_prereq"
 		fi
+		test_missing_prereq="$missing_prereq,$test_missing_prereq"
 		skipped_reason="missing $missing_prereq${of_prereq}"
 	fi
 
@@ -1175,6 +1178,7 @@ test_done () {
 		fixed $test_fixed
 		broken $test_broken
 		failed $test_failure
+		missing_prereq $test_missing_prereq
 
 		EOF
 	fi
-- 
2.31.1


--emckqdvape7dnb4c
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

From d13d4c8ccbd832e1d62044b18b8b771f6586ee2a Mon Sep 17 00:00:00 2001
From: Fabian Stelzer <fs@gigacodes.de>
Date: Fri, 12 Nov 2021 16:43:18 +0100
Subject: [RFC PATCH 2/2] test-lib: introduce required prereq for test runs

Allows setting GIT_TEST_REQUIRE_PREREQ to a number of prereqs that must
succeed for this run. Otherwise the test run will abort.

Signed-off-by: Fabian Stelzer <fs@gigacodes.de>
---
 t/test-lib-functions.sh | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index eef2262a36..d65995cd15 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -669,6 +669,14 @@ test_have_prereq () {
 			satisfied_this_prereq=t
 			;;
 		*)
+			if ! test -z $GIT_TEST_REQUIRE_PREREQ
+			then
+				case ",$GIT_TEST_REQUIRE_PREREQ," in
+				*,$prerequisite,*)
+					error "required prereq $prerequisite failed"
+					;;
+				esac
+			fi
 			satisfied_this_prereq=
 		esac
 
-- 
2.31.1


--emckqdvape7dnb4c--
