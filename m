From: Alex Riesen <raa.lkml@gmail.com>
Subject: Fix t5303 (the test case for pack corruptions) on Windows
Date: Wed, 25 Jun 2008 18:44:38 +0200
Message-ID: <20080625164438.GA4039@steel.home>
References: <alpine.LFD.1.10.0806232123420.2979@xanadu.home>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Nicolas Pitre <nico@cam.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 25 18:45:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBY7r-00086F-2i
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 18:45:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752966AbYFYQoo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2008 12:44:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752934AbYFYQoo
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 12:44:44 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:19267 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752217AbYFYQon (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2008 12:44:43 -0400
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: :YSxENQjhO8RswxTRIGdg20tf4EbVSQ==
Received: from tigra.home (Fad8f.f.strato-dslnet.de [195.4.173.143])
	by post.webmailer.de (fruni mo2) (RZmta 16.45)
	with ESMTP id Z01b6ak5PGJk7d ; Wed, 25 Jun 2008 18:44:39 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 0E763277BD;
	Wed, 25 Jun 2008 18:44:39 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id B824856D2A; Wed, 25 Jun 2008 18:44:38 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0806232123420.2979@xanadu.home>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86304>

The perldiag(1) has following to say about this:

    "Can't do inplace edit without backup"

	(F) You're on a system such as MS-DOS that gets confused if
	you try reading from a deleted (but still opened) file. You
	have to say -i.bak, or some such.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---

 t/t5303-pack-corruption-resilience.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t5303-pack-corruption-resilience.sh b/t/t5303-pack-corruption-resilience.sh
index b0f5693..31b20b2 100755
--- a/t/t5303-pack-corruption-resilience.sh
+++ b/t/t5303-pack-corruption-resilience.sh
@@ -90,7 +90,7 @@ test_expect_success \
     'create_new_pack &&
      git prune-packed &&
      chmod +w ${pack}.pack &&
-     perl -i -pe "s/ base /abcdef/" ${pack}.pack &&
+     perl -i.bak -pe "s/ base /abcdef/" ${pack}.pack &&
      test_must_fail git cat-file blob $blob_1 > /dev/null &&
      test_must_fail git cat-file blob $blob_2 > /dev/null &&
      test_must_fail git cat-file blob $blob_3 > /dev/null'
@@ -138,7 +138,7 @@ test_expect_success \
     'create_new_pack &&
      git prune-packed &&
      chmod +w ${pack}.pack &&
-     perl -i -pe "s/ delta1 /abcdefgh/" ${pack}.pack &&
+     perl -i.bak -pe "s/ delta1 /abcdefgh/" ${pack}.pack &&
      git cat-file blob $blob_1 > /dev/null &&
      test_must_fail git cat-file blob $blob_2 > /dev/null &&
      test_must_fail git cat-file blob $blob_3 > /dev/null'
-- 
1.5.6.28.g6f71b
