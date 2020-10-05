Return-Path: <SRS0=R7wA=DM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58F46C4363A
	for <git@archiver.kernel.org>; Mon,  5 Oct 2020 08:12:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA60420781
	for <git@archiver.kernel.org>; Mon,  5 Oct 2020 08:12:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AHvJbGHP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725914AbgJEIMg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Oct 2020 04:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbgJEIMg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Oct 2020 04:12:36 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D9F6C0613CE
        for <git@vger.kernel.org>; Mon,  5 Oct 2020 01:12:36 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id t14so5505016pgl.10
        for <git@vger.kernel.org>; Mon, 05 Oct 2020 01:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Jeubxp9V/LHMPR2bjwoFvfcKIwBa+o3T73JPQuxtvMU=;
        b=AHvJbGHP2BKLB8dY38Tym7ItWIUuXY6i0+mvIUxXtXesm3fKETzECpA2YpydGZYRXT
         msGvofUTZoFr+AKsgFCQfWebtS3kJWRsNXHOAIA4VBYeUDOqrm+HQ72BAT2/oSdbGULc
         /Igfvm2QaMUmR1lqrpgytGpSjd5Nv7ZGEVbwgI9VHrBakj9SuNrEhfSrCbHWkErkS7co
         lwekSq9Ac+8ywJrof7sOqCqWMXC/OuFoX9l04QMJPAV7AoMZjVzXGaInk5Vpk/MFmad4
         cs8RtYJujWybgUJ18uszvF70cYpV3yhfKBEj3zoN0JBc2Uw8Ii/FSgR0aP1qNM2dj2+P
         dd/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Jeubxp9V/LHMPR2bjwoFvfcKIwBa+o3T73JPQuxtvMU=;
        b=FTizJWe7/iTWoPF8fgtTHJOp1/sQZoYV7Rh6m9GVGehh8SylACa+TBFrQLZZf4YUff
         RkaxrYonOEDGqI5pW6g9Vd6Dz8BEd66b17g3n0oJbRkw0Yv3W75ibcbnnyjtfErlcTkW
         Oxumzo1AKxu4ELhNxWko+iksVosh1U+l/Ba0Xn+2Br4Tn4XDjsZzMCEvA7qlIT+A4hqK
         FkZlMod9tvtebiG96jbYuWnyFR03Zo44kBZlETKtXtGJfJT92NuIjYorLjVUid62QfHB
         JlY/9ABoCJxfsi+qZmgFmKx9esoDHkqkToGXaQCj6Xrf2Y8xmgJgIq8BRTCOqto0vLIe
         r1Tw==
X-Gm-Message-State: AOAM530Hcd7qN9Oub3KFrfaBCyLNpYtM42u0m+TASCZFlowsoI7d1mwu
        NaxTe6vxv4LNu8vcZOVG/gk=
X-Google-Smtp-Source: ABdhPJwAW+h7+eDZjKDhl2o0r7B6SzKCGlVqk8mkcbveyaP9yuGWPjx9SrwPzpscZNMzQ+1FNQuOig==
X-Received: by 2002:a05:6a00:1b:b029:13e:d13d:a101 with SMTP id h27-20020a056a00001bb029013ed13da101mr15458106pfk.29.1601885556026;
        Mon, 05 Oct 2020 01:12:36 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:a28c:fdff:fee1:cedb])
        by smtp.gmail.com with ESMTPSA id c10sm763212pfc.196.2020.10.05.01.12.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 01:12:35 -0700 (PDT)
Date:   Mon, 5 Oct 2020 01:12:33 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 7/7] fsck: complain when .gitattributes or .gitignore is
 a symlink
Message-ID: <20201005081233.GJ1166820@google.com>
References: <20201005071751.GA2290770@coredump.intra.peff.net>
 <20201005072503.GG2291074@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201005072503.GG2291074@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:

> The previous commit made it impossible to have a symlinked
> .gitattributes or .gitignore file via verify_path(). Let's add the same
> check to fsck, which matches how we handle .gitmodules symlinks, via
> b7b1fca175 (fsck: complain when .gitmodules is a symlink, 2018-05-04).
>
> Note that we won't add these to the existing gitmodules block. Its logic
> is a bit more complicated, as we also check the content of non-symlink
> instances we find. But for these new files, there is no content check;
> we're just looking at the name and mode of the tree entry (and we can
> avoid even the complicated name checks in the common case that the mode
> doesn't indicate a symlink).

On the subject of where the check gets added, the old description said

	It's easier to handle than .gitmodules, because we don't care
	about checking the blob content. This is really just about
	whether the name and mode for the tree entry are valid.

which I think was self-explanatory enough.  The new text is a little
more confusing because I get lost in figuring out what the "it" in
"Its" refers to.

> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  fsck.c                    | 15 +++++++++++++++
>  t/t7450-bad-meta-files.sh |  9 +++++++++
>  2 files changed, 24 insertions(+)

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Thanks for a pleasant read.
