Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0548CC2D0E4
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 20:32:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A50A216C4
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 20:32:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="CKPZydHt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbgKLUcE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Nov 2020 15:32:04 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52766 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726566AbgKLUcE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Nov 2020 15:32:04 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AE33BF1B65;
        Thu, 12 Nov 2020 15:31:59 -0500 (EST)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Se3gMqC8vEzj
        8Ou+Myz0MpLonqA=; b=CKPZydHtQFbXxK8XROpQp0gk6RLlbK/vXuCc/po1zMVm
        bAqSQ9qXk4AYxvzUFdRK+SoFhAhlmuA1ln25DEHOZH8cDKxo7/y0pj/cJ9BmXMzQ
        OEfUOzlotsia4Nypteb1LlA5D96l8AyHnhvmKQOyIv/leBWn67x3OtTpDFr4GEQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=iGjGzZ
        iV1sKR7DdI0C7OV+lBVjFOq9Yfqf7oLMexcqCxQZ+7SEHAQTC5tr7AbmB7mjophT
        i+FPZpP+nHWKrDzbFO80HnLuKxfAFUWn3+SaTz66PZ9bVfyYfWiXyM7uVAcrSFJG
        zhaZbR5PjmG5OWf1XpgxqHlTQ7pOeF5JR6lOA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A7354F1B63;
        Thu, 12 Nov 2020 15:31:59 -0500 (EST)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E8A51F1B62;
        Thu, 12 Nov 2020 15:31:56 -0500 (EST)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 0/2] Retire git-parse-remote
Date:   Thu, 12 Nov 2020 12:31:53 -0800
Message-Id: <20201112203155.3342586-1-gitster@pobox.com>
X-Mailer: git-send-email 2.29.2-442-ga30192deef
In-Reply-To: <xmqqwnyr4zv8.fsf@gitster.c.googlers.com>
References: <xmqqwnyr4zv8.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Pobox-Relay-ID: 1BC3311C-2526-11EB-9134-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is based on =C3=86var's 5-patch series, which removed unused bits
from git-parse-remote one by one, before finally moving the remnant
to the only user to remove the file.

Earlier I suggested an alternative arrangement of the series to just
lift what is still in use and then discard the rest without even
splitting them out into separate commits---it is easy to see what's
not used by grepping for names of the helper functions.

The only difference in the end result is that git-parse-remote.sh file
itself is also removed.

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (2):
  parse-remote: move used code to git-submodule.sh
  parse-remote: remove this now-unused library

 .gitignore                         |   1 -
 Documentation/git-parse-remote.txt |  23 -------
 Makefile                           |   2 -
 command-list.txt                   |   1 -
 git-parse-remote.sh                | 101 -----------------------------
 git-submodule.sh                   |   8 ++-
 6 files changed, 7 insertions(+), 129 deletions(-)
 delete mode 100644 Documentation/git-parse-remote.txt
 delete mode 100644 git-parse-remote.sh

Range-diff against v1:
1:  f8c1396d68 < -:  ---------- parse-remote: remove unused GIT_DIR varia=
ble
2:  5f2dac99b8 < -:  ---------- parse-remote: remove long-dead rebase cod=
e
3:  871a40c7e0 < -:  ---------- parse-remote: remove long-dead git-pull.s=
h code
4:  17b0d43b65 ! 1:  8d8de925ea parse-remote: move used code to git-submo=
dule.sh
    @@ Metadata
      ## Commit message ##
         parse-remote: move used code to git-submodule.sh
    =20
    -    Move the only code in git-parse-remote.sh that was actually used=
 to
    -    git-submodule.sh.
    +    Move the get_default_remote () helper from git-parse-remote.sh t=
o
    +    git-submodule.sh, as the latter is the only user.
    =20
    -    This leaves just a comment in git-parse-remote.sh for ease of re=
view,
    -    a later commit will remove it and its build system configuration=
.
    +    There are two more helper functions, get_remote_merge_branch() a=
nd
    +    error_on_missing_default_upstream(), in the git-parse-remote she=
ll
    +    function library, but they are not referenced by git-submodule.s=
h;
    +    stop dot-sourcing the git-parse-remote.
    =20
         Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gm=
ail.com>
         Signed-off-by: Junio C Hamano <gitster@pobox.com>
    =20
      ## git-parse-remote.sh ##
     @@
    - # This is a shell library to calculate the remote repository and
    - # upstream branch that should be pulled by "git pull" from the curr=
ent
    - # branch.
    --
    + # this would fail in that case and would issue an error message.
    + GIT_DIR=3D$(git rev-parse -q --git-dir) || :;
    +=20
     -get_default_remote () {
     -	curr_branch=3D$(git symbolic-ref -q HEAD)
     -	curr_branch=3D"${curr_branch#refs/heads/}"
     -	origin=3D$(git config --get "branch.$curr_branch.remote")
     -	echo ${origin:-origin}
     -}
    +-
    + get_remote_merge_branch () {
    + 	case "$#" in
    + 	0|1)
    =20
      ## git-submodule.sh ##
    +@@ git-submodule.sh: USAGE=3D"[--quiet] [--cached]
    + OPTIONS_SPEC=3D
    + SUBDIRECTORY_OK=3DYes
    + . git-sh-setup
    +-. git-parse-remote
    + require_work_tree
    + wt_prefix=3D$(git rev-parse --show-prefix)
    + cd_to_toplevel
     @@ git-submodule.sh: is_tip_reachable () (
      	test -z "$rev"
      )
