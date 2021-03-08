Return-Path: <SRS0=iBdC=IG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B209CC433E0
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 12:56:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 609C4651C3
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 12:56:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbhCHMzx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Mar 2021 07:55:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbhCHMzh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Mar 2021 07:55:37 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35FC0C06174A
        for <git@vger.kernel.org>; Mon,  8 Mar 2021 04:55:37 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id p8so20163417ejb.10
        for <git@vger.kernel.org>; Mon, 08 Mar 2021 04:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=jYj75PL4LdG3au1oTTUFeKpvwfCqN1gHcCeJUBMogiA=;
        b=do6MzEigSYyiQjOy0OpXMOasLWcO1NA5E0xyQE/Uxvoo87el0ZUGCvSPS+bagOhj8k
         grJE1MRz2VhnR8rX/LgsCEV28WnS5zHf/2WDqIuGpuzUpCkah55jN7EofSnLjYRmGjDO
         CWfaJ+F5d2VLPLA/9gdiEgm65I21xTcx1I04qcrAjDJYq5Sdw/QG59at04l3UmG/DVR8
         2RUUZOWLQWEQMhUq5pF1L6ysdXO4i9NlaWGPtk51zTOqEJ+8NFpnWiqK466DEXo6xJoh
         +C5ncPzTFsJHKDK57dByvjTZhPXgQtpDkZioK1c4LviGNb2KjImFIiULT3g54f/QAbiv
         um4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=jYj75PL4LdG3au1oTTUFeKpvwfCqN1gHcCeJUBMogiA=;
        b=FuwHcWLJwR+XUIPwt9oUas+frQU57COiVCbjBLYeJdY8pk376qugp6caVi+UMBe/zK
         U7R1zBUzqjSCJ0WePNdiNdvK9U5Fib5ojynzgSYHioiNj4trOr4AnAas0K50SDIg+Onj
         1jqI1zI10Cd7vWQcC7UsZG9M2M7TVbEBvbAiafrM6Hh6Fnkqq6DtYYjn7yr08s62Jh4X
         wnIhrqcJorQa/H8jZI0JfH9qMWKfEUYo/hRlhMsBo2qUAIqFf+KxobeGnl3jNnTIefB3
         +0dnMkcqCKpysYR9pzYn0aR0Eb5HwPKITNRV1acBbfLLwPukyXMQ6+IuGJM/VHUGbRok
         oHQg==
X-Gm-Message-State: AOAM530g3MlFa3lXV+HOk+gkF+9bABj28S58UiLJYxux58fp2fp4zNL3
        Z9U4m/bOmsLW4MA5gANluMhY9G9DZOthMg==
X-Google-Smtp-Source: ABdhPJzbA7GmGspNb2E3GUeTevQxohpCTt1HutpjXnoJxo3nMy5/ZUMIgptL/A2CHWEwVSy22U5dOg==
X-Received: by 2002:a17:906:1444:: with SMTP id q4mr9504526ejc.343.1615208135584;
        Mon, 08 Mar 2021 04:55:35 -0800 (PST)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id v25sm7028367edr.18.2021.03.08.04.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 04:55:35 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 05/11] merge-ort: let renormalization change
 modify/delete into clean delete
References: <pull.973.git.git.1614905738.gitgitgadget@gmail.com>
 <b70ef4d7000a1d83b1588a9be1e8f4273a382cc7.1614905738.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <b70ef4d7000a1d83b1588a9be1e8f4273a382cc7.1614905738.git.gitgitgadget@gmail.com>
Date:   Mon, 08 Mar 2021 13:55:34 +0100
Message-ID: <877dmhkdo9.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Mar 05 2021, Elijah Newren via GitGitGadget wrote:

