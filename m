X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 4/4] Bomb out when --ack and --sign are both passed to
	"refresh".
Date: Fri, 24 Nov 2006 00:17:12 +0100
Message-ID: <20061123231708.9769.53781.stgit@gandelf.nowhere.earth>
References: <20061123230721.9769.38403.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 23 Nov 2006 23:18:10 +0000 (UTC)
Cc: GIT list <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061123230721.9769.38403.stgit@gandelf.nowhere.earth>
User-Agent: StGIT/0.11
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32172>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GnNpU-0001hR-R0 for gcvg-git@gmane.org; Fri, 24 Nov
 2006 00:18:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S934251AbWKWXSA (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 23 Nov 2006
 18:18:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934252AbWKWXSA
 (ORCPT <rfc822;git-outgoing>); Thu, 23 Nov 2006 18:18:00 -0500
Received: from smtp2-g19.free.fr ([212.27.42.28]:60637 "EHLO
 smtp2-g19.free.fr") by vger.kernel.org with ESMTP id S934251AbWKWXR7 (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 23 Nov 2006 18:17:59 -0500
Received: from bylbo.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net
 [81.57.214.146]) by smtp2-g19.free.fr (Postfix) with ESMTP id 7C40BEE; Fri,
 24 Nov 2006 00:17:58 +0100 (CET)
Received: from gandelf.nowhere.earth ([10.0.0.5] ident=dwitch) by
 bylbo.nowhere.earth with esmtp (Exim 4.62) (envelope-from
 <ydirson@altern.org>) id 1GnNpi-0002t4-32; Fri, 24 Nov 2006 00:18:18 +0100
To: Catalin Marinas <catalin.marinas@gmail.com>
Sender: git-owner@vger.kernel.org


Old behaviour was silently ignoring --ack, which could be confusing.

Signed-off-by: Yann Dirson <ydirson@altern.org>
---

 stgit/commands/refresh.py |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/stgit/commands/refresh.py b/stgit/commands/refresh.py
index ea0fe6f..aa5ff78 100644
--- a/stgit/commands/refresh.py
+++ b/stgit/commands/refresh.py
@@ -107,6 +107,8 @@ def func(parser, options, args):
 
     if options.sign:
         sign_str = 'Signed-off-by'
+        if options.ack:
+            raise CmdException, '--ack and --sign were both specified'
     elif options.ack:
         sign_str = 'Acked-by'
