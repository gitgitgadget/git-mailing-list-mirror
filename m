Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D6111F453
	for <e@80x24.org>; Fri, 19 Oct 2018 20:37:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726471AbeJTEpf (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 Oct 2018 00:45:35 -0400
Received: from mail-oi1-f202.google.com ([209.85.167.202]:51100 "EHLO
        mail-oi1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbeJTEpe (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Oct 2018 00:45:34 -0400
Received: by mail-oi1-f202.google.com with SMTP id l204-v6so23486569oia.17
        for <git@vger.kernel.org>; Fri, 19 Oct 2018 13:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=pTk+EBYCB22gAjxCqHEKl8YuG6o8zVBc1XEHpIxOFuw=;
        b=lh+2/OIeuGHt8/2n3XjBoPk9hI9odMI4wARrga023dfHwtbHdNrDmzom7NubDLoWhC
         /sgPdhDoPuXXA5+oX0MJbA1vL1VZMV07wo3nh+0IUVwfGqwxNFgm6+Inqbxxeq695f1w
         fbELnH1AkIiCDaysMmtCtmhTsYabuAN8q/GOOaNPDKit/E7tNAjb7yhN3u6M/w9PIAUp
         3yFly3hRfXb2Fi5Y8e1N+3MLPvQ5fc6xgu/jBMhirSbp9PwSzsdpLBPKu9lFUM/rYF3k
         1nSwGcPNpuM2K8JjorPJGmH7QmchqZGR8zO4Z8mdmA3SCd7kcL2ncsN0xF6sIEfoTTDw
         NlFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=pTk+EBYCB22gAjxCqHEKl8YuG6o8zVBc1XEHpIxOFuw=;
        b=q20k8zUVzYfsXrB+P/1Mjgp2ag/wepsmfkhdSBBNtvZrEnrvf9JEt2cint4e/1nY43
         2XyH4wIDSGHwLXom8DsV/NgByEXPjrBc+ifWY6emfLYlUWjvKotN67FgiPr4/cPgK5Qs
         KrhyFEtzXyiJjdE6QmCJl4/KO+3vn1m+lK+d/kOyjaYxDCNrHDIe6tbZavdUVTceBVtO
         8Fm1WOsoK9Q6ENKbNSI+sSa3VEnz8K/nqI35iHjZtnMRTI5LJ+2K49BMCuabYpM0MWTb
         aHoyji/Xl0/bOE6if85pXA1coAfSA6MDAR9ojXdoD1ZeFmAOyMt76vxYnQRq4FmGA37+
         DGaQ==
X-Gm-Message-State: ABuFfogyRI5k5ElrgTGXaQcaD34SJfU/HNXBj4kwRy8i/u1V9tr3Sted
        cDVPP+jB8MWzFeRVihQo323EryXhx+jy3fHPYC/I
X-Google-Smtp-Source: ACcGV61HDDrxixx8dLhoji8oW3jFoQNohNenxKwEVPxsWgu6EUGasZS5swnndCswNSnaDf28hFU4MFw+E1vJI1UACO06
X-Received: by 2002:a9d:524f:: with SMTP id q15mr28809194otg.15.1539981474268;
 Fri, 19 Oct 2018 13:37:54 -0700 (PDT)
Date:   Fri, 19 Oct 2018 13:37:50 -0700
In-Reply-To: <20181016233550.251311-19-sbeller@google.com>
Message-Id: <20181019203750.110741-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20181016233550.251311-19-sbeller@google.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: Re: [PATCH 18/19] submodule: use submodule repos for object lookup
From:   Jonathan Tan <jonathantanmy@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, jonathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> This converts the 'show_submodule_header' function to use
> the repository API properly, such that the submodule objects
> are not added to the main object store.

There is also a side effect in that the submodule now needs to pass all
the checks done by repo_init() instead of merely having  the "objects/"
directory. Can you add information about this to the commit message?

Also, which tests exercise this functionality? Mention them in the
commit message.

> +/*
> + * Initialize 'out' based on the provided submodule path.
> + *
> + * Unlike repo_submodule_init, this tolerates submodules not present
> + * in .gitmodules. This function exists only to preserve historical behavior,
> + *
> + * Returns 0 on success, -1 when the submodule is not present.
> + */
> +static int open_submodule(struct repository *out, const char *path)
> +{
> +	struct strbuf sb = STRBUF_INIT;
> +
> +	if (submodule_to_gitdir(&sb, path) || repo_init(out, sb.buf, NULL)) {
> +		strbuf_release(&sb);
> +		return -1;
> +	}
> +
> +	out->submodule_prefix = xstrdup(path);
> +	out->submodule_prefix = xstrfmt("%s%s/",
> +					the_repository->submodule_prefix ?
> +					the_repository->submodule_prefix :
> +					"", path);

You seem to say here [1] that we don't need submodule_prefix, but you're
instead setting it twice? :-)

[1] https://public-inbox.org/git/CAGZ79kZTxoNMUyX+EHg0q3Ss2M-Etkf0yiw3E40U3VCt4QMwrQ@mail.gmail.com/

> +/*
> + * Helper function to display the submodule header line prior to the full
> + * summary output.
> + *
> + * If it can locate the submodule git directory it will create a repository
> + * handle for the submodule and lookup both the left and right commits and
> + * put them into the left and right pointers.
>   */
> -static void show_submodule_header(struct diff_options *o, const char *path,
> +static void show_submodule_header(struct diff_options *o,
> +		const char *path,
>  		struct object_id *one, struct object_id *two,
>  		unsigned dirty_submodule,
> +		struct repository *sub,
>  		struct commit **left, struct commit **right,
>  		struct commit_list **merge_bases)
>  {

Location of the submodule git directory is done by the caller of this
function, not by this function. Also this function doesn't create any
repository handles. The documentation probably needs to be updated. Also
mention what happens if sub is NULL.

> @@ -563,16 +596,20 @@ void show_submodule_summary(struct diff_options *o, const char *path,
>  	struct rev_info rev;
>  	struct commit *left = NULL, *right = NULL;
>  	struct commit_list *merge_bases = NULL;
> +	struct repository subrepo, *sub = &subrepo;
> +
> +	if (open_submodule(&subrepo, path) < 0)
> +		sub = NULL;

Handling of the subrepo and *sub seems clumsy - it might be better to
just let open_submodule() return a struct repository pointer.

Previous 17 patches look good - most are the same as the previous
version, which I already was happy with, and I see that the patch I
requested in [2] was added.

[2] https://public-inbox.org/git/20181011221114.186377-1-jonathantanmy@google.com/
