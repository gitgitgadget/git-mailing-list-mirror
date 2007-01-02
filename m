From: Juergen Ruehle <j.ruehle@bmiag.de>
Subject: Re: How to commit removed file?
Date: Tue, 2 Jan 2007 22:49:23 +0100
Message-ID: <17818.54115.482000.804065@lapjr.intranet.kiel.bmiag.de>
References: <20061231102444.GD26552@mellanox.co.il>
	<20070102201041.GB10451@mellanox.co.il>
	<Pine.LNX.4.63.0701022211100.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: "Michael S. Tsirkin" <mst@mellanox.co.il>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 02 22:49:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H1rW5-0000Zh-32
	for gcvg-git@gmane.org; Tue, 02 Jan 2007 22:49:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932684AbXABVtu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 2 Jan 2007 16:49:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964894AbXABVtu
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Jan 2007 16:49:50 -0500
Received: from bilbo.bmiag.de ([62.154.210.131]:3812 "HELO bilbo.bmiag.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932684AbXABVtt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jan 2007 16:49:49 -0500
Received: (qmail 22909 invoked by uid 106); 2 Jan 2007 21:49:45 -0000
Received: from eotheod.intranet.kiel.bmiag.de(10.130.2.1)
 via SMTP by bilbo.bmiag.de, id smtpdnAF8mL; Tue Jan  2 22:49:35 2007
Received: from localhost (localhost.localdomain [127.0.0.1])
	by eotheod.intranet.kiel.bmiag.de (Postfix) with ESMTP id 5094A3ADC8;
	Tue,  2 Jan 2007 22:49:35 +0100 (CET)
Received: from eotheod.intranet.kiel.bmiag.de ([127.0.0.1])
	by localhost (eotheod [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 10353-07; Tue, 2 Jan 2007 22:49:30 +0100 (CET)
Received: from LAPJR (dialin5.galadriel.bmiag.de [192.168.251.5])
	by eotheod.intranet.kiel.bmiag.de (Postfix) with ESMTP id C9CBC3ADC6;
	Tue,  2 Jan 2007 22:49:26 +0100 (CET)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0701022211100.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-Mailer: VM 7.19 under Emacs 21.3.1
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at eotheod.intranet.kiel.bmiag.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35824>

Johannes Schindelin writes:
 > On Tue, 2 Jan 2007, Michael S. Tsirkin wrote:
 > 
 > > > I'd like to remove a file and commit the removal while
 > > > leaving out other changes in repository/index.
 > > > 
 > > > $git rm kernel_patches/fixes/ib_verbs_warning_fix.patch
 > > > rm 'kernel_patches/fixes/ib_verbs_warning_fix.patch'
 > > > 
 > > > $ git commit kernel_patches/fixes/ib_verbs_warning_fix.patch
 > > > error: pathspec 'kernel_patches/fixes/ib_verbs_warning_fix.patch' did not match
 > > > any file(s) known to git.
 > > > Did you forget to 'git add'?
 > > > 
 > > > A similiar thing works with "git add".
 > > 
 > > Any ideas? Can this be done with git?
 > 
 > Did you actually try the "--" thing I suggested in 
 > http://article.gmane.org/gmane.comp.version-control.git/35699/?
 > 
 > Besides, I just tested with current "next": 
 > 
 > $ git commit kernel_patches/fixes/ib_verbs_warning_fix.patch
 > Created commit 89a5bb5ac16fb8be9b6e061284e191cafb3e4da2
 >  1 files changed, 0 insertions(+), 22 deletions(-)
 >  delete mode 100644 a234

But (at least in next from yesterday or something -- having an old
modem here only:-) it doesn't work if you delete the file using
git-rm, because git-commit -o operates only on known files: one of the
first things in this code path is a

  git-ls-files --error-unmatch -- $@

This seems wrong because -o is supposed to bypass the index. It
should probably be doing ls-tree --name-only HEAD -- $@ instead, but
ls-tree doesn't have the --error-match functionality.
