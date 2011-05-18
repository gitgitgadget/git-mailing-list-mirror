From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH/RFC] git-svn: New flag to add a file in empty
	directories
Date: Wed, 18 May 2011 08:33:14 +0000
Message-ID: <20110518083314.GA22204@dcvr.yhbt.net>
References: <1305669635-10861-1-git-send-email-rchen@cs.umd.edu> <4DD373CD.6010607@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ray Chen <rchen@cs.umd.edu>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed May 18 10:33:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QMcC1-0005lP-P9
	for gcvg-git-2@lo.gmane.org; Wed, 18 May 2011 10:33:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755972Ab1ERIdP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 May 2011 04:33:15 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:46980 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755502Ab1ERIdP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2011 04:33:15 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id A4AD01F404;
	Wed, 18 May 2011 08:33:14 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <4DD373CD.6010607@alum.mit.edu>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173860>

Michael Haggerty <mhagger@alum.mit.edu> wrote:
<snip> 1..3 are all very good points

> 4. If it is a goal to support long-term tracking of a Subversion
> repository, then it would be good to add a config option to turn on this
> feature permanently for a git-svn repository, so that the user doesn't
> have to enter the extra options with each command invocation.

Command-line options should be automatically converted into config file
options inside git svn.  We should however discourage this from getting
mixed...

> 5. It might be useful to allow the placeholder files to be committed to
> Subversion, so that other git-svn users based off the same Subversion
> repository don't have to worry about empty directories.  This would
> typically be something that people would want to do semi-manually in
> specific Subversion commits.  To support this user case, one could add a
> similar option to "git svn mkdirs" that causes the placeholder files to
> be created in the working copy but not committed.  Then the user could
> review the suggested changes, perhaps add lines to the .gitignore files,
> commit to git, then dcommit to Subversion.

No, too hard and error-prone, I think.

This would require tracking which .gitignore files are git-only and
which are not (some SVN repos have .gitignore files explicitly checked
in, but that should /always/ be done explicitly by the user every time).

I would go as far as to have a flag to disable dcommit (and set-tree) on
any repo that uses this placeholder feature.  SVN-only folks could be
very unhappy to see placeholder files, especially in some cases
where placeholders may break builds or cause information leaks.


I strongly believe git-svn should leave no trace.  Nobody but the user
using git-svn should know they're using git-svn to interact with an SVN
repo.  This allows users to stay under the radar of any idiotic rules
(or knee-jerk reactions of FUD) their organization may have against
using non-standard SVN clients.  So far, it's worked out pretty well,
git-svn users slowly and quietly develop clout and influence to migrate
their repos from SVN to git.

> 6. Documentation patches would also be required.

Agreed, along with automated test cases.

-- 
Eric Wong
