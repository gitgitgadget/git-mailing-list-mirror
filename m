X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: bash completion in backticks partially broken
Date: Sun, 5 Nov 2006 04:05:40 -0500
Message-ID: <20061105090540.GA4843@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 5 Nov 2006 09:06:05 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30960>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Ggdwq-00066w-Ld for gcvg-git@gmane.org; Sun, 05 Nov
 2006 10:05:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1422626AbWKEJFp (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 5 Nov 2006
 04:05:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161223AbWKEJFp
 (ORCPT <rfc822;git-outgoing>); Sun, 5 Nov 2006 04:05:45 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:39645 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S1161216AbWKEJFo
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 5 Nov 2006 04:05:44 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1Ggdwi-0007J4-3E for git@vger.kernel.org; Sun, 05 Nov 2006 04:05:40 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 8625B20E491; Sun,  5 Nov 2006 04:05:40 -0500 (EST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

So an annoying feature of bash appears to be that it won't really
provide completion on backtick'd commands.

For example I can complete "git merge-base ma" just fine as is, but
if I toss it into backticks say "git update-ref M `git merge-base ma"
then I can't complete "ma" out to "master" anymore.

A little bit of debugging appears to show that bash is invoking the
completion hook for the outermost command; that is we are looking
for parameters for update-ref and not merge-base.

I think I could rewrite a good part of git-completion.bash to
support this use.  But it won't work for "echo `git merge-base ma"
as the outermost command is echo and we don't have a Git completion
hook registered for that command.

This is really annoying when it comes to less contrived examples.
I find myself forming odd pipelines with commit-tree, update-ref,
mktree, lstree, sed, rev-list, etc. and always keep bumping up on
the limitations of git-completion.bash.

Any suggestions?  How often do bash users try to use backticks to
call Git commands, only to find bash isn't being as helpful as it
should be?

-- 
