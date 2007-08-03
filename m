From: Pavel Roskin <proski@gnu.org>
Subject: Some ideas for StGIT
Date: Fri, 03 Aug 2007 13:50:10 -0400
Message-ID: <1186163410.26110.55.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 03 19:50:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IH1IK-000110-9O
	for gcvg-git@gmane.org; Fri, 03 Aug 2007 19:50:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763537AbXHCRuR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Aug 2007 13:50:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763775AbXHCRuQ
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Aug 2007 13:50:16 -0400
Received: from fencepost.gnu.org ([140.186.70.10]:46658 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763675AbXHCRuN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Aug 2007 13:50:13 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.60)
	(envelope-from <proski@gnu.org>)
	id 1IH1KN-0000HD-FF
	for git@vger.kernel.org; Fri, 03 Aug 2007 13:52:43 -0400
Received: from proski by gnu.org with local (Exim 4.66)
	(envelope-from <proski@gnu.org>)
	id 1IH1Hu-0007OK-9Q; Fri, 03 Aug 2007 13:50:10 -0400
X-Mailer: Evolution 2.10.3 (2.10.3-2.fc7) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54735>

Hello!

I was recently disappointed to learn that one of the Linux drivers
(bcm43xx_mac80211, to be precise) switched from git to quilt.  I asked
whether StGIT was considered, a discussion followed, and I think the key
points need to be shared with StGIT developers.  I'll add some of my
ideas to the mix.

The main point in favor of quilt is that it allows to edit the patches
with the text editor.  One can pop all patches, edit them and push the
all back.

I don't suggest that StGIT gives up on the git-based storage, but this
mode of operation could be implemented in two ways.

One is to have a command opposite to "export".  It would read the files
that "export" produces, replacing the existing patches.

Another approach would be to reexamine the patch after "stg refresh -es"
and to apply it instead of the original patch.  If the patch doesn't
apply, the options would be to discard the edits or to re-launch the
editor.

Next issue is that it should be possible to create a patch in one
operation.  StGIT follows quilt too closely here in requiring "new" and
"refresh", instead of utilizing the advantage of the workflow that
allows immediate editing of the sources without any commands.

Basically, I want one command that:

1) shows user what was changed
2) allows user to name the patch
3) allows user to describe the patch
4) allows user to exclude files from the patch
5) doesn't require another command to put the changes to the patch

I think the most natural approach would be to enhance "stg new".  I see
"stg new -s" is supposed to show the changes, but it's currently broken.
This is run in a clean StGIT repository with no patches:

$ stg new -s foo
Traceback (most recent call last):
  File "/home/proski/bin/stg", line 43, in <module>
    main()
  File "home/proski/lib/python2.5/site-packages/stgit/main.py", line 284, in main
  File "/usr/lib64/python2.5/new.py", line 82, in func
    
  File "home/proski/lib/python2.5/site-packages/stgit/stack.py", line 842, in new_patch
  File "home/proski/lib/python2.5/site-packages/stgit/stack.py", line 89, in edit_file
  File "home/proski/lib/python2.5/site-packages/stgit/stack.py", line 461, in get_patch
  File "home/proski/lib/python2.5/site-packages/stgit/stack.py", line 148, in __init__
  File "/usr/lib64/python2.5/posixpath.py", line 60, in join
    if b.startswith('/'):
AttributeError: 'NoneType' object has no attribute 'startswith'

Another backtrace in "stg new", also run in a clean StGIT repository with no patches:

$ EDITOR=true stg new todo           
Invoking the editor: "true .stgitmsg.txt" ... done
$ stg export -np
Checking for changes in the working directory ... done
Traceback (most recent call last):
  File "/home/proski/bin/stg", line 43, in <module>
    main()
  File "home/proski/lib/python2.5/site-packages/stgit/main.py", line 284, in main
  File "home/proski/lib/python2.5/site-packages/stgit/commands/export.py", line 137, in func
AttributeError: 'NoneType' object has no attribute 'strip'

Finally, it would be great to have TLS support in the mail command.
Mercurial has it, and looking at their mail.py, it doesn't seem to be
much work.

-- 
Regards,
Pavel Roskin
