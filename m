Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B92DCC433EF
	for <git@archiver.kernel.org>; Sun, 19 Dec 2021 15:41:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235953AbhLSPlC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Dec 2021 10:41:02 -0500
Received: from mail-mw2nam12on2052.outbound.protection.outlook.com ([40.107.244.52]:55520
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229870AbhLSPlA (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Dec 2021 10:41:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aghzqtUW9NkNBjO+yUTuOsTgvSzTUoeuxrPcQyihcEqE01ysVd2ms4ltz+1hjy3lTHPryl5e5nhkn+ifev3R3MvOWVKeuTE85kOm1kbBtHX5qfcQ9sMrMzXhMjNmXLAbzAfh+jN6PFs3W9iGJ8IAQDOVHwUyPWuIMHRFv1DALdBWsbmqWb/dbce+xfCAojpgRUQMP3YPcnbKEFW1jfeBiZzqCJBqE7wVX76RlZbfh8EEqH83a3Qk4IPQ1TRM142fdeKQwTQCjXYpqNSjYmeCUh7S2fhI4Q8+7dGaVDPa66beEbMqfTBepcFamxBvyxckBnDdUm+loPwspEhhl6PHjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IsjxWH7iFWQs0LJjhQr7BnM27pPks8p2lRbpoE4BnwI=;
 b=EZO9FJigv8CQPb8pQjq62J88SNljZ9qfOVqUUAxkwVDL5z93blVUvaHt4Bp2wzyhDzCKHNyIXCLGn8dkH5C1cBR89mpeFs7iNRjk7MJk2lkqed6fh1hDuONAvDYg7kgiuld47r6gXpcq38dXbdo0fNnUa57kjoNmz0ysRspLf8cI7NJeKcpMYwAXWNrtk8sZ+N9XGxJwMxXHZ0wmvYSlgjTtU5HLD2YTSAy2PaHXBixsWmbK/P2oK9MLUrb2/PCKZkMcHyYFfzruOz6QSMco57IPjxVAHyd/1mNpiVMsu5bd6KO3PvBKskJBj7kx/sZ1HCIyB90gWn51Tqyk+6QwfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IsjxWH7iFWQs0LJjhQr7BnM27pPks8p2lRbpoE4BnwI=;
 b=HGgue667s1SE4y0wR4QyTtHbRjAiFUAqwagPXMe7INssO+T/zgtYeJXSJhuaJQEwdk0W8TOrjCss0J4zyu6zw4ZQWW9VFsofPdTH3RF8UwhZ7T5AWvjRVkHZLp1SCUtqLzqV/Rs+h7rvAK7rk8w0pI5RudyYpbQByQskpeeby/n8/xemCXfaLU8kTWxdMNcA5m3buwdZ11noh2UFbxjEKQXzBy0GvTWc9aKAJLklG/Vt/zP/nGALhMLJ625pxIaVaG1n5TOa/xu5u/wIzTx4ElK2Hu3XuVCn+NVmO76xbAVY9gTemQ2KtKXFnsg+4upre1G+Aj9VAotHBfn8wSI+xw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN8PR12MB3361.namprd12.prod.outlook.com (2603:10b6:408:67::19)
 by BN6PR12MB1186.namprd12.prod.outlook.com (2603:10b6:404:1c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Sun, 19 Dec
 2021 15:40:56 +0000
Received: from BN8PR12MB3361.namprd12.prod.outlook.com
 ([fe80::4063:6e26:a906:e592]) by BN8PR12MB3361.namprd12.prod.outlook.com
 ([fe80::4063:6e26:a906:e592%3]) with mapi id 15.20.4801.020; Sun, 19 Dec 2021
 15:40:56 +0000
From:   Joel Holdsworth <jholdsworth@nvidia.com>
To:     git@vger.kernel.org
Cc:     Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com>,
        Dorgon Chang <dorgonman@hotmail.com>,
        Joachim Kuebart <joachim.kuebart@gmail.com>,
        Daniel Levin <dendy.ua@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Luke Diamand <luke@diamand.org>,
        Ben Keene <seraphire@gmail.com>,
        Andrew Oakley <andrew@adoakley.name>,
        Joel Holdsworth <jholdsworth@nvidia.com>
Subject: [PATCH v3 2/2] git-p4: show progress as an integer
Date:   Sun, 19 Dec 2021 15:40:28 +0000
Message-Id: <20211219154028.3288756-3-jholdsworth@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211219154028.3288756-1-jholdsworth@nvidia.com>
References: <20211219154028.3288756-1-jholdsworth@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR04CA0098.eurprd04.prod.outlook.com
 (2603:10a6:208:be::39) To BN8PR12MB3361.namprd12.prod.outlook.com
 (2603:10b6:408:67::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9a899cb4-d26b-481b-4249-08d9c305f250
X-MS-TrafficTypeDiagnostic: BN6PR12MB1186:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB11863928151D26FE0E96FD95C87A9@BN6PR12MB1186.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:293;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dvjCxhGP4AHHw65UCfmia+0igU8BpTKoFtSa/OXnI6F0xwK4yKJDL7XfXfAGcoEZrjaj57ufFIpaTr7jSEpO1haH+9npDlmDKByed4FN+xvOu0kkpkyDSRikiuulTI0G4QuxcO72/WdKLUjfDTR6bjX9hGzi0Q6P9wIRcKyecMFN4O3++cTLrWNSqHs4vdnlo66NArE+zsjMO8DJi3AJ5m2Etg4e63IoCKBfDyXB28XDvDvrm9t+uEbmtzmnc3nMSiV4j21vAnfDz3+f2o4fpT0cCtEplNBqdotoo0GYfvH4+1vT1S4WqXcblqqxo3qAmW83I1s5TLddj9fj1nTN4xK1Asf/6HMz9QSgZEXKXaX0M4jeouO85xXurdnwAqa8oB4Wqk3TYbDo214xDG2jfl+95NCMA/idMg5uUHUgVIBxBNGdQiLymZunD97E7p/lUIREtSv5lpMcsF+jBVDzpeL80Bt+PpHQuaEBmg7YJUqDBEMpuFVRk57jsq2WbyozCFLpstC8XFW0GETAT6LK5Jo86w7ri4PHynOEKJPyoX2HMloebt3WIAx6FqQnu21HC/oq8DXGLBKbmLvJ+C839hUvgVREq360PwKZXX8sSjZnKU2v55slnQcGTCuFZXGZx6WEX4XVebl/gQBCooMKzGA36uGO7i3SAnDQOePE4bKGEmefBUSpEw6dBvg5i6gD35xnR8aF16jndS5bSSjG1w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3361.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(83380400001)(186003)(6512007)(26005)(6916009)(52116002)(8936002)(6506007)(66946007)(1076003)(8676002)(66556008)(6666004)(55236004)(66476007)(508600001)(6486002)(2906002)(54906003)(2616005)(38100700002)(38350700002)(107886003)(36756003)(4326008)(316002)(5660300002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Fk8F2rWiq0K62cmm9M17DFypK4tF2irK5rRRhvd2ss/bskvQKMFCjrI1wh8/?=
 =?us-ascii?Q?3Zh9p92mmN7dPf+Q60a8x1JAYurMiqLbk/oQhPrC/RXLxN620/QaoQ3HE8np?=
 =?us-ascii?Q?+AUNmCopGJPjkzpWrbMMWqhrcZAbJvwpeYQojGZeB1KM+cF46Nv6Rgmnywzd?=
 =?us-ascii?Q?h89DoKUX6bDGgYZHUfNSy7oHX6PHLTJl4ony4UeZjvc4iget6+3wR9emDFfr?=
 =?us-ascii?Q?oZOZPSNzLzgvuTZszINHSKIZ3wSdYzghwsjmQP4muaGg9dutm4vOh+D7UrCv?=
 =?us-ascii?Q?CahaZkhJinQak1YvgrvFkWQLnZLf+MdQBUGfr2DEOgaXbnlVkyN4KdXDiNbQ?=
 =?us-ascii?Q?1XO1gIiKLenTNde0ohVeDbr513Fsd7LFIIspXWJcPQCrCTlf8ZEwR6QGWMSD?=
 =?us-ascii?Q?9GVoTVSRw5fm7iHigKE9kductWcaD7dEywzQ3IYngrsN3+tq6re1VQe6l2v9?=
 =?us-ascii?Q?kEhkr58m4bPuN2YCuJKlPTxG7wp5Maakz5wHZqObW9Ih+W3dsXjJeKYCpkVs?=
 =?us-ascii?Q?7XIXRwfBwQtQe+drZIUXQFdBZXOFUXn3Z2uktlbtTZA6ngKN9Xufr7weuVFr?=
 =?us-ascii?Q?h5Np1pmHED4/oujoBwDHQ8/9/PEahJVrw6vUgdOpigBZFaNFxFQqVcyyix5P?=
 =?us-ascii?Q?xDOydaFR4VKeZadd88ar/K5Hkoo+vtN19kN0R3wmeqg/u4GQN4t6IVCP3ak+?=
 =?us-ascii?Q?e9q0ew4GFt+lkqbdhSd8pA6uXppHzg9cTJY2sdkWFC/+AKR6wCz0Zg8BqyHe?=
 =?us-ascii?Q?kvy9GBaYwJ8xH9wB9GIgGKZIjuHqxokdTARZ/Gq0jo164Rv5q55KJ833dCwZ?=
 =?us-ascii?Q?jPXI7aIHvHZShEDFAtdV5rYTJvyo8o4qNOML2G0SivgpUdwKRivuHq9NObcv?=
 =?us-ascii?Q?HXILrinaToIROon+rDbfRFaTZPn9vnfAZr03xZcRA/xYO+V19TvuKIeswt77?=
 =?us-ascii?Q?3+TKtBYTNpnb65sjTNpjzejgzZDiHMSSkTalQNfPWphNRWtc2uor7797xYxs?=
 =?us-ascii?Q?tu2y7DaMpSJ6EnvVahgdJzMS83jG8y2s9GtFoxY7QaTY4NeJYsw3G+68EIvL?=
 =?us-ascii?Q?JqXkfVmGhcjB/8a5GZw2p6U8yCK19d03ZTnxcUchkF9Fq7vxckS2qxc3ysWt?=
 =?us-ascii?Q?Yq1ALCPSoSBLwb6JEpYVohzOSkQ+lZwbQVx1TdavUCQFM7GHARfGwia74QlG?=
 =?us-ascii?Q?GdzkvnObYcs2DMrGLP1y+t9wUJwSH7n7InzDGz1DQQY06vLWnVmhu9zRNZjT?=
 =?us-ascii?Q?qch7T3GTsZfqEiplzO9blaA8C43ETmRXDzptXFlXcpve9jtt/1btGFrPreq0?=
 =?us-ascii?Q?oBy926KBl4iwkoTTUoTLfV6zvfyyK8vNWvtnvqW890tVEjNwSaIdowprTXeG?=
 =?us-ascii?Q?E0Apf7UR+EBP7Tmxjod1vyAxll7tEep46LfUfWsJ0cEE5MOjp3pM+imOjf1Z?=
 =?us-ascii?Q?1dgQ6aEvQrdROeIHFcatgqA05Y3dus8IZSKKxFWkAlhej1pUAtGPf54TAWYe?=
 =?us-ascii?Q?2IINKkRiy5EokZ6cMrKmEsVsVyVLHTShkSQp4qQNPeZMbnxbIB6t+0Cn5QBM?=
 =?us-ascii?Q?ZuyoOLQvs3YP3tg2pHgjCkDuxNCeHEfmhuSgdVqvF5eXiJFGZ+WKqOx3A9ho?=
 =?us-ascii?Q?vRVUROw4UYhriwOXajr5jj8=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a899cb4-d26b-481b-4249-08d9c305f250
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3361.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2021 15:40:56.1552
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wmoJicx21e+Lfhmo1bXNTs4XWy0lSjYQIol94nflxu3DJjDATczYxAJ9QrHd+tiooQACC+erSkmOFCXOIifq9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1186
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When importing files from Perforce, git-p4 periodically logs the
progress of file transfers as a percentage. However, the value is
printed as a float with an excessive number of decimal places.

For example a typical update might contain the following message:

Importing revision 12345 (26.199617677553135%)

This patch simply rounds the value down to the nearest integer
percentage value, greatly improving readability.

Signed-off-by: Joel Holdsworth <jholdsworth@nvidia.com>
Acked-by: Luke Diamand <luke@diamand.org>
---
 git-p4.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/git-p4.py b/git-p4.py
index 74834736fa..a625077b83 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -3637,7 +3637,8 @@ def importChanges(self, changes, origin_revision=0):
             self.updateOptionDict(description)
 
             if not self.silent:
-                sys.stdout.write("\rImporting revision %s (%s%%)" % (change, cnt * 100 / len(changes)))
+                sys.stdout.write("\rImporting revision %s (%d%%)" % (
+                    change, (cnt * 100) // len(changes)))
                 sys.stdout.flush()
             cnt = cnt + 1
 
-- 
2.34.1

