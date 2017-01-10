Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 916CF20756
	for <e@80x24.org>; Tue, 10 Jan 2017 20:41:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751360AbdAJUlg (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jan 2017 15:41:36 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63237 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750701AbdAJUlf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jan 2017 15:41:35 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BAE615E3A9;
        Tue, 10 Jan 2017 15:41:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=NfeOvBnhvueTyfv3hvSlxW1tDDo=; b=glO0QM
        eEErqmOZGxisvWLyD3FNDQrHYFH3jlXa/afQVfW1W8W9fk8v7hj6KBSMgqgCaE/q
        OGX7IrG0hZNmSG0GP8BdjH2HN0BSIs6YjKBKNmFw3xqdnHt9JhS87X+EahdYbsuu
        ci0D2cqSfKMGue2ohHUDAE8C/zmNHYQF8+/5s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=NvwqM25XDlVIoKyIqtacSx2wiJHFJdxC
        1lcdew2VOT8tAaQt70r6T8YdHl9XWKKG0AzQkcb1pYYgxs+MPmMDkkABXyZ6eXKA
        5IgwZ1jKuh+wIt+OLlo1IwftG+OUfnKOlsJ9NuM1zUnghLal4apKBh1eK1GEVUwy
        SYoEo/dRrRI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A1A085E3A8;
        Tue, 10 Jan 2017 15:41:33 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 106325E3A5;
        Tue, 10 Jan 2017 15:41:32 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     bmwill@google.com, novalis@novalis.org, git@vger.kernel.org
Subject: Re: [PATCH 1/4] read-tree: use OPT_BOOL instead of OPT_SET_INT
References: <20170110014542.19352-1-sbeller@google.com>
        <20170110014542.19352-2-sbeller@google.com>
Date:   Tue, 10 Jan 2017 12:41:31 -0800
In-Reply-To: <20170110014542.19352-2-sbeller@google.com> (Stefan Beller's
        message of "Mon, 9 Jan 2017 17:45:39 -0800")
Message-ID: <xmqqmveyr6kk.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2C02192E-D775-11E6-A882-FE3F13518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> All occurrences of OPT_SET_INT were setting the value to 1;
> internally OPT_BOOL is just that.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  builtin/read-tree.c | 36 ++++++++++++++++++------------------
>  1 file changed, 18 insertions(+), 18 deletions(-)

The result is much easier to read, partly because the "1" (true) is
at the very end of the line when OPT_SET_INT() is used for the
reader to notice that this is merely a boolean.

More importantly, as OPT_SET_INT() can be used multiple times on the
same variable (or field) to set it to different values, it is easier
to read if OPT_BOOL() is used when OPT_SET_INT() to 1 is not used
for that purpose.

Thanks.

>> diff --git a/builtin/read-tree.c b/builtin/read-tree.c
> index fa6edb35b2..8ba64bc785 100644
> --- a/builtin/read-tree.c
> +++ b/builtin/read-tree.c
> @@ -109,34 +109,34 @@ int cmd_read_tree(int argc, const char **argv, const char *unused_prefix)
>  		{ OPTION_CALLBACK, 0, "index-output", NULL, N_("file"),
>  		  N_("write resulting index to <file>"),
>  		  PARSE_OPT_NONEG, index_output_cb },
> -		OPT_SET_INT(0, "empty", &read_empty,
> -			    N_("only empty the index"), 1),
> +		OPT_BOOL(0, "empty", &read_empty,
> +			    N_("only empty the index")),
>  		OPT__VERBOSE(&opts.verbose_update, N_("be verbose")),
>  		OPT_GROUP(N_("Merging")),
> -		OPT_SET_INT('m', NULL, &opts.merge,
> -			    N_("perform a merge in addition to a read"), 1),
> -		OPT_SET_INT(0, "trivial", &opts.trivial_merges_only,
> -			    N_("3-way merge if no file level merging required"), 1),
> -		OPT_SET_INT(0, "aggressive", &opts.aggressive,
> -			    N_("3-way merge in presence of adds and removes"), 1),
> -		OPT_SET_INT(0, "reset", &opts.reset,
> -			    N_("same as -m, but discard unmerged entries"), 1),
> +		OPT_BOOL('m', NULL, &opts.merge,
> +			 N_("perform a merge in addition to a read")),
> +		OPT_BOOL(0, "trivial", &opts.trivial_merges_only,
> +			 N_("3-way merge if no file level merging required")),
> +		OPT_BOOL(0, "aggressive", &opts.aggressive,
> +			 N_("3-way merge in presence of adds and removes")),
> +		OPT_BOOL(0, "reset", &opts.reset,
> +			 N_("same as -m, but discard unmerged entries")),
>  		{ OPTION_STRING, 0, "prefix", &opts.prefix, N_("<subdirectory>/"),
>  		  N_("read the tree into the index under <subdirectory>/"),
>  		  PARSE_OPT_NONEG | PARSE_OPT_LITERAL_ARGHELP },
> -		OPT_SET_INT('u', NULL, &opts.update,
> -			    N_("update working tree with merge result"), 1),
> +		OPT_BOOL('u', NULL, &opts.update,
> +			 N_("update working tree with merge result")),
>  		{ OPTION_CALLBACK, 0, "exclude-per-directory", &opts,
>  		  N_("gitignore"),
>  		  N_("allow explicitly ignored files to be overwritten"),
>  		  PARSE_OPT_NONEG, exclude_per_directory_cb },
> -		OPT_SET_INT('i', NULL, &opts.index_only,
> -			    N_("don't check the working tree after merging"), 1),
> +		OPT_BOOL('i', NULL, &opts.index_only,
> +			 N_("don't check the working tree after merging")),
>  		OPT__DRY_RUN(&opts.dry_run, N_("don't update the index or the work tree")),
> -		OPT_SET_INT(0, "no-sparse-checkout", &opts.skip_sparse_checkout,
> -			    N_("skip applying sparse checkout filter"), 1),
> -		OPT_SET_INT(0, "debug-unpack", &opts.debug_unpack,
> -			    N_("debug unpack-trees"), 1),
> +		OPT_BOOL(0, "no-sparse-checkout", &opts.skip_sparse_checkout,
> +			 N_("skip applying sparse checkout filter")),
> +		OPT_BOOL(0, "debug-unpack", &opts.debug_unpack,
> +			 N_("debug unpack-trees")),
>  		OPT_END()
>  	};
