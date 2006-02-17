From: Karl =?ISO-8859-1?Q?=20Hasselstr=F6m?= <kha@treskal.com>
Subject: [PATCH 1/2] Update .git/refs/heads/base after patch deletion
Date: Fri, 17 Feb 2006 05:31:26 +0100
Message-ID: <20060217043126.14175.21930.stgit@backpacker.hemma.treskal.com>
References: <20060217042728.14175.39928.stgit@backpacker.hemma.treskal.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 17 05:31:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F9xHL-0000Kk-Cp
	for gcvg-git@gmane.org; Fri, 17 Feb 2006 05:31:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751379AbWBQEb3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 16 Feb 2006 23:31:29 -0500
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751360AbWBQEb2
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Feb 2006 23:31:28 -0500
Received: from mxfep01.bredband.com ([195.54.107.70]:33717 "EHLO
	mxfep01.bredband.com") by vger.kernel.org with ESMTP
	id S932172AbWBQEb2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Feb 2006 23:31:28 -0500
Received: from backpacker.hemma.treskal.com ([83.227.180.148] [83.227.180.148])
          by mxfep01.bredband.com with ESMTP
          id <20060217043126.KDCP12400.mxfep01.bredband.com@backpacker.hemma.treskal.com>;
          Fri, 17 Feb 2006 05:31:26 +0100
Received: from backpacker.hemma.treskal.com (localhost.localdomain [127.0.0.1])
	by backpacker.hemma.treskal.com (Postfix) with ESMTP id A4D53172D;
	Fri, 17 Feb 2006 05:31:26 +0100 (CET)
To: Catalin Marinas <catalin.marinas@arm.com>
In-Reply-To: <20060217042728.14175.39928.stgit@backpacker.hemma.treskal.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16329>

Save the current HEAD into refs/heads/base if the stack is empty after
a patch has been deleted. This was not done before, which caused
refs/heads/base to not be updated after 'stg commit'. To guard against
existing repositories with no applied patches and HEAD !=3D
refs/heads/base, also do the update every time someone asks for the
name of refs/heads/base.

Signed-off-by: Karl Hasselstr=F6m <kha@treskal.com>

---

 stgit/stack.py |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/stgit/stack.py b/stgit/stack.py
index 68a2936..bc39d14 100644
--- a/stgit/stack.py
+++ b/stgit/stack.py
@@ -366,6 +366,7 @@ class Series:
         return names
=20
     def get_base_file(self):
+        self.__begin_stack_check()
         return self.__base_file
=20
     def get_protected(self):
@@ -686,6 +687,7 @@ class Series:
         f =3D file(self.__unapplied_file, 'w+')
         f.writelines([line + '\n' for line in unapplied])
         f.close()
+        self.__begin_stack_check()
=20
     def forward_patches(self, names):
         """Try to fast-forward an array of patches.
