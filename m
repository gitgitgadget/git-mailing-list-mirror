Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31731C47082
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 17:40:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C5BA61360
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 17:40:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233425AbhFHRml (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Jun 2021 13:42:41 -0400
Received: from mail-pf1-f178.google.com ([209.85.210.178]:36599 "EHLO
        mail-pf1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233081AbhFHRmk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jun 2021 13:42:40 -0400
Received: by mail-pf1-f178.google.com with SMTP id c12so16301743pfl.3
        for <git@vger.kernel.org>; Tue, 08 Jun 2021 10:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ASoBwAxLtEfMXtVdCZ8R/jXDSzr8wPFXGWhHL0RDu0E=;
        b=slTC8oQFbkl0U718yX1tSWtm6Uz+CCky+K8AKWC+c3i9DyVHaSrZZxF0MLDKywIqKU
         QlVHk2SkJy3UaxteMqva6RECGir38nN5mAFmXDvnJsiDxbVI/die3lnvLsdt5u7H6cd+
         7159DsZcX2wpriTCEfIHzdswbKqNfiXt7Q3JHzSqckmDgIfqis/HfpBkCzRLEvXkJh3g
         uynmZ7t5+0wTSlQP+gNvgesVIPX+q8lSCxxNvKZoBNLsJpzuYEazYtC+gHA0aDsEj0EW
         R4htZqeo5TSqJ0ql8qLp/vntjMy7OuoiHEnQ6SuY03OIn9PRvHzrWgrl02Dg04X0yNnt
         uCRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ASoBwAxLtEfMXtVdCZ8R/jXDSzr8wPFXGWhHL0RDu0E=;
        b=XnbPqImqxIGQkcbVhUqxxxVDiF9hrCX6ziGmMGfswDA3sFuw/ls9pE4pVDNjMEPAxz
         3q4ZXdf0PHRWCIWCVtnGrn0utN03LpcSQ2x70Xe+AX64Jw6MdXmga/ZEPVDdJA0hdt/t
         8FSVB3mjwK1x0SNojYqfnqVOednIusp+NFFl57Zo86AKPDmsnbxxZY5d3r3szArPLhk/
         s/F9WfyUOb47gEVaeYq26U4rgDxg2haeW12YsfsN+znVjYTM8z2S3aKPLWEfV3vcfphF
         XRXrB1TRpYgPDQpu+OCY+PE/xVWWdw8oUSmVqoyIzfOIJAKaKrw3jj/rXwiHB55fxl9Z
         imtw==
X-Gm-Message-State: AOAM530A8JIQHQpfV4ISf2hjc7ReWUZF4t1PWvlSemieVYG3KVGwmeYT
        H2JGonjv5ziX14DETPlCNHxbHA==
X-Google-Smtp-Source: ABdhPJys9EDhkrv1XhAfmpCn446zSdIQuP60RyKXvJkp7Cexiz2O6lQsO5LYJklMQV4UlewntS1f2Q==
X-Received: by 2002:a65:6256:: with SMTP id q22mr23935395pgv.391.1623173987499;
        Tue, 08 Jun 2021 10:39:47 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:f819:e238:f61a:a961])
        by smtp.gmail.com with ESMTPSA id w125sm11025743pfw.214.2021.06.08.10.39.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 10:39:46 -0700 (PDT)
Date:   Tue, 8 Jun 2021 10:39:42 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com,
        sandals@crustytoothpaste.net, stolee@gmail.com, jrnieder@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 4/4] CodingGuidelines: recommend singular they
Message-ID: <YL+rXqDMIPvA2a3+@google.com>
References: <pull.975.git.1623085069.gitgitgadget@gmail.com>
 <d2c079264955b3bd6c3a5ef77a9c3684206f8475.1623085069.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2c079264955b3bd6c3a5ef77a9c3684206f8475.1623085069.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 07, 2021 at 04:57:48PM +0000, Derrick Stolee via GitGitGadget wrote:
