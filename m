X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Seth Falcon <sethfalcon@gmail.com>
Subject: git-svn problem: unexpected files/diffs in commit
Date: Fri, 25 Aug 2006 09:31:49 -0700
Message-ID: <m2u040n5e2.fsf@ziti.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 25 Aug 2006 16:31:54 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:to:subject:from:date:message-id:user-agent:mime-version:content-type;
        b=WP4mcmOmNyhGeuMb6FVUFLM2ZHrZhn4vQspdoNWt9XkfAUZ8XupFF/2sN/SkUK7Kc1FKIEDFrsah7cbKuY0ampswMuUR1nQAptIMhR0dg3YIOxG/gv9lJa3ysiXsegiZM33ofwgTs0zZprF/cCS8zv9v3gYM9uCSDvNDjeCCmkk=
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (darwin)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26000>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GGean-0007R7-0w for gcvg-git@gmane.org; Fri, 25 Aug
 2006 18:31:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030213AbWHYQbd (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 25 Aug 2006
 12:31:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030214AbWHYQbd
 (ORCPT <rfc822;git-outgoing>); Fri, 25 Aug 2006 12:31:33 -0400
Received: from nz-out-0102.google.com ([64.233.162.200]:31306 "EHLO
 nz-out-0102.google.com") by vger.kernel.org with ESMTP id S1030213AbWHYQbc
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 25 Aug 2006 12:31:32 -0400
Received: by nz-out-0102.google.com with SMTP id n1so639462nzf for
 <git@vger.kernel.org>; Fri, 25 Aug 2006 09:31:32 -0700 (PDT)
Received: by 10.65.126.4 with SMTP id d4mr3970252qbn; Fri, 25 Aug 2006
 09:31:32 -0700 (PDT)
Received: from ziti.local ( [140.107.181.122]) by mx.gmail.com with ESMTP id
 m1sm2647734nzf.2006.08.25.09.31.31; Fri, 25 Aug 2006 09:31:31 -0700 (PDT)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Hi,

I just made an svn commit using 'git-svn commit' and ended up with a
quite unexpected result.  

I'm using svn, version 1.3.2 (r19776) _with_ the SVN:: lib and 
git is git version 1.4.2.g7099c (actually, I just updated and so I was
a few commits back, but git-svn.perl didn't change, so I'm pretty
confident that I'm current w.r.t. git-svn).

Here is a copy/paste of my session (some edits since some history was lost):

## Check for changes in svn repos and merge them in.

    ziti:~/proj/graph-git seth$ git-svn fetch
    ziti:~/proj/graph-git seth$ git pull . remotes/git-svn
    Trying really trivial in-index merge...
    Wonderful.
    In-index merge
     DESCRIPTION            |    2 +-
     R/AllGenerics.R        |    2 +-
     R/clustergraph.R       |    4 ++--
     man/distGraph-class.Rd |    6 ++++--
     4 files changed, 8 insertions(+), 6 deletions(-)

## I'm really where I think I am:

   ziti:~/proj/graph-git seth$ git branch
   * master

## Let's see what I _would_ commit if I did the normal git-svn commit
## thing

   ziti:~/proj/graph-git seth$ git diff --stat remotes/git-svn..master
    inst/unitTests/graphNEL_test.R |    2 +-
    inst/unitTests/runalltests.R   |    6 +++---
    2 files changed, 4 insertions(+), 4 deletions(-)

## Yeah, that looks right.

## ok, go for the commit

    ziti:~/proj/graph-git seth$ git-svn commit remotes/git-svn..master
    diff-tree f5ebf17f7e460d3bc3de72ab381c72dc76d26936 0681f7614c342b85b91d909ff02a9a966a44c3f4
            M       DESCRIPTION
            M       R/AllGenerics.R
            M       R/clustergraph.R
            M       inst/unitTests/graphNEL_test.R
            M       inst/unitTests/runalltests.R
            M       man/distGraph-class.Rd
    r19467 = 1b75d81a95da328f0b0d06b7562fdb48970b4c98
    RA layer request failed: OPTIONS request failed on '/bioconductor': OPTIONS of '/bioconductor': Could not read status line: SSL error: decryption failed or bad record mac (https://hedgehog.fhcrc.org) at /Users/seth/scm/bin/git-svn line 526
    65280 at /Users/seth/scm/bin/git-svn line 547
            main::commit_lib('0681f7614c342b85b91d909ff02a9a966a44c3f4', '0cccf3753b472b52a93154ed8021499055bb3923') called at /Users/seth/scm/bin/git-svn line 457
            main::commit('remotes/git-svn..master') called at /Users/seth/scm/bin/git-svn line 149


## GAAAHH! That isn't what I wanted at all.  It looks as if I didn't
## really do the pull.  What is going on?

Despite the SSL error, the commit to svn actually went through and I
had to back it out.  Did I do something wrong?  I did the git-svn
fetch and pull to sync up, then reapplied my patch and git-svn commit
"worked" although I got the same SSL error.

If I can provide more info, let me know.  

Thanks,

