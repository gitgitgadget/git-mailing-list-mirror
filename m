Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7383EC433E0
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 17:52:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3402564F01
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 17:52:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232782AbhCQRwB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 13:52:01 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:65532 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232838AbhCQRvp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 13:51:45 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8D2C6134672;
        Wed, 17 Mar 2021 13:51:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=yksvQD4noRLjshlJgDKF89TxNvs=; b=XXunQr
        vNbKLtkoQLKlPDw6iVDmeJn1x9TDJLHQMPocwRwdsXu0RnpmRvZY6R308Ogq+ux5
        gWzByHK5FHgxk8lViqKK2oqUwB6PAVzocPdKenSDGMfdftje7aSIcyreBZaHaaQk
        a0WTCbXP0e8qJGP70ztQY/npqsZdl/3fHjgPg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Hy6nTD2SmmyvUj7A11ryOj2TNvRPo0M4
        Jw8lafzzerMmPXsiukpzBMnCyxkQdR0f5aEQtgpJ1/1nUKZJLB43OuQ/Nc+IJB+a
        E8s7nJenKeKNj3NEywMKq7g8z247ORz4Sur08/B16QxcuklHgO9Dc5YjKNousmUT
        gLBZA1f57o0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 72BC7134671;
        Wed, 17 Mar 2021 13:51:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id BB4CA134670;
        Wed, 17 Mar 2021 13:51:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/7] builtin.h: ASCII-sort list of functions
References: <cover.1615856156.git.liu.denton@gmail.com>
        <aee5f6d1e2e123505c1e3b0b8ff952cce7de3436.1615856156.git.liu.denton@gmail.com>
