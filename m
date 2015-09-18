From: Michael Rappazzo <rappazzo@gmail.com>
Subject: [PATCH v8 0/4] worktree: list functions and command
Date: Fri, 18 Sep 2015 09:30:23 -0400
Message-ID: <1442583027-47653-1-git-send-email-rappazzo@gmail.com>
Cc: git@vger.kernel.org, Michael Rappazzo <rappazzo@gmail.com>
To: gitster@pobox.com, sunshine@sunshineco.com,
	dturner@twopensource.com
X-From: git-owner@vger.kernel.org Fri Sep 18 15:31:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zcvku-0005du-45
	for gcvg-git-2@plane.gmane.org; Fri, 18 Sep 2015 15:31:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751658AbbIRNbF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Sep 2015 09:31:05 -0400
Received: from mail-qg0-f43.google.com ([209.85.192.43]:36737 "EHLO
	mail-qg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751414AbbIRNbE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Sep 2015 09:31:04 -0400
Received: by qgx61 with SMTP id 61so38364466qgx.3
        for <git@vger.kernel.org>; Fri, 18 Sep 2015 06:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=31608gaam1E8Xw1MsShGkVmKO5dpXsY0keoWvyUD7UE=;
        b=1KDk577F5YGpqwZhGCQf/ze6BUgna5Q6n84WGObKrIsO31CxByNCnBltFMH2WWuQ8N
         PgSQUwmf3vkoCm9z4EoLVP6ugRg8T9yeRbPC5rpVtBRDWuavTRx/EeKBFv7+8b1BhFR6
         i/+fKVwAbVquTv0TUmJz3f9KRV4cdF8mNIGABHJE8rt3HScLvlo21IfhGzP/927D3I3b
         80/s5QFzvNqJcugMwaKIfzD1c6RydsH/kohP6eVyzjJ1BUnJpWFS3KQl0n82HKtMHDpt
         mI7oABtiE0TZi0vq9gsKtdgeSsIf9lwJ+gARfw0XYj626p2J77FjgMqTvjdaHD8Hypm6
         e62Q==
X-Received: by 10.140.91.164 with SMTP id z33mr6343840qgd.40.1442583063075;
        Fri, 18 Sep 2015 06:31:03 -0700 (PDT)
Received: from localhost.localdomain (109.sub-70-199-70.myvzw.com. [70.199.70.109])
        by smtp.gmail.com with ESMTPSA id i19sm3586051qkh.13.2015.09.18.06.31.01
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 18 Sep 2015 06:31:02 -0700 (PDT)
X-Mailer: git-send-email 2.5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278190>

Changes from v7[1]:

	- Reworked history to try to maintain blame from moving functions 
	  from branch.c

	- Removed the worktree_list struct (linked list) and instead return
	  return an array of worktrees.  An alternative was also proposed to
	  include a `next` pointer in the worktree struct.  I coded this 
	  option separately (found in my github fork[2]), but ultimately felt
	  that the array was more managable from a client perspective.

	- Removed the `--skip-bare` and `--verbose` command line options for 
	  `worktree list`.

	- The default output of the includes all of the details which were
	  previously only included in verbose output.  Sample output:

		$git worktree list
		/Users/me/code/bare-git-source         (bare)
		/Users/me/code/worktree-git-from-bare  7ecec52 [master]
		/Users/me/code/wt2                     8681989 (detached HEAD)

	- Added `--porcelain` option to the worktree list command.  

		$git worktree list --porcelain
		worktree /Users/mike/code/bare-git-source
		bare
		
		worktree /Users/mike/code/worktree-git-from-bare
		branch master
		
		worktree /Users/mike/code/wt2
		detached at 8681989

[1]: http://thread.gmane.org/gmane.comp.version-control.git/277335
[2]: https://github.com/git/git/compare/master...rappazzo:worktree-list/v8/next-entry-in-worktree

Michael Rappazzo (4):
  worktree: add top-level worktree.c
  worktree: refactor find_linked_symref function
  worktree: add functions to get worktree details
  worktree: add 'list' command

 Documentation/git-worktree.txt |  15 ++-
 Makefile                       |   1 +
 branch.c                       |  79 +-------------
 branch.h                       |   8 --
 builtin/notes.c                |   1 +
 builtin/worktree.c             |  78 ++++++++++++++
 t/t2027-worktree-list.sh       |  86 +++++++++++++++
 worktree.c                     | 238 +++++++++++++++++++++++++++++++++++++++++
 worktree.h                     |  38 +++++++
 9 files changed, 457 insertions(+), 87 deletions(-)
 create mode 100755 t/t2027-worktree-list.sh
 create mode 100644 worktree.c
 create mode 100644 worktree.h

-- 
2.5.0
