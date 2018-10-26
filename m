Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 622D21F453
	for <e@80x24.org>; Fri, 26 Oct 2018 19:26:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727809AbeJ0EEn (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Oct 2018 00:04:43 -0400
Received: from mail-vk1-f202.google.com ([209.85.221.202]:33385 "EHLO
        mail-vk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbeJ0EEn (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Oct 2018 00:04:43 -0400
Received: by mail-vk1-f202.google.com with SMTP id n129-v6so931046vke.0
        for <git@vger.kernel.org>; Fri, 26 Oct 2018 12:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ZS29xSFLSaUMkdk8wie1XpLpYCSSv5dVBB3hf6TkqUM=;
        b=ombJTBKBlpo87cSMQppFajfUMAD7MYKVReilm8bdYfGyQ9Q/+HdKZx8TJKy3/HJezY
         YpA/yWSxoSY/SslWwqcsZYIOI46yu+fRSzxVvaKnU7nl8RlOZ3Fa4q+6qZoMA2R6TN16
         djCUAvOuYRlivRUKBwbsx0fswVpALIprFWPIBb6IhkfowG2i9LGGFlU9sBWQ30DOkT7j
         /0A+r2659akVkghDEcSjAMM1v1xzMBGYTxfJpuDU5tG2rgmhFrDbgaTBAx7vmYCvaQGh
         PKGmppjwzTFW4JuoybaAIaJIEcpIczBM/W5NZZi/UN0XI/Y1C0xR/UIv1/vysYJyvdt9
         i/VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ZS29xSFLSaUMkdk8wie1XpLpYCSSv5dVBB3hf6TkqUM=;
        b=E3bU0qLYHKh0uYy4Zkv7xqXNV/X5EqzDq55a5KG8sfxyW8ZQCgeEc9+IYABlWlOET9
         oG+JuqOjnRiTZ4TEKS5RBp+p3u0YSaHwzv5XGLMcp2zji1zqNFAEJjz/dy/0rCq2j7+b
         Exq+cc/fY10g43IumYsV75cAP6Fsk77XjKiP07PfAj2xXB+ps7ewuSngm7EEuF1XRjQ8
         iK4jtHql/9LRYO2Q7KwImuIlTqsgT96gbNIFJW1vBJO2O3ywKznCkcxYfQnG/X1VI6h5
         QVLTAtk1yi7ACyHByVrxaLdtWtXHGLyg+dk5PQpp7uMsdQvWU3nHSd1UGrBSqeIuzNig
         +HTg==
X-Gm-Message-State: AGRZ1gK3BEH6PD1ruagwO7Feh/bZnYtD/Sd0mzH9O7jIKvtvGClwcyW7
        Qn0lj6wO4F6KaLCzqTVo9CR4Q28gKRVtbImVGeqR
X-Google-Smtp-Source: AJdET5d++hlfYPFrMKX18ueHi1dtbYsDZeM4iD+hlCtipRx9Wxl6qMdf4I0H8WDjUkkITTs4nUOcSO0Led8w0FdoTWa5
X-Received: by 2002:ab0:138e:: with SMTP id m14mr4377028uae.1.1540581985637;
 Fri, 26 Oct 2018 12:26:25 -0700 (PDT)
Date:   Fri, 26 Oct 2018 12:26:21 -0700
In-Reply-To: <20181025233231.102245-8-sbeller@google.com>
Message-Id: <20181026192621.111450-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20181025233231.102245-8-sbeller@google.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: Re: [PATCH 07/10] submodule: migrate get_next_submodule to use
 repository structs
From:   Jonathan Tan <jonathantanmy@google.com>
To:     sbeller@google.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> We used to recurse into submodules, even if they were broken having
> only an objects directory. The child process executed in the submodule
> would fail though if the submodule was broken.
> 
> This patch tightens the check upfront, such that we do not need
> to spawn a child process to find out if the submodule is broken.

Thanks for the clear commit message. Also mention which tests currently
exercise this.

> +static struct repository *get_submodule_repo_for(struct repository *r,
> +						 const struct submodule *sub)
> +{
> +	struct repository *ret = xmalloc(sizeof(*ret));
> +
> +	if (repo_submodule_init(ret, r, sub)) {
> +		/*
> +		 * No entry in .gitmodules? Technically not a submodule,
> +		 * but historically we supported repositories that happen to be
> +		 * in-place where a gitlink is. Keep supporting them.
> +		 */
> +		struct strbuf gitdir = STRBUF_INIT;
> +		strbuf_repo_worktree_path(&gitdir, r, "%s/.git", sub->path);
> +		if (repo_init(ret, gitdir.buf, NULL)) {
> +			strbuf_release(&gitdir);

You should also free ret here.

> +			return NULL;
> +		}
> +		strbuf_release(&gitdir);
> +	}
> +
> +	return ret;
> +}

The above is the rest of get_submodule_repo_for(), so that we can see
that gitdir is indeed freed.

> -		if (!git_dir)
> -			git_dir = submodule_git_dir.buf;
> -		if (is_directory(git_dir)) {
> +		repo = get_submodule_repo_for(spf->r, submodule);
> +		if (repo) {
>  			child_process_init(cp);
> -			cp->dir = strbuf_detach(&submodule_path, NULL);
>  			prepare_submodule_repo_env(&cp->env_array);
> +			cp->dir = xstrdup(repo->worktree);

Move the cp->dir one line up for a cleaner diff.

[snip]

> +			repo_clear(repo);
> +			free(repo);
>  			ret = 1;
> +		} else {
> +			/*
> +			 * An empty directory is normal,
> +			 * the submodule is not initialized
> +			 */
> +			if (S_ISGITLINK(ce->ce_mode) &&
> +			    !is_empty_dir(ce->name))
> +				die(_("Could not access submodule '%s'"), ce->name);

Previously, a failed fetch would just set spf->result = 1 (in
fetch_finish()), allowing other fetches to still proceed. This sounds
like a better idea to me instead of die-ing outright. (Also remember to
print a warning message - since we no longer spawn a child process to
try a fetch that will fail, we need to print a message ourselves.)
