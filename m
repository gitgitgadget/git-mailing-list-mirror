From: Andreas Krey <a.krey@gmx.de>
Subject: Re: Branch merge bug
Date: Tue, 19 Jan 2010 13:39:15 +0100
Message-ID: <20100119123915.GB28667@inner.home.ulmdo.de>
References: <f3271551001182322p86a02d8p8b9ceb49e930d333@mail.gmail.com> <4B55A080.7010705@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Jan 19 13:39:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXDMm-0004eD-Ks
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jan 2010 13:39:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751751Ab0ASMjX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jan 2010 07:39:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751614Ab0ASMjX
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jan 2010 07:39:23 -0500
Received: from continuum.iocl.org ([213.146.114.200]:62628 "EHLO
	continuum.iocl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751575Ab0ASMjX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jan 2010 07:39:23 -0500
Received: (from krey@localhost)
	by continuum.iocl.org (8.11.3/8.9.3) id o0JCdFS13037;
	Tue, 19 Jan 2010 13:39:15 +0100
Content-Disposition: inline
In-Reply-To: <4B55A080.7010705@drmicha.warpmail.net>
User-Agent: Mutt/1.4.2.1i
X-message-flag: What did you expect to see here?
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137452>

On Tue, 19 Jan 2010 13:07:28 +0000, Michael J Gruber wrote:
...
> If you really mean to modify and rename an existing file, then tell Git so:
> 
> git mv fil fila
> git commit -m 'we need a new name'
> 
> instead of your 'git rm fil' will record your intentions (not only for
> Git, but also for everyone else reading your log, such as you a year
> from now) and will make the merge succeed.

The intention would only be known informally in the commit message,
as 'git mv' just removes the old and adds the new file, and still
leave the work to the rename detection.

Indeed, changing
  >: git rm fil
  >: echo asjhdajkhsdkajhs >fila
  >: git add fila
to
  >: git mv fil fila
  >: echo asjhdajkhsdkajhs >fila
  >: git add fila
and even to
  >: git mv fil fila
  >: git cm 'other mv'
  >: echo asjhdajkhsdkajhs >fila
  >: git add fila
still gives the same rename/delete conflict because the rename
detection does not look at every single commit but only at
the total changes.

Which is actually good; when someone does

  cp prog.c prog.cpp
  git add prog.cpp && git commit
  vi prog.cpp --make-compile-again && git commit -a
  git rm prog.c && git commit

it is still seen as a rename prog.c->prog.cpp even though both
existed in parallel for some commits.

Andreas
