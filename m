Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86739C4361B
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 09:47:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50F5023A82
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 09:47:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732310AbgLRJrV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Dec 2020 04:47:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbgLRJrU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Dec 2020 04:47:20 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 546A4C0617A7
        for <git@vger.kernel.org>; Fri, 18 Dec 2020 01:46:40 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id 11so1368627oty.9
        for <git@vger.kernel.org>; Fri, 18 Dec 2020 01:46:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=HBGKK3PnoKnxFuh7CfaL87I76Xm3XZAn1IHZZ4PIBTY=;
        b=gmEn8/IBDRkPcO0U2zJXSjCW78xefnhsNQomxjT3cT8sYS/8Ba0gaPdYl+QDF9zB91
         t8weM9IE2e+/+5b/1KpUfmP3iouiK6iU46alWqeLbGtGG0lTkogUDNFwM0JckFoFIggD
         VGl5WRazWKezDQrC8SiWMqpTVDnbmerXy357PucbAX4FjvBV3fmjcpGFZidEi4Q7VJgn
         oCyQw9G19f4zOx15uHfkuYIMIIFJNgI52uD/adBgAN3yqXOaBl/fbXR9Jk9aeWPHL1CB
         gh66Ntg2kS/Faz1s/GYlZQNpUDiOsZ6QUz+ZhxYz2UkoRVsQULAim4TLV1T2KJnmC5Dp
         wGsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=HBGKK3PnoKnxFuh7CfaL87I76Xm3XZAn1IHZZ4PIBTY=;
        b=dhlU5kfomdD6XEHARLOxZii87KiNaWn6lwp0bq+MbX4zeOo+8i91LgO0H9oJ5ZdqGq
         ZusAdn95zLmih9AARAmmZ0MVt4NC5mr0Q6PqPdtyc03lm2UvwUy/Gn3NGsUIpkcexru5
         1V3g/EQJezpX8+I32uEOcXBFz/uPdWUPm8DKINS31QkNeV9XScNREtzhLz7MOcnlwKFN
         NoX9Dp2fbBDnLT774vxitLwxr+ZmaO4zzaCzAH+8Tg4y328NDPJlmFbMpHoAixHKkx8K
         qhFEKWxFt3rpm4b5OJcl2xW0Uh+ui9h2uFGRq2wfkf/BvuAYO9O9C3ASB7x0ZTF3REb5
         IF1w==
X-Gm-Message-State: AOAM532g39UuT4PutUKpQnulM/BRxyYVgJ9czQHmyJ8ftIfLcnFtcFYg
        9p1kFjaJ9/o4aVHXOGMEQ60=
X-Google-Smtp-Source: ABdhPJxSj7h1HCQEKUugiznX2S2wJMhh+MgJrTYEy/NAhMw982DXuAfZ6vUsSz94To4lCQ8sSP4KZA==
X-Received: by 2002:a05:6830:1d66:: with SMTP id l6mr2202820oti.23.1608284799582;
        Fri, 18 Dec 2020 01:46:39 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id f201sm1687243oig.21.2020.12.18.01.46.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Dec 2020 01:46:38 -0800 (PST)
Date:   Fri, 18 Dec 2020 03:46:37 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Seth House <seth@eseth.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Johannes Sixt <j6t@kdbg.org>, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org, David Aguilar <davvid@gmail.com>
Message-ID: <5fdc7a7d3a933_f4673208d0@natae.notmuch>
In-Reply-To: <20201218054947.GA123376@ellen>
References: <xmqqa6ud2xuw.fsf@gitster.c.googlers.com>
 <105041520.23756286.1608159189934.JavaMail.zimbra@eseth.com>
 <5fdaef83a40ba_d0e26208f6@natae.notmuch>
 <e5c73fed-b87e-2091-794e-19aced4dd25b@kdbg.org>
 <20201217094424.GA75257@ellen>
 <5fdb3471c6bb7_d6d032087@natae.notmuch>
 <20201217175037.GA80608@ellen>
 <5fdc0e6dd79a7_f2faf208a1@natae.notmuch>
 <20201218023534.GA117762@ellen>
 <5fdc18a91c402_f2faf20837@natae.notmuch>
 <20201218054947.GA123376@ellen>
Subject: Re: [RFC/PATCH] mergetool: use resolved conflicts in all the views
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Seth House wrote:
> On Thu, Dec 17, 2020 at 08:49:13PM -0600, Felipe Contreras wrote:
> > And no person is the sole arbiter of truth, in this list, or anywhere.
> > People have managed to change Junio's mind.
> 
> I'm not worried about Junio but I am wondering if anyone has managed to
> change your mind.

Yes, with evidence and reasoning.

> You and I have been going back and forth on this list
> and on Reddit for two solid days and, to be frank, I'm running out of
> steam.

That doesn't mean you are right.

> > You said you would provide a list of tools that would be affected.
> 
> No, I said I would provide a list of before/after screenshots so people
> in this thread that haven't been following the entire discussion can
> more easily see the differences and benefits of this change.

