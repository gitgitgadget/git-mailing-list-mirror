Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4192EC433EF
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 04:46:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbhLIEuH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Dec 2021 23:50:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbhLIEuF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Dec 2021 23:50:05 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 691AEC061746
        for <git@vger.kernel.org>; Wed,  8 Dec 2021 20:46:32 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id x6so15549295edr.5
        for <git@vger.kernel.org>; Wed, 08 Dec 2021 20:46:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=OJkaQL7bYzcKI7PJtbMAM9Raj7Yz14kt3ysqiTIU2XI=;
        b=P4MSlovVYq0JjQIy6npIfHgoa15GKSSY96qJKU59b4Bo8pjxhX8Os4Dkas0onyA36W
         WfDrj15Swof0zv4ZPdChQx/uwqi1LCbmIlGyirT3NI8IBsw2kYowP7JAQREaXFrcfwB8
         mrYuUkaAZ4sG2eIi7F+0P+oWQRzrRWu5XS0ro2e8tVWX7cEiPzXdyxGsgPeFKNjiLmgX
         zOWr+XNVkFsqeOpccMBvJA7x6XAReD3JVpIYp6Izi1vhAUN70/9PrZ2Fpu3HzPHiibaW
         cGwMi/tTzTWFHhORO7BZe47sxhXhKuCdv2wQJ4UokvEbM0YZlchzequZ7G9aZ2oPKBG6
         JEdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=OJkaQL7bYzcKI7PJtbMAM9Raj7Yz14kt3ysqiTIU2XI=;
        b=cUdQY5HCtan6fVga5gqllcROv0HtxT6u2HNCpgV0oDQcJcOJ6EBX4TfzGUOCpcfEzc
         dznn9t9PlFVINIfXaSs0wx+fHmqX5kQSvr+r1y5hgB4hLr+fPnBZg3GwaJDFER7BB/uW
         c5fJd/BaekhlDyTalG4xhDPli1TqxYYFqDbcJo4YmGbxGNdd3oGt3XkDATTL+EWQ8SUc
         RTggvLeog0VozVKOM3HcS0j/T1yuNbZJ+ll6iPCJZ2ZO6nO27EmihoSbzMd2i0ZwcxKI
         W0bN0DgYIOmWO6E8lGIezEhvzlaaAQIiYtAn5uygUTLDEypeBSQu2rSh4FnEsDhDLrnZ
         dR/A==
X-Gm-Message-State: AOAM533ieQ9VouZ3PnP4nVQgin8r1mqn7pnhIy21XweWc7DJnEudLeYP
        uZGgjfrQ8nLXtDff9jTGJ/Jn1FOWnpXcIA==
X-Google-Smtp-Source: ABdhPJxDqZX0R0hzCzB6280XfSYa4xC7X5gmmystDt4O+1pgFMXMzQheMvQNMuSLF2QqhIsbqHMOIQ==
X-Received: by 2002:a17:907:7ba8:: with SMTP id ne40mr12801133ejc.391.1639025190269;
        Wed, 08 Dec 2021 20:46:30 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id j17sm3079039edj.0.2021.12.08.20.46.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 20:46:29 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mvBK7-001WlM-3c;
        Thu, 09 Dec 2021 05:46:27 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Neeraj Singh <nksingh85@gmail.com>
Cc:     Neeraj Singh via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        Neeraj Singh <neerajsi@microsoft.com>
Subject: Re: [PATCH v2 2/3] core.fsync: introduce granular fsync control
Date:   Thu, 09 Dec 2021 05:08:50 +0100
References: <pull.1093.git.1638588503.gitgitgadget@gmail.com>
 <pull.1093.v2.git.1638845211.gitgitgadget@gmail.com>
 <ff80a94bf9add8a6fabcd5146e5177edf5e35e49.1638845211.git.gitgitgadget@gmail.com>
 <211207.86wnkgo9fv.gmgdl@evledraar.gmail.com>
 <CANQDOdfX2KaosPwLM4hS4rp+FH9V7VUxUh_md43FfZ9NG4iroQ@mail.gmail.com>
 <211208.86ee6nmme5.gmgdl@evledraar.gmail.com>
 <CANQDOddkKbUC-g97JOf40nS28Yv1KACvbjW9gtQZemfBMutPCw@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <CANQDOddkKbUC-g97JOf40nS28Yv1KACvbjW9gtQZemfBMutPCw@mail.gmail.com>
Message-ID: <211209.86bl1ql718.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Dec 08 2021, Neeraj Singh wrote:

> On Wed, Dec 8, 2021 at 2:17 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <av=
arab@gmail.com> wrote:
>>
>>
>> On Tue, Dec 07 2021, Neeraj Singh wrote:
>>
>> > On Tue, Dec 7, 2021 at 5:01 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason =
<avarab@gmail.com> wrote:
>> >>
>> >>
>> >> On Tue, Dec 07 2021, Neeraj Singh via GitGitGadget wrote:
>> >>
>> >> > From: Neeraj Singh <neerajsi@microsoft.com>
>> >> >
>> >> > This commit introduces the `core.fsync` configuration
>> >> > knob which can be used to control how components of the
>> >> > repository are made durable on disk.
>> >> >
>> >> > This setting allows future extensibility of the list of
>> >> > syncable components:
>> >> > * We issue a warning rather than an error for unrecognized
>> >> >   components, so new configs can be used with old Git versions.
>> >>
>> >> Looks good!
>> >>
>> >> > * We support negation, so users can choose one of the default
>> >> >   aggregate options and then remove components that they don't
>> >> >   want. The user would then harden any new components added in
>> >> >   a Git version update.
>> >>
>> >> I think this config schema makes sense, but just a (I think important)
>> >> comment on the "how" not "what" of it. It's really much better to def=
ine
>> >> config as:
>> >>
>> >>     [some]
>> >>     key =3D value
>> >>     key =3D value2
>> >>
>> >> Than:
>> >>
>> >>     [some]
>> >>     key =3D value,value2
>> >>
>> >> The reason is that "git config" has good support for working with
>> >> multi-valued stuff, so you can do e.g.:
>> >>
>> >>     git config --get-all -z some.key
>> >>
>> >> And you can easily (re)set such config e.g. with --replace-all etc., =
but
>> >> for comma-delimited you (and users) need to do all that work themselv=
es.
>> >>
>> >> Similarly instead of:
>> >>
>> >>     some.key =3D want-this
>> >>     some.key =3D -not-this
>> >>     some.key =3D but-want-this
>> >>
>> >> I think it's better to just have two lists, one inclusive another
>> >> exclusive. E.g. see "log.decorate" and "log.excludeDecoration",
>> >> "transfer.hideRefs"
>> >>
>> >> Which would mean:
>> >>
>> >>     core.fsync =3D want-this
>> >>     core.fsyncExcludes =3D -not-this
>> >>
>> >> For some value of "fsyncExcludes", maybe "noFsync"? Anyway, just a
>> >> suggestion on making this easier for users & the implementation.
>> >>
>> >
>> > Maybe there's some way to handle this I'm unaware of, but a
>> > disadvantage of your multi-valued config proposal is that it's harder,
>> > for example, for a per-repo config store to reasonably override a
>> > per-user config store.  With the configuration scheme as-is, I can
>> > have a per-user setting like `core.fsync=3Dall` which covers my typical
>> > repos, but then have a maintainer repo with a private setting of
>> > `core.fsync=3Dnone` to speed up cases where I'm mostly working with
>> > other people's changes that are backed up in email or server-side
>> > repos.  The latter setting conveniently overrides the former setting
>> > in all aspects.
>>
>> Even if you turn just your comma-delimited proposal into a list proposal
>> can't we just say that the last one wins? Then it won't matter what cmae
>> before, you'd specify "core.fsync=3Dnone" in your local .git/config.
>>
>> But this is also a general issue with a bunch of things in git's config
>> space. I'd rather see us use the list-based values and just come up with
>> some general way to reset them that works for all keys, rather than
>> regretting having comma-delimited values that'll be harder to work with
>> & parse, which will be a legacy wart if/when we come up with a way to
>> say "reset all previous settings".
>>
>> > Also, with the core.fsync and core.fsyncExcludes, how would you spell
>> > "don't sync anything"? Would you still have the aggregate options.?
>>
>>     core.fsyncExcludes =3D *
>>
>> I.e. the same as the core.fsync=3Dnone above, anyway I still like the
>> wildcard thing below a bit more...
>
> I'm not going to take this feedback unless there are additional votes
> from the Git community in this direction.  I make the claim that
> single-valued comma-separated config lists are easier to work with in
> the existing Git infrastructure.=20

Easier in what sense? I showed examples of how "git-config" trivially
works with multi-valued config, but for comma-delimited you'll need to
write your own shellscript boilerplate around simple things like adding
values, removing existing ones etc.

