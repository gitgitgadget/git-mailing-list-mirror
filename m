Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF8DCC433F5
	for <git@archiver.kernel.org>; Wed,  9 Mar 2022 19:49:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238024AbiCITuf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 14:50:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238022AbiCITue (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 14:50:34 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09354266D
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 11:49:35 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id s5-20020a637705000000b00380cf1d3eb0so552568pgc.5
        for <git@vger.kernel.org>; Wed, 09 Mar 2022 11:49:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=A60RHgpMc5obDjMPkQ7SiJZvwP1pKXxT/pJMdxK9U/s=;
        b=Xmwn+ibXDNf/GCjfCgvTuV8ZlFy+x1XYU6TpyPT6ivnesAdarW2PJ/39JSUumf8cOS
         rMzyM7KiEOxsecKZRY3Yq6mXbz62piVC4l8sYkvwiIBYByZ84c0mm6T24ZTkiOP0bfnq
         +mZeuydcUcPptYw1GdnsS23O7rGkewR+SJa/OHigsgg3+fA75D3wPvP71cjFm5pOKFsU
         Jtthf55noeEuIRmoeI3wyGNYxP43GyIgfKi0AD5j1cMOE9VbRkw16Q1odd3o7vqGzTfb
         ZiolfI4PxZThk6olb73zAgq6bdlhfEOY4Y8Zs7sTK/ceNQrQAuKYJVCuvLSHokDqVAbh
         sNfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=A60RHgpMc5obDjMPkQ7SiJZvwP1pKXxT/pJMdxK9U/s=;
        b=eTYSe5gLp4uwsWC2Maa1x2zNKqnO3Voqm4D7i2lH6HdB/8G4DITVnokWMI1AnyoShW
         RLxnVvraF6wcY8+l+TF9tBIFrR7Lo6wt2dU7J95QNntZLH3CZVAqwGnVXLtb8cLnmTKe
         PNFyhh09V080E92WQeonNmf3+qKvPlCweDe2sXIIFfgvmvkg7eI3VITaFhyCyvXO+/q4
         u7OaqDo6hUzwxkH5z6WvhI9cl4nj6UMzbLePvAVYeu0GeeLa9iXIJUxKvKcFMLkETJUM
         LZUHHQKrXfVeaX1tgzrzDQzNwdy8vEnpzBeovc53AQ6ew0ao55lua/CLAm8kaupF0xvp
         A9mw==
X-Gm-Message-State: AOAM530pY2nAQl9YIW0eTGJv0JMVO542Hql/nVASXkpFQiM1PJS/LHXL
        kMieWUkweuEr2KMrFp6qrfqTFULY8yLT1g==
X-Google-Smtp-Source: ABdhPJwuTaNm1DrmBBk1RFTTIAcOir2hrIxdiNp35OOuyG+iV8paIJQbszxWkpZ0kW83XVERiEAmd7X7SA2yjw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:9b95:b0:151:533b:9197 with SMTP
 id y21-20020a1709029b9500b00151533b9197mr1163076plp.66.1646855374469; Wed, 09
 Mar 2022 11:49:34 -0800 (PST)
Date:   Wed, 09 Mar 2022 11:49:32 -0800
In-Reply-To: <xmqqfsnrkkhd.fsf@gitster.g>
Message-Id: <kl6l5yom6h4j.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <20220304005757.70107-1-chooglen@google.com> <20220308001433.94995-1-chooglen@google.com>
 <xmqqr17dp8s9.fsf@gitster.g> <kl6lh7885mm3.fsf@chooglen-macbookpro.roam.corp.google.com>
 <xmqqfsnrkkhd.fsf@gitster.g>
Subject: Re: [PATCH v5 00/10] fetch --recurse-submodules: fetch unpopulated submodules
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Glen Choo <chooglen@google.com> writes:
>
>> This uses a "first one wins approach", which obviously doesn't have
>> correctness guarantees. But in practice, I don't think this is likely to
>> cause problems:
>>
>> - As far as I can tell, the only value we read from .gitmodules is
>>   'submodule.<name>.fetchRecurseSubmodules', and this value gets
>>   overridden by two other values: the CLI option, and the config
>>   variable with the same name in .git/config.
>>
>>   During "git submodule init", we copy the config values from
>>   .gitmodules to .git/config. Since we can only fetch init-ed submodules
>>   anyway, it's quite unlikely that we will ever actually make use of the
>>   .gitmodules config.
>
> These are reasonable.
>
>> - Even if we do use the .gitmodules config values, it's unlikely that
>>   the values in .gitmodules will change often, so it _probably_ won't
>>   matter which one we choose.
>
> What bad things would we see if the value changes during the span of
> history of the superproject we fetched?  How often we would see
> broken behaviour is immaterial and breakage being rare is a no excuse
> to import a new code with designed-in flaw.  Unless the "rare" is
> "never", that is.

Makes sense, I'll keep this mind.

> I would think using ANY values from .gitmodules without having the
> end-user agree with the settings and copying the settings to the
> .git/config is a BUG.  So if it mattered from which superproject
> commit we took .gitmodules from, that would mean we already have
> such a bug and it is not a new problem.
>
> That would be a reasonable argument for this topic. Together with
> the previous point, i.e. we do not copy values we see in the in-tree
> .gitmodules file to .git/config anyway, it would make a good enough
> assurance, I would think.

To clarify, does this opinion of "don't use config values that aren't
copied into .git/config" extend to in-tree .gitmodules? Prior to this
series, we always read the in-tree .gitmodules to get the config - the
user does not need to copy the settings to .git/config, but we don't
pick a commit to read .gitmodules from.

If we still want to consider in-tree .gitmodules e.g. by merging
.git/config and .gitmodules, then we still have the new problem of
choosing the right .gitmodules.

If the answer is "no, we don't even consider in-tree .gitmodules"
(unless we really have to, like cloning a new submodule), that seems
pretty safe and predictable because we wouldn't have to look in two
different places to figure out what the user wants. And more crucially,
we'd never have to guess which .gitmodules to read - which will become
more of an issue as we add more support for init-ed but unpopulated
submodules.

> It leads to a possible #leftoverbit clean-up.  Because we only fetch
> submodules that are initialized, the API functions we are using in
> this series has no reason to require us to feed _a_ commit in the
> superproject to them so that they can find .gitmodules in them.

Hm, this is true; an initialized submodule should already have the
'expected' information in .git/config. And if we no longer have to fret
about whether we're reading the correct .gitmodules, we can revisit the
idea of "init a subrepo using only its name".

> Fixing the API can probably be left outside the scope of the topic,
> to be done soon after the dust from the topic settles, I think, to
> avoid distracting us from the topic.
>
> Thanks.
