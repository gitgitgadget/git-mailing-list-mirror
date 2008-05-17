From: Teemu Likonen <tlikonen@iki.fi>
Subject: Possible bug: hooks/post-update does not trigger
Date: Sat, 17 May 2008 18:28:16 +0300
Message-ID: <20080517152816.GA23308@mithlond.arda.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 17 17:29:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JxOLO-0006Al-Gi
	for gcvg-git-2@gmane.org; Sat, 17 May 2008 17:29:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753578AbYEQP2U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 May 2008 11:28:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753150AbYEQP2T
	(ORCPT <rfc822;git-outgoing>); Sat, 17 May 2008 11:28:19 -0400
Received: from mta-out.inet.fi ([195.156.147.13]:55717 "EHLO
	jenni1.rokki.sonera.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752759AbYEQP2T (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 May 2008 11:28:19 -0400
Received: from mithlond.arda.local (80.220.180.181) by jenni1.rokki.sonera.fi (8.5.014)
        id 482C7E620014EA39 for git@vger.kernel.org; Sat, 17 May 2008 18:28:17 +0300
Received: from dtw by mithlond.arda.local with local (Exim 4.63)
	(envelope-from <tlikonen@iki.fi>)
	id 1JxOKW-00083N-TP
	for git@vger.kernel.org; Sat, 17 May 2008 18:28:16 +0300
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82351>

Sort of a problem is that hooks/post-update script is never triggered.
I have the following setup:

I work on a local repository and publish my changes by pushing them into
a bare repository which lies on the same filesystem. The actual
publishing will then require "git update-server-info" and rsync'ing the
bare repository to another host which in turn serves the repo via http.
(No git installed on the remote side and probably never will.)

I want to make this process automatical and I have actually done it
already with hooks/post-receive. It works fine. I'm just wondering why
hooks/post-update doesn't work.

The default hooks/post-update contains the line

  exec git-update-server-info

So the file is sort of advertised being the "official" way of running
git-update-server-info. The problem is that on my bare repository side
that file never gets executed (yes, execute bits are on). I tried to put
"echo" and "touch stampfile" type commands there but nothing happens.

Well, my problem was solved simply by using hooks/post-receive instead.
I put the following lines there and it works great:

  git update-server-info
  rsync --recursive --delete . remotehost:public_html/repo.git

Still I'd like to know if there is a bug in hooks/post-update triggering
mechanism or did I do something wrong?
