Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9934CC28CB0
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 02:22:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8017961268
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 02:22:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348308AbhIUCXI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Sep 2021 22:23:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241567AbhIUCCL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Sep 2021 22:02:11 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 964A5C12D656
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 11:11:35 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id g16so32249367wrb.3
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 11:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xMBHju9ouiSJFyHB79G1kEaJsipX1sfMcASV7m/f470=;
        b=Gooa4qmlATf0HUOz75AUD3Ij+MfHayvkFWHJdS04DyPVLXOCntdlwsAv92m7A2mOWy
         Ay642zbBzPb4wyilyDPBupR3JBZkdarYGJChVCnjuEDY5gIXf1SYDGMAyfrP4nOYXIJz
         0QetG5z1sqJ/SZWH/9EhKZgEcQlKwDjQV8xqZmesMKoX5ZdVWn1PPk5tCpDdkavo7hcr
         20DDiFKxjSJhFQN3pvCszekZxKx0/T55DLCr/gezE/BMK2lxL5xDoX2QyYViZyimfdi3
         M23J+Ko3B1AqRqwO4m1cSL7VtBuYp5oNxAmaDA5U1F1zlTadoqh7Ni6iT6M+IK5RWzqy
         7RoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=xMBHju9ouiSJFyHB79G1kEaJsipX1sfMcASV7m/f470=;
        b=MpTTPT6POMz50NxU0K581h90UOEWne0oCHy0GV/fn/MjXosuxMgLkVueIisr/G+vwd
         B9T6JtyjMBcUMudTHcNE7egz6vkp12qIxNifWvPTTtifFGS0zhtOp8UWuv8NljO5oH1V
         xu1iRYstCLayjX7fgi/2f7S/3EffSBqqXxGARJvGovjoXWmYR+H3ZVr2ib0BH9gFJq92
         KtZi7G4Poaia+Y2rHL2SFusNcWQH5Zg9RydXJToC6pTH1kXmUsL8LCGPsyrCw2BVLugY
         BOZqBqQ4TcPe93XTe1YytDSTua73xuw4dno7VvbbVzoB8twcBFaZeM6juM6zk3inBBmT
         u40A==
X-Gm-Message-State: AOAM533hZyuP1Vu/a8mRtiT2g75tZXfSpHBnzuIxhXupbjvd80e7DjIL
        71D0OsSNDxrpHHOhUVKGWz0V/UlQxmo=
X-Google-Smtp-Source: ABdhPJxzTnXyTURBSx13M7sOH2P14Q8jbztK+4PWH3a1pDF7WZ3g+edOhDJWcVeYgo9bOfFVcORYwg==
X-Received: by 2002:a7b:ce06:: with SMTP id m6mr376231wmc.85.1632161494134;
        Mon, 20 Sep 2021 11:11:34 -0700 (PDT)
Received: from [192.168.1.201] (178.2.7.51.dyn.plus.net. [51.7.2.178])
        by smtp.googlemail.com with ESMTPSA id v191sm227958wme.36.2021.09.20.11.11.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Sep 2021 11:11:33 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 2/6] Split unpack_trees 'reset' flag into two for
 untracked handling
To:     Elijah Newren <newren@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Fedor Biryukov <fedor.birjukov@gmail.com>
References: <pull.1036.git.1632006923.gitgitgadget@gmail.com>
 <45bd05a945f034d03555f04a1ba85835482dc591.1632006923.git.gitgitgadget@gmail.com>
 <acef3628-9542-d777-2534-577de9707e15@gmail.com>
 <CABPp-BGnWeFiJ11x8j1J+yjgVB9r858S47y40h8cFQYF4TR1HA@mail.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <a3433f37-4a22-faa1-16a7-cbc01a24af6e@gmail.com>
Date:   Mon, 20 Sep 2021 19:11:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BGnWeFiJ11x8j1J+yjgVB9r858S47y40h8cFQYF4TR1HA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 20/09/2021 17:05, Elijah Newren wrote:
> On Mon, Sep 20, 2021 at 3:19 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>>
>> On 19/09/2021 00:15, Elijah Newren via GitGitGadget wrote:
>>> From: Elijah Newren <newren@gmail.com>
>>>
>>> Traditionally, unpack_trees_options->reset was used to signal that it
>>> was okay to delete any untracked files in the way.  This was used by
>>> `git read-tree --reset`, but then started appearing in other places as
>>> well.  However, many of the other uses should not be deleting untracked
>>> files in the way.  Split this into two separate fields:
>>>      reset_nuke_untracked
>>>      reset_keep_untracked
>>> and, since many code paths in unpack_trees need to be followed for both
>>> of these flags, introduce a third one for convenience:
>>>      reset_either
>>> which is simply an or-ing of the other two.
>>
>> See [1] for an alternative approach that used an enum instead of adding
>> mutually exclusive flags.
> 
> Oh, interesting.  Any reason you didn't pursue that old series further?

