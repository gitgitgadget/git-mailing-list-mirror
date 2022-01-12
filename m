Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2190BC433EF
	for <git@archiver.kernel.org>; Wed, 12 Jan 2022 13:49:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353708AbiALNtZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jan 2022 08:49:25 -0500
Received: from mail-dm6nam10on2057.outbound.protection.outlook.com ([40.107.93.57]:44001
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1353701AbiALNr4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jan 2022 08:47:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m0tA7rFgKMtg/OXufQICKSVvdPIbqULH8zsW0ucaw1yOXp+tuUVCo2dkTwk/7+l7UTchjFDuwvhp6WkKN8QrHF3iqbp0hzAY16A4FlpqcP48GI8+vebipmubETNbkiRV1lohP9iuCuslfjMTxROop514RmHQKimA9YJgsDTY/CcmOHvEhvqzz61B6kRzVWX6eYyPLgciWKNApm6cucsOKBFKS56pbkdq/JK2Vy7smYD6mn0i9pgPjOKXElBS4wf9FvLpmod393M+1iSINg+1kNUw4NVTy8km7kP6/+thRuzVbJ5gBrc009IScgOZCDgRvHcIQhPiuKQGqmngbgIDYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wxds9ybv9Of3vjOuabhzf1oske6FKC7HVnBpUySNMIU=;
 b=Vv/Qqf5cPsCvmNw9bO1q9ZUCMczHQd69Z6iXe9XDjOYZQoC1EjZAj/ZS2fpLFf+Em5ujl3JDKrcIJb4wrH07GisBwiw1CMIj2bSW58rHTDaOG78atEsYjFhySv/+0KSQjHT5/BFSR+uM9BEiffEXuiXQh+A44XVQS3/auv5iXdcsMNGU0vbwre/aUbeIeC/pWm2PCpCEQgBwc7PEWfty9Vg7O2vJfC7Beug5N2ilUKb2suiiV5anvzas6YGpY0AaVFXvMkcdNAem4Yx1kDMVmnNLX32pmHF0KQCBVw1mE8gZuCaXDe3gYZnk5EhH9iGlMbMDBqxmfLP66Z/Rl8INEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wxds9ybv9Of3vjOuabhzf1oske6FKC7HVnBpUySNMIU=;
 b=JZK6bC4TfBziDa7hKtYhGC25wD8q4NCGT5VLaSnY1ENyE3eOgEMQ/nN6oGZ5h9XIFej2aMBNVa2y7n16mK8WhLGg2pGzbiBDUU4/8NzJNBePntRnG6c9brGdkB7cFzCx3gBmGlumlUqfJJSa+J/v4f8k4dy/wnv9KApbUmOvbBT5SCBolgB4z2CKGLuf3f6Els1Gu781oBuTxVrc1/43MhFXPS/idfhzK1PFp6QvkpgPLJwG8ZAiR2f16NBbdeYyiicnU0MAoBVjlcOYMVK6R+q5mXxjbDnABXzBjtYJDAuj2wWRpox0Cfb2eed/LjLBpvWg9qCLQa+rhkajZy/Waw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB4849.namprd12.prod.outlook.com (2603:10b6:208:1c2::17)
 by MN2PR12MB3693.namprd12.prod.outlook.com (2603:10b6:208:159::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10; Wed, 12 Jan
 2022 13:47:40 +0000
Received: from BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::509e:bbb9:e1fb:26ed]) by BL0PR12MB4849.namprd12.prod.outlook.com
 ([fe80::509e:bbb9:e1fb:26ed%4]) with mapi id 15.20.4888.010; Wed, 12 Jan 2022
 13:47:40 +0000
From:   Joel Holdsworth <jholdsworth@nvidia.com>
To:     git@vger.kernel.org, Luke Diamand <luke@diamand.org>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Cc:     Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com>,
        Dorgon Chang <dorgonman@hotmail.com>,
        Joachim Kuebart <joachim.kuebart@gmail.com>,
        Daniel Levin <dendy.ua@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Ben Keene <seraphire@gmail.com>,
        Andrew Oakley <andrew@adoakley.name>,
        Joel Holdsworth <jholdsworth@nvidia.com>
