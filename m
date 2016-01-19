From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 6/6] worktree: new command to fix up worktree's info after moving
Date: Tue, 19 Jan 2016 10:25:31 -0800
Message-ID: <xmqqa8o1bf50.fsf@gitster.mtv.corp.google.com>
References: <1453116094-4987-1-git-send-email-pclouds@gmail.com>
	<1453116094-4987-7-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 19 19:25:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLayJ-00013D-8W
	for gcvg-git-2@plane.gmane.org; Tue, 19 Jan 2016 19:25:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932591AbcASSZf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 Jan 2016 13:25:35 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:63797 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932315AbcASSZd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Jan 2016 13:25:33 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1BE823C14D;
	Tue, 19 Jan 2016 13:25:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Zj9XT9gelFW9
	AuomGxq5SL7rliU=; b=WWKCbBSGQjYIqGpEuNohf3FBh8MYH0YauWt+6tkmgJsF
	49bqfxEF5uW3LYuVFi8L8Gf8LQJKvfqA+bP1gIL7Hr/Sp78lQ+AVTOTOFPBouBv6
	L9s1ZDWEXb6TWbpZeqCYhXLeJf7WEwVMX6O8PEt/Gdp8ZLZ/Au2ASYT3N5sq3KY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=YFukUy
	Vh68JDAsVc2weNSIhztoVmam0VhVO81WaYdkopoNBd+kNQfUiV6uNn2MxjK2P80w
	0Y2FkZX5NBTQEbW4bOazzt0zpuJSCok89wLZm4Vy8M2VbRtZiWZB4w9C2lTyeoYz
	VreX1WGM1JnknftKpO+v9vGeJg5D7cucgaVBo=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 12A533C14C;
	Tue, 19 Jan 2016 13:25:33 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 7DFB23C14B;
	Tue, 19 Jan 2016 13:25:32 -0500 (EST)
In-Reply-To: <1453116094-4987-7-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Mon, 18
 Jan 2016 18:21:34 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 067776A4-BEDA-11E5-9CA8-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284367>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> This is a low-level command that can be used to correct worktree
> information after a worktree is moved. The idea is like 'index refres=
h'.
> In future we may do "worktree refresh" automatically to keep it from
> being pruned.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---

I cannot help but think this is backwards.

Before this step, the users were essentially forbidden from using
"mv" to move a worktree, as doing so without telling Git can make
things inconsistent.  Why not keep that prohibition, and give one
and only official supported way to move a worktree, e.g. "worktree
mv", that explicitly tells Git what is being moved from where to
where?

It is prudent to avoid having to do things automatically, especially
that you already were burned once to be overly clever by doing
things automatically, no?  And telling users not to "mv" and instead
to use "worktree mv" would be one way to avoid having to "refresh"
automatically.

>  Documentation/git-worktree.txt |  8 +++++++-
>  builtin/worktree.c             | 18 ++++++++++++++++++
>  t/t1501-worktree.sh            |  9 +++++++++
>  3 files changed, 34 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/git-worktree.txt b/Documentation/git-workt=
ree.txt
> index 62c76c1..306aeec 100644
> --- a/Documentation/git-worktree.txt
> +++ b/Documentation/git-worktree.txt
> @@ -12,6 +12,7 @@ SYNOPSIS
>  'git worktree add' [-f] [--detach] [-b <new-branch>] <path> [<branch=
>]
>  'git worktree prune' [-n] [-v] [--expire <expire>]
>  'git worktree list' [--porcelain]
> +'git worktree refresh'
> =20
>  DESCRIPTION
>  -----------
> @@ -65,6 +66,11 @@ each of the linked worktrees.  The output details =
include if the worktree is
>  bare, the revision currently checked out, and the branch currently c=
hecked out
>  (or 'detached HEAD' if none).
> =20
> +refresh::
> +
> +This command is required to update worktree's information after it's=
 moved.
> +Executed from inside the moved worktree.
> +
>  OPTIONS
>  -------
> =20
> @@ -140,7 +146,7 @@ in the entry's directory. For example, if a linke=
d working tree is moved
>  to `/newpath/test-next` and its `.git` file points to
>  `/path/main/.git/worktrees/test-next`, then update
>  `/path/main/.git/worktrees/test-next/gitdir` to reference `/newpath/=
test-next`
> -instead.
> +instead. Alternatively you can run "git worktree refresh".
> =20
>  To prevent a $GIT_DIR/worktrees entry from being pruned (which
>  can be useful in some situations, such as when the
> diff --git a/builtin/worktree.c b/builtin/worktree.c
> index 475b958..0183ce0 100644
> --- a/builtin/worktree.c
> +++ b/builtin/worktree.c
> @@ -445,6 +445,22 @@ static int list(int ac, const char **av, const c=
har *prefix)
>  	return 0;
>  }
> =20
> +static int refresh(int ac, const char **av, const char *prefix)
> +{
> +	const char *gitdir;
> +
> +	if (ac !=3D 1)
> +		die(_("Arguments not expected"));
> +
> +	gitdir =3D git_pathdup("gitdir");
> +	if (access(gitdir, F_OK))
> +		return 0;
> +	if (!startup_info->first_gitfile)
> +		die("BUG: .git file's location not found");
> +	write_file(gitdir, "%s", startup_info->first_gitfile);
> +	return 0;
> +}
> +
>  int cmd_worktree(int ac, const char **av, const char *prefix)
>  {
>  	struct option options[] =3D {
> @@ -459,5 +475,7 @@ int cmd_worktree(int ac, const char **av, const c=
har *prefix)
>  		return prune(ac - 1, av + 1, prefix);
>  	if (!strcmp(av[1], "list"))
>  		return list(ac - 1, av + 1, prefix);
> +	if (!strcmp(av[1], "refresh"))
> +		return refresh(ac - 1, av + 1, prefix);
>  	usage_with_options(worktree_usage, options);
>  }
> diff --git a/t/t1501-worktree.sh b/t/t1501-worktree.sh
> index cc5b870..821831b 100755
> --- a/t/t1501-worktree.sh
> +++ b/t/t1501-worktree.sh
> @@ -423,4 +423,13 @@ test_expect_success '$GIT_WORK_TREE overrides $G=
IT_DIR/common' '
>  	)
>  '
> =20
> +test_expect_success 'worktree refresh corrects gitdir file' '
> +	git worktree add test-refresh &&
> +	P=3Drepo.git/worktrees/test-refresh/gitdir &&
> +	echo corrupt >$P &&
> +	git -C test-refresh worktree refresh &&
> +	echo "$TRASH_DIRECTORY/test-refresh/.git" >expected &&
> +	test_cmp expected $P
> +'
> +
>  test_done
