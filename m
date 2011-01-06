From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH/RFC] Documentation/checkout: explain behavior wrt local
 changes
Date: Thu, 6 Jan 2011 16:52:22 -0600
Message-ID: <20110106225222.GA15900@burratino>
References: <20110106154418.3348.29438.reportbug@localhost>
 <20110106173522.GB11346@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: "r.ductor" <r.ductor@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 06 23:52:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PayhG-0004pD-Sb
	for gcvg-git-2@lo.gmane.org; Thu, 06 Jan 2011 23:52:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754388Ab1AFWwh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Jan 2011 17:52:37 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:51914 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752782Ab1AFWwg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jan 2011 17:52:36 -0500
Received: by vws16 with SMTP id 16so6981706vws.19
        for <git@vger.kernel.org>; Thu, 06 Jan 2011 14:52:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=zfyaxrnSX6mkkT02fkUGjAnM5narHnnYQ7QZ/bXkO1Y=;
        b=CdBSrL4VZD/HwqWM8B1NneANB+0ocLpfmmTu0h6FFJBivIPNSSAY0XWGi/yCHfGih6
         sbXZgQW7rgA8vsqP9qKDp5BE+2S5y1w8hnoMc+j/VxZ/UR+pkhNaxmT6WgKhWNXM8k18
         IoOogvQRwtTWprdGwgRtXWorTsAMuah/dDQms=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=IrT/di79DLLQ/e52xGQLbf/m8H0mBPoYOtIzA7rIgbSxMoN52Kn3uKNYXqCqa5lXz3
         DqnGrYgfiIPY4KD/uTWJeNeCqCQogLV/dLUyOa5oXlQPaMqosOA1kqIwZaJl0lHZItwn
         VlYfbtZOnK7eHU8K4DRNYJLYhTM9/1VDVRxVI=
Received: by 10.220.193.8 with SMTP id ds8mr69629vcb.2.1294354355954;
        Thu, 06 Jan 2011 14:52:35 -0800 (PST)
Received: from burratino (adsl-69-209-72-219.dsl.chcgil.ameritech.net [69.209.72.219])
        by mx.google.com with ESMTPS id r20sm5491795vcf.10.2011.01.06.14.52.34
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 06 Jan 2011 14:52:35 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110106173522.GB11346@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164684>

Jonathan Nieder wrote:

> Proposed clearer text would be welcome, especially if in the form of
> a patch to Documentation/git-checkout.txt (see Documentation/SubmittingPatches).

Like this, maybe?

-- 8< --
Subject: Documentation/checkout: explain behavior wrt local changes

The current start of the description to "git checkout" tries to
combine an explanation of "git checkout <branch> --" with "git
checkout -- <paths>" and ends up with a muddle (as Jeff noticed).

In particular, the text does not make it obvious that the "git
checkout <branch> --" form does not clobber local changes relative
to the HEAD commit in the worktree and index.

Reported-by: r.ductor <r.ductor@gmail.com>
Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
I somehow suspect that a mention of --merge would make this clearer
but good words for it aren't coming at the moment.  Improvements
welcome.

 Documentation/git-checkout.txt |   14 ++++++++------
 1 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index 22d3611..cfb71a8 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -15,16 +15,18 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
-Updates files in the working tree to match the version in the index
-or the specified tree.  If no paths are given, 'git checkout' will
-also update `HEAD` to set the specified branch as the current
-branch.
+There are two different modes -- one to switch branches and one to
+make some paths in the work tree match the index or specified tree.
 
 'git checkout' [<branch>]::
 'git checkout' -b|-B <new_branch> [<start point>]::
 
-	This form switches branches by updating the index, working
-	tree, and HEAD to reflect the specified branch.
+	This form switches branches by changing `HEAD` and updating the
+	tracked files to the specified branch.  'git checkout' will
+	stop without doing anything if local changes overlap with
+	changes to the tracked files.  (Any local changes that do not
+	overlap with changes from `HEAD` to the specified branch will
+	be preserved.)
 +
 If `-b` is given, a new branch is created as if linkgit:git-branch[1]
 were called and then checked out; in this case you can
-- 
1.7.4.rc1
