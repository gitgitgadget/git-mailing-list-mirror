Return-Path: <SRS0=4z2X=6U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F365DC47254
	for <git@archiver.kernel.org>; Wed,  6 May 2020 00:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B51DD20659
	for <git@archiver.kernel.org>; Wed,  6 May 2020 00:30:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CEx3J8/v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728969AbgEFAac (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 May 2020 20:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728512AbgEFAac (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 May 2020 20:30:32 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 651BBC061A0F
        for <git@vger.kernel.org>; Tue,  5 May 2020 17:30:32 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id z1so132295pfn.3
        for <git@vger.kernel.org>; Tue, 05 May 2020 17:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=79vFJfz63hJpypO/g3Dp79fTHbO7g9ipizMjI6fgzgA=;
        b=CEx3J8/vhhjtUQBxbVfN03OApDWEvxVbu6n5w0I7vakuTyAtiVscSfKFQ1ufnGOcbQ
         sXpBzvG4RshJP2a9B4WRAWZthIWmxCVZAVa0ElrK8+SmJmYZL1Oo8td4gCJolA77iiNh
         IGkkyJ9cbgSFZ4Wm9Hod1QbFyIyt9MeIRnx6AM6LtQQWv051BvS4nqRsko5yp2xbD57x
         wp4GRgT73nH0Bci0TJO3v4LE8svl2KUwmxuDyA0j/dqpZPR5iQ1TNOS7WLPdAGFDn4/n
         3D9rehKzATP/k5DwgQV+vFTYipamy24cUi8+QbncXoSPx2PYEUQjK1WMe8/alxl/2REB
         Wg4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=79vFJfz63hJpypO/g3Dp79fTHbO7g9ipizMjI6fgzgA=;
        b=DUY9mXExji/shrJKjt24HQLVWaYz6S83/KaaQESuzjbjCWiTZlaVGPifTC3ugSuWOk
         BN8sXjqmhmEgN73CPXSfNsVphFOU0QPP70KYd/MTUfhPR7kcQAC2iAHY3dgVmNRTCtJ3
         Yz90PCJOHkdml/UbcGlyXa8CJ/HKgv5lfczwgYDYqEcsTxBe2BPtCiP3oGIxddJUmNuw
         tRcb5CABgvJrMs4Bz3SvRnU/7oh4Ay3zNMgRNsZGO7oyvQigHBqSfZfuvwok5Ntcgs+K
         OIgnOhv/U9hZDYFtvhi07ZoSjU8nVkQ8Ei0rXNf8zjAkeiFzs3diNQhcEVq+hlynpMF8
         21lw==
X-Gm-Message-State: AGi0Pua5SAyTXo/Y9FqpdKfTNaq07V57MPcsMffjWA/g83AvIEMygF1K
        rFMFmA8l3sP7FbrIWEfSRIrdEAne
X-Google-Smtp-Source: APiQypIRJpihdL3xNCa8ie8RiBQTJ10ZBOXdV7+DBGcAo1+a52gq93LsTGkhzE/NGjH/KMJHpquLow==
X-Received: by 2002:a63:7219:: with SMTP id n25mr4977673pgc.358.1588725031739;
        Tue, 05 May 2020 17:30:31 -0700 (PDT)
Received: from Carlos-MBP (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id z185sm250045pgz.26.2020.05.05.17.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 17:30:31 -0700 (PDT)
Date:   Tue, 5 May 2020 17:30:29 -0700
From:   Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH] docs: document credential.helper allowed values
Message-ID: <20200506003029.GB49541@Carlos-MBP>
References: <20200505231226.1280264-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200505231226.1280264-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 05, 2020 at 11:12:26PM +0000, brian m. carlson wrote:
> gitcredentials(7) already mentions several possible invocations that one
> can use as the value for credential.helper.  However, many people are
> not aware that there are other options than a simple credential helper
> name, so let's place some explanatory text in the documentation for
> credential.helper as well.
> 
> We still refer the user to gitcredential(7) for additional explanations
> and helpful examples.
> 
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  Documentation/config/credential.txt | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/config/credential.txt b/Documentation/config/credential.txt
> index 60fb3189e1..9d01641c28 100644
> --- a/Documentation/config/credential.txt
> +++ b/Documentation/config/credential.txt
> @@ -1,9 +1,13 @@
>  credential.helper::
>  	Specify an external helper to be called when a username or
>  	password credential is needed; the helper may consult external
> -	storage to avoid prompting the user for the credentials. Note
> -	that multiple helpers may be defined. See linkgit:gitcredentials[7]
> -	for details.
> +	storage to avoid prompting the user for the credentials. This is
> +	normally the name of a credential helper with possible
> +	arguments, but may also be an absolute path with arguments or, if
> +	preceded by `!`, shell commands.
> ++
> +Note that multiple helpers may be defined. See linkgit:gitcredentials[7]
> +for details and examples.

what about something even simpler, to encourage people to go see the full
range of options and hopeful find a fitting example in gitcredentials?

  "This is usually a credential helper application with possible arguments
   but might also be a simple shell one liner for the simplest uses"

with the Note following as you suggested.
 
Carlo

PS. I suspect a sample like the one you provided for smtp would be very
    useful there, specially if using an encrypted storage of sort.
