From: "Eric Kidd" <emk.lists@randomhacks.net>
Subject: git svn: Cannot rebuild rev_map with --rewrite-root
Date: Tue, 26 Feb 2008 08:47:48 -0500
Message-ID: <431341160802260547p5b02fa60ka124d636451cae50@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 26 14:48:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JU0AV-0006d9-5r
	for gcvg-git-2@gmane.org; Tue, 26 Feb 2008 14:48:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753452AbYBZNrv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Feb 2008 08:47:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753329AbYBZNrv
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Feb 2008 08:47:51 -0500
Received: from rv-out-0910.google.com ([209.85.198.185]:15812 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753178AbYBZNru (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Feb 2008 08:47:50 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1358458rvb.1
        for <git@vger.kernel.org>; Tue, 26 Feb 2008 05:47:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition:x-google-sender-auth;
        bh=B5rIZj0zYyPJs51knDzijcjMW0CyiQYJREN0kM1iCVk=;
        b=uztvM2kDXpUrHwD9YpWbqTfVIt26kMKSNJ4gD4vu+y8/3okQ87CM46M2VCWwPFEneL+mWn21pf4Lv4whii3X2oy/y+qUkZYAL4JuIqcaoNeytj/BOYozw5hgAcrn8eE4WcGMGrTp3Bs1+Q3EdY4tPWj7d0vyum4WnKMUf2hMdtI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition:x-google-sender-auth;
        b=FRs2+Yak6B7PYxYk4S5X74xkLitrCR3AxM3Z5ZpD+3NWN+b4GHg20aZifEYT/EuPTEwlfduiC7bFqyZHqe8da7jLYCHvarC3ioYtJSpS3WKB4NxRAms7+/j2fDi4eTbzdrmKBuGae1Lgtpn2OjmajdPRjfINTjsR/ZtLW7aewwo=
Received: by 10.140.132.8 with SMTP id f8mr3277536rvd.122.1204033668988;
        Tue, 26 Feb 2008 05:47:48 -0800 (PST)
Received: by 10.64.201.16 with HTTP; Tue, 26 Feb 2008 05:47:48 -0800 (PST)
Content-Disposition: inline
X-Google-Sender-Auth: cccaaa1db04806e8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75137>

Good morning! I'm trying to understand git svn's --rewrite-root
argument, and I'm confused.

In the following example, I have a Subversion repo named 'foo-svn',
containing a single (empty) project named 'foo'. This project has the
usual trunk/branches/tags layout, but no content.

When I run the following script:

  GIT_SVN_ARGS="-s --rewrite-root svn://svn.foo.org/ file://`pwd`/foo-svn/foo"

  git svn clone $GIT_SVN_ARGS foo1
  git clone foo1 foo2
  cd foo2
  git config --add remote.origin.fetch '+refs/remotes/*:refs/remotes/*'
  git fetch
  git svn init $GIT_SVN_ARGS
  git svn fetch

...it gives me the following error:

Using higher level of URL:
file:///Users/emk/src/git/git-svn-rewrite-root-test/foo-svn/foo =>
file:///Users/emk/src/git/git-svn-rewrite-root-test/foo-svn
Rebuilding .git/svn/trunk/.rev_map.6d4f8df3-8fea-4595-8e57-7b909cefc69c ...
Done rebuilding .git/svn/trunk/.rev_map.6d4f8df3-8fea-4595-8e57-7b909cefc69c
Rebuilding .git/svn/trunk/.rev_map.6d4f8df3-8fea-4595-8e57-7b909cefc69c ...
Done rebuilding .git/svn/trunk/.rev_map.6d4f8df3-8fea-4595-8e57-7b909cefc69c
Rebuilding .git/svn/trunk/.rev_map.6d4f8df3-8fea-4595-8e57-7b909cefc69c ...
Done rebuilding .git/svn/trunk/.rev_map.6d4f8df3-8fea-4595-8e57-7b909cefc69c
Rebuilding .git/svn/trunk/.rev_map.6d4f8df3-8fea-4595-8e57-7b909cefc69c ...
Done rebuilding .git/svn/trunk/.rev_map.6d4f8df3-8fea-4595-8e57-7b909cefc69c
Last fetched revision of refs/remotes/trunk was r2, but we are about
to fetch: r2!

You can find the Subversion repository and the script here:

  http://www.randomhacks.net/tmp/git-svn-rewrite-root-test.tar.gz

Other things I've tried:

 1) If I remove --rewrite-root from GIT_SVN_ARGS, it works fine.
 2) If I omit the 'git config --add remote.origin.fetch' step, it works fine.
 3) If I add more revisions to foo/trunk, I get an error of the form:

Last fetched revision of refs/remotes/trunk was $LAST_REV, but we are
about to fetch: $FIRST_REV!

 4) The following versions of git-svn all behave the same way:

    git-svn HEAD on MacOS X 10.5
    git-svn 1.5.3.7 on MacOS X 10.5
    git-svn 1.5.4 on Cygwin

 5) If I access the Subversion repository using svn+ssh://..., I get
the same error.

If I run 'git svn --version', I get:

    git-svn version 1.5.4.3.220.g99d8e (svn 1.4.4)

Also, a possibly related error was mentioned here by a user upgrading
from 1.5.3.4.452.g09149 to 1.5.4.1:

http://thread.gmane.org/gmane.comp.version-control.git/73661/focus=73664

So, am I abusing --rewrite-root, and suffering a well-deserved
failure? Or is this unexpected behavior?

Thank you for any advice you can provide!

Cheers,
Eric
