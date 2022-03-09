Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FD78C433EF
	for <git@archiver.kernel.org>; Wed,  9 Mar 2022 21:53:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238329AbiCIVyZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 16:54:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234811AbiCIVyX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 16:54:23 -0500
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E8FF01
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 13:53:22 -0800 (PST)
Received: by mail-il1-x135.google.com with SMTP id l1so2482816ilv.3
        for <git@vger.kernel.org>; Wed, 09 Mar 2022 13:53:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=piySpAEUtu1rYexSnhPtiP4CVCXqmaxuAjd5fWdOgts=;
        b=c6VgEnOeOfeLI7etyAfG9glUY1RrppRkZpeh1GIyylMW7iAZykBYZ/0q4lfxwtzD1n
         DiyZMWfLP+mScETK79ujbRFF1qKXkEk6m27nTcC9Nw0d8m+W9fWYdEUp549YsVDR9fuH
         bNd32ZuVsJwLqVNpfZoY+g1RRja+LObwWg1udxGt20Gq0jYdTXXQtJyfW758XAY6KSR1
         k43LKLZU1zFwf3O+SwK8bX3U9MAQ3aWrJ8+EgYnapM6jZepbn8wAdt2QdwKCUS2/kMNs
         pfYE/06o/ajuYJ3JJR2NkPGr2QMTcD6HN4Pdr4En8jkwGHs8DOAG0rWfsb4Ey98nJhx5
         3gHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=piySpAEUtu1rYexSnhPtiP4CVCXqmaxuAjd5fWdOgts=;
        b=lxteTcZH7RXExTlirkMk1raFyzVPw9hPzYzdECoH2LnJ5VmKSqEB2hk5UeuRApEQ+j
         G3Ia+E7czGNKt5IuuF70d4d4HuaINyiVwlG1gWrZzL74L+GuCn8DKjXGXLcmNjrOFH6w
         s8j/pRirWe04GZstNxFKMbu8t1PD+Q1p5Jpt/UljM9aMdByAASW8k1n0CiHLbycfjNSH
         c/vowJuMw0ZeAOAzz5n1k6839K8bGCelxSGrfrxMm9zHOd+MGVpF29j2C1S0tzgWMvfE
         /4XKgNtbPHPSXa5Ru+VGHKM8ZU+srhU5DwmPcfW89g1PwxgXNFONmwY9zozVZEKGiAyB
         7V8g==
X-Gm-Message-State: AOAM532zzpcr2Y/tFy1sP2sBTIfEEZSNvndyXzSS2/yj5vH2i57k8Z02
        wGA2tp1w6pN9tIrD2KCniIKpXQ==
X-Google-Smtp-Source: ABdhPJyxpwaqqPpvhBvjalJx0SGNvbMaQ3WjZd/yFmPVRY/6u4u16YpPCCSMVvi4IU5fAioWm8zBLw==
X-Received: by 2002:a92:c691:0:b0:2be:8eab:9f7d with SMTP id o17-20020a92c691000000b002be8eab9f7dmr1246638ilg.26.1646862801840;
        Wed, 09 Mar 2022 13:53:21 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id a4-20020a5d9544000000b00640a6eb6e1esm1676076ios.53.2022.03.09.13.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 13:53:21 -0800 (PST)
Date:   Wed, 9 Mar 2022 16:53:20 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 10/24] revisions API users: use release_revisions() in
 builtin/log.c
Message-ID: <Yikh0Cu3IJt16pIZ@nand.local>
References: <cover-00.24-00000000000-20220309T123321Z-avarab@gmail.com>
 <patch-10.24-a89f0da4fd7-20220309T123321Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-10.24-a89f0da4fd7-20220309T123321Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 09, 2022 at 02:16:40PM +0100, Ævar Arnfjörð Bjarmason wrote:
> In the case of "format-patch" revert the addition of UNLEAK() in
> dee839a2633 (format-patch: mark rev_info with UNLEAK, 2021-12-16), and
> which will cause several tests that previously passed under
> "TEST_PASSES_SANITIZE_LEAK=true" to start failing.

Thanks for calling this out. When I skimmed the diff first, I wasn't
sure whether the change in t4126 was intentional or not. But this is
helpful context to indicate that it was.

> @@ -731,8 +737,7 @@ int cmd_show(int argc, const char **argv, const char *prefix)
>  			ret = error(_("unknown type: %d"), o->type);
>  		}
>  	}
> -	free(objects);
> -	return ret;
> +	return cmd_log_deinit(ret, &rev);
>  }

Here `objects` points at `rev.pending.objects`, and that is now freed
along the cmd_log_deinit() -> release_revision() -> object_array_clear()
path.

Makes sense, and the rest looks good, too.

Thanks,
Taylor
