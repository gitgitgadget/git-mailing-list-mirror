Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D3C0C77B75
	for <git@archiver.kernel.org>; Wed,  3 May 2023 15:44:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbjECPoa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 May 2023 11:44:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjECPo2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2023 11:44:28 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE7A5BAE
        for <git@vger.kernel.org>; Wed,  3 May 2023 08:44:27 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-187fc21f6acso2306507fac.2
        for <git@vger.kernel.org>; Wed, 03 May 2023 08:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683128666; x=1685720666;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6lcrQX5XhvfV6hhgnIzGtMG+n9YNiUqmqqzTdmH/o8Y=;
        b=ixylZIvTUKhGh8JV1TTeYUrqLA0UwaHAwvPNSeThXyZpQkU4jTb/D4QSojOWqq54iY
         RQQsTim9A1MOCh5sOJkYWxjho1BMrDlrY5FXGtRFu+O5k6FbWv5rfq7YSDG+KIO3Nb0I
         xotVkk3e7GVG+j7REtcmKY14sVz//DWa90Zb6qmWjyrnqqMEUHWilsugv4bhdP8hN8An
         e9pZMa+X4XJEPdNflP5FlD3Bf7Bg4WS3UsogNzOiR3YfrikwnvW5NMAJ1euKpLrjATOj
         epF7JTmHILUp1OnystQGM6688UbrTwDmYNRf0IMoiJsU+8eaUwcbRQjJEal59TUvTlzJ
         AU2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683128666; x=1685720666;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6lcrQX5XhvfV6hhgnIzGtMG+n9YNiUqmqqzTdmH/o8Y=;
        b=FnLfoh3t970+t+k4zjc9omOy57gLk2Gqe4tICCjK1544vJV3QQVHUnv/VvDzJq6bkU
         rrbf+pUfP0wLyEakCXVjA3+AlSLqPpHm/i6WACt7dDfh18uO6ybZyHGXr3RLO+g7R08o
         SX2SUCXlcx/Mi8cUI1E7KnYQYYlP4wh9KCFIA6CDiSt2Hq2aqK495zeaYRmNmLDI8owQ
         kVlsRYI6h2zlKkh3MzeN+8cpqRtB+fsAhU1MAnPMH43EZGXwG8HyugDKYb6pOV8Ft3zr
         UhvPdrXgQecKDKfk0KnRcJ6CxWSkk9kioSTrm6DkG4dtTTVqghXxh/KsGU+lID/cDE47
         sj1A==
X-Gm-Message-State: AC+VfDyglNsAd1or97wG1Y0Ox0C646e7EGh1Av/YgUU1IwiMOPzMLt6V
        RtiB2JZ+tZZ+a2HxnLJdsi6lIHEG6rM=
X-Google-Smtp-Source: ACHHUZ7YQ8BTl6MRF21pxrKxGA4WMSFihheFr+21Iy59ay0dH1Pb46OesES+OjgW4pRS+rByLCnsjg==
X-Received: by 2002:a05:6871:302:b0:187:bbb2:9586 with SMTP id b2-20020a056871030200b00187bbb29586mr8645662oag.33.1683128666640;
        Wed, 03 May 2023 08:44:26 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id f35-20020a4a8926000000b00541b5963069sm2384119ooi.20.2023.05.03.08.44.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 08:44:25 -0700 (PDT)
Date:   Wed, 03 May 2023 09:44:24 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Adam Majer <adamm@zombino.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Message-ID: <64528158cdd1e_68229498@chronos.notmuch>
In-Reply-To: <70103746-6980-baed-13d9-afeae6cee464@zombino.com>
References: <ZEmMUFR7AJn+v7jV@tapette.crustytoothpaste.net>
 <20230426205324.326501-1-sandals@crustytoothpaste.net>
 <20230426205324.326501-3-sandals@crustytoothpaste.net>
 <xmqqbkjaqqfp.fsf@gitster.g>
 <20230427054343.GE982277@coredump.intra.peff.net>
 <6451a0ba5c3fb_200ae2945b@chronos.notmuch>
 <70103746-6980-baed-13d9-afeae6cee464@zombino.com>
