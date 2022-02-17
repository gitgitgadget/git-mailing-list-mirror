Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA8FEC433FE
	for <git@archiver.kernel.org>; Thu, 17 Feb 2022 10:24:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239194AbiBQKY4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Feb 2022 05:24:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239164AbiBQKYn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Feb 2022 05:24:43 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABAD82790A9
        for <git@vger.kernel.org>; Thu, 17 Feb 2022 02:24:24 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id d10so6016096eje.10
        for <git@vger.kernel.org>; Thu, 17 Feb 2022 02:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=RUgGWZCJBmybJsfviT9fdUaG8lEMx64dGWnP4Nku8g8=;
        b=PWN+lSvaOi719k3B6RMwaZTTY/SJVqLWzKHvQfm6myM58907eARdak7IqKlDauRZa3
         5wXFJLu+vNNAosc9l33aldmrWoy5HLrlYyoPcgybH0XZd30BX9FrFiCyuURnCrVH51c6
         86voy9cuRcXeq4dPKEWbh1V+slMTwYZuubodHMvapJevuWcbHCHwztL0EgWV44fSleTC
         u7MCIo6ThPhHXyTHUZhofarBX9UpZHzYE6eykF0rPa2PJ0z0cADG9K0DGJKpuvwkk3c6
         oMvdxTfptAzD5OlWWsMHQBNSKUPn0P8Ax7GYVu6WFlTauQwJ3sVqSkzOvqevB1Uqab+7
         kBSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=RUgGWZCJBmybJsfviT9fdUaG8lEMx64dGWnP4Nku8g8=;
        b=xdHg+7AQigFAQ9VKzktZEx3jyFx5FESHFazWPpn7/pYAIqTqWWff1vTnoJ9iVk3j1Q
         9F6ht1jgEw9QCqfGlpCTlDuFUruKqEcok/wgLte8ZCnSPOJCXG8no+DB4ggdONTKzsGR
         61OhUqj7AJvonXfpX4zVRZh0qdpnvzad+qbEKLptH6S9bwS+p19y+VHWl4LfZOYhkN9N
         HSwY1hGmkiFnEGWtQzUIBrHUTfX2Wqr0D3UxuFs7OcrC3450uOt9iqhzuMjR4rZgIWFG
         nvDTx6HdaCvHlxsRQdUsC6Fenu9CSy+2HMdJm6UyOD5bCqv2JFs980nQGR2Z96OpifGM
         LzRw==
X-Gm-Message-State: AOAM533119XXJ6X5QCR7l1h5o+nxs+xvoBJ2LZgDX4wMk6JQ1aOovZO2
        znAFda7uvxjHaRcOjm09171C1jF9uFxVfA==
X-Google-Smtp-Source: ABdhPJzrXsSjAYUs/NWCYw7Rqtfy+3Wi1L+UnXlDpRbR90LAH3bCTRsEb8R1bsqUbedSjCh0uOpS8w==
X-Received: by 2002:a17:906:d9db:b0:6ce:8bfb:53c9 with SMTP id qk27-20020a170906d9db00b006ce8bfb53c9mr1762657ejb.10.1645093462670;
        Thu, 17 Feb 2022 02:24:22 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id i24sm1003833ejg.40.2022.02.17.02.24.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 02:24:21 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nKdxV-003iOj-5r;
        Thu, 17 Feb 2022 11:24:21 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH 1/2] diff.[ch]: have diff_free() call
 clear_pathspec(opts.pathspec)
Date:   Thu, 17 Feb 2022 11:22:15 +0100
References: <cover-0.2-00000000000-20220216T105250Z-avarab@gmail.com>
 <patch-1.2-1c6c7f0f52f-20220216T105250Z-avarab@gmail.com>
 <CABPp-BHYR8a9YyPGGrUhjMbzPws286FeHjyNcOmgk=8XnwOiVg@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <CABPp-BHYR8a9YyPGGrUhjMbzPws286FeHjyNcOmgk=8XnwOiVg@mail.gmail.com>
Message-ID: <220217.865ypdiyei.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Feb 16 2022, Elijah Newren wrote:

> On Wed, Feb 16, 2022 at 7:34 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>>
>> Have the diff_free() function call clear_pathspec(). Since the
>> diff_flush() function calls this all its callers can be simplified to
>> rely on it instead.
>>
>> When I added the diff_free() function in e900d494dcf (diff: add an API
>> for deferred freeing, 2021-02-11) I simply missed this, or wasn't
>> interested in it. Let's consolidate this now. This means that any
>> future callers (and I've got revision.c in mind) that embed a "struct
>> diff_options" can simply call diff_free() instead of needing know that
>> it has an embedded pathspec.
>>
>> This does fix a bunch of leaks, but I can't mark any test here as
>> passing under the SANITIZE=3Dleak testing mode because in
>> 886e1084d78 (builtin/: add UNLEAKs, 2017-10-01) an UNLEAK(rev) was
>> added, which plasters over the memory
>> leak. E.g. "t4011-diff-symlink.sh" would report fewer leaks with this
>> fix, but because of the UNLEAK() reports none.
>>
>> I'll eventually loop around to removing that UNLEAK(rev) annotation as
>> I'll fix deeper issues with the revisions API leaking. This is one
>> small step on the way there, a new freeing function in revisions.c
>> will want to call this diff_free().
>>
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> ---
>>  add-interactive.c | 6 +++---
>>  blame.c           | 3 ---
>>  builtin/reset.c   | 1 -
>>  diff.c            | 1 +
>>  notes-merge.c     | 2 --
>>  5 files changed, 4 insertions(+), 9 deletions(-)
>>
>> diff --git a/add-interactive.c b/add-interactive.c
>> index 6498ae196f1..e1ab39cce30 100644
>> --- a/add-interactive.c
>> +++ b/add-interactive.c
>> @@ -797,14 +797,14 @@ static int run_revert(struct add_i_state *s, const=
 struct pathspec *ps,
>>         diffopt.flags.override_submodule_config =3D 1;
>>         diffopt.repo =3D s->r;
>>
>> -       if (do_diff_cache(&oid, &diffopt))
>> +       if (do_diff_cache(&oid, &diffopt)) {
>> +               diff_free(&diffopt);
>>                 res =3D -1;
>> -       else {
>> +       } else {
>>                 diffcore_std(&diffopt);
>>                 diff_flush(&diffopt);
>>         }
>>         free(paths);
>> -       clear_pathspec(&diffopt.pathspec);
>>
>>         if (!res && write_locked_index(s->r->index, &index_lock,
>>                                        COMMIT_LOCK) < 0)
>> diff --git a/blame.c b/blame.c
>> index 206c295660f..401990726e7 100644
>> --- a/blame.c
>> +++ b/blame.c
>> @@ -1403,7 +1403,6 @@ static struct blame_origin *find_origin(struct rep=
ository *r,
>>                 }
>>         }
>>         diff_flush(&diff_opts);
>> -       clear_pathspec(&diff_opts.pathspec);
>>         return porigin;
>>  }
>>
>> @@ -1447,7 +1446,6 @@ static struct blame_origin *find_rename(struct rep=
ository *r,
>>                 }
>>         }
>>         diff_flush(&diff_opts);
>> -       clear_pathspec(&diff_opts.pathspec);
>>         return porigin;
>>  }
>>
>> @@ -2328,7 +2326,6 @@ static void find_copy_in_parent(struct blame_score=
board *sb,
>>         } while (unblamed);
>>         target->suspects =3D reverse_blame(leftover, NULL);
>>         diff_flush(&diff_opts);
>> -       clear_pathspec(&diff_opts.pathspec);
>>  }
>>
>>  /*
>> diff --git a/builtin/reset.c b/builtin/reset.c
>> index b97745ee94e..24968dd6282 100644
>> --- a/builtin/reset.c
>> +++ b/builtin/reset.c
>> @@ -274,7 +274,6 @@ static int read_from_tree(const struct pathspec *pat=
hspec,
>>                 return 1;
>>         diffcore_std(&opt);
>>         diff_flush(&opt);
>> -       clear_pathspec(&opt.pathspec);
>>
>>         return 0;
>>  }
>> diff --git a/diff.c b/diff.c
>> index c862771a589..0aef3db6e10 100644
>> --- a/diff.c
>> +++ b/diff.c
>> @@ -6345,6 +6345,7 @@ void diff_free(struct diff_options *options)
>>
>>         diff_free_file(options);
>>         diff_free_ignore_regex(options);
>> +       clear_pathspec(&options->pathspec);
>>  }
>>
>>  void diff_flush(struct diff_options *options)
>> diff --git a/notes-merge.c b/notes-merge.c
>> index b4a3a903e86..7ba40cfb080 100644
>> --- a/notes-merge.c
>> +++ b/notes-merge.c
>> @@ -175,7 +175,6 @@ static struct notes_merge_pair *diff_tree_remote(str=
uct notes_merge_options *o,
>>                        oid_to_hex(&mp->remote));
>>         }
>>         diff_flush(&opt);
>> -       clear_pathspec(&opt.pathspec);
>>
>>         *num_changes =3D len;
>>         return changes;
>> @@ -261,7 +260,6 @@ static void diff_tree_local(struct notes_merge_optio=
ns *o,
>>                        oid_to_hex(&mp->local));
>>         }
>>         diff_flush(&opt);
>> -       clear_pathspec(&opt.pathspec);
>>  }
>>
>>  static void check_notes_merge_worktree(struct notes_merge_options *o)
>> --
>> 2.35.1.1028.g2d2d4be19de
>
> I have occasionally found it surprising that we have places where
> callers are responsible for free'ing a single piece of some struct
> despite the fact that we have a function for free'ing memory
> associated with that struct.  Thanks for getting rid of another one of
> these.

Yes, much of the later memory leak effort is focused on consolidating
those, there's a lot of it around "struct rev_info", e.g. callers
reaching into it to free a pathspec, the "struct object_array *pending"
etc.

There's some gray area there, particularly when the caller originally
allocates the resource and "hands it off" to the struct, but even in
those cases they should probably be freeing their own original variable,
not referring to it by reaching into a struct they handed it to.

That would amount to the exact same thing for the machine (same
pointer), but the former is surely more readable to the human reader.
