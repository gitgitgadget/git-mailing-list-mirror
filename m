Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6FF801F935
	for <e@80x24.org>; Wed, 21 Sep 2016 18:44:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936563AbcIUSoT (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Sep 2016 14:44:19 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52252 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S936537AbcIUSoR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Sep 2016 14:44:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 53A773FE29;
        Wed, 21 Sep 2016 14:44:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=wjUswLRSKngB
        iITZGHeKccYXQis=; b=G3y27GJ7p8fyh/1C4JhldxLFb7qTJ4Mpt13tGFiO9Pjm
        W/B7BEoxcIU3xjH88vDcxe47Jm0Tiu5OlrLhDgWZwHJbkB59kOaDjXVBnfeM4T3E
        9nut4HRG6U+za9W9RXOBM5enB2kAQR19o5rzxAXt34f/MHS9AISobYp/Iymm83c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=SQDzjm
        DKtK9CNhvc/sk45XGAOa/NGNvdiqGRtlCqxSKEbHg34g6mcxOR9jYRjJ9OEfkrtu
        tO03HVagZ1Q2a+DTONYlWLJLm8PteGfq1LLbZX9QWcf3iRmBpJBoSq60VPjiyw12
        B/08sGgtlwdrvBVAoyZZONi45VGZii3omM9yc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4C0F03FE28;
        Wed, 21 Sep 2016 14:44:16 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AB1073FE27;
        Wed, 21 Sep 2016 14:44:15 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, git@drmicha.warpmail.net,
        max.nordlund@sqore.com
Subject: Re: [PATCH v2 2/3] init: do not set core.worktree more often than necessary
References: <20160908134719.27955-1-pclouds@gmail.com>
        <20160921112939.3444-1-pclouds@gmail.com>
        <20160921112939.3444-3-pclouds@gmail.com>
Date:   Wed, 21 Sep 2016 11:44:12 -0700
In-Reply-To: <20160921112939.3444-3-pclouds@gmail.com> (=?utf-8?B?Ik5ndXk=?=
 =?utf-8?B?4buFbiBUaMOhaSBOZ+G7jWM=?=
        Duy"'s message of "Wed, 21 Sep 2016 18:29:38 +0700")
Message-ID: <xmqqd1jx854z.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 658DF66E-802B-11E6-A88D-EAAE7A1B28F4-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> When "git init" is called with GIT_WORK_TREE environment set, we want t=
o
> keep this worktree's location in core.worktree so the user does not hav=
e
> to set the environment again and again. See ef6f0af (git-init: set
> core.worktree if GIT_WORK_TREE is specified - 2007-07-04)
>
> We detect that by this logic (in needs_work_tree_config): normally
> worktree's top dir would contains ".git" directory, if this is not true=
,

s/contains/contain/;

> worktree is probably set to elsewhere by the user.
>
> Unfortunately when it calls get_git_dir() it does not take ".git" files
> into account. When we find a .git file, we immediately follow the file
> until we find the real ".git" directory. The location of this first
> ".git" file is lost.
>
> The .git file would satisfy the logic above and not create
> core.worktree (correct). But because the final .git's location is used,
> needs_work_tree_config() is misled and creates core.worktree anyway.

The above explanation makes it sound like the correct fix belongs to
needs_work_tree_config(), though.

I am starting to wonder if what ef6f0af did was misguided and we are
better off without setting core.worktree ourselves, but that is a
different issue.

> diff --git a/builtin/init-db.c b/builtin/init-db.c
> index d5d7558..0d5cc76 100644
> --- a/builtin/init-db.c
> +++ b/builtin/init-db.c
> @@ -23,6 +23,7 @@ static int init_is_bare_repository =3D 0;
>  static int init_shared_repository =3D -1;
>  static const char *init_db_template_dir;
>  static const char *git_link;
> +static const char *original_git_dir;
> =20
>  static void copy_templates_1(struct strbuf *path, struct strbuf *templ=
ate,
>  			     DIR *dir)
> @@ -263,7 +264,7 @@ static int create_default_files(const char *templat=
e_path)
>  		/* allow template config file to override the default */
>  		if (log_all_ref_updates =3D=3D -1)
>  			git_config_set("core.logallrefupdates", "true");
> -		if (needs_work_tree_config(get_git_dir(), work_tree))
> +		if (needs_work_tree_config(original_git_dir, work_tree))
>  			git_config_set("core.worktree", work_tree);
>  	}
> =20
> @@ -314,6 +315,8 @@ static void create_object_directory(void)
>  int set_git_dir_init(const char *git_dir, const char *real_git_dir,
>  		     int exist_ok)
>  {
> +	original_git_dir =3D xstrdup(real_path(git_dir));
> +
>  	if (real_git_dir) {
>  		struct stat st;

The function being extern bothers me.  The create_default_files()
function, which is the only thing consumes this variable, is called
only from init_db(), and I'd prefer to see some way to guarantee
that everybody who calls init_db() calls set_git_dir_init()
beforehand.  Right now, cmd_init_db() and cmd_clone() are the only
ones that call init_db() and they both call set_dir_git_init(); if a
new caller starts calling init_db() and forgets to call the other
one, that caller will be buggy.

Perhaps a comment before init_db() to tell callers to always call
the other one is the least thing necessary?

> diff --git a/t/t0001-init.sh b/t/t0001-init.sh
> index 488564b..b8fc588 100755
> --- a/t/t0001-init.sh
> +++ b/t/t0001-init.sh
> @@ -400,9 +400,11 @@ test_expect_success 're-init from a linked worktre=
e' '
>  		test_commit first &&
>  		git worktree add ../linked-worktree &&
>  		mv .git/info/exclude expected-exclude &&
> +		cp .git/config expected-config &&
>  		find .git/worktrees -print | sort >expected &&
>  		git -C ../linked-worktree init &&
>  		test_cmp expected-exclude .git/info/exclude &&
> +		test_cmp expected-config .git/config &&
>  		find .git/worktrees -print | sort >actual &&
>  		test_cmp expected actual
>  	)
