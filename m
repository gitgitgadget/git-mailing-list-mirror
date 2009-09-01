From: Junio C Hamano <gitster@pobox.com>
Subject: stash --dwim safety (was Re: What's cooking in git.git (Aug 2009,
 #06; Sun, 30))
Date: Mon, 31 Aug 2009 22:58:08 -0700
Message-ID: <7v3a77dx5b.fsf@alter.siamese.dyndns.org>
References: <7viqg48nxi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 01 07:58:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MiMOI-0002Ly-Rq
	for gcvg-git-2@lo.gmane.org; Tue, 01 Sep 2009 07:58:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751850AbZIAF6U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Sep 2009 01:58:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751367AbZIAF6U
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Sep 2009 01:58:20 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:39588 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751710AbZIAF6T (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Sep 2009 01:58:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 283813F1A5;
	Tue,  1 Sep 2009 01:58:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FLD6LzYiZmB1jTosQqRjANygjfs=; b=A3Zsba
	Cm0coQBbZ0zkX4udD8JnPEShym/uKJuAVYuTTYrP1IOqGJwRiquo5IPa/9yYPC68
	A24LK4no2tY11B/EnoIO81O3FW5QIjyhA7pChTh4rwxDFjHBLady/PR6Y6xKfY4d
	0e5PAAkk8CRbJbpQ5DoH7HWl9IeSfOgT7euJw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fvY5PeM19CIpJlIwpzRwxbi12N8/Icku
	S8UAJ7kglgjfMdvhSiRC4xT05+tNHuy11xV55N6ZBS7CAMLqbcLrjRRj5P+Kg8GW
	WWP9nAT8owzx48qSVr7CSkf3ZORj2U2tTGKusxpe91u225bDVnxtfooMucywc1Fv
	/M3KSrQTB50=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 02DB93F1A4;
	Tue,  1 Sep 2009 01:58:18 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 89A893F1A3; Tue,  1 Sep 2009
 01:58:10 -0400 (EDT)
In-Reply-To: <7viqg48nxi.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon\, 31 Aug 2009 00\:03\:53 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 72AA0A96-96BC-11DE-8AE6-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127522>

Junio C Hamano <gitster@pobox.com> writes:

> [Stalled]
>
> * js/stash-dwim (2009-07-27) 1 commit.
> * tr/reset-checkout-patch (2009-08-27) 9 commits.
>
> There was a discussion on better DWIMmery for the above two topics to (1)
> forbid "git stash save --anything-with-dash" and (2) redirect with any
> option "git stash --opt" to "git stash save --opt", to keep it flexible
> and safe at the same time.  I think it is a sane thing to do, but nothing
> has happened lately.

Actually, I was at fault giving up on Matthieu's patch without studying it
after seeing the phrase "this series replaces", when the two topics the
series tried to replace were already in 'next'.

It turns out that the rework was simple enough, so I did it myself.  Among
his 3 patch series, an equivalent to the first one ("save -keep" can be
written as "save -k" for brevity) were already in, and the second one
(default to "save" if we see any option before command word) was unsafe
without the third one (reject unknown option to "save"), so it ended up as
a single patch that is a combination of the latter two patches.

This applies on top of tr/reset-checkout-patch branch, 14c674e (Make test
case number unique, 2009-08-27).

-- >8 --
From: Matthieu Moy <Matthieu.Moy@imag.fr>
Date: Tue, 18 Aug 2009 23:38:40 +0200
Subject: [PATCH] stash: simplify defaulting to "save" and reject unknown options

With the earlier DWIM patches, certain combination of options defaulted
to the "save" command correctly while certain equally valid combination
did not.  For example, "git stash -k" were Ok but "git stash -q -k" did
not work.

This makes the logic of defaulting to "save" much simpler. If the first
argument begins with a '-', it is clear that there is no command word,
and we default to "save" subcommand.

This also teaches "git stash save" to reject an unknown option.  This is
to keep a mistyped "git stash save --quite" from creating a stash with a
message "--quite", and this safety is more important with the new logic
to default to "save" with any option-looking argument without an explicit
comand word.

[jc: this is based on Matthieu's 3-patch series, and he takes all the
credit; if I have introduced bugs while reworking they are mine]

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
Signed-off-by: Junio C Hamano <gitster@pobox.com>

---
 Documentation/git-stash.txt |    1 -
 git-stash.sh                |   22 ++++++++++++++++++----
 t/t3903-stash.sh            |   11 +++++++++++
 3 files changed, 29 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index 1c4ed41..5d4cce3 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -14,7 +14,6 @@ SYNOPSIS
 'git stash' ( pop | apply ) [--index] [-q|--quiet] [<stash>]
 'git stash' branch <branchname> [<stash>]
 'git stash' [save [--patch] [-k|--[no-]keep-index] [-q|--quiet] [<message>]]
-'git stash' [-p|--patch|-k|--keep-index]
 'git stash' clear
 'git stash' create
 
diff --git a/git-stash.sh b/git-stash.sh
index 9fd7289..ff71507 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -8,7 +8,6 @@ USAGE="list [<options>]
    or: $dashless ( pop | apply ) [--index] [-q|--quiet] [<stash>]
    or: $dashless branch <branchname> [<stash>]
    or: $dashless [save [-k|--keep-index] [-q|--quiet] [<message>]]
-   or: $dashless [-k|--keep-index]
    or: $dashless clear"
 
 SUBDIRECTORY_OK=Yes
@@ -146,6 +145,14 @@ save_stash () {
 		-q|--quiet)
 			GIT_QUIET=t
 			;;
+		--)
+			shift
+			break
+			;;
+		-*)
+			echo "error: unknown option for 'stash save': $1"
+			usage
+			;;
 		*)
 			break
 			;;
@@ -355,6 +362,13 @@ apply_to_branch () {
 	drop_stash $stash
 }
 
+# The default command is "save"
+case "$1" in
+-*)
+	set "save" "$@"
+	;;
+esac
+
 # Main command set
 case "$1" in
 list)
@@ -406,9 +420,9 @@ branch)
 	apply_to_branch "$@"
 	;;
 *)
-	case $#,"$1","$2" in
-	0,,|1,-k,|1,--keep-index,|1,-p,|1,--patch,|2,-p,--no-keep-index|2,--patch,--no-keep-index)
-		save_stash "$@" &&
+	case $# in
+	0)
+		save_stash &&
 		say '(To restore them type "git stash apply")'
 		;;
 	*)
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index e16ad93..5514f74 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -208,4 +208,15 @@ test_expect_success 'stash -k' '
 	test bar,bar4 = $(cat file),$(cat file2)
 '
 
+test_expect_success 'stash --invalid-option' '
+	echo bar5 > file &&
+	echo bar6 > file2 &&
+	git add file2 &&
+	test_must_fail git stash --invalid-option &&
+	test_must_fail git stash save --invalid-option &&
+	test bar5,bar6 = $(cat file),$(cat file2) &&
+	git stash -- -message-starting-with-dash &&
+	test bar,bar2 = $(cat file),$(cat file2)
+'
+
 test_done
-- 
1.6.4.2.295.g9bcb
