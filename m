From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: Re: [PATCH] Git.pm: Always set Repository to absolute path if
	autodetecting
Date: Sat, 18 Apr 2009 23:02:25 +0200
Message-ID: <20090418210225.GC17706@mail-vs.djpig.de>
References: <1240070330-31446-1-git-send-email-frank@lichtenheld.de> <1240070330-31446-2-git-send-email-frank@lichtenheld.de> <alpine.DEB.1.00.0904182012330.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Apr 18 23:04:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LvHht-0007v3-VA
	for gcvg-git-2@gmane.org; Sat, 18 Apr 2009 23:04:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754131AbZDRVCj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Apr 2009 17:02:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754034AbZDRVCj
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Apr 2009 17:02:39 -0400
Received: from pauli.djpig.de ([78.46.38.139]:60416 "EHLO pauli.djpig.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753583AbZDRVCj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Apr 2009 17:02:39 -0400
Received: from localhost (localhost [127.0.0.1])
	by pauli.djpig.de (Postfix) with ESMTP id D6C509007F;
	Sat, 18 Apr 2009 23:02:35 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at pauli.djpig.de
Received: from pauli.djpig.de ([127.0.0.1])
	by localhost (pauli.djpig.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BVMrdH+NXKaZ; Sat, 18 Apr 2009 23:02:26 +0200 (CEST)
Received: from mail-vs.djpig.de (mail-vs.djpig.de [78.47.136.189])
	by pauli.djpig.de (Postfix) with ESMTP id 2B1879007D;
	Sat, 18 Apr 2009 23:02:26 +0200 (CEST)
Received: from djpig by mail-vs.djpig.de with local (Exim 4.69)
	(envelope-from <djpig@mail-vs.djpig.de>)
	id 1LvHg9-0005NG-Kk; Sat, 18 Apr 2009 23:02:25 +0200
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0904182012330.10279@pacific.mpi-cbg.de>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116867>

On Sat, Apr 18, 2009 at 08:13:05PM +0200, Johannes Schindelin wrote:
> On Sat, 18 Apr 2009, Frank Lichtenheld wrote:
> 
> > So far we only set it to absolute paths in some cases which lead to 
> > problems like wc_chdir not working.
> 
> We had something similar in setup.c until Linus pointed out that it 
> deteriorates performance.

You mean 044bbbcb63281dfdb78344ada2c44c96122dc822 ?

I don't think we're talking about the same issue here. The code in setup.c
prepares a variable for usage inside the running git command, while the Perl
code needs to prepare a variable for calling a git command, i.e. the content
of the GIT_DIR environment variable. As you can see from the code in setup.c
git will in fact make that content absolute before making it relative again,
so no harm should come from the fact that we're giving it an already absolute
value.

Also if we're giving it a relative path it will interpret it relative to the
current working directory and not GIT_WORK_TREE, so we should in fact not store
it relative because we would need to recalculate it after wc_chdir, which is
exactly what's causing problems.

Gruesse,
-- 
Frank Lichtenheld <frank@lichtenheld.de>
www: http://www.djpig.de/
