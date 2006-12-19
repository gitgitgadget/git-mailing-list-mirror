X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
Subject: Bug: git-svn fails on Mediawiki SVN repo r2992
Date: Wed, 20 Dec 2006 00:53:13 +0100
Message-ID: <20061219235312.GB12756@thorium2.jmh.mhn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
NNTP-Posting-Date: Wed, 20 Dec 2006 00:06:08 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Greylist: delayed 900 seconds by postgrey-1.27 at vger.kernel.org; Tue, 19 Dec 2006 19:05:55 EST
Mail-Followup-To: git@vger.kernel.org, bleher@informatik.uni-muenchen.de
Content-Disposition: inline
X-Accept-Language: de, en
X-Operating-System: Linux 2.6.17-10-generic i686
User-Agent: Mutt/1.5.12-2006-07-14
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34868>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gwoy7-0006yh-TP for gcvg-git@gmane.org; Wed, 20 Dec
 2006 01:06:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932661AbWLTAF5 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 19 Dec 2006
 19:05:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932665AbWLTAF5
 (ORCPT <rfc822;git-outgoing>); Tue, 19 Dec 2006 19:05:57 -0500
Received: from mailrelay1.lrz-muenchen.de ([129.187.254.106]:60486 "EHLO
 mailrelay1.lrz-muenchen.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S932661AbWLTAF4 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 19 Dec
 2006 19:05:56 -0500
Received: from cobalt.jmh.mhn.de ([192.168.10.2] [192.168.10.2]) by
 mailout.lrz-muenchen.de for git@vger.kernel.org; Wed, 20 Dec 2006 00:50:53
 +0100
Received: (qmail 26204 invoked from network); 19 Dec 2006 23:50:53 -0000
Received: from thorium2.jmh.mhn.de (HELO localhost.localdomain)
 (10.151.1.138) by cobalt.jmh.mhn.de with SMTP; 19 Dec 2006 23:50:53 -0000
Received: by localhost.localdomain (Postfix, from userid 1000) id 72E0C926DC;
 Wed, 20 Dec 2006 00:53:13 +0100 (CET)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

There is some problem between git-svn (v1.4.4.1.gad0c3) and MediaWiki
SVN when cloning their repo.

I just did
$ git-svn init http://svn.wikimedia.org/svnroot/mediawiki/trunk/phase3
$ git-svn fetch -r 2991:3122
and git-svn went into an endless loop, repeatedly downloading and adding
the same files from r2992 over and over again.

The bad revision can be viewed here:
http://svn.wikimedia.org/viewvc/mediawiki?view=rev&revision=2992
It adds ~1000 files (mostly small images).
I can check out this revision just fine using the svn command line
client.

I found this problem while cloning this repo a while ago, using a
slightly older version of git (probably 1.4.3, don't remember exactly).
In this repo, some directories appeared in the latest revisions which
were deleted a long time ago.

You can temporarily browse this repo here:
http://misc.j-crew.de/cgi-bin/gitweb.cgi?p=mediawiki.git
HEAD contains the dir Smarty-2.6.2, which was removed in SVN r3122.
Strangely, my repo misses all commits between r2991 and r3822.
You can see the gap at
http://misc.j-crew.de/cgi-bin/gitweb.cgi?p=mediawiki.git;a=shortlog;h=49e761ba51ee0d0a698999451134acbf2e078c03

I didn't notice any strange errors while cloning, but I had to abort and
restart git-svn a few times, so maybe there was some error there?

Anyway, I figured I didn't need the _whole_ history, so this is nothing
urgent, but I thought I should report it.