> 
> 
> Technical writing seeks to convey information with minimal friction. One
> way that a reader can experience friction is if they encounter a
> description of "a user" that is later simplified using a gendered
> pronoun. If the reader does not consider that pronoun to apply to them,
> then they can experience cognitive dissonance that removes focus from
> the information.
> 
> If we use singular "they/them" pronouns instead of "he/him" or "she/her"
> pronouns, then we can avoid this congitive load on the reader.
> 
> Using singular "they" is also incredibly efficient. Choosing a gendered
> pronoun is usually arbitrary between "he" or "she". Using constructs
> such as "he or she", "s/he", or "(s)he" are more complicated than
> singular "they".
> 
> When choosing a gendered pronoun, that pronoun no longer applies to
> nearly half of possible readers. Even if we alternated between "he/him"
> and "she/her" perfectly evenly, we would still expect male and female
> readers to experience an incorrect pronoun half the time. However, some
> readers will not prescribe to either of these binary genders. Those
> readers hence suffer an incorrect pronoun the entire time. Singular
> "they" applies to every reader.
> 
> Perhaps due to similar reasons, official style guides have changed their
> stance on singuler "they" in recent years. For example, the APA style
> guide changed their official recommendation in 2019 [1]. The MLA
> handbook also references helpful ways to use singular "they" [2]. While
> not fully endorsing it, the Chicago Manual of Style has removed its
> blanket ban on singular "they" [3] (the previous recommendation was to
> only use "it" as a singular non-gendered pronoun).
> 
> [1] https://apastyle.apa.org/blog/singular-they
> [2] https://style.mla.org/using-singular-they/
> [3] https://libraries.indiana.edu/chicago-manual-style-singular-pronoun-they
> 
> While not all styleguides are updating their recommendations, we can
> make a choice as a project to adopt the concept because of the
> efficiencies above, as well as the benefits of increased inclusion.
> 
> To futher justify singular "they" as an acceptable grammatical concept,
> I include the careful research of brian m. carlson who collected their
> thoughts on this matter [2] (lightly edited):
> 
>   Singular "they" has been used by native English speakers as part of
>   the language for over half a millennium and is widely used and
>   understood. This usage is specified in Merriam Webster[3]:
> 
>     The use of they, their, them, and themselves as pronouns of
>     indefinite gender and indefinite number is well established in
>     speech and writing, even in literary and formal contexts.
> 
>   Wiktionary notes[4] (references omitted):
> 
>     Usage of they as a singular pronoun began in the 1300s and has been
>     common ever since, despite attempts by some grammarians, beginning
>     in 1795, to condemn it as a violation of traditional (Latinate)
>     agreement rules. Some other grammarians have countered that criticism
>     since at least 1896. Fowler's Modern English Usage (third edition)
>     notes that it "is being left unaltered by copy editors" and is "not
>     widely felt to lie in a prohibited zone." Some authors compare use of
>     singular they to widespread use of singular you instead of thou.
> 
>   Linguists fit roughly into two camps: prescriptive and descriptive.
>   The former specify rules for people to use, and the latter document
>   language as it is actually used without forming a judgment.
> 
>   Some prescriptivists think it is acceptable, and some do not. But
>   descriptivists will rightly note that it is and has been commonly
>   used in English across countries, cultures, and contexts for an
>   extended period of time and is therefore generally accepted by most
>   English speakers as a normal part of the language.  Since we are
>   writing text for an English language audience who are mostly not
>   linguists, we should probably consider using the language that most
>   people will use in this context.
> 
> [2] https://lore.kernel.org/git/YKrk4dEjEm6+48ji@camp.crustytoothpaste.net/
> [3] https://www.merriam-webster.com/dictionary/they
> [4] https://en.wiktionary.org/wiki/they
> 
> If we refer to a specific person, then using a gendered pronoun is
> appropriate. Examples within the Git codebase include:
> 
> * References to real people (e.g. Linus Torvalds, "the Git maintainer").
>   Do not misgender real people. If there is any doubt to the gender of a
>   person, then use singular "they".
> 
> * References to fictional people with clear genders (e.g. Alice and
>   Bob).
> 
> * Sample text used in test cases (e.g t3702, t6432).
> 
> * The official text of the GPL license contains uses of "he or she", but
>   modifying the license this way is not within the scope of the Git
>   project.
> 
> Other cases within the Git project were cleaned up by the previous
> changes.
> 
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>

Well said.
Acked-by: Emily Shaffer <emilyshaffer@google.com>

> ---
>  Documentation/CodingGuidelines | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
> index e3af089ecf26..78cd399f7cf5 100644
> --- a/Documentation/CodingGuidelines
> +++ b/Documentation/CodingGuidelines
> @@ -648,3 +648,8 @@ Writing Documentation:
>   inline substituted text+ instead of `monospaced literal text`, and with
>   the former, the part that should not get substituted must be
>   quoted/escaped.
> +
> + When referring to an anonymous user, use singular "they/them" pronouns
> + as opposed to choosing between "he/him" and "she/her". Do not use more
> + complicated constructs such as "he or she" or "s/he". This recommendation
> + also applies to code comments and commit messages.
> -- 
> gitgitgadget
