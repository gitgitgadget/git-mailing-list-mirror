Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B86D3C54EBC
	for <git@archiver.kernel.org>; Thu, 12 Jan 2023 16:42:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232192AbjALQmO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Jan 2023 11:42:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240503AbjALQkL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2023 11:40:11 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB64FE79
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 08:34:57 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id u9so46165637ejo.0
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 08:34:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6nv6MNJ0v1MWehPp/vAhsMPzpcoRzFwrqf10h7siXJc=;
        b=GX2HEt/TMIywhtRiqRn+X5ltUVEZWWVIiOdGNzed8ikKyrKIVtah5DvbF6B/DddcaV
         pP6b3VIr6t89KSmQAoHqToOuhGSPe6Hb5fjxoSgT4DSRCy/fXvedzBLjt4cqiqcmXjp2
         K0LH5EQfXwBZt7ufvqv+47f6RD1o47kx/C3HC1zO55nTb3f7OmyjvkwgrlFB1DbvuIRa
         6/nZ8cW3ZsQFRmgRJ3P5ViFNJ9YCd44q1+7KiHOhqVFJRef4m0PJ3USTjRVxh5x61huL
         tY2/cg2wgekHRSLm7ZIb1eyPlvcjwJbq3eUEGdmHE8yuhP+yRjwnXDBvvwSToRlHKHx7
         0/aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6nv6MNJ0v1MWehPp/vAhsMPzpcoRzFwrqf10h7siXJc=;
        b=I3dTAnr7oNbpRzEMekecFBiwt0ug+cIv67dCY6uL0/K2VdqALyHwRJpko5BgzpAeA3
         nQ7EKUjTYGuQDZfIJSy6Y0N+TuMOga98qE8UKWUPCOX/4YYZt6pI5GAtgrQ2mb0GYh03
         my8xaFCqfgFXUBpQ61AZuiyk6D0Ic14WJcJft82SVrE1wW3Ps4CdEsgD9iCtCw2g3A+v
         KGT14TBTQYCm3pC6gKQ9h6K4ZjsjhaLznL3kIjlrGxQd54gm4+wooKaZofvBcUwey06y
         vJ3tWpcUpsyeottBEZ3XrxkaIg/ITQL9ZMRVoZprEcWYea8yCfwLUK0M3CDseKIrV0eK
         dTXw==
X-Gm-Message-State: AFqh2koFqj4Zxa14vmcp125GcXQx2xG579nASoSVrG29sFEwK17F6nSf
        8oweqXodW/QUJ3aTPTI4d5Q=
X-Google-Smtp-Source: AMrXdXs3C2f0rLCViMisokb9RjqQknvRNQG0D0ua1bvFxgKRoDvpVztUwZ9tMHaxsJ3VNOQB+j7Xyg==
X-Received: by 2002:a17:906:9f0a:b0:7ad:88f8:7663 with SMTP id fy10-20020a1709069f0a00b007ad88f87663mr87615534ejc.43.1673541296280;
        Thu, 12 Jan 2023 08:34:56 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id 21-20020a170906301500b007c0985aa6b0sm7656113ejz.191.2023.01.12.08.34.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 08:34:55 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pG0XX-000L0J-1H;
        Thu, 12 Jan 2023 17:34:55 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     phillip.wood@dunelm.org.uk
Cc:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Olliver Schinagl <oliver@schinagl.nl>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] rebase -i: allow a comment after a "break" command
Date:   Thu, 12 Jan 2023 17:28:55 +0100
References: <pull.1460.git.1673519809510.gitgitgadget@gmail.com>
 <230112.86pmbk0vvj.gmgdl@evledraar.gmail.com>
 <4e2bb2da-0c42-ae9c-2a05-9b23db55c2ce@dunelm.org.uk>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <4e2bb2da-0c42-ae9c-2a05-9b23db55c2ce@dunelm.org.uk>
Message-ID: <230112.86r0vzzp74.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jan 12 2023, Phillip Wood wrote:

> On 12/01/2023 12:25, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> On Thu, Jan 12 2023, Phillip Wood via GitGitGadget wrote:
>>=20
>>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
>>> index f9675bd24e6..511ace43db0 100644
>>> --- a/Documentation/git-rebase.txt
>>> +++ b/Documentation/git-rebase.txt
>>> @@ -869,7 +869,9 @@ the files and/or the commit message, amend the comm=
it, and continue
>>>   rebasing.
>>>     To interrupt the rebase (just like an "edit" command would do,
>>> but without
>>> -cherry-picking any commit first), use the "break" command.
>>> +cherry-picking any commit first), use the "break" command. A "break"
>>> +command may be followed by a comment beginning with `#` followed by a
>>> +space.
>> You're missing a corresponding edit here to the help string in
>> append_todo_help(), as you note you're making "break" support what
>> "merge" does, and that help string documents that "merge" accepts a
>> comment, after this we don't do that for "break", but should one way or
>> the other (see below).
>
> Thanks, Andrei has already mentioned that, I'll update the todo help
> when I re-roll
>> I like this direction, but I don't see why we need to continue this
>> special-snowflakeness of only allowing specific commands to accept these
>> #-comments.
>> Why not just have them all support it? It started with "merge",
>> which as
>> 4c68e7ddb59 (sequencer: introduce the `merge` command, 2018-04-25) note
>> can be used for:
>> 	merge -C baaabaaa abc # Merge the branch 'abc' into master
>> As Olliver points out we should probably support "#" without the
>> following " ", which seems to be an accident of history &
>> over-strictness.
>
> It's not an accident, labels and commit names can begin with '#' so we
> need to support
>
> 	merge #parent1 #parent2

Ah, I would have told you that '#' was forbidden in refnames, but as
some trivial experimentation shows I was wrong about that. So yes, we
need the "# ".

> For "break" we could just not require '#' at all as we do for "reset
> <label>" where anything following the label is ignored. That would
> mean we couldn't add an argument to break in the future though (I'm
> not sure that is really a problem in practice). If we're going to
> require '#' then we may as well following the existing rules.

I'd think we'd want to parse past the "break" to find a "#", and error
out unknown stuff still, exactly to support future extensions.

I.e. we'd like to close the door on "break# foo", "break # foo" etc, but
not "break foo", unless I'm misunderstanding you here...

>> But in this commit you extend it to "break", but we're going out of or
>> way to e.g. extend this to "noop".
>
> I'm struggling to see why "noop" would need a comment - it only exists
> to avoid an empty todo list and is not meant for general use (it's not
> in the help added by append_todo_help() for this reason)

I'm struggling to see why "break" needs a comment, why not just add it
to the preceding line or something? But it seems some users like it :)

So at that point, it seems easier to both explain & implement something
that just consistently supports comment syntax, rather than overly
special-casing it.

> For "pick", "edit", "reword", "fixup" & "squash" we don't need a
> comment mechanism as we ignore everything after the commit name. For
> "reset" we ignore everything after the label. For "label" we could add
> support for comments but I'm not sure it is that useful and we'd need
> to be careful not to interpret a bad label name as a label + comment.

I think there's been a couple of request to have changing the "argument"
actually reword the $subject (I'm pretty such for "reword" that got as
far as a patch, but I may be misrecalling).

Of course that's an argument against what I was suggesting of making the
comment support a bit more general (although we could probably still
support it for "noop" or whatever).

>> So I'd expect that just like the first for-loop in "parse_insn_line()"
>> we'd check if strchr(bol, '#') returns non-NULL, and if so set eol to
>> that result.
>
> That would break labels and commit names that contain a '#'
>
> If we think we're never going to want "break" to take an argument then
> maybe we should just make it ignore the rest of the line like "reset
> <label>".

It's unfortunate that we do that, I think it's almost always better to
just error out rather that silently ignore data, except for some
explicit exceptions (such as comment syntax).