I.e. you can use --add, --unset, --unset-all, --get, --get-all etc.

> parsing code for the core.whitespace variable and users are used to
> this syntax there. There are several other comma-separated lists in
> the config space, so this construct has precedence and will be with
> Git for some time.

That's not really an argument either way for why we'd pick X over Y for
something new. We've got some comma-delimited, some multi-value (I'm
fairly sure we have more multi-value).

> Also, fsync configurations aren't composable like
> some other configurations may be. It makes sense to have a holistic
> singular fsync configuration, which is best represented by a single
> variable.

What's a "variable" here? We call these "keys", you can have a
single-value key like user.name that you get with --get, or a
multi-value key like say branch.<name>.merge or push.pushOption that
you'd get with --get-all.

I think you may be referring to either not wanting these to be
"inherited" (which is not really a think we do for anything else in
config), or lacking the ability to "reset".

For the latter if that's absolutely needed we could just use the same
trick as "diff.wsErrorHighlight" uses of making an empty value "reset"
the list, and you'd get better "git config" support for editing it.

>> >> > This also supports the common request of doing absolutely no
>> >> > fysncing with the `core.fsync=3Dnone` value, which is expected
>> >> > to make the test suite faster.
>> >>
>> >> Let's just use the git_parse_maybe_bool() or git_parse_maybe_bool_tex=
t()
>> >> so we'll accept "false", "off", "no" like most other such config?
>> >
>> > Junio's previous feedback when discussing batch mode [1] was to offer
>> > less flexibility when parsing new values of these configuration
>> > options. I agree with his statement that "making machine-readable
>> > tokens be spelled in different ways is a 'disease'."  I'd like to
>> > leave this as-is so that the documentation can clearly state the exact
>> > set of allowable values.
>> >
>> > [1] https://lore.kernel.org/git/xmqqr1dqzyl7.fsf@gitster.g/
>>
>> I think he's talking about batch, Batch, BATCH, bAtCh etc. there. But
>> the "maybe bool" is a stanard pattern we use.
>>
>> I don't think we'd call one of these 0, off, no or false etc. to avoid
>> confusion, so then you can use git_parse_maybe_...()
>
> I don't see the advantage of having multiple ways of specifying
> "none".  The user can read the doc and know exactly what to write.  If
> they write something unallowable, they get a clear warning and they
> can read the doc again to figure out what to write.  This isn't a
> boolean options at all, so why should we entertain bool-like ways of
> spelling it?

It's not boolean, it's multi-value and one of the values includes a true
or false boolean value. You just spell it "none".

I think both this and your comment above suggest that you think there's
no point in this because you haven't interacted with/used "git config"
as a command line or API mechanism, but have just hand-crafted config
files.

That's fair enough, but there's a lot of tooling that benefits from the
latter.

E.g.:
=20=20=20=20
    $ git -c core.fsync=3Doff config --type=3Dbool core.fsync
    false
    $ git -c core.fsync=3Dblah config --type=3Dbool core.fsync
    fatal: bad boolean config value 'blah' for 'core.fsync'

Here we can get 'git config' to normalize what you call 'none', and you
can tell via exit codes/normalization if it's "false". But if you invent
a new term for "false" you can't do that as easily.

We have various historical keys that take odd exceptions to that,
e.g. "never", but unless we have a good reason to let's not invent more
exceptions.

