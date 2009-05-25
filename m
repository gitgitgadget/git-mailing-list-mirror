From: Charles Bailey <charles@hashpling.org>
Subject: [PATCH 1/2] merge-file fails to output anything for a degenerate merge
Date: Mon, 25 May 2009 01:21:13 +0100
Message-ID: <1243210874-18451-2-git-send-email-charles@hashpling.org>
References: <1243210874-18451-1-git-send-email-charles@hashpling.org>
Cc: Charles Bailey <charles@hashpling.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 25 02:23:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8Ny2-0005dH-9W
	for gcvg-git-2@gmane.org; Mon, 25 May 2009 02:23:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754107AbZEYAVb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 May 2009 20:21:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754047AbZEYAVa
	(ORCPT <rfc822;git-outgoing>); Sun, 24 May 2009 20:21:30 -0400
Received: from relay.pcl-ipout02.plus.net ([212.159.7.100]:9397 "EHLO
	relay.pcl-ipout02.plus.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753961AbZEYAVa (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 May 2009 20:21:30 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ApoEAIiBGUrUnw6R/2dsb2JhbADMb4QLBQ
Received: from ptb-relay01.plus.net ([212.159.14.145])
  by relay.pcl-ipout02.plus.net with ESMTP; 25 May 2009 01:21:31 +0100
Received: from [212.159.69.125] (helo=hashpling.plus.com)
	 by ptb-relay01.plus.net with esmtp (Exim) id 1M8NwZ-0007OX-1z; Mon, 25 May 2009 01:21:31 +0100
Received: from cayley.hashpling.org (cayley.hashpling.org [192.168.76.254])
	by hashpling.plus.com (8.14.2/8.14.2) with ESMTP id n4P0LUm8018494
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 25 May 2009 01:21:30 +0100
Received: (from charles@localhost)
	by cayley.hashpling.org (8.14.2/8.14.2/Submit) id n4P0LUZI018493;
	Mon, 25 May 2009 01:21:30 +0100
X-Mailer: git-send-email 1.6.3.1.72.gbd1ec
In-Reply-To: <1243210874-18451-1-git-send-email-charles@hashpling.org>
X-Plusnet-Relay: 280b19675f20c1f0e5195a1f9c4f86bd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119881>

In the case that merge-file is passed three files with identical
contents it wipes the contents of the output file instead of
leaving it unchanged.

Althought merge-file is porcelain and this will never happen in
normal usage, it is still wrong.

Signed-off-by: Charles Bailey <charles@hashpling.org>
---
 t/t6023-merge-file.sh |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/t/t6023-merge-file.sh b/t/t6023-merge-file.sh
index f8942bc..44141af 100755
--- a/t/t6023-merge-file.sh
+++ b/t/t6023-merge-file.sh
@@ -54,6 +54,11 @@ deduxit me super semitas jusitiae,
 EOF
 printf "propter nomen suum." >> new4.txt
 
+cp orig.txt test.txt
+test_expect_success "merge with no changes" \
+	"git merge-file test.txt orig.txt orig.txt &&
+	 test_cmp test.txt orig.txt"
+
 cp new1.txt test.txt
 test_expect_success "merge without conflict" \
 	"git merge-file test.txt orig.txt new2.txt"
-- 
1.6.3.1.72.gbd1ec
