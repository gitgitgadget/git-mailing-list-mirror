From: Matthias Lederhofer <matled@gmx.net>
Subject: git-sh-setup.sh:cd_to_toplevel problematic with symlinks
Date: Mon, 6 Aug 2007 18:10:45 +0200
Message-ID: <20070806161045.GA21815@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 06 18:10:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1II5AT-0008JU-3k
	for gcvg-git@gmane.org; Mon, 06 Aug 2007 18:10:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753345AbXHFQKt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Aug 2007 12:10:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753335AbXHFQKt
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Aug 2007 12:10:49 -0400
Received: from mail.gmx.net ([213.165.64.20]:37205 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753289AbXHFQKs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Aug 2007 12:10:48 -0400
Received: (qmail invoked by alias); 06 Aug 2007 16:10:46 -0000
Received: from pD9EBB594.dip0.t-ipconnect.de (EHLO moooo.ath.cx) [217.235.181.148]
  by mail.gmx.net (mp001) with SMTP; 06 Aug 2007 18:10:46 +0200
X-Authenticated: #5358227
X-Provags-ID: V01U2FsdGVkX19sovhpHXxsaolA1aEdcFrSIlbDzlqUPWX/pkUw3f
	cAy+WLgzh1mFmb
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55158>

cd_to_toplevel takes the output of git rev-parse --show-cdup and feeds
it to cd.  The problem is that cd uses PWD to do what the user means
when saying cd .., i.e. it goes to /foo when in /foo/bar even though
/foo/bar might be a symlink.  Example:

    (in an existing git repository)
    /tmp/foo$ mkdir -p a/b
    /tmp/foo$ ln -s a/b c
    /tmp/foo$ cd c
    /tmp/foo/c$ git fetch . master:master
    git-fetch: line 108: /FETCH_HEAD: Permission denied

Is there any way to tell cd to ignore $PWD?

Another option is to have a new option to rev-parse which shows the
absolute path to tho toplevel.
