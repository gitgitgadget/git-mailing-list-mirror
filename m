Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AD1BECAAA1
	for <git@archiver.kernel.org>; Fri,  9 Sep 2022 19:46:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231694AbiIITq0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Sep 2022 15:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231683AbiIITqB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2022 15:46:01 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FCAF14996E
        for <git@vger.kernel.org>; Fri,  9 Sep 2022 12:42:41 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id s14-20020a17090a6e4e00b0020057c70943so6316600pjm.1
        for <git@vger.kernel.org>; Fri, 09 Sep 2022 12:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=J3m5OkulZZtoydSfRv7J+aExCFIRFv34HlBS3i5nBpA=;
        b=LWJCAhei0VxEvHqRwIatZVld5QHhMynhdot12Vz3nOikXInv7ldayf619JYmMtDbug
         T+55j8SVGNwBhzV0eOipnEd8d3yZgH3EnMqeCYdjTn1nPLBPON8g1WsvndEit8Ld4Zg+
         KvuYpS7AYvPhG6VbnyDGtp0RfawNeBPaFoA2OCnPVylt3k0y4/Q8iICVREjNvMvJa67r
         4tSa2FjYpHQUwaFcODGUiH+B0qCBkPC+SGgtwseKQYQfn3iYOZWZDi6Z1wttWwbkfWGl
         U7bU5ZEDHC+I/H0ukd3WDmJRBn1Cd4DjmbKv269aKO2BntDyz0GzKGSmSjOS++PVfS7f
         VMpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date;
        bh=J3m5OkulZZtoydSfRv7J+aExCFIRFv34HlBS3i5nBpA=;
        b=Tgny7HLcr048VyFW7qKGu6kIQTFWBMWNVviUfwSoxqmTqrd2f96zq2EfK+5wnesYyW
         /T0FoVJMTbisno3M5MDZ6NSk8SRNw8PBY6UAYbkw5bCI1n9v1K6PTQbw61PjAjtztnAw
         +UPFIqWfbtMdWwIofYKatULNWzCe+JI6061jW90Mr4o7HEblX7up056TZh38/4op6C9k
         zbP1C4KRjC5srxFG1uPJ/tHHv1hTTpFXoqUrZVPccGhq1nRbNP+bBNEZ+o6F7Aj8jqax
         ETcROpyEAjVzO2E1AVgiqX4b3J4lDApCrHfPsXgG1en4HeKxxo0G0ZbS+kmBd2bOzxST
         3zMg==
X-Gm-Message-State: ACgBeo26Qd2nz+dOwmdxiL5a9DvkbRWag/+Awn1hiTKeZfOX3Z8kk2/F
        ZaUTP2RpUc2yyT+5i6zdd43QKyFRCXw=
X-Google-Smtp-Source: AA6agR7dVoIbkQXOJL4ERYtnODIBqKsASjbGxZpCMR1WxNV1EjyPh+DgBrs3VCrSj0m89lpv8kDsZA==
X-Received: by 2002:a17:90a:e60c:b0:202:6ef8:4b52 with SMTP id j12-20020a17090ae60c00b002026ef84b52mr9382244pjy.236.1662752558217;
        Fri, 09 Sep 2022 12:42:38 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id f13-20020a63e30d000000b00438806e0acbsm921692pgh.4.2022.09.09.12.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 12:42:37 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, derrickstolee@github.com,
        Johannes.Schindelin@gmx.de, steadmon@google.com,
        chooglen@google.com, Victoria Dye <vdye@github.com>
