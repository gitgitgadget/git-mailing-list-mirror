Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA37BC7EE2F
	for <git@archiver.kernel.org>; Wed,  7 Jun 2023 00:01:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239967AbjFGABo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jun 2023 20:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234601AbjFGABj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jun 2023 20:01:39 -0400
Received: from AUS01-ME3-obe.outbound.protection.outlook.com (mail-me3aus01olkn2181.outbound.protection.outlook.com [40.92.63.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C561D11A
        for <git@vger.kernel.org>; Tue,  6 Jun 2023 17:01:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kksUgDW1odAeFgKysGKzumsm6GB9uHPoS8eRmiIp0KSmpF1NUKzUAjrdSmfEaeaUQ+7Rble/9MkYP6IiZNOIu2PW/hOJt/7tpagHSnzfbyaYfxYPrxVFSgYi+LrJOgbdaLhqT5LNrTti2zZxzUFEjzNxJW3QZHO06/wLuzveaUyBIVYHJZGaESLeg0mNE51q/er3o77l0YSOxqhDwIuCSvdBqPwwc1wPjmalaCL1XCaNViQOipJ99QVmTaZHp09SWS3ZpmTXHw5G6P8TBMp749xy5o1/QNfNXcqcg8KTsz4XlK2sBmbiQ7U0DPpBYIckgwCIld9+63fM8svV20wOdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MmJjzejmrqE7G2xWy4ygZs0b5AmVRgzN7e/AJ7dYBME=;
 b=HwZJk6mI8HkYvSPUJICxPBtHBhCalQQv4gKiEiQOY/kLxh85jUAKkcy0NoVQ30Y2ypyUfO/+UGK0gZwRXLEuFrHZc5NUmjBFzO7fG22DLd+DX33cGeNVTcclZ2WngwTli2scoI+euYHJd/D00BQXrZdPA3dEZHT64I05SjtMZQbmmtt+WUuBCQMdmTtN0xmPWWhzGt/bjCf5AUHRT2GqHYYOKFbhQwTnPDQrLha4FMoEIKN7nH1XJzDsufaBaMLZ4ooVDy32fOOG/NydsYpI/BIe5jHAj9/Z98pPXuzVXD8DO5H7U/9wTirFRagu4Szj9F2z5tyVvrFlj4W/Gf+Yeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MmJjzejmrqE7G2xWy4ygZs0b5AmVRgzN7e/AJ7dYBME=;
 b=Ou/IATuB5tmKvO8zk5jRU7bCGB8UaTCf2zZpcpXveCCvm/AZwP+sBrC+x2p/rlYDgXyl8GuhvqCb1E39gqckd7uYguZGUC8NUbUcUXBqTLEiAdywp3rWYDRxCd4fMdB2/b628W4pDRn+AvTRzNzwsoyP4k60EeqdtfOhgZb4yCDSm0lKM3wgyivt/zzXkD8q33AN7QwtAClBc/aYpIKo5qohydq4uSQwlPHckQG7o1W2aOr0qkq3lO5RwDZ055gpO7GkEFyZk2fGPHzQV97W9qucjIM3bUsjhlp7hESw8r0JtM/Z4gnm6Jgkp3GUKppydTWkVSqQwQgjswwwe3eQjw==
Received: from ME2P282MB2242.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:eb::14)
 by SYYP282MB1183.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:bd::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6477.19; Wed, 7 Jun 2023 00:01:33 +0000
Received: from ME2P282MB2242.AUSP282.PROD.OUTLOOK.COM
 ([fe80::e7b2:ce6a:695e:ef76]) by ME2P282MB2242.AUSP282.PROD.OUTLOOK.COM
 ([fe80::e7b2:ce6a:695e:ef76%5]) with mapi id 15.20.6477.016; Wed, 7 Jun 2023
 00:01:33 +0000
From:   Qixing ksyx Xue <qixingxue@outlook.com>
To:     git@vger.kernel.org
Cc:     Qixing ksyx Xue <qixingxue@outlook.com>
Subject: [PATCH] gitweb: wrong capture group used for grep search
Date:   Tue,  6 Jun 2023 20:00:18 -0400
Message-ID: <ME2P282MB224200468AFBBBD4534ED1F7B453A@ME2P282MB2242.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.22.0.windows.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [zRkPOQbBbmtLKGBFJYE7JFZ2Nyekj07HzZ7X3G0Wfe0RnlamzfVbsiSB1rSLVovV]
X-ClientProxiedBy: BN0PR02CA0053.namprd02.prod.outlook.com
 (2603:10b6:408:e5::28) To ME2P282MB2242.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:eb::14)
