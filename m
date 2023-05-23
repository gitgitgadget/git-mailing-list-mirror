Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03D5CC7EE29
	for <git@archiver.kernel.org>; Tue, 23 May 2023 23:52:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238811AbjEWXwB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 May 2023 19:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjEWXvy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 May 2023 19:51:54 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E74DDB5
        for <git@vger.kernel.org>; Tue, 23 May 2023 16:51:53 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-51b0f9d7d70so227444a12.1
        for <git@vger.kernel.org>; Tue, 23 May 2023 16:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684885913; x=1687477913;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EX5QXGWDBY7ES5SldfkAyom0U5fap4d9bQ0QWFfv/nM=;
        b=Ry9obCQ0Z4ZbW/mo+wypCerN+jN9oUQoT0YrrmB8pkh5hxqxJMylS7ur34v9JVuGSx
         7+AhTiBcdcaN3fdtvJE1l7LNKk1E//KXuc+r++lNmWbAOnosvX2JuVx5fJFz/h2i4gL5
         XKwPITPC48xGqEnl/Nk7yqJDPe+zizNWVHOEEojKbixeNrV4ZL4ssixRGrapbmHk6hNz
         6n7/kk75FxbcP27OihH7lHQ1vq2kf+4MO0YJ4C8zft2Bwx28tBQw4C9xqMzRiWM1GRE/
         YUR+4bgPdn4Bs6NwHDmkkaMAs7sayoM+Yd+kf4HvEcl+zGBK/inFFjis3aOPIo8DNN6j
         4Fng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684885913; x=1687477913;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EX5QXGWDBY7ES5SldfkAyom0U5fap4d9bQ0QWFfv/nM=;
        b=JyzoFtl26f7kulpGcCsI8+uf999w/UxSayZSdk+BZ4IyJgPYMpAFjDey/6L+yifCuK
         x0YQRSuwZNRvVacMIxveyO4IYeMnBj7sulyd2lbm26pTq3kWq8Hb5UilkO8mkfsfDSgo
         hWRs8OX3WN8q5N9AkjeHwkt9G/LlHxzEI74xTRcPOIzp2IYOypuM54fmCrrd/s5nwfMo
         /KmHP7QEa+Ng9VQvQDFf5jNDf1yuzZ0wykMYHegEoM+zj9hBXZlpw5OUKXny/LXgH1Ug
         1V6rfTgYAxCJknnYEyWGocS3RFVumoYp/NMy+OBQJ5fMElqNfhLOU4i0HYlmdAAydoUP
         pT2w==
X-Gm-Message-State: AC+VfDwW4g5RlOKgk9wNC/016sB4YlRJoKW3IIkF7IGLgwQmu4tJ6Os3
        N6Wz+ap47Uy3vM7BI5zrMzN5C6/ycnobVQ==
X-Google-Smtp-Source: ACHHUZ5ysfMd50vNizkWrbAFJr8r4qcxZsalKI7Tzyoj6M79zIiM040fOSHmFO4A1X5US3Qi6V3KZA==
X-Received: by 2002:a17:902:6b8c:b0:1af:bae0:6bed with SMTP id p12-20020a1709026b8c00b001afbae06bedmr5134276plk.56.1684885912914;
        Tue, 23 May 2023 16:51:52 -0700 (PDT)
Received: from localhost (217.195.118.34.bc.googleusercontent.com. [34.118.195.217])
        by smtp.gmail.com with ESMTPSA id g23-20020a170902869700b001aafa2e4716sm7298052plo.264.2023.05.23.16.51.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 16:51:52 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        me@ttaylorr.com
Subject: Re: [PATCH 2/2] commit-graph: fix murmur3, bump filter ver. to 2
References: <cover.1684790529.git.jonathantanmy@google.com>
        <1cb0ee10253ab38b194c6554ecc68a5267e21145.1684790529.git.jonathantanmy@google.com>
        <def26c71-0fbb-58a3-f1cd-f8e532b67503@github.com>
Date:   Wed, 24 May 2023 08:51:52 +0900
In-Reply-To: <def26c71-0fbb-58a3-f1cd-f8e532b67503@github.com> (Derrick
        Stolee's message of "Tue, 23 May 2023 09:00:59 -0400")
Message-ID: <xmqqv8gihahz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

> I appreciate that you discovered and are presenting a way out of this
> problem, however the current approach does not preserve compatibility
> enough.
> ...
> By changing this algorithm directly (instead of making an "unsigned" version,
> or renaming this one to the "maybe signed" version), you are making it
> impossible for us to ship a version that can read version 1 Bloom filters,
> so all read-only history operations will immediately slow down (because they
> will ignore v1 chunks, better than incorrectly parsing v1 chunks).
>
> Here's where we would ignore v1 filters, instead of continuing to read them
> (with all the risks involved).

I do not know the "all the risks involved" comment.  Is the risk
something we can mitigate by still reading v1 data but be careful
about when not to apply the filters?

I may be misremembering the original discussion, but wasn't the
conclusion that v1 data is salvageable in the sense that it can
still reliably say that, given a pathname without bytes with
high-bit set, it cannot possibly belong to the set of changed paths,
even though, because the filter is contaminated with "signed" data,
its false-positive rate may be higher than using "unsigned" version?
And based on that observation, we can still read v1 data but only
use the Bloom filters when the queried paths have no byte with
high-bit set.

Also if we are operating in such an environment then would it be
possible to first compute as if we were going to generate v2 data,
but write it as v1 after reading all the path and realizing there
are no problematic paths?  IOW, even if the version of Git is
capable of writing and reading v2, it does not have to use v2,
right?  To put it the other way around, we will have to and can keep
supporting data that is labeled as v1, no?

> In order for this to be something we can ship safely to environments that depend
> on changed-path Bloom filters, we need to be able to parse v1 filters. It would
> be even better if we didn't write v2 filters by default, but instead hid it
> behind a config option that is off by default for at least one major release.

Is the concern that we will double the chunk size because both v1
and v2 will be written?  Or is it that we will stop writing v1 if we
start writing v2 and switching too early will mean the repositories
will become slower for older implementations that haven't died out?

Thanks.