We can run the simulation in our mind; if uncontested chunks are the
same in all files, then *all* tools would present them with no diff.

No tool would present a diff in the second paragraph. We don't need to
see the screenshots to know that.

I don't see how that effort advances this discussion, at this point
nobody is against this change. The discussion now is about what kind of
configuration it should be: user or tool.

> I can't speak for the preferences of all the mergetool authors out there
> but I will try to convince you of the merit of adding a configuration
> flag in two places instead of just one.

The preferences of mergetool authors do not matter, what matters is how
the users of those tools use them.

We don't need to hear from the author of WinMerge, we need to hear from
Johannes, who uses WinMerge.

Authors are fallible--like everyone else--and they can be wrong about
their own inventions. Play-Doh for example was invented to remove
wallpapers.

It's perfectly fine for a user to use a tool in ways the author did not
intend.

> This took me a long time to write; I would appreciate it if you read
> it slowly and carefully.

Sure.

> There are three broad classifications of mergetools that I've seen so
> far. I've only collected notes for seventeen of them but there are many,
> many others. I mentioned those classifications earlier in this thread
> but to repeat them here:
> 
> 1.  Tools that ignore conflict resolution and simply diff LOCAL and
>     REMOTE. This accounts for most of them.

This is not true.

I already told you this, but *all* tools have MERGED in one of their
panes.

If a tool doesn't have MERGED, then it can't work.

> 2.  Tools that perform their own, internal conflict resolution. Examples
>     are tkdiff, WinMerge, IntelliJ.

OK. I don't see how that is relevant.

> 3.  Tools that reuse Git's conflict resolution by splitting MERGED.
>     Examples are Emacs + Magit, vim-mergetool, diffconflicts.

Interesting. I know 2/3 of the people that are the original authors of
these tools; I know Marius Vollmer (the original author of magit).

However, I don't think magit is a mergetool; you can't do "git mergetool
-t magit".

> This patch *will* (probably) always benefit the first group. Because
> this patch *overwrites* LOCAL and REMOTE those tools will see immediate
> benefit without having to make any changes at all.

Yes.

> This patch *may* benefit the second group, or it may not affect them at
> all, or they may want it off.

Why might they want it off? Let's read...

> If they keep it on they will run conflict resolution against files
> that have already undergone that process in Git and likely turn up no
> additional resolutions since Git is quite good at doing that. It is
> also possible that some of them may do a better job than Git, or that
> some of them may want Git to tackle some of the conflict resolution
> (things that require access to the file history such as renames or
> recursive parents), but also want to perform even more sophisticated
> conflict resolution on top of that. Some of those tools are very
> clever and innovation in this space is still happening.

You did not explain why they would want it off.

In your mergetool rant [2] you wrote this point:

 4. All conflicts in the second stanza were automatically resolved. They
    should not be shown to the user.

So it doesn't matter if git does it, or the mergetool does it, you said
the conflicts in the second paragraph can be solved, so they should not
be shown to the user.

If git does it, that's one less thing the mergetool has to do.

Even if the mergetool is smarter than git, in fact, so smart it's run by
a superintelligent AI; it still would resolve the conflict in precisely
the same way as git, and it still should not present that conflict to
the user.

So the end result is the same. Correct?

> This patch *may* benefit the third group or it may make them no longer
> necessary. Speaking as the author of one of them: I see that as a good
> thing.

Yes, at least the core of what they do.

> This patch *may* prevent tools in the second and third groups from
> having all the information they desire to show users without also
> running additional Git commands.

Explain how.

-------------------------------------------------
cat > BASE <<EOF
= tite =

sentence
EOF

cat > LOCAL <<EOF
= title =

sentence
EOF

cat > REMOTE <<EOF
= tite =

sentence.
EOF

git merge-file "$@" --diff3 -p LOCAL BASE REMOTE
-------------------------------------------------

In this example the conflicts are so trivial that git doesn't even
bother to stop the merge; it doesn't even think there's a need to launch
the mergetool.

If instead in REMOTE you have this:

-------------------------------------------------
cat > REMOTE <<EOF
= temporary tite =

sentence.
EOF
-------------------------------------------------

Now there's a *true* conflict, and git requires user-intervention to fix
it, it has placed markers where the user should focus her attention, and
that's where the mergetool should focus the user attention too.

It's very clear where the *true* conflict is:

-------------------------------------------------
<<<<<<< LOCAL
= title =
||||||| BASE
= tite =
=======
= temporary tite =
>>>>>>> REMOTE

sentence.
-------------------------------------------------

If there was no conflict in the first paragraph git wouldn't have
bothered the user with the second paragraph.

Why should the mergetool?

> Because this patch *overwrites* LOCAL and REMOTE any tool that wishes
> to show the state of the file before the merge was started will need
> to use Git to generate a new copy of those files.

Why would they want to do that? Git already has determined there's no
valuable information there.