X-Microsoft-Original-Message-ID: <20230607000017.606-1-qixingxue@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ME2P282MB2242:EE_|SYYP282MB1183:EE_
X-MS-Office365-Filtering-Correlation-Id: bf75f542-cfd7-44aa-e6fe-08db66ea5aa7
X-MS-Exchange-SLBlob-MailProps: 0wLWl8rLpvuY36wV1SFeMlt7XXvVGObrpVzLx8+GIDJVdyzWnP//nV/gmUqYfXNPN6QcBOUYSaM/FX4RuxmXZxGaTlhxZqwaNZ0zemPsCrT755S8REFpxT9nli1x38tfxQCzA/i3LTq8oxhDBDdZQ3nmFvs+aogodPMnUENHRD3TjukcsNkj0JjA1jUMAdo5nUz8nbRkOhJOJ0mBTMzc7NRGMc88EnVd3onv6+kvcw9ypnIMy2azDTWzaxL0ANFElQLEt17R93mN+7AxADdL9XFdqtAPayO6xploxWVKkDYylc39EVImMIHPr9PtfTmnaqkA7V5M7dGfUHhqEL2gZGmarXZNJVdqGWZcUrQzHkEQuRQ2ufkmFgl4nUOIxFaHfKc8BfLDw5p2O7VIziX2qWFK9vONIqYt7jX8e2WXBxObHD4vDxlUDl1/4v6txT6HuRRKu6+Jor3iQseI/8/fjsKmwm4bPVg/kt85eWEPzC/UPPETt5a/6jHo24ZRnM0exVpmQ7HoaaUQQ+o4gn4O+4Nlst4pWQK41qytGyGD9Bj1TCc2TVhVaAT+aCRVVOL6uMV4wu1veJ3zHkcYKvZIqtwboKgykv5zHNYwpAhJRrwm3Wi6sz9+oK/5kipiBM0Ovqx6D3S8X0YTbfy2htjL96comsnNxZ9yUqrixrS6gZJ7/SuWW3lV3FU2qiWE1mJeWpmz7spMVV3j3iSeIirjkCMtWWlNxjrYn/JM2bpUASLflMwnnA3eJL5kEmV1yunI9pyoJr2U1ZA=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xo3h9ZDqsUtqvWvDeQSSjfX3/FOeh/ZUj79aQ6XXGmO+NuSg1bG8we13PwK9tKOzmQiiJPiSB0a8MiBOxI23KghAbl8nDy8PCusC1wMOvQGvl4svS6u3nbJFf88fYIIHxFkl0tjYd1F0aNZ8m95ktmYeZc1aXXZCWxP19uwZgy6UsgsXAv2Tp//2/0sdEImQ4CqyRRYEn9ODOtPd2UCrw6DFGODopHIqlA3XddHk31RAd1NzsGvbLxNluYKVRqV48ce0/kL2m9OLouIzYKO2OoaC0rW7FSzXQgPqL/OYH3LXUq6a4PFXSZDPgmOnU6NyT9gn2R5hesVjYBZNQ+csPqKu6aYRi3V61ER9n/IFOCxCNnteWfcQaU1bPhUt6VLAxhLoaAYiktRJyHRaeU20FxQuh6ea9jX7C4BiRVKVqZvRopekPoxcYbxxYnn7lNbXahnm5tmlfCngQ56hIJTr+oEsmfwnLUpNZrb3Uft32GmS6cA3nvMM2Z1I65lBWxTVeokqO4ynbgnKKzpaTNvEWi9VokIZMc6yRXGck88sqiiMk3tinI6Al+AhRezCt8bGjgEWJH33mOIeipLfqP0HQWHyZ7ACifRXcXUSZAeg0rOq0rZ/MXa9ZAT4LDAVx7tU
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?J9EuxM11Pkj5BPBBwoxiAJ3lRoPGzMWr4Zn0Dk1kU7WQ8HNKI0+b/N90fTIr?=
 =?us-ascii?Q?hZZtWHoZ0XvhXHWiE2nHcakf8QzY9U3lz10KDHh0/lIYOrxmG6xw+8Qgue30?=
 =?us-ascii?Q?Vqg6cblKlBeZ0/BEEty13LSnn4lmYmYo7rEZHLsWZ+NTSHqjGFHcTC39XdVt?=
 =?us-ascii?Q?q5Zoo0C4NwEEGZpaZ6LWNhl5t3F5PJsAbjNSVNR5jrm+eIUqGv/FYwtOYR4L?=
 =?us-ascii?Q?Z3JfUM8krePzWBMsjPihUtng1Z+QMnMfa1sMpUuSsKjtNaiODWvM/M0I+6vr?=
 =?us-ascii?Q?PfyPp1YVXqjYlqNBznb7YHgkGwzfeR2jOXth9daORX/GwAjH5L+P4nF4axv+?=
 =?us-ascii?Q?6w9CeeUZwnG1TyTxNc9qYglOOfnfUbHgSSJvJzayx4Ann8qezrtHB5q8RBve?=
 =?us-ascii?Q?xR91wb067N5GflRyEGHEgzB8dmwFsD8/QvH5zwLoJKz1tjTzL+msGP2xetkt?=
 =?us-ascii?Q?1Qa2Gn0dE7BC3V3Im1LdPdOFkNdWFwavdBD05cAvwv4WSf1teEANHS0SjbbK?=
 =?us-ascii?Q?V9OOzMIc0p/Gkk/aqf6sgzP53I5Iw6a2qyeDMW6vJV7yNMdQCXNdcqeY+Zoq?=
 =?us-ascii?Q?uMlnsH7MdKuE970iIyFYeOFAmPoyvPvSjC+wi+91ho+EHtcbOAj9JhMc1p0F?=
 =?us-ascii?Q?l8WM3E0w8okt4SgyOreaHTnF+uVTYkqZRzN4yaD6BLjkjUm3NjyYHYIltnNO?=
 =?us-ascii?Q?9yrKEzPBH8mElvkHy2PUAIAJIm1d3AhWYqN/Jgh0Pq+mxJOwL5deUEMTO5KR?=
 =?us-ascii?Q?zlvnqYB3y9jkho1qvc+PbEkVI1SNZHNdN5zuhz9rIfNIsqMhHJnowLNvdj5I?=
 =?us-ascii?Q?LoCBe50Rnz3LKTriDmMFDrS3fdBFaOKQsp/YKNHpt0k7tvRP3SdqZktVFd5g?=
 =?us-ascii?Q?rosDiB7noOyPYqF85tqzfPw0z/lIBFBIb2ite2dEGuTozrQ0WF+yH61to3r6?=
 =?us-ascii?Q?WmG/3MfEJ2EjFLH9AcGcpgWT5QyW/IjODNCbEW49sqQ2q6xOfYAHY3t2FMoV?=
 =?us-ascii?Q?Ylvxvow1Q9ho44HolazvAwy2SfHKfEurKaZyMdLuPyPkeLTz/uvEqhLDXASl?=
 =?us-ascii?Q?EWs5oK3FynkEO4xK50IYFyPrca7pugwnjlqSJ1gLDA5vKCxDgHetMPUxY0LZ?=
 =?us-ascii?Q?KQCQd5+UqOTjrKt8t8Gc196zMEeL9DgdEB8E5e9CcWzID4S/j5AU2uHj70Gr?=
 =?us-ascii?Q?u+18cupFPZrZ5DH2lAFuJzUUt5e0XS4lZY4IsrJKURqHjMvusHro5Zh1Z+PS?=
 =?us-ascii?Q?+DipP9B4cevdF43rpt4ieXjc/RdyQk8an+Md0kx3GrbD2D5KBv1+A/rqWJfX?=
 =?us-ascii?Q?O64=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf75f542-cfd7-44aa-e6fe-08db66ea5aa7
