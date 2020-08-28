Return-Path: <SRS0=bfGv=CG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A82AEC433E6
	for <git@archiver.kernel.org>; Fri, 28 Aug 2020 20:09:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CD7120872
	for <git@archiver.kernel.org>; Fri, 28 Aug 2020 20:09:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IQ7c6me/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbgH1UJW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Aug 2020 16:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbgH1UJV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Aug 2020 16:09:21 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5573AC061264
        for <git@vger.kernel.org>; Fri, 28 Aug 2020 13:09:21 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id 109so292838otv.3
        for <git@vger.kernel.org>; Fri, 28 Aug 2020 13:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iSae/a7zVEdg494vK0dxi1NIebdImS5JoWmQmndmoNQ=;
        b=IQ7c6me/ippzdkE9gCSeOwqcyPIm8Z3gimRCRkR+1qYCkYpWB24VUiboe4LArbQD/f
         +4RrHd1Hb9BfT3w0tI7nkAeNPNs3ncb7GPaks/ATSuLkM6jVVEMDKEqRMcnE4wwAXvea
         Xr0IOWxuyO+eHuYKzvhDvFwCeutpXOlwiUvjqj/A+iJmHLX0Y5H5dXYFvbx+eg6eTgHW
         NoluS+BqY0+A7WcU5qLZ483QKLPlcZuIDqPu0rdTf35OVvKWHVAh1CmBABRxrHq2KyTk
         mQSymci4h3WN+mxnZ3MsE6s4jb6l24k9VRpDv0qcPN/5cgUiAVDJQXWMq2R0nqSPUOaP
         rW2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iSae/a7zVEdg494vK0dxi1NIebdImS5JoWmQmndmoNQ=;
        b=FaoFTYTZ2jzhO1yLfltA3s87LJiIUOr0zedkB2ci1N9ScK3iWg4Y6ikAaJhDIS6Dzq
         Cxaa0pfgrVuIjNkSZ+3nsK8yzKAo6J3MMDTSimu4HgUNdqNzvJuyyr9NmP8A7Naf90Ie
         ij7o7BVUz5Jdt9V1NAkQfW809xvhiod9lUNjIA2oJi+HspeiT5EyaWLx9wMWg1pL3IN+
         FfasQiBJH9KYeCqzZtFD8aWJCHHV3WcKC8btOwT5k39g4wH5oLvuaDP/MdXsOLBax8R8
         iCcBKANEu5gB31OBCgrqV40PfzJyVBJ8ixIKe9y739mZ+8iQkwAz3SAEBwf9pq8k+rAc
         0M4w==
X-Gm-Message-State: AOAM530qWJwzY4CfNa574BcQ1L7CcY5PYcaV35s95gEkskPoLuP45inh
        BH+/FT+Eq3ijs0f4g5YAKvvbbzyVYy14w4ETN0Y=
X-Google-Smtp-Source: ABdhPJwRyBf4AiZ9Zh5LjIYPNgNjwBFL/C0YY0ShHuLyfhlTkQfNeYnKvXM76kBBJsbZWvyH2Mduwt+hJeE33qlLSeg=
X-Received: by 2002:a05:6830:155a:: with SMTP id l26mr218577otp.177.1598645360241;
 Fri, 28 Aug 2020 13:09:20 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqh7snpxy1.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqh7snpxy1.fsf@gitster.c.googlers.com>
From:   Hariom verma <hariom18599@gmail.com>
Date:   Sat, 29 Aug 2020 01:39:07 +0530
Message-ID: <CA+CkUQ_=qm2x2zKvgHnvKLLA_A23gTNm8Q8CeWxLFGSBi=9gKw@mail.gmail.com>
Subject: Re: What's cooking in git.git (Aug 2020, #07; Thu, 27)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Fri, Aug 28, 2020 at 3:14 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> --------------------------------------------------
> [Cooking]
>
> * hv/ref-filter-misc (2020-08-17) 9 commits
>   (merged to 'next' on 2020-08-27 at c015fa6b0f)
>  + ref-filter: add `sanitize` option for 'subject' atom
>  + format-support: move `format_sanitized_subject()` from pretty
>  + pretty: refactor `format_sanitized_subject()`
>  + ref-filter: add `short` modifier to 'parent' atom
>  + ref-filter: add `short` modifier to 'tree' atom
>  + ref-filter: rename `objectname` related functions and fields
>  + ref-filter: modify error messages in `grab_objectname()`
>  + ref-filter: refactor `grab_objectname()`
>  + ref-filter: support different email formats
>
>  The "--format=" option to the "for-each-ref" command and friends
>  learned a few more tricks, e.g. the ":short" suffix that applies to
>  "objectname" now also can be used for "parent", "tree", etc.
>
>  Will merge to 'master'.

I sent an updated version of the patch series addressing your comment
concerning new file format-support.{c,h}[1].

If you are still unsure about adding a new file, you might want to
take a look at the updated version of patch series:
https://public-inbox.org/git/pull.684.v4.git.1598046110.gitgitgadget@gmail.com/

Footnote:
[1]: https://public-inbox.org/git/xmqqlfid1305.fsf@gitster.c.googlers.com/

Thanks,
Hariom
