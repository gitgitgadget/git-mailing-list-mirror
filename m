From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: restriction of pulls
Date: Sat, 10 Feb 2007 15:50:11 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702101533060.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <200702091149.12462.duelli@melosgmbh.de>
 <Pine.LNX.4.63.0702091554160.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <45CC941E.9030808@dawes.za.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Christoph Duelli <duelli@melosgmbh.de>, git@vger.kernel.org
To: Rogan Dawes <lists@dawes.za.net>
X-From: git-owner@vger.kernel.org Sat Feb 10 15:50:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFtYR-00022k-P5
	for gcvg-git@gmane.org; Sat, 10 Feb 2007 15:50:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932520AbXBJOuP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Feb 2007 09:50:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932579AbXBJOuO
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Feb 2007 09:50:14 -0500
Received: from mail.gmx.net ([213.165.64.20]:60473 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932520AbXBJOuN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Feb 2007 09:50:13 -0500
Received: (qmail invoked by alias); 10 Feb 2007 14:50:12 -0000
X-Provags-ID: V01U2FsdGVkX1/wzaRm0+Lwbd9Zxz16QfjlnJLeIxtnk5rGHvNy78
	TDbQ==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <45CC941E.9030808@dawes.za.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39226>

Hi,

On Fri, 9 Feb 2007, Rogan Dawes wrote:

> Johannes Schindelin wrote:
> > 
> > On Fri, 9 Feb 2007, Christoph Duelli wrote:
> > 
> > > Is it possible to restrict a chechout, clone or a later pull to some 
> > > subdirectory of a repository?
> > 
> > No. In git, a revision really is a revision, and not a group of file 
> > revisions.
> 
> I thought about how this might be implemented, although I'm not entirely 
> sure how efficient this will be.

There are basically three ways I can think of:

- rewrite the commit objects on the fly. You might want to avoid the use 
of the pack protocol here (i.e. use HTTP or FTP transport).

- try to teach git a way to ignore certain missing objects and 
directories. This might be involved, but you could extend upload-pack 
easily with a new extension for that.

(my favourite:)
- use git-split to create a new branch, which only contains doc/. Do work 
only on that branch, and merge into mainline from time to time.

If you don't need the history, you don't need to git-split the branch.

You only need to make sure that the newly created branch is _not_ branched 
off of mainline, since the next merge would _delete_ all files outside of 
doc/ (merge would see that the files exist in mainline, and existed in the 
common ancestor, too, so would think that the files were deleted in the 
doc branch).

Ciao,
Dscho
