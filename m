Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7C5DEE14A9
	for <git@archiver.kernel.org>; Wed,  6 Sep 2023 22:11:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244890AbjIFWLt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Sep 2023 18:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236369AbjIFWLs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Sep 2023 18:11:48 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FBE51BC2
        for <git@vger.kernel.org>; Wed,  6 Sep 2023 15:11:41 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-5009d4a4897so464335e87.0
        for <git@vger.kernel.org>; Wed, 06 Sep 2023 15:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694038299; x=1694643099; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pTMzaPJGn3jiahyysEmmWheDtQMZ0CnTQXG9NoZqI0k=;
        b=nWq1pWHOZomraJufnokaUkxd3A0KtqctCLokn7lp1GiKzp4jxW7N1KSzZg5HcRgiEd
         e2n2Zl1FFMGBCMCoxOd4dMO1L10QsnGul19YRQGmakIQGLofzjivTH3LKZcu+7I+6uvM
         o9Hlqjt4BIBM6rJyMwE/MY1s0ZAtUtppOTZk7cL+5UWr22qCF9Nnpy3GsCdmrhMcwsx8
         enO5Z1U51GDw4D48ztjO0xxMWdgsRv/DFhwfdCdlHWXGNRnv15/EEvFosG5gMalVtTCg
         zdqd15kawtgrvQE5A2NR867L37hSozbyPdrocd5o1qZbz83at245YeSwZCmecEMqENIB
         EDVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694038299; x=1694643099;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pTMzaPJGn3jiahyysEmmWheDtQMZ0CnTQXG9NoZqI0k=;
        b=HE7YuStRMvXMbDd7fbDBS78QNXpKW7VVFF6ftoJOz5fjoawfMT8vqxPo1Exp0bF8Ul
         +TFMkqR9+iACuIKqXTXncrzjL0rWZimFpSw762xJrxj8t/uzB3H2gCeNHwwb5N3ALzgZ
         P24lL8wSecZYWQkeqVU3KLtE2Z/pjqAFtGn3yjnfoFmHl2g083h5ETVjkZuY06Jpcxis
         Vt+3sc9li0/6I7/ndm3wNVlVZuOK172wqqXZXJtNR/GqlBQ4cg/qi5laDAEE1mQaMoxc
         TBbJCLmoqF58bKqOu6JCv0Nom9lvkizpIKPWbSDJOERdu6K/gsiI4da5DJvJoJAdjfVc
         1YeA==
X-Gm-Message-State: AOJu0Ywpty6LVvE727fnuZmR7zX8qtXmCO4wJGRa8AHceCHwM+e13U/J
        MsjkxJ4PYVBVCqF50MTedko37cx58Xo=
X-Google-Smtp-Source: AGHT+IHVfEN1EJO19bnEvB1g1uHFRlLLWKV8/5zGHwmrdkHRYKt0CvbB1n54DwsRZT4H4bK/9ccnNQ==
X-Received: by 2002:ac2:58cf:0:b0:500:af82:7dd9 with SMTP id u15-20020ac258cf000000b00500af827dd9mr2809180lfo.62.1694038299248;
        Wed, 06 Sep 2023 15:11:39 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id c26-20020a19761a000000b004fb326d4ff0sm2887565lff.77.2023.09.06.15.11.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 15:11:38 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "Kristoffer Haugsbakk" <code@khaugsbakk.name>,
        "Eric Sunshine" <sunshine@sunshineco.com>,
        "Tao Klerks" <tao@klerks.biz>,
        "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
        "Taylor Blau" <me@ttaylorr.com>, "Patrick Steinhardt" <ps@pks.im>,
        git <git@vger.kernel.org>
Subject: Re: Is "bare"ness in the context of multiple worktrees weird?
 Bitmap error in git gc.
