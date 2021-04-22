Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70F45C433B4
	for <git@archiver.kernel.org>; Thu, 22 Apr 2021 08:41:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3516C6144D
	for <git@archiver.kernel.org>; Thu, 22 Apr 2021 08:41:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235249AbhDVIlk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Apr 2021 04:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbhDVIli (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Apr 2021 04:41:38 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 434C9C06174A
        for <git@vger.kernel.org>; Thu, 22 Apr 2021 01:41:04 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id i3so26752763edt.1
        for <git@vger.kernel.org>; Thu, 22 Apr 2021 01:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=BAJ7QaHg92nRrSmaMLkdinBsxJXGCpct8OIqRTgm54Q=;
        b=uceZ0BZ4uAvyG8mIYmPnSBLkn+UnCB5Uws4VdAnrn5i4R90vbLCpf0ECoDGmAqzrZ9
         mWDbLnNVW3RlBnp93G5iGKex8UJMEewovR3vKoUzLnFPfNtzTS8e6uzTLmF4k7GevJoq
         GKIrwUzJRfcWk9A51OiLdkIc6+kgewUScFwVOqY4vTO5SOX3BVHYPYjluG5JKhVoVqpD
         rWYVvVkqeO91z4B7wwOfxqmNTMEKbDOi9ellRJyX+Xih4Q+9JmIvTc7cTHS8vYhIUfjU
         hYcktVyTR6YFkS8bXaLMu5/WScCAF3SC/RDeXf11TdzYEtaXjzXVzse88mMsS04SRlwV
         5gaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=BAJ7QaHg92nRrSmaMLkdinBsxJXGCpct8OIqRTgm54Q=;
        b=jUQOt+IN+k5yUqNEAixAyOdxUT7OZ2A4cfpKNih4JcOXyXQkg59Qe8tXlefJlTG/9O
         FDnGSO5r71DTZKaHOCkGdSPTFvO1uX5fgnaQXp0KxQ9m8765oSSxRjBFOLDWFSiu+GH3
         olZbUuqK4NG2ghOdtev3I1tQk3hE/9C3GUY8eniubbyYNpdxi68JDAYy5H1JqKuUmY1W
         UNTlRBJ6cW5UbboM4tkWT2z/oRpx4A4KKdf1aDtu0XYAlGs3kajjo+8b/peO1JFm/7dC
         iboLNh9uc2k0k4LCuqN4S9rC08gtKBm/TtWheuZ503lh6BY4Njuy83RZLh/ec7HduZe5
         VdOw==
X-Gm-Message-State: AOAM530tUD6j73JsbMw9FRzOvYxcwvvvKQ902N/xWmFeWhfQcr6Hoe70
        n7MNqWMegHnMV4JMDKu7pXuDf/nOSJ2Jdw==
X-Google-Smtp-Source: ABdhPJzjnGkVa+fuH78RfsZ/5Fikz9rqg35+HXqODerwFpiX5juoNbT0sYBRb4HzhodMklLHHOx5sw==
X-Received: by 2002:aa7:c518:: with SMTP id o24mr2436835edq.64.1619080862849;
        Thu, 22 Apr 2021 01:41:02 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id b8sm1560667edu.41.2021.04.22.01.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Apr 2021 01:41:02 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Luke Shumaker <lukeshu@lukeshu.com>,
        Git Mailing List <git@vger.kernel.org>,
        Luke Shumaker <lukeshu@datawire.io>, Jeff King <peff@peff.net>
Subject: Re: [RFC PATCH] fast-export, fast-import: Let tags specify an
 internal name
References: <20210420190552.822138-1-lukeshu@lukeshu.com>
 <xmqqa6ps4otm.fsf@gitster.g> <87zgxs2gp9.fsf@evledraar.gmail.com>
 <CABPp-BFY65wddHHw2Uhortcux+TzMYBZS1wwfnsasYeishXa-w@mail.gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <CABPp-BFY65wddHHw2Uhortcux+TzMYBZS1wwfnsasYeishXa-w@mail.gmail.com>
Date:   Thu, 22 Apr 2021 10:41:01 +0200
Message-ID: <874kfy3e5e.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Apr 21 2021, Elijah Newren wrote:

> On Wed, Apr 21, 2021 at 1:19 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>>
>>
>> On Tue, Apr 20 2021, Junio C Hamano wrote:
>>
>> > Luke Shumaker <lukeshu@lukeshu.com> writes:
>> >
>> >> That'd work fine if they're lightweight tags, but if they're annotated
>> >> tags, then after the rename the internal name in the tag object
>> >> (`v0.0.1`) is now different than the refname (`gitk/v0.0.1`).  Which
>> >> is still mostly fine, since not too many tools care if the internal
>> >> name and the refname disagree.
>> >>
>> >> But, fast-export/fast-import are tools that do care: it's currently
>> >> impossible to represent these tags in a fast-import stream.
>> >>
>> >> This patch adds an optional "name" sub-command to fast-import's "tag"
>> >> top-level-command, the stream
>> >>
>> >>     tag foo
>> >>     name bar
>> >>     ...
>> >>
>> >> will create a tag at "refs/tags/foo" that says "tag bar" internally.
>> >>
>> >> These tags are things that "shouldn't" happen, so perhaps adding
>> >> support for them to fast-export/fast-import is unwelcome, which is why
>> >> I've marked this as an "RFC".  If this addition is welcome, then it
>> >> still needs tests and documentation.
>> >
>> > I actually think this is a good direction to go in, and it might be
>> > even an acceptable change to fsck to require only the tail match of
>> > tagname and refname so that it becomes perfectly OK for Gitk's
>> > "v0.0.1" tag to be stored at say "refs/tags/gitk/v0.0.1".
>>
>> Do you mean to change fsck to care about this it all? It doesn't care
>> about the refname pointing to a tag, and AFAICT we never did.
>>
>> All we check is that the pseudo-"refname" is valid, i.e. if we were to
>> use the thing we find on the "tag" line as a refname, does it pass
>> check_refname_format()?
>>
>> "git tag -v" doesn't care either:
>>
>>         $ git update-ref refs/tags/a-v-2.31.0 3e90d4b58f3819cfd58ac61cb8=
668e83d3ea0563
>>         $ git tag -v a-v-2.31.0
>>         object a5828ae6b52137b913b978e16cd2334482eb4c1f
>>         type commit
>>         tag v2.31.0
>>         tagger Junio C Hamano <gitster@pobox.com> 1615834385 -0700
>>         [.. snip same gpgp output as for v2.31.0 itself..]
>>
>> I think at this point the right thing to do is to just explicitly
>> document that we ignore it, and that the export/import chain should be
>> as forgiving about it as possible.
>>
>> I.e. we have not cared about this before for validation, and
>> e.g. core.alternateRefsPrefixes and such things will break any "it
>> should be under refs/tags/" assumption.
>>
>> There's also perfectly legitimate in-the-wild use-cases for this,
>> e.g. "archiving" tags to not-refs/tags/* so e.g. the upload-pack logic
>> doesn't consider and follow them. Not being able to export/import those
>> repositories as-is due to an overzelous data check there that's not in
>> fsck.c would suck.
>
> Not would suck, but does suck.  I had to document it as a shortcoming
> of fast-export/fast-import -- see
> https://www.mankier.com/1/git-filter-repo#Internals-Limitations, where
> I wrote, "annotated and signed tags outside of the refs/tags/
> namespace are not supported (their location will be mangled in weird
> ways)".

Indeed, hence the whole point of this thread. I stand corrected.

I'm less familiar with fast-export (obviously), just wanted to chime in
on the "tag" field in the tag object.

> The problem is, what's the right backward-compatible way to fix this?
> Do we have to add a flag to both fast-export and fast-import to stop
> assuming a "refs/tags/" prefix and use the full refname, and require
> the user to pass both flags?  How is fast-import supposed to know that
> "refs/alternate-tags/foo" is or isn't
> "refs/tags/refs/alternate-tags/foo"?
>
> And if we need such a flag, should fast-import die if it sees this new
> "name" directive and the flag isn't given?

After looking at it, it seems to me that there's two potential cases,
and the simpler one we can nastily hack in, the more complex case needs
a format change.

This is the simpler case:
=09
	test_expect_success 'setup' '
		echo file content >file &&
		git add file &&
		git commit -m"my commit message" &&
		git tag -a -m"my tag message" mytag HEAD &&
=09
		git for-each-ref &&
		git fast-export --all >stream.a &&
=09
		mkdir .git/refs/mytags &&
		mv .git/refs/tags/mytag .git/refs/mytags/ &&
		git for-each-ref &&
		git fast-export --all >stream.b &&
		test_might_fail git diff --no-index stream.a stream.b
	'
=09
	test_expect_success 'minimal' '
		git init --bare import &&
		cat stream.b &&
		git -C import fast-import <stream.b &&
		git -C import for-each-ref
	'
=09
	test_done

Right now this "works", but with this difference in the stream:
=20=20=20=20
    + git diff --no-index stream.a stream.b
    diff --git a/stream.a b/stream.b
    index 0d7d656..167bc26 100644
    --- a/stream.a
    +++ b/stream.b
    @@ -12,7 +12,7 @@ data 18
     my commit message
     M 100644 :1 file
=20=20=20=20
    -tag mytag
    +tag refs/mytags/mytag
     from :2
     tagger C O Mitter <committer@example.com> 1112354055 +0200
     data 15

Instead of:

    9ecf7742801c36c6b37b068fdf499603702c582a tag    refs/mytags/mytag
=20=20=20=20
we end up with:
=20=20=20=20
    ed9c5b1dcec27acec5dac510d475869d4d11a6a9 tag    refs/tags/refs/mytags/m=
ytag
=20=20=20=20
The only difference in the objects is that the former has "tag mytag",
and the latter "tag refs/mytags/mytag", since we didn't trigger the
special-case of stripping off the "refs/tags/*" prefix.

So wouldn't the nasty hack of:

    * If we see a tag object
    * It's prefixed with refs/*, e.g. "refs/some-name/space/a-name"

We strip off everything until the last slash, stick that "a-name" in the
"tag" header, and place the resulting object at the requested
"refs/some-name/space/a-name."

This rule would be ambiguous for anyone who today has a tag name like
"refs/tags/refs/[...]", but that seems exceedingly unlikely (and we
could guard the behavior with a flag or whatever).

The case we can't seem to support without a format change is if you not
only moved the tag to a new namespace, but also changed its name.

But isn't that a special-case of fast-export being unable to support
custom commit/tag object headers (maybe it does, and I've just missed
that). I.e. we could then easily support it as a minor special-case of
sometimes including the built-in "tag" header as a "custom" header.
