From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] rebase: avoid non-function use of "return" on FreeBSD
Date: Thu, 17 Apr 2014 10:15:19 -0700
Message-ID: <xmqq4n1rg9nc.fsf@gitster.dls.corp.google.com>
References: <438458da797bcab97449bfa931a9d1d@74d39fa044aa309eaea14b9f57fe79c>
	<0779303f7d2257a618b5bed00260a8a@74d39fa044aa309eaea14b9f57fe79c>
	<xmqqob03le3v.fsf@gitster.dls.corp.google.com>
	<FAD02895-24B2-46C3-ABEF-E9CE17926FF9@gmail.com>
	<xmqqsipdi5lw.fsf@gitster.dls.corp.google.com>
	<xmqqtx9tgn5l.fsf@gitster.dls.corp.google.com>
	<F88F585D-B146-4CD2-A7E9-D3CB2C5B25A4@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 17 19:16:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WapvG-0006jA-1U
	for gcvg-git-2@plane.gmane.org; Thu, 17 Apr 2014 19:16:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751176AbaDQRQW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Apr 2014 13:16:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50758 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751101AbaDQRQU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Apr 2014 13:16:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BD26F75B30;
	Thu, 17 Apr 2014 13:16:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VUS0vjs/7tc7zxpjanK6vnFFlA0=; b=NM0p1w
	dBrq7i2JfQ6Js99zOGzmv0+VKC0+5orJLPHSvnSIZ553ZrwDBWnmdzUt645wrWpN
	jarDEKlQTt2GZ4YenZ/vjyHaFYFB+Tmk/Hf0MLXfdyx9WJGrq0OlD/SYk5DEQnbQ
	+IFOTJDSsm7wtnM9E8EJoQ5KQwFqF8K5m4jM8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SODJYfuFs38+mAVHueNJa9wtD5ZxID6E
	dgK6+d46gdrJUEJ6Dq+mhIM0gCjgNahn2EIdMACrjQCJnU7RCdSFyIu1pnjhj5mX
	5fqkU9hrJcwzBrfbVwgwubzyIKkxX+vZoKEnpt9goEhYpHcF0e/dr/V0WyluvzNo
	UYFP7aqfCnc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A731675B2F;
	Thu, 17 Apr 2014 13:16:19 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CB6BC75AD4;
	Thu, 17 Apr 2014 13:15:21 -0400 (EDT)
In-Reply-To: <F88F585D-B146-4CD2-A7E9-D3CB2C5B25A4@gmail.com> (Kyle J. McKay's
	message of "Wed, 16 Apr 2014 17:41:51 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: DB8816C2-C653-11E3-9CEE-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246425>

"Kyle J. McKay" <mackyle@gmail.com> writes:

> Either "return to the function that dot-sourced us" or "return from
> the dot command that dot-sourced us",

> but using the original wording
> implies to me that the function that dot-sourced us will return as
> soon as the dot-sourced script executes the return and that is exactly
> one of the bugs we're working around.

True. "return to the function that dot-sourced us" is what I meant.
To be more pedantic, "return to the point in the function that
dot-sourced this file".

> I think just the s/from/to/ would fix it so it does not give me the
> wrong impression, but that doesn't mean that would not confuse
> everyone else.  ;)

Yeah, let's do that.  Thanks for carefully reading them.

>> So "while this is allowed by POSIX" may be a bit misleading and
>> needs to be reworded, I guess?
>
> "allowed by POSIX" is not incorrect. ;)

Calling something that is required as "allowed" is a bit misleading,
if not outright dishonest.  Allowed implies that you are free not to
do so and can still be in compliance, but I do not think that is the
case.

I'd think it makes it clearer to say that we take "return stopping
the dot-sourced file" as a given and FreeBSD does not behave that
way.

-- >8 --
From: "Kyle J. McKay" <mackyle@gmail.com>
Date: Fri, 11 Apr 2014 01:28:17 -0700
Subject: [PATCH] rebase: avoid non-function use of "return" on FreeBSD

Since a1549e10, 15d4bf2e and 01a1e646 (first appearing in v1.8.4)
the git-rebase--*.sh scripts have used a "return" to stop execution
of the dot-sourced file and return to the "dot" command that
dot-sourced it.  The /bin/sh utility on FreeBSD however behaves
poorly under some circumstances when such a "return" is executed.

In particular, if the "dot" command is contained within a function,
then when a "return" is executed by the script it runs (that is not
itself inside a function), control will return from the function
that contains the "dot" command skipping any statements that might
follow the dot command inside that function.  Commit 99855ddf (first
appearing in v1.8.4.1) addresses this by making the "dot" command
the last line in the function.

Unfortunately the FreeBSD /bin/sh may also execute some statements
in the script run by the "dot" command that appear after the
troublesome "return".  The fix in 99855ddf does not address this
problem.

For example, if you have script1.sh with these contents:

