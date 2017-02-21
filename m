Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9CB9E201A9
	for <e@80x24.org>; Tue, 21 Feb 2017 20:56:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752339AbdBUU4y (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Feb 2017 15:56:54 -0500
Received: from mail-it0-f42.google.com ([209.85.214.42]:35142 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751208AbdBUU4w (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Feb 2017 15:56:52 -0500
Received: by mail-it0-f42.google.com with SMTP id 203so125575312ith.0
        for <git@vger.kernel.org>; Tue, 21 Feb 2017 12:56:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=HURHinLbo/ooGkYIXfLAmIqdDu3QZog4J3LINEmXVqw=;
        b=BCdkU6+N73FzVlCEt0Cy6PrcyoUcV0yNbzFKg2ZqeFHlvzX9oS8BDkNhmnnKG1g1+b
         DVbZZ9utV69gMbosFUWiKRjLEJksju2M7UBcdrjea3VagiZwJVy/DNNaHDNG4dSCqjL2
         L2FhyX1PBjAZ4R9VgEk6zwo8EF9vVOrlLQ3z8lQNA2FB19HCAyBXmDqGM9+q5/H34jWn
         X2BTLwXKPZAwN8jZIFr9XmsaQhAQZZkyy/jv6ISSSA5y/tePYQk+QYTz46P77XxAdAtW
         qTNjEon85iyGPP1UsrcsSJKoTUAtA9hMubXC6pSSi8THw+K10i3jPcfgz6ZYdPD9T8EZ
         vjvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=HURHinLbo/ooGkYIXfLAmIqdDu3QZog4J3LINEmXVqw=;
        b=mCqhAzSiyVmVCAnb7ypxkJyhgr3mkYiWxBtBtxSTB2vCMRCUyvAJ0HERQtgf/7d+r5
         PaKh6o41i6NGt5v3G1/M64F05kWBsywRSeFtpyihiMH8uZOPMEB6cmJ6pXzj9b3xniEe
         iVuVWZPf3Y9dCo0p8yEtgktvj2xG13O92APlZOuH9GKtc8sXJjYXYyaRrorimE8KRlHg
         jvTq4Svt5qw1BTLtENrUzN3CdnUPa0nmlMg0UZpDLg7Z+g3zgoSqfMf/x3n5vNJ7kBFY
         yo9tgNoWHaviUdQ4ERXepTj8FdM3Ef7u+o/hwglrbR9G70VTx3uHVSyzmdX9DBgN9sUL
         t03w==
X-Gm-Message-State: AMke39ngGqflnvk97vXr1yOL4gZhz0nPD/HQYfRqn4LIvRXHc7sllB5SGCkoD0SygEJfi55nb6zRw2BM4W8GPiTj
X-Received: by 10.36.65.4 with SMTP id x4mr30094799ita.69.1487710611277; Tue,
 21 Feb 2017 12:56:51 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.33.148 with HTTP; Tue, 21 Feb 2017 12:56:50 -0800 (PST)
In-Reply-To: <CA+P7+xqpxTt7KibOrVr2ekjLy6Hva4KJ6nCaN22j-Qpspky3aQ@mail.gmail.com>
References: <xmqq8tp74823.fsf@gitster.mtv.corp.google.com> <20170216003811.18273-1-sbeller@google.com>
 <20170216003811.18273-9-sbeller@google.com> <CA+P7+xqpxTt7KibOrVr2ekjLy6Hva4KJ6nCaN22j-Qpspky3aQ@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 21 Feb 2017 12:56:50 -0800
Message-ID: <CAGZ79kbCvHkooxwFyhixnGKG4pSp8AX8UjCKr9OJzJm_EJEV5Q@mail.gmail.com>
Subject: Re: [PATCH 08/15] submodules: introduce check to see whether to touch
 a submodule
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 17, 2017 at 10:36 AM, Jacob Keller <jacob.keller@gmail.com> wrote:
> On Wed, Feb 15, 2017 at 4:38 PM, Stefan Beller <sbeller@google.com> wrote:
>> In later patches we introduce the --recurse-submodule flag for commands
>> that modify the working directory, e.g. git-checkout.
>>
>> It is potentially expensive to check if a submodule needs an update,
>> because a common theme to interact with submodules is to spawn a child
>> process for each interaction.
>>
>> So let's introduce a function that checks if a submodule needs
>> to be checked for an update before attempting the update.
>>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>>  submodule.c | 27 +++++++++++++++++++++++++++
>>  submodule.h | 13 +++++++++++++
>>  2 files changed, 40 insertions(+)
>>
>> diff --git a/submodule.c b/submodule.c
>> index 591f4a694e..2a37e03420 100644
>> --- a/submodule.c
>> +++ b/submodule.c
>> @@ -548,6 +548,33 @@ void set_config_update_recurse_submodules(int value)
>>         config_update_recurse_submodules = value;
>>  }
>>
>> +int touch_submodules_in_worktree(void)
>> +{
>> +       /*
>> +        * Update can't be "none", "merge" or "rebase",
>> +        * treat any value as OFF, except an explicit ON.
>> +        */
>> +       return config_update_recurse_submodules == RECURSE_SUBMODULES_ON;
>> +}
>
> Ok, so here, we're just checking whether the value is
> RECURSE_SUBMODULES_ON. The comment doesn't make sense to me at all.

Yes the comment was not updated in the last round of patches and is
now out of context.

> What is "update" and why "can't" it be those values? How is this code
> treating thise values as OFF exept for an explicit ON?

Please disregard the comment; I'll remove it in the next reroll.
The submodule API is in such a way that
config_update_recurse_submodules

>
> At first I thought this comment was related to check in the previous
> patch. I think I see the patch is "recurse submodules = true" or
> "recurse submodules = checkout" as a specific strategy? Ie:
> recurse-submodules=checkout" means "recurse into submodules and update
> them using checkout strategy?

Yes that is what I had in mind. See previous comment, in a later series
we could extend that to other strategies such as "revert-in-submodules"
for git-revert or "rebase", "merge" as we curreently have for
"git submodule update".

> Maybe this should be called something like
> recurse_into_submodules_in_worktree() though that is pretty verbose.

I like that. (It's less than double the number of characters, so it's
fine, isn't it?)
Maybe we can abbreviate worktree by "wt" ans "submodules by subs:

    /* recurse into submodules in the worktree? */
    int rec_subs_wt;

That looks short enough to qualify as non-Java.

> I'm not sure I have a good name really. But I wonder why we need this
> in the first place. Basically, we set RECURSE_SUBMODULES_* value which
> could be OFF, ON, or even future extensions of CHECKOUT, REBASE,
> MERGE, etc?
>
> But shouldn't we just return the mode, and let the later code decide
> "oh. actually I don't support this mode". For now, obviously we
> wouldn't set any of the new modes yet.

Mh, makes sense. Maybe I tricked myself into premature optimization,
because I'd expect most of the users not caring about submodules, such
that we want to have a *really* cheap way of saying "no, not interesting in
submodules", which is what this method mainly offers.

Junio also remarked this and the following
"is_active_submodule_with_strategy" to be bad design.

I'll redo those, such that the caller decides what to do with each strategy.

>
>> +
>> +int is_active_submodule_with_strategy(const struct cache_entry *ce,
>> +                                     enum submodule_update_type strategy)
>> +{
>> +       const struct submodule *sub;
>> +
>> +       if (!S_ISGITLINK(ce->ce_mode))
>> +               return 0;
>> +
>> +       if (!touch_submodules_in_worktree())
>> +               return 0;
>> +
>> +       sub = submodule_from_path(null_sha1, ce->name);
>> +       if (!sub)
>> +               return 0;
>> +
>> +       return sub->update_strategy.type == strategy;
>> +}
>> +
>
> I liked Junio's suggestion where this just returns the strategy that
> it can use, or 0 if it shouldn't be updated. Then, other code just
> decides: Yes, I can use this strategy or no I cannot.
>
> Should this be tied in with the strategy used by the
> recurse_submodules above? ie: when/if we support recursing using other
> strategies, shouldn't we make these match here, so that if the recurse
> mode is "checkout" we don't checkout a submodule that was configured
> to be rebased? Or do you want to blindly apply checkout to all
> submodules even if they don't have strategy?
>
> I assume you do not, since you check here with passing a strategy
> value, and then see if it matches.
>
> this could be named something like:
>
> get_active_submodule_strategy() and return the strategy directly. It
> would then return 0 in any case where it shouldn't be updated. Later
> code can then check the strategy.

0 is already taken as SM_UPDATE_UNSPECIFIED,
so maybe we'd introduce a new update command
SM_UPDATE_IGNORE = -1 or rather use
SM_UPDATE_NONE instead.

>
>>  static int has_remote(const char *refname, const struct object_id *oid,
>>                       int flags, void *cb_data)
>>  {
>> diff --git a/submodule.h b/submodule.h
>> index b4e60c08d2..46d9f0f293 100644
>> --- a/submodule.h
>> +++ b/submodule.h
>> @@ -65,6 +65,19 @@ extern void show_submodule_inline_diff(FILE *f, const char *path,
>>                 const struct diff_options *opt);
>>  extern void set_config_fetch_recurse_submodules(int value);
>>  extern void set_config_update_recurse_submodules(int value);
>> +
>> +/*
>> + * Traditionally Git ignored changes made for submodules.
>> + * This function checks if we are interested in the given submodule
>> + * for any kind of operation.
>
> This comment seems a bit weird.

correct, I'll reword that.

>
>> + */
>> +extern int touch_submodules_in_worktree(void);
>> +/*
>> + * Check if the given ce entry is a submodule with the given update
>> + * strategy configured.
>
> I like Junio's suggestion of this "getting the current configured
> strategy for a submodule. When we aren't set to recurse into
> submodules we (obviously) return that we have no strategy since we're
> not going to update it at all.
>
>> + */
>> +extern int is_active_submodule_with_strategy(const struct cache_entry *ce,
>> +                                            enum submodule_update_type strategy);
>>  extern void check_for_new_submodule_commits(unsigned char new_sha1[20]);
>>  extern int fetch_populated_submodules(const struct argv_array *options,
>>                                const char *prefix, int command_line_option,
>> --
>> 2.12.0.rc1.16.ge4278d41a0.dirty
>>