X-MS-Exchange-CrossTenant-AuthSource: ME2P282MB2242.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 00:01:33.7417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SYYP282MB1183
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The capture group numberings $1, $2, and $3 used in the original script
does not work well when the search term itself has capture group, and
could be replicated with the simplest case of p(a|b), whose search
result with regard to original text `XpaY' would yield `Xpaa' since
capture group 3 now becomes the one in the search term, instead of
some suffix. This patch fixes the problem with named capture group with
capture names that hopefully would not conflict.

Signed-off-by: Qixing ksyx Xue <qixingxue@outlook.com>
---
 gitweb/gitweb.perl | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index e66eb3d9ba..e868122853 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -6418,12 +6418,12 @@ sub git_search_files {
 			print "<div class=\"binary\">Binary file</div>\n";
 		} else {
 			$ltext = untabify($ltext);
-			if ($ltext =~ m/^(.*)($search_regexp)(.*)$/i) {
-				$ltext = esc_html($1, -nbsp=>1);
+			if ($ltext =~ m/^(?<__gitweb__prefix>.*)(?<__gitweb__matching_text>$search_regexp)(?<__gitweb__suffix>.*)$/i) {
+				$ltext = esc_html($+{__gitweb__prefix}, -nbsp=>1);
 				$ltext .= '<span class="match">';
-				$ltext .= esc_html($2, -nbsp=>1);
+				$ltext .= esc_html($+{__gitweb__matching_text}, -nbsp=>1);
 				$ltext .= '</span>';
-				$ltext .= esc_html($3, -nbsp=>1);
+				$ltext .= esc_html($+{__gitweb__suffix}, -nbsp=>1);
 			} else {
 				$ltext = esc_html($ltext, -nbsp=>1);
 			}
-- 
2.30.0