> From: Elijah Newren <newren@gmail.com>
>
> When we have a modify/delete conflict, but the only change to the
> modification is e.g. change of line endings, then if renormalization is
> requested then we should be able to recognize such a case as a
> not-modified/delete and resolve the conflict automatically.
>
> This fixes t6418.10 under GIT_TEST_MERGE_ALGORITHM=ort.
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  merge-ort.c | 63 +++++++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 61 insertions(+), 2 deletions(-)
>
> diff --git a/merge-ort.c b/merge-ort.c
> index 87c553c0882c..c4bd88b9d3db 100644
> --- a/merge-ort.c
> +++ b/merge-ort.c
> @@ -2416,6 +2416,60 @@ static int string_list_df_name_compare(const char *one, const char *two)
>  	return onelen - twolen;
>  }
>  
> +static int read_oid_strbuf(struct merge_options *opt,
> +			   const struct object_id *oid,
> +			   struct strbuf *dst)
> +{
> +	void *buf;
> +	enum object_type type;
> +	unsigned long size;
> +	buf = read_object_file(oid, &type, &size);
> +	if (!buf)
> +		return err(opt, _("cannot read object %s"), oid_to_hex(oid));
> +	if (type != OBJ_BLOB) {
> +		free(buf);
> +		return err(opt, _("object %s is not a blob"), oid_to_hex(oid));

As an aside I've got another series I'll submit soon which refactors all
these "object is not xyz" calls to a utility function, so in this case
we'd also say what it was other than a blob.

Fine to keep this here, just a #leftoverbits note to myself to
eventually migrate this.

> +	}
> +	strbuf_attach(dst, buf, size, size + 1);
> +	return 0;
> +}
> +
> +static int blob_unchanged(struct merge_options *opt,
> +			  const struct version_info *base,
> +			  const struct version_info *side,
> +			  const char *path)
> +{
> +	struct strbuf basebuf = STRBUF_INIT;
> +	struct strbuf sidebuf = STRBUF_INIT;
> +	int ret = 0; /* assume changed for safety */
> +	const struct index_state *idx = &opt->priv->attr_index;
> +
> +	initialize_attr_index(opt);
> +
> +	if (base->mode != side->mode)
> +		return 0;
> +	if (oideq(&base->oid, &side->oid))
> +		return 1;
> +
> +	if (read_oid_strbuf(opt, &base->oid, &basebuf) ||
> +	    read_oid_strbuf(opt, &side->oid, &sidebuf))
> +		goto error_return;
> +	/*
> +	 * Note: binary | is used so that both renormalizations are
> +	 * performed.  Comparison can be skipped if both files are
> +	 * unchanged since their sha1s have already been compared.
> +	 */
> +	if (renormalize_buffer(idx, path, basebuf.buf, basebuf.len, &basebuf) |
> +	    renormalize_buffer(idx, path, sidebuf.buf, sidebuf.len, &sidebuf))
> +		ret = (basebuf.len == sidebuf.len &&
> +		       !memcmp(basebuf.buf, sidebuf.buf, basebuf.len));
> +
> +error_return:
> +	strbuf_release(&basebuf);
> +	strbuf_release(&sidebuf);
> +	return ret;
> +}
> +
>
>  struct directory_versions {
>  	/*
>  	 * versions: list of (basename -> version_info)
> @@ -3003,8 +3057,13 @@ static void process_entry(struct merge_options *opt,
>  		modify_branch = (side == 1) ? opt->branch1 : opt->branch2;
>  		delete_branch = (side == 1) ? opt->branch2 : opt->branch1;
>  
> -		if (ci->path_conflict &&
> -		    oideq(&ci->stages[0].oid, &ci->stages[side].oid)) {
> +		if (opt->renormalize &&
> +		    blob_unchanged(opt, &ci->stages[0], &ci->stages[side],
> +				   path)) {
> +			ci->merged.is_null = 1;
> +			ci->merged.clean = 1;
> +		} else if (ci->path_conflict &&
> +			   oideq(&ci->stages[0].oid, &ci->stages[side].oid)) {

Small note (no need for re-roll or whatever) on having read a bit of
merge-ort.c code recently: I'd find this thing a bit easier on the eyes
if ci->stages[0] and ci->stages[side] were split into a variable before
the if/else, i.e. used as "side_0.oid and side_n.oid" and "side_0 and
side_n" in this case..

That would also avoid the wrapping of at least one argument list here.
