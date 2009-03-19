From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Define a version of lstat(2) with posix semantics
Date: Thu, 19 Mar 2009 22:40:01 +0100
Message-ID: <20090319214001.GA6253@blimp.localdomain>
References: <81b0412b0903190327l7745bf01i479fb84fae777af0@mail.gmail.com> <alpine.DEB.1.00.0903191155300.10279@pacific.mpi-cbg.de>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Jeff King <peff@peff.net>, layer <layer@known.net>,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Mar 19 22:42:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkPzn-0002o3-9R
	for gcvg-git-2@gmane.org; Thu, 19 Mar 2009 22:41:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755075AbZCSVkT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2009 17:40:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754734AbZCSVkS
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 17:40:18 -0400
Received: from mout5.freenet.de ([195.4.92.95]:50686 "EHLO mout5.freenet.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754551AbZCSVkR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2009 17:40:17 -0400
Received: from [195.4.92.25] (helo=15.mx.freenet.de)
	by mout5.freenet.de with esmtpa (ID alexander.riesen@freenet.de) (port 25) (Exim 4.69 #76)
	id 1LkPyB-0000HE-AH; Thu, 19 Mar 2009 22:40:07 +0100
Received: from x62b3.x.pppool.de ([89.59.98.179]:46711 helo=tigra.home)
	by 15.mx.freenet.de with esmtpa (ID alexander.riesen@freenet.de) (port 587) (Exim 4.69 #76)
	id 1LkPyA-0001tp-Th; Thu, 19 Mar 2009 22:40:07 +0100
Received: from blimp.localdomain (blimp.home [192.168.1.28])
	by tigra.home (Postfix) with ESMTP id A3ED9277D8;
	Thu, 19 Mar 2009 22:40:01 +0100 (CET)
Received: by blimp.localdomain (Postfix, from userid 1000)
	id 67DCA36D27; Thu, 19 Mar 2009 22:40:01 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0903191155300.10279@pacific.mpi-cbg.de>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113833>

So that Cygwin port can continue work around its supporting
library and get access to its faked file attributes.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---

Johannes Schindelin, Thu, Mar 19, 2009 11:57:01 +0100:
> On Thu, 19 Mar 2009, Alex Riesen wrote:
> > So that Cygwin port can continue work around its supporting
> > library and get access to its faked file attributes.
> > 
> 
> [patch not inlined: therefore you'll have to guess what I am referring to]

I resend.

> It seems quite wrong to define something for other platforms when only 
> Cygwin is affected.

I know. Didn't I already said I'm sorry? I even said that it is fine
if the patches wont be applied. Just wanted to share the pain.

> I'd rather just disable WIN32_STAT for Cygwin, because otherwise, we will 
> keep running into issues.

I'd rather not. The thing is just so unbelievably slow and being stuck
on it I'm just trying my damnedest to squeeze every last bit of
performance out of it.

 git-compat-util.h |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index f09f244..c99549d 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -85,11 +85,16 @@
 #undef _XOPEN_SOURCE
 #include <grp.h>
 #define _XOPEN_SOURCE 600
+static inline int posix_lstat(const char *file_name, struct stat *buf)
+{
+	return lstat(file_name, buf);
+}
 #include "compat/cygwin.h"
 #else
 #undef _ALL_SOURCE /* AIX 5.3L defines a struct list with _ALL_SOURCE. */
 #include <grp.h>
 #define _ALL_SOURCE 1
+#define posix_lstat lstat
 #endif
 #else 	/* __MINGW32__ */
 /* pull in Windows compatibility stuff */
-- 
1.6.2.1.237.g7206c6
