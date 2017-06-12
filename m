Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF2D51FA7B
	for <e@80x24.org>; Mon, 12 Jun 2017 08:02:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751796AbdFLICd (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Jun 2017 04:02:33 -0400
Received: from a7-11.smtp-out.eu-west-1.amazonses.com ([54.240.7.11]:54578
        "EHLO a7-11.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750730AbdFLICc (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 12 Jun 2017 04:02:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1497254550;
        h=From:To:Message-ID:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=Tfu49brScLzm22n4LVa6XDZONx1S+XCPyd/r4FQk0SU=;
        b=e1KVS53/ru1z+Ltsx7fNY7JFOuugQlGeROiGzA0NSQGGQjSpoXts1ciL8+McbRMe
        EUTQ+TE8GY3stY2pJ6Hm++WD9KUmeCCNNWuHzJCLqm0APFXEZLsiCy6GAggB1OB7mNI
        huZykUO3ZZ5usgWH1/XvX6tQPHrhhmf4TyXcAguY=
From:   Sergey Yurzin <jurzin.s@gmail.com>
To:     git@vger.kernel.org
Message-ID: <0102015c9b535a84-fd59d55d-387a-419e-b8ec-439873c4b7f5-000000@eu-west-1.amazonses.com>
Subject: [PATCH] Fix KeyError "fileSize" in verbose mode
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Mon, 12 Jun 2017 08:02:30 +0000
X-SES-Outgoing: 2017.06.12-54.240.7.11
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Sergei Iurzin <sergei_iurzin@epam.com>

---
 git-p4.py | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 8d151da91b969..b3666eddf12e3 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -2523,8 +2523,11 @@ def streamOneP4File(self, file, contents):
         relPath = self.stripRepoPath(file['depotFile'], self.branchPrefixes)
         relPath = self.encodeWithUTF8(relPath)
         if verbose:
-            size = int(self.stream_file['fileSize'])
-            sys.stdout.write('\r%s --> %s (%i MB)\n' % (file['depotFile'], relPath, size/1024/1024))
+            if 'fileSize' in self.stream_file:
+                size = int(self.stream_file['fileSize'])
+                sys.stdout.write('\r%s --> %s (%i MB)\n' % (file['depotFile'], relPath, size/1024/1024))
+            else:
+                sys.stdout.write('\r%s --> %s\n' % (file['depotFile'], relPath))
             sys.stdout.flush()
 
         (type_base, type_mods) = split_p4_type(file["type"])

--
https://github.com/git/git/pull/373
