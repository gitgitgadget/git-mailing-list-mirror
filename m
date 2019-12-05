Return-Path: <SRS0=7IA6=Z3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9762C43603
	for <git@archiver.kernel.org>; Thu,  5 Dec 2019 10:27:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83E0F24654
	for <git@archiver.kernel.org>; Thu,  5 Dec 2019 10:27:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WY0aFm3l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729223AbfLEK11 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Dec 2019 05:27:27 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:37332 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728707AbfLEK11 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Dec 2019 05:27:27 -0500
Received: by mail-pj1-f65.google.com with SMTP id ep17so1129594pjb.4
        for <git@vger.kernel.org>; Thu, 05 Dec 2019 02:27:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/kB+rphAc0nuJJBEns/ktL13BOBybjMLArdQEIrvlEc=;
        b=WY0aFm3lUFOWK4LzLWUfc9ur0kiGej6MAJRQtFwpju0q6CXdokCcYKhuYfQNiiGKcy
         a7en9I7LdN+t2jgp3luQb7SwGqeGUN4DJlp8eKuGkFHw0zS2+8j3O/jTq2T+8U9Cjfxl
         qHsbtOMUfn9pVvvl5a1iH36aBZHhvUdBviISy5Nu+6xc9Ux/nSbKNaRxptbCnigElnaH
         7xHovHg2oHqLVHuUhIZ61vrS7Vp+gC/RCq7PbUGK3tAh9/BOAGpWjjJjHNmiS4NLZW/h
         nMmBmghDxNr/4Z0NgTJ9Jgw/cNUTZVP1ssBv2jWynwk8JiUD4Tm7jbw9F23ud5JvnL0r
         a3JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/kB+rphAc0nuJJBEns/ktL13BOBybjMLArdQEIrvlEc=;
        b=Vsp0UEVonyfdrOC8H+hCw7mgMscC48DzPwBnmXgXZTiLV1q+mEBgBi/tAonk7wrQ1o
         YTzUXP/kQsGZEgvISPJ/lxYV2dVvIsza1AU4wcMWLnJcxzqV5MZnc2s7IlgTtMmvfhiv
         03IBZj+vrAQXRDR533oNX5Ul+UeSKQr02ekK0Jr7UAhCS+LvsKk4OcUwLN6WXbDmQjuy
         MI/qoLqnmPHeETsSUb4f6772PBMNQJp6oXWeuEUW7rdUo5Ug/nybsNx/wXjGYhVfVclE
         P+zfOrZS0hqnuxDLdxR6ZfMOzKhRQrMSTfIzXDcJiAV6Z/pN6Js7U+gbwpB8NXOAhDyC
         OOqw==
X-Gm-Message-State: APjAAAXUExHoM7i4YsVGXzYpBIuLH8GHUxhAFqujQxQjVVOk9TEQxmjg
        QtqXSQUdTgm+zvF8Kr7cFwbkLJTY
X-Google-Smtp-Source: APXvYqxyq0kGRxPhzlpSzfHryMmSl/oDRGP4VtG5SsuN86yVlTCYDh57H/KGWp7QEgf+X8O974Ouzw==
X-Received: by 2002:a17:902:59c9:: with SMTP id d9mr8066345plj.184.1575541646371;
        Thu, 05 Dec 2019 02:27:26 -0800 (PST)
Received: from generichostname ([2601:646:280:1b30:b0bc:639f:d5c8:2bcf])
        by smtp.gmail.com with ESMTPSA id v72sm9486988pjb.25.2019.12.05.02.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2019 02:27:25 -0800 (PST)
Date:   Thu, 5 Dec 2019 02:27:24 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Ben Keene via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Ben Keene <seraphire@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 02/11] git-p4: change the expansion test from
 basestring to list
Message-ID: <20191205102724.GB315203@generichostname>
References: <pull.463.v3.git.1575313336.gitgitgadget@gmail.com>
 <pull.463.v4.git.1575498577.gitgitgadget@gmail.com>
 <0ef2f56b04803cad2e60bf881e86d8bdd69463a6.1575498577.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ef2f56b04803cad2e60bf881e86d8bdd69463a6.1575498577.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ben,

On Wed, Dec 04, 2019 at 10:29:28PM +0000, Ben Keene via GitGitGadget wrote:
> From: Ben Keene <seraphire@gmail.com>
> 
> Python 3+ handles strings differently than Python 2.7.

Do you mean Python 3?

> Since Python 2 is reaching it's end of life, a series of changes are being submitted to enable python 3.7+ support. The current code fails basic tests under python 3.7.

Python 3.5 doesn't reach EOL until Q4 2020[1]. We should be testing
these changes under 3.5 to ensure that we're not accidentally
introducing stuff that's not backwards compatible.

> 
> Change references to basestring in the isinstance tests to use list instead. This prepares the code to remove all references to basestring.
> 
> The original code used basestring in a test to determine if a list or literal string was passed into 9 different functions.  This is used to determine if the shell should be evoked when calling subprocess methods.

Once again, I'd swap the above two paragraphs. Problem then solution.

Also, did you mean "invoked" instead of "evoked"?

> 
> Signed-off-by: Ben Keene <seraphire@gmail.com>
> (cherry picked from commit 5b1b1c145479b5d5fd242122737a3134890409e6)
> ---
>  git-p4.py | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)

The patch itself looks good, though.

[1]: https://devguide.python.org/#branchstatus
