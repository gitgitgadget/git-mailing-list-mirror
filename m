From: "Chris Lee" <chris133@gmail.com>
Subject: git-svnimport failed and now git-repack hates me
Date: Wed, 3 Jan 2007 15:52:30 -0800
Message-ID: <204011cb0701031552j8292d23v950f828279702d3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Jan 04 00:52:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2FuM-0005bS-UC
	for gcvg-git@gmane.org; Thu, 04 Jan 2007 00:52:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932202AbXACXwc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 Jan 2007 18:52:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932201AbXACXwb
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jan 2007 18:52:31 -0500
Received: from wr-out-0506.google.com ([64.233.184.236]:28685 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932202AbXACXwb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jan 2007 18:52:31 -0500
Received: by wr-out-0506.google.com with SMTP id 68so771098wri
        for <git@vger.kernel.org>; Wed, 03 Jan 2007 15:52:30 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=MdRKSeo50aKmuBrLk0JOyPArhOmZ/tB7CEbuE9G9q817GqBT0CIycd7/5MJE0M52GZHiUdlruxgfl9dfYeuhXJDu823/aKjP5Rt+9lSUEZ6NQYIF2PY+SKQVTZSmbfOZYbttkiB00Iph1LSk4nqtlZ1mSCONyr0nNDVYjkPe6fY=
Received: by 10.90.118.12 with SMTP id q12mr15303907agc.1167868350747;
        Wed, 03 Jan 2007 15:52:30 -0800 (PST)
Received: by 10.90.80.11 with HTTP; Wed, 3 Jan 2007 15:52:30 -0800 (PST)
To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35899>

So I'm using git 1.4.1, and I have been experimenting with importing
the KDE sources from Subversion using git-svnimport.

First issue I ran into: On a machine with 4GB of RAM, when I tried to
do a full import, git-svnimport died after 309906 revisions, saying
that it couldn't fork.

Checking `top` and `ps` revealed that there were no git-svnimport
processes doing anything, but all of my 4G of RAM was still marked as
used by the kernel. I had to do sysctl -w vm.drop_caches=3 to get it
to free all the RAM that the svn import had used up.

Now, after that, I tried doing `git-repack -a` because I wanted to see
how small the packed archive would be (before trying to continue
importing the rest of the revisions. There are at least another 100k
revisions that I should be able to import, eventually.)

The repack finished after about nine hours, but when I try to do a
git-verify-pack on it, it dies with this error message:

error: Packfile
.git/objects/pack/pack-540263fe66ab9398cc796f000d52531a5c6f3df3.pack
SHA1 mismatch with itself

I get the same message from git-prune.

Any ideas?
