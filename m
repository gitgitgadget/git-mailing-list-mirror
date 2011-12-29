From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Submodules always use a relative path to gitdir
Date: Thu, 29 Dec 2011 14:40:32 -0800
Message-ID: <7vsjk3vw67.fsf@alter.siamese.dyndns.org>
References: <1325192426-10103-1-git-send-email-antony.male@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, iveqy@iveqy.com
To: Antony Male <antony.male@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 29 23:40:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RgOeQ-0006Rg-I7
	for gcvg-git-2@lo.gmane.org; Thu, 29 Dec 2011 23:40:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754784Ab1L2Wkh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Dec 2011 17:40:37 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36029 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754714Ab1L2Wkg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Dec 2011 17:40:36 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 02BA77F1E;
	Thu, 29 Dec 2011 17:40:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vyr/l/1TQCg3h1Dk632u6qkEaB4=; b=Xpica5
	i1squAQzQZVy0ymPjl4b+dN72CU3y2Trtgfs+OchF28juqDN2Um3svtBZP39bMJR
	Uv0CH6wOA3EjcE1LmLXitB7Oqgj/u9tpP+A8I+1v+odgWvREtbxXMh252egO1gua
	8lnEZ/Ia0Yg8gZvsMMTYab66o+oS+N+YX6cLE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RnzDozJMuNR3WHDpyFuP9z2UOctoX9gu
	NJew+wCVgDmxbke9rebp5h9NREks+pjAMkSsdE2M6KQInm0ka71rYwySg8lQkF2f
	gL9f2nieg+Ex5j3ieOFJScUKsLOdlmTffGylVXo4Jg6OmzVLsZh6geUnxjK1aHOq
	SPuv7p9E14Q=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EE0F47F1D;
	Thu, 29 Dec 2011 17:40:34 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 49B457F1C; Thu, 29 Dec 2011
 17:40:34 -0500 (EST)
In-Reply-To: <1325192426-10103-1-git-send-email-antony.male@gmail.com>
 (Antony Male's message of "Thu, 29 Dec 2011 21:00:26 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1ED8A5BC-326E-11E1-A0D3-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187786>

Antony Male <antony.male@gmail.com> writes:

> Git submoule clone uses git clone --separate-git-dir to checkout a
> submodule's git repository into <supermodule>/.git/modules,...

This is misleading. The <superproject>/.git/modules/<name> is the location
of the $GIT_DIR for the submodule <name>, not the location of its checkout
at <superproject>/<path> that is outside <superproject>/.git/modules/
hierarchy.

> folder does not already exist. git clone --separate-git-dir was
> designed for a scenario where the git repository stays in one location
> and the working copy can be moved.

Are you sure about this "clone's design"? It sounds like a revisionist
history.

Saying something like "it would be nicer if it also let us use in this new
different scenario" in the proposed commit log message is perfectly fine,
but my understanding is that the --separate-git-dir option and "gitdir: "
support were designed to allow having the $GIT_DIR in a different place
from the working tree that has ".git" in it, nothing more, nothing less. I
do not think we meant to support moving either directory after they are
set up. If you want to move either, you would need to (and you can, like
your patch does) tweak "gitdir:" to adjust.

By-the-way-Nit. We do not use any folders. s/folder/directory/.

> In the submodules scenario, neither the git repository nor the working
> copy will be moved relative to each other. However, the supermodule may
> be moved,...

Again, who said that you are allowed to move the superproject directory in
the first place? I would understand that it might be nicer if it could be
moved but I haven't thought this through thoroughly yet---there may be
other side effects from doing so, other than the relativeness of "gitdir".

> Previously, if git submodule clone was called when the submodule's git
> repository already existed in <supermodule>/.git/modules, it would
> simply re-create the submodule's .git file, using a relative path.

... "to point at the existing <superproject>/.git/modules/<name>".

Overall, I think I can agree with the goal, but the tone of the proposed
commit log message rubs the reader in a wrong way to see clearly what this
patch is proposing to do and where its merit lies. It is probably not a
big deal, and perhaps it may be just the order of explanation.

I would probably explain the goal like this if I were doing this patch,
without triggering any need for revisionist history bias.

    Recent versions of "git submodule" maintain the submodule <name> at
    <path> in the superproject using a "separate git-dir" mechanism. The
    repository data for the submodule is stored in ".git/modules/<name>/"
    directory of the superproject, and its working tree is created at
    "<path>/" directory, with "<path>/.git" file pointing at the
    ".git/modules/<name>/" directory.

    This is so that we can check out an older version of the superproject
    that does not yet have the submodule <name> anywhere without losing
    (and later having to re-clone) the submodule repository. Removing
    "<path>" won't lose ".git/modules/<name>", and a different branch that
    has the submodule at different location in the superproject, say
    "<path2>", can create "<path2>/" and ".git" in it to point at the same
    ".git/modules/<name>".

    When instantiating such a submodule, if ".git/modules/<name>/" does
    not exist in the superproject, the submodule repository needs to be
    cloned there first. Then we only need to create "<path>" directory,
    point ".git/modules/<name>/" in the superproject with "<path>/.git",
    and check out the working tree.

    However, the current code is not structured that way. The codepath to
    deal with newly cloned submodules uses "git clone --separate-git-dir"
    and creates "<path>" and "<path>/.git". This can make the resulting
    submodule working tree at "<path>" different from the codepath for
    existing submodules. An example of such differences is that this
    codepath prepares "<path>/.git" with an absolute path, while the
    normal codepath uses a relative path.

When explained this way, the remedy is quite clear, and the change is more
forward-looking, isn't it?  If we later start doing more in the codepath
to deal with existing submodules, your patch may break without having
extra code to cover the "newly cloned" case, too.

I further wonder if we can get away without using separate-git-dir option
in this codepath, though. IOW using

        git clone $quiet -bare ${reference:+"$reference"} "$url" "$gitdir"

might be a better solution.

For example (this relates to the point I mumbled "haven't thought this
through thoroughly yet"), doesn't the newly cloned repository have
core.worktree that points at the working tree that records the <path>,
which would become meaningless when a commit in the superproject that
binds the submodule at different path <path2>?

 git-submodule.sh |   21 ++++++++-------------
 1 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 3adab93..9a23e9d 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -156,21 +156,16 @@ module_clone()
 		;;
 	esac
 
-	if test -d "$gitdir"
+	if ! test -d "$gitdir"
 	then
-		mkdir -p "$path"
-		echo "gitdir: $rel_gitdir" >"$path/.git"
-		rm -f "$gitdir/index"
-	else
-		mkdir -p "$gitdir_base"
-		if test -n "$reference"
-		then
-			git-clone $quiet "$reference" -n "$url" "$path" --separate-git-dir "$gitdir"
-		else
-			git-clone $quiet -n "$url" "$path" --separate-git-dir "$gitdir"
-		fi ||
-		die "$(eval_gettext "Clone of '\$url' into submodule path '\$path' failed")"
+		git clone $quiet -n ${reference:+"$reference"} \
+			--separate-git-dir "$gitdir" "$url" "$path" ||
+		die "$(eval_gettext "Clone of '\$url' for submodule '\$name' failed")
 	fi
+
+	mkdir -p "$path"
+	echo "gitdir: $rel_gitdir" >"$path/.git"
+	rm -f "$gitdir/index"
 }
 
 #
