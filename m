From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: Commiting changes onto more than one branch
Date: Wed, 25 Nov 2009 17:47:55 +0100
Message-ID: <200911251747.57456.trast@student.ethz.ch>
References: <6b4a562b0911250831q332ac3b5m6ee38f59e7a6f391@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: Mike Jarmy <mjarmy@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 25 17:48:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDL2T-0007jE-Qj
	for gcvg-git-2@lo.gmane.org; Wed, 25 Nov 2009 17:48:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757710AbZKYQry (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2009 11:47:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754096AbZKYQry
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Nov 2009 11:47:54 -0500
Received: from gwse.ethz.ch ([129.132.178.237]:19610 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753401AbZKYQrx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2009 11:47:53 -0500
Received: from CAS02.d.ethz.ch (129.132.178.236) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.176.0; Wed, 25 Nov
 2009 17:47:57 +0100
Received: from thomas.localnet (129.132.153.233) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.176.0; Wed, 25 Nov
 2009 17:47:58 +0100
User-Agent: KMail/1.12.90 (Linux/2.6.31.5-0.1-desktop; KDE/4.3.75; x86_64; ; )
In-Reply-To: <6b4a562b0911250831q332ac3b5m6ee38f59e7a6f391@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133651>

Mike Jarmy wrote:
> Suppose that I checkout the v3 branch, and fix the bug by editing
> several different files.  (Lets assume for now that the files in
> question have not diverged between any of the 3 branches, even though
> tons of other files have changed).  How do I commit the bugfix into
> all of v3, v4 and v5?  Clearly, merging the branches together would be
> bad.  So I think what I should do is perform 3 different commits, but
> I'm not quite sure how to juggle the git index (or stash or whatever)
> to accomplish this.  This may be a really obvious question, but I'm a
> confused git newbie.

You can build the fix on top of the merge-base of v3, v4 and v5, i.e.

  git checkout -b myfix $(git merge-base v3 $(git merge-base v4 v5))
  # work
  git commit

and then merge it to each of the version branches:

  for b in v3 v4 v5; do
    git checkout $b
    git merge myfix
  done

So much for the theory.  In the model suggested in the gitworkflows(7)
manpage and used in git.git, v3 is contained in v4 and similar for v5.
This means that after merging (possibly several) fixes to v3, you can
merge v3 into v4 and v4 into v5 (and so on, through all versions) to
propagate the fixes.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
