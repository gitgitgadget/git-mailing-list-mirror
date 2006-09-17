From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: gitweb on OpenBSD (-T not supported on filesystems...)
Date: Sun, 17 Sep 2006 11:12:12 +0200
Organization: At home
Message-ID: <eej3g3$d9j$1@sea.gmane.org>
References: <op.tf0k9fdvqpav6l@crystal.sienna.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Sun Sep 17 11:12:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GOsgr-00083v-Et
	for gcvg-git@gmane.org; Sun, 17 Sep 2006 11:11:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932405AbWIQJLv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Sep 2006 05:11:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932406AbWIQJLu
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Sep 2006 05:11:50 -0400
Received: from main.gmane.org ([80.91.229.2]:1972 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932405AbWIQJLu (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Sep 2006 05:11:50 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GOsgf-00080m-Do
	for git@vger.kernel.org; Sun, 17 Sep 2006 11:11:41 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 17 Sep 2006 11:11:41 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 17 Sep 2006 11:11:41 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27174>

Andrew Pamment wrote:

> I'm not sure if this is useful but I thought I would post it anyway,
> 
> in gitweb.cgi on line 1560 where you have -T testing a file descripter, it  
> doesn't work on OpenBSD 3.9, which makes viewing blobs not work.
> 
> I solved this (or I think I have) by replacing $fd with $filename.

This doesn't work. $filename is file name relative to the git repository,
i.e. full path would be $projectroot/$project/../$file_name _if_ the
repository is full repository and not bare repository, and when projects
are symlinked .. goes up linked directory.

We need '-T $fd', where $fd is open pipe from git-cat-file, to avoid
creating temporary files (we just removed need for $tmp_dir and temporary
files for creating diffs).


What Perl version do you use? Does 'perldoc -f -X' has the following lines?

        -X FILEHANDLE

        (...) If "-T" or "-B" is used on a filehandle, the current IO buffer
        is examined rather than the first block. (...)

The solution for you would be to skip -T test.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
