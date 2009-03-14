From: Allan Caffee <allan.caffee@gmail.com>
Subject: [PATCH] Autoconf: Disable inline for compilers that don't support
	it.
Date: Fri, 13 Mar 2009 21:04:21 -0400
Message-ID: <20090314010421.GA6642@linux.vnet>
References: <20090114223832.GC30710@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 14 02:06:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LiIK8-0006is-Jw
	for gcvg-git-2@gmane.org; Sat, 14 Mar 2009 02:06:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751628AbZCNBE2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Mar 2009 21:04:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751148AbZCNBE2
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Mar 2009 21:04:28 -0400
Received: from wf-out-1314.google.com ([209.85.200.173]:61450 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751002AbZCNBE1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Mar 2009 21:04:27 -0400
Received: by wf-out-1314.google.com with SMTP id 28so752448wfa.4
        for <git@vger.kernel.org>; Fri, 13 Mar 2009 18:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:mail-followup-to:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=rD2D1TOyx8PwFzGO2Yn6ULaxyMVG+auPbnyrx0OQL/g=;
        b=pLZUZdmhX/J7raTOWoxwen/TS2OtULAvoPbvJDrWlYzy9hvqyZb/xRnOfxg6B5nQdS
         fl4PmPtXQKhSMxZJE+c9dIKFhH3sXclM2MtzSOSkKXeqTBYcW9bI5p60QYYajLMMconn
         MWRH+A7nPB9GeReCeSxBMB2fPWE2pkKok3w/0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=WRP4tmYNNF09RBhMmw+ZfD1+yXUWh0BQnVQDRTQDLgHdc84cCQaukuTEXS/laTG7L3
         NdyWv1ImY9aiAbDHyWgBOEpTcGlo1BjM13C00P8Y7kfSWf5kBFewi/FdXCxyvzS7b4NU
         U73LHwo/Ocf1gMlkC7uaS3bcVHvZs6Ufm92Sc=
Received: by 10.143.13.16 with SMTP id q16mr875162wfi.67.1236992665745;
        Fri, 13 Mar 2009 18:04:25 -0700 (PDT)
Received: from linux.vnet (pool-71-185-49-127.phlapa.fios.verizon.net [71.185.49.127])
        by mx.google.com with ESMTPS id 30sm5405050wfa.18.2009.03.13.18.04.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 13 Mar 2009 18:04:25 -0700 (PDT)
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20090114223832.GC30710@genesis.frugalware.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113229>

The Autoconf macro AC_C_INLINE will redefine the inline keyword to whatever the
current compiler supports (including possibly nothing).

Signed-off-by: Allan Caffee <allan.caffee@gmail.com>
---
On Wed, 14 Jan 2009, Miklos Vajna wrote:
> On Wed, Jan 14, 2009 at 01:32:56PM -0500, Corey Stup
> <coreystup@gmail.com> wrote:
> > When trying to compile with a C89 compliant compiler, I'm coming
> > across a couple issues:
> > - "inline" use
>
> AFAIK that can be avoided with -Dinline=.

But some compilers support other variations of this like __inline__ or
__inline.  Luckily Autoconf has a builtin method for handling this.

diff --git a/configure.ac b/configure.ac
index 082a03d..69fa25e 100644
--- a/configure.ac
+++ b/configure.ac
@@ -308,6 +308,9 @@ AC_SUBST(OLD_ICONV)
 ## Checks for typedefs, structures, and compiler characteristics.
 AC_MSG_NOTICE([CHECKS for typedefs, structures, and compiler characteristics])
 #
+# Check for compilers ability to inline functions.
+AC_C_INLINE
+#
 # Define NO_D_INO_IN_DIRENT if you don't have d_ino in your struct dirent.
 AC_CHECK_MEMBER(struct dirent.d_ino,
 [NO_D_INO_IN_DIRENT=],
-- 
1.5.4.3