Subject: [PATCH 16/20] git-p4: tidied visual indented lines of conditionals
Date:   Wed, 12 Jan 2022 13:46:31 +0000
Message-Id: <20220112134635.177877-17-jholdsworth@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220112134635.177877-1-jholdsworth@nvidia.com>
References: <20220112134635.177877-1-jholdsworth@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM3PR04CA0137.eurprd04.prod.outlook.com (2603:10a6:207::21)
 To BL0PR12MB4849.namprd12.prod.outlook.com (2603:10b6:208:1c2::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4564b66e-6f63-4fe4-978d-08d9d5d219d2
X-MS-TrafficTypeDiagnostic: MN2PR12MB3693:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB36938415DEE21A143D1CE215C8529@MN2PR12MB3693.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1468;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vtoQeSmMV8nvV4BY3DfLck6hb6y7nalBDRU0TpDf9ff5jcJxvFMLKCU0J4z/1aa8iW+eQz/Mm6MH8MsXjAfm/lmUn7QcO/535EnLU4Us4wTDISdmH9H4DOPUs/7V6L87mNJJFzJd5/uh32APGfIEyeUghXW0IhENH59rBGZn5icBUay9saaQMd58wCkyh9UKag833DENx8e5/b1uJaWyJB/L/qKb5Zz7A4i6SOlJDsKymv1x+Ypa/ICxauKzlrExWpfWpAxbWTD2EvuimKy38FYL2BfmmRgyT+DOgQQ0nAE3I6XVQrgz+75kasQ+3rSZQLt39wzxyXGoBe1UTW1C/XhQJ0i1mhZypCGDLdkkNFyoPtGitLvSb2Ip56Ioe47xg24uIEJYOL8oUcjz+b//PddJLytqlQDQ3ZBmSktfJ09Pg1aJ7Y50XRBeBtPrQBzu8FDszJvm+Nt6Ryz2Te+Vj8TrjjmE/ZEycqyl028pYwAaH9iGkk9FQhQcEz3qXUulqcPhpPr9oYI3IvJ8z0Z97+c1HwkdICoF8btVBm51BuRSJDTnXsXU63Pci97x3mDesfFy+YQJb/P/1obZKfZQYCYW/jyijMF3yPzvkZqUpugO/FyVCQWBEXejPo6fqZntZXy728QIzLxOTULmJmPpXLP9j8BLFLW4iPj5a8eq2tJJIEuLXN3S3tUCAytXHwMktggXY5hAlvYOBmgfYN4swaz0rOdcnm9C+mScWfX+WPuWAzIXgCa5440nqoDSetsj2VNgyBUxcdT4GwSZVo717vAOEuVQZtE51nZS0QZCHJg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(1076003)(508600001)(7416002)(8676002)(107886003)(8936002)(4326008)(86362001)(966005)(2616005)(186003)(6486002)(66946007)(66476007)(66556008)(110136005)(6666004)(52116002)(38100700002)(38350700002)(6512007)(26005)(54906003)(316002)(83380400001)(6506007)(2906002)(36756003)(5660300002)(55236004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3mQsVDhpfeHdsqQhl7YLigWPh6vIaYx/dbYDAnvEznrJuNI/qW/Un+QvTo6A?=
 =?us-ascii?Q?AfKkMHcJEBhkDRRGDmg4f6Zvv1GQ5lp0EGZWegHrfSDQFvf4luwLmTFt54GL?=
 =?us-ascii?Q?CK0CVqmqzZ/QIGljfv50js37p7vSFaPRy04w7ToizZq1RscJt829MPu1eeo9?=
 =?us-ascii?Q?OtbJsWGuh/z62ZEGL+jUCCZ1F3ND5HThzaihx50xeSl95dCSzzZswN/P4Jqo?=
 =?us-ascii?Q?gSfz1Zsl2QxzNo35FJqIF/kJMWAh+jC4PVq61FZqcH9Vzq4/qAhboayF8WSU?=
 =?us-ascii?Q?ykzhMicjJsYhiVnuuGLa7NgLm1Lm6h3azY/lzURaD/vNlLgIlYhXBv2+B3qX?=
 =?us-ascii?Q?rx6s5odYAnPZ6L5e6dOziDMB8CsIPxK0nQwS6I1Zn70DrDL9SiJyRcU5QZQf?=
 =?us-ascii?Q?PZCIVxY7aSdXkuMn59jTzyqnMpaLi5wnPtOkOYfqyarMQWnu5SLPjBaEtHP3?=
 =?us-ascii?Q?satTWKM4wNb34IFMxqBthGUtTAY2Yi4QSs2a9jfW96iSOAGdRcKYCjeK/rCv?=
 =?us-ascii?Q?x+/VPRYV+OIGgwACsjjA5gEzKOfhD3H0U6I/k/qmqCIWOsCc8KIlhn8XFpMJ?=
 =?us-ascii?Q?7ii9u1KYbZuDHHQMoQyI/DuvG57N50SOLTn1fP+1pv164OEo4jwSjGSEPcfl?=
 =?us-ascii?Q?NfkiReqcKFNGrRDG2ubpmrMJIft40uI9Tlkp/d9BVe5NCiaFm9F+XdQkCyhq?=
 =?us-ascii?Q?y6M3T9ovntkFmgyikEn98BBoUhw5Fe5oDyJZsFxEMOOmy9vQ7/BsWAcWyPLH?=
 =?us-ascii?Q?MxG/pXOmxa44xNzaRjAL0+FAmlByMZp1fAhATLaruQbHwVNhmlVOkeoOu+go?=
 =?us-ascii?Q?mEeCISUCMH/cPVGgBhzxdudCIxokfBC8fCUz7gM/y1F4mExqP1xGsqiPDJU6?=
 =?us-ascii?Q?asbFGXC0rtViRFEbYOOOutEb3Mpg54GiER7DyTXJd515+BlcaZeACn+jkP2M?=
 =?us-ascii?Q?J1uhoHXxLvT+nXkepxIgKMkMsqRYTuzBipYDpEbgAzo+viCILUy/rbyRXrKd?=
 =?us-ascii?Q?6VdPboL9G2eB6+n+ipEC/KxZ0yBwrdhcRxs2xT+S3AxJrvBmILZfWsEuojne?=
 =?us-ascii?Q?BWmXGVsffj210pJoN3PoqNpwxJIKMsGGQ34SUYOsJ73/ehK9V3fixmbM06YR?=
 =?us-ascii?Q?Fi72cLFpqGlU8sLy1mCqfXdsw4/CXR0xHqVyAdL2q6LfJjkNgb+XMsDHCDtZ?=
 =?us-ascii?Q?tIL6Nlc1Ccj/5brcy+mP5YFSA/pMPstYgl9yROXBRO+gehozkRfUQ+Kw2vn0?=
 =?us-ascii?Q?xQhAry5IJeQGQkSggJTkFcF8I35/5ssljDJYSTzeMraKeNINUCbEJvKKKH4X?=
 =?us-ascii?Q?Jf23wLiZ/GIDYZumd1sv8qxvfIUFBS1BvsRtws5dADpZyQ1DOgX55so3ktsC?=
 =?us-ascii?Q?PTwIcN8sEO9oRjVsqpgYvnXO8OdSUsKG6DCIWQCN4AJcKoJj9ep/oC7NcRXR?=
 =?us-ascii?Q?dqzJsAsT2aqqb6kwhBVWr+0qz87LFZoQFpfP3LZkGq/cASIYc0mUncDn5Ucr?=
 =?us-ascii?Q?FbpneY/YLfnahFGzumGJYilHmPobA4u0XBfl5V0l4aTOCLkBRa/uyVsVmgnC?=
 =?us-ascii?Q?1wAlQJBaq6HS/dkr0DhAfzaWvKlRl6NiBxonrmP6yE/P+Ojjlzc2PmbpyUSx?=
 =?us-ascii?Q?c0oS03wV8c8vZE0mtPyoVa8=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4564b66e-6f63-4fe4-978d-08d9d5d219d2
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2022 13:47:40.4122
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b8wzWFT4xYqF6kqJagPEi6f/CskE0AdbQ5oHRmsmrql2Iqrjbeu63P2hvFvOKFqtvei2yuEfyLU6pc7CNU/6NA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3693
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

PEP8 recommends that when wrapping the arguments of conditional
statements, an extra level of indentation should be added to distinguish
arguments from the body of the statement.

This guideline is described here:
https://www.python.org/dev/peps/pep-0008/#indentation

This patch either adds the indentation, or removes unnecessary wrapping.

Signed-off-by: Joel Holdsworth <jholdsworth@nvidia.com>
---
 git-p4.py | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 90e7922ebd..0159e35adc 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -1158,8 +1158,7 @@ def createOrUpdateBranchesFromOrigin(localRefPrefix="refs/remotes/p4/", silent=T
         originHead = line
 
         original = extractSettingsGitLog(extractLogMessageFromGitCommit(originHead))
-        if ('depot-paths' not in original
-            or 'change' not in original):
+        if 'depot-paths' not in original or 'change' not in original:
             continue
 
         update = False
@@ -2170,8 +2169,8 @@ def applyCommit(self, id):
                     if regexp:
                         # this file is a possibility...look for RCS keywords.
                         for line in read_pipe_lines(
-                            ["git", "diff", "%s^..%s" % (id, id), file],
-                            raw=True):
+                                ["git", "diff", "%s^..%s" % (id, id), file],
+                                raw=True):
                             if regexp.search(line):
                                 if verbose:
                                     print("got keyword match on %s in %s in %s" % (regex.pattern, line, file))
@@ -3181,9 +3180,9 @@ def streamP4FilesCb(self, marshalled):
                 self.stream_file[k] = marshalled[k]
 
         if (verbose and
-            'streamContentSize' in self.stream_file and
-            'fileSize' in self.stream_file and
-            'depotFile' in self.stream_file):
+                'streamContentSize' in self.stream_file and
+                'fileSize' in self.stream_file and
+                'depotFile' in self.stream_file):
             size = int(self.stream_file["fileSize"])
             if size > 0:
                 progress = 100*self.stream_file['streamContentSize']/size
@@ -4000,8 +3999,7 @@ def run(self, args):
                 settings = extractSettingsGitLog(logMsg)
 
                 self.readOptions(settings)
-                if ('depot-paths' in settings
-                    and 'change' in settings):
+                if 'depot-paths' in settings and 'change' in settings:
                     change = int(settings['change']) + 1
                     p4Change = max(p4Change, change)
 
-- 
2.34.1

