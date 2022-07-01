Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB639C43334
	for <git@archiver.kernel.org>; Fri,  1 Jul 2022 01:30:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232505AbiGABa7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 21:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231982AbiGABa6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 21:30:58 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C98738BF5
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 18:30:57 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id y14so2431845qvs.10
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 18:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+deh4Oh+RXe1tyZVaGa3g/x9X3Mp6WmXIOUu+DXvKz4=;
        b=ZXccsmpMnWGFHm2BaXGADC6KK3qQDnvgshC0HZ/iPfjKEezfUz3C0Heyewjfz2058D
         1eUtfe937tXoi/u4x6nOsRe3sNEsxgQx4EOAUKIaOPyF5paQFlr/gE/DeEh55A3MfZHs
         YJeMGHdFxVYE1LSlJ+Ny6pXWumjhApCZYNQjLvbyldRyEQkK9EvsLDzHT4PFd+bTSoHp
         50DbY84tHiilbUS02h8vmZuN2h+uN7a24sKOfyGh88YjVWyTmNq6bw50+27//+SZ48uE
         PQnHDPcU+iQYJl6JHU2Me63eH+okoLhDxyBeQ4zJ6LmZtE530Ia8L2YXLPuRqZ+EseRH
         vRjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+deh4Oh+RXe1tyZVaGa3g/x9X3Mp6WmXIOUu+DXvKz4=;
        b=5Makf1rrEw683FjKoeLhBH+gqkCOKu+CK4Dh+NvmWrs02fbH0T+TtQIMjB41OLyitr
         meXz1pT0vXZe0OA/7jpJx6MAqj1ez8tYVcupI8iGTodW6eMYsg7k70BLWPz54eDPmXqh
         7nRQ3YP7QfeBu1MUQZQV8G5SfbeyPqe0E083CSjOZY9AOQYxqpcz2afm33olOsubcgp3
         LEmlH+421V9oViwnMm1QKi+XOmGielEPHxtKM/7L/ACycbo3cFyN3JWca03Ngwxghfy/
         sfv28Y+irQQn2G61kYzu+IU4WRKqqNcT6R2ZHJFvagXha6DqmVy073/2HI8tg/wRzWjv
         b+Qg==
X-Gm-Message-State: AJIora/6nHn4u3zRueu8kWbgwaaLI0/NsjaiEPmNOW7syCaBtipWhXWK
        huBSMl6KrvdaNDNwVT/Vc3m1Wg==
X-Google-Smtp-Source: AGRyM1uFd8gFmDYiPWB4S/GhWiDx/hw0yszc5G5M1BMbP1TCYUd2qpj50NKJZSIy6iTDclMceNp9Fw==
X-Received: by 2002:ac8:5e06:0:b0:317:ea59:60a7 with SMTP id h6-20020ac85e06000000b00317ea5960a7mr10715276qtx.534.1656639056116;
        Thu, 30 Jun 2022 18:30:56 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id n8-20020a05620a222800b006ab935c1563sm15623088qkh.8.2022.06.30.18.30.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 18:30:55 -0700 (PDT)
Date:   Thu, 30 Jun 2022 21:30:54 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Glen Choo via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Glen Choo <chooglen@google.com>
Subject: Re: [PATCH v6 5/5] setup.c: create `discovery.bare`
Message-ID: <Yr5OTq7s2qxxqsiY@nand.local>
References: <pull.1261.v5.git.git.1656354994.gitgitgadget@gmail.com>
 <pull.1261.v6.git.git.1656612839.gitgitgadget@gmail.com>
 <a1323d963f917df661a8701c305d84e781a8f550.1656612839.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a1323d963f917df661a8701c305d84e781a8f550.1656612839.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 30, 2022 at 06:13:59PM +0000, Glen Choo via GitGitGadget wrote:
> If we want to protect users from such attacks by default, neither value
> will suffice - "always" provides no protection, but "never" is
> impractical for bare repository users. A more usable default would be to
> allow only non-embedded bare repositories ([2] contains one such
> proposal), but detecting if a repository is embedded is potentially
> non-trivial, so this work is not implemented in this series.

I think that everything you said in your patch message makes sense, but
I appreciate this paragraph in particular. The historical record is
definitely important and worth preserving here, and I hope that it'll be
helpful to future readers who may wonder why the default wasn't chosen
as "never".

