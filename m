Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C75E4C4361B
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 22:20:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E16523B5D
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 22:20:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbgLRWTx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Dec 2020 17:19:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbgLRWTx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Dec 2020 17:19:53 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C0BFC0617B0
        for <git@vger.kernel.org>; Fri, 18 Dec 2020 14:19:13 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id m25so9174284lfc.11
        for <git@vger.kernel.org>; Fri, 18 Dec 2020 14:19:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=rogQqFJ757RsGWd+rmHcn/R3esB2Q0BAO/g5e+1b6iw=;
        b=A6RcMB1Y+f0DbsmcktrP8gceZgfw4BDcjmTSbNUBJYamqbAR2vM7nRNlkP0jKBJAej
         rRCjczh9d/PLls/tm+2yavD1W9mwgM9cJKjtmZTHibcKQqUena/yLpSfe/zKnJjOwl26
         Ep7SqC4Bh04YOMvkou/n7eBkmPg8ycg2EOjsRVj7fO+Nje2rqc6Au5bhAEJMIwAiy4So
         LqKSW9hV89t+O/e39PuBwqyoLPqbzdEGcPNM3SZ843VBODQO0L4TiW1v+R915gINRqXW
         iow+y0WnwDjeEodfDjxqMdkb2xnJ7NKCPEP1zFFGaxMgRUJHh9cBRzhndhnZsRNCNI7i
         tlsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=rogQqFJ757RsGWd+rmHcn/R3esB2Q0BAO/g5e+1b6iw=;
        b=jd6DteNtCKrxzKUSgaIemxTHVDBA6tGcrdsRdGn2ld2NZmPbME5z9tIqA+S5dIFiKG
         2ed0uhnw2x0+EXa0lYdKmvrgXQWivH0QCOAEpN3/a/z1ebyotJHcio/AtT5Ht5ycB/nL
         +ZzmXGDhdDrrsbWEYJNBEzf9Ze89pSSAP0H5Pmtz1QmQkVk7YbRGlbXt8r5Cd9MebhiC
         N9BsDzH77OIkHCgWm0kVIgr0esT+9VyOglKhuDiGGzoaZVhufUrBnxzAltNIfaBAP+Ix
         /tgQKzv2swwnvOCiN4J838hyr9uGZeQmos5qS2O+tM+H/tCt7x0CTK+ciZ9zcxI/BCMZ
         gMcA==
X-Gm-Message-State: AOAM533yIlO9SPAp/t70G1P69Wdw9fZ8JdzyhSgQGhJP+20H9t7uOtAv
        BHumpkTcjY9ykWaGIRCYUGk2JsTIWao=
X-Google-Smtp-Source: ABdhPJy4t9F7UQMU+Ok8zcSKpEkHsDitn488Iyrk5ciTtrmmYdtTXMFhlTqoQf8B0yYpdFUlDi9BIQ==
X-Received: by 2002:a2e:a40b:: with SMTP id p11mr2624843ljn.315.1608329951363;
        Fri, 18 Dec 2020 14:19:11 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id x15sm28787lfc.62.2020.12.18.14.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Dec 2020 14:19:10 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v2 26/33] diff-merges: let new options enable diff
 without -p
References: <20201101193330.24775-1-sorganov@gmail.com>
        <20201216184929.3924-1-sorganov@gmail.com>
        <20201216184929.3924-27-sorganov@gmail.com>
        <CABPp-BHu2xLZLfwBg+hzNEKQ0K=EyT1HLqJO9=pNzBFf4MqR=A@mail.gmail.com>
        <87wnxfb2gt.fsf@osv.gnss.ru>
        <CABPp-BG4GEmv20YK39M51nzTYVZtcLgD-UbmQLfgynjUhBKx9w@mail.gmail.com>
        <87o8iq97o2.fsf@osv.gnss.ru>
        <CABPp-BF6YyNNYT1i_56=89TjtKEj09bs6TOXJWYKXsC6yAZ0Rw@mail.gmail.com>
