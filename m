Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C8ED820248
	for <e@80x24.org>; Mon, 15 Apr 2019 15:00:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727252AbfDOPAt (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Apr 2019 11:00:49 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:37381 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbfDOPAt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Apr 2019 11:00:49 -0400
Received: by mail-yb1-f193.google.com with SMTP id p134so6497185ybc.4
        for <git@vger.kernel.org>; Mon, 15 Apr 2019 08:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=s0RDViE1RFOl4gl1frQ0U0cLqNvnwopBfiJqg221ZRk=;
        b=PgMlFWDTMC6VbpU/xskSm424Xuf06/JVOdyGUHVMyzF1Jo2W2YbxDzYWe/3Yyh49qC
         oaqKBTMETF4jVVah+W4bOevn+1FN8Uuwt+LwasTuI2WaVLGAHxkdeUL39URE3wmmDVjV
         hXWeXgozP9wLCcWiGFoiy1u/mezjR1NKP1ChNZeeXEKmIjwJ6kuY1zHeLYdQfA23Vv9u
         9/Z0AZt3szeo9+G9ZngObHL2lQHFW0vgpWxbq2bW0xmDV/DcWwtach9X/KMc3JYv/pwH
         B91I4JkKoAKGzhT93yxW5/L2+USvRmkqrhwIMQ/s6tQNczZkiF2ShybrtiRyenWQpsBf
         gHGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=s0RDViE1RFOl4gl1frQ0U0cLqNvnwopBfiJqg221ZRk=;
        b=NJIA3x/fGVKja81TgHqoyu7lHFfM6Ra/sooVXi6D4kJue9E/TrCMFaue6RrGKh6rja
         AuVfYWggtG7X5O5k0QtqRDSKvJcAYjT2e5GkMXeQMUq0XG0UHDThRcFMEdRdZ+MwnQgK
         ZArxydp7McS5iuSb7XETSPcHinbywaw19WtdWgvne8sPyrSQF3BEcSZkdeI/Q5F/lzOB
         E2moQpc7SuJAdkJEGynv419VJenbU12g+AuDa84CJGBcw4jza1zotO1KBQdJweR3gQaL
         BlS6MNwtBihHYjpPFQI0eXJ9Dlk0uOiE6wyEDZLdNiboWj+/G+k9IxNbROj2g/pMfw/w
         11fQ==
X-Gm-Message-State: APjAAAUdQpjEYS8iTKg+Ke0oS0BAOZUpiDzqAshNEjc8YdnkK27BuxXX
        2zflcnBEdotZnaZQnHxhyZ3V1gEIZtE=
X-Google-Smtp-Source: APXvYqwut+fLQlVpeev+tnBMQ0CaEEpnHwt25VeRLCC9PnfNjTeXsv1/iYDzikmoe486A5mPNM3D5g==
X-Received: by 2002:a5b:3ca:: with SMTP id t10mr60406272ybp.65.1555340447254;
        Mon, 15 Apr 2019 08:00:47 -0700 (PDT)
Received: from [192.168.1.14] ([98.122.173.75])
        by smtp.gmail.com with ESMTPSA id x13sm40859331ywx.63.2019.04.15.08.00.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Apr 2019 08:00:46 -0700 (PDT)
Subject: Re: [PATCH 2/3] prune: use bitmaps for reachability traversal
To:     Jeff King <peff@peff.net>, git@vger.kernel.org
References: <20190214043127.GA19019@sigill.intra.peff.net>
 <20190214043743.GB19183@sigill.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <49e2aa9b-ff22-a8d1-ba72-1c881ff5fab4@gmail.com>
Date:   Mon, 15 Apr 2019 11:00:45 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:66.0) Gecko/20100101
 Thunderbird/66.0
MIME-Version: 1.0
In-Reply-To: <20190214043743.GB19183@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/13/2019 11:37 PM, Jeff King wrote:
> +static void *lookup_object_by_type(struct repository *r,
> +				   const struct object_id *oid,
> +				   enum object_type type)
> +{
> +	switch (type) {
> +	case OBJ_COMMIT:
> +		return lookup_commit(r, oid);
> +	case OBJ_TREE:
> +		return lookup_tree(r, oid);
> +	case OBJ_TAG:
> +		return lookup_tag(r, oid);
> +	case OBJ_BLOB:
> +		return lookup_blob(r, oid);
> +	default:
> +		die("BUG: unknown object type %d", type);
> +	}
> +}
> +
> +static int mark_object_seen(const struct object_id *oid,
> +			     enum object_type type,
> +			     int exclude,
> +			     uint32_t name_hash,
> +			     struct packed_git *found_pack,
> +			     off_t found_offset)
> +{
> +	struct object *obj = lookup_object_by_type(the_repository, oid, type);
> +	if (!obj)
> +		die("unable to create object '%s'", oid_to_hex(oid));
> +
> +	obj->flags |= SEEN;
> +	return 0;
> +}
> +
>  void mark_reachable_objects(struct rev_info *revs, int mark_reflog,
>  			    timestamp_t mark_recent, struct progress *progress)
>  {
>  	struct connectivity_progress cp;
> +	struct bitmap_index *bitmap_git;
>  
>  	/*
>  	 * Set up revision parsing, and mark us as being interested
> @@ -188,6 +223,13 @@ void mark_reachable_objects(struct rev_info *revs, int mark_reflog,
>  	cp.progress = progress;
>  	cp.count = 0;
>  
> +	bitmap_git = prepare_bitmap_walk(revs);
> +	if (bitmap_git) {
> +		traverse_bitmap_commit_list(bitmap_git, mark_object_seen);
> +		free_bitmap_index(bitmap_git);
> +		return;
> +	}
> +

Peff,

This block after "if (bitmap_git)" is not exercised by the (non-performance)
test suite, so the rest of the code above is not tested, either. Could a test
of this "prune" capability be added to the regression tests around the bitmaps?

Thanks,
-Stolee
