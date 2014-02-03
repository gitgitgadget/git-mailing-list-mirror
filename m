From: Martin Erik Werner <martinerikwerner@gmail.com>
Subject: Re: [PATCH v5 1/5] t0060: Add test for manipulating symlinks via
 absolute paths
Date: Mon, 3 Feb 2014 21:12:41 +0100
Message-ID: <20140203201241.GB15607@mule>
References: <1391306351-13237-1-git-send-email-martinerikwerner@gmail.com>
 <1391358940-17373-1-git-send-email-martinerikwerner@gmail.com>
 <1391358940-17373-2-git-send-email-martinerikwerner@gmail.com>
 <xmqq7g9cf2ty.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, richih@debian.org, tboegi@web.de,
	pclouds@gmail.com, dak@gnu.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 03 21:13:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WAPtJ-0003CB-Gw
	for gcvg-git-2@plane.gmane.org; Mon, 03 Feb 2014 21:13:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753112AbaBCUMx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Feb 2014 15:12:53 -0500
Received: from mail-la0-f42.google.com ([209.85.215.42]:64514 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752464AbaBCUMr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Feb 2014 15:12:47 -0500
Received: by mail-la0-f42.google.com with SMTP id hr13so5806595lab.15
        for <git@vger.kernel.org>; Mon, 03 Feb 2014 12:12:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=uZ1mGRP8rm5Vz4By+AKuUSYWRI6JuxunO5WlbDdt4Zk=;
        b=MuqaXwvFXhomBn8KjnyjECeoWT30RHeGcm+MYMXzIypGPXhSVppIEk/H03F3roXCp+
         fLWZ7gEbQjY3zGuXMBXQNFKwFqxK3ZunWB3xULQdkRTbHLymBV2Dhi1P2TEpjw9n/Y4+
         ObZuvP4GzEPHkcVytirk0MUgaXx0ekosws7nOzWOLx1efCMLmCalyj3aMMvByYrk6XAa
         RQMIj7+A+vZvOTkwbq+0wPWQviML17FQ4ij3+2c4U2VmpxHawwPt4FLlzeDRmHE3OSlX
         NsRozC93Zwinzf+3CoalpfPDzHZplnbjnnQaJbwkOCnS+eZ9JFzxiQQiirgEiAnXTwII
         1HsQ==
X-Received: by 10.152.219.37 with SMTP id pl5mr2920323lac.36.1391458365956;
        Mon, 03 Feb 2014 12:12:45 -0800 (PST)
Received: from mule (nl116-226-21.student.uu.se. [130.243.226.21])
        by mx.google.com with ESMTPSA id ya9sm5211182lbb.2.2014.02.03.12.12.43
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 03 Feb 2014 12:12:44 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <xmqq7g9cf2ty.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241471>

On Mon, Feb 03, 2014 at 10:50:17AM -0800, Junio C Hamano wrote:
> Martin Erik Werner <martinerikwerner@gmail.com> writes:
> 
> > When symlinks in the working tree are manipulated using the absolute
> > path, git dereferences them, and tries to manipulate the link target
> > instead.
> 
> The above may a very good description of the root cause, but
> can we have description of a symptom that is visible by end-users
> that is caused by the bug being fixed with the series here, by
> ending the above like so:
> 
> 	... link target instead.  This causes "git foo bar" to
> 	misbehave in this and that way.
> 
> Testing the low-level underlying machinery like this patch does is
> not wrong per-se, but I suspect that this series was triggered by
> somebody noticing breakage in a end-user command "git foo $path"
> with $path being a full pathname to an in-tree symbolic link.  It
> wouldn't be like somebody who was bored and ran "test-path-utils"
> for fun noticed the root cause without realizing how the fix would
> affect the behaviour that would be visible to end-users, right?
> 
> Can we have that "git foo $path" to the testsuite as well?  That is
> the breakage we do not want to repeat in the future by regressing.
> 
> I am guessing "foo" is "add", but I wasn't closely following the
> progression of the series.
> 
> Thanks.

Indeed, it was first discovered via git-mv, (by Richard, using
git-annex) and me reproducing and reporting it was the start of the
thread: http://thread.gmane.org/gmane.comp.version-control.git/240467

In going further (PATCHv0):
> I've done a bit more digging into this: The issue applies to pretty
> much all commands which can be given paths to files which are present
> in the work tree, so add, cat-file, rev-list, etc.

At this stage I kind of dropped the reference to any specific top-level
command since it seemed to apply to all of them in some way, and I
figured it made more sense with a generic explanation that would apply
to all commands. But it might definitely be worth to mention it in order
for the commit messages to be less technical, and add at least one test
which would actually trigger it in a user-manner. So for the
explanation, something like that?:

	This causes for example 'git add /dir/repo/symlink' to attempt
	to add the target of the symlink rather than the symlink itself,
	which is usually not what the user intends to do.

Hmm, come to think of it, I even made some of those tests back before I
found it could be narrowly tested via prefix_path... I guess I'll pick
out the git-add one since it's the simplest, should that be added to
t0060-path-utils.sh as well, or would it fit better in t3700-add.sh?:

>From 910d8c9f51c3b3f2c03dbf15ce3cf7ea94de8d27 Mon Sep 17 00:00:00 2001
From: Martin Erik Werner <martinerikwerner@gmail.com>
Date: Thu, 16 Jan 2014 00:24:43 +0100
Subject: [PATCH] Add test for manipulating symlinks via absolute paths

When symlinks in the working tree are manipulated using the absolute
path, git derferences them, and tries to manipulate the link target
instead.

Add three known-breakage tests using add, mv, and rev-list which
checks this behaviour.

The failure of the git-add test is a regression introduced by 18e051a:
  setup: translate symlinks in filename when using absolute paths
(which did not take symlinks in the work tree into consideration).
---
 t/t0054-symlinks-via-abs-path.sh | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100755 t/t0054-symlinks-via-abs-path.sh

diff --git a/t/t0054-symlinks-via-abs-path.sh b/t/t0054-symlinks-via-abs-path.sh
new file mode 100755
index 0000000..0b3c91e
--- /dev/null
+++ b/t/t0054-symlinks-via-abs-path.sh
@@ -0,0 +1,38 @@
+#!/bin/sh
+
+test_description='symlinks via sbsolute paths
+
+This test checks the behavior when symlinks in the working tree are manipulated
+via absolute path arguments.
+'
+. ./test-lib.sh
+
+test_expect_failure SYMLINKS 'git add symlink with absolute path' '
+
+	ln -s target symlink &&
+	git add "$(pwd)/symlink"
+
+'
+
+rm -f symlink
+
+test_expect_failure SYMLINKS 'git mv symlink with absolute path' '
+
+	ln -s target symlink &&
+	git add symlink &&
+	git mv "$(pwd)"/symlink moved
+
+'
+
+rm -f symlink moved
+
+test_expect_failure 'git rev-list symlink with absolute path' '
+
+	ln -s target symlink &&
+	git add symlink &&
+	git commit -m show &&
+	test "$(git rev-list HEAD -- symlink)" = "$(git rev-list HEAD -- $(pwd)/symlink)"
+
+'
+
+test_done
-- 
1.8.5.2
