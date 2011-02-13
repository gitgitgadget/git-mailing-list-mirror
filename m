From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [STGIT] AssertionError on stg rebase
Date: Sun, 13 Feb 2011 17:35:34 -0200
Message-ID: <20110213193534.GA2437@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 13 20:35:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pohja-0008CT-I4
	for gcvg-git-2@lo.gmane.org; Sun, 13 Feb 2011 20:35:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754836Ab1BMTfq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Feb 2011 14:35:46 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:35079 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754762Ab1BMTfo (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 13 Feb 2011 14:35:44 -0500
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id DFD7720936;
	Sun, 13 Feb 2011 14:35:43 -0500 (EST)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Sun, 13 Feb 2011 14:35:43 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=date:from:to:cc:subject:message-id:mime-version:content-type; s=smtpout; bh=KghWDxDx6Hc7ViczQV2s8jNpE+g=; b=gA3IbL+9fTUb5Bs+SSFKdrwzRYnzIKE9d7//pN+COQ12SNnwh3uczwOcKezHdNwXtQ7tm1+eqgIhC4xvIevEiQSZgnVBHSPshK7rziZqkgS9vK72CyrQKvBmlTg0qMBEhL79jZ/sjqJpGkRspIPivjQqAWCUkbYSoj9WBxPMJSw=
X-Sasl-enc: QsjZ9fdZDcENr7xUAWxkdUhroYXV8phu9D3jtIvA08or 1297625743
Received: from khazad-dum.debian.net (unknown [201.82.68.120])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 9082B401586;
	Sun, 13 Feb 2011 14:35:43 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by localhost.khazad-dum.debian.net (Postfix) with ESMTP id B9729E0104;
	Sun, 13 Feb 2011 17:35:41 -0200 (BRST)
X-Virus-Scanned: Debian amavisd-new at khazad-dum.debian.net
Received: from khazad-dum.debian.net ([127.0.0.1])
	by localhost (khazad-dum2.khazad-dum.debian.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 51NHmvYGaMFv; Sun, 13 Feb 2011 17:35:34 -0200 (BRST)
Received: by khazad-dum.debian.net (Postfix, from userid 1000)
	id 93CE0E1A4A; Sun, 13 Feb 2011 17:35:34 -0200 (BRST)
Content-Disposition: inline
X-GPG-Fingerprint: 1024D/1CDB0FE3 5422 5C61 F6B7 06FB 7E04  3738 EE25 DE3F
 1CDB 0FE3
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166677>

(please keep me CC'd, I am currently not subscribed to the git ML)

It appears stgit dislikes something on the v2.6.27 longterm tree, or
something else is hosed on my system.  It is causing me a lot of
trouble, I now have a few backport branches that are unusable, and that
I'd like very much to fix...

Tested with stgit 0.15, and also stgit "proposed" branch.  Debian
squeeze, both in ia32 and x86-64.


Here is a testcase to reproduce the problem:

$ git clone git://git.kernel.org/pub/scm/linux/kernel/git/longterm/linux-2.6.27.y.git
$ cd linux-2.6.27.y
$ git reset --hard v2.6.27.53
$ stg init
$ stg new test-patch-1
$ echo "something" > changedfile
$ git add changedfile
$ stg refresh

$ stg rebase v2.6.27.58

Checking for changes in the working directory ... done
Popping all applied patches ... done
Rebasing to "v2.6.27.58" ... done
Pushing patch "test-patch-1" ... done
Now at patch "test-patch-1"
Traceback (most recent call last):
  File "/usr/bin/stg", line 44, in <module>
    main()
  File "/usr/lib/pymodules/python2.6/stgit/main.py", line 175, in main
    _main()
  File "/usr/lib/pymodules/python2.6/stgit/main.py", line 170, in _main
    directory.write_log(cmd)
  File "/usr/lib/pymodules/python2.6/stgit/commands/common.py", line 537, in write_log
    log.compat_log_entry(msg)
  File "/usr/lib/pymodules/python2.6/stgit/lib/log.py", line 372, in compat_log_entry
    log_entry(stack, msg)
  File "/usr/lib/pymodules/python2.6/stgit/lib/log.py", line 328, in log_entry
    new_log.write_commit()
  File "/usr/lib/pymodules/python2.6/stgit/lib/log.py", line 283, in write_commit
    tree = self.__tree(metadata)
  File "/usr/lib/pymodules/python2.6/stgit/lib/log.py", line 277, in __tree
    patches = dict((pn, pf(c)) for pn, c in self.patches.iteritems())
  File "/usr/lib/pymodules/python2.6/stgit/lib/log.py", line 277, in <genexpr>
    patches = dict((pn, pf(c)) for pn, c in self.patches.iteritems())
  File "/usr/lib/pymodules/python2.6/stgit/lib/log.py", line 275, in pf
    r = patch_file(self.__repo, c.data)
  File "/usr/lib/pymodules/python2.6/stgit/lib/log.py", line 116, in patch_file
    'Bottom: %s' % cd.parent.data.tree.sha1,
  File "/usr/lib/pymodules/python2.6/stgit/lib/git.py", line 426, in data
    self.__repository.cat_object(self.sha1))
  File "/usr/lib/pymodules/python2.6/stgit/lib/git.py", line 408, in parse
    assert False
AssertionError


I have other failure modes that also result on assertions, but they all
look like the same basic problem, and this one is at least easy to
reproduce.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
