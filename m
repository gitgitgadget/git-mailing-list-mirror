Return-Path: <SRS0=AD9v=6R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5275EC28CBC
	for <git@archiver.kernel.org>; Sun,  3 May 2020 11:44:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EF612073E
	for <git@archiver.kernel.org>; Sun,  3 May 2020 11:44:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dq0BT4GN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728081AbgECLoG (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 May 2020 07:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727023AbgECLoF (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 3 May 2020 07:44:05 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9510FC061A0C
        for <git@vger.kernel.org>; Sun,  3 May 2020 04:44:05 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id h11so5628544plr.11
        for <git@vger.kernel.org>; Sun, 03 May 2020 04:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mvtMSKhSXnfRPY+sYEMDZSDjYm8Vn1f53tAJQkF8VO8=;
        b=dq0BT4GNShYZSpk5FGv+kZkuMTAiKXOTVW3FbGAzPVE6ZoZlZ8B002LGAQUb5WRFro
         dzgWdfV8/gunhm3E91ox8xDjirgRTuhPVXMJ8UbUejM5wUPvS49vhdm0R+va/OOUwtS8
         hEjVWV+zRGqNtBoY49KjFhDRvwSKOopQ6SJemL0NFgvoESgl5mbmSavSNmUR8F1fp9zZ
         5ECDKxIutwOyDIpqH0f/C1WaRNid7Uw6lq4Cr1A6aj592zozQurd7j34zTo63O8EXLVI
         d9xkXhPiCx8UxTHEZQ6EQBUeYpy/sMu+uVpFKRxM+luWrSYC2k9XM1VFLwUpTY8Xvvl9
         fNhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mvtMSKhSXnfRPY+sYEMDZSDjYm8Vn1f53tAJQkF8VO8=;
        b=eirbue9p88+ZeCKgsIXxbQTpnJ4nUifrAJQp0oL3mTXNJSydepKDnrvPgN2f7p1HzO
         /iYLlLQyainTK7V6OZKhauUI+3/64eQYcbXXVpjRkFk5RgDO9qRBWQpVkao0C8LEk97i
         yhC6TjBb93ojp2gilpOEtYsoxplgAEGruXW0YUtv8/8qR114Kro8h7/+95PIlh2klTX7
         keJOB4+sWW0DZt5MnMEr1uUE9OlAMiEdII6aXSF/Fsbh6QtGn8NR/D67p/bMH2TDKIDM
         yGWhI8aDmcgiflgXpcFV8SKugYMEefh8dIY63ODKkhoVOwfGwR1tqXKRZ3CHy3BhHmgB
         dlxg==
X-Gm-Message-State: AGi0PuZhYOZhCzeJ+P54MIILFzYnp8+sLnOAA0nuwumfkouJYvnITnlk
        BH0M1ldxKOFKxluyoZNk6Rk=
X-Google-Smtp-Source: APiQypJgC/0r8chDWfSsFX6d5Mxfic4LzAIpIkO7vFWag0Okiz/thzb/1I9/aNrn6CEt8Rtf9b8K0g==
X-Received: by 2002:a17:90a:3b42:: with SMTP id t2mr11237550pjf.11.1588506245099;
        Sun, 03 May 2020 04:44:05 -0700 (PDT)
Received: from localhost ([2402:800:6374:cedc:d509:3e82:1f34:e3c4])
        by smtp.gmail.com with ESMTPSA id q19sm6437346pfh.34.2020.05.03.04.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2020 04:44:04 -0700 (PDT)
Date:   Sun, 3 May 2020 18:44:02 +0700
From:   Danh Doan <congdanhqx@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     clime <clime7@gmail.com>, Git List <git@vger.kernel.org>
Subject: Re: [PATCH 1/2] ref-filter: apply --ignore-case to all sorting keys
Message-ID: <20200503114351.GA28680@danh.dev>
References: <20200503090952.GA170768@coredump.intra.peff.net>
 <20200503091157.GA170902@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200503091157.GA170902@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-05-03 05:11:57-0400, Jeff King <peff@peff.net> wrote:
> +test_expect_success 'for-each-ref --ignore-case works on multiple sort keys' '
> +	# name refs numerically to avoid case-insensitive filesystem conflicts
> +	nr=0 &&
> +	for email in a A b B
> +	do
> +		for subject in a A b B
> +		do
> +			GIT_COMMITTER_EMAIL="$email@example.com" \
> +			git tag -m "tag $subject" icase-$(printf %02d $nr) &&
> +			nr=$((nr+1))||

The CodingGuidelines said we want to spell `$nr` instead of `nr`
inside arithmetic expansion for dash older than 0.5.4

I'm not sure if we should go with just `$((nr+1))` or it's better to
loosen our Guidelines. Since Debian Jessie (oldest supported Debian)
ships 0.5.7. I don't know about other systems.


-- 
Danh
