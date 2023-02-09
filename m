Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 744A4C636CC
	for <git@archiver.kernel.org>; Thu,  9 Feb 2023 00:29:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbjBIA3M (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Feb 2023 19:29:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230360AbjBIA3K (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2023 19:29:10 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29D8221A09
        for <git@vger.kernel.org>; Wed,  8 Feb 2023 16:29:09 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id ml19so1992274ejb.0
        for <git@vger.kernel.org>; Wed, 08 Feb 2023 16:29:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Qs1Xh9XIxKNWxPkUamKZaF5hkZKsabEROICxoiMmTz0=;
        b=phn2gTpo4uzUZsD93uPyfxCSehVCYuqfiyikppeqBGUbsAHyR+oldBue/7HncQgHyu
         UGdcoNJ9Z/AtxB9uDh/9zZXXhUA9mJHvbr147PYL7nWSuOYK9BfCWNtwxJj6N+ThXuOB
         7IzBg2ARwje8Ze+o+LDamv7jIMJmBftA/nNX9PVkigdNiFv9bbBZKfWmKeNNTKNYewY1
         J/aVL0wVVlNtA4mGmQFqsC8lPC4cTUm8BRLby5WXDxLM4Es6Z/ZQMLbxCpA610dNIOZu
         hqzfn/bcNxL7KvAglu/RQZE8W7aqNFtORznE8r4f1utnRNBup2tH9QBS4dJA2jbzYHdp
         CnNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qs1Xh9XIxKNWxPkUamKZaF5hkZKsabEROICxoiMmTz0=;
        b=Y/qao/kWphToLY+fDGPmxeF8PZqnSOVaNeSunwIv9THsNIBTdcxeFJ1s9l4LzinYKB
         ybLjNNsPyJQRTEcLOwYgwz8byvFSYeb/r38Tlfeq3lq5Mw28GuLG8l3TN73S0xSe1SzC
         SOxVEg0DFA9T96T31cDMTh9TBXrxhlVE+GTl7S+lv56AIaTsDasWBss53Gbljq+cZ6mx
         mytskD4NcZMsiethrzsOii6QFZ/R7mg3ux4bLw3KmtZwcSExnlk07NwWrzxJLIDM226A
         ZbHP7dUTg109NY5qAqZmF077AKxLi/iDAwjTlzpb0iQxATELza7YtWUq2eOqZbPaND8Y
         tkMA==
X-Gm-Message-State: AO0yUKWb34drakR4z28a11wJKYMQpP314gChCqD5gTLLQRPz7UvJB0rT
        z+Mla4Ms9zEIRlqDHKNzUY4YVws4CtBNgCi+
X-Google-Smtp-Source: AK7set+p4va70mz7ZWaYMxuznHL1J1KWTcGN3rGJ/F8JUtZBJCZK3LtJcZuaZGC/TpqKq/+ezDP7gw==
X-Received: by 2002:a17:907:1686:b0:844:79b1:ab36 with SMTP id hc6-20020a170907168600b0084479b1ab36mr7112295ejc.25.1675902547582;
        Wed, 08 Feb 2023 16:29:07 -0800 (PST)
Received: from gmgdl ([81.191.238.7])
        by smtp.gmail.com with ESMTPSA id lo24-20020a170906fa1800b0088a694749f7sm150591ejb.4.2023.02.08.16.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 16:29:07 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pPuoE-001YWE-1R;
        Thu, 09 Feb 2023 01:29:06 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Max Gautier <max.gautier@redhat.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH] gpg-interface: lazily initialize and read the
 configuration
Date:   Thu, 09 Feb 2023 01:17:39 +0100
References: <Y+PGRaiTTaZ/DtlJ@work-laptop-max>
 <Y+PRTYtFDoE73XEM@coredump.intra.peff.net> <xmqqmt5orqgv.fsf@gitster.g>
 <xmqqh6vwrpce.fsf@gitster.g> <xmqqlel7rj9z.fsf_-_@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <xmqqlel7rj9z.fsf_-_@gitster.g>
Message-ID: <230209.86fsbfznot.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Feb 08 2023, Junio C Hamano wrote:

> Instead of forcing the porcelain commands to always read the
> configuration variables related to the signing and verifying
> signatures, lazily initialize the necessary subsystem on demand upon
> the first use.
>
> This hopefully would make it more future-proof as we do not have to
> think and decide whether we should call git_gpg_config() in the
> git_config() callback for each command.

One thing left un-noted here is that this will defer any errors in the
config now until use (or lazy init), so e.g.:

	git -c gpg.mintrustlevel=bad show --show-signature

Used to exit with code 128 and an error, but will now (at least for me)
proceed to run show successfully.

I think that's OK overall, and most of our config reading these days
works like that, but it's probably worth noting.

> Quite a many git_config() callback functions that used to be custom
> callbacks are now just a thin wrapper around git_default_config().
> We could further remove, git_FOO_config and replace calls to
> git_config(git_FOO_config) with git_config(git_default_config), but
> to make it clear which ones are affected and the effect is only the
> removal of git_gpg_config(), it is vastly preferred not to do such a
> change in this step (they can be done on top once the dust settled).

Yeah, we could do that later, but I think it's trivially easy to see
which ones would be affected, i.e. these...

> diff --git c/builtin/am.c w/builtin/am.c
> index 82a41cbfc4..40126b59c5 100644
> --- c/builtin/am.c
> +++ w/builtin/am.c
> @@ -2314,12 +2314,6 @@ static int parse_opt_show_current_patch(const struct option *opt, const char *ar
>  
>  static int git_am_config(const char *k, const char *v, void *cb UNUSED)
>  {
> -	int status;
> -
> -	status = git_gpg_config(k, v, NULL);
> -	if (status)
> -		return status;
> -
>  	return git_default_config(k, v, NULL);
>  }
>  
> diff --git c/builtin/commit-tree.c w/builtin/commit-tree.c
> index cc8d584be2..f6a099d601 100644
> --- c/builtin/commit-tree.c
> +++ w/builtin/commit-tree.c
> @@ -39,9 +39,6 @@ static void new_parent(struct commit *parent, struct commit_list **parents_p)
>  
>  static int commit_tree_config(const char *var, const char *value, void *cb)
>  {
> -	int status = git_gpg_config(var, value, NULL);
> -	if (status)
> -		return status;
>  	return git_default_config(var, value, cb);
>  }

...but not a bunch of elided ones here, and then these...

> diff --git c/builtin/verify-commit.c w/builtin/verify-commit.c
> index 3ebad32b0f..3c5d0b024c 100644
> --- c/builtin/verify-commit.c
> +++ w/builtin/verify-commit.c
> @@ -54,9 +54,6 @@ static int verify_commit(const char *name, unsigned flags)
>  
>  static int git_verify_commit_config(const char *var, const char *value, void *cb)
>  {
> -	int status = git_gpg_config(var, value, cb);
> -	if (status)
> -		return status;
>  	return git_default_config(var, value, cb);
>  }
>  
> diff --git c/builtin/verify-tag.c w/builtin/verify-tag.c
> index 217566952d..ecffb069bf 100644
> --- c/builtin/verify-tag.c
> +++ w/builtin/verify-tag.c
> @@ -21,9 +21,6 @@ static const char * const verify_tag_usage[] = {
>  
>  static int git_verify_tag_config(const char *var, const char *value, void *cb)
>  {
> -	int status = git_gpg_config(var, value, cb);
> -	if (status)
> -		return status;
>  	return git_default_config(var, value, cb);
>  }

...we can see are now just git_default_config() by another name. I'd
prefer to just see them gone in this same commit.

> @@ -632,6 +644,8 @@ int check_signature(struct signature_check *sigc,
>  	struct gpg_format *fmt;
>  	int status;
>  
> +	gpg_interface_lazy_init();
> +
>  	sigc->result = 'N';
>  	sigc->trust_level = -1;
>  

This is needed, because we need "configured_min_trust_level" populated.

> @@ -695,11 +709,13 @@ int parse_signature(const char *buf, size_t size, struct strbuf *payload, struct
>  
>  void set_signing_key(const char *key)
>  {
> +	gpg_interface_lazy_init();
> +
>  	free(configured_signing_key);
>  	configured_signing_key = xstrdup(key);
>  }

But this is not, we could say that we're doing it for good measure, but
it's hard to imagine a scenario where we would end up actually needing
lazy init here. we'll just set a variable here, which...

> -int git_gpg_config(const char *var, const char *value, void *cb UNUSED)
> +static int git_gpg_config(const char *var, const char *value, void *cb UNUSED)
>  {
>  	struct gpg_format *fmt = NULL;
>  	char *fmtname = NULL;
> @@ -888,6 +904,8 @@ static const char *get_ssh_key_id(void) {
>  /* Returns a textual but unique representation of the signing key */
>  const char *get_signing_key_id(void)
>  {
> +	gpg_interface_lazy_init();
> +

...we'll read back here, and here the lazy init is needed, because...

>  	if (use_format->get_key_id) {

...this is one of the lazy init'd variables.

>  		return use_format->get_key_id();
>  	}
> @@ -898,6 +916,8 @@ const char *get_signing_key_id(void)
>  
>  const char *get_signing_key(void)
>  {
> +	gpg_interface_lazy_init();
> +

ditto, this is needed.

>  	if (configured_signing_key)
>  		return configured_signing_key;
>  	if (use_format->get_default_key) {
> @@ -923,6 +943,8 @@ const char *gpg_trust_level_to_str(enum signature_trust_level level)
>  
>  int sign_buffer(struct strbuf *buffer, struct strbuf *signature, const char *signing_key)
>  {
> +	gpg_interface_lazy_init();
> +

and this.