> [1]: https://lore.kernel.org/git/kl6lsfqpygsj.fsf@chooglen-macbookpro.roam.corp.google.com
> [2]: https://lore.kernel.org/git/5b969c5e-e802-c447-ad25-6acc0b784582@github.com
>
> Signed-off-by: Glen Choo <chooglen@google.com>
> ---
>  Documentation/config.txt           |  2 ++
>  Documentation/config/discovery.txt | 23 ++++++++++++
>  setup.c                            | 57 +++++++++++++++++++++++++++++-
>  t/t0035-discovery-bare.sh          | 52 +++++++++++++++++++++++++++
>  4 files changed, 133 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/config/discovery.txt
>  create mode 100755 t/t0035-discovery-bare.sh
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index e284b042f22..9a5e1329772 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -409,6 +409,8 @@ include::config/diff.txt[]
>
>  include::config/difftool.txt[]
>
> +include::config/discovery.txt[]
> +
>  include::config/extensions.txt[]
>
>  include::config/fastimport.txt[]
> diff --git a/Documentation/config/discovery.txt b/Documentation/config/discovery.txt
> new file mode 100644
> index 00000000000..bbcf89bb0b5
> --- /dev/null
> +++ b/Documentation/config/discovery.txt
> @@ -0,0 +1,23 @@
> +discovery.bare::
> +	Specifies whether Git will work with a bare repository that it
> +	found during repository discovery. If the repository is

Is it clear from the context what "discovery" means here? It's probably
easier to describe what it isn't, which you kind of do in the next
sentence. But it may be clearer to say something like:

    Specifies whether Git will recognize bare repositories that aren't
    specified via the top-level `--git-dir` command-line option, or the
    `GIT_DIR` environment variable (see linkgit:git[1]).

> +This defaults to `always`, but this default may change in the future.

I think the default being subject to change is par for the course. It's
probably easy enough to just say "Defaults to 'always'" and leave it at
that.

> ++
> +If you do not use bare repositories in your workflow, then it may be
> +beneficial to set `discovery.bare` to `never` in your global config.
> +This will protect you from attacks that involve cloning a repository
> +that contains a bare repository and running a Git command within that
> +directory.

I think we still don't have a great answer for people who trust some
bare repositories (e.g., known-embedded repositories that are used for
testing) but not others. To be clear, I think that is a fine point to
concede with this direction.

But we should be clear about that limitation by stating that Git does
not support the "I trust some bare repositories to be safely
discoverable but not others".

> +static enum discovery_bare_allowed get_discovery_bare(void)
> +{
> +	enum discovery_bare_allowed result = DISCOVERY_BARE_ALWAYS;
> +	git_protected_config(discovery_bare_cb, &result);
> +	return result;
> +}
> +
> +static const char *discovery_bare_allowed_to_string(
> +	enum discovery_bare_allowed discovery_bare_allowed)
> +{
> +	switch (discovery_bare_allowed) {
> +	case DISCOVERY_BARE_NEVER:
> +		return "never";
> +	case DISCOVERY_BARE_ALWAYS:
> +		return "always";

> +	default:
> +		BUG("invalid discovery_bare_allowed %d",
> +		    discovery_bare_allowed);

Should we have a default case here since the case arms above are
exhaustive?

> +	}
> +	return NULL;
> +}
> +
>  enum discovery_result {
>  	GIT_DIR_NONE = 0,
>  	GIT_DIR_EXPLICIT,
> @@ -1151,7 +1195,8 @@ enum discovery_result {
>  	GIT_DIR_HIT_CEILING = -1,
>  	GIT_DIR_HIT_MOUNT_POINT = -2,
>  	GIT_DIR_INVALID_GITFILE = -3,
> -	GIT_DIR_INVALID_OWNERSHIP = -4
> +	GIT_DIR_INVALID_OWNERSHIP = -4,
> +	GIT_DIR_DISALLOWED_BARE = -5,
>  };
>
>  /*
> @@ -1248,6 +1293,8 @@ static enum discovery_result setup_git_directory_gently_1(struct strbuf *dir,
>  		}
>
>  		if (is_git_directory(dir->buf)) {
> +			if (!get_discovery_bare())

Relying on NEVER being the zero value here seems fragile to me. Should
we check that `if (get_discovery_bare() == DISCOVERY_BARE_NEVER)` to be
more explicit here?

> +				return GIT_DIR_DISALLOWED_BARE;
>  			if (!ensure_valid_ownership(dir->buf))
>  				return GIT_DIR_INVALID_OWNERSHIP;
>  			strbuf_addstr(gitdir, ".");
> @@ -1394,6 +1441,14 @@ const char *setup_git_directory_gently(int *nongit_ok)
>  		}
>  		*nongit_ok = 1;
>  		break;
> +	case GIT_DIR_DISALLOWED_BARE:
> +		if (!nongit_ok) {
> +			die(_("cannot use bare repository '%s' (discovery.bare is '%s')"),
> +			    dir.buf,
> +			    discovery_bare_allowed_to_string(get_discovery_bare()));
> +		}
> +		*nongit_ok = 1;
> +		break;
>  	case GIT_DIR_NONE:
>  		/*
>  		 * As a safeguard against setup_git_directory_gently_1 returning

Thanks,
Taylor