Subject: Re: [PATCH] Documentation: add ReviewingGuidelines
References: <pull.1348.git.1662747205235.gitgitgadget@gmail.com>
Date:   Fri, 09 Sep 2022 12:42:37 -0700
In-Reply-To: <pull.1348.git.1662747205235.gitgitgadget@gmail.com> (Victoria
        Dye via GitGitGadget's message of "Fri, 09 Sep 2022 18:13:25 +0000")
Message-ID: <xmqqwnacibbm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Victoria Dye <vdye@github.com>
>
> Add a reviewing guidelines document including advice and common terminology
> used in Git mailing list reviews. The document is included in the
> 'TECH_DOCS' list in order to include it in Git's published documentation.
>
> Helped-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> Helped-by: Derrick Stolee <derrickstolee@github.com>
> Signed-off-by: Victoria Dye <vdye@github.com>

Thanks, all, for starting this.

> +Patches can also be searched manually in the mailing list archive using a query
> +like `s:"PATCH" -s:"Re:"`. You can browse these results for topics relevant to
> +your expertise or interest.

It probably is a good idea to say "the 'lore.kernel.org' mailing
list archive" somewhere here, as the queries may not work on other
archives like marc.info/?l=git archive.

> +If you've already contributed to Git, you may also be CC'd in another
> +contributor's patch series. These are usually topics where the author feels that
> +your attention is warranted; this may be due to prior contributions,
> +demonstrated expertise, and/or interest in related topics. There is no
> +requirement to review these series, but you may find them easier to review as a
> +result of your preexisting background knowledge on the topic.

I think "your attention is warranted" is a good way to summarize,
but the readers may want to know that the reason for Cc'ing ranges
from "you may want to know that I am about to butcher the code you
wrote earlier, which you might care about (so I am giving a notice
so that you can stop me and offer a better alternative)" to "your
reviewing would really help making this patch better".

It is true that there is no requirement to review anything, but
scratching each other's back, especially the reason for Cc'ing is to
request help, is in the spirit of working on a piece of open source
software.  That may be more important than knowing that they may be
easier to review than others.


> +- If a patch is long, you can delete parts of it that are unrelated to your
> +  review from the email reply. Make sure to leave enough context for readers to
> +  understand your comments!

"you can" -> "it is encouraged to"

> +- When pointing out an issue, try to include suggestions for how the author
> +  could fix it. This not only helps the author to understand and fix the issue,
> +  it also deepens and improves your understanding of the topic.

Thanks for saying "try to".  Sometimes reviewers can tell something
is wrong without being able to say what the alternative is that is
right, but at least they should try before saying "that one is wrong"
and stopping at it.

> +- Reviews do not need to exclusively point out problems. Feel free to "think out
> +  loud" in your review: describe how you read & understood a complex section of
> +  a patch, ask a question about something that confused you, point out something
> +  you found exceptionally well-written, etc. In particular, uplifting feedback
> +  goes a long way towards encouraging contributors to participate more actively
> +  in the Git community.

Good piece of advice.  It also helps if the authors understood the
above.  A review response to a patch may not necessarily point out
the problems and they do not need to become defensive.

> +- When providing a recommendation, be as clear as possible about whether you
> +  consider it "blocking" (the code would be broken or otherwise made worse if an
> +  issue isn't fixed) or "non-blocking" (the patch could be made better by taking
> +  the recommendation, but acceptance of the series does not require it).
> +  Non-blocking recommendations can be particularly ambiguous when they are
> +  related to - but outside the scope of - a series ("nice-to-have"s), or when
> +  they represent only stylistic differences between the author and reviewer.

I hear that some communities take the "reviewer wins" approach to
tiebreak the last one.  In any case, it is a good piece of advice to
make sure which parts are "just thinking out aloud" and which parts
are pointing out problems in the patch that need to be corrected in
the next iteration.  The former may observe an existing problem in
the code in context that may need to be addressed in the longer term
but can be left out of the scope of the topic, and being clear about
that is helpful to the author.

> +- If you read and review a series but find nothing that warrants inline
> +  commentary, reply to the series' cover letter to indicate that you've reviewed
> +  the changes.

I would prefer to see folks avoid doing this on the initial
iteration of a topic, until/unless the reviewer has demonstrated
proficiency in the affected area.  If everybody considers that you
are one of the authorities of revision traversal and the patch
series is about updating revision.c, then such a "I've reviewed and
everything is so clean there is nothing to say" may be helpful, but
it is hard to put a proper weight on such a statement by somebody
whose understanding of the area is not well known.  

It is a different story to give such a "looks good" on a second and
subsequent iteration by a reviewer who commented on an earlier
round, of course.

> +Completing a review
> +~~~~~~~~~~~~~~~~~~~
> +Once each patch of a series is reviewed, the author (and/or other contributors)
> +may discuss the review(s). This may result in no changes being applied, or the
> +author will send a new version of their patch(es).
> +
> +After a series is rerolled in response to your or others' review, make sure to
> +re-review the updates. If you are happy with the state of the patch series,
> +explicitly indicate your approval (typically with a reply to the latest
> +version's cover letter). Optionally, you can let the author know that they can
> +add a "Reviewed-by: <you>" trailer to subsequent versions of their series.

"to subsequent versions" -> "if they resubmit the reviewed patch verbatim".

> +Finally, subsequent "What's cooking" emails may explicitly ask whether a
> +reviewed topic is ready for merging to the `next` branch (typically phrased
> +"Will merge to 'next'?"). You can help the maintainer and author by responding
> +with a short description of the state of your (and others', if applicable)
> +review.

Thanks for mentioning this.  "We have reached the agreement that,
while this and that have room for improvement, the patch is a strict
improvement over the status quo, and should move forward, at <URL>"
that points into the lore archive would be the most easy and clear.

Everything else I did not quote from your patch looked good to me
without any need to comment.

Thanks.
