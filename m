From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Remove .git auto detection from setup_git_env()
Date: Fri, 05 Feb 2010 09:22:08 -0800
Message-ID: <7vy6j7a98f.fsf@alter.siamese.dyndns.org>
References: <1265370468-6147-1-git-send-email-pclouds@gmail.com>
 <20100205151239.GC14116@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org,
	=?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 05 18:22:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdRsx-0005Uf-96
	for gcvg-git-2@lo.gmane.org; Fri, 05 Feb 2010 18:22:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757092Ab0BERWW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Feb 2010 12:22:22 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:51320 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756268Ab0BERWV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Feb 2010 12:22:21 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1E2F1977F0;
	Fri,  5 Feb 2010 12:22:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=TyXAWXkNRQfx
	eN4IEl7cPTa0Gd8=; b=kGrPs22WzwAvhh7lJuKPZAI8cVwWFXRlwAOxyMPbkgSl
	xR+w8c+yRpQ/ZhaP3bsTpKGMEgAbFDeY18Q36kmWz1NFEybWwOSxjJciYAK2yAEk
	Tkd1nJwle6qkolpcM/WiviPxypBtY7pap7lHaH+IWhF3lCo3UckykwmCzWi57M8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=W9Ur3T
	Eq7zwF1YDttkUBxfpxLd26ydFBYF+PqV+mN8+fVeGw1lqUklRk44XulhWGJH2teO
	CfLsXO+37LPT7/4B/XR1YMGhvrXez8+3dUUxVppL2bJZE3ZUXSWonSpfK87mdJkC
	Eot0ycDqrC6Bp/WKiMwxYfRlyB7BGgtL/TE+M=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D0702977EE;
	Fri,  5 Feb 2010 12:22:15 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9B94B977EC; Fri,  5 Feb
 2010 12:22:10 -0500 (EST)
