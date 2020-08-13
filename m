Return-Path: <SRS0=IFun=BX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B412EC433E1
	for <git@archiver.kernel.org>; Thu, 13 Aug 2020 15:11:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A1522087D
	for <git@archiver.kernel.org>; Thu, 13 Aug 2020 15:11:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="QyIyXR7o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbgHMPLk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Aug 2020 11:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbgHMPLk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Aug 2020 11:11:40 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F632C061757
        for <git@vger.kernel.org>; Thu, 13 Aug 2020 08:11:39 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id l13so2755451qvt.10
        for <git@vger.kernel.org>; Thu, 13 Aug 2020 08:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+1snnUxsqfUoemGj+1qNlVlgv+AMQfLfS6w8Lkc3nFs=;
        b=QyIyXR7oml7NDyQ+FyEQPovQWfPsO+LQmrTaJuKtGixT/dU0E+GmTTWTXOZLsM2D+4
         If6YgQ0HFFS+b/+MWndG2GhXbbCglVgJ/EOEgSADY63LenOgwXDFCdiqCKbaYXc4+QKf
         nkXJIB3piEh0qE0hT5dLXhgDS33LstxalM7/qvGJP1VX7vh7wlWixaGIp05tiTQKUKZu
         PSR09y2PYVrewo6eBhZ2isrntlLCMNq+AKQD3m0MJNhN5bakglNr9l+ooCPxb9whlzUf
         90cKlTyhspyPRjakxdWx4CWTCGZii1jo3SA8bkaGh9eWe3KIh/D8cHLWxS3DG/jcp93B
         fprg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+1snnUxsqfUoemGj+1qNlVlgv+AMQfLfS6w8Lkc3nFs=;
        b=puxZ4ordxIvi55RLEo4iPBl9178jcDS8jES61Qcm4eMv8dmUywl2uuCXZtXyzgn5Hd
         yFHFUs7ICFFWALdK7ta7AhA6pj7xc2h1oNK6TDlBkTYlW2ykPyhBh44uotiXhPb+0FnK
         QQ5jUsIbFX3inzeZ9dsMsXuHUiQPT25yXxDfJENITCXbVZd4ua7T9aqNqeQy7PdIUtUY
         cjuHtGKfVT7uKnSZoexTQIIAY998nAoOf3KZlfUDlG9zPdcCrxJV57Wv4PBJMbv9TCeR
         d7K1893vh2ByDX+F7GWz+hLka83K8hWuBw7m7x9gq1r1x7lnWilDd1IeVrmzXSaChwYP
         nzXg==
X-Gm-Message-State: AOAM531KO2bd4/7LSRPJKW0TOnvya+wY9JiTZOCpEcnAFpV0v1NtBoIU
        +tnJSsvNEI5SL/ysBGiNTj8Z3g==
X-Google-Smtp-Source: ABdhPJzph2egY3k0BpnYtQZEnAgCy51UEERQlOXibgt/LiDaqXEDyVpdlAmJ5H82AQIaAY9PFHRLvQ==
X-Received: by 2002:ad4:5189:: with SMTP id b9mr4944246qvp.242.1597331498673;
        Thu, 13 Aug 2020 08:11:38 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:cdcd:c658:5bb1:ebc9])
        by smtp.gmail.com with ESMTPSA id r18sm7148738qtc.90.2020.08.13.08.11.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 08:11:37 -0700 (PDT)
Date:   Thu, 13 Aug 2020 11:11:36 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 5/5] drop vcs-svn experiment
Message-ID: <20200813151136.GC2244@syl.lan>
References: <20200813145515.GA891139@coredump.intra.peff.net>
 <20200813150017.GE891370@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200813150017.GE891370@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 13, 2020 at 11:00:17AM -0400, Jeff King wrote:
> The code in vcs-svn was started in 2010 as an attempt to build a
> remote-helper for interacting with svn repositories (as opposed to
> git-svn). However, we never got as far as shipping a mature remote
> helper, and the last substantive commit was e99d012a6bc in 2012.
>
> We do have a git-remote-testsvn, and it is even installed as part of
> "make install". But given the name, it seems unlikely to be used by
> anybody (you'd have to explicitly "git clone testsvn::$url", and there
> have been zero mentions of that on the mailing list since 2013, and even
> that includes the phrase "you might need to hack a bit to get it working
> properly"[1]).
>
> We also ship contrib/svn-fe, which builds on the vcs-svn work. However,
> it does not seem to build out of the box for me, as the link step misses
> some required libraries for using libgit.a. Curiously, the original
> build breakage bisects for me to eff80a9fd9 (Allow custom "comment
> char", 2013-01-16), which seems unrelated. There was an attempt to fix
> it in da011cb0e7 (contrib/svn-fe: fix Makefile, 2014-08-28), but on my
> system that only switches the error message.
>
> So it seems like the result is not really usable by anybody in practice.
> It would be wonderful if somebody wanted to pick up the topic again, and
> potentially it's worth carrying around for that reason. But the flip
> side is that people doing tree-wide operations have to deal with this
> code.  And you can see the list with (replace "HEAD" with this commit as
> appropriate):

I have nothing to add to this email other than to say that I think it
makes sense to remove this. I agree it would be nice if somebody picked
it up, but given that nothing has really changed since ~8 years ago, I
think that it's unlikely to happen in the next ~8 years ;).

At least, it seems unlikely enough that dropping 2MB from the
installation size is worth it. If someone *is* interested in picking it
up, I'm sure that they won't have trouble finding this patch and
reverting it.

Thanks.

> [snip]

Thanks,
Taylor
