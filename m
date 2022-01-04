Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25C1CC433EF
	for <git@archiver.kernel.org>; Tue,  4 Jan 2022 12:49:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231863AbiADMtf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Jan 2022 07:49:35 -0500
Received: from mail-bn8nam12on2054.outbound.protection.outlook.com ([40.107.237.54]:26048
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233156AbiADMte (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jan 2022 07:49:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CTuOR4cexc+9OpDmu7XGqTrT2/nfrLe1Jf7YlXquVzHDQuUBu0BQAWXfv60t0e3nss6Z9Py8p5hXvZ+Tghvu3AT9OMQkze+5W478eqU0SNt/gJytcOL7qAsntYoLM3MMm5/XHaTKSd10FW1BuS2A1NiMTpypizze4bREXcE/oZNQnLjkcZP55S1fVZD2aEDSh1sNHSSSIm9+W8w2Dc8CtQ160xpY7f4vbzgwNKukUez7ZKOng+UqIwBTT44/6TEB9Od6pKh6epWnYKrOPwlHuHT7lLpq30Xu0W7409b3ggs2FFOxoNdUW1qIA8L3F1plBWw/gjkz/Tlf8E+199SjTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dCZSFVL/iEwwhUAbfeX0lfiW2N1XjCZXlIE3OhLttZA=;
 b=CUl/Ec/QitUuOrH4pI6IZFrlcDUMv9wyMbhinZ5iAPAgyvn4FOOUc+ZAVouvYN9cd0e+PjJLdW17BBQaW0NQTy/UIMLsDjzE6GLoPyFWEFL3bql8q88+q3MkrbjeHEMxbUgnGQF45FIxSSEAHFtEAYlp5i7ODrKBOU6eCGkHTo8LxHJP8Sd5t+6KiAjmWl6sFG6EJm+LRQJo0UN5OSn9Ek++uJXB0tNlnVBa3hy3d0AMtNJCfqkAnI4ZitaEWHfA+MFUD81pEUZ1ulenrGHK1WcM/Y2l4zpbtnBNW+9d9t6+fsA1VzKPAblKYAwHIOwCL+blVdqwMrSqPZodmv+gRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dCZSFVL/iEwwhUAbfeX0lfiW2N1XjCZXlIE3OhLttZA=;
 b=hn1bnFI4UpvzjjG1tnVze4vSLsX7zbyL0Mvc+1Di4ZOGYDgpzSrJ6SYQjUTRHD89j7NmI88yr0H6EyAauahgqI6s8rEDZ0UM3G1PgXCnMwoJCgJgq2AHDcAEjQHLtUfBLdpkniaGpXr/cAjhKo7dU7XrFkQQ0awmlqZuB6e6mIE3tq/lZpkAsiDr09+FwkGFdRUgC+7i6kNpJLNIRtIM2PC98dLrJoV5oYI1I6QSh8AUHfumV/xwInEy13b9IlQcvnHsA/hmYPoNQdwTBcQ/1olsET1or4ul+fCcYSbSLnxtK/OPsIqCMydbZWTDelyl6OEb9qwqp/8O/C0qjFSA9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB4849.namprd12.prod.outlook.com (2603:10b6:208:1c2::17)
 by BL0PR12MB2500.namprd12.prod.outlook.com (2603:10b6:207:4e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Tue, 4 Jan
 2022 12:49:33 +0000
Received: from BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::516f:3a1f:4951:ebd6]) by BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::516f:3a1f:4951:ebd6%5]) with mapi id 15.20.4844.016; Tue, 4 Jan 2022
 12:49:33 +0000
From:   Joel Holdsworth <jholdsworth@nvidia.com>
To:     git@vger.kernel.org, Luke Diamand <luke@diamand.org>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com>,
        Dorgon Chang <dorgonman@hotmail.com>,
        Joachim Kuebart <joachim.kuebart@gmail.com>,
        Daniel Levin <dendy.ua@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Ben Keene <seraphire@gmail.com>,
        Andrew Oakley <andrew@adoakley.name>,
        Joel Holdsworth <jholdsworth@nvidia.com>
