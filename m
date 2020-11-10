Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAE2AC55ABD
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 16:07:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C724207D3
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 16:07:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="iB1SZW+r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730760AbgKJQHG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Nov 2020 11:07:06 -0500
Received: from mout.gmx.net ([212.227.17.22]:51365 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729909AbgKJQHF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Nov 2020 11:07:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1605024421;
        bh=iSGtToZB4PVDersdotOW7ds77XGQMXyCPuwdhSGUveQ=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=iB1SZW+r076n3q/UyciL6T3hS2bKynJcW9QNKa4pM/hhYrMHrT+Hdd4/kdcn9syBt
         +bV4ZyFRsR+SWGH2DidGfQY3KO9Pd2wQ8LA1vaREllkPgSUsyqBV1qAZ994XMfXhDR
         poFad8vlgo75IfDqf5gWDL/h3p6I4Cp7Nvo1S6Gk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.25.62] ([213.196.212.205]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MgvvJ-1k6jjF3K1d-00hPkF; Tue, 10
 Nov 2020 17:07:00 +0100
Date:   Tue, 10 Nov 2020 17:06:59 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: ["BUG"] builtin add-interactive does not honor 'color.diff.
 frag'
In-Reply-To: <20201106170345.GA174555@coredump.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.2011101653330.18437@tvgsbejvaqbjf.bet>
References: <313B8999-1E99-4695-A20D-E48840C30879@gmail.com> <20201106170345.GA174555@coredump.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:mEJRcia/8qNwK3sjVD/1OuTx82jshriPhQPmgCjmw5/zRupE7yW
 DQV3CYLUvGIJLD8Fk1wb9wbmH1vlQxawPRNJt6sZTo9YMFJpiEF7RuFZjJErr5EzarNGTxQ
 91F5UOOMaVHMB+xXQK8Vhihy95mBca6bxbVygeO6S9nM15QTBJoiwk9oMv3XoDlUj6KjcWS
 bZt+ckmny7UR6wNqTTurg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:b57++/yU0Tk=:IjSNlmnV1xhcRgGyYGK78W
 yOqluuQjzyGmRivuJ6zTEErkMSGnlXpeAc9VlYE8rtz9vxhAfXRjqSjAlD4t/FtBXTeA/HYef
 GQHwal/AaI+tt9LO4FeFqP8HpElzlE8VH3BFhIw2wodOr7GExK/8oE00i/WM366/8u3PsGK3N
 kZJlBn4x6uIdz06T28aC7pJtY7k/4R9E+T1ujRBFCsAbutTOs2D/hEdt8hxKkqXPYjZ7M63O/
 /gJ3ZaB7lwtT6G/iPpxOfHiYK/kaFoVVeM3YG9kRczPFYuLS5VrVnIJEZSDq03n5JC0l9KCuL
 j3tHbiP4XsQsR88QjMd64/4IpZDiPYR9zHrYBH+2PDfjjhz6U/X/P9rjdwRYKEQqO0tQRI2yk
 BI0NFGgO0wz+nBCjlMMZj1BCDGnGbZpastMQxeYrECb7RVZjkcNv4hh4+ShOyHmepbb0z1xcK
 8qZbUmqKjVD8ROl7Wx+ijSqduxHGoDjec3+lWdmTf+xwri4wfXMR8PhYMB2DKk8/75OtWZvOz
 LqWte98o4g2I8FQ4QFU04uT303t+zQmuG4zzK1Ue5O8XUtZxHDaNqYx4NPPPTPk1tNpS+aFrI
 jrj8c+KWcvy7DkXOSzkMfkPg3ls+QYZSDy6XxSgrbqIJIVHZe8NEJKtYp64V5PtBza4ZELTAb
 MymCXTnHtu0kXeC2DTjoMbOuIVRlNmbx7TJfm/qXc2gPhAnuZAOcuDSIOIHgU3pXKVQGMl0dB
 0EqpORUbnKaAlGu3Zpq3yPBibTULqOrqddzoMnRK06gFt7whF2ONmtfs7w1svtyz8lz4xxLHH
 TqAmImum1YBfs7bsIf0SWMcgKJ8ZUcEsPTEVYrDMcMG8VnckvRHV5kixym2//YO1Q9UoZREg4
 yTDyAWryrVG83ZLPyesxzGsRD7up09WCY9aO4k9a4=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff & Philippe,

On Fri, 6 Nov 2020, Jeff King wrote:

> On Fri, Nov 06, 2020 at 11:31:32AM -0500, Philippe Blain wrote:
>
> > I tried the builtin add-interactive for the first time today,
> > and noticed a very minor difference with the Perl version.
> > The title says it all.
> >
> > Repro:
> >
> > # Change the default color
> > $ git config color.diff.frag "magenta bold"
> > # Compare
> > $ git add -p
> > # and
> > $ git -c add.interactive.useBuiltin=3Dtrue add -p
> > # I'm on latest master
> > $ git --version
> > git version 2.29.2.154.g7f7ebe054a
>
> It looks like the code in add-interactive.c uses "fraginfo" instead of
> "frag".


Aaargh, yes, I missed that.

> But there's something much more puzzling, which is that it checks
> color.interactive.frag. AFAIK that has never been a valid config option
> (there are some color.interactive.* values, but they are all for
> interactive-specific things).

And that. This is the code in `git-add--interactive.perl`:

=2D- snip --
my $menu_use_color =3D $repo->get_colorbool('color.interactive');
my ($prompt_color, $header_color, $help_color) =3D
        $menu_use_color ? (
                $repo->get_color('color.interactive.prompt', 'bold blue'),
                $repo->get_color('color.interactive.header', 'bold'),
                $repo->get_color('color.interactive.help', 'red bold'),
        ) : ();
my $error_color =3D ();
if ($menu_use_color) {
        my $help_color_spec =3D ($repo->config('color.interactive.help') o=
r
                                'red bold');
        $error_color =3D $repo->get_color('color.interactive.error',
                                        $help_color_spec);
}

my $diff_use_color =3D $repo->get_colorbool('color.diff');
my ($fraginfo_color) =3D
        $diff_use_color ? (
                $repo->get_color('color.diff.frag', 'cyan'),
        ) : ();
my ($diff_plain_color) =3D
        $diff_use_color ? (
                $repo->get_color('color.diff.plain', ''),
        ) : ();
my ($diff_old_color) =3D
        $diff_use_color ? (
                $repo->get_color('color.diff.old', 'red'),
        ) : ();
my ($diff_new_color) =3D
        $diff_use_color ? (
                $repo->get_color('color.diff.new', 'green'),
        ) : ();

my $normal_color =3D $repo->get_color("", "reset");
=2D- snap --

> So something like this seems to go in the right direction (and makes
> your example work):
>
> diff --git a/add-interactive.c b/add-interactive.c
> index a14c0feaa2..1eb69c5160 100644
> --- a/add-interactive.c
> +++ b/add-interactive.c
> @@ -12,10 +12,11 @@
>  #include "prompt.h"
>
>  static void init_color(struct repository *r, struct add_i_state *s,
> +		       const char *section,
>  		       const char *slot_name, char *dst,
>  		       const char *default_color)
>  {
> -	char *key =3D xstrfmt("color.interactive.%s", slot_name);
> +	char *key =3D xstrfmt("color.%s.%s", section, slot_name);
>  	const char *value;
>
>  	if (!s->use_color)
> @@ -40,18 +41,19 @@ void init_add_i_state(struct add_i_state *s, struct =
repository *r)
>  			git_config_colorbool("color.interactive", value);
>  	s->use_color =3D want_color(s->use_color);
>
> -	init_color(r, s, "header", s->header_color, GIT_COLOR_BOLD);
> -	init_color(r, s, "help", s->help_color, GIT_COLOR_BOLD_RED);
> -	init_color(r, s, "prompt", s->prompt_color, GIT_COLOR_BOLD_BLUE);
> -	init_color(r, s, "error", s->error_color, GIT_COLOR_BOLD_RED);
> -	init_color(r, s, "reset", s->reset_color, GIT_COLOR_RESET);
> -	init_color(r, s, "fraginfo", s->fraginfo_color,
> +	init_color(r, s, "interactive", "header", s->header_color, GIT_COLOR_B=
OLD);
> +	init_color(r, s, "interactive", "help", s->help_color, GIT_COLOR_BOLD_=
RED);
> +	init_color(r, s, "interactive", "prompt", s->prompt_color, GIT_COLOR_B=
OLD_BLUE);
> +	init_color(r, s, "interactive", "error", s->error_color, GIT_COLOR_BOL=
D_RED);
> +
> +	init_color(r, s, "diff", "reset", s->reset_color, GIT_COLOR_RESET);
> +	init_color(r, s, "diff", "frag", s->fraginfo_color,
>  		   diff_get_color(s->use_color, DIFF_FRAGINFO));
> -	init_color(r, s, "context", s->context_color,
> +	init_color(r, s, "diff", "context", s->context_color,
>  		diff_get_color(s->use_color, DIFF_CONTEXT));
> -	init_color(r, s, "old", s->file_old_color,
> +	init_color(r, s, "diff", "old", s->file_old_color,
>  		diff_get_color(s->use_color, DIFF_FILE_OLD));
> -	init_color(r, s, "new", s->file_new_color,
> +	init_color(r, s, "diff", "new", s->file_new_color,
>  		diff_get_color(s->use_color, DIFF_FILE_NEW));
>
>  	FREE_AND_NULL(s->interactive_diff_filter);
>
> but that is missing another thing: for historical reasons we allow both
> color.diff.frag and diff.color.frag. TBH, I wouldn't be too sad to see
> us drop support for the historical versions in this setting. But it
> makes me wonder if we could be reusing the parsing from
> git_diff_basic_config(), which handles both cases.

Hmm. The Perl version uses the Git.pm's `get_color()` function, which in
turn invokes `git config --get-color` with the exact keys I pasted above.

All along the way to `builtin/config.c`'s `git_get_color_config()`, I fail
to see any `color.diff`/`diff.color` munging. So I believe that `git add
=2D-interactive` _never_ looked at the `diff.color` section to begin with.

> I'm not entirely clear on how add-interactive.c invokes the diff, and
> whether it would be unhappy to pick up diff config. But it seems like
> this:
>
> diff --git a/builtin/add.c b/builtin/add.c
> index a825887c50..47bb6ea10b 100644
> --- a/builtin/add.c
> +++ b/builtin/add.c
> @@ -362,7 +362,7 @@ static int add_config(const char *var, const char *v=
alue, void *cb)
>  		return 0;
>  	}
>
> -	return git_default_config(var, value, cb);
> +	return git_diff_basic_config(var, value, cb);
>  }
>
>  static const char embedded_advice[] =3D N_(
>
> might be the simplest thing (and drop the extra diff-config parsing from
> add-interactive.c that I was touching above). It does need to be done in
> each program that calls into the add-interactive code though (so
> checkout, etc). Obviously it would be easy for init_add_i_state() to
> make a similar call, though that may open us up to loading the diff
> config twice. I suspect that would probably be OK, but it could lead to
> weirdness if there are any multi-valued config options.

Hmm. I don't like it. So far, we were very careful to keep respecting
`struct repository *r` in the built-in interactive add command. This would
go the exact opposite way.

Combined with the fact that we never supported `diff.color.*` in the
interactive add command anyway, I would rather continue with the first
variant you presented.

A bigger puzzle for me was: why did we not catch that earlier? I vaguely
remember that we introduced _specifically_ code to test coloring, and to
make those test work on Windows (rather than skipping them all).

*clicketyclick* ah, we only tests the menu of `git add -i`, and we do not
even override the colors...

Will try to set aside some time to work on fixing this,
Dscho
