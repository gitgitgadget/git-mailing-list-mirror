From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH/RFC] gitopt - command-line parsing enhancements
Date: Mon, 08 May 2006 22:06:43 -0700
Message-ID: <1147151209168-git-send-email-normalperson@yhbt.net>
Reply-To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Tue May 09 08:22:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FdLcO-00087J-CY
	for gcvg-git@gmane.org; Tue, 09 May 2006 08:22:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751421AbWEIGWm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 May 2006 02:22:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751423AbWEIGWm
	(ORCPT <rfc822;git-outgoing>); Tue, 9 May 2006 02:22:42 -0400
Received: from hand.yhbt.net ([66.150.188.102]:7647 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1751421AbWEIGWm (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 May 2006 02:22:42 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id A49AA2DC035
	for <git@vger.kernel.org>; Mon,  8 May 2006 23:22:40 -0700 (PDT)
To: git@vger.kernel.org
X-Mailer: git-send-email 1.3.2.ge3d7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19818>


Here's my take at a new command-line option parser to reduce wear on my
fingers.  It handles both long and short options, permuting, automatic
abbreviations, required arguments, optional arguments, and bundling.

It doesn't use getopt or argp, so it should be easily portable to
non-GNU systems (and only uses git-isms trivially, so other programs can
use it easily, too).

I've tested everything lightly but it seems to be working well.  The
unit test was very helpful throughout.
More intensive testing, bugfixes and comments would be greatly
appreciated.

It should be pretty easy to convert other git-* programs to use gitopt,
and write shell wrappers for git.c like I did with am/checkout/commit.
I'll probably do so in a few days once my fingers recover a bit, of
course feedback and patches for bug reports/enhancements are encouraged,
too.

1 - gitopt: a new command-line option parser for git
	This adds the parser, tests, and some simple changes to
	the git.c wrapper.

2 - update-index: convert to using gitopt
3 - ls-tree: convert to gitopt
4 - ls-files: convert to using gitopt
	These three are fairly straightforward conversions.
	I was somewhat disappointed that update-index didn't take
	kindly to permuting arguments, but it's also a good example
	how to disable permuting via gitopt: a == b

5 - gitopt: convert setup_revisions(), and diff_opt_parse()
	This is a fairly intrusive change that affects several
	important programs.  All the tests still pass, so it must be
	working :)

6 - commit: allow --pretty= args to be abbreviated
	This one isn't strictly dependent on gitopt, and can be
	trivially changed to work without the parent patches.

-- 
Eric Wong
