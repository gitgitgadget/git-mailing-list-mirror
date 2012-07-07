From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: congif spec in GIT
Date: Sat, 07 Jul 2012 20:28:16 +0200
Message-ID: <4FF87FC0.2080900@web.de>
References: <4FF6D022.10801@itcnetworks.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Radu Manea <RManea@luxoft.com>
X-From: git-owner@vger.kernel.org Sat Jul 07 20:28:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SnZkI-0006LC-00
	for gcvg-git-2@plane.gmane.org; Sat, 07 Jul 2012 20:28:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751266Ab2GGS2g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Jul 2012 14:28:36 -0400
Received: from smtp-out21.han.skanova.net ([195.67.226.208]:56060 "EHLO
	smtp-out21.han.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751031Ab2GGS2f (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 Jul 2012 14:28:35 -0400
Received: from wanderer.site (194.22.188.61) by smtp-out21.han.skanova.net (8.5.133) (authenticated as tboegi@telia.com)
        id 4FD624AF008DDE9F; Sat, 7 Jul 2012 20:28:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:13.0) Gecko/20120601 Thunderbird/13.0
In-Reply-To: <4FF6D022.10801@itcnetworks.ro>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201163>

On 06.07.12 13:46, Radu Manea wrote:
> Hi,
>
> Thank you for the detailed presentation posted on git.or.cz site.
>
> One question: is there any equivalent config spec file for GIT as is in ClearCase today?

There are similarities, and differences between git and ClearCase,
I can only point out the very basic differences,
because the philosophy of these 2 tools is completely different.


CC has a "virtual file system", often mounted on /vobs on Unix,
and M:\ (or another drive name) on Windows.

CC simulates a file system, where files are seen according
to the config spec. Changing the config spec will change the
version of the files seen under /vobs immediately.

If you want a copy of all the files on your local disk,
you need to create a "snapshot view". After changing
the config spec, the snapshot view needs to be updated.

git always has a "working tree", similar to a "snapshot view"
(except for "bare repositories", they correspond to a CC server)


CC uses branches
git uses branches

CC uses labels
git uses commit ids, A tag may point to a commit id

CC defines for each file/directory which label is used
    When a file is checked out, a branch is created for that file element
   different directories may use different branches
- git uses the same branch for the whole repo

CC uses labels for each directory, whatever the config spec say for that 
very directory.
- git uses a commit id as a base for that branch.


So if try to transform "a branch in git" into a config spec,
we do:

$ git status
# On branch my_feature_branch
  (and that branch is defined on the whole working tree, similar to 
/vobs/projects/git/tb)

If I open the "engine bonnet" of git, to see what that means 
technically, I run on the command line:

$ cat .git/HEAD ref: refs/heads/my_feature_branch
(we are on branch my_feature_branch)

When I dig further:

$ cat .git/refs/heads/my_feature_branch
a5b0a8ff7f48cfd5ea19712680c64a029e99c2ba

We see that my branch is taking commit a5b08ff7 as a base line


So a "config spec" could include 3 lines, kind of
"all files are CHECKOUT/CHECKIN"
"All files are based on commit id a5b0a8ff7f48cfd5ea19712680c64a029e99c2ba"
"If you commit one or more files at once, they are recorded on branch 
"my_feature_branch"

HTH
/Torsten
