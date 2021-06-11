Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6B16C4743D
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 06:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 869AB61374
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 06:10:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbhFKGMw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Jun 2021 02:12:52 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59723 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbhFKGMv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Jun 2021 02:12:51 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2CA1D14983D;
        Fri, 11 Jun 2021 02:10:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=qLiAbW5+mI25
        1dPCziGP8OsItKRdk4aMU0uIKTvZ47s=; b=OQFMnMlhZl7TtE+/OmjUXM2sXyqJ
        R+qLWPUTzQZeiwvpCbeo7ZsiomL8s/XmAGswxuSrpbhT0Uo07jqYQSuiA9+S2Ciz
        +YQgJ89R9VZJ3HWOwzvwrK5SW7pBMLD9Vmo/Sgwi+5qIAoKL+Zg3gNYSMoCE97u7
        5PbbhRD2NQhFDOM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 245F414983C;
        Fri, 11 Jun 2021 02:10:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 6398914983B;
        Fri, 11 Jun 2021 02:10:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Atharva Raykar <raykar.ath@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Shourya Shukla <shouryashukla.oo@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Subject: Re: [PATCH v3 1/2] submodule--helper: introduce add-clone subcommand
References: <20210608095655.47324-1-raykar.ath@gmail.com>
        <20210610083916.96243-1-raykar.ath@gmail.com>
        <20210610083916.96243-2-raykar.ath@gmail.com>
Date:   Fri, 11 Jun 2021 15:10:49 +0900
In-Reply-To: <20210610083916.96243-2-raykar.ath@gmail.com> (Atharva Raykar's
        message of "Thu, 10 Jun 2021 14:09:15 +0530")
Message-ID: <xmqqim2l3p92.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: C5DBBDC2-CA7B-11EB-99C1-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Atharva Raykar <raykar.ath@gmail.com> writes:

> Let's add a new "add-clone" subcommand to `git submodule--helper` with
> the goal of converting part of the shell code in git-submodule.sh
> related to `git submodule add` into C code. This new subcommand clones
> the repository that is to be added, and checks out to the appropriate
> branch.
>
> This is meant to be a faithful conversion that leaves the behaviour of
> 'submodule add' unchanged. The only minor change is that if a submodule=
 name has