>> >> > Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
>> >> > ---
>> >> >  Documentation/config/core.txt | 27 +++++++++----
>> >> >  builtin/fast-import.c         |  2 +-
>> >> >  builtin/index-pack.c          |  4 +-
>> >> >  builtin/pack-objects.c        |  8 ++--
>> >> >  bulk-checkin.c                |  5 ++-
>> >> >  cache.h                       | 39 +++++++++++++++++-
>> >> >  commit-graph.c                |  3 +-
>> >> >  config.c                      | 76 +++++++++++++++++++++++++++++++=
+++-
>> >> >  csum-file.c                   |  5 ++-
>> >> >  csum-file.h                   |  3 +-
>> >> >  environment.c                 |  1 +
>> >> >  midx.c                        |  3 +-
>> >> >  object-file.c                 |  3 +-
>> >> >  pack-bitmap-write.c           |  3 +-
>> >> >  pack-write.c                  | 13 +++---
>> >> >  read-cache.c                  |  2 +-
>> >> >  16 files changed, 164 insertions(+), 33 deletions(-)
>> >> >
>> >> > diff --git a/Documentation/config/core.txt b/Documentation/config/c=
ore.txt
>> >> > index dbb134f7136..4f1747ec871 100644
>> >> > --- a/Documentation/config/core.txt
>> >> > +++ b/Documentation/config/core.txt
>> >> > @@ -547,6 +547,25 @@ core.whitespace::
>> >> >    is relevant for `indent-with-non-tab` and when Git fixes `tab-in=
-indent`
>> >> >    errors. The default tab width is 8. Allowed values are 1 to 63.
>> >> >
>> >> > +core.fsync::
>> >> > +     A comma-separated list of parts of the repository which shoul=
d be
>> >> > +     hardened via the core.fsyncMethod when created or modified. Y=
ou can
>> >> > +     disable hardening of any component by prefixing it with a '-'=
. Later
>> >> > +     items take precedence over earlier ones in the list. For exam=
ple,
>> >> > +     `core.fsync=3Dall,-pack-metadata` means "harden everything ex=
cept pack
>> >> > +     metadata." Items that are not hardened may be lost in the eve=
nt of an
>> >> > +     unclean system shutdown.
>> >> > ++
>> >> > +* `none` disables fsync completely. This must be specified alone.
>> >> > +* `loose-object` hardens objects added to the repo in loose-object=
 form.
