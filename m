Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49CD71F42B
	for <e@80x24.org>; Sun, 12 Nov 2017 09:49:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751425AbdKLJtG (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Nov 2017 04:49:06 -0500
Received: from cpanel2.indieserve.net ([199.212.143.6]:36036 "EHLO
        cpanel2.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750765AbdKLJtE (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Nov 2017 04:49:04 -0500
Received: from cpec03f0ed08c7f-cm68b6fcf980b0.cpe.net.cable.rogers.com ([174.118.92.171]:55312 helo=localhost.localdomain)
        by cpanel2.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1eDosx-0008IY-C1
        for git@vger.kernel.org; Sun, 12 Nov 2017 04:49:03 -0500
Date:   Sun, 12 Nov 2017 04:48:40 -0500 (EST)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Git Mailing list <git@vger.kernel.org>
Subject: more pedantry ... what means a file "known to Git"?
Message-ID: <alpine.LFD.2.21.1711120430580.30032@localhost.localdomain>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel2.indieserve.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Get-Message-Sender-Via: cpanel2.indieserve.net: authenticated_id: rpjday+crashcourse.ca/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: cpanel2.indieserve.net: rpjday@crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


  apologies for more excruciating nitpickery, but i ask since it seems
that phrase means slightly different things depending on where you
read it.

  first, i assume that there are only two categories:

  1) files known to Git
  2) files unknown to Git

and that there is no fuzzy, grey area middle ground, yes?

  now, in "man git-clean", one reads (near the top):

    Cleans the working tree by recursively removing files that are
    not under version control, starting from the current directory.

    Normally, only files unknown to Git are removed, but if the -x
              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    option is specified, ignored files are also removed.

the way that's worded suggests that ignored files are "known" to Git,
yes? that is, if, by default, "git clean" removes only files "unknown"
to Git, and "-x" extends that to ignored files, the conclusion is that
ignored files are *known* to Git.

  if, however, you check out "man git-rm", you read:

    The <file> list given to the command can be exact pathnames,
    file glob patterns, or leading directory names. The command
    removes only the paths that are known to Git. Giving the name
                                    ^^^^^^^^^^^^
    of a file that you have not told Git about does not remove that file.

so "git rm" removes only files "known to Git", but from the above
regarding how "git clean" sees this, that should include ignored
files, which of course it doesn't.

  given that this phrase occurs in a number of places:

$ grep -ir "known to git" *
builtin/difftool.c:		/* The symlink is unknown to Git so read from the filesystem */
dir.c:		error("pathspec '%s' did not match any file(s) known to git.",
Documentation/git-rm.txt:removes only the paths that are known to Git.  Giving the name of
Documentation/git-commit.txt:   be known to Git);
Documentation/user-manual.txt:error: pathspec '261dfac35cb99d380eb966e102c1197139f7fa24' did not match any file(s) known to git.
Documentation/gitattributes.txt:	Notice all types of potential whitespace errors known to Git.
Documentation/git-clean.txt:Normally, only files unknown to Git are removed, but if the `-x`
Documentation/RelNotes/1.8.2.1.txt: * The code to keep track of what directory names are known to Git on
Documentation/RelNotes/1.8.1.6.txt: * The code to keep track of what directory names are known to Git on
Documentation/RelNotes/2.9.0.txt:   known to Git.  They have been taught to do the normalization.
Documentation/RelNotes/2.8.4.txt:   known to Git.  They have been taught to do the normalization.
Documentation/RelNotes/1.8.3.txt: * The code to keep track of what directory names are known to Git on
t/t3005-ls-files-relative.sh:			echo "error: pathspec $sq$f$sq did not match any file(s) known to git."
t/t3005-ls-files-relative.sh:			echo "error: pathspec $sq$f$sq did not match any file(s) known to git."
$

it might be useful to define precisely what it means. or is it assumed
to be context dependent?

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