Date:   Sat, 19 Dec 2020 01:19:10 +0300
In-Reply-To: <CABPp-BF6YyNNYT1i_56=89TjtKEj09bs6TOXJWYKXsC6yAZ0Rw@mail.gmail.com>
        (Elijah Newren's message of "Fri, 18 Dec 2020 14:06:20 -0800")
Message-ID: <87ft427o69.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> On Fri, Dec 18, 2020 at 12:32 PM Sergey Organov <sorganov@gmail.com> wrote:
>>
>> Elijah Newren <newren@gmail.com> writes:
>>
>> > On Fri, Dec 18, 2020 at 6:42 AM Sergey Organov <sorganov@gmail.com> wrote:
>> >>
>> >> Elijah Newren <newren@gmail.com> writes:
>> >>
>> >> > On Wed, Dec 16, 2020 at 10:50 AM Sergey Organov
>> >> > <sorganov@gmail.com> wrote:
>>
>> [...]
>>
>> >> >> diff --git a/log-tree.c b/log-tree.c
>> >> >> index f9385b1dae6f..67060492ca0a 100644
>> >> >> --- a/log-tree.c
>> >> >> +++ b/log-tree.c
>> >> >> @@ -899,15 +899,21 @@ static int log_tree_diff(struct rev_info
>> >> >> *opt, struct commit *commit, struct log
>> >> >>         int showed_log;
>> >> >>         struct commit_list *parents;
>> >> >>         struct object_id *oid;
>> >> >> +       int is_merge;
>> >> >> + int regulars_need_diff = opt->diff ||
>> >> >> opt->diffopt.flags.exit_with_status;
>> >> >
>> >> > So rev_info.diff has changed in meaning from
>> >> > commits-need-to-show-a-diff, to non-merge-commits-need-to-show-a-diff.
>> >> > That's a somewhat subtle semantic shift.  Perhaps it's worth adding a
>> >> > comment to the declaration of rev_info.diff to highlight this?  (And
>> >> > perhaps even rename the flag?)
>> >>
>> >> No, the meaning of rev_info.diff hopefully didn't change. rev_info.diff
>> >> still enables all the commits to pass further once set. It is still
>> >> exactly the same old condition, just assigned to a variable for reuse.
>> >> My aim was to avoid touching existing logic of this function and only
>> >> add a new functionality when opt->merges_need_diff is set.
>> >>
>> >> It looks like I rather choose confusing name for the variable, and it'd
>> >> be more clear if I'd call this, say:
>> >>
>> >>   int need_diff = opt->diff || opt->diffopt.flags.exit_with_status;
>> >>
>> >> ?
>> >>
>> >> What do you think?
>> >
>> > I think need_diff would actually be confusing.  It can be false when
>> > you need diffs (e.g. --diff-merges=cc with no -p, because then you'd
>> > need diffs for merge commits and not for non-merge commits).  I'd
>> > stick with your original local variable name.
>> >
>> > Perhaps opt->diff hasn't changed meaning and I just had a wrong mental
>> > model in my head for what it meant, but even then what seems like its
>> > obvious purpose given its name is mismatched with what it actually
>> > does.  Since you are already changing struct rev_info in this series,
>> > this was more a note that a name change or at least a comment for
>> > opt->diff might be useful.  I mean, you asked a couple times on the
>> > previous series for help trying to understand it, and I could only
>> > offer some flailing guesses and Junio responded with a couple bits of
>> > history.  Clearly, it isn't very clear and this patch reminded me of
>> > that and made me wonder if we're possibly making it a little harder
>> > for others further down the road to figure out.
>>
>> I still don't see why opt->diff is needed in the first place, and
>> second, why opt->diffopt.flags.exit_with_status check is here? Why
>> whoever sets opt->diffopt.flags.exit_with_status doesn't just set
>> opt->diff as well (provided opt->diff is needed in the first place)?
>>
>> From the aforementioned discussion it looks like opt->diff is an
>> optimization (maybe a remnant from the times when diff was a separate
>> script), and that apparently there is some code instance somewhere that
>> actually relies on the fact that clearing opt->diff is enough to disable
>> diff machinery (as followed from my experiment of removing the check
>> altogether and then getting only single seemingly unrelated test
>> failing.)
>>
>> Overall, neither have I any idea how to clarify this, nor do I want to
>> bother in this patch series. It'd be nice though if somebody who really
>> does understand diff machinery in Git does the job.
>
> Doh, I was hoping you had it all figured out.

I tried. I failed. :-)

> If not, then that's a fair enough argument not to attempt to clarify.

This.

Thanks,
-- Sergey
