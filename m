From: Yann Dirson <ydirson@altern.org>
Subject: stg 0.14.3 breakage on push after moving hunk
Date: Thu, 25 Sep 2008 01:26:54 +0200
Message-ID: <20080924232654.GY4985@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT list <git@vger.kernel.org>
To: Catalin Marinas <catalin.marinas@gmail.com>,
	Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Thu Sep 25 01:26:31 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kidkc-0005y1-6u
	for gcvg-git-2@gmane.org; Thu, 25 Sep 2008 01:26:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752593AbYIXXZV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Sep 2008 19:25:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752202AbYIXXZU
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Sep 2008 19:25:20 -0400
Received: from smtp6-g19.free.fr ([212.27.42.36]:42145 "EHLO smtp6-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751882AbYIXXZT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Sep 2008 19:25:19 -0400
Received: from smtp6-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp6-g19.free.fr (Postfix) with ESMTP id 5016E19717;
	Thu, 25 Sep 2008 01:25:16 +0200 (CEST)
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp6-g19.free.fr (Postfix) with ESMTP id E04D71970B;
	Thu, 25 Sep 2008 01:25:15 +0200 (CEST)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id 95D4E1F0C2; Thu, 25 Sep 2008 01:26:54 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96711>

Just saw the following problem - ever saw that ?

Getting into context: split changes affecting a particular file into
another patch

$ stg --version
Stacked GIT 0.14.3
git version 1.6.0.1
Python version 2.5.2 (r252:60911, Aug  8 2008, 09:22:44)
[GCC 4.3.1]

$ stg pop
Checking for changes in the working directory ... done
Popping patch "factorize" ... done
Now at patch "x-dummy"
$ stg new -m test
$ stg-fold-files-from factorize 't/*'
Checking for changes in the working directory ... done
Folding patch from stdin ... done
$ stg ref
Checking for changes in the working directory ... done
Refreshing patch "test" ... done

... then attempting to push to get rid of the now-duplicated changes
from orig patch (which has been how I have used stg-fold-files-from
ever since I wrote it, so I'm pretty sure it used to work, but then,
it's been a couple of months since I did not use it ;):

$ stg push
Checking for changes in the working directory ... done
Pushing patch "factorize" ... Traceback (most recent call last):
  File "/usr/bin/stg", line 43, in <module>
    main()
  File "/var/lib/python-support/python2.5/stgit/main.py", line 281, in main
    command.func(parser, options, args)   
  File "/var/lib/python-support/python2.5/stgit/commands/push.py", line 102, in func
    push_patches(crt_series, patches, options.merged)
  File "/var/lib/python-support/python2.5/stgit/commands/common.py", line 202, in push_patches
    modified = crt_series.push_patch(p)
  File "/var/lib/python-support/python2.5/stgit/stack.py", line 1112, in push_patch
    git.merge(bottom, head, top, recursive = True)
  File "/var/lib/python-support/python2.5/stgit/git.py", line 790, in merge
    stages['2'][0], stages['3'][0]) != 0:
  File "/var/lib/python-support/python2.5/stgit/gitmergeonefile.py", line 268, in merge
    % path)
TypeError: not all arguments converted during string formatting

Best regards,
-- 
Yann
