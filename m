From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] setup: set env $GIT_WORK_TREE when work tree is set, like $GIT_DIR
Date: Fri, 26 Jun 2015 10:30:28 -0700
Message-ID: <xmqqlhf6v0ln.fsf@gitster.dls.corp.google.com>
References: <CA+cck7GD+JgR4O-XoBeUX1gJAG6suP9iLwASyRygK8hR4KP7pw@mail.gmail.com>
	<1435315055-27011-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, snoksrud@gmail.com
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 26 19:30:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z8XSV-0007jb-Pr
	for gcvg-git-2@plane.gmane.org; Fri, 26 Jun 2015 19:30:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752228AbbFZRac convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Jun 2015 13:30:32 -0400
Received: from mail-ig0-f171.google.com ([209.85.213.171]:37386 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752001AbbFZRab (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jun 2015 13:30:31 -0400
Received: by igblr2 with SMTP id lr2so17913499igb.0
        for <git@vger.kernel.org>; Fri, 26 Jun 2015 10:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=BBDUlp/zUSgmatKkGZKxAtUF6kNdgnPbjDJVhvYw9fw=;
        b=0FcxZ2mMeRVlhx8pq8R0cY+nICpgLJJofSZmWv49LjSEQRqZgNsZirPxcxZaeD2PUI
         5N10r1X4/KFbbpo29Ru3NNsrkTIRVKnup1GHYNxM/65eMWwnHWLOl+MNIu6OnL/ewlxN
         lkGLinV+dmjGKNZnJIYPO+y7h7x1jsyTn1k85EryAEjfnMayuzmGHeXFCgDSXRkkACCR
         L1KN8w5JrEesHwBy6S1aYyPK6ZJirCXp9JHYBArBXtWncCRz8AIuYyL15jXPb60qWQyo
         aVamEuUAulcOidp9TKO4HskhuIEA5557oNXX/PftFmo2UIhA0HUt0/oaDDMdJb1oW7l1
         EZVw==
X-Received: by 10.43.34.205 with SMTP id st13mr4682641icb.4.1435339830496;
        Fri, 26 Jun 2015 10:30:30 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:6587:7c7a:db33:ca35])
        by mx.google.com with ESMTPSA id o19sm1246439igs.18.2015.06.26.10.30.29
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 26 Jun 2015 10:30:29 -0700 (PDT)
In-Reply-To: <1435315055-27011-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Fri, 26
 Jun 2015 17:37:35 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272803>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> This is where the "fun" is. The legacy behavior is, if $GIT_WORK_TREE=
 is
> not set but $GIT_DIR is, cwd is chosen as worktree's top. If you happ=
en
> to stand at worktree's top when you do this, all is well.

It is not legacy, though.  It is how things were designed to be
used, and how things are supposed to work in the future.

Until we do the deprecation dance to force people to update existing
scripts to explicitly export GIT_WORK_TREE=3D$(pwd) or something like
that, that is.

And I wouldn't be opposed to such a transition plan; something along
the lines of what Peff outlined in that old thread.

http://thread.gmane.org/gmane.comp.version-control.git/219096/focus=3D2=
19197

> Bottom line is, when $GIT_DIR is set, $GIT_WORK_TREE should be set to=
o
> unless there's no work tree. But setting $GIT_WORK_TREE inside
> set_git_dir() may backfire. We don't know at that point if work tree =
is
> already configured by the caller. So set it when work tree is
> detected. It does not harm if $GIT_WORK_TREE is set while $GIT_DIR is
> not.

I am inclined to queue this on 'next' per "experimental" basis so
that other people with different workflows (especially those who
use existing scripts around Git plumbing heavily) can see if this
does not have any unintended fallouts.  I cannot convince myself
that it is generally a safe thing to do to muck with environment
partially, hoping nobody would care.

Thanks for looking into it.

>  environment.c      |  2 ++
>  t/t0002-gitfile.sh | 17 +++++++++++++++++
>  2 files changed, 19 insertions(+)
>
> diff --git a/environment.c b/environment.c
> index 61c685b..8f1b249 100644
> --- a/environment.c
> +++ b/environment.c
> @@ -231,6 +231,8 @@ void set_git_work_tree(const char *new_work_tree)
>  	}
>  	git_work_tree_initialized =3D 1;
>  	work_tree =3D xstrdup(real_path(new_work_tree));
> +	if (setenv(GIT_WORK_TREE_ENVIRONMENT, work_tree, 1))
> +		error("Could not set GIT_WORK_TREE to '%s'", work_tree);
>  }
> =20
>  const char *get_git_work_tree(void)
> diff --git a/t/t0002-gitfile.sh b/t/t0002-gitfile.sh
> index 37e9396..9393322 100755
> --- a/t/t0002-gitfile.sh
> +++ b/t/t0002-gitfile.sh
> @@ -99,4 +99,21 @@ test_expect_success 'check rev-list' '
>  	test "$SHA" =3D "$(git rev-list HEAD)"
>  '
> =20
> +test_expect_success 'setup_git_dir twice in subdir' '
> +	git init sgd &&
> +	(
> +		cd sgd &&
> +		git config alias.lsfi ls-files &&
> +		mv .git .realgit &&
> +		echo "gitdir: .realgit" >.git &&
> +		mkdir subdir &&
> +		cd subdir &&
> +		>foo &&
> +		git add foo &&
> +		git lsfi >actual &&
> +		echo foo >expected &&
> +		test_cmp expected actual
> +	)
> +'
> +
>  test_done
