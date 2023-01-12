Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2C5BC54EBC
	for <git@archiver.kernel.org>; Thu, 12 Jan 2023 13:22:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbjALNV6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Jan 2023 08:21:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232317AbjALNVw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2023 08:21:52 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FDA43631E
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 05:21:46 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id l22so14972716eja.12
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 05:21:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Hxvx0BZPeATKLde3I+vpuKJ+/4BbDZAGN2gO/hSFuYc=;
        b=RAuo4iBr5pN+LsH//bPNmZt+8hRLiQWIueYBD1BwUkw4W/6sW0aASt69MkLk0Rk4oA
         ucgXiv21XBmGARmjK0hLpQvnVKT9dlghxQFl5Qp1DhY6auIMCW5gURSX4cX+W78UOsZE
         nfeFpq1Y6Uw3F4nyTP3C3vPYMZ446kRZLwmJEFBP1UZpBQp2PgCF75Sj6s3AqIaCTlpa
         xXgDxxIiegqvZux7o/tHAqpIE4njBRU+iFzoE4oeppZ2lAujCdR0RVvFOt7J4olbWCw7
         zqql06whMEUN/fprPqyI0I//tcxOVGZSOfSGmHt4ca00GVGAxO8Mbt9qocEjwb7CSyOQ
         OnwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hxvx0BZPeATKLde3I+vpuKJ+/4BbDZAGN2gO/hSFuYc=;
        b=axM7ZWKa0KZeJN+cYVHbqF3W732hTp2T1G5G6jw2Et/L1o36A36OZWt23W1r5YSGOb
         51GgA/A+2iJjH2oJEpwEtl4BZCEabsJ4ig6MzvYTxl51mv2FxEVBmIJuZi/p0lKBXg2w
         bfYTQKYDf5VKD13ZE0crcyzxfARCvN8Dfikt8SwtArr4nvLGZTmnsiXh93dR9zhmbnuV
         Tb6eYMs1q5O647IYeGUdcrxwJxawf/IPISPVduTuhw52o3+/5ZvrAEgdj4ICh/YuiQ1w
         Vv0nWLkcsMDGvaSoqtlD0J+QRPkzoAteKPUsR9FqoGJ7wmSHsJsYrHALAvNCv8Le2l+Y
         rDtQ==
X-Gm-Message-State: AFqh2kq0xFWdXnhFY9ZKQqUtNzlYdNjA++FyHL3RUbuN7DKInuoNO9+R
        D3K7sPZ3IbadvYc3KTy9mnQ=
X-Google-Smtp-Source: AMrXdXs0OJXh+zxq5Fh/ZlHzwzH/KhFDRSsZyxgBdPOgcuU/I4PRCp4SNvvJQhOb3HwDSzGhv+KUiQ==
X-Received: by 2002:a17:907:d48e:b0:862:fc76:6f8e with SMTP id vj14-20020a170907d48e00b00862fc766f8emr4346821ejc.36.1673529704923;
        Thu, 12 Jan 2023 05:21:44 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id k2-20020a17090632c200b007b47749838asm7307671ejk.45.2023.01.12.05.21.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 05:21:44 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pFxWZ-000E7D-3D;
        Thu, 12 Jan 2023 14:21:44 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Karthik Nayak <karthik.188@gmail.com>
Cc:     git@vger.kernel.org, Toon Claes <toon@iotcl.com>
Subject: Re: [PATCH v5 2/2] attr: add flag `--source` to work with tree-ish
Date:   Thu, 12 Jan 2023 14:20:56 +0100
References: <https://lore.kernel.org/git/cover.1671630304.git.karthik.188@gmail.com/>
 <cover.1671793109.git.karthik.188@gmail.com>
 <23813496fc73b7e5cb9f09b166e05c9a02bac43c.1671793109.git.karthik.188@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <23813496fc73b7e5cb9f09b166e05c9a02bac43c.1671793109.git.karthik.188@gmail.com>
Message-ID: <230112.86lem728ig.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jan 02 2023, Karthik Nayak wrote:

> +static struct attr_stack *read_attr_from_blob(struct index_state *istate,
> +					      const struct object_id *tree_oid,
> +					      const char *path, unsigned flags)
> +{
> +	struct object_id oid;
> +	unsigned long sz;
> +	enum object_type type;
> +	void *buf;
> +	unsigned short mode;
> +
> +	if (!tree_oid)
> +		return NULL;
> +
> +	if (get_tree_entry(istate->repo, tree_oid, path, &oid, &mode))
> +		return NULL;
> +
> +	buf = read_object_file(&oid, &type, &sz);

Here you flip-flop between istate->repo and "the_repository". I think
you want to use repo_read_object_file(istate->repo, ...) instead.
