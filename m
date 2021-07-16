Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95212C12002
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 19:24:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79105613FD
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 19:24:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232787AbhGPT1J (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Jul 2021 15:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232261AbhGPT1B (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jul 2021 15:27:01 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F19B0C06175F
        for <git@vger.kernel.org>; Fri, 16 Jul 2021 12:24:04 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id dp20so14851297ejc.7
        for <git@vger.kernel.org>; Fri, 16 Jul 2021 12:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=oiLcFcTZa5ibLVsG+Zt8jDXPVU0y3rEH820h1rEfFec=;
        b=gChfpQvm8nk371QJn2Ru9cxV+QUu5oLUk+Y0V04qvz4HQTooMnhCRlQUoXCtU55svP
         Rbd4xOxYv7KbFhYA3Ll2I2qCCS8NjOuzm0vobH1Jw1JyCNdSS3dk2v0HbgCzc3O+A6us
         qy35GLBVLnXijxSiRAyBBk1jPJqsHVl3w9PmGes5FRGhalyCSfHpjmZARcyhEdQXtzx9
         DISLaTazo8zpPLtzi6B/gxxL6ORzD9FlsoDHIqvZkmpW6QKi1T/52nvvyZl5RjMqYO2x
         gBdC7J2cLY091fFKcwuYOod1kq9SxcyKTJDocAviBVmJptSH7+jyAp3weGpfagzdRzJq
         wgnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=oiLcFcTZa5ibLVsG+Zt8jDXPVU0y3rEH820h1rEfFec=;
        b=PBfM8P6nJXhmz6pMxEtwrY0hD+gcgJg6Kk25mWwsPbUcMcN3y36gW5roeSGt5ldM9q
         1hCSSX1eH6f11tP0ywdM15i/sDhDClRyArBeQckn+NvYkK58/F3QL3+YcfwUlfQCL0cc
         Eb6jyxkTdNflTUh7DofH8psUh3DU0pDQ5n4zg129TJMFWjTMuwYu7hfyagOyl6Uoec3V
         fG5V66ue67ZfYn5ViiF2GB0eCraoy85kNSFAyoZ/Sx5BcQ5AN1fHC6MZYV2qSGO7SXYf
         54mxx4B216ocZSLvOygiAIhBY0m20pc2tuqs50BOcCQMgm3g1a4GdtSshCBx0sOmd4Y6
         fmdA==
X-Gm-Message-State: AOAM531wLFmd/OS1YYofOGcYXI7k8dj72W5PuK9uuXd3+v5ASeESu5dr
        MAG/YDKaJ8KnTVFOvx3TtX8=
X-Google-Smtp-Source: ABdhPJwIke7emWbkmp4K78FGtCGsmnKKxz8VPZUXjSc3Rg3TSttlRJzmgkJJwIsp6NwIcfHVf/vE4A==
X-Received: by 2002:a17:907:e9e:: with SMTP id ho30mr13594121ejc.114.1626463443307;
        Fri, 16 Jul 2021 12:24:03 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id g23sm4116148edp.90.2021.07.16.12.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 12:24:02 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] CodingGuidelines: recommend gender-neutral description
Date:   Fri, 16 Jul 2021 21:11:36 +0200
References: <xmqqmtqpzosf.fsf@gitster.g>
        <2c7f188a-6ebe-b116-8299-86ca3732d79a@gmail.com>
        <87czrl0wob.fsf@evledraar.gmail.com> <xmqqk0lrtuh4.fsf_-_@gitster.g>
        <xmqqv95aqeyh.fsf_-_@gitster.g>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <xmqqv95aqeyh.fsf_-_@gitster.g>
Message-ID: <87pmvivz8j.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jul 16 2021, Junio C Hamano wrote:

> Technical writing seeks to convey information with minimal
> friction. One way that a reader can experience friction is if they
> encounter a description of "a user" that is later simplified using a
> gendered pronoun. If the reader does not consider that pronoun to
> apply to them, then they can experience cognitive dissonance that
> removes focus from the information.
>
> Give some basic tips to guide us avoid unnecessary uses of gendered
> description.
>
> Using a gendered pronoun is appropriate when referring to a specific
> person.
>
> There are acceptable existing uses of gendered pronouns within the
> Git codebase, such as:
>
> * References to real people (e.g. Linus Torvalds, "the Git maintainer").
>   Do not misgender real people. If there is any doubt to the gender of a
>   person, then avoid using pronouns.
>
> * References to fictional people with clear genders (e.g. Alice and
>   Bob).
>
> * Sample text used in test cases (e.g t3702, t6432).
>
> * The official text of the GPL license contains uses of "he or she",
>   but using singular "they" (or modifying the text in some other
>   way) is not within the scope of the Git project.
>
> * Literal email messages in Documentation/howto/ should not be edited
>   for grammatical concerns such as this, unless we update the entire
>   document to fit the standard documentation format. If such an effort is
>   taken on, then the authorship would change and no longer refer to the
>   exact mail message.
>
> * External projects consumed in contrib/ should not deviate solely for
>   style reasons. Recommended edits should be contributed to those
>   projects directly.
>
> Other cases within the Git project were cleaned up by the previous
> changes.
>
> Co-authored-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

On the topic of co-authors & SOB this text does look quite familiar:
https://lore.kernel.org/git/87a6nz2fda.fsf@evledraar.gmail.com/ :)

>  The only change relative to the previous one is that this
>  explicitly calls out that some are taught that 'they' is only used
>  for third-person plural.  As we already say that some foreigners
>  find it ungrammatical and unnatural to use 'they', I actually do
>  not think it is necessary[...]

The proposed commit message...

> + In order to ensure the documentation is inclusive, avoid assuming
> + that an unspecified example person is male or female, and think
> + twice before using "he", "him", "she", or "her".  Here are some
> + tips to avoid use of gendered pronouns:

Applies to this:

> +  - Prefer succinctness and matter-of-factly describing functionality
> +    in the abstract.  E.g.
> +
> +     --short:: Emit output in the short-format.
> +
> +    and avoid something like these overly verbose alternatives:
> +
> +     --short:: Use this to emit output in the short-format.
> +     --short:: You can use this to get output in the short-format.
> +     --short:: A user who prefers shorter output could....
> +     --short:: Should a person and/or program want shorter output, he
> +               she/they/it can...

But this.

> +    This practice often eliminates the need to involve human actors in
> +    your description, but it is a good practice regardless of the
> +    avoidance of gendered pronouns.

Not this.

> +  - When it becomes awkward to stick to this style, prefer "you" when
> +    addressing the the hypothetical user, and possibly "we" when
> +    discussing how the program might react to the user.  E.g.
> +
> +      You can use this option instead of --xyz, but we might remove
> +      support for it in future versions.
> +
> +    while keeping in mind that you can probably be less verbose, e.g.
> +
> +      Use this instead of --xyz. This option might be removed in future
> +      versions.

But this.

> +  - If you still need to refer to an example person that is
> +    third-person singular, you may resort to "singular they" to avoid
> +    "he/she/him/her", e.g.
> +
> +      A contributor asks their upstream to pull from them.
> +
> +    Note that this sounds ungrammatical and unnatural to those who
> +    learned that "they" is only used for third-person plural, e.g.
> +    those who learn English as a second language in some parts of the
> +    world.
> +

And not this, have, respectively, nothing to do and mostly everything to
do with the commit message.

IOW I don't think we should conflate a section on general style in our
common patterns/issues in our docs and one that at the end state of this
series is discussing the already-rare-now-nonexistent pattern that the
proposed policy is trying to prevent ever making it in-tree again, or to
put the entirety of a general style guide under the equivalent of "how
to avoid gendered pronouns".

IOW to have this instead (this is mostly a mere moving of your proposed
version):

== BEGIN==

General style points for our documentation

 - Prefer succinctness and matter-of-factly describing functionality
   in the abstract.  E.g.

    --short:: Emit output in the short-format.

   and avoid something like these overly verbose alternatives:

    --short:: Use this to emit output in the short-format.
    --short:: You can use this to get output in the short-format.
    --short:: A user who prefers shorter output could....
    --short:: Should a person and/or program want shorter output, he
              she/they/it can...

 - When it becomes awkward to stick to this style, prefer "you" when
   addressing the the hypothetical user, and possibly "we" when
   discussing how the program might react to the user.  E.g.

     You can use this option instead of --xyz, but we might remove
     support for it in future versions.

   while keeping in mind that you can probably be less verbose, e.g.

     Use this instead of --xyz. This option might be removed in future
     versions.

Discussing beings in our documentation:

  In order to ensure the documentation is inclusive, avoid assuming
  that an unspecified example person is male or female, and think
  twice before using "he", "him", "she", or "her".  Here are some
  tips to avoid use of gendered pronouns:

  The practice of avoiding verbosity discussed above often eliminates
  the need to involve human actors in your description.

 - If you still need to refer to an example person that is
   third-person singular, you may resort to "singular they" to avoid
   "he/she/him/her", e.g.

   A contributor asks their upstream to pull from them.

   Note that this sounds ungrammatical and unnatural to those who
   learned that "they" is only used for third-person plural, e.g.
   those who learn English as a second language in some parts of the
   world.

== END == 

I'd be happy to re-arrange this, if I could only get the submitter of
the series to respond to my E-Mails...

Snipping around above:

> , but I'd prefer not to leave easy loose
>  end hanging untied, so let's close this round and let others polish
>  on top if they wanted to after the dust settls.

Sure, but as someone who'll probably want to patch the first part of
this at one point or another, it's going to be rather weird to cover
e.g. how we prefer to quote options or refer to things in
errors/warnings or whatever all under a section that says all of the
below is in the service of the avoidance of gender pronouns.

Whereas it's mostly the case that our docs are just following a style
established in common OS-level docs at a time when I daresay this topic
wasn't part of the zeitgeist.
