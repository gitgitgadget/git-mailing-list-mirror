Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE1DB1FA26
	for <e@80x24.org>; Thu, 20 Apr 2017 13:54:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031577AbdDTNyF (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Apr 2017 09:54:05 -0400
Received: from mail-bl2nam02on0084.outbound.protection.outlook.com ([104.47.38.84]:13216
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1031575AbdDTNyD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2017 09:54:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=roku.onmicrosoft.com;
 s=selector1-roku-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=m1WkMvsvg1w6+1/ZkhxJQbWfQjxbW0QKMn7lQzf+0w4=;
 b=TV9dqnOvecvsuerie5vL7PTGtgpQpGUqVMgQ6vnFZ0cXKYopnvttOcTKV/q0ozuEQsoeCTCOuNC8ahb1K7jF290aa75n/GxHXjRvnwaQd34g+MzJC53tNwoqUO1TlUz9ShjGEx9PKCcHLGVStpelTC/Tm8xq5P68Rr21/9hcILY=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=roku.com;
Received: from aoakley-t5810.corp.roku (81.145.207.254) by
 BN6PR01MB2755.prod.exchangelabs.com (10.172.196.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1034.10; Thu, 20 Apr 2017 13:53:59 +0000
From:   Andrew Oakley <aoakley@roku.com>
To:     <git@vger.kernel.org>
CC:     <luke@diamand.org>, <larsxschneider@gmail.com>,
        Andrew Oakley <aoakley@roku.com>
Subject: [PATCH] git-p4: improve branch option handling
Date:   Thu, 20 Apr 2017 14:52:32 +0100
Message-ID: <20170420135232.16415-1-aoakley@roku.com>
X-Mailer: git-send-email 2.10.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [81.145.207.254]
X-ClientProxiedBy: HE1PR0901CA0064.eurprd09.prod.outlook.com (10.168.89.160)
 To BN6PR01MB2755.prod.exchangelabs.com (10.172.196.17)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 80f19c80-5727-4624-9a5b-08d487f4b2d2
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(201703131423075)(201703031133081);SRVR:BN6PR01MB2755;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR01MB2755;3:rdYWk/taDtJSTN2ykY/JbNry7W6+uqY969Z+9/nIE49Xm+kMN0O9psR6zt9UrbOMj3fMWZvmnS9Lpw/wOSCBGD3DGNqSskQTWcBxQH64IdnZ252QRDRFoPtAbyTUoQvvPInvYP9vl/6pMmSYDLTw9PByLScL/IxMwY//aBOmS4LE7gNb6K7Q7VV8yKHbh8/uDNEPBuehwKy+GdQgz+29U7O5BvfvO7+HpoWE97LEfg/qfW9mPwR4Hoq1GHbu6ERlS9lpXgDWnepsqS2dQIo75eQY9JW/w5TlwbL3SBrALDvH+OACkq1ixFYRqR3cd980lsKh2Fa9p8Ozsd6OwxFPQg==;25:ckCkxEpgGCk+jCDoAeHEUuoOA4JahSd+YhpmLMwVJgKhhS8BtyhZG6NNc2UrTeWKa6OozpA2AhFttFuPkyhAEGnYfq5r6p6IoFUt0M0tKeH6l3LH5MzMpzOEQ3CbTVUkEQlqH92QlXKDAi7pM8DNa3YrO5NUPC8xi4DT1zA6cpk6jr12reV8FZmHsNdLlEp+qdGj7E8Y2N1eDJug+RGsvbcVzxWi5em7N/kgqHvGCZEqyhojCGX/W4PkrpTxUiySXV5CjdMRLfOpEs06XIH+LW6L2rUMgxYmVsW5dvrA8ujvH2Mtjc/9VksdFRN3peK31gxbrompsSYAJimODyIaN+a7qdsWEVfdMbf7q/4a9k68qXf3SQvho6vXo6EgcSRSGIhgYPW3nCxAygk+7VazEXbgoSGVAiGrG/nEr2ltNwXDJSEM86Rrp6hWhCsWIAdZY+GkyZjNISBbACB//UqaFQ==
X-Microsoft-Exchange-Diagnostics: 1;BN6PR01MB2755;31:353Xzae75Mps7O5UdEW58cwwFUZA9r1WnE11Nx4ydwZjhLdsRGq3z18w6A02Ki1TSIFSHBLRrjVPkZjRuLgu01/brrRm68VZp7uh5oY9tAn7Pm00aGY57iefrZMoPcZpjD1gJIFcgfMxHlqsJqIe9v7sNIjbprVmIRkRlt3L6LpZrBDX4T6eD0sz2p3WOMOn90S//RTxP93RQYxZxnlMsfoFzPPTDYgp6NEVmBWw0ju3r5g12LRyFbzy74GJNlip;20:B3gq320J/TlXsBBvkp8e95gdOGXWkYM0Gyw1JMUTECWrGkW0BIfMeujNgDcx1Qp/WSvpBRtt/9/hSZO+mbgWGGFaUKorPYOGpXD7oJwh1rC9EfQBlCH7vK/t4Mk6/0NhwJPva5BtoWUon001Xm7FoB87rZDTBlVESkj5ctRc9WaIWwDLQ8oG3jlNk+NkQQZ18rghhPz8nJqB/n0MD4m0m1P6S6nVcKEWjlIVlQxyUdzIDmxOOEfQ9pURx+NaWEJKEBTj7aW//X9hd3SQgWFnSEiMST5c5R9RDIrQ2G3OMpGadVP48j7+j2jq+u9o0/+4NVvoGOwhMgScFluC72VAnZkBcooCu0O/0TYQOtXzzc+qgWStpgCufVxt9uep7k6Z62OzLJj7g2zkYXce1XIc5hm4ucPDzCUsjaEG5AGZbjuBzsntdqSpnGeN9k/jtSdhGjn1MT0XqCe38MBAxoocwE8+WBMEue54oC64D+owON+R+NnfLrJVc99ZOwK6KV6p
X-Microsoft-Antispam-PRVS: <BN6PR01MB275509620B218A4EC797AFE1C21B0@BN6PR01MB2755.prod.exchangelabs.com>
X-Exchange-Antispam-Report-Test: UriScan:(169088704739312);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040450)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(6041248)(20161123555025)(20161123560025)(20161123562025)(201703131423075)(201702281528075)(201703061421075)(20161123564025)(6072148);SRVR:BN6PR01MB2755;BCL:0;PCL:0;RULEID:;SRVR:BN6PR01MB2755;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR01MB2755;4:yP8lRgQPCywZ69lwVvcYjogP+XOhBQ59zUnJZUmumhA0WIQYAz0F80Pa79RJzkuy+hc7pQ8adrm4NcH3yMHyfpMk+q5YbPA8iXKZihRGOfi1cDKxaZR70+mfZc6Ed0IdmbArvFxHcK5kkHqSfyaEm48kzRGNtQkG8bXchuEDL+wBPZc3r1VIi6DEjHz4Gptmrr2VjlO9+QmB+ht4SpM8b/G2CDDTj4RU4Iyp0bSXHk0mdKy67dDgMM/kwRnC2VJ8H8pNlFU//leMx+kIJ3po4k5yXXJL5D8j64JcS9vh58EeFZxxNqyP++pavMznEiPCydSwc/NF9Y3sjhw/e+d35NhWQfzyA1nManimMr2IAqIGSsvLF0lUxssusBPEm36fSjpAW373KAnBiu7z3u3+34siR/VpGH4bt3nMkzLTEsnmpgl8u2ilkZr6rd/v9F0CHKNaHAOpb8V0pn6Es+iZhO9xITMfjCXSEvRMnTeXm0SaCVO2Qhx48UwG8eLqhzQwYicF33THbIScX2TV0Q+wqBdrSktJITSTVj4SpgwfEkHR0dYkle5qUPkdFnOyygw4tSs9pCrd0rxBH/ailHn/uEzG5Azpl080BxTcIiWz7OYlRj7CIvBzx40YYAFaiewp43Pj+GIF9HxT9dBWj2ZQBPqLEG3KKg0P+PQtgdCO5TOzgwn+3N4rmGWNUAf2d9HIPL7V1BjaOmdy5oEvclSL0dpgrZf3YBfBB9DnIbBJg+mWheXO1Qvef2KueGLEQLkV
X-Forefront-PRVS: 02830F0362
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4630300001)(6009001)(39410400002)(39400400002)(39450400003)(39840400002)(6116002)(1076002)(6916009)(6666003)(86362001)(5660300001)(66066001)(48376002)(2351001)(189998001)(5003940100001)(50466002)(3846002)(33646002)(8676002)(53416004)(6506006)(6486002)(81166006)(107886003)(7736002)(50986999)(2906002)(54906002)(50226002)(47776003)(110136004)(42186005)(36756003)(305945005)(53936002)(6512007)(25786009)(4326008)(38730400002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR01MB2755;H:aoakley-t5810.corp.roku;FPR:;SPF:None;MLV:sfv;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR01MB2755;23:0Iy67aNuWGCvkC2dDMLVHrXxfaOb68JlBdAPMb/DH?=
 =?us-ascii?Q?Ugc6FqmLK3u/NfKPSFs2qSXMDwpJrBqNOw2NFJcbeVlGGrHbjHI6cGNIG5XI?=
 =?us-ascii?Q?F5eM0V301IrGvMGFaclWS1qjs8kjrYiG6784p6DPxC7lWPYIREPsp2d1ABAy?=
 =?us-ascii?Q?3/84HllW24o0R+jO2ljKWNraHQd+BSATOLzFD3RG7/cQSOVAGbdx0VucNMTG?=
 =?us-ascii?Q?0W7LJTZOhVTa2BoQScVRThFrtK82mLsTtD7VUjUoPdzOqdCS0F5GWcCL6nmj?=
 =?us-ascii?Q?/q2EJUftC11AmBQOjl2jNogCpKAJsV0Z/8lBhkcjUWHKz1tvoIbiMLfKKP3a?=
 =?us-ascii?Q?mZftrhyX5t191+qOYEMx9dKdFGzoGfRycFvBCylxcJTWsfv1NaxwPBdwBdB8?=
 =?us-ascii?Q?h33XzCJdGRsRIYBf4T7qxq+tVugbSgju1QIIP7H/gNibPiGC6h6++S0HAcT2?=
 =?us-ascii?Q?/c8ymof1MfjyJOmlg0jj5uYad2zJvgbPisFZQ2i0LlLUjJhcd0bmXzrFZPYF?=
 =?us-ascii?Q?Iz5BC87wxdtpGET8HAWl5rd6Su9DJLZpIoCEiY3r+tuza/oIYfYja8ADVrjp?=
 =?us-ascii?Q?HpUnn4w0r0sULJ+6QjVCoV0yShtCOT7+gkC2lsdCzbbOVVOLGAxbKkxhLKSh?=
 =?us-ascii?Q?tHGsfSV2OxGept4vw0bwUro8xhOl1oZW0ROjdWSSDTZZBacsk71+hqPY5KHq?=
 =?us-ascii?Q?/M9qhIDjNSSNXoAKfkXGu7G5prLc1MVO0ZE2a60vvlymJ8jz03C1oaRMuqOA?=
 =?us-ascii?Q?N8bad7NR5HSb/iVRJDJ2s4/5lNqwC4YZ7WJMklwBDEsq36F+rO9uDESthLot?=
 =?us-ascii?Q?mSJamX9b8cgfS7ju1WDDZ3C9p4STx8x72QiI5uXUD2TqrI3rUerKOKjjeEw1?=
 =?us-ascii?Q?8zEYkkXEC+WDR0zIPQHejb3mq6uefGSzWnMCKS00r1FmVWYqsk8ba162DlRl?=
 =?us-ascii?Q?fit020MagRAfAphxBsX9MratSt36ORhWeTZztMllo7yT5m0NcPAlzpVsqFkK?=
 =?us-ascii?Q?3o3GwEsC9YDzd1YK1kVuAabyLiMN/C4l8MikEBnKH/yjg=3D=3D?=
X-Microsoft-Exchange-Diagnostics: 1;BN6PR01MB2755;6:RnDOv+WtsvOeNOfIpvfS5k4FlPKGa6zJjC95sauWR4IQTbAGgPGssNllss/hnFG/u+tPtaKdkuhThs+IzymglrsoEH8swxozXbJAvwRWH2aO9BjRKo9I+tNMUwPMstm+3ZAJSB+nuyoru6VcQSpAbckxWLhK7K7mzbemCJXCMcbLyhmHNw5GRGxP6ps849rL20eR4+iPPgKqCrXmJ/GoXqGdHATDsrscu24lW3mD4rRFXJYthd/69k1GGfPEdMnj5vKlb4krjd0ODCytQQZyGMTjiaI4tkxQwqNGhdUZvfufUySjZuYrzISwl5JCkLopB0+5JcWljUus2vNusqj51v2p13jbd3b6V7MMoGjrcXiMioWOApXkg6b0fBvPM8P2vDIu1nvOmv5oV4NxIOr0i4ro0fqv7Db4C5KrhThlqkRTCHw7hwFKrs35Wu6Q0fkTaVx5C+80lSzq8hZKxdWlXCwclWhAPYvSE1UYiw4KvAiwOadCa9OnNRyeFcWHGqQaVL57HPkJh5kvmt87lFwTlg==;5:kn9eih+FL71KOZfYpJ8PRHkd1TvLyJjnyOhb3mATi22pYNVUL6RjIXEdIn7bE6wy8tUEbQN/jNG/2W2NGdOT2oLp9cYewkWEF5Uxn0NbJYApKujJ9qUZ4xW2WYddI604z2xyi+QHmK5cSDAR5RSK8w==;24:5m0XAQPeHo+y6GU6p6gCB3H4hoyEFEshdlArdtl2MHaoKS5wVrZ5zHZHQvnXtoW/5cYc+tZdfJdYeOB9Fw0/CZLy2xKDQu1K6X2s8TFfRK4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR01MB2755;7:luGPWFdg2oZI6d7OnLrJoEwEAvodJzMmAAhyQGRgkFfrzsEAc4p7Slhecv/5TQb8a+PPwaiJ/tqYqW+/DK6pO6n+5NrZtSGFwMy2/TySHYI0Me04m7fu4jS5eO9Rc9QXzGGPVZOAAxlnG1gumi8fxhMpjx2AQE133R2XrUM27RTzg8MTbM/oGa1HTjI9q8BMqjUSZzTsnFOuSnyWc3W67S2XFr+ihqbuDPnaiq74JkeWlAFrWKsmSCKmPbXAtwXpzrwpaArZRqgA43uKu2YtmbS1fklvOoKgsWAjCEZbsWcM8KM3AzviYoIRBXFI8rTuD1RpXBQvp7QAeJjCeT7GgA==
X-OriginatorOrg: roku.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2017 13:53:59.8511 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR01MB2755
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It is sometimes useful (much quicker) to request commands only operate
on a single branch.

The P4Sync command has been updated to handle self.branch being None for
consitency with the P4Submit.

The P4Rebase command has been given a branch option which is forwarded
to the P4Sync command it runs.

The P4Submit command has been simplified to not call P4Sync itself, it
lets P4Rebase do it instead (now that the branch can be handled).  This
fixes an issue where P4Submit does a sync of the requested branch and
then does a rebase which does a sync of all branches.

Signed-off-by: Andrew Oakley <aoakley@roku.com>
---
 Documentation/git-p4.txt |  4 ++++
 git-p4.py                | 15 +++++++--------
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
index 7436c64..a03a291 100644
--- a/Documentation/git-p4.txt
+++ b/Documentation/git-p4.txt
@@ -328,6 +328,10 @@ Rebase options
 ~~~~~~~~~~~~~~
 These options can be used to modify 'git p4 rebase' behavior.
 
+--branch <branch>::
+	Sync this named branch instead of the default p4/master.  See the
+	"Sync options" section above for more information.
+
 --import-labels::
 	Import p4 labels.
 
diff --git a/git-p4.py b/git-p4.py
index 8d151da..e58b34a 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -2161,13 +2161,9 @@ class P4Submit(Command, P4UserMap):
         elif len(commits) == len(applied):
             print ("All commits {0}!".format(shelved_applied))
 
-            sync = P4Sync()
-            if self.branch:
-                sync.branch = self.branch
-            sync.run([])
-
             rebase = P4Rebase()
-            rebase.rebase()
+            rebase.branch = self.branch
+            rebase.run([])
 
         else:
             if len(applied) == 0:
@@ -2343,7 +2339,7 @@ class P4Sync(Command, P4UserMap):
         self.silent = False
         self.createdBranches = set()
         self.committedChanges = set()
-        self.branch = ""
+        self.branch = None
         self.detectBranches = False
         self.detectLabels = False
         self.importLabels = False
@@ -3281,7 +3277,7 @@ class P4Sync(Command, P4UserMap):
                 system("git fetch origin")
 
         branch_arg_given = bool(self.branch)
-        if len(self.branch) == 0:
+        if not branch_arg_given:
             self.branch = self.refPrefix + "master"
             if gitBranchExists("refs/heads/p4") and self.importIntoRemotes:
                 system("git update-ref %s refs/heads/p4" % self.branch)
@@ -3567,14 +3563,17 @@ class P4Rebase(Command):
     def __init__(self):
         Command.__init__(self)
         self.options = [
+                optparse.make_option("--branch", dest="branch"),
                 optparse.make_option("--import-labels", dest="importLabels", action="store_true"),
         ]
+        self.branch = None
         self.importLabels = False
         self.description = ("Fetches the latest revision from perforce and "
                             + "rebases the current work (branch) against it")
 
     def run(self, args):
         sync = P4Sync()
+        sync.branch = self.branch
         sync.importLabels = self.importLabels
         sync.run([])
 
-- 
2.10.2

