From: Junio C Hamano <gitster@pobox.com>
Subject: [RFC/PATCH] fsck: default to "git fsck --full"
Date: Tue, 20 Oct 2009 11:46:55 -0700
Message-ID: <7v3a5doqcg.fsf_-_@alter.siamese.dyndns.org>
References: <loom.20091019T094924-194@post.gmane.org>
 <4ADC2D45.3020803@viscovery.net>
 <alpine.DEB.1.00.0910191202020.4985@pacific.mpi-cbg.de>
 <7v7hur1a0h.fsf@alter.siamese.dyndns.org> <vpqy6n6shri.fsf@bauges.imag.fr>
 <7vfx9esgvt.fsf@alter.siamese.dyndns.org>
 <81b0412b0910200225g47220cc9wa2e82290a853c85d@mail.gmail.com>
 <alpine.DEB.1.00.0910201221250.4985@pacific.mpi-cbg.de>
 <vpq1vkygtx6.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Alex Riesen <raa.lkml@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Sergio Callegari <sergio.callegari@gmail.com>,
	git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Oct 20 20:47:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0Jjv-0002dM-PZ
	for gcvg-git-2@lo.gmane.org; Tue, 20 Oct 2009 20:47:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751675AbZJTSrN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Oct 2009 14:47:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751381AbZJTSrN
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Oct 2009 14:47:13 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:34140 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751284AbZJTSrM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Oct 2009 14:47:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1D8DF7F067;
	Tue, 20 Oct 2009 14:47:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tkMP8Sd+LGA+TTI3J8jgr9iUU1w=; b=nYBDeL
	y+kfE6djR4zHBOp9QvBcRr7W/5FT+6vXww/Jiz/BD1g8EfSSm0OMB54sS3yWRAf6
	nU5aTX+txo3YFduDlD/M8tGlBQQ3DYBNgQkfkfdj+oeQXQ5KHl6wey8gSKNLOtdV
	JxigR0d0al6MU7Q5nTL8kCad+kPNRVqVs309I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DXOykP/1/wC8kEoY5D3ilLFg6E0Txyib
	I2EBe2HjV7A1AHl0wkJ7XlRczRoZTLot/pLp0696SXbMOStAW7rERi+nJ+/o7mYW
	cmmsQiD3Tu69zo1YPEq6EArNeAEZTJpRCEbKkM8o+zXj5XflVV2aI0eDcVRfEEfd
	5nWjBL98GAc=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id BE9E77F05B;
	Tue, 20 Oct 2009 14:47:07 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 17D397F059; Tue, 20 Oct 2009
 14:46:56 -0400 (EDT)
In-Reply-To: <vpq1vkygtx6.fsf@bauges.imag.fr> (Matthieu Moy's message of
 "Tue\, 20 Oct 2009 13\:56\:53 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F796EF5E-BDA8-11DE-AB56-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130824>

Linus and other git developers from the early days trained their fingers
to type the command, every once in a while even without thinking, to check
the consistency of the repository back when the lower core part of the git
was still being developed.  Developers who wanted to make sure that git
correctly dealt with packfiles could deliberately trigger their creation
and checked them after they were created carefully, but loose objects are
the ones that are written by various commands from random codepaths.  It
made some technical sense to have a mode that checked only loose objects
from the debugging point of view for that reason.

Even for git developers, there no longer is any reason to type "git fsck"
every five minutes these days, worried that some newly created objects
might be corrupt due to recent change to git.

The reason we did not make "--full" the default is probably we trust our
filesystems a bit too much.  At least, we trusted filesystems more than we
trusted the lower core part of git that was under development.

Once a packfile is created and we always use it read-only, there didn't
seem to be much point in suspecting that the underlying filesystems or
disks may corrupt them in such a way that is not caught by the SHA-1
checksum over the entire packfile and per object checksum.  That trust in
the filesystems might have been a good tradeoff between fsck performance
and reliability on platforms git was initially developed on and for, but
it may not be true anymore as we run on many more platforms these days.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> ...
>> On Tue, 20 Oct 2009, Alex Riesen wrote:
>> ...
>>> --no-full works
>>
>> It works.  Technically.  For human users, though, --loose-objects-only 
>> (with a shortcut "--loose") would be better.
>
> OTOH, the advantage of "--no-full" is that it's compatible with
> existing Git versions. If I learn Git 1.6.6 with --no-full, and use it
> in a script, then my stript works also with older Gits.
>
> But anyway, I think very few people are actually interested in "git
> --no-full" (or call it whatever you like), so I don't think this is
> very important.

For human users, I think --full vs --no-full is quite a nice suggestion,
given that we already have advertised --full and people know the option.

Also people know that splicing "no-" after the double dash is often the
way to negate a boolean-looking option.

The actual patch to do this is tiny, but that is just a bonus ;-)

 Documentation/RelNotes-1.6.6.txt |   10 ++++++++++
 Documentation/git-fsck.txt       |    5 +++--
 builtin-fsck.c                   |    2 +-
 3 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/Documentation/RelNotes-1.6.6.txt b/Documentation/RelNotes-1.6.6.txt
index 5f1fecb..1896e05 100644
--- a/Documentation/RelNotes-1.6.6.txt
+++ b/Documentation/RelNotes-1.6.6.txt
@@ -1,6 +1,13 @@
 GIT v1.6.6 Release Notes
 ========================
 
+In this release, "git fsck" defaults to "git fsck --full" and checks
+packfiles.  If you prefer a quicker check only on loose objects (the
+old default), you can say "git fsck --no-full".  This has been
+supported by 1.5.4 and newer versions of git, so it is safe to write
+it in your script if you use slightly older git on some of your
+machines.
+
 In git 1.7.0, which is planned to be the release after 1.6.6, "git
 push" into a branch that is currently checked out will be refused by
 default.
@@ -38,6 +45,9 @@ Updates since v1.6.5
 
 (usability, bells and whistles)
 
+ * "git fsck" by default checks the packfiles (i.e. "--full" is the
+   default); you can turn it off with "git fsck --no-full".
+
  * "git log --decorate" shows the location of HEAD as well.
 
 (developers)
diff --git a/Documentation/git-fsck.txt b/Documentation/git-fsck.txt
index 287c4fc..6fe9484 100644
--- a/Documentation/git-fsck.txt
+++ b/Documentation/git-fsck.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git fsck' [--tags] [--root] [--unreachable] [--cache] [--no-reflogs]
-	 [--full] [--strict] [--verbose] [--lost-found] [<object>*]
+	 [--[no-]full] [--strict] [--verbose] [--lost-found] [<object>*]
 
 DESCRIPTION
 -----------
@@ -52,7 +52,8 @@ index file, all SHA1 references in .git/refs/*, and all reflogs (unless
 	or $GIT_DIR/objects/info/alternates,
 	and in packed git archives found in $GIT_DIR/objects/pack
 	and corresponding pack subdirectories in alternate
-	object pools.
+	object pools.  This is now default; you can turn it off
+	with --no-full.
 
 --strict::
 	Enable more strict checking, namely to catch a file mode
diff --git a/builtin-fsck.c b/builtin-fsck.c
index c58b0e3..2d88e45 100644
--- a/builtin-fsck.c
+++ b/builtin-fsck.c
@@ -19,7 +19,7 @@ static int show_root;
 static int show_tags;
 static int show_unreachable;
 static int include_reflogs = 1;
-static int check_full;
+static int check_full = 1;
 static int check_strict;
 static int keep_cache_objects;
 static unsigned char head_sha1[20];
