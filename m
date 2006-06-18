From: Ryan Anderson <ryan@michonline.com>
Subject: Re: git 1.4.0 usability problem
Date: Sun, 18 Jun 2006 09:43:00 -0700
Message-ID: <20060618164300.GI25520@h4x0r5.com>
References: <449557B6.1080907@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 18 18:43:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fs0Mr-0006v6-0I
	for gcvg-git@gmane.org; Sun, 18 Jun 2006 18:43:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932244AbWFRQnR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Jun 2006 12:43:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932248AbWFRQnR
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jun 2006 12:43:17 -0400
Received: from h4x0r5.com ([70.85.31.202]:29712 "EHLO h4x0r5.com")
	by vger.kernel.org with ESMTP id S932244AbWFRQnQ (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Jun 2006 12:43:16 -0400
Received: from ryan by h4x0r5.com with local (Exim 4.50)
	id 1Fs0MX-0007Sd-2Z; Sun, 18 Jun 2006 09:43:01 -0700
To: Jeff Garzik <jeff@garzik.org>
Content-Disposition: inline
In-Reply-To: <449557B6.1080907@garzik.org>
User-Agent: Mutt/1.5.9i
X-michonline.com-MailScanner: Found to be clean
X-michonline.com-MailScanner-From: ryan@h4x0r5.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22092>

On Sun, Jun 18, 2006 at 09:40:06AM -0400, Jeff Garzik wrote:
> Now that kernel 2.6.17 is out, I updated all my repositories to be based 
> against that kernel.  And for each repository I updated, my merge was 
> rejected, due to an error similar to:
> 
> >fatal: Untracked working tree file '.gitignore' would be overwritten by 
> >merge.
> 
> I am only able to merge if I delete files in the working directory, so 
> that git stops complaining on merge.
> 
> This behavior is new with git 1.4.0, which Fedora Extras just added.  I 
> verified that merges work as expected in git 1.3.3, the last version 
> Fedora Extras shipped prior to 1.4.0.
> 
> This behavior is a definite regression, that impacts workflow :(
> 
> Here is how to reproduce:
> 
> git clone -l $url/torvalds/linux-2.6.git tmp-2.6

At this point you have master checked out, and recorded properly in the
index.

> cd tmp-2.6
> cp .git/refs/tags/v2.6.12 .git/refs/heads/tmp
> git checkout -f tmp

Here, you throw that index away, ignore the contents of the working
tree, and checkout tmp.

> git pull . master
> # watch OBVIOUS FAST-FORWARD MERGE complain about untracked
> # working tree files

At this point, you have a working tree containing files leftover from
the checkout of master, but which are totally unknown to the 2.6.12
tree, and so are untracked.  The fast-forward is trying hard not to
overwrite things it shouldn't be messing with, and so complains.

The fix is to drop the "-f" from git checkout, and things should work
correctly.  ("-f" should really not be a normal thing to use. For
switching branches, "git checkout" should be sufficient, and should
result ina working tree that doesn't contain nearly as many potential
conflict sources.

-- 

Ryan Anderson
  sometimes Pug Majere
