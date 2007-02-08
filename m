From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: broken git-fast-import.xml
Date: Thu, 8 Feb 2007 18:13:41 -0500
Message-ID: <20070208231341.GB1382@spearce.org>
References: <864ppwtffu.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
X-From: git-owner@vger.kernel.org Fri Feb 09 00:14:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFISo-0001u2-2v
	for gcvg-git@gmane.org; Fri, 09 Feb 2007 00:14:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751840AbXBHXNq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Feb 2007 18:13:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751947AbXBHXNq
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Feb 2007 18:13:46 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:39164 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751840AbXBHXNp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Feb 2007 18:13:45 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HFISL-00053q-Si; Thu, 08 Feb 2007 18:13:34 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 652BF20FBAE; Thu,  8 Feb 2007 18:13:41 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <864ppwtffu.fsf@blue.stonehenge.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39118>

"Randal L. Schwartz" <merlyn@stonehenge.com> wrote:
> xmlto -m callouts.xsl man git-fast-import.xml
> xmlto: input does not validate (status 1)
> /Volumes/UFS/MIRROR/git-GIT/Documentation/git-fast-import.xml:527: parser error : Opening and ending tag mismatch: superscript line 527 and literal
> <simpara>The <literal><superscript>0</literal> suffix is necessary as gfi does n
>                                               ^
> /Volumes/UFS/MIRROR/git-GIT/Documentation/git-fast-import.xml:529: parser error : Opening and ending tag mismatch: literal line 529 and superscript
> m</literal> command is even read from the input.  Adding <literal></superscript>
>                                                                                ^
> make[1]: *** [git-fast-import.1] Error 1
> rm git-fast-import.xml git-diff-stages.xml

Thanks. I already knew about the problem and fixed it in 209f1298.
I think Junio planned on pulling this in from my branch on repo.or.cz:

  git://repo.or.cz/git/fastimport

but it hasn't made it to kernel.org yet.  Here's the patch, if you
want to apply it yourself:

--8>--
From: Shawn O. Pearce <spearce@spearce.org>
Date: Thu, 8 Feb 2007 01:35:37 -0500
Subject: [PATCH] Correct ^0 asciidoc syntax in fast-import docs.

I wrote this documentation with asciidoc 7.1.2, but apparently
asciidoc 8 assumes ^ means superscript.  The solution was already
documented in rev-parse's manpage and is to use {caret} instead.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 Documentation/git-fast-import.txt |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
index 0b64d33..0c44761 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -380,9 +380,9 @@ current branch value should be written as:
 ----
 	from refs/heads/branch^0
 ----
-The `^0` suffix is necessary as gfi does not permit a branch to
+The `{caret}0` suffix is necessary as gfi does not permit a branch to
 start from itself, and the branch is created in memory before the
-`from` command is even read from the input.  Adding `^0` will force
+`from` command is even read from the input.  Adding `{caret}0` will force
 gfi to resolve the commit through Git's revision parsing library,
 rather than its internal branch table, thereby loading in the
 existing value of the branch.
-- 
1.5.0.rc4
