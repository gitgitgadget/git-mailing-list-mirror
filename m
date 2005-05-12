From: Jan Harkes <jaharkes@cs.cmu.edu>
Subject: Re: [PATCH] [RFD] Add repoid identifier to commit
Date: Thu, 12 May 2005 09:29:22 -0400
Message-ID: <20050512132922.GB20785@delft.aura.cs.cmu.edu>
References: <428297DB.8030905@zytor.com> <1115858022.22180.256.camel@tglx> <7vekcdmd16.fsf@assigned-by-dhcp.cox.net> <1115884637.22180.277.camel@tglx> <1895.10.10.10.24.1115890333.squirrel@linux1> <1115890792.22180.306.camel@tglx> <3656.10.10.10.24.1115891188.squirrel@linux1> <1115896713.22180.314.camel@tglx> <3745.10.10.10.24.1115897090.squirrel@linux1> <1115898230.11872.8.camel@tglx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sean <seanlkml@sympatico.ca>, Junio C Hamano <junkio@cox.net>,
	"H. Peter Anvin" <hpa@zytor.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 12 15:23:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWDdk-0003eJ-RV
	for gcvg-git@gmane.org; Thu, 12 May 2005 15:22:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261370AbVELN3z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 May 2005 09:29:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261931AbVELN3z
	(ORCPT <rfc822;git-outgoing>); Thu, 12 May 2005 09:29:55 -0400
Received: from DELFT.AURA.CS.CMU.EDU ([128.2.206.88]:14008 "EHLO
	delft.aura.cs.cmu.edu") by vger.kernel.org with ESMTP
	id S261370AbVELN3w (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2005 09:29:52 -0400
Received: from jaharkes by delft.aura.cs.cmu.edu with local (Exim 3.36 #1 (Debian))
	id 1DWDkg-0002YQ-00; Thu, 12 May 2005 09:29:22 -0400
To: Thomas Gleixner <tglx@linutronix.de>
Mail-Followup-To: Thomas Gleixner <tglx@linutronix.de>,
	Sean <seanlkml@sympatico.ca>, Junio C Hamano <junkio@cox.net>,
	"H. Peter Anvin" <hpa@zytor.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <1115898230.11872.8.camel@tglx>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, May 12, 2005 at 01:43:50PM +0200, Thomas Gleixner wrote:
> > Is there any _useful_ question you can ask where the answer
> > is lost for all time because of this.
> 
> I want to see the history of _any_ repository in the order of  changes
> in the specific repository. The fast forward heads without additional
> information simply do not allow this. 

But you can't add additional information to the fast-forward head. That
would defeat the whole point of the fast-forward.

> I want to see the history of a file in the correct order. The current
> solution ends up with useless file version diffs or annotates where
> changes are shown in random order and therefor worthless.

Not random order, those changes were performed in parallel, so there is
no order between them until they are merged, at which point the parent
linkage defines the order. If you want to add a total ordering to them,
write out a file with 'commit-id parent-id' pairs and run it through
'tsort'.

Your examples break if you consider additional merges where M syncs up a
couple of times (f.i. at Rn-2) before M is merged back into R.

What you seem to want won't be fixed by adding a repoid, you need to
keep a list of all the commits you have already seen and append any new
ones whenever you look at the history. If you look whenever you pull or
merge the list will be in the total ordering that you seem to expect for
your repository. But that is a porcelain thing.

Jan

