From: jrnieder@uchicago.edu
Subject: Re: [RFC/PATCH] Documentation: Don't assume git-sh-setup and
 git-parse-remote are in the PATH
Date: Sun, 29 Jun 2008 11:10:20 -0500 (CDT)
Message-ID: <Pine.GSO.4.62.0806291026310.8371@harper.uchicago.edu>
References: <20080627151001.BIA19424@m4500-01.uchicago.edu>
 <20080628205817.GB3172@steel.home> <7vvdztmfrk.fsf@gitster.siamese.dyndns.org>
 <20080629053823.GA8262@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Alex Riesen <raa.lkml@gmail.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 29 18:12:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCzVP-0000gQ-RZ
	for gcvg-git-2@gmane.org; Sun, 29 Jun 2008 18:12:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753424AbYF2QKo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jun 2008 12:10:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753310AbYF2QKo
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jun 2008 12:10:44 -0400
Received: from smtp00.uchicago.edu ([128.135.12.76]:45496 "EHLO
	smtp00.uchicago.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753292AbYF2QKn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jun 2008 12:10:43 -0400
Received: from harper.uchicago.edu (harper.uchicago.edu [128.135.12.7])
	by smtp00.uchicago.edu (8.13.8/8.13.8) with ESMTP id m5TGAR0B018655;
	Sun, 29 Jun 2008 11:10:27 -0500
Received: from localhost (jrnieder@localhost)
	by harper.uchicago.edu (8.12.10/8.12.10) with ESMTP id m5TGAKvv009789;
	Sun, 29 Jun 2008 11:10:20 -0500 (CDT)
X-Authentication-Warning: harper.uchicago.edu: jrnieder owned process doing -bs
In-Reply-To: <20080629053823.GA8262@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86812>

On Sun, 29 Jun 2008, Jeff King wrote:

> I think the right question is:
> 
>   PATH=$PATH:$(git --exec-path)
>   . git-sh-setup
> 
> or
> 
>   . "$(git --exec-path)/git-sh-setup"
> 
> ?
> 
> Generally, I would prefer the latter because it has no side effects.

On Sun, 28 Jun 2008, Alex Riesen wrote:

> . "$(git --exec-path)/git-sh-setup"

I agree. I was blindly following the instructions from the release notes
to Git 1.5.4. After thinking about it a little and reading git-sh-setup.sh
and git-parse-remote.sh, it does seem safe not to add the exec-path to PATH.

How about this documentation patch? (This time tested! With hg-fast-export
appropriately modified:
  $ hg clone http://hg.sharesource.org/asciidoc
  $ mkdir asciidoc-git && cd asciidoc-git
  $ git init && hg-fast-export.sh -r /path/to/asciidoc --quiet
  $ git checkout
  $ sudo ./install.sh
  $ cd /path/to/git/Documentation && make git-{sh-setup,parse-remote}.html
I haven't tried rebuilding manpages, though.)

Junio: I stole the commit message from you. I hope you don't mind.

-- %< --

Subject: [PATCH] Documentation: don't assume git-sh-setup and git-parse-remote are in PATH

When git-parse-remote and git-sh-setup are not installed in
$(bindir) anymore, the shell script library won't be found on
user's $PATH in general.

Signed-off-by: Jonathan Nieder <jrnieder@uchicago.edu>
---
 Documentation/git-parse-remote.txt |    2 +-
 Documentation/git-sh-setup.txt     |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-parse-remote.txt b/Documentation/git-parse-remote.txt
index 951dbd6..421312e 100644
--- a/Documentation/git-parse-remote.txt
+++ b/Documentation/git-parse-remote.txt
@@ -8,7 +8,7 @@ git-parse-remote - Routines to help parsing remote repository access parameters
 
 SYNOPSIS
 --------
-'. git-parse-remote'
+'. "$(git --exec-path)/git-parse-remote"'
 
 DESCRIPTION
 -----------
diff --git a/Documentation/git-sh-setup.txt b/Documentation/git-sh-setup.txt
index c543170..6731f9a 100644
--- a/Documentation/git-sh-setup.txt
+++ b/Documentation/git-sh-setup.txt
@@ -7,7 +7,7 @@ git-sh-setup - Common git shell script setup code
 
 SYNOPSIS
 --------
-'git-sh-setup'
+'. "$(git --exec-path)/git-sh-setup"'
 
 DESCRIPTION
 -----------
-- 
1.5.5.1.328.gbfcc6
