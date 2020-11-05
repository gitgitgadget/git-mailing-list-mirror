Return-Path: <SRS0=KwJF=EL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29FA0C4741F
	for <git@archiver.kernel.org>; Thu,  5 Nov 2020 18:22:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A66DF2078E
	for <git@archiver.kernel.org>; Thu,  5 Nov 2020 18:22:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="u9nF1nZo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731234AbgKESWg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Nov 2020 13:22:36 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59508 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729783AbgKESWg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Nov 2020 13:22:36 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B1827F8AC0;
        Thu,  5 Nov 2020 13:22:32 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=sv+OS5Fc/y2EEj3jpjwDnJSgM1s=; b=u9nF1n
        ZokDNnhnsLcDNIL52A6dIOXD/K0KEDsYSqsGWEbknCqbSo8R8RYphq9+FBgELGjg
        mIgkyg+QBveHD/Zapm7LlUHg4eWOkfiVNaf2Ea2kFqnkARyWDSpB2mcrSixGCRKn
        HDh8Q8NwwsWM81Wap8vpTD6e87LbWRHaHKd+s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=o6ioDOiMVCzYJBqZ+xMPgeNCs9WquGso
        QQp+6mfBp2NH0D3UK9x5QSiNimBKMaIw5CvShD7xd3V6yV8JhVbZh4CqOjaBO92X
        mcAaIc0CBSrUPfOOQXDstkC12CmMH6LoAfEDwJB+CLjkMRavULyb2UeiiQX9u3Up
        q/dr0e1CW+U=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A9D75F8ABF;
        Thu,  5 Nov 2020 13:22:32 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id EE1FCF8ABE;
        Thu,  5 Nov 2020 13:22:29 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>,
        git@vger.kernel.org,
        Abhishek Kumar via GitGitGadget <gitgitgadget@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v4 06/10] commit-graph: implement corrected commit date
References: <pull.676.v3.git.1597509583.gitgitgadget@gmail.com>
        <pull.676.v4.git.1602079785.gitgitgadget@gmail.com>
        <694ef1ec08d9dc96a74a2631b2710ad206397dbc.1602079786.git.gitgitgadget@gmail.com>
        <85r1pjzejg.fsf@gmail.com> <20201103114432.GA3577@Abhishek-Arch>
        <85pn4tnk8u.fsf@gmail.com>
        <efa3488a-3983-3435-e5e4-2eb71e76a33a@iee.email>
Date:   Thu, 05 Nov 2020 10:22:28 -0800
In-Reply-To: <efa3488a-3983-3435-e5e4-2eb71e76a33a@iee.email> (Philip Oakley's
        message of "Thu, 5 Nov 2020 14:05:06 +0000")
Message-ID: <xmqqtuu3k6jf.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DD6432FA-1F93-11EB-8424-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philip Oakley <philipoakley@iee.email> writes:

> This may be not part of the the main project, but could you consider, if
> time permits, also adding some entries into the Git Glossary (`git help
> glossary`) for the various terms we are using here and elsewhere, e.g.
> 'topological levels', 'generation number', 'corrected commit date' (and
> its fancy technical name for the use of date heuristics e.g. the
> 'chronological ordering';).
>
> The glossary can provide a reference, once the issues are resolved. The
> History Simplification and Commit Ordering section of git-log maybe a
> useful guide to some of the terms that would link to the glossary.

Ah, I first thought that Documentation/rev-list-options.txt (which
is the relevant part of "git log" documentation you mention here)
already have references to deep technical terms explained in the
glossary and you are suggesting Abhishek to mimic the arrangement by
adding new and agreed-upon terms to the glossary and referring to
them from the commit-graph documentation updated by this series.

But sadly that is not the case.  What you are saying is that you
noticed that rev-list-options.txt needs a similar "the terms we use
to explain these two sections should be defined and explained in the
glossary (if they are not) and new references to glossary should be
added there" update.

In any case, that is a very good suggestion.  I agree that updating
"git log" doc may be outside the scope of Abhishek's theme, but it
would be very good to have such an update by anybody ;-)

Thanks
