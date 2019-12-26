Return-Path: <SRS0=68ZU=2Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7D2FC2D0C0
	for <git@archiver.kernel.org>; Thu, 26 Dec 2019 20:40:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EA09206CB
	for <git@archiver.kernel.org>; Thu, 26 Dec 2019 20:40:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="gaxiqBj+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbfLZUkE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Dec 2019 15:40:04 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63226 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbfLZUkE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Dec 2019 15:40:04 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8C54C9FAC3;
        Thu, 26 Dec 2019 15:39:59 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=01+I5ghB9AjIORnabjZLE7uw/lQ=; b=gaxiqB
        j+3G3EMKOrIbnOcuf2hvXQaELb+SgiFtq/tP2tm79dWSiS9PuESEcK1JL1uxmOO7
        ruVEtspGv+QHlU/8VBeMjdZgkUThYVOc0gEwGLAluJ/qTgIp81Eqzj8NQqGBhFez
        C/YUNKVAMKIv6sST0bUd2lHOqSl1U3xIb+hho=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=nV6uk50dTcXgpKUtT/oBQpa5A90FFAHf
        TBzqf30TwqMzGd79jlXJGOMfmBZSygt/WGeCc3L6T1nGWr5rRII4eI1e6V7+zPZY
        I+8I9cMx7GHa4tDILWOt56iaXnot4uA3bj3sSesw2VD7RM+ruhILvsuokP6zXwEz
        KAhZLinT7kU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 84BAE9FAC2;
        Thu, 26 Dec 2019 15:39:59 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 3938B9FABE;
        Thu, 26 Dec 2019 15:39:55 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Alban Gruin <alban.gruin@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 04/17] sequencer: configurably warn on non-existent files
References: <cover.1571246693.git.liu.denton@gmail.com>
        <cover.1577185374.git.liu.denton@gmail.com>
        <fd547aab491b24a47f683d717c6b77255ac16901.1577185374.git.liu.denton@gmail.com>