> been supplied with a name that clashes with a local submodule, the mess=
age shown
> to the user ("A git directory for 'foo' is found locally...") is prepen=
ded with
> "error" for clarity.
>
> This is part of a series of changes that will result in all of 'submodu=
le add'
> being converted to C.
>
> Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Shourya Shukla <shouryashukla.oo@gmail.com>
> Based-on-patch-by: Shourya Shukla <shouryashukla.oo@gmail.com>
> Based-on-patch-by: Prathamesh Chavan <pc44800@gmail.com>
> Helped-by: =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh <congdanhqx@gmail=
.com>
> ---
>  builtin/submodule--helper.c | 180 ++++++++++++++++++++++++++++++++++++
>  git-submodule.sh            |  38 +-------
>  2 files changed, 181 insertions(+), 37 deletions(-)
>
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index d55f6262e9..21b2e9fb14 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -2745,6 +2745,185 @@ static int module_set_branch(int argc, const ch=
ar **argv, const char *prefix)
>  	return !!ret;
>  }
> =20
> +struct add_data {
> +	const char *prefix;
> +	const char *branch;
> +	const char *reference_path;
> +	const char *sm_path;
> +	const char *sm_name;
> +	const char *repo;
> +	const char *realrepo;
> +	int depth;
> +	unsigned int force: 1;
> +	unsigned int quiet: 1;
> +	unsigned int progress: 1;
> +	unsigned int dissociate: 1;
> +};
> +#define ADD_DATA_INIT { .depth =3D -1 }
> +
> +static void show_fetch_remotes(FILE *output, const char *sm_name, cons=
t char *git_dir_path)
> +{
> +	struct child_process cp_remote =3D CHILD_PROCESS_INIT;
> +	struct strbuf sb_remote_out =3D STRBUF_INIT;
> +
> +	cp_remote.git_cmd =3D 1;
> +	strvec_pushf(&cp_remote.env_array,
> +		     "GIT_DIR=3D%s", git_dir_path);
> +	strvec_push(&cp_remote.env_array, "GIT_WORK_TREE=3D.");
> +	strvec_pushl(&cp_remote.args, "remote", "-v", NULL);
> +	if (!capture_command(&cp_remote, &sb_remote_out, 0)) {
> +		char *next_line;
> +		char *line =3D sb_remote_out.buf;
> +		while ((next_line =3D strchr(line, '\n')) !=3D NULL) {
> +			size_t len =3D next_line - line;
> +			if (strip_suffix_mem(line, &len, " (fetch)"))
> +				fprintf(output, "  %.*s\n", (int)len, line);
> +			line =3D next_line + 1;

Good.  That's a handy helper to use here.

> +		}
> +	}
> +
> +	strbuf_release(&sb_remote_out);
> +}
> +
> +static int add_submodule(const struct add_data *add_data)
> +{
> +	char *submod_gitdir_path;
> +
> +	/* perhaps the path already exists and is already a git repo, else cl=
one it */
> +	if (is_directory(add_data->sm_path)) {
> +		submod_gitdir_path =3D xstrfmt("%s/.git", add_data->sm_path);
> +		if (is_directory(submod_gitdir_path) || file_exists(submod_gitdir_pa=
th))

This is a faithful translation from the scripted Porcelain that did
not have access to our C internals that can do a lot better job at
deciding if a given "$path", which has ".git" directly or file below
it, is the top of a working tree that is governed by that ".git"
thing.

I wonder if setup.c::is_nonbare_repository_dir() can be used here.
You really want to see add_data->sm_path is the top of the working
tree of a submodule, so requiring only that ".git" thing is either
a directory or a file, which was the cheap thing the scripted version
could do without expending too much engineering effort, is a shame
when you are now writing in C and all the infrastructure to do much
better job is available to you.

> +			printf(_("Adding existing path at '%s' to index\n"),
> +			       add_data->sm_path);

Unintended change to the message here; you lost "the".

> +		else
> +			die(_("'%s' already exists and is not a valid git repo"),
> +			    add_data->sm_path);
> +		free(submod_gitdir_path);
> +	} else {
> +		struct strvec clone_args =3D STRVEC_INIT;
> +		struct child_process cp =3D CHILD_PROCESS_INIT;
> +		submod_gitdir_path =3D xstrfmt(".git/modules/%s", add_data->sm_name)=
;
> +
> +		if (is_directory(submod_gitdir_path)) {
> +			if (!add_data->force) {
> +				error(_("a git directory for '%s' is found "
> +					"locally with remote(s):"), add_data->sm_name);

The original is a mere eval_gettextln, so a faithful conversion
would be to emit this to the standard error stream, without letting
error() to add "error: " prefix and downcasing "A git directory".

> +				show_fetch_remotes(stderr, add_data->sm_name,
> +						   submod_gitdir_path);
> +				fprintf(stderr,
> +					_("If you want to reuse this local git "
> +					  "directory instead of cloning again from\n"
> +					  "  %s\n"
> +					  "use the '--force' option. If the local git "
> +					  "directory is not the correct repo\n"
> +					  "or if you are unsure what this means, choose "
> +					  "another name with the '--name' option.\n"),
> +					add_data->realrepo);
> +				free(submod_gitdir_path);
> +				return 1;

The updated caller in the scripted Porcelain just silently exits
upon an error, so the above message that used to be given to die()
needs to be emitted by us like this.  You may want to do die(),
instead of fprintf(stderr) followed by return 1, to be a more
faithful conversion.

> +			} else {
> +				printf(_("Reactivating local git directory for "
> +					 "submodule '%s'\n"), add_data->sm_name);
> +			}
> +		}
> +		free(submod_gitdir_path);

And at this point, the original scripted Porcelain used to call "git
submodule--helper clone".

> +		strvec_pushl(&clone_args, "clone", "--path", add_data->sm_path, "--n=
ame",
> +			     add_data->sm_name, "--url", add_data->realrepo, NULL);
> +		if (add_data->quiet)
> +			strvec_push(&clone_args, "--quiet");
> +		if (add_data->progress)
> +			strvec_push(&clone_args, "--progress");
> +		if (add_data->prefix)
> +			strvec_pushl(&clone_args, "--prefix", add_data->prefix, NULL);
> +		if (add_data->reference_path)
> +			strvec_pushl(&clone_args, "--reference",
> +				     add_data->reference_path, NULL);
> +		if (add_data->dissociate)
> +			strvec_push(&clone_args, "--dissociate");
> +		if (add_data->depth >=3D 0)
> +			strvec_pushf(&clone_args, "--depth=3D%d", add_data->depth);
> +
> +		if (module_clone(clone_args.nr, clone_args.v, add_data->prefix)) {
> +			strvec_clear(&clone_args);
> +			return -1;
> +		}
> +		strvec_clear(&clone_args);

All of the above does the equivalent of it, but having to "unparse"
members of the add_data structure and stuff clone_args, only to be
parsed by parse_options() call in module_clone(), is somewhat
unsatisfactory.  I think this series would be helped greatly if
there were an additional step that splits module_clone() into two,
factoring out everything that happens after module_clone() calls
parse_options() into a helper function.  module_clone() will call
that helper function, and then at this step, instead of the above
"unparse and then call module_clone()", this place will call the
same helper function.

In any case, after doing "git submodule--helper clone", the original
scripted version does "git checkout" in the newly cloned working
tree.  I wonder if the "module_clone" is done with "--no-checkout"
option---cloning and letting a commit checked out, and checking out
another commit immediately after it, feels somewhat wasteful.

> +		prepare_submodule_repo_env(&cp.env_array);
> +		cp.git_cmd =3D 1;
> +		cp.dir =3D add_data->sm_path;
> +		strvec_pushl(&cp.args, "checkout", "-f", "-q", NULL);
> +
> +		if (add_data->branch) {
> +			strvec_pushl(&cp.args, "-B", add_data->branch, NULL);
> +			strvec_pushf(&cp.args, "origin/%s", add_data->branch);
> +		}
> +
> +		if (run_command(&cp))
> +			die(_("unable to checkout submodule '%s'"), add_data->sm_path);
> +	}
> +	return 0;
> +}