Subject: [PATCH v2 RESEND 1/5] git-p4: use with statements to close files after use in patchRCSKeywords
Date:   Tue,  4 Jan 2022 12:49:09 +0000
Message-Id: <20220104124913.2894-2-jholdsworth@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220104124913.2894-1-jholdsworth@nvidia.com>
References: <20220104124913.2894-1-jholdsworth@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM9P192CA0014.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:21d::19) To BL0PR12MB4849.namprd12.prod.outlook.com
 (2603:10b6:208:1c2::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4e07dd91-b874-4e6e-4a23-08d9cf80a7d7
X-MS-TrafficTypeDiagnostic: BL0PR12MB2500:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB2500C8D2FB4EC0A3EB580B74C84A9@BL0PR12MB2500.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SHmJf/+Zz2cvlRq6iph0xCpskvq6kFHqNMTDhhLKMFnhdrnmMzDbjWlbbKf/Gf7arytd2eABm0pikhhOkjx4cGZ2W6GbVAURuXxwviOYI9L3R13Hg++cSVSGBzeTFHyDeIkEW04rjMv5oufwZnRIVAA5I4w/yx6i7L34iulEj2OztzIeRhAuzJZ2DtW4t72RRPAALS1Z92B9wCUV9C18oJh7OsRx6fVOUXVbfSDZWygJilFXW8T16DRnjnoH5nbkuMLy1hPYqft9d6cyjlRHNKmPaGockTnesPLcLUP3XQeXGTA25BY3ayIeNnpKeIsWLnSvFuVCmcAsx+hRiZ3YiYaF3jY4RMCBGQ+qfdY81yQLVN4/UU4AOuvpJKBiXkqwMyMPq71DCKXHTxbjG7OKQEbF0llRBPfri16E+J1/LtLLU2VDC01YgmeGZ4xCPVzMvfB+BMq0FJNAzCI0MmXNKSuiqxiVpeJz1Z8/GhipVM7OAMfwcnOvajmewSKqtX2/mG1+0FFKfk8IivJS1Zwa+T/OnN/UC6HXbhuwYWPleres7I5znHr31D+YJBS5XdYiZxPK5gniC40rMWM8aJNe/gU6H90lz6ns87U4z7XskHQdH4YAEqBkSz1ANEjNKr5qSS/2siRIOyq3zvVfe547D24oNaG8IxQj+03yTd4BVr+wkqVHzVkY3rbvP5bmCl9+4Jt+Fff4D9dwvtU7Uva/VnUJse3b8qeyF/87VvJE0gY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2616005)(66946007)(38100700002)(6486002)(110136005)(2906002)(26005)(66556008)(54906003)(66476007)(83380400001)(4326008)(86362001)(1076003)(36756003)(8676002)(6512007)(186003)(5660300002)(508600001)(6666004)(6506007)(8936002)(107886003)(38350700002)(52116002)(316002)(55236004)(7416002)(156123004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fGw1dRSmI/j/R8IU/SC1Fd6pcWupeoRnVxLLDB6YersbIWfKyme1wX/n0NpT?=
 =?us-ascii?Q?n+7ikCrIJWKfe0fbwdXIYmIlUyQo9faRObgBZsubc7v+kmNcHjv5iftQH85l?=
 =?us-ascii?Q?VCHKu/kFo6orZSV130XIPNR5SG+rI15pmbwTm+mYxH8+WK6E6sILIjZh6fmR?=
 =?us-ascii?Q?EMHCQhasHS4p9FAeWoNVG+YbbqKMgOe1gc1EQ4cSsliDnMMZ0b/DoV+oIpJl?=
 =?us-ascii?Q?NlUparBl3xDfSlDVSo7pedZ5Jk+p9hdh9sGLcZb9RZroKkLOzyEuItmqt4y1?=
 =?us-ascii?Q?YrQ/Jv/aS7TpCFyAfvJXHeMuCFZtYv7PJsMbvZQH0fjf6/DjewyEKiJeMfq0?=
 =?us-ascii?Q?H2kJz/YS6paViWg5tXlZiVdT3grGlxQSrEswnID3l7vFZdMWIjkdyoPjlviG?=
 =?us-ascii?Q?Rl0GXTS3rzWQnpY6YvxXS3rjA8ucDUxrBCvNpxbW2naoX6tXv0Q6fGguz6MG?=
 =?us-ascii?Q?aJe+WDlPJmCua1Sd4yfIxTsjvd4rpPNX5/51a0jje6lMV5eZ/Nk1HS40l9tn?=
 =?us-ascii?Q?qL1U9/JBN+tiinrTza2oc4qQyW46Kb1ropJV3FB0wqg8a+0f/7vMxS8T4OHf?=
 =?us-ascii?Q?ksXmQOR2aBkGGV9hJexaeNj7GBouOqLpAw8+X42luubhmb+RXAqUU7Qjbv6V?=
 =?us-ascii?Q?9JNnKq/OL9ld03Bo+R1Te0JysFZpy+H+TaGXODEvMH1hhJhxdn/FonL5W8Cd?=
 =?us-ascii?Q?EcUWOU+WogD9SgznSutWjg/hbY+TVfh2Idn7GALLceX6F9aRq7RhAHZlpa0B?=
 =?us-ascii?Q?p8frs1wdfJI9/NKthRyTO2dpZr2W6HJjFSYQ1joYDbPTo/fBehGUD2+LPSbk?=
 =?us-ascii?Q?76Ht1tNOBu01h8Djc3sSXOak1wNGa0hTh1Mj8n8qTU6HvoabgO95Q+eimhSY?=
 =?us-ascii?Q?LuP1d0eOio0tPLAYB70SSpB1K9fdKIf07lceaLLwnT4Vk7z2PABrxSI+ehPH?=
 =?us-ascii?Q?t4SB9lsSzL4Wsft1a9hku+YqMUjxweD4lNKVno3hBa5URtxt/glp3Z5QmVA4?=
 =?us-ascii?Q?uF4ihy5vfOuGtHmYe7vw2U0gxMuy9Vo7UmPG4+f9GVzFbX1ZMqSKUG0r7P6d?=
 =?us-ascii?Q?Zun4M18afqekAmuN5oIuM9nVxgXTETr+D4/v1tr/+LoaF8VPwK7A/5lnPAvZ?=
 =?us-ascii?Q?hxmsnC30Qb0S5Muh5hx8umf8AUKFU29i6/dy8JghJD43trMfYDvTWY/nTKP4?=
 =?us-ascii?Q?ek4KZzt90gJdWN3wa4ANaJ2edQbTBfibqntXBGrTQHSmTEuppVzm91/AONAZ?=
 =?us-ascii?Q?keBKxGT3h0MDrD6fdky80ODf/4zBnum//+IBu05pih+p+bDGO5IQHZso8zku?=
 =?us-ascii?Q?rogKchXsMDr9tb7GpqjmzE0hhacGHUJIZWGQgolhXRKVXYnG5LF5Po51I0NJ?=
 =?us-ascii?Q?LOIMFtKxLd+vXrZcmDQB6FmVh53SPm2Hv/2y9FKerqQj7XBhiojyevVHWcvr?=
 =?us-ascii?Q?tT3p5VjTeUDzG9N+tMrcrLN5mje+O9w7R1VdWqC6YaqazSrKGyJ1KshZnHY1?=
 =?us-ascii?Q?WAxBep3tZy9nmQRqutHTQ7/clgIrHsM8COuxlGjWae7XNuIzDE4WHqHcHatU?=
 =?us-ascii?Q?pvfn+/Y461IxpMz5MCwERlG86i8/BE07YDD/th/WaCNQvSAoGBmUFnls8ODZ?=
 =?us-ascii?Q?YnpgHO9vhMlzaeDNnbYe0RE=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e07dd91-b874-4e6e-4a23-08d9cf80a7d7
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2022 12:49:32.9553
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ojk8sBxtWrmTJxiYGmHjqn9h7jQReyYg28aTmHK7bMSkYm8ONlTnCgpu5d1P/+7ALuBqmDxPxX2x3t1ibwaNvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2500
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Python with statements are used to wrap the execution of a block of code
so that an object can be safely released when execution leaves the
scope.

They are desirable for improving code tidyness, and to ensure that
objects are properly destroyed even when exceptions are thrown.

Signed-off-by: Joel Holdsworth <jholdsworth@nvidia.com>
---
 git-p4.py | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 2b4500226a..226cdef424 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -1757,14 +1757,11 @@ def patchRCSKeywords(self, file, pattern):
         # Attempt to zap the RCS keywords in a p4 controlled file matching the given pattern
         (handle, outFileName) = tempfile.mkstemp(dir='.')
         try:
-            outFile = os.fdopen(handle, "w+")
-            inFile = open(file, "r")
-            regexp = re.compile(pattern, re.VERBOSE)
-            for line in inFile.readlines():
-                line = regexp.sub(r'$\1$', line)
-                outFile.write(line)
-            inFile.close()
-            outFile.close()
+            with os.fdopen(handle, "w+") as outFile, open(file, "r") as inFile:
+                regexp = re.compile(pattern, re.VERBOSE)
+                for line in inFile.readlines():
+                    line = regexp.sub(r'$\1$', line)
+                    outFile.write(line)
             # Forcibly overwrite the original file
             os.unlink(file)
             shutil.move(outFileName, file)
-- 
2.34.1

