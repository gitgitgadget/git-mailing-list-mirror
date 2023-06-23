Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E667CEB64D7
	for <git@archiver.kernel.org>; Fri, 23 Jun 2023 19:17:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231523AbjFWTQ7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jun 2023 15:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbjFWTQ6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jun 2023 15:16:58 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0422FE5B
        for <git@vger.kernel.org>; Fri, 23 Jun 2023 12:16:54 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-3f828ee8ecdso1324121cf.0
        for <git@vger.kernel.org>; Fri, 23 Jun 2023 12:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687547813; x=1690139813;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=IBaSdvZ9YQdJTyoliUBImxAjJ1ZNI1DUOAHJ89kT1Cs=;
        b=q9fy/IU42poNSeBUbCEojRFQyIC5Kd8GWnqtU7eT9UvaWSFZOoI7XjmbgWBRGaaP+4
         Sl+hpQVU6glcqBJzrkJ22474eCHBtAdoeF4La+peh1ABlylMB0z7uK2zpcaU6Oew8OHU
         p4X2hdnQAkNN+hTwE/rO1/n7NkzpbCIQtUz6hDOyE6NDv5v23YW4VeMs8P1+NP2DqzWy
         40aNSmLIs8vorLlIUAJmOwmQtdr+RQtbFz/H+iQSdRIGZL6F10he0YhrLKlrLrs2fPbf
         lDLElc0lMlOviMj8MxcLpSA3wcuS3563YQ3jU4heaajnabupPR/oxImSnflng9hkMZBx
         X7hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687547813; x=1690139813;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IBaSdvZ9YQdJTyoliUBImxAjJ1ZNI1DUOAHJ89kT1Cs=;
        b=Y44nBErseOft6T4TfRpaW6OfgJdv62frubcWgrHt14RnIiaIU9Yw37ywdJfdixTCMb
         aXaEHHRGPPOBy3Y7KWCPIQ6W2mR+v12iGNIuLt5eIqX3FzGRYXacdqlTlQ2pvFZX9COh
         2K8t2Rj1GeYhyrhRIGdKI3emwy8Wt5FlOPpMg9oyLOm87G+QdqHPTOpLQ5uyo1fsc/zj
         DjuKjrV9UbtdKXo/gnC7i7Q2UqDvQKtbLzzmn1qI91icTxGPlu7YnsDRBhmNb5ADKiAp
         HWeeB1H1VnZkuBs0Q/nDaGy3e6FgaD1Zl1D1l4PAAVnN9fj4cO5h5OIm8fkGO7tvSPtJ
         jyKw==
X-Gm-Message-State: AC+VfDyHzejDc5skxZl+x6uJJuzkoXKTFT5c7VxW+Cgg1xTrmZTl+GqS
        TeIRZkL1+y0oMeat6JoFqBjafyHYlKRi5A==
X-Google-Smtp-Source: ACHHUZ72cYrQn9WP9uGVYnxAIFDLbl++WDnV72yoDI36Z12xYrT2kBBtn91omX1U2Bym27XEyofK4Q==
X-Received: by 2002:ad4:5de8:0:b0:5ed:c96e:ca4a with SMTP id jn8-20020ad45de8000000b005edc96eca4amr26105393qvb.1.1687547812968;
        Fri, 23 Jun 2023 12:16:52 -0700 (PDT)
Received: from [192.168.1.239] (ool-4570b665.dyn.optonline.net. [69.112.182.101])
        by smtp.gmail.com with ESMTPSA id q5-20020ad45ca5000000b00623950fbe48sm100426qvh.41.2023.06.23.12.16.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Jun 2023 12:16:52 -0700 (PDT)
From:   John Cai <johncai86@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/3] revision: refactor ref_excludes to ref_visibility
Date:   Fri, 23 Jun 2023 15:16:52 -0400
X-Mailer: MailMate (1.14r5852)
Message-ID: <941CCF5B-1FE6-46BE-9ED7-77C11E943E2E@gmail.com>
In-Reply-To: <ZJRDZ7NhyNpTV8jD@nand.local>
References: <pull.1515.git.git.1687376112.gitgitgadget@gmail.com>
 <ZJRBsDq8NI9EInel@nand.local> <ZJRDZ7NhyNpTV8jD@nand.local>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Taylor,

On 22 Jun 2023, at 8:49, Taylor Blau wrote:

> On Thu, Jun 22, 2023 at 08:42:24AM -0400, Taylor Blau wrote:
>> On Wed, Jun 21, 2023 at 07:35:09PM +0000, John Cai via GitGitGadget wrote:
>>> The ref_excludes API is used to tell which refs should be excluded. However,
>>> there are times when we would want to add refs to explicitly include as
>>> well. 4fe42f326e (pack-refs: teach pack-refs --include option, 2023-05-12)
>>> taught pack-refs how to include certain refs, but did it in a more manual
>>> way by keeping the ref patterns in a separate string list. Instead, we can
>>> easily extend the ref_excludes API to include refs as well, since this use
>>> case fits into the API nicely.
>>
>> After reading this description, I am not sure why you can't "include" a
>> reference that would otherwise be excluded by passing the rules:
>>
>>   - refs/heads/exclude/*
>>   - !refs/heads/exclude/but/include/me
>>
>> (where the '!' prefix in the last rule is what brings back the included
>> reference).
>>
>> But let's read on and see if there is something that I'm missing.
>
> Having read this series in detail, I am puzzled. I don't think that
> there is any limitation of the existing reference hiding rules that
> wouldn't permit what you're trying to do by adding the list of
> references you want to include at the end of the exclude list, so long
> as they are each prefixed with the magic "!" sentinel.

To be honest, I had no idea "!" would have this effect--so thanks for bringing
it to my attention.
>
> I think splitting the list of excluded references into individual
> excluded and non-excluded references creates some awkwardness. For one:
> excluded references already can cause us to include a reference, so
> splitting that behavior across two lists seems difficult to reason
> about.
>
> For example, if your excluded list contains:
>
>   - refs/heads/foo
>   - refs/heads/bar
>   - !refs/heads/foo/baz
>
> and your included lists contains:
>
>   - refs/heads/bar/baz/quux
>
> I am left wondering: why doesn't the rule pertaining to
> refs/heads/foo/baz show up in the included list? Likewise, what happens
> with refs/heads/bar/baz/quux? It is a child of an excluded rule, so the
> question is which list takes priority.

Now knowing the effect of "!", I understand the concerns about having a
separate list for included references. However, I do think it would be odd if
there is a ref_included() function to also use ref_excluded() to include a ref.

Also, even with the current API, I think it can be confusing to reason about
what takes precedence if there is a mix of inclusions and exclusions. For
example, if the excluded list contains:

- refs/heads/foo/baz
- !refs/heads/foo

would the inclusion take precedence, or the exclusion?

>
> Mostly, I am wondering if I am missing something that would explain why
> you couldn't modify the above example's excluded list to contain
> something like "!refs/heads/bar/baz/quux", eliminating the need for the
> include list entirely.

I think my one reservation however, is with usability of the current API. It's
not very intuitive to include references by adding them with
ref_excluded(&exclusions, "!ref/to/be/included").

I do think it would be easier to reason about if we kept two separate lists, one
for inclusion and one for exclusion. The existence of the "!" magic sentinel
does make things much more confusing however. I almost want to remove support
for the magic sentinel in favor of keeping two distinct lists that cannot be
mixed. Wondering your thoughts on that approach?

>
> Thanks,
> Taylor

thanks!
JOhn
