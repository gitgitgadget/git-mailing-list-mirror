Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 958ADC433EF
	for <git@archiver.kernel.org>; Wed, 19 Jan 2022 15:27:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242318AbiASP1r (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Jan 2022 10:27:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239385AbiASP1q (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jan 2022 10:27:46 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F9BC061574
        for <git@vger.kernel.org>; Wed, 19 Jan 2022 07:27:46 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id b13so14001478edn.0
        for <git@vger.kernel.org>; Wed, 19 Jan 2022 07:27:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=jkNISof+mQsgkow7/Y5El/gaV9QUNXDbMfdauhG4nRw=;
        b=cjQfdcQkQq4tFI3RzgtORIcC8EngfZwO29pBnK5xX3aDJIF6zjb2bjFaMtTeWF2BGd
         8ufaqSHzxvknM1GWiXC45D1Th1sJY2elfNp9xq5252DFDJwC5igc9FO09XXgH7yEF5XT
         utBLZWWkaTrEQ8PAMry/YHxH1GK90NOpUzkrnrH4xmPSji61AZQ3f3K2T8vnuBhU2k2I
         Ls8Un+Pam6AS8ON56OC5fibhx+vaC7g6v0uH7/OYwOmV0/rTc9XcsEtj7i84iwf0IV9h
         hKKnUXFkzgqg+fdQMxbex4GCun5Ow+2HC1LrZyUDCSX0EOGL1RzGQtBdOaNim2tGkKtr
         IZiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=jkNISof+mQsgkow7/Y5El/gaV9QUNXDbMfdauhG4nRw=;
        b=UN/oyj4jxTdwQreVHmqfwmvHzea2JNj1Q0MYwB1mhjf4rAMiH4I7tMNW9DjsyLUdc0
         1VRYJNNbpHZYeeCtIfyAbUkJKDcNi42T3aIeiJ2OEIVgc1vO3N5bWnJIVZ/NxEUBoN1n
         fyT9p17GcCLq1M+hisP/2kjUCxzldngxHfW4MNdMG8Tv1As1mgYt46MfZugaF0qkKjmQ
         s85/DFPlnEDZ7DZCcNqlaUa8goP+LPWlNbCqWtMYSBKvzUNiSKy70XzlN0e0M0kujOu6
         7oQTHsNL/lFdPJXr53HaUfeyq42qHf1jcaUsgrv1NKwP29/r8G6R896rHq9hYcl7Gd1g
         Ltlg==
X-Gm-Message-State: AOAM533HuV1oAYAv1F2DAhAZ3lsA+fpg++GicpzvQE9MfD8ApUOVCBYG
        JV/oqteKhZWtYqAJkyD0XuqX9cw+3S/aww==
X-Google-Smtp-Source: ABdhPJyAnUNC2EOoHyf+UuZ/66a30PbbYoD05BS/c3vmod7wOtjOoWjryLbvOIKRY9EhxGBBrIZJqA==
X-Received: by 2002:a17:906:38ce:: with SMTP id r14mr24935461ejd.468.1642606063676;
        Wed, 19 Jan 2022 07:27:43 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id h15sm26434ejg.144.2022.01.19.07.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 07:27:43 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nACsA-001nBk-Ik;
        Wed, 19 Jan 2022 16:27:42 +0100
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
Date:   Wed, 19 Jan 2022 15:52:15 +0100
References: <pull.1093.git.1638588503.gitgitgadget@gmail.com>
 <pull.1093.v2.git.1638845211.gitgitgadget@gmail.com>
 <ff80a94bf9add8a6fabcd5146e5177edf5e35e49.1638845211.git.gitgitgadget@gmail.com>
 <211207.86wnkgo9fv.gmgdl@evledraar.gmail.com>
 <CANQDOdfX2KaosPwLM4hS4rp+FH9V7VUxUh_md43FfZ9NG4iroQ@mail.gmail.com>
 <211208.86ee6nmme5.gmgdl@evledraar.gmail.com>
 <CANQDOddkKbUC-g97JOf40nS28Yv1KACvbjW9gtQZemfBMutPCw@mail.gmail.com>
 <211209.86bl1ql718.gmgdl@evledraar.gmail.com>
 <CANQDOdchh3mfC8S6ouWAQbtWzZUkmTzF1p5D9dg4muoBu4N1Fg@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <CANQDOdchh3mfC8S6ouWAQbtWzZUkmTzF1p5D9dg4muoBu4N1Fg@mail.gmail.com>
Message-ID: <220119.8635ljoidt.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Dec 08 2021, Neeraj Singh wrote:

[Sorry about the late reply, and thanks for the downthread prodding]

> On Wed, Dec 8, 2021 at 8:46 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <av=
arab@gmail.com> wrote:
>>
>>
>> On Wed, Dec 08 2021, Neeraj Singh wrote:
>>
>> > On Wed, Dec 8, 2021 at 2:17 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason =
<avarab@gmail.com> wrote:
>> >>
>> >>
>> >> On Tue, Dec 07 2021, Neeraj Singh wrote:
>> >>
>> >> > On Tue, Dec 7, 2021 at 5:01 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmas=
on <avarab@gmail.com> wrote:
>> >> >>
>> >> >>
>> >> >> On Tue, Dec 07 2021, Neeraj Singh via GitGitGadget wrote:
>> >> >>
>> >> >> > From: Neeraj Singh <neerajsi@microsoft.com>
>> >> >> >
>> >> >> > This commit introduces the `core.fsync` configuration
>> >> >> > knob which can be used to control how components of the
>> >> >> > repository are made durable on disk.
>> >> >> >
>> >> >> > This setting allows future extensibility of the list of
>> >> >> > syncable components:
>> >> >> > * We issue a warning rather than an error for unrecognized
>> >> >> >   components, so new configs can be used with old Git versions.
>> >> >>
>> >> >> Looks good!
>> >> >>
>> >> >> > * We support negation, so users can choose one of the default
>> >> >> >   aggregate options and then remove components that they don't
>> >> >> >   want. The user would then harden any new components added in
>> >> >> >   a Git version update.
>> >> >>
>> >> >> I think this config schema makes sense, but just a (I think import=
ant)
>> >> >> comment on the "how" not "what" of it. It's really much better to =
define
>> >> >> config as:
>> >> >>
>> >> >>     [some]
>> >> >>     key =3D value
>> >> >>     key =3D value2
>> >> >>
>> >> >> Than:
>> >> >>
>> >> >>     [some]
>> >> >>     key =3D value,value2
>> >> >>
>> >> >> The reason is that "git config" has good support for working with
>> >> >> multi-valued stuff, so you can do e.g.:
>> >> >>
>> >> >>     git config --get-all -z some.key
>> >> >>
>> >> >> And you can easily (re)set such config e.g. with --replace-all etc=
., but
>> >> >> for comma-delimited you (and users) need to do all that work thems=
elves.
>> >> >>
>> >> >> Similarly instead of:
>> >> >>
>> >> >>     some.key =3D want-this
>> >> >>     some.key =3D -not-this
>> >> >>     some.key =3D but-want-this
>> >> >>
>> >> >> I think it's better to just have two lists, one inclusive another
>> >> >> exclusive. E.g. see "log.decorate" and "log.excludeDecoration",
>> >> >> "transfer.hideRefs"
>> >> >>
>> >> >> Which would mean:
>> >> >>
>> >> >>     core.fsync =3D want-this
>> >> >>     core.fsyncExcludes =3D -not-this
>> >> >>
>> >> >> For some value of "fsyncExcludes", maybe "noFsync"? Anyway, just a
>> >> >> suggestion on making this easier for users & the implementation.
>> >> >>
>> >> >
>> >> > Maybe there's some way to handle this I'm unaware of, but a
>> >> > disadvantage of your multi-valued config proposal is that it's hard=
er,
>> >> > for example, for a per-repo config store to reasonably override a
>> >> > per-user config store.  With the configuration scheme as-is, I can
>> >> > have a per-user setting like `core.fsync=3Dall` which covers my typ=
ical
>> >> > repos, but then have a maintainer repo with a private setting of
>> >> > `core.fsync=3Dnone` to speed up cases where I'm mostly working with
>> >> > other people's changes that are backed up in email or server-side
>> >> > repos.  The latter setting conveniently overrides the former setting
>> >> > in all aspects.
>> >>
>> >> Even if you turn just your comma-delimited proposal into a list propo=
sal
>> >> can't we just say that the last one wins? Then it won't matter what c=
mae
>> >> before, you'd specify "core.fsync=3Dnone" in your local .git/config.
>> >>
>> >> But this is also a general issue with a bunch of things in git's conf=
ig
>> >> space. I'd rather see us use the list-based values and just come up w=
ith
>> >> some general way to reset them that works for all keys, rather than
>> >> regretting having comma-delimited values that'll be harder to work wi=
th
>> >> & parse, which will be a legacy wart if/when we come up with a way to
>> >> say "reset all previous settings".
>> >>
>> >> > Also, with the core.fsync and core.fsyncExcludes, how would you spe=
ll
>> >> > "don't sync anything"? Would you still have the aggregate options.?
>> >>
>> >>     core.fsyncExcludes =3D *
>> >>
>> >> I.e. the same as the core.fsync=3Dnone above, anyway I still like the
>> >> wildcard thing below a bit more...
>> >
>> > I'm not going to take this feedback unless there are additional votes
>> > from the Git community in this direction.  I make the claim that
>> > single-valued comma-separated config lists are easier to work with in
>> > the existing Git infrastructure.
>>
>> Easier in what sense? I showed examples of how "git-config" trivially
>> works with multi-valued config, but for comma-delimited you'll need to
>> write your own shellscript boilerplate around simple things like adding
>> values, removing existing ones etc.
>>
>> I.e. you can use --add, --unset, --unset-all, --get, --get-all etc.
>>
>
> I see what you're saying for cases where someone would want to set a
> core.fsync setting that's derived from the user's current config.  But
> I'm guessing that the dominant use case is someone setting a new fsync
> configuration that achieves some atomic goal with respect to a given
> repository. Like "this is a throwaway, so sync nothing" or "this is
> really important, so sync all objects and refs and the index".

Whether it's multi-value or comma-separated you could do:

    -c core.fsync=3D[none|false]

To sync nothing, i.e. if we see "none/false" it doesn't matter if we saw
core.fsync=3Dloose-object or whatever before, it would override it, ditto
for "all".

>> > parsing code for the core.whitespace variable and users are used to
>> > this syntax there. There are several other comma-separated lists in
>> > the config space, so this construct has precedence and will be with
>> > Git for some time.
>>
>> That's not really an argument either way for why we'd pick X over Y for
>> something new. We've got some comma-delimited, some multi-value (I'm
>> fairly sure we have more multi-value).
>>
>
> My main point here is that there's precedent for patch's current exact
> schema for a config in the same core config leaf of the Documentation.
> It seems from your comments that we'd have to invent and document some
> new convention for "reset" of a multi-valued config.  So you're
> suggesting that I solve an extra set of problems to get this change
> in.  Just want to remind you that my personal itch to scratch is to
> get the underlying mechanism in so that git-for-windows can set its
> default setting to batch mode. I'm not expecting many users to
> actually configure this setting to any non-default value.

Me neither. I think people will most likely set this once in
~/.gitconfig or /etc/gitconfig.

We have some config keys that are multi-value and either comma-separated
or space-separated, e.g. core.alternateRefsPrefixes

Then we have e.g. blame.ignoreRevsFile which is multi-value, and further
has the convention that setting it to an empty value clears the
list. which would scratch the "override existing" itch.

format.notes, versionsort.suffix, transfer.hideRefs, branch.<name>.merge
are exmples of existing multi-value config.

>> > Also, fsync configurations aren't composable like
>> > some other configurations may be. It makes sense to have a holistic
>> > singular fsync configuration, which is best represented by a single
>> > variable.
>>
>> What's a "variable" here? We call these "keys", you can have a
>> single-value key like user.name that you get with --get, or a
>> multi-value key like say branch.<name>.merge or push.pushOption that
>> you'd get with --get-all.
>
> Yeah, I meant "key".  I conflated the config key with the underlying
> global variable in git.

*nod*

>> I think you may be referring to either not wanting these to be
>> "inherited" (which is not really a think we do for anything else in
>> config), or lacking the ability to "reset".
>>
>> For the latter if that's absolutely needed we could just use the same
>> trick as "diff.wsErrorHighlight" uses of making an empty value "reset"
>> the list, and you'd get better "git config" support for editing it.
>>
>
> My reading of the code is that diff.wsErrorHighlight is a comma
> separated list and not a multi-valued config.  Actually I haven't yet
> found an existing multi-valued config (not sure how to grep for it).

Yes, I think I conflated it with one of the ones above when I wrote
this.

>> >> >> > This also supports the common request of doing absolutely no
>> >> >> > fysncing with the `core.fsync=3Dnone` value, which is expected
>> >> >> > to make the test suite faster.
>> >> >>
>> >> >> Let's just use the git_parse_maybe_bool() or git_parse_maybe_bool_=
text()
>> >> >> so we'll accept "false", "off", "no" like most other such config?
>> >> >
>> >> > Junio's previous feedback when discussing batch mode [1] was to off=
er
>> >> > less flexibility when parsing new values of these configuration
>> >> > options. I agree with his statement that "making machine-readable
>> >> > tokens be spelled in different ways is a 'disease'."  I'd like to
>> >> > leave this as-is so that the documentation can clearly state the ex=
act
>> >> > set of allowable values.
>> >> >
>> >> > [1] https://lore.kernel.org/git/xmqqr1dqzyl7.fsf@gitster.g/
>> >>
>> >> I think he's talking about batch, Batch, BATCH, bAtCh etc. there. But
>> >> the "maybe bool" is a stanard pattern we use.
>> >>
>> >> I don't think we'd call one of these 0, off, no or false etc. to avoid
>> >> confusion, so then you can use git_parse_maybe_...()
>> >
>> > I don't see the advantage of having multiple ways of specifying
>> > "none".  The user can read the doc and know exactly what to write.  If
>> > they write something unallowable, they get a clear warning and they
>> > can read the doc again to figure out what to write.  This isn't a
>> > boolean options at all, so why should we entertain bool-like ways of
>> > spelling it?
>>
>> It's not boolean, it's multi-value and one of the values includes a true
>> or false boolean value. You just spell it "none".
>>
>> I think both this and your comment above suggest that you think there's
>> no point in this because you haven't interacted with/used "git config"
>> as a command line or API mechanism, but have just hand-crafted config
>> files.
>>
>> That's fair enough, but there's a lot of tooling that benefits from the
>> latter.
>
> My batch mode perf tests (on github, not yet submitted to the list)
> use `git -c core.fsync=3D<foo>` to set up a per-process config.  I
> haven't used the `git config` writing support in a while, so I haven't
> deeply thought about that.  However, I favor simplifying the use case
> of "atomically" setting a new holistic core.fsync value versus the use
> case of deriving a new core.fsync value from the preexisting value.

If you implement it like blame.ignoreRevsFile you can have your cake and
eat it too, i.e.:

    -c core.fsync=3D core.fsync=3Dloose-object

ensures only loose objects are synced, as with your single-value config,
but I'd think what you'd be more likely to actually mean would be:

    # With "core.fsync=3Dpack" set in ~/.gitconfig
    -c core.fsync=3Dloose-object

I.e. that the common case is "I want this to be synced here", not that
you'd like to declare sync policy from scratch every time.

In any case, on this general topic my main point is that the
git-config(1) command has pretty integration for multi-value if you do
it that way, and not for comma-delimited. I.e. you get --add, --unset,
--unset-all, --get, --get-all etc.

So I think for anything new it makes sense to lean into that, I think
most of these existing comma-delimited ones are ones we'd do differently
today on reflection.

And if you suppor the "empty resets" like blame.ignoreRevsFile it seems
to me you'll have your cake & eat it too.

>> E.g.:
>>
>>     $ git -c core.fsync=3Doff config --type=3Dbool core.fsync
>>     false
>>     $ git -c core.fsync=3Dblah config --type=3Dbool core.fsync
>>     fatal: bad boolean config value 'blah' for 'core.fsync'
>>
>> Here we can get 'git config' to normalize what you call 'none', and you
>> can tell via exit codes/normalization if it's "false". But if you invent
>> a new term for "false" you can't do that as easily.
>>
>> We have various historical keys that take odd exceptions to that,
>> e.g. "never", but unless we have a good reason to let's not invent more
>> exceptions.
>>
>> >> >> > Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
>> >> >> > ---
>> >> >> >  Documentation/config/core.txt | 27 +++++++++----
>> >> >> >  builtin/fast-import.c         |  2 +-
>> >> >> >  builtin/index-pack.c          |  4 +-
>> >> >> >  builtin/pack-objects.c        |  8 ++--
>> >> >> >  bulk-checkin.c                |  5 ++-
>> >> >> >  cache.h                       | 39 +++++++++++++++++-
>> >> >> >  commit-graph.c                |  3 +-
>> >> >> >  config.c                      | 76 ++++++++++++++++++++++++++++=
++++++-
>> >> >> >  csum-file.c                   |  5 ++-
>> >> >> >  csum-file.h                   |  3 +-
>> >> >> >  environment.c                 |  1 +
>> >> >> >  midx.c                        |  3 +-
>> >> >> >  object-file.c                 |  3 +-
>> >> >> >  pack-bitmap-write.c           |  3 +-
>> >> >> >  pack-write.c                  | 13 +++---
>> >> >> >  read-cache.c                  |  2 +-
>> >> >> >  16 files changed, 164 insertions(+), 33 deletions(-)
>> >> >> >
>> >> >> > diff --git a/Documentation/config/core.txt b/Documentation/confi=
g/core.txt
>> >> >> > index dbb134f7136..4f1747ec871 100644
>> >> >> > --- a/Documentation/config/core.txt
>> >> >> > +++ b/Documentation/config/core.txt
>> >> >> > @@ -547,6 +547,25 @@ core.whitespace::
>> >> >> >    is relevant for `indent-with-non-tab` and when Git fixes `tab=
-in-indent`
>> >> >> >    errors. The default tab width is 8. Allowed values are 1 to 6=
3.
>> >> >> >
>> >> >> > +core.fsync::
>> >> >> > +     A comma-separated list of parts of the repository which sh=
ould be
>> >> >> > +     hardened via the core.fsyncMethod when created or modified=
. You can
>> >> >> > +     disable hardening of any component by prefixing it with a =
'-'. Later
>> >> >> > +     items take precedence over earlier ones in the list. For e=
xample,
>> >> >> > +     `core.fsync=3Dall,-pack-metadata` means "harden everything=
 except pack
>> >> >> > +     metadata." Items that are not hardened may be lost in the =
event of an
>> >> >> > +     unclean system shutdown.
>> >> >> > ++
>> >> >> > +* `none` disables fsync completely. This must be specified alon=
e.
>> >> >> > +* `loose-object` hardens objects added to the repo in loose-obj=
ect form.
>> >> >> > +* `pack` hardens objects added to the repo in packfile form.
>> >> >> > +* `pack-metadata` hardens packfile bitmaps and indexes.
>> >> >> > +* `commit-graph` hardens the commit graph file.
>> >> >> > +* `objects` is an aggregate option that includes `loose-objects=
`, `pack`,
>> >> >> > +  `pack-metadata`, and `commit-graph`.
>> >> >> > +* `default` is an aggregate option that is equivalent to `objec=
ts,-loose-object`
>> >> >> > +* `all` is an aggregate option that syncs all individual compon=
ents above.
>> >> >> > +
>> >> >>
>> >> >> It's probably a *bit* more work to set up, but I wonder if this wo=
uldn't
>> >> >> be simpler if we just said (and this is partially going against wh=
at I
>> >> >> noted above):
>> >> >>
>> >> >> =3D=3D BEGIN DOC
>> >> >>
>> >> >> core.fsync is a multi-value config variable where each item is a
>> >> >> pathspec that'll get matched the same way as 'git-ls-files' et al.
>> >> >>
>> >> >> When we sync pretend that a path like .git/objects/de/adbeef... is
>> >> >> relative to the top-level of the git
>> >> >> directory. E.g. "objects/de/adbeaf.." or "objects/pack/...".
>> >> >>
>> >> >> You can then supply a list of wildcards and exclusions to configure
>> >> >> syncing.  or "false", "off" etc. to turn it off. These are synonym=
ous
>> >> >> with:
>> >> >>
>> >> >>     ; same as "false"
>> >> >>     core.fsync =3D ":!*"
>> >> >>
>> >> >> Or:
>> >> >>
>> >> >>     ; same as "true"
>> >> >>     core.fsync =3D "*"
>> >> >>
>> >> >> Or, to selectively sync some things and not others:
>> >> >>
>> >> >>     ;; Sync objects, but not "info"
>> >> >>     core.fsync =3D ":!objects/info/**"
>> >> >>     core.fsync =3D "objects/**"
>> >> >>
>> >> >> See gitrepository-layout(5) for details about what sort of paths y=
ou
>> >> >> might be expected to match. Not all paths listed there will go thr=
ough
>> >> >> this mechanism (e.g. currently objects do, but nothing to do with =
config
>> >> >> does).
>> >> >>
>> >> >> We can and will match this against "fake paths", e.g. when writing=
 out
>> >> >> packs we may match against just the string "objects/pack", we're n=
ot
>> >> >> going to re-check if every packfile we're writing matches your glo=
bs,
>> >> >> ditto for loose objects. Be reasonable!
>> >> >>
>> >> >> This metharism is intended as a shorthand that provides some flexi=
bility
>> >> >> when fsyncing, while not forcing git to come up with labels for all
>> >> >> paths the git dir, or to support crazyness like "objects/de/adbeef=
*"
>> >> >>
>> >> >> More paths may be added or removed in the future, and we make no
>> >> >> promises that we won't move things around, so if in doubt use
>> >> >> e.g. "true" or a wide pattern match like "objects/**". When in dou=
bt
>> >> >> stick to the golden path of examples provided in this documentatio=
n.
>> >> >>
>> >> >> =3D=3D END DOC
>> >> >>
>> >> >>
>> >> >> It's a tad more complex to set up, but I wonder if that isn't worth
>> >> >> it. It nicely gets around any current and future issues of decidin=
g what
>> >> >> labels such as "loose-object" etc. to pick, as well as slotting in=
to an
>> >> >> existing method of doing exclude/include lists.
>> >> >>
>> >> >
>> >> > I think this proposal is a lot of complexity to avoid coming up wit=
h a
>> >> > new name for syncable things as they are added to Git.  A path based
>> >> > mechanism makes it hard to document for the (advanced) user what the
>> >> > full set of things is and how it might change from release to relea=
se.
>> >> > I think the current core.fsync scheme is a bit easier to understand,
>> >> > query, and extend.
>> >>
>> >> We document it in gitrepository-layout(5). Yeah it has some
>> >> disadvantages, but one advantage is that you could make the
>> >> composability easy. I.e. if last exclude wins then a setting of:
>> >>
>> >>     core.fsync =3D ":!*"
>> >>     core.fsync =3D "objects/**"
>> >>
>> >> Would reset all previous matches & only match objects/**.
>> >>
>> >
>> > The value of changing this is predicated on taking your previous
>> > multi-valued config proposal, which I'm still not at all convinced
>> > about.
>>
>> They're orthagonal. I.e. you get benefits from multi-value with or
>> without this globbing mechanism.
>>
>> In any case, I don't feel strongly about/am really advocating this
>> globbing mechanism. I just wondered if it wouldn't make things simpler
>> since it would sidestep the need to create any sort of categories for
>> subsets of gitrepository-layout(5), but maybe not...
>>
>> > The schema in the current (v1-v2) version of the patch already
>> > includes an example of extending the list of syncable things, and
>> > Patrick Steinhardt made it clear that he feels comfortable adding
>> > 'refs' to the same schema in a future change.
>> >
>> > I'll also emphasize that we're talking about a non-functional,
>> > relatively corner-case behavioral configuration.  These values don't
>> > change how git's interface behaves except when the system crashes
>> > during a git command or shortly after one completes.
>>
>> That may be something some OS's promise, but it's not something fsync()
>> or POSIX promises. I.e. you might write a ref, but unless you fsync and
>> the relevant dir entries another process might not see the update, crash
>> or not.
>>
>
> I haven't seen any indication that POSIX requires an fsync for
> visiblity within a running system.  I looked at the doc for open,
> write, and fsync, and saw no indication that it's posix compliant to
> require an fsync for visibility.  I think an OS that required fsync
> for cross-process visiblity would fail to run Git for a myriad of
> other reasons and would likely lose all its users.  I'm curious where
> you've seen documentation that allows such unhelpful behavior?

There's multiple unrelated and related things in this area. One is a
case where you'll e.g. write a file "foo" using stdio, spawn a program
to work on it in the same program, but it might not see it at all, or
see empty content, the latter being because you haven't flushed your I/O
buffers (which you can do via fsync()).

The former is that on *nix systems you're generally only guaranteed to
write to a fd, but not to have the associated metadata be synced for
you.

That is spelled out e.g. in the DESCRIPTION section of linux's fsync()
manpage: https://man7.org/linux/man-pages/man2/fdatasync.2.html

I don't know how much you follow non-Windows FS development, but there
was also a very well known "incident" early in ext4 where it leaned into
some permissive-by-POSIX behavior that caused data loss in practice on
buggy programs that didn't correctly use fsync() , since various tooling
had come to expect the stricter behavior of ext3:
https://lwn.net/Articles/328363/

That was explicitly in the area of fs metadata being discussed here.

Generally you can expect your VFS layer to be forgiving when it comes to
IPC, but even that is out the window when it comes to networked
filesystems, e.g. a shared git repository hosted on NFS.

>> That's an aside from these config design questions, and I think
>> most/(all?) OS's anyone cares about these days tend to make that
>> implicit promise as part of their VFS behavior, but we should probably
>> design such an interface to fsync() with such pedantic portability in
>> mind.
>
> Why? To be rude to such a hypothetical system, if a system were so
> insanely designed, it would be nuts to support it.

Because we know that right now the system calls we're invoking aren't
guaranteed to store data persistently to disk portably, although they do
so in practice on most modern OS's.

We're portably to a lot of platforms, and also need to keep e.g. NFS in
mind, so being able to ask for a pedantic mode when you care about data
retention at the cost of performance would be nice.

And because the fsync config mode you're proposing is thoroughly
non-standard, but is known to me much faster by leaning into known
attributes of specific FS's on specific OS's, if we're not running on
those it would be sensible to fall back to a stricter mode of
operation. E.g. syncing all 100 loose objects we just wrote, not just
the last one.

>> > While you may not personally love the proposed configuration
>> > interface, I'd want your view on some questions:
>> > 1. Is it easy for the (advanced) user to set a configuration?
>> > 2. Is it easy for the (advanced) user to see what was configured?
>> > 3. Is it easy for the Git community to build on this as we want to add
>> > things to the list of things to sync?
>> >     a) Is there a good best practice configuration so that people can
>> > avoid losing integrity for new stuff that they are intending to sync.
>> >     b) If someone has a custom configuration, can that custom
>> > configuration do something reasonable as they upgrade versions of Git?
>> >              ** In response to this question, I might see some value
>> > in adding a 'derived-metadata' aggregate that can be disabled so that
>> > a custom configuration can exclude those as they change version to
>> > version.
>> >     c) Is it too much maintenance overhead to consider how to present
>> > this configuration knob for any new hashfile or other datafile in the
>> > git repo?
>> > 4. Is there a good path forward to change the default syncable set,
>> > both in git-for-windows and in Git for other platforms?
>>
>> I'm not really sure this globbing this is a good idea, as noted above
>> just a suggestion etc.
>>
>> As noted there it just gets you out of the business of re-defining
>> gitrepository-layout(5), and assuming too much in advance about certain
>> use-cases.
>>
>> E.g. even "refs" might be too broad for some. I don't tend to be I/O
>> limited, but I could see how someone who would be would care about
>> refs/heads but not refs/remotes, or want to exclude logs/* but not the
>> refs updates themselves etc.
>
> This use-case is interesting (distinguishing remote refs from local
> refs).  I think the difficulty of verifying (for even an advanced
> user) that the right fsyncing is actually happening still puts me on
> the side of having a carefully curated and documented set of syncable
> things rather than a file-path-based mechanism.
>
> Is this meaningful in the presumably nearby future world of the refsdb
> backend?  Is that somehow split by remote versus local?

There is the upcoming "reftable" work, but that's probably 2-3 years out
at the earliest for series production workloads in git.git.

>> >> >> > diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
>> >> >> > index 857be7826f3..916c55d6ce9 100644
>> >> >> > --- a/builtin/pack-objects.c
>> >> >> > +++ b/builtin/pack-objects.c
>> >> >> > @@ -1204,11 +1204,13 @@ static void write_pack_file(void)
>> >> >> >                * If so, rewrite it like in fast-import
>> >> >> >                */
>> >> >> >               if (pack_to_stdout) {
>> >> >> > -                     finalize_hashfile(f, hash, CSUM_HASH_IN_ST=
REAM | CSUM_CLOSE);
>> >> >> > +                     finalize_hashfile(f, hash, FSYNC_COMPONENT=
_NONE,
>> >> >> > +                                       CSUM_HASH_IN_STREAM | CS=
UM_CLOSE);
>> >> >>
>> >> >> Not really related to this per-se, but since you're touching the A=
PI
>> >> >> everything goes through I wonder if callers should just always try=
 to
>> >> >> fsync, and we can just catch EROFS and EINVAL in the wrapper if so=
meone
>> >> >> tries to flush stdout, or catch the fd at that lower level.
>> >> >>
>> >> >> Or maybe there's a good reason for this...
>> >> >
>> >> > It's platform dependent, but I'd expect fsync would do something for
>> >> > pipes or stdout redirected to a file.  In these cases we really don=
't
>> >> > want to fsync since we have no idea what we're talking to and we're
>> >> > potentially worsening performance for probably no benefit.
>> >>
>> >> Yeah maybe we should just leave it be.
>> >>
>> >> I'd think the C library returning EINVAL would be a trivial performan=
ce
>> >> cost though.
>> >>
>> >> It just seemed odd to hardcode assumptions about what can and can't be
>> >> synced when the POSIX defined function will also tell us that.
>> >>
>> >
>> > Redirecting stdout to a file seems like a common usage for this
>> > command. That would definitely be fsyncable, but Git has no idea what
>> > its proper category is since there's no way to know the purpose or
>> > lifetime of the packfile.  I'm going to leave this be, because I'd
>> > posit that "can it be fsynced?" is not the same as "should it be
>> > fsynced?".  The latter question can't be answered for stdout.
>>
>> As noted this was just an aside, and I don't even know if any OS would
>> do anything meaningful with an fsync() of such a FD anyway.
>>
>
> The underlying fsync primitive does have a meaning on Windows for
> pipes, but it's certainly not what Git would want to do. Also if
> stdout is redirected to a file, I'm pretty sure that UNIX OSes would
> respect the fsync call.  However it's not meaningful in the sense of
> the git repository, since we don't know what the packfile is or why it
> was created.

I suggested that because I think it's probably nonsensical, but it's
nonsense that POSIX seems to explicitly tell us that it'll handle
(probably by silently doing nothing). So in terms of our interface we
could lean into that and avoid our own special-casing.

>> I just don't see why we wouldn't say:
>>
>>  1. We're syncing this category of thing
>>  2. Try it
>>  3. If fsync returns "can't fsync that sort of thing" move on
>>
>> As opposed to trying to shortcut #3 by doing the detection ourselves.
>>
>> I.e. maybe there was a good reason, but it seemed to be some easy
>> potential win for more simplification, since you were re-doing and
>> simplifying some of the interface anyway...
>
> We're trying to be deliberate about what we're fsyncing.  Fsyncing an
> unknown file created by the packfile code doesn't move us in that
> direction.  In your taxonomy we don't know (1), "what is this category
> of thing?"  Sure it's got the packfile format, but is not known to be
> an actual packfile that's part of the repository.

We know it's a fd, isn't that sufficient? In any case, I'm fine with
also keeping it as is, I don't mean to split hairs here.

It just stuck out as an odd part of the interface, why treat some fd's
specially, instead of just throwing it all at the OS. Presumably the
first thing the OS will do is figure out if it's a syncable fd or not,
and act appropriately.

>> >>
>> >> >> > [...]
>> >> >> > +/*
>> >> >> > + * These values are used to help identify parts of a repository=
 to fsync.
>> >> >> > + * FSYNC_COMPONENT_NONE identifies data that will not be a pers=
istent part of the
>> >> >> > + * repository and so shouldn't be fsynced.
>> >> >> > + */
>> >> >> > +enum fsync_component {
>> >> >> > +     FSYNC_COMPONENT_NONE                    =3D 0,
>> >> >>
>> >> >> I haven't read ahead much but in most other such cases we don't de=
fine
>> >> >> the "=3D 0", just start at 1<<0, then check the flags elsewhere...
>> >> >>
>> >> >> > +static const struct fsync_component_entry {
>> >> >> > +     const char *name;
>> >> >> > +     enum fsync_component component_bits;
>> >> >> > +} fsync_component_table[] =3D {
>> >> >> > +     { "loose-object", FSYNC_COMPONENT_LOOSE_OBJECT },
>> >> >> > +     { "pack", FSYNC_COMPONENT_PACK },
>> >> >> > +     { "pack-metadata", FSYNC_COMPONENT_PACK_METADATA },
>> >> >> > +     { "commit-graph", FSYNC_COMPONENT_COMMIT_GRAPH },
>> >> >> > +     { "objects", FSYNC_COMPONENTS_OBJECTS },
>> >> >> > +     { "default", FSYNC_COMPONENTS_DEFAULT },
>> >> >> > +     { "all", FSYNC_COMPONENTS_ALL },
>> >> >> > +};
>> >> >> > +
>> >> >> > +static enum fsync_component parse_fsync_components(const char *=
var, const char *string)
>> >> >> > +{
>> >> >> > +     enum fsync_component output =3D 0;
>> >> >> > +
>> >> >> > +     if (!strcmp(string, "none"))
>> >> >> > +             return output;
>> >> >> > +
>> >> >> > +     while (string) {
>> >> >> > +             int i;
>> >> >> > +             size_t len;
>> >> >> > +             const char *ep;
>> >> >> > +             int negated =3D 0;
>> >> >> > +             int found =3D 0;
>> >> >> > +
>> >> >> > +             string =3D string + strspn(string, ", \t\n\r");
>> >> >>
>> >> >> Aside from the "use a list" isn't this hardcoding some windows-spe=
cific
>> >> >> assumptions with \n\r? Maybe not...
>> >> >
>> >> > I shamelessly stole this code from parse_whitespace_rule. I thought
>> >> > about making a helper to be called by both functions, but the amount
>> >> > of state going into and out of the wrapper via arguments was
>> >> > substantial and seemed to negate the benefit of deduplication.
>> >>
>> >> FWIW string_list_split() is easier to work with in those cases, or at
>> >> least I think so...
>> >
>> > This code runs at startup for a variable that may be present on some
>> > installations.  The nice property of the current patch's code is that
>> > it's already a well-tested pattern that doesn't do any allocations as
>> > it's working, unlike string_list_split().
>>
>> Multi-value config would also get you fewer allocations :)
>>
>> Anyway, I mainly meant to point out that for stuff like this it's fine
>> to optimize it for ease rather than micro-optimize allocations. Those
>> really aren't a bottleneck on this scale.
>>
>> Even in that case there's string_list_split_in_place(), which can be a
>> bit nicer than manual C-string fiddling.
>>
>
> Am I allowed to change the config value string in place? The
> core.whitespace code is careful not to modify the string. I kind of
> like the parse_ws_error_highlight code a little better now that I've
> seen it, but I think the current code is fine too.

I don't remember offhand if that's safe, probably not. So you'll need a
copy here.

>> > I hope you know that I appreciate your review feedback, even though
>> > I'm pushing back on most of it so far this round. I'll be sending v3
>> > to the list soon after giving it another look over.
>>
>> Sure, no worries. Just hoping to help. If you go for something different
>> etc. that's fine. Just hoping to bridge the gap in some knowledge /
>> offer potentially interesting suggestions (some of which may be dead
>> ends, like the config glob thing...).
