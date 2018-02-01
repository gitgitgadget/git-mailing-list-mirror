Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BCFB11F576
	for <e@80x24.org>; Thu,  1 Feb 2018 11:06:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752062AbeBALGD (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Feb 2018 06:06:03 -0500
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:32547 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751520AbeBALGD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Feb 2018 06:06:03 -0500
Received: from [192.168.2.201] ([92.28.135.202])
        by smtp.talktalk.net with SMTP
        id hCgpexhciAp17hCgqeK3jY; Thu, 01 Feb 2018 11:06:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1517483161;
        bh=8oEoCcEz2fVg5jDxGoIEJS2gbWHp+MOrrGBp5ne3D/I=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=hnigIjWsUdcxihmDcJ0PN8Vk9LbXzWG9iWnzhtLnIGLjpoZcZ01t1/zX3KNiOLxEe
         R3oOkfN49T0fdIF/OW0SsUbC+a8u12NMSV+gBfZO24uM/Py9PLZ8Znt4mIYB7SVOza
         PcBEbe6dc4HfcsbuJGT5x8rras1iejWrh4v7yyFA=
X-Originating-IP: [92.28.135.202]
X-Spam: 0
X-OAuthority: v=2.2 cv=EsGilWUA c=1 sm=1 tr=0 a=+9ZQAP2FB+pNrrgMTYJMPA==:117
 a=+9ZQAP2FB+pNrrgMTYJMPA==:17 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8
 a=qWg-MD4NkUB6VLyEF-sA:9 a=QEXdDO2ut3YA:10
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 3/3] rebase: introduce and use pseudo-ref ORIG_COMMIT
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>, tim@tim-landscheidt.de
References: <20180126095520.919-1-pclouds@gmail.com>
 <20180131093051.15525-1-pclouds@gmail.com>
 <20180131093051.15525-5-pclouds@gmail.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <629cb58a-a2d5-9039-e424-4986024868d1@talktalk.net>
Date:   Thu, 1 Feb 2018 11:05:58 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180131093051.15525-5-pclouds@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfCxGOWPB8Qk5LRcKdO1EmWU0kHMbTaws2VEnCBS24ennP+t0l0HlbN8OaLc+g/+XRR+Il6o6I9WtSTAUhsaNePuo6rWVkx5CbIcnDbJjdgdix4TO8r3G
 odS7Z+Bm7qN01pJNugYZC/P2du+nZsLZmFABCwwQj6lvOpDIvsfXP34m2WUPpc/NkgH59Ztd9U04kjubn94mhNHOEpje/cXD4pROIZ3M7suXRoKv4jR8VePa
 xfX5ixVk9Pc50RuVCqGWx1KN6MTjh2Fua402cU+/Bm/BOzWhZQX/mAbhlEyNRmC3B9mBXHIdvzfZOoO2Uht6iG35RACeC/NccwProequwlTcEVLqcjvo23e1
 whQ5l2Klk9w4GN2R/kNshwi2DY/Ytw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 31/01/18 09:30, Nguyễn Thái Ngọc Duy wrote:
> 
> The new command `git rebase --show-current-patch` is useful for seeing
> the commit related to the current rebase state. Some however may find
> the "git show" command behind it too limiting. You may want to
> increase context lines, do a diff that ignores whitespaces...
> 
> For these advanced use cases, the user can execute any command they
> want with the new pseudo ref ORIG_COMMIT.
> 
> This also helps show where the stopped commit is from, which is hard
> to see from the previous patch which implements --show-current-patch.
> 
> Helped-by: Tim Landscheidt <tim@tim-landscheidt.de>
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  Documentation/git-rebase.txt           | 3 ++-
>  builtin/am.c                           | 4 ++++
>  contrib/completion/git-completion.bash | 2 +-
>  git-rebase--interactive.sh             | 5 ++++-
>  git-rebase--merge.sh                   | 4 +++-
>  git-rebase.sh                          | 1 +
>  sequencer.c                            | 3 +++
>  t/t3400-rebase.sh                      | 3 ++-
>  t/t3404-rebase-interactive.sh          | 5 ++++-
>  9 files changed, 24 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> index 7ef9577472..6da9296bf8 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -252,7 +252,8 @@ leave out at most one of A and B, in which case it defaults to HEAD.
>  
>  --show-current-patch::
>  	Show the current patch in an interactive rebase or when rebase
> -	is stopped because of conflicts.
> +	is stopped because of conflicts. This is the equivalent of
> +	`git show ORIG_COMMIT`.
>  
>  -m::
>  --merge::
> diff --git a/builtin/am.c b/builtin/am.c
> index caec50cba9..bf9b356340 100644
> --- a/builtin/am.c
> +++ b/builtin/am.c
> @@ -1011,6 +1011,7 @@ static void am_setup(struct am_state *state, enum patch_format patch_format,
>  
>  	if (mkdir(state->dir, 0777) < 0 && errno != EEXIST)
>  		die_errno(_("failed to create directory '%s'"), state->dir);
> +	delete_ref(NULL, "ORIG_COMMIT", NULL, REF_NO_DEREF);
>  
>  	if (split_mail(state, patch_format, paths, keep_cr) < 0) {
>  		am_destroy(state);
> @@ -1110,6 +1111,7 @@ static void am_next(struct am_state *state)
>  
>  	oidclr(&state->orig_commit);
>  	unlink(am_path(state, "original-commit"));
> +	delete_ref(NULL, "ORIG_COMMIT", NULL, REF_NO_DEREF);
>  
>  	if (!get_oid("HEAD", &head))
>  		write_state_text(state, "abort-safety", oid_to_hex(&head));
> @@ -1441,6 +1443,8 @@ static int parse_mail_rebase(struct am_state *state, const char *mail)
>  
>  	oidcpy(&state->orig_commit, &commit_oid);
>  	write_state_text(state, "original-commit", oid_to_hex(&commit_oid));
> +	update_ref("am", "ORIG_COMMIT", &commit_oid,
> +		   NULL, 0, UPDATE_REFS_DIE_ON_ERR);
>  
>  	return 0;
>  }
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 2bd30d68cf..deea688e0e 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -439,7 +439,7 @@ __git_refs ()
>  			track=""
>  			;;
>  		*)
> -			for i in HEAD FETCH_HEAD ORIG_HEAD MERGE_HEAD; do
> +			for i in HEAD FETCH_HEAD ORIG_HEAD MERGE_HEAD ORIG_COMMIT; do
>  				case "$i" in
>  				$match*)
>  					if [ -e "$dir/$i" ]; then
> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index 0c0f8abbf9..ef72bd5871 100644
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -199,12 +199,14 @@ make_patch () {
>  
>  die_with_patch () {
>  	echo "$1" > "$state_dir"/stopped-sha
> +	git update-ref ORIG_COMMIT "$1"
>  	make_patch "$1"
>  	die "$2"
>  }
>  
>  exit_with_patch () {
>  	echo "$1" > "$state_dir"/stopped-sha
> +	git update-ref ORIG_COMMIT "$1"
>  	make_patch $1
>  	git rev-parse --verify HEAD > "$amend"
>  	gpg_sign_opt_quoted=${gpg_sign_opt:+$(git rev-parse --sq-quote "$gpg_sign_opt")}
> @@ -841,7 +843,7 @@ To continue rebase after editing, run:
>  	exit
>  	;;
>  show-current-patch)
> -	exec git show "$(cat "$state_dir/stopped-sha")" --
> +	exec git show ORIG_COMMIT --
>  	;;
>  esac
>  
> @@ -858,6 +860,7 @@ fi
>  
>  orig_head=$(git rev-parse --verify HEAD) || die "$(gettext "No HEAD?")"
>  mkdir -p "$state_dir" || die "$(eval_gettext "Could not create temporary \$state_dir")"
> +rm -f "$(git rev-parse --git-path ORIG_COMMIT)"
>  
>  : > "$state_dir"/interactive || die "$(gettext "Could not mark as interactive")"
>  write_basic_state
> diff --git a/git-rebase--merge.sh b/git-rebase--merge.sh
> index 0a96dfae37..70966c32c3 100644
> --- a/git-rebase--merge.sh
> +++ b/git-rebase--merge.sh
> @@ -57,6 +57,7 @@ call_merge () {
>  	echo "$msgnum" >"$state_dir/msgnum"
>  	cmt="$(cat "$state_dir/cmt.$msgnum")"
>  	echo "$cmt" > "$state_dir/current"
> +	git update-ref ORIG_COMMIT "$cmt"
>  	hd=$(git rev-parse --verify HEAD)
>  	cmt_name=$(git symbolic-ref HEAD 2> /dev/null || echo HEAD)
>  	eval GITHEAD_$cmt='"${cmt_name##refs/heads/}~$(($end - $msgnum))"'
> @@ -138,13 +139,14 @@ skip)
>  	return
>  	;;
>  show-current-patch)
> -	exec git show "$(cat "$state_dir/current")" --
> +	exec git show ORIG_COMMIT --
>  	;;
>  esac
>  
>  mkdir -p "$state_dir"
>  echo "$onto_name" > "$state_dir/onto_name"
>  write_basic_state
> +rm -f "$(git rev-parse --git-path ORIG_COMMIT)"
>  
>  msgnum=0
>  for cmt in $(git rev-list --reverse --no-merges "$revisions")
> diff --git a/git-rebase.sh b/git-rebase.sh
> index 41c915d18c..1db4301b90 100755
> --- a/git-rebase.sh
> +++ b/git-rebase.sh
> @@ -182,6 +182,7 @@ You can run "git stash pop" or "git stash drop" at any time.
>  }
>  
>  finish_rebase () {
> +	rm -f "$(git rev-parse --git-path ORIG_COMMIT)"
>  	apply_autostash &&
>  	{ git gc --auto || true; } &&
>  	rm -rf "$state_dir"
> diff --git a/sequencer.c b/sequencer.c
> index 4d3f60594c..fe907a0701 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -1792,6 +1792,8 @@ static int make_patch(struct commit *commit, struct replay_opts *opts)
>  	p = short_commit_name(commit);
>  	if (write_message(p, strlen(p), rebase_path_stopped_sha(), 1) < 0)
>  		return -1;
> +	update_ref("rebase", "ORIG_COMMIT", &commit->object.oid,
> +		   NULL, 0, UPDATE_REFS_DIE_ON_ERR);

The sequencer tries to return errors rather than dying so the caller can
handle them. The other callers of update_ref pass UPDATE_REFS_MSG_ON_ERR

Best Wishes

Phillip