>> >> > +* `pack` hardens objects added to the repo in packfile form.
>> >> > +* `pack-metadata` hardens packfile bitmaps and indexes.
>> >> > +* `commit-graph` hardens the commit graph file.
>> >> > +* `objects` is an aggregate option that includes `loose-objects`, =
`pack`,
>> >> > +  `pack-metadata`, and `commit-graph`.
>> >> > +* `default` is an aggregate option that is equivalent to `objects,=
-loose-object`
>> >> > +* `all` is an aggregate option that syncs all individual component=
s above.
>> >> > +
>> >>
>> >> It's probably a *bit* more work to set up, but I wonder if this would=
n't
>> >> be simpler if we just said (and this is partially going against what I
>> >> noted above):
>> >>
>> >> =3D=3D BEGIN DOC
>> >>
>> >> core.fsync is a multi-value config variable where each item is a
>> >> pathspec that'll get matched the same way as 'git-ls-files' et al.
>> >>
>> >> When we sync pretend that a path like .git/objects/de/adbeef... is
>> >> relative to the top-level of the git
>> >> directory. E.g. "objects/de/adbeaf.." or "objects/pack/...".
>> >>
>> >> You can then supply a list of wildcards and exclusions to configure
>> >> syncing.  or "false", "off" etc. to turn it off. These are synonymous
>> >> with:
>> >>
>> >>     ; same as "false"
>> >>     core.fsync =3D ":!*"
>> >>
>> >> Or:
>> >>
>> >>     ; same as "true"
>> >>     core.fsync =3D "*"
>> >>
>> >> Or, to selectively sync some things and not others:
>> >>
>> >>     ;; Sync objects, but not "info"
>> >>     core.fsync =3D ":!objects/info/**"
>> >>     core.fsync =3D "objects/**"
>> >>
>> >> See gitrepository-layout(5) for details about what sort of paths you
>> >> might be expected to match. Not all paths listed there will go through
>> >> this mechanism (e.g. currently objects do, but nothing to do with con=
fig
>> >> does).
>> >>
>> >> We can and will match this against "fake paths", e.g. when writing out
>> >> packs we may match against just the string "objects/pack", we're not
>> >> going to re-check if every packfile we're writing matches your globs,
>> >> ditto for loose objects. Be reasonable!
>> >>
>> >> This metharism is intended as a shorthand that provides some flexibil=
ity
>> >> when fsyncing, while not forcing git to come up with labels for all
>> >> paths the git dir, or to support crazyness like "objects/de/adbeef*"
>> >>
>> >> More paths may be added or removed in the future, and we make no
>> >> promises that we won't move things around, so if in doubt use
>> >> e.g. "true" or a wide pattern match like "objects/**". When in doubt
>> >> stick to the golden path of examples provided in this documentation.
>> >>
>> >> =3D=3D END DOC
>> >>
>> >>
>> >> It's a tad more complex to set up, but I wonder if that isn't worth
>> >> it. It nicely gets around any current and future issues of deciding w=
hat
>> >> labels such as "loose-object" etc. to pick, as well as slotting into =
an
>> >> existing method of doing exclude/include lists.
>> >>
>> >
>> > I think this proposal is a lot of complexity to avoid coming up with a
>> > new name for syncable things as they are added to Git.  A path based
>> > mechanism makes it hard to document for the (advanced) user what the
>> > full set of things is and how it might change from release to release.
>> > I think the current core.fsync scheme is a bit easier to understand,
>> > query, and extend.
>>
>> We document it in gitrepository-layout(5). Yeah it has some
>> disadvantages, but one advantage is that you could make the
>> composability easy. I.e. if last exclude wins then a setting of:
>>
>>     core.fsync =3D ":!*"
>>     core.fsync =3D "objects/**"
>>
>> Would reset all previous matches & only match objects/**.
>>
>
> The value of changing this is predicated on taking your previous
> multi-valued config proposal, which I'm still not at all convinced
> about.

They're orthagonal. I.e. you get benefits from multi-value with or
without this globbing mechanism.

In any case, I don't feel strongly about/am really advocating this
globbing mechanism. I just wondered if it wouldn't make things simpler
since it would sidestep the need to create any sort of categories for
subsets of gitrepository-layout(5), but maybe not...

> The schema in the current (v1-v2) version of the patch already
> includes an example of extending the list of syncable things, and
> Patrick Steinhardt made it clear that he feels comfortable adding
> 'refs' to the same schema in a future change.
>
> I'll also emphasize that we're talking about a non-functional,
> relatively corner-case behavioral configuration.  These values don't
> change how git's interface behaves except when the system crashes
> during a git command or shortly after one completes.

That may be something some OS's promise, but it's not something fsync()
or POSIX promises. I.e. you might write a ref, but unless you fsync and
the relevant dir entries another process might not see the update, crash
or not.

That's an aside from these config design questions, and I think
most/(all?) OS's anyone cares about these days tend to make that
implicit promise as part of their VFS behavior, but we should probably
design such an interface to fsync() with such pedantic portability in
mind.

> While you may not personally love the proposed configuration
> interface, I'd want your view on some questions:
> 1. Is it easy for the (advanced) user to set a configuration?
> 2. Is it easy for the (advanced) user to see what was configured?
> 3. Is it easy for the Git community to build on this as we want to add
> things to the list of things to sync?
>     a) Is there a good best practice configuration so that people can
> avoid losing integrity for new stuff that they are intending to sync.
>     b) If someone has a custom configuration, can that custom
> configuration do something reasonable as they upgrade versions of Git?
>              ** In response to this question, I might see some value
> in adding a 'derived-metadata' aggregate that can be disabled so that
> a custom configuration can exclude those as they change version to
> version.
>     c) Is it too much maintenance overhead to consider how to present
> this configuration knob for any new hashfile or other datafile in the
> git repo?
> 4. Is there a good path forward to change the default syncable set,
> both in git-for-windows and in Git for other platforms?

I'm not really sure this globbing this is a good idea, as noted above
just a suggestion etc.

As noted there it just gets you out of the business of re-defining
gitrepository-layout(5), and assuming too much in advance about certain
use-cases.

E.g. even "refs" might be too broad for some. I don't tend to be I/O
limited, but I could see how someone who would be would care about
refs/heads but not refs/remotes, or want to exclude logs/* but not the
refs updates themselves etc.

>> >> > diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
>> >> > index 857be7826f3..916c55d6ce9 100644
>> >> > --- a/builtin/pack-objects.c
>> >> > +++ b/builtin/pack-objects.c
>> >> > @@ -1204,11 +1204,13 @@ static void write_pack_file(void)
>> >> >                * If so, rewrite it like in fast-import
>> >> >                */
>> >> >               if (pack_to_stdout) {
>> >> > -                     finalize_hashfile(f, hash, CSUM_HASH_IN_STREA=
M | CSUM_CLOSE);
>> >> > +                     finalize_hashfile(f, hash, FSYNC_COMPONENT_NO=
NE,
>> >> > +                                       CSUM_HASH_IN_STREAM | CSUM_=
CLOSE);
>> >>
>> >> Not really related to this per-se, but since you're touching the API
>> >> everything goes through I wonder if callers should just always try to
>> >> fsync, and we can just catch EROFS and EINVAL in the wrapper if someo=
ne
>> >> tries to flush stdout, or catch the fd at that lower level.
>> >>
>> >> Or maybe there's a good reason for this...
>> >
>> > It's platform dependent, but I'd expect fsync would do something for
>> > pipes or stdout redirected to a file.  In these cases we really don't
>> > want to fsync since we have no idea what we're talking to and we're
>> > potentially worsening performance for probably no benefit.
>>
>> Yeah maybe we should just leave it be.
>>
>> I'd think the C library returning EINVAL would be a trivial performance
>> cost though.
>>
>> It just seemed odd to hardcode assumptions about what can and can't be
>> synced when the POSIX defined function will also tell us that.
>>
>
> Redirecting stdout to a file seems like a common usage for this
> command. That would definitely be fsyncable, but Git has no idea what
> its proper category is since there's no way to know the purpose or
> lifetime of the packfile.  I'm going to leave this be, because I'd
> posit that "can it be fsynced?" is not the same as "should it be
> fsynced?".  The latter question can't be answered for stdout.

As noted this was just an aside, and I don't even know if any OS would
do anything meaningful with an fsync() of such a FD anyway.

I just don't see why we wouldn't say:

 1. We're syncing this category of thing
 2. Try it
 3. If fsync returns "can't fsync that sort of thing" move on

As opposed to trying to shortcut #3 by doing the detection ourselves.

I.e. maybe there was a good reason, but it seemed to be some easy
potential win for more simplification, since you were re-doing and
simplifying some of the interface anyway...

>>
>> >> > [...]
>> >> > +/*
>> >> > + * These values are used to help identify parts of a repository to=
 fsync.
>> >> > + * FSYNC_COMPONENT_NONE identifies data that will not be a persist=
ent part of the
>> >> > + * repository and so shouldn't be fsynced.
>> >> > + */
>> >> > +enum fsync_component {
>> >> > +     FSYNC_COMPONENT_NONE                    =3D 0,
>> >>
>> >> I haven't read ahead much but in most other such cases we don't define
>> >> the "=3D 0", just start at 1<<0, then check the flags elsewhere...
>> >>
>> >> > +static const struct fsync_component_entry {
>> >> > +     const char *name;
>> >> > +     enum fsync_component component_bits;
>> >> > +} fsync_component_table[] =3D {
>> >> > +     { "loose-object", FSYNC_COMPONENT_LOOSE_OBJECT },
>> >> > +     { "pack", FSYNC_COMPONENT_PACK },
>> >> > +     { "pack-metadata", FSYNC_COMPONENT_PACK_METADATA },
>> >> > +     { "commit-graph", FSYNC_COMPONENT_COMMIT_GRAPH },
>> >> > +     { "objects", FSYNC_COMPONENTS_OBJECTS },
>> >> > +     { "default", FSYNC_COMPONENTS_DEFAULT },
>> >> > +     { "all", FSYNC_COMPONENTS_ALL },
>> >> > +};
>> >> > +
>> >> > +static enum fsync_component parse_fsync_components(const char *var=
, const char *string)
>> >> > +{
>> >> > +     enum fsync_component output =3D 0;
>> >> > +
>> >> > +     if (!strcmp(string, "none"))
>> >> > +             return output;
>> >> > +
>> >> > +     while (string) {
>> >> > +             int i;
>> >> > +             size_t len;
>> >> > +             const char *ep;
>> >> > +             int negated =3D 0;
>> >> > +             int found =3D 0;
>> >> > +
>> >> > +             string =3D string + strspn(string, ", \t\n\r");
>> >>
>> >> Aside from the "use a list" isn't this hardcoding some windows-specif=
ic
>> >> assumptions with \n\r? Maybe not...
>> >
>> > I shamelessly stole this code from parse_whitespace_rule. I thought
>> > about making a helper to be called by both functions, but the amount
>> > of state going into and out of the wrapper via arguments was
>> > substantial and seemed to negate the benefit of deduplication.
>>
>> FWIW string_list_split() is easier to work with in those cases, or at
>> least I think so...
>
> This code runs at startup for a variable that may be present on some
> installations.  The nice property of the current patch's code is that
> it's already a well-tested pattern that doesn't do any allocations as
> it's working, unlike string_list_split().

Multi-value config would also get you fewer allocations :)

Anyway, I mainly meant to point out that for stuff like this it's fine
to optimize it for ease rather than micro-optimize allocations. Those
really aren't a bottleneck on this scale.

Even in that case there's string_list_split_in_place(), which can be a
bit nicer than manual C-string fiddling.

> I hope you know that I appreciate your review feedback, even though
> I'm pushing back on most of it so far this round. I'll be sending v3
> to the list soon after giving it another look over.

Sure, no worries. Just hoping to help. If you go for something different
etc. that's fine. Just hoping to bridge the gap in some knowledge /
offer potentially interesting suggestions (some of which may be dead
ends, like the config glob thing...).
