From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] GIT_ONE_FILESYSTEM: flip the default to stop at filesystem
 boundaries
Date: Sun, 04 Apr 2010 11:00:09 -0700
Message-ID: <7v4ojr85ee.fsf_-_@alter.siamese.dyndns.org>
References: <1268855753-25840-1-git-send-email-lars@pixar.com>
 <1268855753-25840-4-git-send-email-lars@pixar.com>
 <20100328092253.GA17563@coredump.intra.peff.net>
 <7vr5n44crq.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1003301537150.3707@i5.linux-foundation.org>
 <20100330230211.GC608@coredump.intra.peff.net>
 <alpine.LFD.2.00.1003301610151.3707@i5.linux-foundation.org>
 <40aa078e1003301754u3a1e5e9je7bb2aa2dc04f6a1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Jeff King <peff@peff.net>,
	Erik Faye-Lund <kusmabite@googlemail.com>, git@vger.kernel.org
To: "Lars R. Damerow" <lars@pixar.com>
X-From: git-owner@vger.kernel.org Sun Apr 04 20:00:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NyU7c-0001M8-9x
	for gcvg-git-2@lo.gmane.org; Sun, 04 Apr 2010 20:00:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752188Ab0DDSAZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Apr 2010 14:00:25 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:39260 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751861Ab0DDSAX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Apr 2010 14:00:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5D52FA8D22;
	Sun,  4 Apr 2010 14:00:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DI13SiTMSSKyEMFIjdIuCYRYgdk=; b=fXy6xM
	gtivi7vKQ9cDY3a8/2UHZWeEwODsgLcRE3EdW52qusAuShHST14+OyzhFyF9oAXS
	1HSuBMrKZ3Ep060YS1nBy8K+1C4adj5JB9Fw+tt9xclRYpDekYSO3Oa2hCn2mqd4
	fxj9p4NY5SbGAyfaRLKTRl61d7Nmf+HEqT7jc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uxGdYeY4Gj2awxDvwNY41xfMCglJSZm+
	lUX52DzEL6nVn87reEE0TnBLIIeHD4A6XUuXY9SgeF7bjXBn+iMjLGb/tCGZqOb/
	zp9sXNpCePIWVVhFTQ+bPhlEvNx2KW0pJZfNoDtESYwgMMGBbi+4WVCKNN/ga2SW
	FTDtD6OIbco=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0E044A8D1D;
	Sun,  4 Apr 2010 14:00:17 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D99EAA8D1A; Sun,  4 Apr
 2010 14:00:10 -0400 (EDT)
In-Reply-To: <40aa078e1003301754u3a1e5e9je7bb2aa2dc04f6a1@mail.gmail.com>
 (Erik Faye-Lund's message of "Wed\, 31 Mar 2010 02\:54\:24 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: ED10E3BC-4013-11DF-95EB-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143935>

Regarding the new environment variable, Linus Torvalds
<torvalds@linux-foundation.org> writes on Tue, 30 Mar 2010 in
<alpine.LFD.2.00.1003301537150.3707@i5.linux-foundation.org>:

    I suspect that it is _very_ unusual to have a source repo that crosses
    multiple filesystems, and the original reason for this patch-series
    seems to me to be likely to be more common than that multi-fs case. So
    having the logic go the other way would seem to match the common case,
    no?

The "crossing filesystem boundary" condition is checked by comparing
st_dev field in the result from stat(2).  This is slightly worrysome if
non-POSIX ports return different values in the field even for directories
in the same work tree extracted to the same "filesystem".  Erik Faye-Lund
confirms that in the msysgit port st_dev is 0, so this should be safe, as
"even Windows is safe" ;-)

This will affect those who use /.git to cram /etc and /home/me in the same
repostiory, /home is mounted from non-root filesystem, and a git operation
is done from inside /home/me/src.  But that is such a corner case we don't
want to give preference over helping people who will benefit from having
this default so that they do not have to suffer from slow automounters.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * I agree with Linus that it make sense to flip the default, but this
   should probably have to wait for at least two release cycles for the
   usual backward-compatibility rules.

   I wonder if "git add" and friends should also notice it and warn.  If
   you have more than one values of ce->ce_dev in the index, it means that
   the working tree spans more than one filesystem and from a subdirectory
   with an entry that has a ce->ce_dev different from the value for a path
   at the top of the work tree, you will not be able to discover the top
   of the tree without GIT_ONE_FILESYSTEM set to true.  A likely scenario
   for this to happen would be:

    (1) You have a tarball of some sort; you extract it $there;

	$ mkdir $there && cd $there
        $ tar xf /var/tmp/tarball.tar

    (2) You notice the filesystem lacks enough free space, and move some
        part (say "images/") to a separate filesystem, and bind-mount;

        $ mv images $another/. && rm -fr images && mkdir images
        $ mount --bind $another/images images

    (3) You add everything to start the project;

        $ git init && git add .

        Up to this point it would work (you are at the top of the working
        tree).  And this is the point we _could_ notice and warn that you
        will have trouble in step (4).

    (4) Go down to a subdirectory and start futzing;

	$ cd images && gimp naughty.jpg && git add -u

 Documentation/git.txt |   12 ++++++++----
 setup.c               |    4 ++--
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index bf1b45e..aa62083 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -531,10 +531,14 @@ git so take care if using Cogito etc.
 	(Useful for excluding slow-loading network directories.)
 
 'GIT_ONE_FILESYSTEM'::
-	If set to a true value ("true" or a non-zero integer), stop at
-	filesystem boundaries when looking for a repository directory.
-	Like 'GIT_CEILING_DIRECTORIES', it will not affect an explicit
-	respository directory set via 'GIT_DIR' or on the command line.
+	When run in a directory that does not have ".git" repository
+	directory, git tries to find such a directory in the parent
+	directories to find the top of the working tree, but by default it
+	does not cross filesystem boundaries.  This environment variable
+	can be set to false value ("false" or zero) to tell git not to
+	stop at filesystem boundaries.  Like 'GIT_CEILING_DIRECTORIES',
+	this will not affect an explicit respository directory set via
+	'GIT_DIR' or on the command line.
 
 git Commits
 ~~~~~~~~~~~
diff --git a/setup.c b/setup.c
index 8b911b1..d290633 100644
--- a/setup.c
+++ b/setup.c
@@ -323,7 +323,7 @@ const char *setup_git_directory_gently(int *nongit_ok)
 	const char *gitdirenv;
 	const char *gitfile_dir;
 	int len, offset, ceil_offset, root_len;
-	int current_device = 0, one_filesystem = 0;
+	int current_device = 0, one_filesystem = 1;
 	struct stat buf;
 
 	/*
@@ -444,7 +444,7 @@ const char *setup_git_directory_gently(int *nongit_ok)
 				}
 				cwd[offset] = '\0';
 				die("Not a git repository (or any parent up to mount parent %s)\n"
-					"Stopping at filesystem boundary since GIT_ONE_FILESYSTEM is set.", cwd);
+				"Stopping at filesystem boundary since GIT_ONE_FILESYSTEM is true.", cwd);
 			}
 		}
 		if (chdir("..")) {
-- 
1.7.0.4.552.gc303c1
