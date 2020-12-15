Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1968BC4361B
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 11:15:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D670A22255
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 11:15:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbgLOLPE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Dec 2020 06:15:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728274AbgLOLOl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Dec 2020 06:14:41 -0500
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CF6FC06179C
        for <git@vger.kernel.org>; Tue, 15 Dec 2020 03:13:55 -0800 (PST)
Received: by mail-ed1-x542.google.com with SMTP id b2so20597310edm.3
        for <git@vger.kernel.org>; Tue, 15 Dec 2020 03:13:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Qako9tKu4kDKCvn9jLQ0KBWIlg+0fxCYnEQ9r+5q/28=;
        b=ojyvxU0oUaLI6jEFliiQB8q3Jcqe1a/Y6YGyBgO0PDxc8GHR8slTBXvpNQtaNVRoW6
         h0ejwB7tV3851sVgO0TpRnLoKK/dndjsZDY4s5zPgJAkz9YPvI5h2/LVcB6yxCXNWGUI
         /5NNBCTlfgvJqaEOeoRalzX8YeEfmcEhBXmptIKQoBvqlxh2W7Lg0sbi0Sr4bpSMusLu
         +0VygQOnLbxcAaXjNi3WpTVo6xUOJpel1V+viyYUCN2mIgru5S1EUMhWaptzXUod6iFl
         p9JC2S3Pjz5ChOSaCTPVmCmi1CH16ijNkyMS88jHC0MGQLP3xvVWo6i0JQGxG315ahsO
         FExQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:references:cc:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Qako9tKu4kDKCvn9jLQ0KBWIlg+0fxCYnEQ9r+5q/28=;
        b=FgxMUIeCUoMKjh+Umf2zm1FW8v2XX4IfTalw7jVQKTQz3ufI22TWPyz8Spw4yODDgn
         +KP0wOKZjrPfRJF278H5PjohQL6GCqvzx0cH6Ka9zrnGTClKg9PLv+m0jnhmmr5MtBeL
         ivVG4gJodgBeDR4V5wLucp4Lehem5jNHy3RulsOxOhHdc80vf4SorG8fk0uyX2RnT84h
         RlzakCP9A3YPeQ0SOj80W6qQYOCJ6Kt89fZVhthq9HSdcZX96sMVU2+yk0nRifkSckG5
         HG+AygQ3QzxHyeitU/Nt54gROSdqCGtDQckjG5/VJmtsZOsGH4VjouS8wSm6CxbnEyJO
         10bg==
X-Gm-Message-State: AOAM530c7wKWnqkAtbZGy3/6TGbO/5+EUiUI9oIbay5bq00n2+ZHPDW1
        XOVeY1ks95PlXL7cu+3BhXVO+TLhLVc=
X-Google-Smtp-Source: ABdhPJy2cm6JQvF7xEr5v6x1ReZB+Qt78cirui//K+exLVs/6bJw/FXxaydrx8RG87jc5GQfdlmBlA==
X-Received: by 2002:aa7:d74f:: with SMTP id a15mr29431928eds.344.1608030833900;
        Tue, 15 Dec 2020 03:13:53 -0800 (PST)
Received: from [192.168.1.240] (108.45.90.146.dyn.plus.net. [146.90.45.108])
        by smtp.gmail.com with ESMTPSA id m7sm1129709ejo.125.2020.12.15.03.13.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Dec 2020 03:13:53 -0800 (PST)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 1/1] mailmap: support hashed entries in mailmaps
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
References: <20201213010539.544101-1-sandals@crustytoothpaste.net>
 <20201213010539.544101-2-sandals@crustytoothpaste.net>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff King <peff@peff.net>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <d250435c-6f57-3c98-25f1-916269f13b7b@gmail.com>
Date:   Tue, 15 Dec 2020 11:13:51 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <20201213010539.544101-2-sandals@crustytoothpaste.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Brian

On 13/12/2020 01:05, brian m. carlson wrote:
> Many people, through the course of their lives, will change either a
> name or an email address.  For this reason, we have the mailmap, to map
> from a user's former name or email address to their current, canonical
> forms.  Normally, this works well as it is.
> 
> However, sometimes people change a name or an email address and wish to
> wholly disassociate themselves from that former name or email address.
> For example, a person may have left a company which engaged in a deeply
> unethical act with which the person does not want to be associated, or
> they may have changed their name to disassociate themselves from an
> abusive family or partner.

I think we should be clear in the documentation that by adding a hashed 
.mailmap entry people are still publicly associating their old identity 
with their new identity it's just that the association is obscured. They 
should not rely on it for their safety. An abusive partner knows the old 
identity so all they have to do to find the new identity is hash the old 
identity and see if it is in the .mailmap file.

Having said that I think this is a useful step forward in may cases.

Best Wishes

Phillip