Other than all the commented parts, this looks fairly faithful
conversion from the part of the scripted Porcelain that has been
lost by the same patch.

> +static int add_clone(int argc, const char **argv, const char *prefix)
> +{
> +	int force =3D 0, quiet =3D 0, dissociate =3D 0, progress =3D 0;
> +	struct add_data add_data =3D ADD_DATA_INIT;
> + ...
> +	argc =3D parse_options(argc, argv, prefix, options, usage, 0);
> +
> +	if (argc !=3D 0)
> +		usage_with_options(usage, options);
> +
> +	add_data.progress =3D !!progress;
> +	add_data.dissociate =3D !!dissociate;
> +	add_data.force =3D !!force;
> +	add_data.quiet =3D !!quiet;
> +
> +	if (add_submodule(&add_data))
> +		return 1;
> +
> +	return 0;
> +}

As you wrote the add_clone() vs add_submodule() split of labour, the
reason this one is much more nicely organized than module_clone()
should be obvious to you.  This part of the design of this patch is
very well done.

The "additional step" I hinted earlier is exactly that---by making
the guts of the feature add_submodule() to work on already parsed
data and a separate wrapper add_clone() that interfaces to the
scripts to parse the command line arguments into a shape that is
more appropriate for the inner function, you can later call the
inner function add_submodule() directly without going through the
unparsing-then-parsing dance from other places.  If module_clone()
were split into two in a similar way, then the place to call it from
add_submodule() would become much cleaner.

Thanks.
