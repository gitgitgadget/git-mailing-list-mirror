From: Haakon Riiser <haakon.riiser@fys.uio.no>
Subject: Cleaning the .git directory with gc
Date: Thu, 24 Apr 2008 01:13:59 +0200
Message-ID: <20080423231359.GA30913@fox>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 24 01:14:51 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JooAs-0001mC-2O
	for gcvg-git-2@gmane.org; Thu, 24 Apr 2008 01:14:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752857AbYDWXOE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2008 19:14:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752831AbYDWXOC
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Apr 2008 19:14:02 -0400
Received: from pat.uio.no ([129.240.10.15]:54289 "EHLO pat.uio.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752700AbYDWXOA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2008 19:14:00 -0400
Received: from mail-mx1.uio.no ([129.240.10.29])
	by pat.uio.no with esmtp (Exim 4.67)
	(envelope-from <haakon.riiser@fys.uio.no>)
	id 1JooA3-0003me-KF
	for git@vger.kernel.org; Thu, 24 Apr 2008 01:13:59 +0200
Received: from smtp.uio.no ([129.240.10.9] helo=mail-mx1.uio.no)
	by mail-mx1.uio.no with esmtp (Exim 4.69)
	(envelope-from <haakon.riiser@fys.uio.no>)
	id 1JooA3-0005cY-Es
	for git@vger.kernel.org; Thu, 24 Apr 2008 01:13:59 +0200
Received: from c85-196-100-202.static.sdsl.no ([85.196.100.202] helo=bigboss.venod.com)
	by mail-mx1.uio.no with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <haakon.riiser@fys.uio.no>)
	id 1JooA3-0005cT-CT
	for git@vger.kernel.org; Thu, 24 Apr 2008 01:13:59 +0200
Received: from fox.venod.com ([10.0.0.4])
	by bigboss.venod.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.62)
	(envelope-from <haakon.riiser@fys.uio.no>)
	id 1JooA3-0001r7-3q
	for git@vger.kernel.org; Thu, 24 Apr 2008 01:13:59 +0200
Received: from hakonrk by fox.venod.com with local (Exim 4.67)
	(envelope-from <haakon.riiser@fys.uio.no>)
	id 1JooA3-00085W-1F
	for git@vger.kernel.org; Thu, 24 Apr 2008 01:13:59 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)
X-UiO-Resend: resent
X-UiO-Spam-info: not spam, SpamAssassin (score=-5.0, required=5.0, autolearn=disabled, UIO_MAIL_IS_INTERNAL=-5)
X-UiO-Scanned: 6A95ABDA3D0E9E642EB8F38C1CC7A9A724C325D9
X-UiO-SR-test: 15A167923C05834E1F11A4AFEA448742E4D5D836
X-UiO-SPAM-Test: remote_host: 129.240.10.9 spam_score: -49 maxlevel 200 minaction 2 bait 0 mail/h: 69 total 8053236 max/h 8345 blacklist 0 greylist 0 ratelimit 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80273>

I've recently started using git, and while experimenting with
git commit --amend, I noticed that git gc does not do what I
expected.  Example:

  $ mkdir foo && cd foo
  $ git init
  $ dd if=/dev/urandom bs=1k count=1000 of=rand.dat
  $ git add .
  $ git commit -a -m 'first rev'
  $ du -s .git
  1100    .git

1 MB file checked in, 1 MB repository.  So far, so good.

  $ dd if=/dev/urandom bs=1k count=1000 of=rand.dat
  $ git commit -a -m 'replaced first rev' --amend
  $ du -s .git
  2120    .git

At this point, I expected the --amend command to notice that
the amended commit contains a replacement for the old file,
and thus that the repository didn't grow.  I then figured that
if --amend doesn't do that by itself, git gc surely will:

  $ git gc
  $ du -s .git
  2104    .git

So, why doesn't gc remove the data from the first commit?  Is it
still accessible, even though the log doesn't show it?

Is it possible to actually replace the commit, i.e., to make it
exactly like the first commit never happend at all?  (Without
modifying the repository by hand.)

-- 
 Haakon
