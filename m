Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCEBBC433EF
	for <git@archiver.kernel.org>; Sun, 21 Nov 2021 08:56:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237312AbhKUI7u (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Nov 2021 03:59:50 -0500
Received: from mout.web.de ([217.72.192.78]:47877 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229972AbhKUI7u (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Nov 2021 03:59:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1637484994;
        bh=B4QEMG2x+MW7WJXH55raEga4bUd9dB8hwAH2xCmAUuc=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=IqMhF5ToRVa9tAb7m9/t9cTKoE/oiysrz116ozj5FJDns1jgDFQsi92LDsJ6wwGW1
         BzqXQMeobNclubeF8JgoKpBIFkXnxt+KFQYlv9wONQAeC8EkhF4kWgY+kTFyiUdUb2
         id2R4lWeqw1WDTeeJW4hQDZ0LXlR9Y6JgvmLDHss=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.20.171]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MN6Fj-1n7lTD0hVN-00Is1A; Sun, 21
 Nov 2021 09:56:34 +0100
Message-ID: <776abd16-53d5-46c0-8008-c518a4415f7d@web.de>
Date:   Sun, 21 Nov 2021 09:56:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [PATCH 2/8] repository, setup: introduce the_cwd
Content-Language: en-US
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>
References: <pull.1140.git.git.1637455620.gitgitgadget@gmail.com>
 <7b0c665fb75d3d73d9d8d03b629a09a0ec4244e6.1637455620.git.gitgitgadget@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <7b0c665fb75d3d73d9d8d03b629a09a0ec4244e6.1637455620.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DA6nI+ci8CCGBzW9E4SaDRQ2/6My5STkrxyZE+EX1TnJFWwBn99
 lj1wHNu+M/FRudGaMAI4paHGRTTk8S4jS7761hrHIih+8Mo0UVgjnO3I8wZMfuFsxcmoYVz
 kYpUjpKUmyRwcF0Fb96VvJVQ6H+KBVncV4VElPsoyTt3dO/axOYY313PCBXoCYs4Pb5+R4V
 IwhZwJt1llVh3aiXhX9OQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dQ63fpQYo3o=:TR487maEyN2vJ1oIU7Jx3f
 GVWUnxHf7CZnyxATpQlHpD6HSnqe2+bKeEHW1NXC1lUgbuDJPgXcisJIYMErC68YEZLHHTHgR
 XdZ500wjaaPkMdZCv5DtoIfPFNsfvlZ1+tHNbnYVpAMU0WPMKSjMe4CuhyMUtEPnwWBDegfQL
 UYzYgSB+ZVVlWMu3zOeRceUqVC7R0XE29XIdfY0jbclgavdkWg6nxW7kbx6YHuPD7t/FibkBr
 4MCDC9MJQRpyQ/BVD/8hglAO6uSkuagvSTa4+GPhixG1txYFKdVK+0DB/lCXN2rGnfdbdaK8C
 b87kP5Y1zQQdztjsQGO3gYKCkxjWP3oSd7lTRtRQOhCI9bRs2PKvxfWswMLepmI8q/8uMbWEe
 oYCuhQOFtpEC4tOc+OVD14CMGC1wNIwbAaoBKmJ+hZ2qykouzHYt0Jo2WLfqbG/ah2OvyG0jn
 FouJT42Cm94fqF/7HYntpqtHjX+utD8V9pv4WkKfvYwqfhSpB8iXnl3HrrFsJL8hU8xZy1QFU
 Il7h5XByxJJkPpomPrrBLhgOAh4qCZ3ybPNNdfbYPFrddoMpgjFbIwhvmbvKo9x3L+nAoWdYL
 AAtzhylelUBT2HfBqxYWExZBBh4/AoFg+VNBiPapPACC9K+EAfJeUhz3RlA4oorR4edecHQuU
 abPPy4lEhf2Tk7dn63A8NdKR6np+QzcO9I4M9LlqSG3y5mVYuA/heRG05fClKrV/tGz41wrXo
 4RiPxjl7F8u1mRU1YP5DQM8dihZs/edAyfn4B9vFKH4JiTIylIk9IOk4KMfSdIQFTSGsy3X8D
 ANCFNdRSX0yVFFgQTTexRmnz2WdiXDLXMS9iZazC1T8H50dt74084BDDQ9wvWiKDza9rKLE8h
 dYqOvHpNkQIHNHcETWg4+5tc18wVcWS+B5oMHC+F3Sj+auzqgQFoHh/OHMtTwVP6gy6Gd/J3m
 lmg9ZULIz46aQe/vCpVZASqqj+zCJ07D/RuK3+E+Rp9OFN7pfxwAn2po6gfvcvcPjJ0t5uwbM
 AU+sgJY5apPwzw9/4biD7JqaKyMQrm/djM3end5JsK+/XPekCWTH1xYU5+yUfoQUkQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 21.11.21 um 01:46 schrieb Elijah Newren via GitGitGadget:
> From: Elijah Newren <newren@gmail.com>
>
> Removing the current working directory causes all subsequent git
> commands (and likely a number of non-git commands) run from that
> directory to get confused and fail with a message about being unable to
> read the current working directory.  That confuses end users,
> particularly since the command they get the error from is not the one
> that caused the problem; the problem came from the side-effect of some
> previous command.
>
> We would like to avoid removing the current working directory;

A worthy goal.

> towards
> this end, introduce a new the_cwd variable that tracks the current
> working directory.  Subsequent commits will make use of this new
> variable.

Why make it a global variable instead of getting the working directory
in the places that try to delete directories?  (Honest question, not a
suggestion.)

>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  repository.c | 1 +
>  repository.h | 1 +
>  setup.c      | 2 ++
>  3 files changed, 4 insertions(+)
>
> diff --git a/repository.c b/repository.c
> index c5b90ba93ea..69a106c553c 100644
> --- a/repository.c
> +++ b/repository.c
> @@ -17,6 +17,7 @@
>  static struct repository the_repo;
>  struct repository *the_repository;
>  struct index_state the_index;
> +char *the_cwd;
>
>  void initialize_the_repository(void)
>  {
> diff --git a/repository.h b/repository.h
> index a057653981c..45de85d18ef 100644
> --- a/repository.h
> +++ b/repository.h
> @@ -147,6 +147,7 @@ struct repository {
>  };
>
>  extern struct repository *the_repository;
> +extern char *the_cwd;
>
>  /*
>   * Define a custom repository layout. Any field can be NULL, which
> diff --git a/setup.c b/setup.c
> index 347d7181ae9..4466fa55af3 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -887,6 +887,7 @@ static const char *setup_explicit_git_dir(const char=
 *gitdirenv,
>  		set_git_dir(gitdirenv, 1);
>  		if (chdir(worktree))
>  			die_errno(_("cannot chdir to '%s'"), worktree);
> +		the_cwd =3D xstrdup(cwd->buf + offset);
>  		strbuf_addch(cwd, '/');
>  		free(gitfile);
>  		return cwd->buf + offset;
> @@ -940,6 +941,7 @@ static const char *setup_discovered_git_dir(const ch=
ar *gitdir,
>  	/* Make "offset" point past the '/' (already the case for root dirs) *=
/
>  	if (offset !=3D offset_1st_component(cwd->buf))
>  		offset++;
> +	the_cwd =3D xstrdup(cwd->buf + offset);
>  	/* Add a '/' at the end */
>  	strbuf_addch(cwd, '/');
>  	return cwd->buf + offset;
>

