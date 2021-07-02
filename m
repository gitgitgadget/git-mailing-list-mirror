Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29AFBC07E95
	for <git@archiver.kernel.org>; Fri,  2 Jul 2021 21:59:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7DB0613FC
	for <git@archiver.kernel.org>; Fri,  2 Jul 2021 21:59:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbhGBWBe (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jul 2021 18:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbhGBWBd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jul 2021 18:01:33 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71CC3C061762
        for <git@vger.kernel.org>; Fri,  2 Jul 2021 14:58:59 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id c12-20020a9d684c0000b029047762db628aso7494120oto.13
        for <git@vger.kernel.org>; Fri, 02 Jul 2021 14:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=oTeDs7QSrru96rXb+CHs8fd7MrLtDK4gFi4bZDBmvVM=;
        b=FRFThOAnnYDKGwhAoZXP8/Ruvc1Kx/5/Q59gGYPGEwzFq9eOP20fhGpCd3Qo6kT5kh
         nvbHGwASok+RCi3pwJlEqQwbbb+Lrt3Czm84eTg6ZlONlWC91aIVFzSkfBEojQ/yee7k
         xIiQ3vik83HEkpfeVjoAp8rdo8VHiCGz4A2WqRK0eXdqGuy20U6KWMSJmauluk2UDHHG
         khDsYANIQliJzRSDe+OP0T5O4bWDLD1tLcB85PAyESOlBYga/gzsOe6vcjUObTjQxTu9
         CsvyFpdF8tQTaMWaqeMzNHXMNozA4v6qkWgD4ODLO1yNq5CrNwB+FCP0AcyEJoKBlQDA
         hwGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=oTeDs7QSrru96rXb+CHs8fd7MrLtDK4gFi4bZDBmvVM=;
        b=ehgUahiV/DGYVhw0Zvp90ryYiqpJ3pVSBjlNl4opDq3PHHwi93xt8qtfTqzszD9h+x
         JpZoYPqBI3eDxw8Ubhc2rJkhxLIDCESVHZP/NwM55AWTuEwnJzXN3gnGwIvKxoKyTWir
         p3w2HsFIw0ldBASY5cFQUyqVsDaExo5KVFihiQfKKKvw8GfZObAPfaKGovjIBdmPVENz
         Vp5EueL8hPbmrtBRNFGpUkhyGnjerkW6ZlakPjMXYQk9YFqzbBhnVeSikPtq84CUAiQT
         Ted4kFDi/uljcJyCr3nN10A6aAgmrYgWyxv1KbgDER0kv90P6SsVDYF76VdKtSmh7E2I
         hBvg==
X-Gm-Message-State: AOAM5320ibG4JpqckiHOgZ1IW3xGS4NfkKz0VzQo3RrcU3VxHoHOpd0r
        PB0v4uaACaZ6ga3g9r+nIlU=
X-Google-Smtp-Source: ABdhPJwcrgPf3v/NX+HGsz1Nc9Q7k92Ai8HLJ1PQbLehjBSmEX+KZN51sCcXDwCGiLvPkjXBgnwT3A==
X-Received: by 2002:a9d:67c1:: with SMTP id c1mr1066103otn.51.1625263138617;
        Fri, 02 Jul 2021 14:58:58 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id l7sm825165otu.76.2021.07.02.14.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jul 2021 14:58:58 -0700 (PDT)
Date:   Fri, 02 Jul 2021 16:58:56 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Message-ID: <60df8c20e8518_28bb20846@natae.notmuch>
In-Reply-To: <8735sxaqln.fsf@evledraar.gmail.com>
References: <20210702100506.1422429-1-felipe.contreras@gmail.com>
 <20210702100506.1422429-6-felipe.contreras@gmail.com>
 <8735sxaqln.fsf@evledraar.gmail.com>
Subject: Re: [PATCH 5/5] config: add default aliases
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> =

> On Fri, Jul 02 2021, Felipe Contreras wrote:
> =

> > These are all the aliases everyone agrees are essential.
> >
> > Virtually all VCS in the world have aliases, except git, so let's cha=
nge
> > that.
> >
> > Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> > ---
> >  Documentation/git-branch.txt      |  4 ++++
> >  Documentation/git-cherry-pick.txt |  4 ++++
> >  Documentation/git-commit.txt      |  4 ++++
> >  Documentation/git-mergetool.txt   |  4 ++++
> >  Documentation/git-rebase.txt      |  4 ++++
> >  Documentation/git-status.txt      |  4 ++++
> >  config.c                          | 29 +++++++++++++++++++++++++++++=

> >  config.h                          |  3 ++-
> >  t/test-lib.sh                     |  2 ++
> >  9 files changed, 57 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.=
txt
> > index 94dc9a54f2..fbf5ebd27a 100644
> > --- a/Documentation/git-branch.txt
> > +++ b/Documentation/git-branch.txt
> > @@ -24,6 +24,10 @@ SYNOPSIS
> >  'git branch' (-d | -D) [-r] <branchname>...
> >  'git branch' --edit-description [<branchname>]
> >  =

> > +ALIAS
> > +~~~~~
> > +'git br'
> =

> I think for these it would be good to explicitly mention the mnemonic, =
e.g.:
> =

> 'git br', git 'br'anch. It's pretty obvious in this case, but not all o=
f
> them.

If we are on `man git-branch(1)`, `git help branch`, or
`git branch --help` I think it's pretty obvious what the alias is for.

Especially since it's right after the synopsis.

FTR all other SCM's specify the alias directly. Perhaps we could even do
'br' instead of 'git br'.

> This also addresses the '"ci" or "co"' discussion downthread
> somewhat, i.e. at least we'll see if we always pick the first two
> letters, or if it's somewhat arbitrary.

How? What would be the mnemonic for 'ci'?

> > +~~~~~
> > +'git pi'
> =

> I've got this this as 'git chrp' locally FWIW, I'd think this would mak=
e
> more sense if it was called 'git pick'.

Yeah, but we are aiming for two letters the only other good option is
'cp' which can be easily confused.

For a past discussion on this alias see [1].

> > +~~~~~
> > +'git co'
> =

> Not going to wade into the downhtread co/ci discussion, except to say
> that this is 'co'mmit, i.e. first two letters, like 'br'anch.

Yeap, so it's straightforward.

> >  'git mergetool' [--tool=3D<tool>] [-y | --[no-]prompt] [<file>...]
> >  =

> > +ALIAS
> > +~~~~~
> > +'git mt'
> =

> Maybe it's just me, but I don't think I've ever used git-mergetool
> directly. I don't think it's worthy of squatting on such a short name.

Huh? How is a user supposed to jump from a merge failing to mergetool?
(or rebase, or cherr-pick)

> > +ALIAS
> > +~~~~~
> > +'git rb'
> =

> So 'r'e'b'ase, not 're'base.

I don't know if 're' makes more sense here.

> >  'git status' [<options>...] [--] [<pathspec>...]
> >  =

> > +ALIAS
> > +~~~~~
> > +'git st'
> =

> FWIW I've got this aliased to 'git status --short', anyway, 'st'atus, s=
o
> first two letters...

Me too. Actually --short --branch.

> > +static int git_config_default(config_fn_t fn, void *data)
> > +{
> > +	int ret =3D 0;
> > +	struct config_source source;
> > +
> > +	if (getenv("GIT_NO_DEFAULT_ALIASES"))
> > +		return 0;
> =

> Can't we just include this under GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS?=

> Maybe rename it to GIT_TEST_DISALLOW_ABBREVIATED now that the "OPTIONS"=

> part is considered inaccurate.

Fine by me.

> > +	memset(&source, 0, sizeof(source));
> > +	source.prev =3D cf;
> > +	source.origin_type =3D CONFIG_ORIGIN_DEFAULT;
> > +	cf =3D &source;
> > +
> > +	ret +=3D fn("alias.co", "commit", data);
> > +	ret +=3D fn("alias.rb", "rebase", data);
> > +	ret +=3D fn("alias.st", "status", data);
> > +	ret +=3D fn("alias.br", "branch", data);
> > +	ret +=3D fn("alias.pi", "cherry-pick", data);
> > +	ret +=3D fn("alias.mt", "mergetool", data);
> =

> I haven't looked but does this also inject things into the configset
> API, or is it just going to be used by things that do
> git_config_mycommand and fall back on git_config_default?

I'm not sure what you mean. But it's basically as if you have them in
a config file.

Initially I used a diffent approach but the bash completion did not pick
them up. This is as close to a config file as possible.

> >  static int config_parse_pair(const char *key, const char *value,
> >  			  config_fn_t fn, void *data)
> >  {
> > @@ -1897,6 +1921,9 @@ static int do_git_config_sequence(const struct =
config_options *opts,
> >  		repo_config =3D NULL;
> >  =

> >  	current_parsing_scope =3D CONFIG_SCOPE_SYSTEM;
> > +
> > +	git_config_default(fn, data);
> > +
> >  	if (git_config_system() && system_config &&
> >  	    !access_or_die(system_config, R_OK,
> >  			   opts->system_gently ? ACCESS_EACCES_OK : 0))
> > @@ -3497,6 +3524,8 @@ const char *current_config_origin_type(void)
> >  		return "submodule-blob";
> >  	case CONFIG_ORIGIN_CMDLINE:
> >  		return "command line";
> > +	case CONFIG_ORIGIN_DEFAULT:
> > +		return "default";
> >  	default:
> >  		BUG("unknown config origin type");
> >  	}
> =

> Ah, this is likely it, do we incclude this in 'git config -l' etc? =


Yes. Just like all other configurations.

> > diff --git a/config.h b/config.h
> > index 9038538ffd..bc3ecca313 100644
> > --- a/config.h
> > +++ b/config.h
> > @@ -58,7 +58,8 @@ enum config_origin_type {
> >  	CONFIG_ORIGIN_FILE,
> >  	CONFIG_ORIGIN_STDIN,
> >  	CONFIG_ORIGIN_SUBMODULE_BLOB,
> > -	CONFIG_ORIGIN_CMDLINE
> > +	CONFIG_ORIGIN_CMDLINE,
> > +	CONFIG_ORIGIN_DEFAULT
> >  };
> >  =

> >  enum config_event_t {
> > diff --git a/t/test-lib.sh b/t/test-lib.sh
> > index 49b80a4eb5..a15965e2f4 100644
> > --- a/t/test-lib.sh
> > +++ b/t/test-lib.sh
> > @@ -456,6 +456,8 @@ GIT_DEFAULT_HASH=3D"${GIT_TEST_DEFAULT_HASH:-sha1=
}"
> >  export GIT_DEFAULT_HASH
> >  GIT_TEST_MERGE_ALGORITHM=3D"${GIT_TEST_MERGE_ALGORITHM:-ort}"
> >  export GIT_TEST_MERGE_ALGORITHM
> > +GIT_NO_DEFAULT_ALIASES=3D1
> > +export GIT_NO_DEFAULT_ALIASES
> >  =

> >  # Tests using GIT_TRACE typically don't want <timestamp> <file>:<lin=
e> output
> >  GIT_TRACE_BARE=3D1
> =

> Really needs more tests.
> =

> We had some other thread where this was discussed where I suggested tha=
t
> we implement some way to include default config. Ah, here it is:
> https://lore.kernel.org/git/87eedj74dr.fsf@evledraar.gmail.com/
> =

> It's more work for this, but I think it would really go a long way to
> addressing the concerns people are going to have about this.
> =

> I think we should not opt-in to this from day one, but have some knob t=
o
> enable including one of those shipped-by-default alias includes. Then
> people could trivially mock svn/cvs or whatever their favorite VCS is,
> and eventually as people vote with their feed we could pick a canonical=

> one.

As I mentioned there the problem is where do we put that file, and how
do we distribute it.

I think it's a cleaner approach, and we should definitely try it, but
ultimately it's not going to change the fact that these aliases should
be part of the distribution, especially if they are mentioned in the man
pages. So it would just be an alternative way of hardcoding them.

[1] https://lore.kernel.org/git/20140421204506.GD5105@thunk.org/

-- =

Felipe Contreras=
