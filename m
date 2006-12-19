X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Seth Falcon <sethfalcon@gmail.com>
Subject: Change in git-svn dcommit semantics?
Date: Tue, 19 Dec 2006 13:12:05 -0800
Message-ID: <m2mz5jegka.fsf@ziti.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 19 Dec 2006 21:12:41 +0000 (UTC)
Cc: Eric Wong <normalperson@yhbt.net>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:to:cc:subject:from:date:message-id:user-agent:mime-version:content-type;
        b=rMDpwtcFmA31/Wm55mpCTPbSU/HpzmL6FrCvFbdfBYoS1RrvGXqtBg8JeVoODl77JIxNgG0Ek+CHJVvUNxmRMT0vIuq5AW5lgdLHZ0bmbzS7cnE16wXyLyo6sn+QSARiJ5twIEi08Kxac4diCCrvEdIRS3Wp7ehGD9LpFfOFEz0=
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (darwin)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34852>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GwmGE-0003c9-Tw for gcvg-git@gmane.org; Tue, 19 Dec
 2006 22:12:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932954AbWLSVM2 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 19 Dec 2006
 16:12:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932968AbWLSVM2
 (ORCPT <rfc822;git-outgoing>); Tue, 19 Dec 2006 16:12:28 -0500
Received: from wx-out-0506.google.com ([66.249.82.229]:25903 "EHLO
 wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S932954AbWLSVM1 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 19 Dec
 2006 16:12:27 -0500
Received: by wx-out-0506.google.com with SMTP id h27so1784394wxd for
 <git@vger.kernel.org>; Tue, 19 Dec 2006 13:12:27 -0800 (PST)
Received: by 10.70.116.1 with SMTP id o1mr10350668wxc.1166562746769; Tue, 19
 Dec 2006 13:12:26 -0800 (PST)
Received: from ziti.local ( [140.107.181.122]) by mx.google.com with ESMTP id
 i14sm10438989wxd.2006.12.19.13.12.23; Tue, 19 Dec 2006 13:12:26 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Hi Eric,

I just updated to the latest git/git-svn (on branch 'master') and the
workflow I've been using no longer seems to work:

   # review the commits I'm going to send to svn
   ziti:~/proj/bioc-2.0-git seth$ git log remotes/git-svn..HEAD
   
   # now send them
   ziti:~/proj/bioc-2.0-git seth$ git svn dcommit remotes/git-svn..HEAD

   fatal: ambiguous argument
   'refs/remotes/git-svn..remotes/git-svn..HEAD': unknown revision or
   path not in the working tree.  Use '--' to separate paths from
   revisions 32768 at /Users/seth/scm/bin/git-svn line 2190
           main::safe_qx('git-rev-list', '--no-merges', 'refs/remotes/git-svn..remotes/git-svn..HEAD') called at /Users/seth/scm/bin/git-svn line 610
           main::dcommit('remotes/git-svn..HEAD') called at /Users/seth/scm/bin/git-svn line 197


At this point, my last commit seems to have been reset (although the
changes are thankfully still in my working tree).  If this happens to
you, you can recover the last commit like:

  git commit -a -v -c ORIG_HEAD

And it seems that the new interface requires no extra args:

 git svn dcommit

The new interface seems ok until things like 

  git svn dcommit remotes/git-svn..HEAD~2

are allowed (if ever).  But it would be nice for the failure mode to
not undo commits :-)

+ seth

git version 1.4.4.2.gee60-dirty