Mainly lack of time/distracted by other things. I was also not that 
confident about modifying the unpack_trees() code. Duy was very helpful 
but then moved on quite soon after I posted that series I think and 
there didn't seem to be much interest from others.

>>> Modify existing callers so that
>>>      read-tree --reset
>>
>> it would be nice if read-tree callers could choose whether they want to
>> remove untracked files or not - that could always be added later. This
>> patch changes the behavior of 'git read-tree -m -u' (and other commands)
>> so that they will overwrite ignored files - I'm in favor of that change
>> but it would be good to spell out the change in the commit message.
> 
> Those commands made no distinction between untracked and ignored files
> previously, and overwrote all of them.

Are you sure, I thought 'read-tree -m -u' unlike 'read-tree --reset -u' 
refused to overwrite untracked and ignored files currently.

>  This patch changes those
> commands so that they stop overwriting untracked files, unless those
> files are ignored.  So, there's no change in behavior for ignored
> files, only for non-ignored untracked files.
> 
> Your suggestion to point out the behavior relative to ignored files in
> the commit message, though, is probably a good idea.  I should mention
> that ignored files will continue to be removed by these commands.
> 
>>>      reset --hard
>>>      checkout --force
>>
>> I often use checkout --force to clear unwanted changes when I'm
>> switching branches, I'd prefer it if it did not remove untracked files.
> 
> I originally started down that path to see what it looked like, but
> Junio weighed in and explicitly called out checkout --force as being a
> command that should remove untracked files in the way.  See
> https://lore.kernel.org/git/xmqqr1e2ejs9.fsf@gitster.g/.  Seems you
> also felt that way previously, at
> https://lore.kernel.org/git/d4c36a24-b40c-a6ca-7a05-572ab93a0101@gmail.com/
> -- any reason for your change of opinion?

I've no recollection of writing that email! When I was writing today I 
thought that 'checkout -f' and 'switch --discard-changes' behaved the 
same way but it appears from that other message that they do not so 
maybe it is OK for 'checkout -f' to nuke everything if there is a safe 
alternative available in the form of 'switch --discard-changes'

>>> continue using reset_nuke_untracked, but so that other callers,
>>> including
>>>      am
>>>      checkout without --force
>>>      stash  (though currently dead code; reset always had a value of 0)
>>>      numerous callers from rebase/sequencer to reset_head()
>>> will use the new reset_keep_untracked field.
>>
>> This is great. In the discussion around [1] there is a mention of 'git
>> checkout <pathspec>' which also overwrites untracked files. It does not
>> use unpack_trees() so is arguably outside the scope of what you're doing
>> here but it might be worth mentioning.
> 
> Oh, that's interesting.  Yeah, that's worth mentioning and perhaps digging into.

It'd be fantastic to fix that if you have the time and inclination to 
dig into it.

Best Wishes

Phillip

