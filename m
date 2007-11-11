From: Ivan Shmakov <ivan@theory.asu.ru>
Subject: Re: tracking remotes with Git
Date: 11 Nov 2007 10:05:13 +0600
Message-ID: <m24pftmnpi.fsf@cherry.siamics.int>
References: <b1e3a35f0711090444g3c31e862g4ef4ef8139927840@mail.gmail.com>
	<200711092138.56277.robin.rosenberg.lists@dewire.com>
Reply-To: Ivan Shmakov <oneingray@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ivan Shmakov <oneingray@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 11 05:05:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ir44m-00075v-D3
	for gcvg-git-2@gmane.org; Sun, 11 Nov 2007 05:05:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751662AbXKKEFV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Nov 2007 23:05:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751657AbXKKEFV
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Nov 2007 23:05:21 -0500
Received: from mx.asu.ru ([82.179.20.33]:39284 "HELO ns.asu.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751564AbXKKEFU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Nov 2007 23:05:20 -0500
Received: (qmail 5579 invoked by uid 1002); 11 Nov 2007 04:05:15 -0000
Received: from unknown (HELO th2.phys.asu.ru) (82.179.21.199)
  by ns.asu.ru with SMTP; 11 Nov 2007 04:05:15 -0000
Received: from localhost ([127.0.0.1] helo=cherry.siamics.int)
	by th2.phys.asu.ru with esmtp (Exim 4.63)
	(envelope-from <ivan@theory.asu.ru>)
	id 1Ir44Q-0001BK-Ro; Sun, 11 Nov 2007 10:05:15 +0600
In-Reply-To: <200711092138.56277.robin.rosenberg.lists@dewire.com>
X-Date: 10 Nov 2007 10:07:08 +0600
X-Message-ID: <m28x56n3pv.fsf@cherry.siamics.int>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64395>

>>>>> Robin Rosenberg <robin.rosenberg.lists@dewire.com> writes:

[...]

 >> * it looks like `git-cvsimport' uses its own CVS protocol
 >> implementation which doesn't support compression; I've tried to
 >> clone a repository of a project hosted in CVS since circa 1998 and
 >> it 20 MiB or so to obtain revisions until 2000 or so; any ways to
 >> minimize traffic?

 > You can pass options to cvsps.  My guess is -P "-Z" will do it.

	Well, this helps somewhat.  But still, IIUC, cvsps(1) is used
	only to reconstruct the ``patch sets'', and to fetch the actual
	revisions, `git-cvsimport' contacts the CVS repository directly:

--cut: $ nl -ba git-cvsimport--
...
   182	package CVSconn;
   183	# Basic CVS dialog.
   184	# We're only interested in connecting and downloading, so ...
   185	
... not a word about the compression...
   482	package main;
   483	
   484	my $cvs = CVSconn->new($opt_d, $cvs_tree);
...
   911			print "Fetching $fn   v $rev\n" if $opt_v;
   912			my ($tmpname, $size) = $cvs->file($fn,$rev);
...
   930			unlink($tmpname);
...
--cut: $ nl -ba git-cvsimport--
