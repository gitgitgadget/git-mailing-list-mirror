Return-Path: <SRS0=JCNZ=6S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 430D2C3A5A9
	for <git@archiver.kernel.org>; Mon,  4 May 2020 15:58:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11F95206A5
	for <git@archiver.kernel.org>; Mon,  4 May 2020 15:58:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qy1gneL4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728983AbgEDP6p (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 May 2020 11:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725941AbgEDP6n (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 4 May 2020 11:58:43 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81A2EC061A0E
        for <git@vger.kernel.org>; Mon,  4 May 2020 08:58:40 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id x15so5699317pfa.1
        for <git@vger.kernel.org>; Mon, 04 May 2020 08:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Sejq7OLLw2OSmnhfphOm7a5fE7QdBYKk3Th5/5aMX5U=;
        b=qy1gneL4fM23LVKAz/yuKoFMWf5OuMACHi03aniWn7BwUus8moGt4F7BPlQ+8WNIel
         8ZKpvXciOLVGdimujVl8Zp569AhF96TkCa5JBCN4gZXVZZLB8xhNpXovuXUy+trDx2M/
         5M/pGt1k2z/OUuIiA0XhDn3f/hbdl3fbe4biYC5Pvdy7EOMt2qUjMFrAsyadH7K4fdiG
         Xh1c4zmrYmZB+lmE6xYozsduqsu553B6owlM7fLfBzirLpMilaPi3sE7RVv+r1Hz3Idd
         98lolI1teOyRD2Mq8uYZrNkb6eiSx05eCYyZsGwJ5wJUSLl3Io11N85e+wG8RGkqyoLy
         evFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Sejq7OLLw2OSmnhfphOm7a5fE7QdBYKk3Th5/5aMX5U=;
        b=LJEMmZYOYQtbVpH94p+wsf6tWPXmxVIdbMsAYtkX9QtypKorhdKO6UpEJZocDHA4vE
         cp5amC5LLc8kNEeKuZ/tfNlqM58xzBAYB7FiYUgTZogIvAkrUwVpmy/VmuVySsH/JJxL
         rLv6jKJrFXP/Reu/JQeQssAMvQAZJ6lyn4v+UsKL0Z0Z29RuReaSgHX88azgcqK24Wv2
         ynKAZxB8rYoKPFGA9UVvpBJV8Ri4sWTG4Nga2v7NtBTqL2+vszeqVzSvFhy+9be12kY4
         v90z/gcI0Nkq8kHyS98zXYmgk6uHzULkNV/Shx6A65GIjd7N3//QmI0QavmLxvnkDScI
         OWxg==
X-Gm-Message-State: AGi0PuZle1i5+CmQaaF8juoEAGlDy0wGR3cNdN9A59XfiDAMbEn4KSb3
        WCbyHksajhrdJNAONUsa3lnx8DA6
X-Google-Smtp-Source: APiQypICSJ5eGWeOMD+NRDOyWckK9RlLvGgiu0YQasqT6egmaLSr4e58gEczeSju3aTFOJMaMCY+bQ==
X-Received: by 2002:a65:6798:: with SMTP id e24mr7370460pgr.316.1588607919883;
        Mon, 04 May 2020 08:58:39 -0700 (PDT)
Received: from Carlos-MBP (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id ml24sm7286112pjb.48.2020.05.04.08.58.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 08:58:39 -0700 (PDT)
Date:   Mon, 4 May 2020 08:58:37 -0700
From:   Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, jrnieder@gmail.com, jalopezsilva@gmail.com
Subject: Re: [RFC PATCH] credential: minor documentation fixes
Message-ID: <20200504155837.GD86805@Carlos-MBP>
References: <20200503063423.83152-1-carenas@gmail.com>
 <20200503065826.GB1829906@coredump.intra.peff.net>
 <20200504074520.GB86805@Carlos-MBP>
 <20200504144436.GA9893@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200504144436.GA9893@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 04, 2020 at 10:44:36AM -0400, Jeff King wrote:
> On Mon, May 04, 2020 at 12:45:20AM -0700, Carlo Marcelo Arenas Belón wrote:
> > * clarification on which fields can be updated by the helper; currently I
> >   don't think we allow overrides for protocol and host and assume all others
> >   but the documentation doesn't clarify, and that might be a problem for
> >   cert:// where file is more relevant.
> 
> I think we do allow a helper to transform a credential in any way:
> 
>   echo url=https://example.com/ |
>   git \
>     -c credential.helper='!sed >&2 s/^/one:/; echo host=other.example.com;:' \
>     -c credential.helper='!sed >&2 s/^/two:/;:' \
>     credential fill
> 
> produces:
> 
>   one:protocol=https
>   one:host=example.com
>   two:protocol=https
>   two:host=other.example.com
>   Username for 'https://other.example.com': 
> 
> So after the first helper runs, subsequent helpers (and the internal
> terminal prompt) will consider the modified hostname.

correct, and that is because the specification (and the current code) does
say that is a valid operation.

what I meant is that we don't REALLY allow those modification to take place
since the credential helper suggestions can't really affect what git assumes
is the right host or protocol (or FWIW path), unlike username/password  and
so they don't seem worth having IMHO.

> Now whether that's a sane feature or not, I'm not sure.

would restricting the output of the credential helpers to username and
password make more sense in this context then?

obviously this change will required both the protocol (definition and
implementation) to change an changes on ALL helpers but I thought that was
the objective of that documentation suggestion in Jonathan's original email.

I agree though the discussion of if that is something we should do in a
maintenance release or not, is worth having; but I suspect it could be
implemented with reasonable enough backward compatibility to be considered.

Carlo

CC adding the author of cert:// too easy on that part of the discussion
