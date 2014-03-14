From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [PATCH 3/3] reset: Print a warning when user uses "git reset"
 during a merge
Date: Fri, 14 Mar 2014 10:33:00 -0400
Message-ID: <5323131C.7070506@xiplink.com>
References: <1394771872-25940-1-git-send-email-andrew.kw.w@gmail.com> <1394771872-25940-4-git-send-email-andrew.kw.w@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Andrew Wong <andrew.kw.w@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 14 15:41:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WOTIy-0001Vu-6b
	for gcvg-git-2@plane.gmane.org; Fri, 14 Mar 2014 15:41:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754481AbaCNOln (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2014 10:41:43 -0400
Received: from smtp146.ord.emailsrvr.com ([173.203.6.146]:54669 "EHLO
	smtp146.ord.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753927AbaCNOln (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2014 10:41:43 -0400
X-Greylist: delayed 534 seconds by postgrey-1.27 at vger.kernel.org; Fri, 14 Mar 2014 10:41:43 EDT
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp19.relay.ord1a.emailsrvr.com (SMTP Server) with ESMTP id C48B73B0354;
	Fri, 14 Mar 2014 10:32:48 -0400 (EDT)
X-Virus-Scanned: OK
Received: by smtp19.relay.ord1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 7BBEE3B0203;
	Fri, 14 Mar 2014 10:32:48 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.3.0
In-Reply-To: <1394771872-25940-4-git-send-email-andrew.kw.w@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244089>

On 14-03-14 12:37 AM, Andrew Wong wrote:
> During a merge, "--mixed" is most likely not what the user wants. Using
> "--mixed" during a merge would leave the merged changes and new files
> mixed in with the local changes. The user would have to manually clean
> up the work tree, which is non-trivial. In future releases, we want to
> make "git reset" error out when used in the middle of a merge. For now,
> we simply print out a warning to the user.

I know this approach was suggested earlier, but given these dangers it seems
silly to give this big warning on a plain "git reset" but still go ahead and
do the things the warning talks about.

Is there any issue with changing "git reset" to error-out now but letting
"git reset --mixed" proceed?  Something like (note the reworded warning message):

$ git reset
Cowardly refusing to implicitly run 'git reset --mixed' during a merge.
This would not clean up any merged changes and would not remove any new
files that were created in the work tree.  It would also make it impossible
for git to automatically clean up the work tree later, so you would have to
clean up the work tree manually.
You probably meant to run 'git merge --abort' instead.
$ git reset --mixed   # Stoopid git!  I know what I'm doing!
$

This would mean that the 10% of git users who like to do "git reset" in the
middle of a conflicted merge will have to teach their fingers some extra
motions.  But these users are all veterans, and they can more easily type in
8 extra characters (6 with completion) than new users can recover from
accidentally misusing git-reset's power.

		M.
