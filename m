Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0D4AC433DB
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 20:46:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F93A64DF5
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 20:46:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbhCHUqH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Mar 2021 15:46:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbhCHUpn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Mar 2021 15:45:43 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 849D0C06174A
        for <git@vger.kernel.org>; Mon,  8 Mar 2021 12:45:43 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id dj14so5328829qvb.1
        for <git@vger.kernel.org>; Mon, 08 Mar 2021 12:45:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9VbebeftMSb2skZH/+TJAuwisWifxrtmHd082R31/bE=;
        b=Qi2IX0nhdAfPdn3ucf8JHBTqvFsv4Ja3FNVStEI6zE0hNt84InfKYIRxP+Jq55uzQf
         5xrxbw4VfNM4rfdTcdD7eMhK1iXVScIn2JGgRW1mHUGoZrUGZdtEXP0VypzLSlgh4tR3
         Xcta9BHpW1G/KtcIoiTXf5iD6AU3tr1AdU30iOFMOj51FlxyqD8uhJKt0iHpsgP9W1cG
         2saI3Bac+mbRwnHg4sQyOTaG8gQlNk391Fpwkd2j6gGWDjedM5YmZ/8yI2azi/8WFdwe
         bv2nmkWrUv7dI2S+zYV0EMoo+WGuN1QLiDSvE94PuQ8IigRwOXwa3gW1DKCMo8BEjRhL
         ygfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9VbebeftMSb2skZH/+TJAuwisWifxrtmHd082R31/bE=;
        b=R05/qhe3DCZO3fVEGbKVFCbqfmI5miftfN1egcalZvjQZi+XoAkKY8BaWLZy1r+kN9
         vMpg/sI55Eeb+t+ag0geq8APqMa7/T9zG99uqVOlzSIJQfbh0lcR2m5+ySPKe2AQNFX4
         e60cg4qFZYPDF7/pgI+Q59s2ax9NYx435/Ph9sQ9ST/ZU2b4KNxvn0VQXxhuNB+VzNFU
         YatiHEUh/uq/x164YN+vsNyFvP2PA/Veyqq2x0VxTOA5ySikO4lvGLCygcQ/a2gpZuKU
         6pVmUqDFAcCPYHTG4mlV2wiOWW9pjq6rNO/9mjrH2ER5D1aiGnT0AhkRz20PzudT+wHF
         oOVA==
X-Gm-Message-State: AOAM532ZnpKz7Krnhc5AshIFr5Gm161Xug6egttLBrkzvcXeqX/POLX5
        QN4/jsJqAHAYfEj93gjb8QrcTg==
X-Google-Smtp-Source: ABdhPJzUFpqnO25UJAJof0P1q/9kiw5VjHGPfwiFxpOYIu8rpx15+sN3RY9xR4Qr90fc8cSnB2TGHQ==
X-Received: by 2002:a05:6214:194f:: with SMTP id q15mr22937535qvk.46.1615236342681;
        Mon, 08 Mar 2021 12:45:42 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:d4a3:1166:858b:6d61])
        by smtp.gmail.com with ESMTPSA id v35sm8632357qtb.20.2021.03.08.12.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 12:45:42 -0800 (PST)
Date:   Mon, 8 Mar 2021 15:45:34 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        Fabien Terrani <terranifabien@gmail.com>, git@vger.kernel.org
Subject: Re: remote.<name>.merge missing from the git-config man page?
Message-ID: <YEaM7ruZCvaQQbPI@nand.local>
References: <CAOuwed4HJLTgk48Fre5vGYjYanqD6hu8yZM73CpcAmF1ajiTnA@mail.gmail.com>
 <xmqqlfax7dya.fsf@gitster.c.googlers.com>
 <YEZwY0721KvQNkK+@nand.local>
 <87pn092yja.fsf@igel.home>
 <YEaI5JIobsbtBQO1@nand.local>
 <87lfax2xat.fsf@igel.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87lfax2xat.fsf@igel.home>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 08, 2021 at 09:41:14PM +0100, Andreas Schwab wrote:
> >> >  `git push origin`::
> >> >  	Without additional configuration, pushes the current branch to
> >> > -	the configured upstream (`remote.origin.merge` configuration
> >> > +	the configured upstream (`branch.<name>.merge` configuration
> >> >  	variable) if it has the same name as the current branch, and
> >> >  	errors out without pushing otherwise.
> >>
> >> That doesn't say what <name> is.  Is that supposed to be <branch>?
> >> Also, what is "it" referring to in "if it has the same name"?
> >
> > <name> refers to the currently-checked-out branch's local name. (That's
> > how it's used in Documentation/config/branch.txt).
> >
> > The antecedent is "the current branch", so I think that this one may
> > already be quite clear if you read past the parenthesis.
>
> That doesn't make sense: "if the current branch has the same name as the
> current branch".

OK, now I see where your confusion is. I was incorrect in saying the
antecedent was "the current branch"; it should instead by "the
configured upstream". IOW, "if both your and the remote copy call the
branch you have checked out the same thing."

Re-reading the original wording, I still think that it is clear enough
to communicate what I wrote above, but if there is an alternative
wording you find clearer, I would certainly welcome suggestions.

Thanks,
Taylor
