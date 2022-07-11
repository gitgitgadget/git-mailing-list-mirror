Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D325C433EF
	for <git@archiver.kernel.org>; Mon, 11 Jul 2022 08:20:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbiGKIUJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jul 2022 04:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbiGKIUG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jul 2022 04:20:06 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 511A61EC53
        for <git@vger.kernel.org>; Mon, 11 Jul 2022 01:20:00 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id y4so5282051edc.4
        for <git@vger.kernel.org>; Mon, 11 Jul 2022 01:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ri10uvbPfp/p+d4+yt+9NHT2HSxGGFCBesaakmZ4l58=;
        b=CX4hXrL2PhPxNgmg8Al//THsO2ibOGiVnvNTod3HCAuYVJ4PszfStzcYgdN0SVCuC1
         Creve7NvLlEHzZydKUyL9IMni7ilsObsF1yiP9x7mAJi1WP3sex2UOPvSDIJi7BANXJU
         k31/hhLeaXQpP7PN4G4vW3uVr3DcfSyyRDC+wLU8Ou96p+/tPfOigIlMs/JKKZq0+Hsa
         FxABF3uXPY0AJ3He9kw4h7mLysLtphzO0GQ0gOlpC46cMSVcA0jBAkz7LeUQ8V/ylL7q
         vT7ubCHwr9N6r3u6N31daXp6Gc9+rIQMuL/+YmETfxxYcFHIussm9+eXoK6jlxKvKtBM
         SvpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ri10uvbPfp/p+d4+yt+9NHT2HSxGGFCBesaakmZ4l58=;
        b=SiuV0xh4ZyeFuWxNn/RclUwM8TU29BU7nKwkcGZrWEUN8RIlDVHyd1RQ0alkXi8hdp
         q/34cDWyYZkDtNHhqCGD5XdlJ6hQxABKdXm6o1LPCOiKlW4bIGVfm0jjspnsWActffd0
         EEbta335seNAjGk2HdOSM838zyHDhscoZmSV6isFZyUIX+kEbMZF+zQO434e2da0P3Sj
         Hps2Vnpiw5aeU9WVubWp0eVoOlsLF0JsIco08ZaL4FDpw1ziux4PM/C3hPJvV9S2DiAS
         UOtlNhFBlrP3RKUGLmossVe/0f5m82ojsJTTH8tKGgSczh8Z7NnzssyUxHP39t3j31Pw
         45Cw==
X-Gm-Message-State: AJIora/D1GjJK0/U7OzpoPyEC8dJI0AFKQIW4uUhnmEsjbKgOGbfIAum
        SdIh4oWY0Ab7x0VxIrUVt5P0r89nb7Q=
X-Google-Smtp-Source: AGRyM1vspASDJfHRFilXJSaSSTE3G6SwAeVTPmSxOdxSIzuMSs22IBNvo4LL3isKclpNtSk6ncgebQ==
X-Received: by 2002:a05:6402:2a08:b0:437:cdc9:d120 with SMTP id ey8-20020a0564022a0800b00437cdc9d120mr22940604edb.129.1657527598644;
        Mon, 11 Jul 2022 01:19:58 -0700 (PDT)
Received: from localhost (94-21-146-223.pool.digikabel.hu. [94.21.146.223])
        by smtp.gmail.com with ESMTPSA id lb7-20020a170907784700b0072b1738a1d7sm2427889ejc.214.2022.07.11.01.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 01:19:58 -0700 (PDT)
Date:   Mon, 11 Jul 2022 10:19:56 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: fsck segfault (was: Re: [PATCH] revision: mark blobs needed for
 resolve-undo as reachable)
Message-ID: <20220711081956.GB2038@szeder.dev>
References: <xmqqfskdieqz.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqfskdieqz.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 09, 2022 at 04:44:20PM -0700, Junio C Hamano wrote:
> +static int fsck_resolve_undo(struct index_state *istate)
> +{
> +	struct string_list_item *item;
> +	struct string_list *resolve_undo = istate->resolve_undo;
> +
> +	if (!resolve_undo)
> +		return 0;
> +
> +	for_each_string_list_item(item, resolve_undo) {
> +		const char *path = item->string;
> +		struct resolve_undo_info *ru = item->util;
> +		int i;
> +
> +		if (!ru)
> +			continue;
> +		for (i = 0; i < 3; i++) {
> +			struct object *obj;
> +
> +			if (!ru->mode[i] || !S_ISREG(ru->mode[i]))
> +				continue;
> +
> +			obj = parse_object(the_repository, &ru->oid[i]);

parse_object() can return NULL ...

> +			if (!obj) {

... and here is the if statement to show an error in that case ...

> +				error(_("%s: invalid sha1 pointer in resolve-undo"),
> +				      oid_to_hex(&ru->oid[i]));
> +				errors_found |= ERROR_REFS;
> +			}
> +			obj->flags |= USED;

... but then there is this line which might dereference that NULL
pointer.

Perhaps all we would need is a 'continue' at the end of that 'if
(!obj)' block, or an else block for the last three statements, which
should result in the same control flow?  Dunno.

> +			fsck_put_object_name(&fsck_walk_options, &ru->oid[i],
> +					     ":(%d):%s", i, path);
> +			mark_object_reachable(obj);
> +		}
> +	}
> +	return 0;
> +}
