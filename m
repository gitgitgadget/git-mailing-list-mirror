From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGIT PATCH] Remove obsolete files when deleting a branch
Date: Tue, 15 May 2007 21:38:40 +0200
Message-ID: <20070515193824.31968.87744.stgit@yoghurt>
References: <20070515182549.GB17851@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 15 21:41:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ho2tq-0006ng-Pa
	for gcvg-git@gmane.org; Tue, 15 May 2007 21:41:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755751AbXEOTl1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 15 May 2007 15:41:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755872AbXEOTl1
	(ORCPT <rfc822;git-outgoing>); Tue, 15 May 2007 15:41:27 -0400
Received: from ch-smtp02.sth.basefarm.net ([80.76.149.213]:49105 "EHLO
	ch-smtp02.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755574AbXEOTl0 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 May 2007 15:41:26 -0400
Received: from c83-250-140-11.bredband.comhem.se ([83.250.140.11]:34481 helo=yoghurt)
	by ch-smtp02.sth.basefarm.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.66)
	(envelope-from <kha@treskal.com>)
	id 1Ho2tg-0004z6-9d; Tue, 15 May 2007 21:41:25 +0200
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by yoghurt with esmtp (Exim 4.62)
	(envelope-from <kha@treskal.com>)
	id 1Ho2r2-0008KK-56; Tue, 15 May 2007 21:38:40 +0200
In-Reply-To: <20070515182549.GB17851@diana.vm.bytemark.co.uk>
User-Agent: StGIT/0.12
X-Scan-Result: No virus found in message 1Ho2tg-0004z6-9d.
X-Scan-Signature: ch-smtp02.sth.basefarm.net 1Ho2tg-0004z6-9d 123889d199733cc6c882003d0eeacee4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47369>

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>
---

 stgit/stack.py |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/stgit/stack.py b/stgit/stack.py
index 52f39a6..4ed3a73 100644
--- a/stgit/stack.py
+++ b/stgit/stack.py
@@ -660,6 +660,16 @@ class Series(StgitObject):
             if os.path.exists(self._dir()+'/orig-base'):
                 os.remove(self._dir()+'/orig-base')
=20
+            # Remove obsolete files that StGIT no longer uses, but
+            # that might still be around if this is an old repository.
+            for obsolete in ([os.path.join(self._dir(), fn)
+                              for fn in ['current', 'description',
+                                         'applied', 'unapplied']]
+                             + [os.path.join(self.__base_dir,
+                                             'refs', 'bases', self.__n=
ame)]):
+                if os.path.exists(obsolete):
+                    os.remove(obsolete)
+
             if not os.listdir(self.__patch_dir):
                 os.rmdir(self.__patch_dir)
             else:
