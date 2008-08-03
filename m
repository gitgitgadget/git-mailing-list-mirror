From: Johan Herland <johan@herland.net>
Subject: [PATCH 1/5 v2] Add testcase for 'git submodule' with url.*.insteadOf
 set in the super-repo
Date: Mon, 04 Aug 2008 01:04:36 +0200
Message-ID: <200808040104.36603.johan@herland.net>
References: <200808040057.00221.johan@herland.net>
 <200808040100.02944.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 04 01:05:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPmdx-0001la-CX
	for gcvg-git-2@gmane.org; Mon, 04 Aug 2008 01:05:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758717AbYHCXEk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Aug 2008 19:04:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758330AbYHCXEj
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Aug 2008 19:04:39 -0400
Received: from smtp.getmail.no ([84.208.20.33]:43962 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758104AbYHCXEj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Aug 2008 19:04:39 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-009-z2.isp.get.no by
 no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0K5100E01S3QPM00@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Mon, 04 Aug 2008 01:04:38 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0K5100B6FS3O5720@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Mon, 04 Aug 2008 01:04:36 +0200 (CEST)
Received: from alpha.herland ([84.215.102.95])
 by no-osl-m323-srv-009-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0K5100CIRS3OUW7L@no-osl-m323-srv-009-z1.isp.get.no> for
 git@vger.kernel.org; Mon, 04 Aug 2008 01:04:36 +0200 (CEST)
In-reply-to: <200808040100.02944.johan@herland.net>
Content-disposition: inline
User-Agent: KMail/1.9.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91290>

Currently, setting url.*.insteadOf in the super-repo in order to rewrite
submodule URLs, don't work. When cloning/fetching the submodule, the
super-repo config is never consulted, and thus the url.*.insteadOf rule
is never seen. This adds a testcase that confirms the current behaviour.

Signed-off-by: Johan Herland <johan@herland.net>
---
 t/t7400-submodule-basic.sh |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)


The previous patch was whitespace-damaged. Sorry. Trying again.


...Johan


diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index cbc0c34..bafc46c 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -209,4 +209,15 @@ test_expect_success 'update --init' '
 
 '
 
+test_expect_failure 'update --init with url.*.insteadOf' '
+
+	rm -rf init &&
+	git config -f .gitmodules submodule.example.url "http://example.com/init2" &&
+	git config --remove-section submodule.example
+	git config "url.$(pwd)/.insteadOf" "http://example.com/" &&
+	git submodule update --init init &&
+	test -d init/.git
+
+'
+
 test_done
-- 
1.6.0.rc1.34.g0fe8c
