From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] difftool: support repositories with .git-files
Date: Mon, 24 Feb 2014 09:55:30 -0800
Message-ID: <xmqqr46s9yzx.fsf@gitster.dls.corp.google.com>
References: <1393211555-50270-1-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?B?R8OhYm9yIExpcHTDoWs=?= <gabor.liptak@gmail.com>,
	Jens Lehmann <jens.lehmann@web.de>,
	John Keeping <john@keeping.me.uk>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 24 18:55:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WHzkt-0003pv-Tq
	for gcvg-git-2@plane.gmane.org; Mon, 24 Feb 2014 18:55:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752988AbaBXRzj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Feb 2014 12:55:39 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48835 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752843AbaBXRze convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Feb 2014 12:55:34 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3E3686BC2D;
	Mon, 24 Feb 2014 12:55:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=HBv2RFFZISEd
	rvM7JOzA5LD4ZNQ=; b=Ttc9GE9TzkR9eZvPT6vB0ofHuutUPkW/6BA9TEhx3JfF
	u5Qj/q05A5VCC/pxNsc7T2bvAvCdGspjYcuSUzB9thPD9z/kO6dGWP2Y4kdE5WYA
	HReaEuMQcr+lezITveZSCX58moFTZJ3CrJ2VzNkpZewFthat/hlr9igxzwciUBA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=fFSP+M
	+B2bNWtidmRmY+//7D7LAgPyBfpRzoItuumLQ1a2IjW+/rq2r9ERa6qNTxeKYpFz
	RXGidn9igYVdDaP5yGt0niAahio6s82UDZ0K4ze4IzF4LzNsWDbyqymrAnz6ruQu
	uljBPTeumwB8YQWNrdclp+Mw5yisiDD6pE9A0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2CA826BC2B;
	Mon, 24 Feb 2014 12:55:34 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4812A6BC2A;
	Mon, 24 Feb 2014 12:55:33 -0500 (EST)
In-Reply-To: <1393211555-50270-1-git-send-email-davvid@gmail.com> (David
	Aguilar's message of "Sun, 23 Feb 2014 19:12:35 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: DB5CD16A-9D7C-11E3-840D-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242622>

David Aguilar <davvid@gmail.com> writes:

> Modern versions of "git submodule" use .git-files to setup the
> submodule directory.  When run in a "git submodule"-created
> repository "git difftool --dir-diff" dies with the following
> error:
>
> 	$ git difftool -d HEAD~
> 	fatal: This operation must be run in a work tree
> 	diff --raw --no-abbrev -z HEAD~: command returned error: 128
>
> core.worktree is relative to the .git directory but the logic
> in find_worktree() does not account for it.
>
> Use `git rev-parse --show-toplevel` to find the worktree so that
> the dir-diff feature works inside a submodule.
>
> Reported-by: G=C3=A1bor Lipt=C3=A1k <gabor.liptak@gmail.com>
> Helped-by: Jens Lehmann <jens.lehmann@web.de>
> Helped-by: John Keeping <john@keeping.me.uk>
> Signed-off-by: David Aguilar <davvid@gmail.com>
> ---

Looks good; thanks.

>  git-difftool.perl | 18 ++----------------
>  1 file changed, 2 insertions(+), 16 deletions(-)
>
> diff --git a/git-difftool.perl b/git-difftool.perl
> index e57d3d1..18ca61e 100755
> --- a/git-difftool.perl
> +++ b/git-difftool.perl
> @@ -39,24 +39,10 @@ USAGE
> =20
>  sub find_worktree
>  {
> -	my ($repo) =3D @_;
> -
>  	# Git->repository->wc_path() does not honor changes to the working
>  	# tree location made by $ENV{GIT_WORK_TREE} or the 'core.worktree'
>  	# config variable.
> -	my $worktree;
> -	my $env_worktree =3D $ENV{GIT_WORK_TREE};
> -	my $core_worktree =3D Git::config('core.worktree');
> -
> -	if (defined($env_worktree) and (length($env_worktree) > 0)) {
> -		$worktree =3D $env_worktree;
> -	} elsif (defined($core_worktree) and (length($core_worktree) > 0)) =
{
> -		$worktree =3D $core_worktree;
> -	} else {
> -		$worktree =3D $repo->wc_path();
> -	}
> -
> -	return $worktree;
> +	return Git::command_oneline('rev-parse', '--show-toplevel');
>  }
> =20
>  sub print_tool_help
> @@ -418,7 +404,7 @@ sub dir_diff
>  	my $rc;
>  	my $error =3D 0;
>  	my $repo =3D Git->repository();
> -	my $workdir =3D find_worktree($repo);
> +	my $workdir =3D find_worktree();
>  	my ($a, $b, $tmpdir, @worktree) =3D
>  		setup_dir_diff($repo, $workdir, $symlinks);
