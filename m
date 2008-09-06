From: Steven Walter <stevenrwalter@gmail.com>
Subject: [ANNOUNCE] yap: Yet Another (Git) Porcelain
Date: Sat, 6 Sep 2008 11:07:23 -0400
Message-ID: <20080906150723.GA31540@dervierte>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 06 17:08:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KbzPE-0003TP-N3
	for gcvg-git-2@gmane.org; Sat, 06 Sep 2008 17:08:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752040AbYIFPHa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Sep 2008 11:07:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752037AbYIFPHa
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Sep 2008 11:07:30 -0400
Received: from wr-out-0506.google.com ([64.233.184.226]:39705 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752023AbYIFPH3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Sep 2008 11:07:29 -0400
Received: by wr-out-0506.google.com with SMTP id 69so883934wri.5
        for <git@vger.kernel.org>; Sat, 06 Sep 2008 08:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:subject
         :message-id:mime-version:content-type:content-disposition:user-agent;
        bh=8GqpZEeD4Kt/jbOQVQRKUXzm2tMPAgBRDruSSqWDmaw=;
        b=V9/fWH/bbQ13K7wtTA2k++ZC1oVMzueZwMijcqjkW+1IRu5lpskQIzqcHV5HK5gJa4
         TQmvruvUkWPhUFvxXkPjzzo7n3DGBsshgNFIs9eUFCjbDjtBNfcnHs6ReOp3JDloRpyC
         8Ks2ZN6xouiX3hXZ3h8uV80s8sANzaJp3EhTM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        b=crVFFMqDV9aRpdAZ9ueTfvYQOrdVsFD2w+kj+gKmKPYAXItzeI9lcL7fXz2WEEmFci
         fqlwGW2kk20WFyH51Bao9LkT4jpzmREvoQJZngQ/QvQ8odTdZRe2nkg5kibKFvWZaVbl
         aZ7WlZKc+S+EIECGGIBcgKjxyCinY8QxkC0NI=
Received: by 10.70.56.6 with SMTP id e6mr16032426wxa.71.1220713646119;
        Sat, 06 Sep 2008 08:07:26 -0700 (PDT)
Received: from dasbrennen.isa-geek.org ( [76.177.32.207])
        by mx.google.com with ESMTPS id 7sm2073435hsx.13.2008.09.06.08.07.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 06 Sep 2008 08:07:25 -0700 (PDT)
Received: by dasbrennen.isa-geek.org (Postfix, from userid 1000)
	id 79C368D992; Sat,  6 Sep 2008 11:07:23 -0400 (EDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95075>

After starting yap several weeks ago, I feel it has reached a level of
maturity that makes it suitable for public consumption.  yap is three
things, in increasing order of relevance:

    1) A git porcelain implemented in python
    2) A git porcelain with a friendlier, more orthogonal interface
    3) A extensible git porcelain

The third point is most interesting, because as far as the author is
aware, it is the first such project to attempt to achieve this.
Included in this distribution are plugins to create backups during
revert, make "temporary" commits, and ease interoperability with
subversion repositories.

Using git to operate on subversion-hosted repositories is a frequent use
case, and will continue to be until the world embraces git as the
awesome tool it is (keep in mind that even CVS is still in common
usage).  The git-svn tool distributed with git greatly facilitates this.
However, using git-svn requires markedly different workflows, commands,
and mental processes than does working with git-native repositories.

By leveraging the extensible nature of yap, its svn mode strives to make
a remote svn repository act and feel as much like a git repository as
possible to lessen the impedance mismatch to the user.

Yap is still very much a work-in-progress.  Patches are welcome.
Suggestions are welcome.  Bug reports are expected.  Hopefully this
tool can fill a gap in your git toolbox.

Features
--------
    * Most commands are easily and clearly reversible (commit/uncommit).  Those
      that are not are clearly marked as such.
    * Commands that have potentially unintended side-effects warn about such.
      For example, "point" will warn if moving the branch would make some
      commits reachable only through the commit log
    * SVN interoperation
        * Cloning an SVN repository is no different than cloning a git
          repository (only slower)
        * Same command to push to an SVN repo as a git repo
        * Standard workflow (yap update) is appropriate for svn-based and
          git-native setups
        * Working with "cache repositories" is supported directly.  When
          cloning a repository generated by "yap clone <svn url>", the new
          repositories is automatically configured to push back to the
          subversion repository.
-- 
-Steven Walter <stevenrwalter@gmail.com>
Freedom is the freedom to say that 2 + 2 = 4
B2F1 0ECC E605 7321 E818  7A65 FC81 9777 DC28 9E8F 
