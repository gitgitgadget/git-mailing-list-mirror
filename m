Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ED5FC05027
	for <git@archiver.kernel.org>; Thu,  9 Feb 2023 01:53:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbjBIBxC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Feb 2023 20:53:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbjBIBxB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2023 20:53:01 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B831F10AB3
        for <git@vger.kernel.org>; Wed,  8 Feb 2023 17:52:57 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id qw12so2303354ejc.2
        for <git@vger.kernel.org>; Wed, 08 Feb 2023 17:52:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iyYDwc/QhlHYng/rv1Keh5DSAvXVMNURaSLQyL2RPUY=;
        b=RWNyIv8iCggks4pc/fEUadk5KEwCLMbTso6vz4HhuCyI0EthfK5e43h1mtiYg7Yikk
         vE66hjwccpcijXYOwUe5cpPq42y2o+lsCdsp5jwhJgI10/WZzJ41Lq+kNcMkR7XhjVBL
         9DfRVU/jWCsqtXO/jD28Rzd2bU3FpJ284nPzVARJ8xMFOFmSBzrKKLSzqemo9EhQ9+6I
         V2K4ziNuDCGELdoZTmGqsi+B2Hq6qnf81o1q43EsR0f/Usdgj449dK2cHEKGhWqWN5oK
         Bg8pvKz9WEmstTirKMfqvRDx+zEhZbVySgdFDbUjf9AAbNNIoHkBlxQZ8V10R0R8wVVW
         Gp9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iyYDwc/QhlHYng/rv1Keh5DSAvXVMNURaSLQyL2RPUY=;
        b=4AkKHzuKZTpyN6Z0pXMNqR40VlmajaM8yRWc9i6JeYtJAXru73kRWX7k+HA7oA6BZk
         Trb6zxS2SUOm2YhUHzqezi8wauczRsolzLSWt3mFUbk05uWcLvrZiKukMHpIUPP0dxSe
         KYDQ4HWueb88MoBTdWEbZaPka9lLTCdDpUkgV2zZS0OoIH56MyqzlR6JHt2FwVRQcCMr
         QRIj53CjBtMb5rHc21UDky3Szbmt88FaUqZjEH3xOfh+5PcaUNdkYtK0Z2A8laDNLDUT
         BfJILA/rXZkTM3tlynO2d/6rZUHbpotwp08gnj+3hQGH1rP2xD9neeMPVYiqw7CfGfsZ
         PApg==
X-Gm-Message-State: AO0yUKXQniRFC0ZEDibSHuGA1bXsGXAuB3402+kDghfjpibR2cO2Clpo
        yEyqkHii0raXAggFazYAcO9DA7X+Pmq5j+lF
X-Google-Smtp-Source: AK7set8M13zSEugeaHAXoUjs5GlG+WTGeotZ5bwLW+ij24KkTvOp38S64NmD0toyUYN3lCkGhCCa/w==
X-Received: by 2002:a17:907:7646:b0:87d:ed60:cb7e with SMTP id kj6-20020a170907764600b0087ded60cb7emr10106539ejc.68.1675907575925;
        Wed, 08 Feb 2023 17:52:55 -0800 (PST)
Received: from gmgdl ([81.191.238.7])
        by smtp.gmail.com with ESMTPSA id kk21-20020a170907767500b0088ef3c38a52sm215990ejc.19.2023.02.08.17.52.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 17:52:55 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pPw7K-001asz-2H;
        Thu, 09 Feb 2023 02:52:54 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     git@vger.kernel.org, chooglen@google.com, newren@gmail.com,
        jonathantanmy@google.com, phillip.wood123@gmail.com
Subject: Re: [PATCH v8 5/6] diff-lib: refactor out diff_change logic
Date:   Thu, 09 Feb 2023 02:48:42 +0100
References: <20230207181706.363453-1-calvinwan@google.com>
 <20230209000212.1892457-6-calvinwan@google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <20230209000212.1892457-6-calvinwan@google.com>
Message-ID: <230209.86357fzjt5.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Feb 09 2023, Calvin Wan wrote:

> +	diff_change(options, oldmode, newmode,
> +			old_oid, new_oid,
> +			!is_null_oid(old_oid),
> +			!is_null_oid(new_oid),
> +			ce->name, 0, dirty_submodule);

Nit: This has odd not-our-usual-style indentation (to align with the
"("). I didn't spot it before, but I vaguely recall seeing something
like this in another one of your patches, but maybe I misrecall. In case
not maybe some editor settings need tweaking?

I haven't looked carefully at the rest to see if the same issue occurs
in other code here.

> -		if (!changed && !dirty_submodule) {
> -			ce_mark_uptodate(ce);
> -			mark_fsmonitor_valid(istate, ce);
> -			if (!revs->diffopt.flags.find_copies_harder)
> -				continue;
> -		}
> -		oldmode = ce->ce_mode;
> -		old_oid = &ce->oid;
> -		new_oid = changed ? null_oid() : &ce->oid;
> -		diff_change(&revs->diffopt, oldmode, newmode,
> -			    old_oid, new_oid,
> -			    !is_null_oid(old_oid),
> -			    !is_null_oid(new_oid),
> -			    ce->name, 0, dirty_submodule);

So in this case it's not new code, but code moving, note the four spaces
after the sequence of tabs that aren't in your version.

So perhaps your editor on re-indentation is configured not to just strip
off the leading \t to re-indent (which is all that's needed here) but
strips all whitespace, then re-indents after its own mind?
