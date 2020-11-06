Return-Path: <SRS0=eTRQ=EM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 939A5C2D0A3
	for <git@archiver.kernel.org>; Fri,  6 Nov 2020 18:26:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C5A520728
	for <git@archiver.kernel.org>; Fri,  6 Nov 2020 18:26:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LIZ0MAnk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727647AbgKFS01 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Nov 2020 13:26:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbgKFS00 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Nov 2020 13:26:26 -0500
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96361C0613CF
        for <git@vger.kernel.org>; Fri,  6 Nov 2020 10:26:26 -0800 (PST)
Received: by mail-ed1-x543.google.com with SMTP id b9so2223612edu.10
        for <git@vger.kernel.org>; Fri, 06 Nov 2020 10:26:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=iXNcXKMrc48TLOIvpUKtM4u5umSXW2CToOzciNo3rT8=;
        b=LIZ0MAnktL4ZbAufOXbg8IepHhv74xWJlfBmLn43+v8J/CIExXbzLj3VyIe3hioOr/
         uopzZfp0DLZgFhtr8m2toWtwcne1uAt+Z6Jr+A9s7QLzHPbtmZP1C7whvlD+tO86UM5e
         8vAS/UkrqBGkhLsJaUUTV6IGMKrm7q1tjiyndhQXPgqbiFDOy2H1DAkySfdq3WuOjkvD
         3nbhkEg7Gn74Np5gutEHDK8khonwHKIib9uvhxRZ44MtgDv37crwffOhxcw7lhCfIeLV
         fillkQE5xiZjDcc7j+DQVEHJGi0FQGu8ylQ83L8XrP9Z2BR45Gl176AqNWUcqCA7yO+3
         3y0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=iXNcXKMrc48TLOIvpUKtM4u5umSXW2CToOzciNo3rT8=;
        b=Jqmu5Jh4XM8In+9zJov8Lbp89tAJj7H19QpAHmiy3D0wNrQWvR4b0zMEVqgiqzbm7f
         2Au12AmEezjc54Hi3OHO3qDG46WHgt/3NtbG0sonjkrFQ/o90ElzrXNqJeENP1P/pgSQ
         9np802qW+wiimKHGOL5hLNUIT4HAWHulK+8f3YCvNi41Z4IarctPO6gVOz0MhQWPr/mY
         f8waFzUVU7nde6nFA3OoYENYvyXKv+2L52oXLzKtjPSYOXtqneHjnyy3NRj5SCDK8rIU
         0JBCOoDtnCVtc97W/NPThIO4ZNyLOsdsRu8cPWP/FSr1jEOiFi7bmrkLomYBeUr+k7fY
         8sOQ==
X-Gm-Message-State: AOAM531mIbekqJ5zkRIF4zAqFfS/OyTMJNWHWoexyDThSSWFE0WHrI4B
        Cd0TD2+W8RcL592gmXVysKJs7X2kImLDnDGJ
X-Google-Smtp-Source: ABdhPJywPfXPqyDwvVc4JM1DzEsOwOkeIIq71TuEexDm9iAY4pJEzeNc4ms3xtA6Ok0TV9kkHUggjg==
X-Received: by 2002:a50:f98b:: with SMTP id q11mr3485259edn.345.1604687185275;
        Fri, 06 Nov 2020 10:26:25 -0800 (PST)
Received: from LAPTOP-ACER-ASPIRE-F5 (host-89-229-7-83.dynamic.mm.pl. [89.229.7.83])
        by smtp.gmail.com with ESMTPSA id bx24sm1466829ejb.51.2020.11.06.10.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 10:26:24 -0800 (PST)
From:   Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Philip Oakley <philipoakley@iee.email>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>,
        git@vger.kernel.org,
        Abhishek Kumar via GitGitGadget <gitgitgadget@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Extending and updating gitglossary (was: Re: [PATCH v4 06/10] commit-graph: implement corrected commit date)
References: <pull.676.v3.git.1597509583.gitgitgadget@gmail.com>
        <pull.676.v4.git.1602079785.gitgitgadget@gmail.com>
        <694ef1ec08d9dc96a74a2631b2710ad206397dbc.1602079786.git.gitgitgadget@gmail.com>
        <85r1pjzejg.fsf@gmail.com> <20201103114432.GA3577@Abhishek-Arch>
        <85pn4tnk8u.fsf@gmail.com>
        <efa3488a-3983-3435-e5e4-2eb71e76a33a@iee.email>
        <xmqqtuu3k6jf.fsf@gitster.c.googlers.com>
Date:   Fri, 06 Nov 2020 19:26:23 +0100
In-Reply-To: <xmqqtuu3k6jf.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Thu, 05 Nov 2020 10:22:28 -0800")
Message-ID: <85zh3ujq9c.fsf_-_@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:
> Philip Oakley <philipoakley@iee.email> writes:
>
>> This may be not part of the the main project, but could you consider, if
>> time permits, also adding some entries into the Git Glossary (`git help
>> glossary`) for the various terms we are using here and elsewhere, e.g.
>> 'topological levels', 'generation number', 'corrected commit date' (and
>> its fancy technical name for the use of date heuristics e.g. the
>> 'chronological ordering';).
>>
>> The glossary can provide a reference, once the issues are resolved. The
>> History Simplification and Commit Ordering section of git-log maybe a
>> useful guide to some of the terms that would link to the glossary.
>
> Ah, I first thought that Documentation/rev-list-options.txt (which
> is the relevant part of "git log" documentation you mention here)
> already have references to deep technical terms explained in the
> glossary and you are suggesting Abhishek to mimic the arrangement by
> adding new and agreed-upon terms to the glossary and referring to
> them from the commit-graph documentation updated by this series.
>
> But sadly that is not the case.  What you are saying is that you
> noticed that rev-list-options.txt needs a similar "the terms we use
> to explain these two sections should be defined and explained in the
> glossary (if they are not) and new references to glossary should be
> added there" update.
>
> In any case, that is a very good suggestion.  I agree that updating
> "git log" doc may be outside the scope of Abhishek's theme, but it
> would be very good to have such an update by anybody ;-)

The only possible problem I see with this suggestion is that some of
those terms (like 'topological levels' and 'corrected commit date') are
technical terms that should be not of concern for Git user, only for
developers working on Git.  (However one could encounter the term
"generation number" in `git commit-graph verify` output.)

I don't think adding technical terms that the user won't encounter in
the documentation or among messages that Git outputs would be not a good
idea.  It could confuse users, rather than help them.

Conversely, perhaps we should add Documentation/technical/glossary.txt
to help developers.


P.S. By the way, when looking at Documentation/glossary-content.txt, I
have noticed few obsolescent entries, like "Git archive", few that have
description that soon could be or is obsolete and would need updating,
like "master" (when default branch switch to "main"), or "object
identifier" and "SHA-1" (when Git switches away from SHA-1 as hash
function).

Best,
--
Jakub Nar=C4=99bski
