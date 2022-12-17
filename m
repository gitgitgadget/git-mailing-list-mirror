Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBED0C4332F
	for <git@archiver.kernel.org>; Sat, 17 Dec 2022 02:51:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbiLQCvQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Dec 2022 21:51:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbiLQCuz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Dec 2022 21:50:55 -0500
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE4F8101D3
        for <git@vger.kernel.org>; Fri, 16 Dec 2022 18:50:53 -0800 (PST)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-14449b7814bso5506235fac.3
        for <git@vger.kernel.org>; Fri, 16 Dec 2022 18:50:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=D2/KD3sivAZKIr0N6dq9nhuYkXO7OF0fLfSvz00kzuI=;
        b=ZCuWHB630ANILFq6tjH4tWVbdhCCjQBf2+bijY5ptHRrdI914YNPHJMuK6c1nuDuSu
         KP4UpOh6FPelDqSYJ635le0FBVYGxVkoRQ1E9Ihsm3JPL47T//P9RwqTCFlKbthHFo0r
         1e/SfQmkQoi7eUodnabBnE3ULkTQx3oAzKxdkiS49gJf6Clslrytoo161WZtVUN5iAon
         uROeync7FCy9pmDdtDrYCzL+cEC7AlbOf1utegEjfmcCWR3xt0a6ubSvZFV4sbWyy/l2
         +uRMetdQepEnpfMyZ0JSOo/xfyMLJzGPnM5puoDdAdnirZkMTsOdfax5+pCQZQu6lPvZ
         UqTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D2/KD3sivAZKIr0N6dq9nhuYkXO7OF0fLfSvz00kzuI=;
        b=eyrYyAAZWJAPrQuyoUHc92YNNYBs8zO68mdGlbTLQuyq3o9MI4FbvHpfNe/f2YQVpB
         W1DYtrlW+ycyY93C3dw5ihC+FN3DLA6b5jBHrFlrb6JlfYNRjm1KlGIQTbnlz2p98hW+
         QvZStg6a/FiMVp+O4QHqtyOxvSeWSUHtAMxwV7c/rrBDkDjNFUBvaOhyQBiuUt6HC0Pz
         MxAeJiccBOCNDVofp8/vCGbR3ucLV6eo9SLOgYMOdAPzNQxiwPElyuybohFcpHrYnZ2m
         IBY1VbT9bJr3RVXeEJjUwItxXQoSRkw/f4WJ5CoqP32JDxXNXi6GxsWzh7u0EMWgFZMT
         fLxg==
X-Gm-Message-State: AFqh2kpqPCK9EkxDf6lT2S/SG327VE3eNsNFS0izjLr49Gr+0Mpkoilt
        vSfHoliWtJV7sN/zpyHhLHifON/77bFumpMQvx/5P5Kg
X-Google-Smtp-Source: AMrXdXsfH1ypZoOvE3Qec0fhXTd9CfBloXyxTDdJqM9qQ3D9OhCqpUurwRvkJADRUVIXv1usGJewVi/A4HpuurnVZqM=
X-Received: by 2002:a05:6870:7883:b0:144:687:9ac0 with SMTP id
 hc3-20020a056870788300b0014406879ac0mr722077oab.277.1671245453005; Fri, 16
 Dec 2022 18:50:53 -0800 (PST)
MIME-Version: 1.0
References: <20221216121557.30714-1-minipli@grsecurity.net>
 <221216.86o7s31fyt.gmgdl@evledraar.gmail.com> <62a06c5b-9646-17f8-b4d5-39823d3cc25a@grsecurity.net>
 <xmqqlen7kksr.fsf@gitster.g>
In-Reply-To: <xmqqlen7kksr.fsf@gitster.g>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Fri, 16 Dec 2022 18:50:41 -0800
Message-ID: <CAPUEspjqgSOS4KKw2nTaRYdiCFo4Ok6OfmKrqb+Mjq+oXn5nsg@mail.gmail.com>
Subject: Re: [PATCH] grep: fall back to interpreter mode if JIT fails
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Mathias Krause <minipli@grsecurity.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 16, 2022 at 3:09 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Mathias Krause <minipli@grsecurity.net> writes:
>
> > ... However, from a user's point of view a fall back to
> > interpreter mode might still be desired in this case, as a failing
> > 'git grep' is simply not acceptable, IMHO.
>
> "git grep" that silently produces a wrong result (by falling back
> after a problem is detected) would not be acceptable, either.

except that an error at this point only invalidates the use of JIT,
so calling pcre2_jit_match() is invalid but calling pcre2_match() is not.

the later is setup to be used later by the code that is added,

> Receiving BADOPTION could be a sign that there is something wrong in
> the input, not from the end-user but from the code, in which case
> stopping with BUG() may be a more appropriate?

The way PCRE handles this kind of errors internally is to instruct pcre2_match()
to use the interpreter.

While a BUG() might be a way to ensure the code is using the right set
of options
I would expect that the failure will be reported by pcre2_compile
instead, with the
only cases left, only being interna to PCRE (ex: JIT can't yet support
a feature the
interpreter has)

Carlo
