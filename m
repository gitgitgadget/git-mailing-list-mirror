Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 548FD1FF76
	for <e@80x24.org>; Mon, 26 Dec 2016 20:32:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752683AbcLZUck (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Dec 2016 15:32:40 -0500
Received: from mail-qk0-f180.google.com ([209.85.220.180]:33011 "EHLO
        mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751028AbcLZUcj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Dec 2016 15:32:39 -0500
Received: by mail-qk0-f180.google.com with SMTP id t184so205026796qkd.0
        for <git@vger.kernel.org>; Mon, 26 Dec 2016 12:32:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=5IoB4pu0w9H/BnSTGzCPqmHvc6TcW3KW6j3ILhNQ/cg=;
        b=k/BQnH+PwKff1BPhHOOdH1y5vchlb0Hlj5C0PnsmfWGVgo+/U+FVTEnwoAvfP6HjzC
         VOZqKHuexi33OZOH6LRnkyvGWdGvO9w4Pk4W3AMARhTF84RYKclJ19liq+XN2tpIIUM6
         TFAOZLEaAl/fKUvBxZDkvcql9v1SsnKKNOuDe+Ovl9Wl8A4sAe/x+5YTSzK/tLAShKw/
         SuNwM/JSgiuu9Sr2UCaNQHnQZM2VYuvNOsqBnUbGqrwzLZjtMbPEFM1ybw269/F5zW1P
         sJMiPUAOr8ixJQIqA5Xa4NIg5Xuyh2QXb8kqXn4AKJGWzpqlx1cD7rXw+DPetSihQ4Pg
         tpGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=5IoB4pu0w9H/BnSTGzCPqmHvc6TcW3KW6j3ILhNQ/cg=;
        b=oRSSXqlSaZYS7r81B51zTJvoPrKe9bpIP48baGYCCSWZD0D2LJBEQo1HUrFPP9URGI
         EOpqW3Mmtr6bcsmruUVHLQaXVEEaK0jIFpvacur/qPerfEKmoV3xK0eC56dh+3jwZiXF
         WtoGTWR64tYCizXmw0US0KTC6IfSAJoVcpu6mzAF8YvyVXsTJqMAkZIwdxeX0g/dQwi/
         ay1qaRjn8eRMG3vabqbVVZz6BhvoEBwPPu2fEbVqeRL/HRUGekAcDem7lvfQzzo4MSEj
         3ZbA1ucb6ixz+JM3rqAVXhydE2WnGTQjp9DAKgwuQhkmQcpsqF4cILMHVKFsr0YMBDYi
         tFAQ==
X-Gm-Message-State: AIkVDXLQs0lO/EkAtWDr8MXg5ioLJadKxshFKx3oa7fu+QzcimyQCVG1mihLdmrCRaJQKNEW9tvypK3xvWL6hUpx
X-Received: by 10.55.197.28 with SMTP id p28mr27679495qki.255.1482784352899;
 Mon, 26 Dec 2016 12:32:32 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.146.7 with HTTP; Mon, 26 Dec 2016 12:32:32 -0800 (PST)
In-Reply-To: <20161225022904.v2mixrnbitvlviuu@glandium.org>
References: <20161225022904.v2mixrnbitvlviuu@glandium.org>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 26 Dec 2016 12:32:32 -0800
Message-ID: <CAGZ79kYAZ=zf8+xLDu1s4KUBhoDWbBdcO8ua4aWhfzieO4UVhA@mail.gmail.com>
Subject: Re: Corner case involving null sha1, alternates, cache misses, and
 submodule config API
To:     Mike Hommey <mh@glandium.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Brandon Williams <bmwill@google.com>
Cc:     Heiko Voigt <hvoigt@hvoigt.net>,
        Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 24, 2016 at 6:29 PM, Mike Hommey <mh@glandium.org> wrote:
> Hi,
>
> As you might be aware, I'm working on a mercurial remote helper for git.
> The way it stores metadata for mercurial manifests abuses "commit"
> references in trees, which are normally used for submodules.
>
> Some operations in the helper use git diff-tree on those trees to find
> files faster than just using ls-tree on every commit would.
>
> Anyways, long story short, it turns out that a combination of
> everything mentioned in the subject of this email causes running git
> diff-tree -r --stdin with a list of 300k+ pairs of commits to take 10
> minutes, when (after investigation) adding --ignore-submodules=dirty
> made it take 1 minute instead, for the exact same 3GB output.
>
> It turns out, this all starts in is_submodule_ignored(), which contains:
>
>         if (!DIFF_OPT_TST(options, OVERRIDE_SUBMODULE_CONFIG))
>                 set_diffopt_flags_from_submodule_config(options, path);
>
> And set_diffopt_flags_from_submodule_config calls:
>
>         submodule_from_path(null_sha1, path);
>
> And because there is no actual submodule involved, at some point that
> null_sha1 ends up in the call to read_sha1_file from
> submodule-config.c's config_from, which then proceeds to try to open the
> null sha1 as a loose object in every alternate, doing multiple system
> calls in each directory for something that is bound to fail. And to add
> pain to injury, it repeats that for each and every line of input to git
> diff-tree because the object cache doesn't care about storing negatives
> (which makes perfect sense for most cases).
>
> Even worse, when read_object returns NULL because the object doesn't
> exist, read_sha1_file_extended calls has_loose_object which does
> another set of system calls.
>
> Now, while I realize my use case is very atypical, and that I should
> just use --ignore-submodule=dirty, the fact that using the null sha1 can
> trigger such behavior strikes me as a footgun that would be better
> avoided. Especially when you factor the fact that
> read_sha1_file_extended calls lookup_replace_object_extended, which
> suggests one might interfere by creating a replace object for the null
> sha1. (BTW, it's not entirely clear to me, in the context of actual
> submodules, what the various --ignore-submodule options are supposed to
> mean for trees that are not the current HEAD ; also, the manual page say
> "all" is the default, but that doesn't appear to be true)

I think at this high level we should start optimizing submodules, i.e.
not HEAD / working tree -> select less aggressive submodule config.

>
> From a cursory look at the output of `git grep \\bnull_sha1` it doesn't
> look like the null sha1 is used anywhere else in a similar fashion where
> it can be attempted to be read as an object. So, one could consider this
> is something the submodule config code should handle on its own by
> treating the null_sha1 argument to submodule_from_path (really
> config_from) specially. After all, gitmodule_sha1_from_commit already
> avoids a get_sha1() call when it's given the null sha1.
>
> OTOH, it seems submodule_from_path and submodule_from_name, the only two
> public functions that end up in config_from(), are *always* called with
> either the null sha1 or a literal null pointer.

When Heiko introduced the submodule config, the consensus
was to have a flexible API to lookup submodule configuration.
The sha1 argument defines where to lookup the submodule
config (e.g. you could have moved a submodule such that the
submodule_from_path returns a different submodule for HEAD^
than HEAD.

The null_sha1 is used for current working tree configuration, i.e.
load .gitmodules and then overload with .git/config.

origin/bw/grep-submodules changes the behavior as it preloads the
null_sha1 to be an actual commit-ish (HEAD^').

I may make use of it in the checkout --recurse-submodules series.

> The *only* calls to
> these functions that doesn't involve a null sha1 or a null pointer is
> from test code. So all in all, I'm not entirely sure what this sha1
> argument is all about in the first place.

See Documentation/technical/api-submodule-config.txt (IIRC)
in next(?).

>
> However, an argument could be made that null_sha1 should be treated
> specially at a lower level (read_sha1_file, I guess).
>
> What would be sensible to do here?

As said above, the nul_sha1 is (ab-)used to mean
"use the preloaded config" which as of now is .git/config on top
of .gitmodules in the working tree.

I would assume we want another earlier and cheaper switch
for all these functions. This may also come in handy for the
git-series, that uses gitlinks as non-submodules.

Something like

    int treat_gitlinks_as_submodule()

which can be configured to be "auto"[1]  and then
"on", "off" that can be set for tools such as mercurial
remote helper or git-series.

[1] the default that
requires some slightly more expensive guess work, e.g.
the existence of the .gitmodules file. c.f.
https://github.com/git/git/commit/1863e05af5be73d9f7b9a1d22a33ca9849726623
static void preset_submodule_default(void)
would be a starting point to cheaply estimate
if gitlinks are submodules.



>
> Mike
