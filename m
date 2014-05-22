From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Get rid of the non portable shell export VAR=VALUE costruct
Date: Thu, 22 May 2014 16:42:49 -0700
Message-ID: <xmqqmwe9l6rq.fsf@gitster.dls.corp.google.com>
References: <1400762896-24324-1-git-send-email-gitter.spiros@gmail.com>
	<537DF7F2.8000401@web.de>
	<CA+EOSBkmZRd7FiTNUfDPrUX4NivHR7HUL-+UqDzcpE+X7BQcOA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>, dak@gnu.org,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Elia Pinto <gitter.spiros@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 23 01:42:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WncdX-0005VX-3Z
	for gcvg-git-2@plane.gmane.org; Fri, 23 May 2014 01:42:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752649AbaEVXmz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 May 2014 19:42:55 -0400
Received: from smtp.pobox.com ([208.72.237.35]:54623 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751546AbaEVXmy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 May 2014 19:42:54 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 53BFC19343;
	Thu, 22 May 2014 19:42:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=y9F/CHtMJxVBIkACEmQon5CQm9A=; b=FHeXL7
	HfOgroA8TXR8g4Ia1pli2MVYnoBE7HMnw3Y2RlBqnGDGFxn3T7lLSieNJ3zeaKGh
	OiE1OzkELFaVDgAjLWNi2fAd2cZ+bZueHXx6P96d9/eU6WuW/q5h3SoRXKbNyQc8
	CFsIlNLnuwbUpxwfrMyo8Y8vnEbfjSSgvn44w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MGOo8L/5nL4ty7bC8ruj4sL7hoZBj/aU
	kPYLrSL2AD5AOp9/TnGaQh1sdlFLcWf8YhhSnURo/1wSPLilH6iFqvI6YSoaRxSb
	xFVxD9xCv/+3se9IGKhiftE87HOAThzBc6Ou0iXuj202L5hQXHWSCfDy29E6fXw6
	bXq6E/RKfbc=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4998519340;
	Thu, 22 May 2014 19:42:54 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 135B21932A;
	Thu, 22 May 2014 19:42:51 -0400 (EDT)
In-Reply-To: <CA+EOSBkmZRd7FiTNUfDPrUX4NivHR7HUL-+UqDzcpE+X7BQcOA@mail.gmail.com>
	(Elia Pinto's message of "Thu, 22 May 2014 15:57:40 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: C996EBBE-E20A-11E3-8F93-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249964>

Elia Pinto <gitter.spiros@gmail.com> writes:

> I have no problems rerolling  this simple patch, but i need to know
> what is the (git) right style in this case.

If I were doing this...

diff --git a/contrib/subtree/t/t7900-subtree.sh b/contrib/subtree/t/t7900-subtree.sh
index 66ce4b0..c1d0b23 100755
--- a/contrib/subtree/t/t7900-subtree.sh
+++ b/contrib/subtree/t/t7900-subtree.sh
@@ -8,7 +8,7 @@ This test verifies the basic operation of the merge, pull, add
 and split subcommands of git subtree.
 '
 
-export TEST_DIRECTORY=$(pwd)/../../../t
+TEST_DIRECTORY=$(pwd)/../../../t && export TEST_DIRECTORY

... I'd say I would make this two lines without &&, i.e.

	TEST_DIRECTORY=$(pwd)/../../../t
        export TEST_DIRECTORY

because we are not doing anything about a failure of $(pwd), other
than skipping the export.  If we were failing the entire thing, it
would be a different story, but at this point of the test, it is
unreasonable to do something like:

	TEST_DIRECTORY=$(pwd)/../../../t &&
        export TEST_DIRECTORY || exit $?

anyway.
 
diff --git a/git-remote-testgit.sh b/git-remote-testgit.sh
index 1c006a0..9d1ce76 100755
--- a/git-remote-testgit.sh
+++ b/git-remote-testgit.sh
@@ -13,7 +13,7 @@ refspec="${GIT_REMOTE_TESTGIT_REFSPEC-$default_refspec}"
 
 test -z "$refspec" && prefix="refs"
 
-export GIT_DIR="$url/.git"
+GIT_DIR="$url/.git" && export GIT_DIR
 
 force=

Similarly, as we do not do anything if the assignment to GIT_DIR
fails here, just like we ignore any failure from assignment to
force,

    GIT_DIR="$url/.git"
    export GIT_DIR

would be sufficient.

The logic before the "mkdir -p" of this script may want to be
cleaned up (can you tell how "if $refspec is empty, set prefix=refs"
makes any sense, and what its implications are, without thinking for
more than 10 seconds?), but that is clearly a separate topic [*1*].


diff --git a/git-stash.sh b/git-stash.sh
index 4798bcf..0bb1af8 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -94,7 +94,7 @@ create_stash () {
 		# ease of unpacking later.
 		u_commit=$(
 			untracked_files | (
-				export GIT_INDEX_FILE="$TMPindex"
+				GIT_INDEX_FILE="$TMPindex" && export GIT_INDEX_FILE &&
 				rm -f "$TMPindex" &&
 				git update-index -z --add --remove --stdin &&
 				u_tree=$(git write-tree) &&

This one does care about failures.  I'd rather have these on
separate lines, i.e.

                                GIT_INDEX_FILE="$TMPindex" &&
                                export GIT_INDEX_FILE &&
                                rm -f "$TMPindex" &&
                                ...


[Footnote]

*1* Perhaps something along these lines with the exact placements of
    blank lines to group similar things together:

	alias=$1 url=$2

        if test -z "${GIT_REMOTE_TESTGIT_REFSPEC-notEmpty}"
        then
        	# only if it is explicitly set to an empty string...
		prefix=refs
	else
		prefix="refs/testgit/$alias"
	fi
        dir="$GIT_DIR/testgit/$alias"
	default_refspec="refs/heads/*:${prefix}/heads/*"
	refspec="${GIT_REMOTE_TESTGIT_REFSPEC-$default_refspec}"
	force=

	GIT_DIR="$url/.git"
	export GIT_DIR
