From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH/RFC] builtin-checkout: suggest creating local branch when appropriate to do so
Date: Mon, 12 Oct 2009 23:40:11 +0200
Message-ID: <200910122340.13366.trast@student.ethz.ch>
References: <0016e68fd0123a175304754694b4@google.com> <alpine.DEB.1.00.0910120941150.4985@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: <Euguess@gmail.com>, Mikael Magnusson <mikachu@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jeff King <peff@peff.net>, Jay Soffian <jaysoffian@gmail.com>,
	<git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Oct 13 00:07:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxT3P-0004FJ-Ji
	for gcvg-git-2@lo.gmane.org; Tue, 13 Oct 2009 00:07:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933282AbZJLVlh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2009 17:41:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933274AbZJLVlh
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Oct 2009 17:41:37 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:18738 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933273AbZJLVlg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2009 17:41:36 -0400
Received: from CAS02.d.ethz.ch (129.132.178.236) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.176.0; Mon, 12 Oct
 2009 23:40:50 +0200
Received: from thomas.localnet (84.74.103.245) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.1.375.2; Mon, 12 Oct
 2009 23:40:50 +0200
User-Agent: KMail/1.12.2 (Linux/2.6.27.29-0.1-default; KDE/4.3.1; x86_64; ; )
In-Reply-To: <alpine.DEB.1.00.0910120941150.4985@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130079>

Johannes Schindelin wrote:
> On Tue, 6 Oct 2009, Euguess@gmail.com wrote:
> > in case if you didn't do that and you try to checkout you will end up 
> > having detached HEAD which is quite scary;) for non-experienced user and 
> > as i see might lead to some unnecessary questions in this list or on IRC 
> > channel...
[...]
> One thing one might add for the technically inclined folks (i.e. those who 
> need to implement, and to see that Git is in dear need of some 
> user-friendliness first): "git checkout" is a porcelain (i.e. a program 
> meant for end-user consumption), and as such should not have a problem to 
> react to isatty(0) (i.e. "is the input coming directly from the 
> console?").

Sadly git-checkout seems to be stuck between being declared a
porcelain, but at the same time being an extremely important command
for scripts all over.  (There are probably others in the same place:
reset comes to mind.)

Your idea is also a backwards incompatible change, so we can just as
well implement the original suggestion and force scripts (or us) to
use some other means when they want to detach.  Say, why not just
invent an option along the lines of

  git checkout {-d|--detach} $ref

to make it explicit.  We have to resort to more arcane means to
*reliably* detach anyway, like 'git checkout master^0'.  Then in some
future release, git-checkout will start making DWIM branches if the -d
is not given.

And while we're there, --attach would be a nice complement to force
refs/heads/foo to attach.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
