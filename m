Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5007CC47089
	for <git@archiver.kernel.org>; Thu, 27 May 2021 18:18:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2466B613CC
	for <git@archiver.kernel.org>; Thu, 27 May 2021 18:18:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235506AbhE0SUY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 May 2021 14:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234756AbhE0SUY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 May 2021 14:20:24 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB611C061574
        for <git@vger.kernel.org>; Thu, 27 May 2021 11:18:50 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id u7-20020a259b470000b02904dca50820c2so1430486ybo.11
        for <git@vger.kernel.org>; Thu, 27 May 2021 11:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=GZevOWBt7YYvjkW4PeYqPAyoyIVqJzQyrBhOxU3QK9g=;
        b=KXcgK5u9IGBOWFY5/Bz2m72fDP9bmYG8NqdZ6VsgHEyXPSQtA6DCZtYd9vvA4skwvs
         PnCE/NPNZ/GDtrJku0KVusgetU03i6oZM3wlvDnl4yPTR8PSx85cYDw9c5cGf3XonWg7
         dQb5SzXmLysjS75xGRVAhl8a0+AeZJvzkiSlABfc5yBnu0ByxVogJsv9hMqgnVy+bu3g
         wB8z5Fuuo97k2sQFBTkLHIMByYYwdi6ph1JE6ayVsWknN90H/Po/Uf8b6mM7gxgRZe8Q
         9IJOclGlrc1jLOyS1pFTR3xt9ZZMZ3fDEFZZbWemJpOyoY7elJiAovLacB1y14VbntgF
         ZQeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=GZevOWBt7YYvjkW4PeYqPAyoyIVqJzQyrBhOxU3QK9g=;
        b=pYLbC8RhPgUXmQyQOa0YS4Pe9AGfwQJNkWHce+vDNK9Rdk71Gotkd1yS12HSCnVEkB
         QuHtiy19w3EB+zdt3ehhDiAvYrmj/UXrnXklUSif3lGe6fdV5DrMIoasberukMQN6Zqe
         52c7fNFzPuXc2F5keXdNsBeWdZGWMuRbhRM+QANDqQoHSexuF2XAkYiKWjOT2oP2JbEv
         G/jXG/bh03bw5YxkRUXVjiLICNhmyhH0TYer5cZ68AlsDnY+VwvU17aMoTTmz9S3xkLt
         wwR1RJnjoeg7Gl2C+Q5xRq+doh94enQ1HxTGzTZ8CcuRZGuJr82yfi0Ucnb+bFb74rGt
         Ofrw==
X-Gm-Message-State: AOAM530YdB+Cg+/czJ07+oivf/bTxKM2Q7c6SgIL0rMLNuWBPAdDF+gG
        XbUQgpgWFRS0jaEweNgyepNbiNEX0QBzIuj1JZBY
X-Google-Smtp-Source: ABdhPJxavIxoYfXcUnxepRUA/Ni/rBMbj6jA9ynrsonJ8HfiddoX+tTYmESQC7kh9iZ/g5GKSS5Gpz3RQZLq8zRDwzOq
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a25:4f05:: with SMTP id
 d5mr6637161ybb.473.1622139529990; Thu, 27 May 2021 11:18:49 -0700 (PDT)
Date:   Thu, 27 May 2021 11:18:48 -0700
In-Reply-To: <patch-14.17-260e9888a3-20210520T111610Z-avarab@gmail.com>
Message-Id: <20210527181848.2679147-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <patch-14.17-260e9888a3-20210520T111610Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0.204.g9fa02ecfa5-goog
Subject: Re: [PATCH v3 14/17] fsck: don't hard die on invalid object types
From:   Jonathan Tan <jonathantanmy@google.com>
To:     avarab@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        j6t@kdbg.org, Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> diff --git a/object-file.c b/object-file.c
> index 0de699de98..0e8a024eb3 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -2522,7 +2522,8 @@ int read_loose_object(const char *path,
>  		      const struct object_id *expected_oid,
>  		      enum object_type *type,
>  		      unsigned long *size,
> -		      void **contents)
> +		      void **contents,
> +		      unsigned int oi_flags)
>  {
>  	int ret = -1;
>  	void *map = NULL;
> @@ -2530,6 +2531,7 @@ int read_loose_object(const char *path,
>  	git_zstream stream;
>  	char hdr[MAX_HEADER_LEN];
>  	struct object_info oi = OBJECT_INFO_INIT;
> +	int allow_unknown = oi_flags & OBJECT_INFO_ALLOW_UNKNOWN_TYPE;
>  	oi.typep = type;
>  	oi.sizep = size;
>  
> @@ -2552,8 +2554,11 @@ int read_loose_object(const char *path,
>  		git_inflate_end(&stream);
>  		goto out;
>  	}
> -	if (*type < 0)
> -		die(_("invalid object type"));
> +	if (!allow_unknown && *type < 0) {
> +		error(_("header for %s declares an unknown type"), path);
> +		git_inflate_end(&stream);
> +		goto out;
> +	}
>  
>  	if (*type == OBJ_BLOB && *size > big_file_threshold) {
>  		if (check_stream_oid(&stream, hdr, *size, path, expected_oid) < 0)

So instead of dying, we print an error and behave as if the object was
invalid for some other reason. Makes sense.
