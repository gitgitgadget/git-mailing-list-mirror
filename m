From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] rehabilitate some t5302 tests on 32-bit off_t machines
Date: Thu, 15 Nov 2007 12:24:17 -0500 (EST)
Message-ID: <alpine.LFD.0.9999.0711151211330.21255@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 15 18:24:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsiSF-0006N6-DI
	for gcvg-git-2@gmane.org; Thu, 15 Nov 2007 18:24:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753570AbXKORYU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2007 12:24:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755113AbXKORYU
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Nov 2007 12:24:20 -0500
Received: from relais.videotron.ca ([24.201.245.36]:59946 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753555AbXKORYT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2007 12:24:19 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JRK00BO45OH1G80@VL-MO-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 15 Nov 2007 12:24:17 -0500 (EST)
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65140>

Commit 8ed2fca458d085f12c3c6808ef4ddab6aa40ef14 was a bit draconian in 
skipping certain tests which should be perfectly valid even on platform 
with a 32-bit off_t.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---
diff --git a/t/t5302-pack-index.sh b/t/t5302-pack-index.sh
index d93abc4..2a2878b 100755
--- a/t/t5302-pack-index.sh
+++ b/t/t5302-pack-index.sh
@@ -129,17 +129,15 @@ test_expect_failure \
     '[index v1] 6) newly created pack is BAD !' \
     'git verify-pack -v "test-4-${pack1}.pack"'
 
-test "$have_64bits" &&
 test_expect_success \
     '[index v2] 1) stream pack to repository' \
     'rm -f .git/objects/pack/* &&
-     git-index-pack --index-version=2,0x40000 --stdin < "test-1-${pack1}.pack" &&
+     git-index-pack --index-version=2 --stdin < "test-1-${pack1}.pack" &&
      git prune-packed &&
      git count-objects | ( read nr rest && test "$nr" -eq 1 ) &&
      cmp "test-1-${pack1}.pack" ".git/objects/pack/pack-${pack1}.pack" &&
-     cmp "test-3-${pack1}.idx"  ".git/objects/pack/pack-${pack1}.idx"'
+     cmp "test-2-${pack1}.idx"  ".git/objects/pack/pack-${pack1}.idx"'
 
-test "$have_64bits" &&
 test_expect_success \
     '[index v2] 2) create a stealth corruption in a delta base reference' \
     '# this test assumes a delta smaller than 16 bytes at the end of the pack
@@ -152,17 +150,14 @@ test_expect_success \
 	  bs=1 count=20 conv=notrunc &&
        git cat-file blob "$delta_sha1" > blob_4 )'
 
-test "$have_64bits" &&
 test_expect_failure \
     '[index v2] 3) corrupted delta happily returned wrong data' \
     'cmp blob_3 blob_4'
 
-test "$have_64bits" &&
 test_expect_failure \
     '[index v2] 4) confirm that the pack is actually corrupted' \
     'git fsck --full $commit'
 
-test "$have_64bits" &&
 test_expect_failure \
     '[index v2] 5) pack-objects refuses to reuse corrupted data' \
     'git pack-objects test-5 <obj-list'



Nicolas
