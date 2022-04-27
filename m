Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3308BC4332F
	for <git@archiver.kernel.org>; Wed, 27 Apr 2022 16:45:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243380AbiD0QtG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Apr 2022 12:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243353AbiD0Qst (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Apr 2022 12:48:49 -0400
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A5032340BB
        for <git@vger.kernel.org>; Wed, 27 Apr 2022 09:45:33 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id y74so2253370vsy.7
        for <git@vger.kernel.org>; Wed, 27 Apr 2022 09:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SnYoo303whXjst3ZlrFa53DtHEvTOQhUV0LvoH3o7Z8=;
        b=qhuVmZH6oitDynX/vWagw5V5tpAmPhQ6zcTQ4llRSiKiz0L4RM3f+669jiA6FOaIOu
         SY5vVJja3AQ1WwvMFAJWI8ps7Ik7vNT9yLpNdP+a9IEr1Mnm+StEn/wwPS6+VG9dgydk
         6d6Jl19bm707b0ejm3Cy+jNPuwAubC54D1VTDyivsnejsCN29ZHwj7EdIMT3BeEovZfc
         q7yFcL9wnVAM1fqgSnQSjpk4FuBg8+kAzoz31qQZOClm5LvGZi6WD7j7iQHsmyy4eUZO
         8vbZUu5qdRZxwSNpXJl3wP8XFKzRDPuy33Zq4vW5zyicF/Tv0IFrzG4ddQ9TDijw8PqG
         49Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SnYoo303whXjst3ZlrFa53DtHEvTOQhUV0LvoH3o7Z8=;
        b=Z25vQpelk4DyfirqXcOXdZ2tR164f2OB9nTJqgS3rNiT+TVO9upqPWUpRn2R2HM8FD
         Qn5sKdA2K9r8RR5XgvLO1xyiMXjHEHXzpHliTiJfAUBYZ8DMRohuczmD3LCw0F1iV0UG
         h1fv4LjIdNtQPvlTlQWlCyn9QADkY4OWRaPmqm2uHaA1Wo5z5zzj6/AHbsgpTLXMGNqP
         EvtoD15qd9UkQcY/tWsVeMyw3WaQ8jZAGlonClM8CXgRFdLW1USEsWYbw7DEPmZozFpU
         BsAZntthD0r9vLrgR/0mYz2PK/i8q8F6WiA5o0Asc1jucVn2IZ/ZJOmpRP4AyRNzzaMv
         yuAQ==
X-Gm-Message-State: AOAM531F1v73hgJTKjqaRk20dbMIYMYupOyj8lFm3i+RPyyDl/I1FKId
        IGZMFNw8vUSXl/RBf8FFyocBJXlVLFfo2bEASME=
X-Google-Smtp-Source: ABdhPJyjr+18eFfxS8Neh4cbGVg8damoCpZ7YYvBrso3wonPaW/rbMQiKH58v87tHT4OfY0q91Oxi5HZwvgRN5zW7dM=
X-Received: by 2002:a67:7242:0:b0:329:1f29:4b4c with SMTP id
 n63-20020a677242000000b003291f294b4cmr9422785vsc.1.1651077932672; Wed, 27 Apr
 2022 09:45:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220426183105.99779-1-carenas@gmail.com> <20220427000522.15637-1-carenas@gmail.com>
 <6522673b-494a-951c-be5e-3ca01577c12b@gmail.com> <CAPUEsphEymVE1HHeDZE+Fh50fr7DJSpM_YFNC-v=m9hFhgz-UA@mail.gmail.com>
 <xmqqczh2o5xg.fsf@gitster.g>
In-Reply-To: <xmqqczh2o5xg.fsf@gitster.g>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Wed, 27 Apr 2022 09:45:21 -0700
Message-ID: <CAPUEspgANqqEcqS31UbBTq+QB6R7TQ8TncZ8uMt778=kvrE=eQ@mail.gmail.com>
Subject: Re: [PATCH] git-compat-util: avoid failing dir ownership checks if
 running privileged
To:     Junio C Hamano <gitster@pobox.com>
Cc:     phillip.wood@dunelm.org.uk, git@vger.kernel.org,
        philipoakley@iee.email, me@ttaylorr.com, guy.j@maurel.de,
        szeder.dev@gmail.com, johannes.Schindelin@gmx.de,
        derrickstolee@github.com, Randall Becker <rsbecker@nexbridge.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 27, 2022 at 9:19 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> And that is why it is wrong to call it "error".  It is not about
> errors, but is about the shape of the input string, i.e. where the
> run of digits ends.

I called it error, because I only cared about it to signal that the
string it converted was an erroneous one (ex: "1a" or "a")

> And there is this note:
>
>     Since 0, {LONG_MIN} or {LLONG_MIN}, and {LONG_MAX} or {LLONG_MAX}
>     are returned on error and are also valid returns on success, an
>     application wishing to check for error situations should set errno
>     to 0, then call strtol() or strtoll(), then check errno.
>
> So, no, I do not think the range check gives us anything
> meaningful.

the meaningful part of it was meant to be:

this function will try to get the value of an UID from SUDO_UID, if it
gets anything insane like LONG_MIN or LONG_MAX or anything above or
below that, it would consider you are just trying to play a bad joke
with it and ignore you.

> At this point, it is tempting to say that it is not worth trying to
> do it right by avoiding atoi(), as we are bound to make more of this
> kind of mistakes X-<.  But at the same time, I hope we can learn
> together and get this right ;-).

except it wasn't a mistake, but maybe poorly documented since I was
already going over my quota of added lines for what should have been a
3 line patch.

apologies for making the code so cryptic and thanks for spending so
much time reviewing it and commenting on it, has been definitely very
instructive so far.

any specific suggestions you would like to have in a reroll?

Carlo
