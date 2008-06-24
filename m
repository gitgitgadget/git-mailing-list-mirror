From: "Klas Lindberg" <klas.lindberg@gmail.com>
Subject: git-fetch remote tag to local branch fails
Date: Tue, 24 Jun 2008 14:17:39 +0200
Message-ID: <33f4f4d70806240517h5e3ae420h263dd0c2d6bae459@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 24 14:19:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KB7UV-0002rX-48
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 14:19:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759990AbYFXMRp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 08:17:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755979AbYFXMRp
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 08:17:45 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:43532 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759990AbYFXMRo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 08:17:44 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1160713fgg.17
        for <git@vger.kernel.org>; Tue, 24 Jun 2008 05:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=r5bAurkRWOOzUZNLRrrZ55+TjVD0oj/BgWju3QV8mU4=;
        b=NwDH3qFzNqd0ZZMSIiIJsoteSChBxE/V8OCH2dbuRb7pMKxCy2obKXMg/5DFtiqbR6
         93pZgF+8mkHP95FalkwWz3ezjRuQm1eRnbfG5GjMIUPhKL9RhyGI+ctb0xg/GKnpE+Cl
         FtYdm/s8rkABZ3vSMA6wLJFexeUex4BvKCYJg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=pDHFoI0ycXyIt5XyGMEkXvSey8LMOE5DVoUP+I/z39NUDwUGfv2uiB8pcJkVHkHzfb
         BVarnjHdjc0lY+vckBFKqDUa54eG1z9qLwCJ1uXs7SRd3bKkK2LGZSXUIlnzrddwz1NN
         6gqrQP7PvakECOOpoipf2fN/lg+D0gH7puBg4=
Received: by 10.86.60.14 with SMTP id i14mr8861208fga.75.1214309860015;
        Tue, 24 Jun 2008 05:17:40 -0700 (PDT)
Received: by 10.86.68.16 with HTTP; Tue, 24 Jun 2008 05:17:39 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86042>

Hi

I have a repository "bogustree" that contains tags "test_tag" and
"foo_tag" (both on the same branch, with "test_tag" pointing to an
older commit).
I also have repository "R", which contains "test_tag" from "bogustree"
and a branch "b" created from "test_tag". The active branch in R is
"master".

Now I want to do the following from R:

git-fetch bogustree refs/tags/foo_tag:refs/heads/b

but this fails with the message given below. The interesting part is
that git-fetch tries to write a "non-commit object" and indeed I have
no idea what this thing is (the commit pointed to by "foo_tag" has
commit ID cab0a25388f1884a1ab16bd0d66f877c0b36f1d5). Another
interesting detail is that the command fails and then continues
anyway. That seems wrong in itself.

# remote: Counting objects: 6, done.
# remote: Compressing objects: 100% (2/2), done.
# remote: Total 4 (delta 0), reused 0 (delta 0)
# Unpacking objects: 100% (4/4), done.
# error: Trying to write non-commit object
5f61233bc5dad0f3e25ecea65457f5bb528174d2 to branch refs/heads/B
# From /home/qliklas/bogustree/b/b
#    72f0622..5f61233  foo_tag    -> b
# From /home/qliklas/bogustree/b/b
#  * [new tag]         foo_tag    -> foo_tag
#  * [new tag]         test_tag   -> test_tag

Why can't I fetch like this? The manual page for git-fetch says that

       <refspec>
              The canonical format of a <refspec> parameter is +?<src>:<dst>;
              that is, an optional plus +, followed by the source ref,
              followed by a colon :, followed by the destination ref.

              The remote ref that matches <src> is fetched, and if <dst> is
              not empty string, the local ref that matches it is fast
              forwarded using <src>. Again, if the optional plus + is used,
              the local ref is updated even if it does not result in a fast
              forward update.

so I think it should be OK?

BR / Klas
