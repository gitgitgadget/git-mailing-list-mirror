From: =?ISO-8859-15?Q?Dirk_S=FCsserott?= <newsletter@dirk.my1.cc>
Subject: Q about git rev-parse {--is-inside-work-tree, --show-cdup}
Date: Fri, 03 Dec 2010 22:06:36 +0100
Message-ID: <4CF95BDC.60506@dirk.my1.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Dec 03 22:06:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POcq6-00056O-9H
	for gcvg-git-2@lo.gmane.org; Fri, 03 Dec 2010 22:06:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753969Ab0LCVGk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Dec 2010 16:06:40 -0500
Received: from smtprelay02.ispgateway.de ([80.67.31.36]:42379 "EHLO
	smtprelay02.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753695Ab0LCVGj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Dec 2010 16:06:39 -0500
X-Greylist: delayed 5392 seconds by postgrey-1.27 at vger.kernel.org; Fri, 03 Dec 2010 16:06:39 EST
Received: from [84.176.55.82] (helo=[192.168.2.100])
	by smtprelay02.ispgateway.de with esmtpa (Exim 4.68)
	(envelope-from <newsletter@dirk.my1.cc>)
	id 1POcpy-0002tF-2d
	for git@vger.kernel.org; Fri, 03 Dec 2010 22:06:38 +0100
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.12) Gecko/20101027 Lightning/1.0b2 Thunderbird/3.1.6
X-Df-Sender: 757646
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162856>

Hi together,

I wrote some shell scripts that do sth with my git repositories. I place
my scripts in my ~/bin folder (not in the repo). So the first step in my
scripts is always to check whether they get called from whithin a git
repo and bail out if they don't.


I do this like so:

---------------------
if [ "$(git rev-parse --is-inside-work-tree)" = "true" ] # (1)
then
      here=$(pwd)
      cdup=$(git rev-parse --show-cdup);    # (2a)
      cdup=${cdup:-"."}                     # (2b)
      cd $cdup                              # (2c)

      [do sth useful from the topdir]

      cd $here
      exit 0;
else
      echo "Not inside a git working tree."
      exit 1;
fi
---------------------

I have two questions:

1. Wouldn't it be useful, if "git rev-parse" (1) had an option "-q" that
simply indicates whether "--is-inside-work-tree" is true by means of the
return code? Actually it has an option "-q" but that doesn't work with
"--is-inside-work-tree".

2. Wouldn't it be useful, if "git rev-parse --show-cdup" (2a) would
return a dot "." instead of nothing if we are already in the topdir?
That would make the steps (2a), (2b), (2c) to a simple "cd $(git
rev-parse --show-cdup)".

(For those who aren't familiar with shell programming: (2b) means: 'if
$cdup is empty, then set it to "."'.)

I know that 2. is a problem, because "git rev-parse" is a plumbing tool.
People likely rely on "--show-dup" to return an empty string. But what
about 1.? I think there's no harm if "-q" would work for
"--is-inside-work-tree" as well.

BTW: I'm sorry that all my sentences start with "I". ;-)

What do you think? If appreciated, I'd like to work on a patch for (1).

Cheers,
     Dirk
