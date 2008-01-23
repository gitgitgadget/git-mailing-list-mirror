From: JM Ibanez <jm@orangeandbronze.com>
Subject: Stripping 'git-svn-id' from commit messages, and switching to svn.noMetadata
Date: Thu, 24 Jan 2008 05:00:32 +0800
Organization: Orange & Bronze Software Labs, Ltd. Co.
Message-ID: <877ii0p89b.fsf@adler.orangeandbronze.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jan 23 22:01:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHmic-0008QO-9y
	for gcvg-git-2@gmane.org; Wed, 23 Jan 2008 22:01:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751789AbYAWVAk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jan 2008 16:00:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751802AbYAWVAk
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jan 2008 16:00:40 -0500
Received: from rv-out-0910.google.com ([209.85.198.186]:9942 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751702AbYAWVAj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jan 2008 16:00:39 -0500
Received: by rv-out-0910.google.com with SMTP id k20so2678675rvb.1
        for <git@vger.kernel.org>; Wed, 23 Jan 2008 13:00:38 -0800 (PST)
Received: by 10.141.23.7 with SMTP id a7mr6682152rvj.58.1201122038280;
        Wed, 23 Jan 2008 13:00:38 -0800 (PST)
Received: from adler.orangeandbronze.com ( [61.28.150.66])
        by mx.google.com with ESMTPS id g39sm817650rvb.16.2008.01.23.13.00.35
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 23 Jan 2008 13:00:37 -0800 (PST)
Jabber-ID: jmibanez@gmail.com
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAMFBMVEUBAQEPDw8aGhoiIiIy
 MjJGRkZaWlp0dHScnJy+vr7R0dHb29vn5+fx8fH29vb///+JzcfYAAAAAWJLR0QAiAUdSAAAAAlw
 SFlzAAAewgAAHsIBbtB1PgAAAi5JREFUOMul1E9o01AYAPAvUQ87JV+3gcemrYi32q7oQRC7gtWD
 OLs6jx5svQhDCk0GggeHTaWgt/ZF5gRlkHZePCg0lTE8SWvnUXHU3QRxyYYryrCpr4PlT81OeyE5
 fD/y5b0v73vQP2DA4aBcWvMEQjJvPKAiF66nhSsrw9CNFnOIo3PyMKRj6cmoEJt/sOiGrhBHFpnx
 qdScG64FAODEWCJ9ddoFOyhQGJ3wx6eCj51wOoDAABNmghHfrAP+BC4gD8AzvI8Nn3HAr0xUQJoL
 WIbng+dtmB58AXiajd7MfQu6ftgfNCFrvbENdpwC4j5sWXFm73HMSrVqxfdmMG7Be2BxIpGYDIIw
 mPSYPSuYEUVRKmTjg2ViyIYtpSITeuUEnkdfzFGSWr1aJwoppwLI+C46QFWVOlluatrbCJ5MOqCp
 1bTyrUsfO8bn1MK3NRt8Txsv8Wi+pOumpLUcAMebD7NK651h/LintlZsyEaUQkjStI7595XaWrQg
 BDhyF2Ck1NNN42tz1gIBjswMinGj0zfM9RZn/yiAyzcp3NH7Rr/93YZtZM69pmV6plMxNhzrSLEL
 XxCZtkHjq5wDfkvt9Rd4qm2YfZNzbp/eB13/ebth0Ew9N6ib+uYSrYhufnJv0eTyUvpRodrobHBu
 2CGiRHJniw0YboOKmE1hUnzODcNuRVJIPgP/txohspoPcx49SHfDPOfRnLtyUfZ79nmt+oTzhCKB
 A04GONwh8w9J0EXBeLkUcQAAAABJRU5ErkJggg==
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71569>


Hi,

I've been trying to convert an existing git-svn clone to noMetadata
(i.e. get rid of git-svn-id in the commit messages), primarily because
I've been using it to track two SVN repos which were originally just a
single repo-- they have the same UUID but are located on different
machines, and have branched significantly, so content-wise are no longer
the same repo.

Because the two repos have a single line of commits which they share, it
would be best if I could store that history in my git repo (as I need to
use it for merging between the two trees). Graphically, my current
history looks something like this:


    A -- B -- C -- D -- E -- a -- b -- c

    A'-- B'-- C'-- D'-- E'-- x -- y -- z

where, in reality, this should be represented as:

    A -- B -- C -- D -- E -- a -- b -- c
                         \
                          +- x -- y -- z

Because the ancestor revisions (A..E) have different commit messages
(because of the git-svn-id), they have differing SHA1 ids.  Which means
I have a hard time trying to track both branches using gitk.

I used git-filter-branch to strip off the git-svn-id lines, as follows:

 $ git filter-branch --msg-filter 'sed -e "s/^git-svn-id.*$//"' \
       --commit-filter 'NEW_SHA1=`git commit-tree "$@"`; \
         echo "s/$GIT_COMMIT/$NEW_SHA1/" >> $REMAP_FILE; \
         echo $NEW_SHA1' HEAD

The mappings between the old commit SHA1s and the new commit SHA1s I
store in $REMAP_FILE (somewhere), which I then execute as a sed script
against all my .rev_db files:

 $ find .git/svn/ -name '.rev_db' | xargs sed -f $REMAP_FILE -i.bak

Now, my problems is I've apparently confused git-svn. I can't seem to do
a git-svn rebase on this particular repo. For the record, I've changed
.git/config and set svn.noMetadata on this repo.

In particular, it seems that git-svn can't find the SVN metadata (even
if .rev_db exists). Exact error is "Unable to determine upstream SVN
information from working tree history".

The reason why I can't do a fresh git-svn clone of the two SVN repos is
the repo is already at ~7700 revisions, with large files. I don't have
the time to do a proper clone at the moment, and I tried this as an
alternative.

And yes, I did all of this on a copy of an existing repo, not the
original repo itself.

-- 
JM Ibanez
Software Architect
Orange & Bronze Software Labs, Ltd. Co.

jm@orangeandbronze.com
http://software.orangeandbronze.com/
