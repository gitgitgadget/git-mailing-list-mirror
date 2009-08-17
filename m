From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC PATCH v3 8/8] --sparse for porcelains
Date: Mon, 17 Aug 2009 11:08:27 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908171101090.4991@intel-tinevez-2-302>
References: <1250005446-12047-1-git-send-email-pclouds@gmail.com> <200908142223.07994.jnareb@gmail.com> <7veird4yyi.fsf@alter.siamese.dyndns.org> <200908160137.30384.jnareb@gmail.com> <alpine.DEB.1.00.0908161002460.8306@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 17 11:08:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1McyCo-0002nR-Nk
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 11:08:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757497AbZHQJIe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 05:08:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757467AbZHQJIe
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 05:08:34 -0400
Received: from mail.gmx.net ([213.165.64.20]:49290 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757455AbZHQJId (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2009 05:08:33 -0400
Received: (qmail invoked by alias); 17 Aug 2009 09:08:33 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp023) with SMTP; 17 Aug 2009 11:08:33 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19Xxhtb5OVXOgukrXamsbuQndcvgIzvc+k13sONe9
	pcXxbJ7Z60JS5e
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <alpine.DEB.1.00.0908161002460.8306@pacific.mpi-cbg.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.63
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126145>

Hi,

On Sun, 16 Aug 2009, Johannes Schindelin wrote:

> [...] if you want to say that assume-unchanged and sparse are two 
> fundamentally different things, I would be interested in some equally 
> convincing argument as for the shallow/graft issue.
> 
> There is a fundamental difference, I grant you that: the working 
> directory does not contain the "sparse'd away" files while the same is 
> not true for assume-unchanged files.
> 
> But does that matter?  The corresponding files are still in the index 
> and the repository.
> 
> IOW under what circumstances would you want to be able to discern 
> between assume-unchanged and "sparse'd away" files in the working 
> directory?
> 
> I could _imagine_ that you'd want a tool that allows you to change the 
> focus of the sparse checkout together with the working directory.  
> Example: you have a sparse checkout of Documentation/ and now you want 
> to have t/, too.  Just changing .git/info/sparse will not be enough.
> 
> The question is if the tool to change the "sparseness" [*1*] should not 
> change .git/info/sparse itself; if it does not, it would be good to be 
> able to discern between the "assume-unchanged" and "sparse'd away" 
> files.
> 
> Although it might be enough to traverse the index and check the presence 
> of the assume-unchanged files in the working directory to determine 
> which files are sparse, and which ones are merely assume-unchanged.
> 
> Ciao,
> Dscho
> 
> Footnote [*1*]: I think we need some nice and clear nomenclature here.  
> Any English wizards with a good taste of naming things?

Turns out that somebody on IRC had a problem that requires to have 
sparse'd out files which _do_ have working directory copies.

So just having the assume-changed bit may not be enough.

The scenario is this: the repository contains a file that users are 
supposed to change, but not commit to (only the super-intelligent inventor 
of this scenario is allowed to).  As this repository is originally a 
subversion one, there is no problem: people just do not switch branches.

But this guy uses git-svn, so he does switch branches, and to avoid 
committing the file by mistake, he marked it assume-unchanged.  Only that 
a branch switch overwrites the local changes.

I suggested the use of the sparse feature, and mark this file (and this 
file alone) as sparse'd-out.

Is this an intended usage scenario?  Then we cannot reuse the 
assume-changed bit [*1*].

Ciao,
Dscho

Footnote [*1*]: in this particular scenario, we could still discern 
between sparse'd-out and regular assume-unchanged file, because 
.git/info/sparse knows about the file.  But the design is now brittle, and 
it is not hard at all to come up with a situation where it breaks.