References: <CAPMMpoixKnr4BkKd8jeU+79Edhqtu4R7m8=BX4ZSYKdBHDzK=w@mail.gmail.com>
        <b5833396-7e04-465f-96f6-69d5280fa023@app.fastmail.com>
        <CAPig+cQoiqeZF52Jr45an+cZF+ZQbHPXtLVn+VmyegjMQaJqCg@mail.gmail.com>
        <2ba66542-9ae2-4b13-ae6b-f37dec6b72c7@app.fastmail.com>
        <xmqq5y4nnq9b.fsf@gitster.g> <xmqqwmx3m82l.fsf@gitster.g>
Date:   Thu, 07 Sep 2023 01:11:37 +0300
In-Reply-To: <xmqqwmx3m82l.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
        06 Sep 2023 12:10:26 -0700")
Message-ID: <874jk7uf3a.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> "Kristoffer Haugsbakk" <code@khaugsbakk.name> writes:
>>
>>> But not with “worktree”:
>>>
>>>   “ A repository can have zero (i.e. bare repository) or one or more
>>>     worktrees attached to it. ...
>>>
>>> Since this entry claims that “bare repository” and “zero worktrees” are
>>> equivalent.
>>
>> I wrote that "(i.e. bare repository)" in 2df5387e (glossary:
>> describe "worktree", 2022-02-09) but did not mean that way.  
>>
>> A non-bare repository can reduce the number of its worktrees, but it
>> cannot go below one, because the directory with working tree files
>> and the .git/ subdirectory, i.e. its primary worktree, must exist
>> for it to be a non-bare repository.  Consequently a repository with
>> zero worktree is by definition a bare repository.
>>
>> But that does not have to mean all bare repositories can have no
>> worktrees.
>
> I re-read the glossary entry and I think the current text is mostly
> OK, except that it does not even have to mention "bare" at that
> position in the sentence.  A bare repository with zero worktrees is
> totally uninteresting in the explanation of the worktree.

Sounds reasonable.

>
> We need to say that the repository data (configuration, refs and
> objecs) are mostly shared among worktrees while some data are kept
> per-worktree, which the current text adequately covers, and what is
> missing with respect to a bare repository is that we do not say
> worktrees can be attached after the fact to a repository that was
> created bare.

Why? Worktree could be attached after the fact to any repository. I
don't see why we need to mention bareness here, as it's not special in
this regard.

>
> So, perhaps something along this line?
>
>  Documentation/glossary-content.txt | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
>
> diff --git c/Documentation/glossary-content.txt w/Documentation/glossary-content.txt
> index 5a537268e2..6dba68ffc0 100644
> --- c/Documentation/glossary-content.txt
> +++ w/Documentation/glossary-content.txt
> @@ -694,10 +694,12 @@ The most notable example is `HEAD`.
>  	plus any local changes that you have made but not yet committed.
>  
>  [[def_worktree]]worktree::
> -	A repository can have zero (i.e. bare repository) or one or
> -	more worktrees attached to it. One "worktree" consists of a
> -	"working tree" and repository metadata, most of which are
> -	shared among other worktrees of a single repository, and
> -	some of which are maintained separately per worktree
> -	(e.g. the index, HEAD and pseudorefs like MERGE_HEAD,
> -	per-worktree refs and per-worktree configuration file).
> +	A repository can have zero or more worktrees attached to it.
> +	One "worktree" consists of a "working tree" and repository
> +	metadata, most of which are shared among other worktrees of
> +	a single repository, and some of which are maintained
> +	separately per worktree (e.g. the index, HEAD and pseudorefs
> +	like MERGE_HEAD, per-worktree refs and per-worktree
> +	configuration file).
> ++
> +Note that worktrees can be attached to an existing bare repository.

"shared among other worktrees" -> "shared among all worktrees"?

Also, if we do have "main worktree" and "linked worktree" as concepts,
they need to be at least mentioned in the glossary, I believe.

Finally, if we do have "linked worktrees", then the phrasing should
better use "linked" instead of "attached"? Alternatively, if "attached"
fits better, let's call them "attached worktrees"?

-- 
Sergey Organov
