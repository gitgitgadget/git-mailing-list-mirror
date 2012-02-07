From: =?UTF-8?B?IkFuZHkgR3JlZW4gKOael+WuieW7uCki?= <andy@warmcat.com>
Subject: STGIT: Deathpatch in linus tree
Date: Tue, 07 Feb 2012 05:02:12 -0800
Message-ID: <4F3120D4.1050604@warmcat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 07 14:31:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rul8p-00089h-PP
	for gcvg-git-2@plane.gmane.org; Tue, 07 Feb 2012 14:31:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755635Ab2BGNbX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Feb 2012 08:31:23 -0500
Received: from warmcat.com ([87.106.134.80]:36979 "EHLO warmcat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755549Ab2BGNbW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Feb 2012 08:31:22 -0500
X-Greylist: delayed 1747 seconds by postgrey-1.27 at vger.kernel.org; Tue, 07 Feb 2012 08:31:22 EST
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:9.0) Gecko/20111222 Thunderbird/9.0
X-Enigmail-Version: 1.3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190174>

Hi -

Linus just pushed 105e5180936d69b1aee46ead8a5fc6c68f4d5f65 to
linux-2.6... along the lines of the Monty Python joke that was so funny
it kills anyone who hears it, if I have a stgit branch based on a HEAD
that includes this commit then stgit dies when pushing on top of it.

So...

[agreen@build linux-2.6]$ stg pop --all
[agreen@build linux-2.6]$ git reset --hard 96e02d1
HEAD is now at 96e02d1 exec: fix use-after-free bug in setup_new_exec()
[agreen@build linux-2.6]$ stg push
Pushing patch "subject-patch-1-3-arm-dt-add-p" ... done (empty)
Now at patch "subject-patch-1-3-arm-dt-add-p"
[agreen@build linux-2.6]$ stg pop
Popped subject-patch-1-3-arm-dt-add-p
No patch applied

So the commit just before the bad guy is happy.  Then -->

[agreen@build linux-2.6]$ git reset --hard 105e518
HEAD is now at 105e518 Merge tag 'hwmon-fixes-for-3.3-rc3' of
git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging
[agreen@build linux-2.6]$ stg push
Error: Unhandled exception:
Traceback (most recent call last):
  File "/usr/lib/python2.7/site-packages/stgit/main.py", line 152, in _main
    ret = command.func(parser, options, args)
  File "/usr/lib/python2.7/site-packages/stgit/commands/push.py", line
68, in func
    check_clean_iw = clean_iw)
  File "/usr/lib/python2.7/site-packages/stgit/lib/transaction.py", line
95, in __init__
    self.__current_tree = self.__stack.head.data.tree
  File "/usr/lib/python2.7/site-packages/stgit/lib/git.py", line 426, in
data
    self.__repository.cat_object(self.sha1))
  File "/usr/lib/python2.7/site-packages/stgit/lib/git.py", line 408, in
parse
    assert False
AssertionError

It also dies if I use Linus' current HEAD as the basis I am stgitting on
top of, which is one patch ahead of the deathpatch.

I'm using Fedora rawhide versions of git and stgit

git-1.7.9-1.fc17.x86_64
stgit-0.15-2.fc17.noarch

-Andy