> In such a case, using the former name or
> address in any way may be undesirable and the person may wish to replace
> it as completely as possible.
> 
> For projects which wish to support this, introduce hashed forms into the
> mailmap.  These forms, which start with "@sha256:" followed by a SHA-256
> hash of the entry, can be used in place of the form used in the commit
> field.  This form is intentionally designed to be unlikely to conflict
> with legitimate use cases.  For example, this is not a valid email
> address according to RFC 5322.  In the unlikely event that a user has
> put such a form into the actual commit as their name, we will accept it.
> 
> While the form of the data is designed to accept multiple hash
> algorithms, we intentionally do not support SHA-1.  There is little
> reason to support such a weak algorithm in new use cases and no
> backwards compatibility to consider.  Moreover, SHA-256 is faster than
> the SHA1DC implementation we use, so this not only improves performance,
> but simplifies the current implementation somewhat as well.
> 
> Note that it is, of course, possible to perform a lookup on all commit
> objects to determine the actual entry which matches the hashed form of
> the data.  However, a project for which this feature is valuable may
> simply insert entries for many contributors in order to make discovery
> of "interesting" entries significantly less convenient.
> 
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>   mailmap.c          | 39 +++++++++++++++++++++++++++++++++++++--
>   t/t4203-mailmap.sh | 35 +++++++++++++++++++++++++++++++++++
>   2 files changed, 72 insertions(+), 2 deletions(-)
> 
> diff --git a/mailmap.c b/mailmap.c
> index 962fd86d6d..09d0ad7ca4 100644
> --- a/mailmap.c
> +++ b/mailmap.c
> @@ -313,6 +313,41 @@ static struct string_list_item *lookup_prefix(struct string_list *map,
>   	return NULL;
>   }
>   
> +/*
> + * Convert an email or name into a hashed form for comparison.  The hashed form
> + * will be created in the form
> + * @sha256:c68b7a430ac8dee9676ec77a387194e23f234d024e03d844050cf6c01775c8f6,
> + * which would be the hashed form for "doe@example.com".
> + */
> +static char *hashed_form(struct strbuf *buf, const struct git_hash_algo *algop, const char *key, size_t keylen)
> +{
> +	git_hash_ctx ctx;
> +	unsigned char hashbuf[GIT_MAX_RAWSZ];
> +	char hexbuf[GIT_MAX_HEXSZ + 1];
> +
> +	algop->init_fn(&ctx);
> +	algop->update_fn(&ctx, key, keylen);
> +	algop->final_fn(hashbuf, &ctx);
> +	hash_to_hex_algop_r(hexbuf, hashbuf, algop);
> +
> +	strbuf_addf(buf, "@%s:%s", algop->name, hexbuf);
> +	return buf->buf;
> +}
> +
> +static struct string_list_item *lookup_one(struct string_list *map,
> +					   const char *string, size_t len)
> +{
> +	struct strbuf buf = STRBUF_INIT;
> +	struct string_list_item *item = lookup_prefix(map, string, len);
> +	if (item)
> +		return item;
> +
> +	hashed_form(&buf, &hash_algos[GIT_HASH_SHA256], string, len);
> +	item = lookup_prefix(map, buf.buf, buf.len);
> +	strbuf_release(&buf);
> +	return item;
> +}
> +
>   int map_user(struct string_list *map,
>   	     const char **email, size_t *emaillen,
>   	     const char **name, size_t *namelen)
> @@ -324,7 +359,7 @@ int map_user(struct string_list *map,
>   		 (int)*namelen, debug_str(*name),
>   		 (int)*emaillen, debug_str(*email));
>   
> -	item = lookup_prefix(map, *email, *emaillen);
> +	item = lookup_one(map, *email, *emaillen);
>   	if (item != NULL) {
>   		me = (struct mailmap_entry *)item->util;
>   		if (me->namemap.nr) {
> @@ -334,7 +369,7 @@ int map_user(struct string_list *map,
>   			 * simple entry.
>   			 */
>   			struct string_list_item *subitem;
> -			subitem = lookup_prefix(&me->namemap, *name, *namelen);
> +			subitem = lookup_one(&me->namemap, *name, *namelen);
>   			if (subitem)
>   				item = subitem;
>   		}
> diff --git a/t/t4203-mailmap.sh b/t/t4203-mailmap.sh
> index 586c3a86b1..794133ba5d 100755
> --- a/t/t4203-mailmap.sh
> +++ b/t/t4203-mailmap.sh
> @@ -62,6 +62,41 @@ test_expect_success 'check-mailmap --stdin arguments' '
>   	test_cmp expect actual
>   '
>   
> +test_expect_success 'hashed mailmap' '
> +	test_config mailmap.file ./hashed &&
> +	hashed_author_name="@sha256:$(printf "$GIT_AUTHOR_NAME" | test-tool sha256)" &&
> +	hashed_author_email="@sha256:$(printf "$GIT_AUTHOR_EMAIL" | test-tool sha256)" &&
> +	cat >expect <<-EOF &&
> +	$GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>
> +	EOF
> +
> +	cat >hashed <<-EOF &&
> +	$GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $hashed_author_name <$GIT_AUTHOR_EMAIL>
> +	EOF
> +	git check-mailmap  "$GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL>" >actual &&
> +	test_cmp expect actual &&
> +
> +	cat >hashed <<-EOF &&
> +	Wrong <wrong@example.org> $GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL>
> +	$GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $hashed_author_name <$GIT_AUTHOR_EMAIL>
> +	EOF
> +	# Check that we prefer literal matches over hashed names.
> +	git check-mailmap  "$hashed_author_name <$GIT_AUTHOR_EMAIL>" >actual &&
> +	test_cmp expect actual &&
> +
> +	cat >hashed <<-EOF &&
> +	$GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $hashed_author_name <$hashed_author_email>
> +	EOF
> +	git check-mailmap  "$GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL>" >actual &&
> +	test_cmp expect actual &&
> +
> +	cat >hashed <<-EOF &&
> +	$GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> <$hashed_author_email>
> +	EOF
> +	git check-mailmap  "$GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL>" >actual &&
> +	test_cmp expect actual
> +'
> +
>   test_expect_success 'check-mailmap bogus contact' '
>   	test_must_fail git check-mailmap bogus
>   '
> 
