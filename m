Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE987C433EF
	for <git@archiver.kernel.org>; Thu, 13 Jan 2022 06:55:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbiAMGz6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Jan 2022 01:55:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbiAMGz5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jan 2022 01:55:57 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 772AAC06173F
        for <git@vger.kernel.org>; Wed, 12 Jan 2022 22:55:57 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id q25so19500661edb.2
        for <git@vger.kernel.org>; Wed, 12 Jan 2022 22:55:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=J9U3rNDqQHGxU0SOHJCOICCUujeSkT+ov6lWbH1MzJM=;
        b=OwgxYzdsr9LRukTjyXda8nGd1lhSuaeEP54hInGhrdr7BiC1mHAKBPdeBqS01W+Jti
         hY9Lr5GqnZZsBuwQiz9KB86UVb8eIpgV2FExszo9Ft3bTBhI0vqQx9JfQ+1SdqBBLXVi
         6zRl5pIfyVEEUblCc1K2yaHk+UtUwwgrSFeMMuVvSAZWuFZsiDZApTTJz4QmU/WF5WDM
         V1PTjvNLLK38xn1Zk+O8fXlveS8rCehQxQpZwkutlcVCuqKxOkXCHRdq95l9W+jTnlMp
         WKUfNlWVPW2MsCsU9n3E9UfB4EHwvrMm1fbAAtRzrG6Cncy9tyKF8SG+kemPMtskKvTi
         Uv6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=J9U3rNDqQHGxU0SOHJCOICCUujeSkT+ov6lWbH1MzJM=;
        b=k85RVvi5q313nZjx+9joc8DcBkOum6HGIMT3iFs4Dvxoz4Mk+0vHDHu3Us08DsgGRB
         ldl/IYLvtnZIbV4Ab1WJCd6IjavVH7Ff2LEDBQyRnPsxVNuLVwOS6/MuauNTajdFUcdX
         U0plhn9b5mOXi73YnXbOVnQl2/OcoW9+StoT+ufeXJgxzFZc9KQwZDrkXYITQGwbjKvs
         w/+eCvGiYYNqjjdQmsQe2At7mRWIfUErUYQoM8wG4jL7HOabtjoPUJcYYWJ0zRJSu0pp
         ygM7XopY9xwQQCgNzs0YHJp6utrOodJt9wsf9xf3/Cg2ZnQvK0Tb2fvvRrAJCSLNee5g
         WXNQ==
X-Gm-Message-State: AOAM533FrbYU9q7ahQKUg+ngSwZHbf+BvcwNKk4YQC5xmqe79KwPU985
        itA6S9wMWp6KkU5/Don+SvN7zeIKEfz9hQ==
X-Google-Smtp-Source: ABdhPJyJ0Y92SIxMO6kTX/pWnRH2r8cNj5TnqsNlK0OFbo7iDeat7prvuL2zeI+8QWGbk0mqVZJQTQ==
X-Received: by 2002:a17:906:38f:: with SMTP id b15mr2495992eja.661.1642056955767;
        Wed, 12 Jan 2022 22:55:55 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id g9sm545536ejo.222.2022.01.12.22.55.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 22:55:55 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1n7u1a-000m66-Pn;
        Thu, 13 Jan 2022 07:55:54 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     Johannes.Schindelin@gmx.de, congdanhqx@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        tenglong.tl@alibaba-inc.com, martin.agren@gmail.com,
        Teng Long <dyronetengb@gmail.com>
Subject: Re: [PATCH v10 5/9] ls-tree: optimize naming and handling of
 "return" in show_tree()
Date:   Thu, 13 Jan 2022 07:49:45 +0100
References: <cover.1641978175.git.dyroneteng@gmail.com>
 <b04188c822c32aab6ef59099a0c9078aeda065c3.1641978175.git.dyroneteng@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <b04188c822c32aab6ef59099a0c9078aeda065c3.1641978175.git.dyroneteng@gmail.com>
Message-ID: <220113.861r1cxgxx.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jan 13 2022, Teng Long wrote:

Re the $subject: Is "optimize naming" here just referring to the
s/retval/recurse/g?

Personally I think just a s/retval/ret/g here would make more senes if
we're doing any change at all, and in either case having this variable
re-rename split up as its own commit would make the proposed control
flow changes clearer.

> The variable which "show_tree()" return is named "retval", a name that's
> a little hard to understand. This commit tries to make the variable
> and the related codes more clear in the context.
>
> The commit firstly rename "retval" to "recurse" which is a more
> meaningful name than before. Secondly, "get_type()" is introduced
> to setup the "type" by "mode", this will remove some of the nested if.
> After this, The codes here become a little bit clearer, so we do not
> need to take a look at "read_tree_at()" in "tree.c" to make sure the
> context of the return value.
>
> Signed-off-by: Teng Long <dyronetengb@gmail.com>
> ---
>  builtin/ls-tree.c | 33 ++++++++++++++++++---------------
>  1 file changed, 18 insertions(+), 15 deletions(-)
>
> diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
> index eecc7482d5..9729854a3d 100644
> --- a/builtin/ls-tree.c
> +++ b/builtin/ls-tree.c
> @@ -61,24 +61,27 @@ static int show_recursive(const char *base, size_t baselen, const char *pathname
>  	return 0;
>  }
>  
> +static enum object_type get_type(unsigned int mode)
> +{
> +	return (S_ISGITLINK(mode)
> +	        ? OBJ_COMMIT
> +	        : S_ISDIR(mode)
> +	        ? OBJ_TREE
> +	        : OBJ_BLOB);
> +}

This new function is a re-invention of the object_type() utility in
cache.h, and isn't needed. I.e....

>  static int show_tree(const struct object_id *oid, struct strbuf *base,
>  		const char *pathname, unsigned mode, void *context)
>  {
> -	int retval = 0;
> +	int recurse = 0;
>  	size_t baselen;
> -	enum object_type type = OBJ_BLOB;
> -
> -	if (S_ISGITLINK(mode)) {
> -		type = OBJ_COMMIT;
> -	} else if (S_ISDIR(mode)) {
> -		if (show_recursive(base->buf, base->len, pathname)) {
> -			retval = READ_TREE_RECURSIVE;
> -			if (!(ls_options & LS_SHOW_TREES))
> -				return retval;
> -		}
> -		type = OBJ_TREE;
> -	}
> -	else if (ls_options & LS_TREE_ONLY)
> +	enum object_type type = get_type(mode);

...just drop it and do this:

	-       enum object_type type = get_type(mode);
	+       enum object_type type = object_type(mode);
