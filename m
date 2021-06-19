Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73131C48BDF
	for <git@archiver.kernel.org>; Sat, 19 Jun 2021 02:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4839E6100A
	for <git@archiver.kernel.org>; Sat, 19 Jun 2021 02:12:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234001AbhFSCPE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Jun 2021 22:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbhFSCPD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jun 2021 22:15:03 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1CDEC061574
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 19:12:53 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id ji1so12610739ejc.4
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 19:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eL+ivea0VzrnUWcPtI6LmjHUzskXlvuOzPdBpcnuxO0=;
        b=JVvHZUHhsmxjrzUZTkFpxj82aESytpa09p6RhX7ImBb9DvNS1qWcZpsHl+8nzF8Ef5
         oi2cZFNyipGnT8vgU5XYweAw5D2BXjlkBkEUWJoSVc6xgtVYgZeTepUxqvHQJJEOLmH8
         JT84AfjIDAHGfckiuzEkAqyyrTsJMiNk4wjPLx1tisfrVfihKdivRvoveI4m8zwISZ76
         pBNVHgscZz/OqpccyHvBW4WbCwhj2qDqF5r3mpaMasQ6ScAv8eWQSFMGqq2c49Z8BlqF
         8dgRY2c8VopuF3ywWjWT8rYeFOKy2TT49msBqjEK+HZUvXT0pkMFMtYlI2Rj/oTXS1ov
         iPnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eL+ivea0VzrnUWcPtI6LmjHUzskXlvuOzPdBpcnuxO0=;
        b=XkqTavy5dmK2uPQLlSVYUVzrNY71Rf+W5s+nhOnOmsx78xcnfGh7d/7hZByle2MvHv
         NqHH5QMChcdTjQRWJlWhDBufkaCFIg7r5+Dcn330w4T1EGvCDJ2S9B1pY9Nx3FUBODei
         SYFtYhBxL7rsYekU8ocs+4ifjVLf1Iw3/xwMCKCu6RyTaTTeXU27MpYSCYaRfMhbXXmX
         mmlL4nilx2KNeRq4oaC642bVgS8o8ndwWj/4C9KurJikM2UpJ9WT0XJwWeUVQn9XKbvy
         DPe9AraRl1RAAWqZD7keOvGNOry7A4FVuK1tYyuX3S1nhiOtfHkiDGQfVXCD0xfPZX1J
         6Tfw==
X-Gm-Message-State: AOAM531enI2dNy+4NAtWkj/+oifEEkiECTYwtb+UM3g5nCRq3jjL/foB
        1o1z6Hm/4OF7JYbE5MFAwv8=
X-Google-Smtp-Source: ABdhPJzc+8K1/MclqLNrAQE2YazLAXVAax9WDwqzpfnX+/0iPo8gGfixY3lA4PDlVZNURH+xKXDCPQ==
X-Received: by 2002:a17:906:244d:: with SMTP id a13mr904907ejb.551.1624068771279;
        Fri, 18 Jun 2021 19:12:51 -0700 (PDT)
Received: from [10.28.18.12] ([212.102.57.166])
        by smtp.gmail.com with ESMTPSA id q5sm1722879ejc.117.2021.06.18.19.12.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jun 2021 19:12:50 -0700 (PDT)
Subject: Re: [PATCH 3/3] bundle: remove "ref_list" in favor of string-list.c
 API
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <cover-0.3-0000000000-20210617T111934Z-avarab@gmail.com>
 <patch-3.3-887313d3b0-20210617T111934Z-avarab@gmail.com>
From:   Andrei Rybak <rybak.a.v@gmail.com>
Message-ID: <23c4ce5f-7769-1d2c-3a97-ac9733f73a25@gmail.com>
Date:   Sat, 19 Jun 2021 04:12:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <patch-3.3-887313d3b0-20210617T111934Z-avarab@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 17/06/2021 13:21, Ævar Arnfjörð Bjarmason wrote:
> ---
>   builtin/bundle.c | 12 ++++-----
>   bundle.c         | 64 ++++++++++++++++++++++++------------------------
>   bundle.h         | 20 +++++++--------
>   transport.c      | 10 +++++---
>   4 files changed, 55 insertions(+), 51 deletions(-)
> 

[snip]