Date:   Wed, 17 Mar 2021 10:51:38 -0700
In-Reply-To: <aee5f6d1e2e123505c1e3b0b8ff952cce7de3436.1615856156.git.liu.denton@gmail.com>
        (Denton Liu's message of "Mon, 15 Mar 2021 17:56:22 -0700")
Message-ID: <xmqqh7l9y8gl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6E4D00B8-8749-11EB-A5D7-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> ASCII sorting was chosen over strict alphabetical order for the same
> reason as 805d9eaf5e (Makefile: ASCII-sort += lists, 2020-03-21): the
> purpose of maintaining the sorted list is to ensure line insertions are
> deterministic. By using ASCII ordering, it is more easily mechanically
> reproducible in the future, such as by using :sort in Vim.

This happens to work only because '(' sorts way earlier than '_'.
Otherwise we'd probably be sorting with 'sort -t\( -k1' or something
like that.

I do not know if it worth mentioning, because it is unlikely that
the sort order between '(' and '_' would ever change ;-).

> This patch is best viewed with `--color-moved`.
>
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
>  builtin.h | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/builtin.h b/builtin.h
> index b6ce981b73..dd6beff6b2 100644
> --- a/builtin.h
> +++ b/builtin.h
> @@ -122,16 +122,16 @@ int cmd_branch(int argc, const char **argv, const char *prefix);
>  int cmd_bugreport(int argc, const char **argv, const char *prefix);
>  int cmd_bundle(int argc, const char **argv, const char *prefix);
>  int cmd_cat_file(int argc, const char **argv, const char *prefix);
> -int cmd_checkout(int argc, const char **argv, const char *prefix);
> -int cmd_checkout_index(int argc, const char **argv, const char *prefix);
>  int cmd_check_attr(int argc, const char **argv, const char *prefix);
>  int cmd_check_ignore(int argc, const char **argv, const char *prefix);
>  int cmd_check_mailmap(int argc, const char **argv, const char *prefix);
>  int cmd_check_ref_format(int argc, const char **argv, const char *prefix);
> +int cmd_checkout(int argc, const char **argv, const char *prefix);
> +int cmd_checkout_index(int argc, const char **argv, const char *prefix);
>  int cmd_cherry(int argc, const char **argv, const char *prefix);
>  int cmd_cherry_pick(int argc, const char **argv, const char *prefix);
> -int cmd_clone(int argc, const char **argv, const char *prefix);
>  int cmd_clean(int argc, const char **argv, const char *prefix);
> +int cmd_clone(int argc, const char **argv, const char *prefix);
>  int cmd_column(int argc, const char **argv, const char *prefix);
>  int cmd_commit(int argc, const char **argv, const char *prefix);
>  int cmd_commit_graph(int argc, const char **argv, const char *prefix);
> @@ -143,9 +143,9 @@ int cmd_credential_cache(int argc, const char **argv, const char *prefix);
>  int cmd_credential_cache_daemon(int argc, const char **argv, const char *prefix);
>  int cmd_credential_store(int argc, const char **argv, const char *prefix);
>  int cmd_describe(int argc, const char **argv, const char *prefix);
> +int cmd_diff(int argc, const char **argv, const char *prefix);
>  int cmd_diff_files(int argc, const char **argv, const char *prefix);
>  int cmd_diff_index(int argc, const char **argv, const char *prefix);
> -int cmd_diff(int argc, const char **argv, const char *prefix);
>  int cmd_diff_tree(int argc, const char **argv, const char *prefix);
>  int cmd_difftool(int argc, const char **argv, const char *prefix);
>  int cmd_env__helper(int argc, const char **argv, const char *prefix);
> @@ -169,16 +169,16 @@ int cmd_interpret_trailers(int argc, const char **argv, const char *prefix);
>  int cmd_log(int argc, const char **argv, const char *prefix);
>  int cmd_log_reflog(int argc, const char **argv, const char *prefix);
>  int cmd_ls_files(int argc, const char **argv, const char *prefix);
> -int cmd_ls_tree(int argc, const char **argv, const char *prefix);
>  int cmd_ls_remote(int argc, const char **argv, const char *prefix);
> +int cmd_ls_tree(int argc, const char **argv, const char *prefix);
>  int cmd_mailinfo(int argc, const char **argv, const char *prefix);
>  int cmd_mailsplit(int argc, const char **argv, const char *prefix);
>  int cmd_maintenance(int argc, const char **argv, const char *prefix);
>  int cmd_merge(int argc, const char **argv, const char *prefix);
>  int cmd_merge_base(int argc, const char **argv, const char *prefix);
> +int cmd_merge_file(int argc, const char **argv, const char *prefix);
>  int cmd_merge_index(int argc, const char **argv, const char *prefix);
>  int cmd_merge_ours(int argc, const char **argv, const char *prefix);
> -int cmd_merge_file(int argc, const char **argv, const char *prefix);
>  int cmd_merge_recursive(int argc, const char **argv, const char *prefix);
>  int cmd_merge_tree(int argc, const char **argv, const char *prefix);
>  int cmd_mktag(int argc, const char **argv, const char *prefix);
> @@ -189,6 +189,7 @@ int cmd_name_rev(int argc, const char **argv, const char *prefix);
>  int cmd_notes(int argc, const char **argv, const char *prefix);
>  int cmd_pack_objects(int argc, const char **argv, const char *prefix);
>  int cmd_pack_redundant(int argc, const char **argv, const char *prefix);
> +int cmd_pack_refs(int argc, const char **argv, const char *prefix);
>  int cmd_patch_id(int argc, const char **argv, const char *prefix);
>  int cmd_prune(int argc, const char **argv, const char *prefix);
>  int cmd_prune_packed(int argc, const char **argv, const char *prefix);
> @@ -204,6 +205,7 @@ int cmd_remote(int argc, const char **argv, const char *prefix);
>  int cmd_remote_ext(int argc, const char **argv, const char *prefix);
>  int cmd_remote_fd(int argc, const char **argv, const char *prefix);
>  int cmd_repack(int argc, const char **argv, const char *prefix);
> +int cmd_replace(int argc, const char **argv, const char *prefix);
>  int cmd_rerere(int argc, const char **argv, const char *prefix);
>  int cmd_reset(int argc, const char **argv, const char *prefix);
>  int cmd_restore(int argc, const char **argv, const char *prefix);
> @@ -216,9 +218,10 @@ int cmd_shortlog(int argc, const char **argv, const char *prefix);
>  int cmd_show(int argc, const char **argv, const char *prefix);
>  int cmd_show_branch(int argc, const char **argv, const char *prefix);
>  int cmd_show_index(int argc, const char **argv, const char *prefix);
> +int cmd_show_ref(int argc, const char **argv, const char *prefix);
>  int cmd_sparse_checkout(int argc, const char **argv, const char *prefix);
> -int cmd_status(int argc, const char **argv, const char *prefix);
>  int cmd_stash(int argc, const char **argv, const char *prefix);
> +int cmd_status(int argc, const char **argv, const char *prefix);
>  int cmd_stripspace(int argc, const char **argv, const char *prefix);
>  int cmd_submodule__helper(int argc, const char **argv, const char *prefix);
>  int cmd_switch(int argc, const char **argv, const char *prefix);
> @@ -235,14 +238,11 @@ int cmd_upload_archive_writer(int argc, const char **argv, const char *prefix);
>  int cmd_upload_pack(int argc, const char **argv, const char *prefix);
>  int cmd_var(int argc, const char **argv, const char *prefix);
>  int cmd_verify_commit(int argc, const char **argv, const char *prefix);
> +int cmd_verify_pack(int argc, const char **argv, const char *prefix);
>  int cmd_verify_tag(int argc, const char **argv, const char *prefix);
>  int cmd_version(int argc, const char **argv, const char *prefix);
>  int cmd_whatchanged(int argc, const char **argv, const char *prefix);
>  int cmd_worktree(int argc, const char **argv, const char *prefix);
>  int cmd_write_tree(int argc, const char **argv, const char *prefix);
> -int cmd_verify_pack(int argc, const char **argv, const char *prefix);
> -int cmd_show_ref(int argc, const char **argv, const char *prefix);
> -int cmd_pack_refs(int argc, const char **argv, const char *prefix);
> -int cmd_replace(int argc, const char **argv, const char *prefix);
>  
>  #endif