Subject: Re: Is GIT_DEFAULT_HASH flawed?
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adam Majer wrote:
> On 5/3/23 01:46, Felipe Contreras wrote:
> > To be honest this whole approach seems to be completely flawed to me and
> > against the whole design of git in the first place.
> 
> The discussion above is mostly moot now since this has been fixed in 
> later patches in this thread, AFAIK.

That particular isssue might be fixed, but that issue should never have
happened in the first place if the design was correct.

A bad design makes certain errors prone to happen, a good design makes the same
errors happen rarely, a great design makes those errors impossible.

Git was designed to make it *impossible* to confuse two commits with similar
data.

The symptom might have been fixed, that doesn't mean there's no underlying
problem.

> It's also moot for other reasons, like the hash function transition plan is
> not really implemented, yet.

The implemention of the plan isn't the problem, it's the plan itself.

> Also, this was about corner-case, like it often is.

A corner-case that should be impossible.

> > In a recent email Linus Torvalds explained why object ids were
> > calculated based {type, size, data} [1], and he explained very clearly
> > that two objects with exactly the same data are not supposed to have the
> > same id if the type is different.
> 
> This is different. But aside, type + size + data are not really much 
> different from just having data in a hash function.

It's completely different.

> There are plenty of hash collisions where
> 
>      HASH(type + size + data) == HASH(type + size + data')
> 
> by definition of how these functions work. The problem is always in 
> finding these collisions. But anyway...

I don't think you understand why Linus Torvalds chose to hash objects.

> > In my view one repository should be able to have part SHA-1 history,
> > part SHA3-256 history, and part BLAKE2b history.
> 
> Yes, that would be great. Please provide patch series for this :-)

I have hundreds of patches being ignored, why would I write yet another patch
series that will be ignored?

> > I have not been following the SHA-1 -> OID discussions, but I
> > distinctively recall Linus Torvalds mentioning that the choice of using
> > SHA-1 wasn't even for security purposes, it was to ensure integrity.
> 
> These are different sides of the same coin. Hashes are used to provide 
> integrity. Hashes like MD4, MD5, SHA1, SHA256 are there for integrity. 
> Some of these are no longer recommended and some are completely broken.

There are different philosophical views of what "security" means, and it seems
pretty clear to me that your view does not align with the view of Linus
Torvalds.

> > Better the SHA-1 you know, than the SHA-256 you don't.
> 
> Wrong conclusion ;) Also, we know SHA-256

You don't understand what is being said.

Which hash is more trustworthy?

 a. 69c786637d7a7fe3b2b8f7d989af095f5f49c3a8
 b. d891b12414e1d9331f8cbb15acfe690671974f27ba76e2b423294cfb7a055f2f

If you answer b just beacuse it's SHA-256 you don't understand security.

b is a random commit I generated, a is the current git.git master.

A SHA-1 hash from a source you trust is inifinitely more trustworthy than a
random SHA-256 hash. Even a known MD5 hash is better in this respect.

> Keep in mind -- hashes are there for object reference.

No. I don't think you understand why Linus Torvalds used hashes.

> If you have SHA1 repo, you can calculate a SHA256 or whatever hash for any
> type object.

I know it *can* be done, I understand how hash algorithms work, but just
because something *can* be done doesn't mean it *should*.

You *can* generate a SHA-1 of a blob's data, instead of a SHA-1 of a blob's
`type + size + data`, does that mean we should? No.

> Finally, let not have a "bike shed" discussion about this.

Discussing the original design of git's object storage which has withstood the
test of time for 18 years is not "bike sheding".

I don't even think you understand what I'm trying to say.

---

Why do you think these commands generate different hashes?

  git hash-object -t blob /dev/null
  git hash-object -t tree /dev/null

-- 
Felipe Contreras