Date:   Thu, 26 Dec 2019 12:39:52 -0800
In-Reply-To: <fd547aab491b24a47f683d717c6b77255ac16901.1577185374.git.liu.denton@gmail.com>
        (Denton Liu's message of "Tue, 24 Dec 2019 06:05:01 -0500")
Message-ID: <xmqqwoaikehz.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DFD38336-281F-11EA-A1C8-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> -static int read_oneliner(struct strbuf *buf,
> -	const char *path, int skip_if_empty)
> +static int read_oneliner(struct strbuf *buf, const char *path,
> +			 int skip_if_empty, int warn_nonexistence)

I would have to say that this results in a rather poor API in the
end, and also forces an awkward API evolution, and we need to be
careful especially if we plan to make this an external API in a
later step in the series.

There is a topic in flight that introduces additional callsites of
read_oneliner().  It is a selfish move that breaks codebase
unnecessarily to unilaterally change the function signature.

Two possible ways to improve are:

 * keep read_oneliner() with existing function signature working for
   other topics in flight, by renaming your extended variant and
   making read_oneliner() a thin wrapper that calls yours with the
   extended feature disabled (i.e. warn_nonexistence==0); or

 * update skip_if_empty that wastes an int parameter to pass only a
   single bit into an unsigned that is a collection of bits, after
   vetting that new callsites contemporary topics add always pass
   either 0 or 1 as the parameter.  Then

	#define READ_ONELINER_SKIP_IF_EMPTY 01
	#define READ_ONELINER_WARN_MISSING  02
	static int read_oneliner(struct strbuf *buf, const char *path,
   				 unsigned flags)

   would transparently work well for those other topics.

The latter probably is more preferrable, as the end result would be
a cleaner API than the former or the one presented in this series.

Thanks.

>  {
>  	int ret = 0;
>  	struct strbuf file_buf = STRBUF_INIT;
>  
> -	if (!file_exists(path))
> +	if (!warn_nonexistence && !file_exists(path))
>  		return 0;
>  
>  	if (strbuf_read_file(&file_buf, path, 0) < 0) {
> @@ -2558,10 +2558,10 @@ void parse_strategy_opts(struct replay_opts *opts, char *raw_opts)
>  static void read_strategy_opts(struct replay_opts *opts, struct strbuf *buf)
>  {
>  	strbuf_reset(buf);
> -	if (!read_oneliner(buf, rebase_path_strategy(), 0))
> +	if (!read_oneliner(buf, rebase_path_strategy(), 0, 0))
>  		return;
>  	opts->strategy = strbuf_detach(buf, NULL);
> -	if (!read_oneliner(buf, rebase_path_strategy_opts(), 0))
> +	if (!read_oneliner(buf, rebase_path_strategy_opts(), 0, 0))
>  		return;
>  
>  	parse_strategy_opts(opts, buf->buf);
> @@ -2572,7 +2572,7 @@ static int read_populate_opts(struct replay_opts *opts)
>  	if (is_rebase_i(opts)) {
>  		struct strbuf buf = STRBUF_INIT;
>  
> -		if (read_oneliner(&buf, rebase_path_gpg_sign_opt(), 1)) {
> +		if (read_oneliner(&buf, rebase_path_gpg_sign_opt(), 1, 0)) {
>  			if (!starts_with(buf.buf, "-S"))
>  				strbuf_reset(&buf);
>  			else {
> @@ -2582,7 +2582,7 @@ static int read_populate_opts(struct replay_opts *opts)
>  			strbuf_reset(&buf);
>  		}
>  
> -		if (read_oneliner(&buf, rebase_path_allow_rerere_autoupdate(), 1)) {
> +		if (read_oneliner(&buf, rebase_path_allow_rerere_autoupdate(), 1, 0)) {
>  			if (!strcmp(buf.buf, "--rerere-autoupdate"))
>  				opts->allow_rerere_auto = RERERE_AUTOUPDATE;
>  			else if (!strcmp(buf.buf, "--no-rerere-autoupdate"))
> @@ -2618,7 +2618,7 @@ static int read_populate_opts(struct replay_opts *opts)
>  		strbuf_release(&buf);
>  
>  		if (read_oneliner(&opts->current_fixups,
> -				  rebase_path_current_fixups(), 1)) {
> +				  rebase_path_current_fixups(), 1, 0)) {
>  			const char *p = opts->current_fixups.buf;
>  			opts->current_fixup_count = 1;
>  			while ((p = strchr(p, '\n'))) {
> @@ -2627,7 +2627,7 @@ static int read_populate_opts(struct replay_opts *opts)
>  			}
>  		}
>  
> -		if (read_oneliner(&buf, rebase_path_squash_onto(), 0)) {
> +		if (read_oneliner(&buf, rebase_path_squash_onto(), 0, 0)) {
>  			if (get_oid_hex(buf.buf, &opts->squash_onto) < 0)
>  				return error(_("unusable squash-onto"));
>  			opts->have_squash_onto = 1;
> @@ -3759,7 +3759,7 @@ static int apply_autostash(struct replay_opts *opts)
>  	struct child_process child = CHILD_PROCESS_INIT;
>  	int ret = 0;
>  
> -	if (!read_oneliner(&stash_sha1, rebase_path_autostash(), 1)) {
> +	if (!read_oneliner(&stash_sha1, rebase_path_autostash(), 1, 0)) {
>  		strbuf_release(&stash_sha1);
>  		return 0;
>  	}
> @@ -4093,7 +4093,7 @@ static int pick_commits(struct repository *r,
>  		if (todo_list->current < todo_list->nr)
>  			return 0;
>  
> -		if (read_oneliner(&head_ref, rebase_path_head_name(), 0) &&
> +		if (read_oneliner(&head_ref, rebase_path_head_name(), 0, 0) &&
>  				starts_with(head_ref.buf, "refs/")) {
>  			const char *msg;
>  			struct object_id head, orig;
> @@ -4106,13 +4106,13 @@ static int pick_commits(struct repository *r,
>  				strbuf_release(&buf);
>  				return res;
>  			}
> -			if (!read_oneliner(&buf, rebase_path_orig_head(), 0) ||
> +			if (!read_oneliner(&buf, rebase_path_orig_head(), 0, 0) ||
>  					get_oid_hex(buf.buf, &orig)) {
>  				res = error(_("could not read orig-head"));
>  				goto cleanup_head_ref;
>  			}
>  			strbuf_reset(&buf);
> -			if (!read_oneliner(&buf, rebase_path_onto(), 0)) {
> +			if (!read_oneliner(&buf, rebase_path_onto(), 0, 0)) {
>  				res = error(_("could not read 'onto'"));
>  				goto cleanup_head_ref;
>  			}
> @@ -4145,7 +4145,7 @@ static int pick_commits(struct repository *r,
>  				DIFF_FORMAT_DIFFSTAT;
>  			log_tree_opt.disable_stdin = 1;
>  
> -			if (read_oneliner(&buf, rebase_path_orig_head(), 0) &&
> +			if (read_oneliner(&buf, rebase_path_orig_head(), 0, 0) &&
>  			    !get_oid(buf.buf, &orig) &&
>  			    !get_oid("HEAD", &head)) {
>  				diff_tree_oid(&orig, &head, "",
> @@ -4230,7 +4230,7 @@ static int commit_staged_changes(struct repository *r,
>  
>  		if (get_oid("HEAD", &head))
>  			return error(_("cannot amend non-existing commit"));
> -		if (!read_oneliner(&rev, rebase_path_amend(), 0))
> +		if (!read_oneliner(&rev, rebase_path_amend(), 0, 0))
>  			return error(_("invalid file: '%s'"), rebase_path_amend());
>  		if (get_oid_hex(rev.buf, &to_amend))
>  			return error(_("invalid contents: '%s'"),
> @@ -4391,7 +4391,7 @@ int sequencer_continue(struct repository *r, struct replay_opts *opts)
>  		struct strbuf buf = STRBUF_INIT;
>  		struct object_id oid;
>  
> -		if (read_oneliner(&buf, rebase_path_stopped_sha(), 1) &&
> +		if (read_oneliner(&buf, rebase_path_stopped_sha(), 1, 0) &&
>  		    !get_oid_committish(buf.buf, &oid))
>  			record_in_rewritten(&oid, peek_command(&todo_list, 0));
>  		strbuf_release(&buf);
