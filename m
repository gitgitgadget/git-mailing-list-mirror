From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: regression in git-gui since 2c5c66b... Merge branch 'jp/get-ref-dir-unsorted
Date: Mon, 17 Oct 2011 05:40:11 +0200
Message-ID: <4E9BA39B.709@alum.mit.edu>
References: <4E9B1E32.7030101@gmail.com> <7vfwispi8u.fsf@alter.siamese.dyndns.org> <4E9B8719.1090203@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 17 05:41:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RFe5N-0002Bc-Cl
	for gcvg-git-2@lo.gmane.org; Mon, 17 Oct 2011 05:41:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754590Ab1JQDkQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Oct 2011 23:40:16 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:45527 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754487Ab1JQDkP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Oct 2011 23:40:15 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.69.134] (p54BECB73.dip.t-dialin.net [84.190.203.115])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p9H3eBeO015363
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 17 Oct 2011 05:40:12 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.23) Gecko/20110921 Lightning/1.0b2 Thunderbird/3.1.15
In-Reply-To: <4E9B8719.1090203@gmail.com>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183763>

On 10/17/2011 03:38 AM, Mark Levedahl wrote:
> On 10/16/2011 08:35 PM, Junio C Hamano wrote:
>> Mark Levedahl<mlevedahl@gmail.com>  writes:
>>> I have a project organized as a number of nested git modules (not
>>> using git-submodule), and frequently use git-new-workdir to create the
>>> nested modules.
>>>
>>> Since the above merge-commit, git-gui is confused by this arrangement
>>> and reports every file in every nested module as being an untracked
>>> file in the top-level (super) project.
> [...]
> 
> The following shows the problem for me:
> 
> #!/bin/bash
> mkdir super sub
> cd sub
> git init
> touch a
> git add a
> git commit -m 'file' a
> git pack-refs --all
> cd ../super
> git init
> git new-workdir ../sub sub
> git-gui
> 
> 
> git-gui shows "sub/a" in the list of Unstaged Changes. Note that the
> "git pack-refs" call is needed to get the failure.

Please bear with me because I don't use git-gui so I don't really know
what to expect.

When I check out 2c5c66b and run the above script (actually, the script
listed below) what I see in git-gui is:

* In the "Unstaged Changes" window, "sub" is listed (not "sub/a").

* When I click on "sub", then in the "Untracked, not staged" window,
"Git Repository (subproject)" appears.

I see the exact same thing when I run the same test script on the
version before merge 2c5c66b.

What do you see?

What do you expect to see?

What versions of git, exactly, are you testing (what version do you
consider "good"; presumably it is version 2c5c66b that you consider "bad")?

Are you certain that you are using the same git version for all commands
("git", "git-gui", and "git-new-workdir")?  Please especially note that
git-new-workdir is not part of a default git install, and therefore it
would be easy to accidentally use a different version of this script
than of the other commands.

Michael

#!/bin/bash

SRC=$(cd $(dirname $0); pwd)
GIT=$SRC/git
GIT_NEW_WORKDIR=$SRC/contrib/workdir/git-new-workdir
GITGUI=$SRC/git-gui/git-gui

rm -rf super sub
mkdir super sub
cd sub
$GIT init
touch a
$GIT add a
$GIT commit -m 'file' a
$GIT pack-refs --all
cd ../super
$GIT init
$GIT_NEW_WORKDIR ../sub sub
$GITGUI &

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