> Although this is a negative I think benefiting the large number of
> tools in the first group outweighs this negative. Because the second
> and third groups of tools are more sophisticated, I think the authors
> of those tools are better suited to navigating these pros and cons.

I'm sorry, but you still haven't determined that it's a negative, and
why.

> In closing, below are several use-cases for having both a tool-level
> flag and a global flag:
> 
> I, as the author of diffconflicts, *will* want to disable this flag for
> diffconflicts because that tool already does what this flag does *and*
> because that tool makes use of the original versions of LOCAL and
> REMOTE which this patch destroys.

Yes, but the author of diffconflicts is not infallible.

Explain why the *users* of the diffconclits tool would be affected
negatively by not being shown a conflict that git resolved
automatically, and if it were not for other *real* conflicts in the file
wouldn't have bothered to stop the merge.

Furthermore, explain why a user in vimdiff2 wouldn't want to see the
trivial conflict, but a user in diffconflicts would.

> I, as a user of diffconflicts, *may* want to disable this flag because
> in practice I don't actually reference LOCAL and REMOTE very often.

It doesn't change your experience at all.

> Other users may reference LOCAL and REMOTE every time.

Yes, and they would prefer the trivial conflicts that git already
resolved *not there*.

> You yourself said, "Even if I were using diffconflict, I would want
> this option on." Other users may choose differently than you because
> you are also not the "sole arbiter of truth" and because this is
> entirely about personal preference and is decidedly not about
> objective truth.

And that's why it is an *OPTION*.

Didn't I introduce an option for those other users?

> If this patch always benefited everyone then we would make it default
> and not put it behind an opt-in flag.

That's not how git works.

10 years ago doing "git merge" (without arguments) used to fail, then
after I suggested a sensible default, the merge.defaultToUpstream option
was introduced, and turned off by default, even though it was clear 100%
of users would want this.

3 years after the introduction of that flag it was turned on, and
literally not one person complained.

Today you can't find a single person that has
"merge.defaulttoupstream=false" in their configuration, and yet, the
option is still there.

In git even if 100% of users we know would benefit, as long as there
exists one hypothetical user that might not, the option is there.

> I, as a user of diffconflicts, may want to both disable this flag for
> diffconflicts but enable this flag for VS Code and kdiff3.

Why? You still have not explained.

> It is not unusual for people to use more than one mergetool. Some of
> them are better or worse at visualizing different kinds of conflicts.
> Sometimes a conflict is small and straightforward; othertimes a
> conflict is complicated and requires deep knowledge of the history of
> both branches.  If we force this to be a global flag only then users
> will not be able to make different choices for different tools.

They would still not be able to make different choices.

If you read Junio's proposal, if kdiff3 returns false in
automerge_enabled, then the user can *not* turn this on.

> Someone who does use multiple mergetools but only uses tools from group
> one may appreciate a single global flag so s/he doesn't need to set it
> for each tool.

You still have not explained why a user might want different
configuration per tool.

> Someone who is actively developing a new mergetool may want to enable or
> disable this flag for that tool while still keeping the flag enabled or
> disabled for tools that s/he uses for work or school. Someone who is
> comparing and contrasting multiple mergetools for work or school may
> want to selectively enable or disable the flag for one tool or another
> in order to do the comparison. Someone may want the same mergetool
> configured twice, once with this flag and once without, in order to
> contrast the difference.

Yes, I've been doing precisely that without problems.

> An end-user may want to use a mergetool differently than the author
> intended. You said, "This should be a setting in the tool driver, not
> a user-visible setting,"

That was Johannes Sixt, not me.

> and then you said, "Even if I were using diffconflict, I would want
> this option on." But I said, "I, as the author of diffconflicts,
> *will* want to disable this flag." and there's no reason we can't have
> both.

In Junio's proposal if the author of diffconflicts disables the flag, the
user cannot activate it.

But even if the user could, there's no reason not to do X is not a valid
argument in favor of doing X.

You still need a valid reason to have both.

> I can't presume what preference other mergetool authors will have.

As I said; this is not relevant.

Why would a *user* of diffconflict want this off?

You still haven't given a reason.

> We can make some educated guesses and even default the option to true
> for some mergetool wrappers that ship with Git but there's every
> possibility that a user will prefer it a different way or that a
> mergetool author will. And there's every possibility that there will
> be differing opinions between users and authors like there is between
> you and me. But that's ok! Because it's just a configuration option.

At the end of the day it's not opinions that matter, it's facts.


You asked me to read slow and carefully a long explanation, which I did.
Now allow me to ask something of you. Please answer the following question.

Do you have any concrete evidence of a single instance where the user
will be negatively affected by turning on this flag in one mergetool,
but not so in another mergetool?

Cheers.

[1] https://www.reddit.com/r/kde/comments/7y6eds/kompare_is_a_great_difftool_why_doesnt_it_work_as/
[2] https://github.com/whiteinge/diffconflicts/blob/master/_utils/README.md

-- 
Felipe Contreras
