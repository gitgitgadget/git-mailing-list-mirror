Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9067EC433FE
	for <git@archiver.kernel.org>; Fri, 17 Dec 2021 20:39:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239572AbhLQUjW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Dec 2021 15:39:22 -0500
Received: from mail-bn7nam10on2087.outbound.protection.outlook.com ([40.107.92.87]:19150
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235790AbhLQUjU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Dec 2021 15:39:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NTX8hEKjEHUSAaAn0stgVejfaWUAG3xMDCxemVGy7JCKY7LeHKM5QedXhr5+qaECSZj6YGYYimIDdRwtmQpHzUmADaIeEKsEGq5ZEVCSb0FN5PM77oVAtzL06YKmWdo+Q7nMbLGldr34QTc+FleMn0rMeJxlY+gQ8NS2nLGjnhlaErKpzD5uZ2aWOvnh+cybK3SoNZ7ViGhgeAl8L07USaN5WrwIIUtT2Jq3bx/1pVaZpzv+fpgYxObiOl21X1m1FjlBn+23kYJoxHgs83MaEnKfIDddUfpymzUz2Z3RKeo03bpTaYyFcBvyQvs2CVQ2Bhn2AYVa0gnWp92mTT1QXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NIc13ty82B6sH/eaE7e7faNLZmRVjsP+pZLzsPKwcc4=;
 b=bqSQeKcjEAZkSkH/S5wR/sRsdj4maEJMrKMggtvPC3A+GrRZiGEXE4CJVejxiYe1Qk22NP44kWW7kNCqNUkV9fN2VJtiJE6Mf9P8yB+qB9zMs5pMaKkSbDz4aLnkDiFQ9k94vVhIYeLpdgFVl+3VTm3rwyRyq8ON9PbrViYyZMNeU01c4O0akRShqLpynXgHMVkaPuUJ0K0Qror4pefLiEsBeme/wVBiMUfYVbczonmiy+auoydDDytG7Xd3iNnDD49hmsiNbjw2nCiwMI+i1C/A0ChHrSbvyvsBPxky1lsrC3HyCwG8vgAOZ/I2mAyUH5v2DacpsWZfTEKM9rBfPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NIc13ty82B6sH/eaE7e7faNLZmRVjsP+pZLzsPKwcc4=;
 b=C6kMRPbjIjROkGU1Q//2Zwn5KXELcLlXQtPIO90/iZn/3CiclsNVef8Q+0/uKun3V7fWMkaNd3n6z8e6DO/pIEhv6Ldv7pZzD2UCHhgpbhK179UI1Y8Q9QWVYkfEjigAaDSqQEg5m8R/Aq+LaF/pNfBOVJ6ADCEcIt08lmv2Vyg8FWpSG5PEhOYrcwQ5dF+/7uDZPzcaJUytVxPIjiqLs+A/+wAlRUtXnKZ084xQ7Mpelw7UGSdpHz31RG/RjRmqdW/8BRFZsYj9lzlx+P40p/D/GroLBkDWbd7GybFU05GagAguGX6Ai6QSTDgpnVhxqoxnohyuWfd+6P2t8h66fA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN8PR12MB3361.namprd12.prod.outlook.com (2603:10b6:408:67::19)
 by BN6PR12MB1652.namprd12.prod.outlook.com (2603:10b6:405:6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.15; Fri, 17 Dec
 2021 20:39:17 +0000
Received: from BN8PR12MB3361.namprd12.prod.outlook.com
 ([fe80::4063:6e26:a906:e592]) by BN8PR12MB3361.namprd12.prod.outlook.com
 ([fe80::4063:6e26:a906:e592%3]) with mapi id 15.20.4778.018; Fri, 17 Dec 2021
 20:39:17 +0000
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
Subject: [PATCH v2 1/2] git-p4: print size values in appropriate units
Date:   Fri, 17 Dec 2021 20:38:55 +0000
Message-Id: <20211217203856.2339161-2-jholdsworth@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211217203856.2339161-1-jholdsworth@nvidia.com>
References: <20211217203856.2339161-1-jholdsworth@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS9PR07CA0012.eurprd07.prod.outlook.com
 (2603:10a6:20b:46c::17) To BN8PR12MB3361.namprd12.prod.outlook.com
 (2603:10b6:408:67::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4f65ea73-8f9b-44ca-4667-08d9c19d4b1f
X-MS-TrafficTypeDiagnostic: BN6PR12MB1652:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB1652035D0BC16B9076DC2498C8789@BN6PR12MB1652.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Cjx9HaI0CnO9lg678JjOMhCBetDb4Pelh5UjYIMMXqFdMt/X5OtZdrrIK2ao4yT1N3/YqQfSHoz8SolGDgODlzFDYmI/HkYGIrqCnR44PcXADVXWg0nugtjJ15dlO2Z+fU+wRtAJdK3lfbqirxnQsRFfxYSeDBsuiFP8VVEQD9i4XBUKMyqurkgj4sms0Yteaqf4j74xwpRAZJ5AqNOKDK9FWuCAIJY0lbv3UsPnHlBnUgQlSWEp4u+IjwykNKG8tQz3tIbBefjpcjfKt4398NsggPfGzEcyS3QRC9fB2iEeXIU+YX8A/z/Aa7zqn7ZS+jaJeqB6mcPY8l463WsESxc8EsLyHun7lsBV8dfk1YRd8tfmL+86KKU0GQF2/vaL9RadMpagyk4MyEYl5I43Cm9BNje7OUsQKxnDIIkZqrOTF+fS7UR9Ztj/34V/rJtQ3WjBGZ8ZkBFHIax8qx08jWJ2bhLFEuoFMn7PC4k2Ry54DC1b8nI7L54jFKxhfyj3hrliKZkFwLh/FyniAV2jCDaJQOW185ZvA0bFg4VINPPpCANZnBFEzPAJRBbZiqAifcwqkNuu+VR0c5ntFkkgMMWQ3j/gdiOXvWWyNNWyneUDlV2j3SHRpNTlVP5o4VdO/ZMc+KdmHOhOltB43wdYLP+M5VsA7BJ8/8AlawOMLviDh9CjbHHEpLXHpfOXG4Fu3REI8myugDuTGWzDz7wa0g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3361.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6666004)(8936002)(66946007)(8676002)(316002)(83380400001)(52116002)(1076003)(186003)(36756003)(54906003)(38350700002)(508600001)(5660300002)(26005)(38100700002)(4326008)(66476007)(2616005)(6916009)(86362001)(6512007)(6506007)(6486002)(107886003)(55236004)(66556008)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bVrsX4whnN19TQnup/4g5jH8Kc8ZxLPPSlpmc7ksuNvpjmiEEsSG4MQvksB4?=
 =?us-ascii?Q?hDDMcIPCyACFZ46azmLxaruRoN6RLi3eP0PdGHvmbq0RdqHDpsQr02OlvrRz?=
 =?us-ascii?Q?5OwcF2xD+rqDILs210kf6n4I8+fbJcFs6infd2en7vviQLFlqcc51/f0EBWn?=
 =?us-ascii?Q?jmgW4w0JqiRZcSsegrrJ0Qmp6j408YEcil77ZjOhGJFZYVVgpnWpdEeouDmA?=
 =?us-ascii?Q?Hzqr9N/EDzm9VYn7PCPYVIQRNGSTv4uDMqQcTOeSnLcMjgjjt77eOKK+vbo+?=
 =?us-ascii?Q?e5zJAFueTToQzG2ql1EHmH7ENVxJO9fC8AnuSfV7bIaqoPKyDeJ9QXwjyxVW?=
 =?us-ascii?Q?tRwEzLAYvSpD2IuGbVutmqaII7BO5xBGlO4BJabb9j3G9p1BcmdFJ6q+OIg5?=
 =?us-ascii?Q?MnAQ/6bWVkPZeY6dsJGeL5JBt8C7Rs/G3IYAg+BcREugDIfIvCis7ORX0aJo?=
 =?us-ascii?Q?lakvQTJTEHWOs3Buhc0gYuV54yLMkAjbvo48tVZcLHD/zlvDEI8LVRpx1Qkp?=
 =?us-ascii?Q?vahlcrFI8NBK330nZztv7plfRnWQ32v7dxmYTNW1boQsM3tCjtHGh1WhLi+d?=
 =?us-ascii?Q?xEFxqO5W6idQbU6flmP5KlCf1f7g/nwtIpYqmAvQisDiGWS9pNMZcWqFrbiT?=
 =?us-ascii?Q?IjGYiMJkdTQB6gt41KOI6cWaKhrCaS0ZIlJXbuiaaY6WHvD1jIJIc1lLpI4o?=
 =?us-ascii?Q?Ffr7IYM2ld7se1S3pjtFh0LdSrL/J/x+4zU948EWAyerKKbKhx5jOwAlYRt0?=
 =?us-ascii?Q?DtHkT92QELNq55s1RKnCw7XMTj0G37Qgrf7yZ46KrWtFVpC9NzgOqJ7FFcbZ?=
 =?us-ascii?Q?WZghRDUksoVWFTZt7fD2Mz0dbPIzYqN1gR3NDwc6TZzG2jcagW0VCtl3hyrv?=
 =?us-ascii?Q?s28mNbpKOIerUZXA36Sm/7xU7g7NZOG+nPo6v+m6X82HVtNS0YcPI8rVcH88?=
 =?us-ascii?Q?5qFi73ZJmtnj801V8rPnN4rZCbd2Dq3MGZzwqeO/N1dYHkY/SO4YD8Z1u0EZ?=
 =?us-ascii?Q?4LnN0JMvGJy6NrzByoAITd2rZxQM0ciKUil8/ka9OSsqVjM28Kz8Z9JPnl6A?=
 =?us-ascii?Q?2PvVVQ3AlkwUZzR9rDGoQC8mwr6HkrBJxaO4LvquBXmwTnEG997cUWxpzNpd?=
 =?us-ascii?Q?vKIELIXAl3QsLjD/nFL7orz9Lo9WxDg/+GW1tkTR7enQ6EXrKSswb089kbQw?=
 =?us-ascii?Q?h8A9XgwTSWFrkjecIq04Kf2hTa7XswxDUNVRthqop5HbZ1FqTqtnq9WOpUjU?=
 =?us-ascii?Q?dCOci3lnF/iho8XM83lsnzEShrDSvBpM9PlfVLDMZhhsfi2Ta0QgIz7JJSPy?=
 =?us-ascii?Q?4PZttxp9ROcT+DllA6GaA6Zl9VGGLc5goesNR9yKlJu49WsqpcV/FF6w2Os7?=
 =?us-ascii?Q?sGcUqgdWqtinbrFzSLS98OMKLdTE+UTyCQGNtww8N7W5XB6gfNkrATNbj13R?=
 =?us-ascii?Q?u+3SktWvPZBI0f8bY9U8oXawL0e1A+RSkZxDsDZpILnYLS1qzf3szeqs9Er3?=
 =?us-ascii?Q?XNYVvsUYWd9Q+74C51hg+HgbDUOEIwLL7nI2R0htPjGpuHl8duXyLDGMwpMu?=
 =?us-ascii?Q?JnRRwFUxyswdB7bGrFrn8fl+g/316IXyekdITmT7kHAELh4Uqm6VA5Yf0iqG?=
 =?us-ascii?Q?FWof8yAp+eJrx+/TyDyY20E=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f65ea73-8f9b-44ca-4667-08d9c19d4b1f
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3361.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2021 20:39:17.0579
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WUOXJJLyRJA557i7htQh3OilqwHLiWCI5hu9+wbSpC6Nxe/IkwoOEO3i0y/XKzjQvHsuo9cxbarutdeiYe4zIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1652
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The git-p4 script reports file sizes in various log messages.
Previously, in each case the script would print them as the number of
bytes divided by 1048576 i.e. the size in mebibytes, rounded down to an
integer.  This resulted in small files being described as having a size
of "0 MB".

This patch replaces the existing behaviour with a new helper function:
format_size_human_readable, which takes a number of bytes (or any other
quantity), and computes the appropriate prefix to use: none, Ki, Mi, Gi,
Ti, Pi, Ei, Zi, Yi.

For example, a size of 123456 will now be printed as "120.6 KiB" greatly
improving the readability of the log output.

Large valued prefixes such as pebi, exbi, zebi and yobi are included for
completeness, though they not expected to appear in any real-world
Perforce repository!

Signed-off-by: Joel Holdsworth <jholdsworth@nvidia.com>
---
This second version of the patch makes the following changes:

  * Corrects an issue with the messages being suffixed with an spurious
    "MB" text.
  * Makes the units of format_size_human_readable hard-coded to bytes.

 git-p4.py | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 2b4500226a..4d8a249b85 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -56,6 +56,16 @@
 
 p4_access_checked = False
 
+def format_size_human_readable(num):
+    """ Returns a number of units (typically bytes) formatted as a human-readable
+        string.
+    """
+    for unit in ["", "Ki", "Mi", "Gi", "Ti", "Pi", "Ei", "Zi"]:
+        if abs(num) < 1024.0:
+            return "{:3.1f} {}B".format(num, unit)
+        num /= 1024.0
+    return "{:.1f} Yi{}B".format(num)
+
 def p4_build_cmd(cmd):
     """Build a suitable p4 command line.
 
@@ -2966,7 +2976,8 @@ def streamOneP4File(self, file, contents):
                 size = int(self.stream_file['fileSize'])
             else:
                 size = 0 # deleted files don't get a fileSize apparently
-            sys.stdout.write('\r%s --> %s (%i MB)\n' % (file_path, relPath, size/1024/1024))
+            sys.stdout.write('\r%s --> %s (%s)\n' % (
+                file_path, relPath, format_size_human_readable(size)))
             sys.stdout.flush()
 
         (type_base, type_mods) = split_p4_type(file["type"])
@@ -3064,9 +3075,8 @@ def streamP4FilesCb(self, marshalled):
         if not err and 'fileSize' in self.stream_file:
             required_bytes = int((4 * int(self.stream_file["fileSize"])) - calcDiskFree())
             if required_bytes > 0:
-                err = 'Not enough space left on %s! Free at least %i MB.' % (
-                    os.getcwd(), required_bytes/1024/1024
-                )
+                err = 'Not enough space left on %s! Free at least %s.' % (
+                    os.getcwd(), format_size_human_readable(required_bytes))
 
         if err:
             f = None
@@ -3110,7 +3120,9 @@ def streamP4FilesCb(self, marshalled):
             size = int(self.stream_file["fileSize"])
             if size > 0:
                 progress = 100*self.stream_file['streamContentSize']/size
-                sys.stdout.write('\r%s %d%% (%i MB)' % (self.stream_file['depotFile'], progress, int(size/1024/1024)))
+                sys.stdout.write('\r%s %d%% (%s)' % (
+                    self.stream_file['depotFile'], progress,
+                    format_size_human_readable(required_bytes)))
                 sys.stdout.flush()
 
         self.stream_have_file_info = True
-- 
2.34.1