run_script2() {
        . "$(dirname -- "$0")/script2.sh"
        _e=$?
        echo only this line should show
        [ $_e -eq 5 ] || echo expected status 5 got $_e
        return 3
}
run_script2
e=$?
[ $e -eq 3 ] || { echo expected status 3 got $e; exit 1; }

And script2.sh with these contents:

if [ 5 -gt 3 ]; then
        return 5
fi
case bad in *)
        echo always shows
esac
echo should not get here
! :

When running script1.sh (e.g. '/bin/sh script1.sh' or './script1.sh'
after making it executable), the expected output from a POSIX shell
is simply the single line:

only this line should show

However, when run using FreeBSD's /bin/sh, the following output
appears instead:

should not get here
expected status 3 got 1

Not only did the lines following the "dot" command in the run_script2
function in script1.sh get skipped, but additional lines in script2.sh
following the "return" got executed -- but not all of them (e.g. the
"echo always shows" line did not run).

These issues can be avoided by not using a top-level "return" in
script2.sh.  If script2.sh is changed to this:

main() {
        if [ 5 -gt 3 ]; then
                return 5
        fi
        case bad in *)
                echo always shows
        esac
        echo should not get here
        ! :
}
main

Then it behaves the same when using FreeBSD's /bin/sh as when using
other more POSIX compliant /bin/sh implementations.

We fix the git-rebase--*.sh scripts in a similar fashion by moving
the top-level code that contains "return" statements into its own
function and then calling that as the last line in the script.

Signed-off-by: Kyle J. McKay <mackyle@gmail.com>
Acked-by: Matthieu Moy <Matthieu.Moy@imag.fr>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-rebase--am.sh          | 15 +++++++++++++++
 git-rebase--interactive.sh | 15 +++++++++++++++
 git-rebase--merge.sh       | 15 +++++++++++++++
 3 files changed, 45 insertions(+)

diff --git a/git-rebase--am.sh b/git-rebase--am.sh
index a4f683a..1cdc139 100644
--- a/git-rebase--am.sh
+++ b/git-rebase--am.sh
@@ -4,6 +4,17 @@
 # Copyright (c) 2010 Junio C Hamano.
 #
 
+# The whole contents of this file is run by dot-sourcing it from
+# inside a shell function.  It used to be that "return"s we see
+# below were not inside any function, and expected to return
+# to the function that dot-sourced us.
+#
+# However, FreeBSD /bin/sh misbehaves on such a construct and
+# continues to run the statements that follow such a "return".
+# As a work-around, we introduce an extra layer of a function
+# here, and immediately call it after defining it.
+git_rebase__am () {
+
 case "$action" in
 continue)
 	git am --resolved --resolvemsg="$resolvemsg" &&
@@ -73,3 +84,7 @@ then
 fi
 
 move_to_original_branch
+
+}
+# ... and then we call the whole thing.
+git_rebase__am
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 43631b4..9e1dd1e 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -810,6 +810,17 @@ add_exec_commands () {
 	mv "$1.new" "$1"
 }
 
+# The whole contents of this file is run by dot-sourcing it from
+# inside a shell function.  It used to be that "return"s we see
+# below were not inside any function, and expected to return
+# to the function that dot-sourced us.
+#
+# However, FreeBSD /bin/sh misbehaves on such a construct and
+# continues to run the statements that follow such a "return".
+# As a work-around, we introduce an extra layer of a function
+# here, and immediately call it after defining it.
+git_rebase__interactive () {
+
 case "$action" in
 continue)
 	# do we have anything to commit?
@@ -1042,3 +1053,7 @@ GIT_REFLOG_ACTION="$GIT_REFLOG_ACTION: checkout $onto_name"
 output git checkout $onto || die_abort "could not detach HEAD"
 git update-ref ORIG_HEAD $orig_head
 do_rest
+
+}
+# ... and then we call the whole thing.
+git_rebase__interactive
diff --git a/git-rebase--merge.sh b/git-rebase--merge.sh
index e7d96de..838fbed 100644
--- a/git-rebase--merge.sh
+++ b/git-rebase--merge.sh
@@ -101,6 +101,17 @@ finish_rb_merge () {
 	say All done.
 }
 
+# The whole contents of this file is run by dot-sourcing it from
+# inside a shell function.  It used to be that "return"s we see
+# below were not inside any function, and expected to return
+# to the function that dot-sourced us.
+#
+# However, FreeBSD /bin/sh misbehaves on such a construct and
+# continues to run the statements that follow such a "return".
+# As a work-around, we introduce an extra layer of a function
+# here, and immediately call it after defining it.
+git_rebase__merge () {
+
 case "$action" in
 continue)
 	read_state
@@ -151,3 +162,7 @@ do
 done
 
 finish_rb_merge
+
+}
+# ... and then we call the whole thing.
+git_rebase__merge
-- 
1.9.2-630-gc3ddd0c
