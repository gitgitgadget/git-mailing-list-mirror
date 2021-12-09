Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10375C433FE
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 20:10:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231669AbhLIUOa (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 15:14:30 -0500
Received: from mail-mw2nam10on2076.outbound.protection.outlook.com ([40.107.94.76]:37985
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231604AbhLIUO2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 15:14:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IPCMuemCEkjlJM5jxe/yHB0YPDUykv62qtr7XEKs5xRbnFOXNQr9MOse7LFTL8U1jv9RVsY4HHeUCSXIQWinE58q2vnGXg6NBNo3nCY48jQtdZfAnbJvc58P6TL+2iRNu3gZXyEtcFVdk24r5WTqVUuRL70RxvtgSfW/l5gTXOyT2LICNvzMFkIN4tqg346H0W58dxa+75QRyvOYaZqXBOYW8AKvQqowvGYt8IVVARgQiEZaWgMI12Ib59hLHB0YHCo+QFv6+T45fZaRlXDPlVXSVl1C/Qo2xRGhiWGdXWPADew+U0A6z2w8tcKQrMUjhF4muZGNXpqCbkyL0xbZMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LyttxTi7YsL4TL3xplbAuXTEpDIEayp4cdzc7qPu/BY=;
 b=EbnQwTpWxkTPtSbJ4baYKyG12Ln01EU1PU/Cb8bkZBJzBBesu40G1tOI979+PGCjRSwM1thbuYGxDAqZGft5c6VRnTqEtApMZPC5gF5NhDi4FpsMLqjaXlDF6xJE8ilJZ6eeX+2PgOYvEcfiTqoXBzKYXS5R7emlwW73JunexpOdeqKIQCFsF5oX2IOUmZf2Chy3/xu0WMU+ZqOls/L4jaJvUWciKY+Z1cjHEw2JPqRwKiXb4VohR9DbbqhENV+I3WzcSKbMk/0siuU8s/N3TtPvOE6RTQtJEFi5/jE39CZt8VTbBWbWb/Q1KQz4OuzOn941Ka8u51LdDo0UIpAixQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LyttxTi7YsL4TL3xplbAuXTEpDIEayp4cdzc7qPu/BY=;
 b=jOGiDUS1OvSv3elhb/z0suiqdLVLKtbA3qvBXdapN66xQb4hRlQ8QGuog1zYuqQuWOq+1hF5YXhvWVXPcTtpgdbUVFWir6Nhssnn0EvqV3ACqsv2P/+u8vMRqt08HWgGDujqAUPl19iv2RqFc/o1p97DGM1vUr8DsxzZz/NG2FEOONYcYBqRNw/dr6Qcd73mFChAi29IrvAiOaDYWgoBhZT21+M7TNrwb8RWlQaCbqLg+rvMMGLocnnrdQphsbHKw8JSqnl+rP6hoC43IAtdVn7C4gNLIubwdaA1F/zEWUnATbXKS6/CP1yNVvFobeXIh33G+H07eym03T/O2P6adw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN8PR12MB3361.namprd12.prod.outlook.com (2603:10b6:408:67::19)
 by BN8PR12MB3282.namprd12.prod.outlook.com (2603:10b6:408:9e::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Thu, 9 Dec
 2021 20:10:53 +0000
Received: from BN8PR12MB3361.namprd12.prod.outlook.com
 ([fe80::4063:6e26:a906:e592]) by BN8PR12MB3361.namprd12.prod.outlook.com
 ([fe80::4063:6e26:a906:e592%3]) with mapi id 15.20.4755.025; Thu, 9 Dec 2021
 20:10:53 +0000
From:   Joel Holdsworth <jholdsworth@nvidia.com>
To:     git@vger.kernel.org
Cc:     Joel Holdsworth <jholdsworth@nvidia.com>
Subject: [PATCH 4/6] git-p4: Decode byte strings before printing
Date:   Thu,  9 Dec 2021 20:10:27 +0000
Message-Id: <20211209201029.136886-5-jholdsworth@nvidia.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211209201029.136886-1-jholdsworth@nvidia.com>
References: <20211209201029.136886-1-jholdsworth@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM9P195CA0012.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:21f::17) To BN8PR12MB3361.namprd12.prod.outlook.com
 (2603:10b6:408:67::19)
MIME-Version: 1.0
Received: from red.nvidia.com (195.110.77.193) by AM9P195CA0012.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:21f::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20 via Frontend Transport; Thu, 9 Dec 2021 20:10:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 29b1c9a3-0991-4173-ef5e-08d9bb5000b6
X-MS-TrafficTypeDiagnostic: BN8PR12MB3282:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB32822531395C334AF5B530DBC8709@BN8PR12MB3282.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:63;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Sklhh71ibt8zA4NySTM7DKfxfZR+jJ8RKyvq1yt9dYjpFn9mS+21M9pT4jSErcQ0x2hwgMudyJ4I7hVmwB1pq8Hqbsb/2vGV2rUkcYp2In+5uuiEAUJ/qzsIS5zSMO2gw5YGl5oGXTiXJLfkOUU2189KrTjTYhid0kPqRSNGK5kBp+PZJmfaDBEWEXKya9n9ARNFq8JeDtc5QhCQMMCPKOTi0Qg+MnuhDNAELBZUYwxz6oWhKeDJHUtX4o3BlY2fWdRgqCDEIoDJvanc+fPJxEmkYsTRHpNeeJnBf7nrVt3zqZDuzwsKne9J9tA/O0LYAFyXhU+czL6JV+itScUoOYDAE6TmOKU+AqG6SSfduDcpOgi2LSpYUZCRizwcakhj0B873y0a0SVTflCxWXA38t2YO7Wud2bDL6FYAPVwSCxSEbShR3kv2S/FxF8QOnjMOsBlgNLbj5VU8uEJs2E/LHfP50L/93FZqHBQ5jHp7YNGFQVej/PMNbEk4Ai0HlJFv4MLqWJ2GKKs/fqAMilzyDKoVD9o2ud0zNrjBUVTlpyk7xUUWpo4MzGqMrgWJWprsIS1VmSMHm1uzWRgYk1Z7ckR+PSTlBSCRzHHsO1qXjPuBPVpYR0sVDyCt48QrodQQJ0hQaIUATgJ1xGQTugIi6P+IPiWldIoMNONQBElDnFuzPb/64QGn0zdd68fcnnih2U3NqCrzpLDLqlG3dBxCQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3361.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(186003)(2906002)(83380400001)(26005)(316002)(6666004)(38350700002)(956004)(508600001)(5660300002)(38100700002)(6486002)(4326008)(52116002)(2616005)(8936002)(36756003)(66476007)(7696005)(55236004)(1076003)(66946007)(86362001)(107886003)(6916009)(66556008)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bPdVINYXN1wA/SNEpc7vM+J77aSYrK790/VRC7/Ou5rTFlZKbpPpk8WHC4sn?=
 =?us-ascii?Q?0XkjuFt96N2GSErWayElUsOgU0NoiZ9M12kKR0NWEhS3CqnviLS5QcUqCv8P?=
 =?us-ascii?Q?28aQzTEOPrWJoF8+WPxNqfd/oFy5YvnXR7UdzX0o+wEtn21D/cjaPuQhBbEk?=
 =?us-ascii?Q?CAQ3MXZ4vLw/qqryNVzXpIUOFTUn+L+f5o2+pd0zrD8tG/RlRfD6wvde9Vt7?=
 =?us-ascii?Q?CR7qclZ60abs0cDEL6MELXJPnG4qxc09iO5MU9tfVTryKM5QdqRCtIrcyFxV?=
 =?us-ascii?Q?Bnjrp9w3CSVaPqpDqqRJDbTuJ7Pbv1MRHor9xbAohJGwtNBOsYmo+Po71y4Y?=
 =?us-ascii?Q?a+Vcq3y1GWA7CECbDIAqrYXpDgBafHIfWJVbEdPgnh67YsGn0GRUx2n0uvyz?=
 =?us-ascii?Q?05SQQ0wP+Byt14ijTBNzROgsnt0akkVlTulexQ896eUJhbsczyCXpZsWrDu7?=
 =?us-ascii?Q?CTLk/i7ASfdeN5Jt4MUePtK7zCXmDDXcvGOHrex+8aSe5fzKKlrowz72imu6?=
 =?us-ascii?Q?R7UPpwnnWHdCjEM8HA+BrHUj58gEbL9D1Pk6mziyTO2HkDtNFVZ/PUyf0t+c?=
 =?us-ascii?Q?90k6946uF9yaTgeenJGMILjxehe5LPV8g5q7W3ptL87yGxd/bmTLpw8ZbVZb?=
 =?us-ascii?Q?cv03rt8mvBTukDmk0W/p77S4Z5tasqD/Y3gf6BEoucQlPMuYfewiLukeO5T4?=
 =?us-ascii?Q?yxDN9L2HTSCwEbTei514iejyIO1JlsgDbtTTVCwV/HCcoYRl+AMkRAAXc4lJ?=
 =?us-ascii?Q?3pswNWMgt7MufQAqLKcghuqYHslO6OsvwFYYAvQ6yHBhVNFrYjqh7wsakMre?=
 =?us-ascii?Q?okWtQj6S8VDF9G7jYqVGGTCHf1z7/3quoASY9MoPNsWqibGkParnuLYuOLWd?=
 =?us-ascii?Q?tbi8l74efsPjhUTL61TJ3hKiyWByQRx9STqujLPwBbIUxGInRLHMdtsvLrnN?=
 =?us-ascii?Q?8N5LWJ4Tonh01s2irsv+xXXIv+/JBu4KXgLEFIrVS6aajOwbM66ondMO86Ed?=
 =?us-ascii?Q?8utDCb5I1724Qlvla1+HPieparjCAVU2m16KilXx/PK20GnRqOgx0oTT3E7F?=
 =?us-ascii?Q?uoCMVHlZjkG54txvTomjAKbEn88eG84GqZWjMuu7TAGv4OdwgGNNm4yTq0nz?=
 =?us-ascii?Q?q9Ygx63T1Fdb3CVfACC++tNcmWGgVuzNk1qw3cadecRcqNSxt1wCMhQ2ezHU?=
 =?us-ascii?Q?JlDFA7Ku1HacnuXrYp/vfQNbKTsBVgW8x175Idb7FzENULuxQI8O+eQnMMAy?=
 =?us-ascii?Q?pK75SN9HwCn4Zv/TRPw2d1bqroPNEYeUoSgoJQ12oy/UsYazOEY6HXjDpY3q?=
 =?us-ascii?Q?zwIkZrrcNx1oj7Ev7Jrg60YfDqaKo5E65GndSGC5sDUU12NloKczqy5mn+t3?=
 =?us-ascii?Q?wXMjlhAKD/ymWz8FVocJ0gBkEjOclYHmwylJocsfcNMJTutxSsE4o4ONikvS?=
 =?us-ascii?Q?1AY+ibV+ClJ037gAXLwRfwwHVlkZxe0VLNAzKTLVMDxX4D1oT2U9Mla0A/Ay?=
 =?us-ascii?Q?4/O8uX2SCewPP0FbMkGBg0A1H1yPsEgMYcJstAbZFV+4I1mmKW2JFx7sWUdy?=
 =?us-ascii?Q?6dtEZTFq3CIol8bdLbBBauqWf+VfGTJOHcnKrnZDJd67r+Wlu5DNymV3fMcS?=
 =?us-ascii?Q?ibmZxRsEKli5C5ZxvEWfuzQ=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29b1c9a3-0991-4173-ef5e-08d9bb5000b6
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3361.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2021 20:10:53.5821
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /KzS6Lv8gROXc9IKYPaU/CJBkdrM+T7pNG7o2aiyYm6jYESikJhCfOxiymH8NrLb538osUrfrvI8b211mueECg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3282
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Joel Holdsworth <jholdsworth@nvidia.com>
---
 git-p4.py | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index b5d4fc1176..b5945a0306 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -2917,7 +2917,8 @@ def streamOneP4File(self, file, contents):
                 size = int(self.stream_file['fileSize'])
             else:
                 size = 0 # deleted files don't get a fileSize apparently
-            sys.stdout.write('\r%s --> %s (%i MB)\n' % (file_path, relPath, size/1024/1024))
+            sys.stdout.write('\r{} --> {} ({} MB)\n'.format(
+                file_path.decode(), relPath, size/1024/1024))
             sys.stdout.flush()
 
         (type_base, type_mods) = split_p4_type(file["type"])
@@ -3061,7 +3062,8 @@ def streamP4FilesCb(self, marshalled):
             size = int(self.stream_file["fileSize"])
             if size > 0:
                 progress = 100*self.stream_file['streamContentSize']/size
-                sys.stdout.write('\r%s %d%% (%i MB)' % (self.stream_file['depotFile'], progress, int(size/1024/1024)))
+                sys.stdout.write('\r{} {}% ({} MB)'.format(
+                    self.stream_file['depotFile'].decode(), progress, int(size/1024/1024)))
                 sys.stdout.flush()
 
         self.stream_have_file_info = True
@@ -3803,7 +3805,7 @@ def closeStreams(self):
             return
         self.gitStream.close()
         if self.importProcess.wait() != 0:
-            die("fast-import failed: %s" % self.gitError.read())
+            die("fast-import failed: {}".format(self.gitError.read().decode()))
         self.gitOutput.close()
         self.gitError.close()
         self.gitStream = None
-- 
2.33.0

