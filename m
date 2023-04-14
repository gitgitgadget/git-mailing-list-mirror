Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9EE6C77B71
	for <git@archiver.kernel.org>; Fri, 14 Apr 2023 16:20:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjDNQU1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Apr 2023 12:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjDNQU0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Apr 2023 12:20:26 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68D3D6A58
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 09:20:15 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-187a1387021so4912423fac.3
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 09:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681489214; x=1684081214;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6uZzR/41HwkPcNCkXwexz2bc1XgtGWKs8FbTozi0DE4=;
        b=J0BGbZG49a++P2lDbttL3j5DPDGcfvwEgsAa571lfKopzevPINcb9iidCCBngFbPzJ
         PscdJ4jaClD1otkoMGNd3a2rVdKv0PDMsWU87Rc+4yZaQcxsyMMdPpnof0sn1MT5i7jZ
         JM4T4wmJcATIeZ8GC/8Y9RGN+rswNNtXMG4bwh3y8ycwhKnAwhIK0HXVGdWFSo4MBzRC
         VjdDW3aagqs9ckgRH2M5K3CMXbdFcefRqFh6tIKicH8BZQjFDbrlPpZpUNhvrLWwYBxe
         qa+iFtdwV2lNxZeSq+Cxir1UbZ2l47m4UVQjAVRXIeINy2vLWltQHB1nFjyi6UVRsIua
         SQVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681489214; x=1684081214;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6uZzR/41HwkPcNCkXwexz2bc1XgtGWKs8FbTozi0DE4=;
        b=hCjpuxqLNbKxVPNL9tZOa64m7vBupHq8RFcYULFMGpdaXI9/dIeMu+0dCqe+1PPaIe
         RPGGi9oc3ZkysEYbWj8jW9cgvY6YQqj6+wfl6XazR7Rz/ChFUHoBvJWPQsGE5GT0KU9I
         n2JEDgE/rvllAp6IgzF4tdiEhv3bByKh86KZ/66HrkBhdhUON2t8qkXmNmqHeIME1ZCD
         9Ck/JWuaXPIhwo7hEGdkW7OR8m9tSmR85/CcxIpujlQDUL8aqdok2ZKDCvtZO9U1Vwai
         /iwX2O4iAuD/RNUpAqfbd7TyjVg1XIUGVJcegUTTEnyqFvqj5YOlA9aDROGI1NqgAVz8
         Zy8w==
X-Gm-Message-State: AAQBX9eOJEv5kVvPbj+auzEoK77Y/GkZchSaKH2AWNp/DGhoe9kzAtb/
        whZ3v7o2bInFmLWtDGLGBKA=
X-Google-Smtp-Source: AKy350Ym4gXWNJ7MPd7JVmAzvf75EYMaZjRyYwTMGKnHarPqty660mTLwUTnF0+5KoS7OMtp62Hesw==
X-Received: by 2002:a05:6870:b016:b0:16e:92d2:e810 with SMTP id y22-20020a056870b01600b0016e92d2e810mr3532758oae.53.1681489214570;
        Fri, 14 Apr 2023 09:20:14 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id t6-20020a4aadc6000000b005252407f6cbsm1802956oon.30.2023.04.14.09.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 09:20:14 -0700 (PDT)
Date:   Fri, 14 Apr 2023 10:20:13 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
Message-ID: <64397d3d67d21_5e3ce294a6@chronos.notmuch>
In-Reply-To: <xmqq5y9yv601.fsf@gitster.g>
References: <20230413074722.71260-1-felipe.contreras@gmail.com>
 <20230414070449.GA540206@coredump.intra.peff.net>
 <xmqq5y9yv601.fsf@gitster.g>
Subject: Re: [PATCH] doc: set actual revdate for manpages
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:

> > diff --git a/Documentation/Makefile b/Documentation/Makefile
> > index 2ccc3a9bc9..307634a94f 100644
> > --- a/Documentation/Makefile
> > +++ b/Documentation/Makefile
> > @@ -144,8 +144,6 @@ man5dir = $(mandir)/man5
> >  man7dir = $(mandir)/man7
> >  # DESTDIR =
> >  
> > -GIT_DATE := $(shell git show --quiet --pretty='%as')
> > -
> >  ASCIIDOC = asciidoc
> >  ASCIIDOC_EXTRA =
> >  ASCIIDOC_HTML = xhtml11
> > diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
> > index 9a1111af9b..14903bd261 100755
> > --- a/GIT-VERSION-GEN
> > +++ b/GIT-VERSION-GEN
> > @@ -10,7 +10,8 @@ LF='
> >  # then try git-describe, then default.
> >  if test -f version
> >  then
> > -	VN=$(cat version) || VN="$DEF_VER"
> > +	VN=$(cut -d" " -f1 version) || VN="$DEF_VER"
> > +	DN=$(cut -d" " -f2 version) || DN=""
> 
> Are we sure historical GIT_VERSION strings never had a SP in it?
> I would be very surprised if we did, but the correctness of the
> approach depends on that assumption.

Why would that matter?

Supposing a hypothetical tarball with a version '0.99 foo', it would have a
corresponding GIT-VERSION-GEN (which didn't check for such file until 1.1.1),
and it would know how to parse it.

In other words: all three are tied together: the 'version' file, the
GIT-VERSION-GEN script, and the tarball that has them both.

-- 
Felipe Contreras
