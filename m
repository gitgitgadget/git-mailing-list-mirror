From: "Joakim Tjernlund" <joakim.tjernlund@transmode.se>
Subject: git-svn and u-boot broken.
Date: Fri, 13 Oct 2006 21:19:34 +0200
Message-ID: <00ad01c6eefc$84298280$1267a8c0@Jocke>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Oct 13 21:22:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GYSbe-0006bm-13
	for gcvg-git@gmane.org; Fri, 13 Oct 2006 21:22:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751833AbWJMTVn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Oct 2006 15:21:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751837AbWJMTVm
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Oct 2006 15:21:42 -0400
Received: from 147.175.241.83.in-addr.dgcsystems.net ([83.241.175.147]:21392
	"EHLO tmnt04.transmode.se") by vger.kernel.org with ESMTP
	id S1751833AbWJMTVl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Oct 2006 15:21:41 -0400
Received: from Jocke ([84.217.9.178]) by tmnt04.transmode.se with Microsoft SMTPSVC(5.0.2195.6713);
	 Fri, 13 Oct 2006 21:21:39 +0200
To: <git@vger.kernel.org>
X-Mailer: Microsoft Office Outlook 11
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2962
Thread-Index: Acbu/IPW13xsYqkVTCK12RFI2IiAow==
X-OriginalArrivalTime: 13 Oct 2006 19:21:39.0105 (UTC) FILETIME=[CE8B6910:01C6EEFC]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28854>

I am trying to create a SVN tree using git-svn from the u-boot git tree and it doesn't work.
First, I had to change this (from memory) in git-svn:
  my $got = SVN::TxDelta::send_stream($fh, @$atd, $self->{pool});
to
  my $got;
  if ( $got ) {
    $got = SVN::TxDelta::send_stream($fh, @$atd, $self->{pool});
  } else {
    $got = $exp
  }
I am no perl programmer so please change as you se fit.

Secondly I ran out of open file descriptors which I "fixed" with ulimit -n 10000, maybe there is a leak
in git-svn?

Then it still failed, but this I could not fix. Don't have the error msg atm as I am home now, but
it should be easy enough to reproduce, just clone current u-boot tree and try :)

What I really would like to do is merge all u-boot commits up to a point into one commit
and then commit that single git commit to a clean SVN repo. Then I want merge the
remaining git commits(my own stuff).
Tried to import a tar tree into the SVN repo with svn import and then merge
the remain commits on top of that using git-svn but that didn't work, lots of conflicts.

 Jocke