>>> [...]
>>> diff --git a/builtin/read-tree.c b/builtin/read-tree.c
>>> index 485e7b04794..8b94e1aa261 100644
>>> --- a/builtin/read-tree.c
>>> +++ b/builtin/read-tree.c
>>> @@ -133,7 +133,7 @@ int cmd_read_tree(int argc, const char **argv, const char *cmd_prefix)
>>>                         N_("3-way merge if no file level merging required")),
>>>                OPT_BOOL(0, "aggressive", &opts.aggressive,
>>>                         N_("3-way merge in presence of adds and removes")),
>>> -             OPT_BOOL(0, "reset", &opts.reset,
>>> +             OPT_BOOL(0, "reset", &opts.reset_keep_untracked,
>>>                         N_("same as -m, but discard unmerged entries")),
>>>                { OPTION_STRING, 0, "prefix", &opts.prefix, N_("<subdirectory>/"),
>>>                  N_("read the tree into the index under <subdirectory>/"),
>>> @@ -162,6 +162,11 @@ int cmd_read_tree(int argc, const char **argv, const char *cmd_prefix)
>>>        opts.head_idx = -1;
>>>        opts.src_index = &the_index;
>>>        opts.dst_index = &the_index;
>>> +     if (opts.reset_keep_untracked) {
>>> +             opts.dir = xcalloc(1, sizeof(*opts.dir));
>>> +             opts.dir->flags |= DIR_SHOW_IGNORED;
>>> +             setup_standard_excludes(opts.dir);
>>> +     }
>>
>> Does this clobber any excludes added by --exclude-per-directory?
> 
> Oh, um...I've basically implemented a --exclude-standard and assumed
> it was passed, ignoring whatever setting of opts.dir was already set
> up by exclude-per-directory.  Oops.
> 
>>> diff --git a/builtin/reset.c b/builtin/reset.c
>>> index 43e855cb887..ba39c4882a6 100644
>>> --- a/builtin/reset.c
>>> +++ b/builtin/reset.c
>>> @@ -10,6 +10,7 @@
>>>    #define USE_THE_INDEX_COMPATIBILITY_MACROS
>>>    #include "builtin.h"
>>>    #include "config.h"
>>> +#include "dir.h"
>>>    #include "lockfile.h"
>>>    #include "tag.h"
>>>    #include "object.h"
>>> @@ -70,9 +71,19 @@ static int reset_index(const char *ref, const struct object_id *oid, int reset_t
>>>                break;
>>>        case HARD:
>>>                opts.update = 1;
>>> -             /* fallthrough */
>>> +             opts.reset_nuke_untracked = 1;
>>> +             break;
>>> +     case MIXED:
>>> +             opts.reset_keep_untracked = 1; /* but opts.update=0, so untracked left alone */
>>> +             break;
>>>        default:
>>> -             opts.reset = 1;
>>> +             BUG("invalid reset_type passed to reset_index");
>>
>> There is no case SOFT: but in that case we don't call reset_index() so
>> we're OK.
>>
>>> diff --git a/reset.c b/reset.c
>>> index 79310ae071b..0880c76aef9 100644
>>> --- a/reset.c
>>> +++ b/reset.c
>>> @@ -1,5 +1,6 @@
>>>    #include "git-compat-util.h"
>>>    #include "cache-tree.h"
>>> +#include "dir.h"
>>>    #include "lockfile.h"
>>>    #include "refs.h"
>>>    #include "reset.h"
>>> @@ -57,8 +58,12 @@ int reset_head(struct repository *r, struct object_id *oid, const char *action,
>>>        unpack_tree_opts.update = 1;
>>>        unpack_tree_opts.merge = 1;
>>>        init_checkout_metadata(&unpack_tree_opts.meta, switch_to_branch, oid, NULL);
>>> -     if (!detach_head)
>>> -             unpack_tree_opts.reset = 1;
>>
>> Unrelated to this patch but this looks dodgy to me. For 'git rebase
>> <upstream> <branch>' where <branch> is ahead of <upstream> we skip the
>> rebase and use reset_head() to checkout <branch> without 'detach_head'
>> set. I think this should be checking 'reset_hard' instead of 'detach_head'
>>
>>> diff --git a/unpack-trees.c b/unpack-trees.c
>>> index 5786645f315..d952eebe96a 100644
>>> --- a/unpack-trees.c
>>> +++ b/unpack-trees.c
>>> @@ -301,7 +301,7 @@ static int check_submodule_move_head(const struct cache_entry *ce,
>>>        if (!sub)
>>>                return 0;
>>>
>>> -     if (o->reset)
>>> +     if (o->reset_nuke_untracked)
>>>                flags |= SUBMODULE_MOVE_HEAD_FORCE;
>>>
>>>        if (submodule_move_head(ce->name, old_id, new_id, flags))
>>> @@ -1696,6 +1696,13 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
>>>        if (len > MAX_UNPACK_TREES)
>>>                die("unpack_trees takes at most %d trees", MAX_UNPACK_TREES);
>>>
>>> +     if (o->reset_nuke_untracked && o->reset_keep_untracked)
>>> +             BUG("reset_nuke_untracked and reset_keep_untracked are incompatible");
>>> +
>>> +     o->reset_either = 0;
>>> +     if (o->reset_nuke_untracked || o->reset_keep_untracked)
>>> +             o->reset_either = 1;
>>
>> <bikeshed>
>> o->reset_either = o->reset_nuke_untracked | o->reset_keep_untracked
>> </bikeshed>
> 
> Goes away entirely if we adopt your enum suggestion.
> 
>>> diff --git a/unpack-trees.h b/unpack-trees.h
>>> index 2d88b19dca7..c419bf8b1f9 100644
>>> --- a/unpack-trees.h
>>> +++ b/unpack-trees.h
>>> @@ -46,7 +46,9 @@ void setup_unpack_trees_porcelain(struct unpack_trees_options *opts,
>>>    void clear_unpack_trees_porcelain(struct unpack_trees_options *opts);
>>>
>>>    struct unpack_trees_options {
>>> -     unsigned int reset,
>>> +     unsigned int reset_nuke_untracked,
>>> +                  reset_keep_untracked,
>>> +                  reset_either, /* internal use only */
>>
>> I think I prefer the enum approach in [1] but I'm biased and I'm not
>> sure it's worth getting excited about. Thanks for working on this it
>> will be great to have git stop overwriting untracked files so often.
> 
> I think the enum approach makes sense; I'll try it out.
> 

