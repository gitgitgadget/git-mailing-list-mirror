Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0664BC2B9F4
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 07:06:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDBFE6135C
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 07:06:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbhFQHI0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Jun 2021 03:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbhFQHIX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jun 2021 03:08:23 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9727CC06175F
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 00:06:16 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id ba2so2506549edb.2
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 00:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=AMCx6gMtXBH2kIzURz65wVFLj6XUFri6A/sKu3EkXvQ=;
        b=UFbRerKiTbxIrn1Q/EenLd083Dc9mvZZiGooa9XFY0Iy+Z7btojaiCeNTzhW5J4ELZ
         DCbQtGh+AeNRSCYDaT2U8oLacZr5Yl3JtC+W55tvxuu9iVDPOkduaKOvBIxn+S5iQfX6
         DGdWMSBIzu3TGeS9KktfPZifG1B4WHRP9F2sY1x/FnM/1R0B/bhzdpM+FJpsOTWRogTx
         HWzgJbl/n2g6zvntWwIRcOgaqhN31yQmnTFlvSZBgOTw10XuzfLviZTR309RxsPH+uj9
         eSdrWu7nCyBKjI0EvSJs0SnwDHLvcwHIgNkbiWijMOyHbWCf6jCPuvZMPqHIYEyldhGm
         mJMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=AMCx6gMtXBH2kIzURz65wVFLj6XUFri6A/sKu3EkXvQ=;
        b=np2gSH71zNVIkb0FPR2Y1KoUorYEdSMKbULP+Ks59JtTuhykdD/IkW2nI0KToYwXcH
         5dhB/HCv5aS52XdDWV5+ezb7hmtqG5EQ6NQ5YOTDWs3IymiSrA6yiraN+mIc71oWZNqV
         nP1EgwZVOm84e0ABV1F7nXFiJFw+Z6RZ8l+298ZvSrdRimV2JwG+WhuLQb0hOFGQU4Yd
         kwZkNcAqA1Vu7BJX8TxOCVfgf9roe1Zsi3prRdG+BHjaRuUjeXHgvqNqpLCGpwpWp4vs
         QpA68pVs8SvpJzlw1vHSej7HNauLJ/q1q762CN5ftgMj1pnbp0DdggQvtuO4GtC3XyEB
         HYcA==
X-Gm-Message-State: AOAM530LzlLlVCdPpB33qtEs/0mtnw5dF6QlRazgLXZJjzpZPSKaw2YS
        zBwkebq8fY46uVBkrGU9iMT9HysVLoXLcA==
X-Google-Smtp-Source: ABdhPJyewiEVUL7alyHJYrFbKX3zJeoKpyRyJwVPgA7orNhkkDJUcjzNhzVVxuI/Mbd9Kf6prbRHlA==
X-Received: by 2002:aa7:d785:: with SMTP id s5mr4650870edq.19.1623913574817;
        Thu, 17 Jun 2021 00:06:14 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id y20sm3415597edq.69.2021.06.17.00.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 00:06:14 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>, ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH 1/8] [GSOC] ref-filter: add obj-type check in grab contents
Date:   Thu, 17 Jun 2021 09:04:57 +0200
References: <pull.980.git.1623496458.gitgitgadget@gmail.com>
 <48d256db5c349c1fa0615bb60d74039c78a831fd.1623496458.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <48d256db5c349c1fa0615bb60d74039c78a831fd.1623496458.git.gitgitgadget@gmail.com>
Message-ID: <878s39x95m.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Jun 12 2021, ZheNing Hu via GitGitGadget wrote:

> From: ZheNing Hu <adlternative@gmail.com>
>
> Only tag and commit objects use `grab_sub_body_contents()` to grab
> object contents in the current codebase.  We want to teach the
> function to also handle blobs and trees to get their raw data,
> without parsing a blob (whose contents looks like a commit or a tag)
> incorrectly as a commit or a tag.
>
> Skip the block of code that is specific to handling commits and tags
> early when the given object is of a wrong type to help later
> addition to handle other types of objects in this function.
>
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Hariom Verma <hariom18599@gmail.com>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: ZheNing Hu <adlternative@gmail.com>
> ---
>  ref-filter.c | 24 +++++++++++++++---------
>  1 file changed, 15 insertions(+), 9 deletions(-)
>
> diff --git a/ref-filter.c b/ref-filter.c
> index 4db0e40ff4c6..5cee6512fbaf 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -1356,11 +1356,12 @@ static void append_lines(struct strbuf *out, const char *buf, unsigned long size
>  }
>  
>  /* See grab_values */
> -static void grab_sub_body_contents(struct atom_value *val, int deref, void *buf)
> +static void grab_sub_body_contents(struct atom_value *val, int deref, struct expand_data *data)
>  {
>  	int i;
>  	const char *subpos = NULL, *bodypos = NULL, *sigpos = NULL;
>  	size_t sublen = 0, bodylen = 0, nonsiglen = 0, siglen = 0;
> +	void *buf = data->content;
>  
>  	for (i = 0; i < used_atom_cnt; i++) {
>  		struct used_atom *atom = &used_atom[i];
> @@ -1371,10 +1372,13 @@ static void grab_sub_body_contents(struct atom_value *val, int deref, void *buf)
>  			continue;
>  		if (deref)
>  			name++;
> -		if (strcmp(name, "body") &&
> -		    !starts_with(name, "subject") &&
> -		    !starts_with(name, "trailers") &&
> -		    !starts_with(name, "contents"))
> +
> +		if ((data->type != OBJ_TAG &&
> +		     data->type != OBJ_COMMIT) ||
> +		    (strcmp(name, "body") &&
> +		     !starts_with(name, "subject") &&
> +		     !starts_with(name, "trailers") &&
> +		     !starts_with(name, "contents")))

We have 4 "real" object types, commit, tree, blob, tag. Do you really
mean "not tag or commit" here, don't you mean "is tree or blob" instead?
I.e. do we really want to pass OBJ_NONE etc. here?

>  			continue;
>  		if (!subpos)
>  			find_subpos(buf,
> @@ -1438,17 +1442,19 @@ static void fill_missing_values(struct atom_value *val)
>   * pointed at by the ref itself; otherwise it is the object the
>   * ref (which is a tag) refers to.
>   */
> -static void grab_values(struct atom_value *val, int deref, struct object *obj, void *buf)
> +static void grab_values(struct atom_value *val, int deref, struct object *obj, struct expand_data *data)
>  {
> +	void *buf = data->content;
> +
>  	switch (obj->type) {
>  	case OBJ_TAG:
>  		grab_tag_values(val, deref, obj);
> -		grab_sub_body_contents(val, deref, buf);
> +		grab_sub_body_contents(val, deref, data);
>  		grab_person("tagger", val, deref, buf);
>  		break;
>  	case OBJ_COMMIT:
>  		grab_commit_values(val, deref, obj);
> -		grab_sub_body_contents(val, deref, buf);
> +		grab_sub_body_contents(val, deref, data);
>  		grab_person("author", val, deref, buf);
>  		grab_person("committer", val, deref, buf);
>  		break;
> @@ -1678,7 +1684,7 @@ static int get_object(struct ref_array_item *ref, int deref, struct object **obj
>  			return strbuf_addf_ret(err, -1, _("parse_object_buffer failed on %s for %s"),
>  					       oid_to_hex(&oi->oid), ref->refname);
>  		}
> -		grab_values(ref->value, deref, *obj, oi->content);
> +		grab_values(ref->value, deref, *obj, oi);
>  	}
>  
>  	grab_common_values(ref->value, deref, oi);

