From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH/RFC] git-svn: New flag to add a file in empty	directories
Date: Thu, 19 May 2011 05:11:22 +0200
Message-ID: <4DD48A5A.8030905@alum.mit.edu>
References: <1305669635-10861-1-git-send-email-rchen@cs.umd.edu> <4DD373CD.6010607@alum.mit.edu> <20110518083314.GA22204@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Ray Chen <rchen@cs.umd.edu>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Thu May 19 05:11:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QMte8-0007RY-VE
	for gcvg-git-2@lo.gmane.org; Thu, 19 May 2011 05:11:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932258Ab1ESDL1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 May 2011 23:11:27 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:57649 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932075Ab1ESDL0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2011 23:11:26 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.69.133] (p54BEDA16.dip.t-dialin.net [84.190.218.22])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p4J3BMHQ013597
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 19 May 2011 05:11:23 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.17) Gecko/20110424 Lightning/1.0b2 Thunderbird/3.1.10
In-Reply-To: <20110518083314.GA22204@dcvr.yhbt.net>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173927>

On 05/18/2011 10:33 AM, Eric Wong wrote:
> Michael Haggerty <mhagger@alum.mit.edu> wrote:
>> 5. It might be useful to allow the placeholder files to be committed to
>> Subversion, so that other git-svn users based off the same Subversion
>> repository don't have to worry about empty directories.  This would
>> typically be something that people would want to do semi-manually in
>> specific Subversion commits.  To support this user case, one could add a
>> similar option to "git svn mkdirs" that causes the placeholder files to
>> be created in the working copy but not committed.  Then the user could
>> review the suggested changes, perhaps add lines to the .gitignore files,
>> commit to git, then dcommit to Subversion.
> 
> No, too hard and error-prone, I think.
> 
> This would require tracking which .gitignore files are git-only and
> which are not (some SVN repos have .gitignore files explicitly checked
> in, but that should /always/ be done explicitly by the user every time).

I agree that the checkin should not be done automatically.  But it is
exactly to assist the explicit (manual) maintenance of placeholder files
in Subversion that this feature could be useful.

> I would go as far as to have a flag to disable dcommit (and set-tree) on
> any repo that uses this placeholder feature.  SVN-only folks could be
> very unhappy to see placeholder files, especially in some cases
> where placeholders may break builds or cause information leaks.
> 
> I strongly believe git-svn should leave no trace.  Nobody but the user
> using git-svn should know they're using git-svn to interact with an SVN
> repo.  This allows users to stay under the radar of any idiotic rules
> (or knee-jerk reactions of FUD) their organization may have against
> using non-standard SVN clients.  So far, it's worked out pretty well,
> git-svn users slowly and quietly develop clout and influence to migrate
> their repos from SVN to git.

Indeed, by default git-svn should leave no trace.  But there are other
workplaces (mine included) where the use of git-svn is welcomed and
supported.  For us, features like "git svn create-ignore" are used to
maintain .gitignore files that are committed to Subversion.  Perhaps
there needs to be a repository-wide flag to distinguish between:

"conversion mode" -- This mode would be intended for full conversions to
git.  Placeholders created for empty directories, svn:ignore properties
converted automatically into .gitignore files, etc.  These actions would
happen automatically whenever a Subversion commit is retrieved and the
changes would be added to the git history as if they had happened in the
corresponding SVN commit.  "git svn dcommit" would be forbidden from
such repositories.

"working mode" -- This mode would support the use of git-svn as a
front-end to Subversion.  It would never push git-related changes to
Subversion except at the explicit request of the user.  In this mode,
there would be commands (like "git svn create-ignore") to create git
aids like placeholders and .gitignore files in the working copy, but
only at the explicit request of the user, and these changes would never
be committed automatically.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