5:  1bda9e4479 ! 2:  a7520d32df parse-remote: remove this now-unused libr=
ary
    @@ Metadata
      ## Commit message ##
         parse-remote: remove this now-unused library
    =20
    -    Completely remove the git-parse-remote shellscript library.
    -
    -    Since e9460a66e0 ("parse-remote: support default reflist in
    -    get_remote_merge_branch", 2009-06-12) when there were around 300=
 lines
    -    of code here used by various core code everything in it has beco=
me
    -    unsued, and that unused code was removed in preceding commits. A=
lmost
    -    all of its previous functionality has now been rewritten in C.
    +    Since the previous step stopped dot-sourcing it from
    +    git-submodule.sh, nothing uses git-parse-remote, which
    +    still has two unused functions.  Remove the dead code
    +    together with the file itself and documentation.
    =20
         Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gm=
ail.com>
         Signed-off-by: Junio C Hamano <gitster@pobox.com>
    @@ command-list.txt: git-p4                                  foreigns=
cminterface
      git-prune                               ancillarymanipulators   com=
plete
      git-prune-packed                        plumbingmanipulators
    =20
    - ## git-submodule.sh ##
    -@@ git-submodule.sh: USAGE=3D"[--quiet] [--cached]
    - OPTIONS_SPEC=3D
    - SUBDIRECTORY_OK=3DYes
    - . git-sh-setup
    --. git-parse-remote
    - require_work_tree
    - wt_prefix=3D$(git rev-parse --show-prefix)
    - cd_to_toplevel
    + ## git-parse-remote.sh (deleted) ##
    +@@
    +-# This is a shell library to calculate the remote repository and
    +-# upstream branch that should be pulled by "git pull" from the curr=
ent
    +-# branch.
    +-
    +-# git-ls-remote could be called from outside a git managed reposito=
ry;
    +-# this would fail in that case and would issue an error message.
    +-GIT_DIR=3D$(git rev-parse -q --git-dir) || :;
    +-
    +-get_remote_merge_branch () {
    +-	case "$#" in
    +-	0|1)
    +-	    origin=3D"$1"
    +-	    default=3D$(get_default_remote)
    +-	    test -z "$origin" && origin=3D$default
    +-	    curr_branch=3D$(git symbolic-ref -q HEAD) &&
    +-	    [ "$origin" =3D "$default" ] &&
    +-	    echo $(git for-each-ref --format=3D'%(upstream)' $curr_branch)
    +-	    ;;
    +-	*)
    +-	    repo=3D$1
    +-	    shift
    +-	    ref=3D$1
    +-	    # FIXME: It should return the tracking branch
    +-	    #        Currently only works with the default mapping
    +-	    case "$ref" in
    +-	    +*)
    +-		ref=3D$(expr "z$ref" : 'z+\(.*\)')
    +-		;;
    +-	    esac
    +-	    expr "z$ref" : 'z.*:' >/dev/null || ref=3D"${ref}:"
    +-	    remote=3D$(expr "z$ref" : 'z\([^:]*\):')
    +-	    case "$remote" in
    +-	    '' | HEAD ) remote=3DHEAD ;;
    +-	    heads/*) remote=3D${remote#heads/} ;;
    +-	    refs/heads/*) remote=3D${remote#refs/heads/} ;;
    +-	    refs/* | tags/* | remotes/* ) remote=3D
    +-	    esac
    +-	    [ -n "$remote" ] && case "$repo" in
    +-		.)
    +-		    echo "refs/heads/$remote"
    +-		    ;;
    +-		*)
    +-		    echo "refs/remotes/$repo/$remote"
    +-		    ;;
    +-	    esac
    +-	esac
    +-}
    +-
    +-error_on_missing_default_upstream () {
    +-	cmd=3D"$1"
    +-	op_type=3D"$2"
    +-	op_prep=3D"$3" # FIXME: op_prep is no longer used
    +-	example=3D"$4"
    +-	branch_name=3D$(git symbolic-ref -q HEAD)
    +-	display_branch_name=3D"${branch_name#refs/heads/}"
    +-	# If there's only one remote, use that in the suggestion
    +-	remote=3D"$(gettext "<remote>")"
    +-	branch=3D"$(gettext "<branch>")"
    +-	if test $(git remote | wc -l) =3D 1
    +-	then
    +-		remote=3D$(git remote)
    +-	fi
    +-
    +-	if test -z "$branch_name"
    +-	then
    +-		gettextln "You are not currently on a branch."
    +-	else
    +-		gettextln "There is no tracking information for the current branc=
h."
    +-	fi
    +-	case "$op_type" in
    +-	rebase)
    +-		gettextln "Please specify which branch you want to rebase against=
."
    +-		;;
    +-	merge)
    +-		gettextln "Please specify which branch you want to merge with."
    +-		;;
    +-	*)
    +-		echo >&2 "BUG: unknown operation type: $op_type"
    +-		exit 1
    +-		;;
    +-	esac
    +-	eval_gettextln "See git-\${cmd}(1) for details."
    +-	echo
    +-	echo "    $example"
    +-	echo
    +-	if test -n "$branch_name"
    +-	then
    +-		gettextln "If you wish to set tracking information for this branc=
h you can do so with:"
    +-		echo
    +-		echo "    git branch --set-upstream-to=3D$remote/$branch $display=
_branch_name"
    +-		echo
    +-	fi
    +-	exit 1
    +-}
--=20
2.29.2-442-ga30192deef