> diff --git a/bundle.c b/bundle.c
> index 621708f40e..d36eeee1a5 100644
> --- a/bundle.c
> +++ b/bundle.c
> @@ -162,14 +156,14 @@ static int list_refs(struct ref_list *r, int argc, const char **argv)
>   		if (argc > 1) {
>   			int j;
>   			for (j = 1; j < argc; j++)
> -				if (!strcmp(r->list[i].name, argv[j]))
> +				if (!strcmp(r->items[i].string, argv[j]))
>   					break;
>   			if (j == argc)
>   				continue;
>   		}
>   
> -		oid = &r->list[i].oid;
> -		name = r->list[i].name;
> +		oid = r->items[i].util;
> +		name = r->items[i].string;
>   		printf("%s %s\n", oid_to_hex(oid), name);

In function `list_refs` variable `name` that is used in a call to printf
has been extracted by the previous patch.

>   	}
>   	return 0;
> @@ -186,7 +180,7 @@ int verify_bundle(struct repository *r,
>   	 * Do fast check, then if any prereqs are missing then go line by line
>   	 * to be verbose about the errors
>   	 */
> -	struct ref_list *p = &header->prerequisites;
> +	struct string_list *p = &header->prerequisites;
>   	struct rev_info revs;
>   	const char *argv[] = {NULL, "--all", NULL};
>   	struct commit *commit;
> @@ -198,17 +192,17 @@ int verify_bundle(struct repository *r,
>   
>   	repo_init_revisions(r, &revs, NULL);
>   	for (i = 0; i < p->nr; i++) {
> -		struct ref_list_entry *e = p->list + i;
> -		struct object_id *oid = &e->oid;
> +		struct string_list_item *e = p->items + i;
> +		struct object_id *oid = e->util;
>   		struct object *o = parse_object(r, oid);
>   		if (o) {
>   			o->flags |= PREREQ_MARK;
> -			add_pending_object(&revs, o, e->name);
> +			add_pending_object(&revs, o, e->string);
>   			continue;
>   		}
>   		if (++ret == 1)
>   			error("%s", message);
> -		error("%s %s", oid_to_hex(oid), e->name);
> +		error("%s %s", oid_to_hex(oid), e->string);
>   	}
>   	if (revs.pending.nr != p->nr)
>   		return ret;
> @@ -224,28 +218,28 @@ int verify_bundle(struct repository *r,
>   			i--;
>   
>   	for (i = 0; i < p->nr; i++) {
> -		struct ref_list_entry *e = p->list + i;
> -		struct object_id *oid = &e->oid;
> +		struct string_list_item *e = p->items + i;
> +		const struct object_id *oid = e->util;
>   		struct object *o = parse_object(r, oid);
>   		assert(o); /* otherwise we'd have returned early */
>   		if (o->flags & SHOWN)
>   			continue;
>   		if (++ret == 1)
>   			error("%s", message);
> -		error("%s %s", oid_to_hex(oid), e->name);
> +		error("%s %s", oid_to_hex(oid), e->string);

However, `e->name` in three places in function `verify_bundle` for two
different instances of `struct ref_list_entry *` wasn't extracted into
a variable by the previous patch. Could you please clarify this
discrepancy?

[snip]

> diff --git a/transport.c b/transport.c
> index 9d601c8c95..667c4e0cc6 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -147,13 +147,14 @@ static struct ref *get_refs_from_bundle(struct transport *transport,
>   	transport->hash_algo = data->header.hash_algo;
>   
>   	for (i = 0; i < data->header.references.nr; i++) {
> -		struct ref_list_entry *e = data->header.references.list + i;
> -		struct ref *ref = alloc_ref(e->name);
> -		struct object_id *oid = &e->oid;
> +		struct string_list_item *e = data->header.references.items + i;
> +		struct ref *ref = alloc_ref(e->string);

Similar question for `e->name` here.

> +		const struct object_id *oid = e->util;
>   		oidcpy(&ref->old_oid, oid);
>   		ref->next = result;
>   		result = ref;
>   	}
> +	string_list_clear(&data->header.references, 1);
>   	return result;
>   }
>   
> @@ -176,6 +177,7 @@ static int close_bundle(struct transport *transport)
>   	struct bundle_transport_data *data = transport->data;
>   	if (data->fd > 0)
>   		close(data->fd);
> +	bundle_header_release(&data->header);
>   	free(data);
>   	return 0;
>   }
> @@ -1082,6 +1084,8 @@ struct transport *transport_get(struct remote *remote, const char *url)
>   		die(_("git-over-rsync is no longer supported"));
>   	} else if (url_is_local_not_ssh(url) && is_file(url) && is_bundle(url, 1)) {
>   		struct bundle_transport_data *data = xcalloc(1, sizeof(*data));
> +		string_list_init(&data->header.prerequisites, 1);
> +		string_list_init(&data->header.references, 1);
>   		transport_check_allowed("file");
>   		ret->data = data;
>   		ret->vtable = &bundle_vtable;
> 

