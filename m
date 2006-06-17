From: Michael Somos <somos@grail.cba.csuohio.edu>
Subject: git-1.4.0 make problems
Date: Fri, 16 Jun 2006 22:18:00 -0400
Message-ID: <200606170218.k5H2I0o0003192@grail.cba.csuohio.edu>
X-From: git-owner@vger.kernel.org Sat Jun 17 04:24:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FrQUU-0005UL-Tb
	for gcvg-git@gmane.org; Sat, 17 Jun 2006 04:24:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751582AbWFQCY2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Jun 2006 22:24:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751583AbWFQCY2
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Jun 2006 22:24:28 -0400
Received: from grail.cba.csuohio.edu ([137.148.216.15]:717 "EHLO
	grail.cba.csuohio.edu") by vger.kernel.org with ESMTP
	id S1751581AbWFQCY1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jun 2006 22:24:27 -0400
Received: from grail.cba.csuohio.edu (localhost [127.0.0.1])
	by grail.cba.csuohio.edu (8.12.11/8.12.10) with ESMTP id k5H2I0DA003194
	for <git@vger.kernel.org>; Fri, 16 Jun 2006 22:18:00 -0400
Received: (from somos@localhost)
	by grail.cba.csuohio.edu (8.12.11/8.12.11/Submit) id k5H2I0o0003192
	for git@vger.kernel.org; Fri, 16 Jun 2006 22:18:00 -0400
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21993>

I downloaded the git-1.4.0.tar.bz2 recently and encountered a few problems.

1) The untar process creates a stray file "pax_global_header".
I am using GNU tar v1.13.22 and I get this message :

======================================================================
> tar jxf ~/u/source/git-1.4.0.tar.bz2
tar: pax_global_header: Unknown file type 'g', extracted as normal file
======================================================================

2) The make install process ignores the "prefix=..." argument. I have
to comment out one line for this :

======================================================================
> diff Makefile git-1.4.0/
94c94 
< #prefix = $(HOME)
---
> prefix = $(HOME)
======================================================================

3) The make has a problem with "expat" include and libararies.
I have to add more lines to the Makefile to handle this like some
of the other include and libraries :

======================================================================
351,358c351
< endif
<
< ifndef NO_EXPAT
<       ifdef EXPATDIR
<               # This is still problematic -- gcc does not always want -R.
<               ALL_CFLAGS += -I$(EXPATDIR)/include
<               EXPAT_LIBEXPAT = -L$(EXPATDIR)/lib -R$(EXPATDIR)/lib -lexpat
<           else
---
>       ifndef NO_EXPAT
360c353
<           endif
---
>       endif
======================================================================

Other than that, it installed okay. I will have to read the docs and
use it to see how it goes otherwise.