In-Reply-To: <20100205151239.GC14116@coredump.intra.peff.net> (Jeff King's
 message of "Fri\, 5 Feb 2010 10\:12\:40 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0167171C-127B-11DF-BFCC-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139061>

Jeff King <peff@peff.net> writes:

> It has been a while since I looked at this code, but I think this is =
a
> good direction forward. I remember trying something like this and
> getting discouraged at all of the ensuing breakage. So if you can tra=
ck
> down all of the fallouts and fix them, I think we will be better off =
in
> the long run.

I agree.

This topic started from "We broke 'git grep' in .git directory" and I
think it is the sanest to revert 3081623 (grep --no-index: allow use of
"git grep" outside a git repository, 2010-01-15) which nobody has used =
so
far in any released version of git, until we sort this out at least.

Every time we touch work-tree related codepath (like Ren=C3=A9's patch =
does) we
seem to inadvertently break something else.  It's too late for that kin=
d
of fixes for this cycle and "grep  --no-index" should go.

-- >8 --
Subject: [PATCH] Revert 308162372d0aa202ff45743e02253e20a4fac4d7

It seems that we have bad interaction with the code related to
GIT_WORK_TREE and "grep --no-index", and broke running grep inside
the .git directory.  For now, just revert it and resurrect it after
1.7.0 ships.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/RelNotes-1.7.0.txt |    3 --
 builtin-grep.c                   |   33 ------------------------
 t/t7002-grep.sh                  |   52 ------------------------------=
--------
 3 files changed, 0 insertions(+), 88 deletions(-)

diff --git a/Documentation/RelNotes-1.7.0.txt b/Documentation/RelNotes-=
1.7.0.txt
index 255666f..f632662 100644
--- a/Documentation/RelNotes-1.7.0.txt
+++ b/Documentation/RelNotes-1.7.0.txt
@@ -133,9 +133,6 @@ Updates since v1.6.6
  * "git grep" does not rely on external grep anymore.  It can use more=
 than
    one threads to accelerate the operation.
=20
- * "git grep" learned "--no-index" option, to search inside contents t=
hat
-   are not managed by git.
-
  * "git grep" learned "--quiet" option.
=20
  * "git log" and friends learned "--glob=3Dheads/*" syntax that is a m=
ore
diff --git a/builtin-grep.c b/builtin-grep.c
index 0ef849c..bff1e68 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -14,7 +14,6 @@
 #include "userdiff.h"
 #include "grep.h"
 #include "quote.h"
-#include "dir.h"
=20
 #ifndef NO_PTHREADS
 #include "thread-utils.h"
@@ -646,24 +645,6 @@ static int grep_object(struct grep_opt *opt, const=
 char **paths,
 	die("unable to grep from object of type %s", typename(obj->type));
 }
=20
-static int grep_directory(struct grep_opt *opt, const char **paths)
-{
-	struct dir_struct dir;
-	int i, hit =3D 0;
-
-	memset(&dir, 0, sizeof(dir));
-	setup_standard_excludes(&dir);
-
-	fill_directory(&dir, paths);
-	for (i =3D 0; i < dir.nr; i++) {
-		hit |=3D grep_file(opt, dir.entries[i]->name);
-		if (hit && opt->status_only)
-			break;
-	}
-	free_grep_patterns(opt);
-	return hit;
-}
-
 static int context_callback(const struct option *opt, const char *arg,
 			    int unset)
 {
@@ -762,8 +743,6 @@ int cmd_grep(int argc, const char **argv, const cha=
r *prefix)
 	struct option options[] =3D {
 		OPT_BOOLEAN(0, "cached", &cached,
 			"search in index instead of in the work tree"),
-		OPT_BOOLEAN(0, "index", &use_index,
-			"--no-index finds in contents not managed by git"),
 		OPT_GROUP(""),
 		OPT_BOOLEAN('v', "invert-match", &opt.invert,
 			"show non-matching lines"),
@@ -950,18 +929,6 @@ int cmd_grep(int argc, const char **argv, const ch=
ar *prefix)
 		paths[1] =3D NULL;
 	}
=20
-	if (!use_index) {
-		int hit;
-		if (cached)
-			die("--cached cannot be used with --no-index.");
-		if (list.nr)
-			die("--no-index cannot be used with revs.");
-		hit =3D grep_directory(&opt, paths);
-		if (use_threads)
-			hit |=3D wait_all();
-		return !hit;
-	}
-
 	if (!list.nr) {
 		int hit;
 		if (!cached)
diff --git a/t/t7002-grep.sh b/t/t7002-grep.sh
index bf4d4dc..7144f81 100755
--- a/t/t7002-grep.sh
+++ b/t/t7002-grep.sh
@@ -434,56 +434,4 @@ test_expect_success 'grep -Fi' '
 	test_cmp expected actual
 '
=20
-test_expect_success 'outside of git repository' '
-	rm -fr non &&
-	mkdir -p non/git/sub &&
-	echo hello >non/git/file1 &&
-	echo world >non/git/sub/file2 &&
-	echo ".*o*" >non/git/.gitignore &&
-	{
-		echo file1:hello &&
-		echo sub/file2:world
-	} >non/expect.full &&
-	echo file2:world >non/expect.sub
-	(
-		GIT_CEILING_DIRECTORIES=3D"$(pwd)/non/git" &&
-		export GIT_CEILING_DIRECTORIES &&
-		cd non/git &&
-		test_must_fail git grep o &&
-		git grep --no-index o >../actual.full &&
-		test_cmp ../expect.full ../actual.full
-		cd sub &&
-		test_must_fail git grep o &&
-		git grep --no-index o >../../actual.sub &&
-		test_cmp ../../expect.sub ../../actual.sub
-	)
-'
-
-test_expect_success 'inside git repository but with --no-index' '
-	rm -fr is &&
-	mkdir -p is/git/sub &&
-	echo hello >is/git/file1 &&
-	echo world >is/git/sub/file2 &&
-	echo ".*o*" >is/git/.gitignore &&
-	{
-		echo file1:hello &&
-		echo sub/file2:world
-	} >is/expect.full &&
-	: >is/expect.empty &&
-	echo file2:world >is/expect.sub
-	(
-		cd is/git &&
-		git init &&
-		test_must_fail git grep o >../actual.full &&
-		test_cmp ../expect.empty ../actual.full &&
-		git grep --no-index o >../actual.full &&
-		test_cmp ../expect.full ../actual.full &&
-		cd sub &&
-		test_must_fail git grep o >../../actual.sub &&
-		test_cmp ../../expect.empty ../../actual.sub &&
-		git grep --no-index o >../../actual.sub &&
-		test_cmp ../../expect.sub ../../actual.sub
-	)
-'
-
 test_done
--=20
1.7.0.rc1.204.gb96e5
