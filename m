From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] rebase -i: Export GIT_AUTHOR_* variables explicitly
Date: Fri, 22 Jan 2010 13:09:24 -0800
Message-ID: <7viqatu9rv.fsf@alter.siamese.dyndns.org>
References: <cover.1264151435.git.mhagger@alum.mit.edu>
 <c6efda03848abc00cf8bf8d84fc34ef0d652b64c.1264151435.git.mhagger@alum.mit.edu> <alpine.DEB.1.00.1001221212350.4985@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	gitster@pobox.com, tarmigan+git@gmail.com, j.sixt@viscovery.net
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jan 22 22:09:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYQlJ-00055g-MV
	for gcvg-git-2@lo.gmane.org; Fri, 22 Jan 2010 22:09:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754330Ab0AVVJo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jan 2010 16:09:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754303Ab0AVVJo
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jan 2010 16:09:44 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:49398 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754272Ab0AVVJn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jan 2010 16:09:43 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 38FA793EA3;
	Fri, 22 Jan 2010 16:09:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oWeHnfdmf0xg7uyMMuhTYF96134=; b=L4JCVC
	/r7cYgy1BqfhJNrU7Ul7kIDG9JSb7fDy+to9PJFCsYka0eKt7wrUZoL9y4OzYS1b
	CyorAR5ClPz6Nb1aqkKPEaCzkUAHPaocKavn+B2hIIx/QKW1dENlGdF0SHYv2Qhq
	O57AEiLEP38rwzN8Yawg/QTJ4gTw5+wcMqk/0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ELeoWot6GdBdhSe52dMYJNICVNv/ztKp
	m+T3RjrjvA5nEqCQ/LoJJTMuUBwuxnLKNufkIHsAAChQV8fzxFpkbsmfZD5Njq5T
	Wb6sMyuWl33wX8K70u0vXzgVGIuXAYtRcSHHdoVgsL5LY3uJ/10B78eHYADlAtdn
	uQI5dxsMLIM=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D9FB693E9D;
	Fri, 22 Jan 2010 16:09:33 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9E32D93E9B; Fri, 22 Jan
 2010 16:09:26 -0500 (EST)
In-Reply-To: <alpine.DEB.1.00.1001221212350.4985@pacific.mpi-cbg.de>
 (Johannes Schindelin's message of "Fri\, 22 Jan 2010 12\:16\:16 +0100
 \(CET\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 70869A64-079A-11DF-9D81-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137782>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Fri, 22 Jan 2010, Michael Haggerty wrote:
>
>> As pointed out on the mailing list, one-shot shell variable exports do
>> not necessarily work with shell functions.  So export the GIT_AUTHOR_*
>> variables explicitly using "export".
>
> This one's a bit hairy; I really was not sure about unintended side 
> effects, that is why I avoided the export.
> ... (sensible worries omitted) ...

My reading of "git grep -C3 AUTHOR git-rebase--interactive.sh" is that
GIT_AUTHOR_NAME/EMAIL/DATE are set by:
 
   - redoing a merge (while preserving history) by reading from the merge;

   - squashing/fixing into the last one (relying on the last one did the
     right thing) by reading from the HEAD; or

   - sourcing AUTHOR_SCRIPT upon --continue, reading from the file left
     by make_patch immediately before the previous invocation gave control
     back to the user (e.g. "e"dit, or conflict).

The places we want to see these variables in effect are while doing one of
the above three places, and they all do this with do_with_author.

Nothing that is called with do_with_author has a side effect of setting
shell variables for the caller of do_with_author.

So I tend to think this patch would be the cleanest and safest
alternative, albeit it may cost an extra fork.

What do you think?

-- >8 --
Subject: rebase -i: Export GIT_AUTHOR_* variables explicitly

There is no point doing self-assignments of these variables.  Instead,
just export them to the environment, but do so in a sub-shell, because

	VAR1=VAL1 VAR2=VAL2 ... command arg1 arg2...

does not mark the variables exported if command that is run
is a shell function, according to POSIX.1.

The callers of do_with_author do not rely on seeing the effect of any
shell variable assignments that may happen inside what was called through
this shell function (currently "output" is the only one), so running it in
the subshell doesn't have an adverse semantic effect.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-rebase--interactive.sh |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index c2f6089..9187e9b 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -215,10 +215,10 @@ has_action () {
 # Run command with GIT_AUTHOR_NAME, GIT_AUTHOR_EMAIL, and
 # GIT_AUTHOR_DATE exported from the current environment.
 do_with_author () {
-	GIT_AUTHOR_NAME="$GIT_AUTHOR_NAME" \
-	GIT_AUTHOR_EMAIL="$GIT_AUTHOR_EMAIL" \
-	GIT_AUTHOR_DATE="$GIT_AUTHOR_DATE" \
-	"$@"
+	(
+		export GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL GIT_AUTHOR_DATE
+		"$@"
+	)
 }
 
 pick_one () {
