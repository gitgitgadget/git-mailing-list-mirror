From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [RFC/PATCH 04/11] ref-filter: add 'ifexists' atom
Date: Tue, 28 Jul 2015 00:54:52 -0700
Message-ID: <CA+P7+xq_jC=gE3J=PTkVx8BpTRzCJCfU0V-ydBve2FYbg1gmBg@mail.gmail.com>
References: <CAOLa=ZT3_DMJWFN62cbF19uxYBFsE69dGaFR=af1HPKsQ42otg@mail.gmail.com>
 <1438066594-5620-1-git-send-email-Karthik.188@gmail.com> <1438066594-5620-4-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 28 09:55:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZJzjL-00034H-Hp
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jul 2015 09:55:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752691AbbG1HzN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2015 03:55:13 -0400
Received: from mail-ig0-f174.google.com ([209.85.213.174]:35710 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751000AbbG1HzM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2015 03:55:12 -0400
Received: by igr7 with SMTP id 7so105686438igr.0
        for <git@vger.kernel.org>; Tue, 28 Jul 2015 00:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=ekaVFGPAAS0wH1YXV9BWmgTLg0VJkEaVMIVF+Opy7Tw=;
        b=wuA0+jnRQhoKvnOmh7OqTzhDjkSH+6xrs1zAptB9FrBv3S+YKszf6uBsIL3v0D1O08
         awsZ5RMI2ZRQEEru/NLd5Fm+kUt9RHu41EN2aV8IS/fYO9G2tIsXKARLrDHBgI11bDJE
         QY3uSyEusB2DIyuqQXmz5anlNydGX2RZn7P14SzGD/duC8d4gFje+KBXL/KX+VW/hatP
         4Jb+WBJyPoTMJp9DvQtJSeTfk3++sWVPz7M2Z6G9tkA4Z5r1YhSjD085HkmVBno95AfE
         JjsFEAAdzLBJ/ipsNx4/7rjyagDP8aeDUYIFmY56cohvA/VZAhYQD4bQ/hvhPgrcTsUO
         2nuQ==
X-Received: by 10.107.136.160 with SMTP id s32mr51549469ioi.174.1438070111986;
 Tue, 28 Jul 2015 00:55:11 -0700 (PDT)
Received: by 10.107.5.203 with HTTP; Tue, 28 Jul 2015 00:54:52 -0700 (PDT)
In-Reply-To: <1438066594-5620-4-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274753>

On Mon, Jul 27, 2015 at 11:56 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
> The 'ifexists' atom allows us to print a required format if the
> preceeding atom has a value. If the preceeding atom has no value then

Don't you mean "following atom" here? since you do document it as "the
next atom" below you should fix the commit message as well to match.
In any respect, this is a useful formatting atom :)

%(ifexists:[%s])%(atom) where the contents of atom will be placed into %s?

> the format given is not printed. e.g. to print "[<refname>]" we can
> now use the format "%(ifexists:[%s])%(refname)".
>
> Add documentation and test for the same.
>
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>  Documentation/git-for-each-ref.txt |  8 ++++++++
>  ref-filter.c                       | 37 ++++++++++++++++++++++++++++++++++---
>  ref-filter.h                       |  5 +++--
>  t/t6302-for-each-ref-filter.sh     | 21 +++++++++++++++++++++
>  4 files changed, 66 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
> index 9dc02aa..4424020 100644
> --- a/Documentation/git-for-each-ref.txt
> +++ b/Documentation/git-for-each-ref.txt
> @@ -138,6 +138,14 @@ colornext::
>         `<:colorname>`.  Not compatible with `padright` and resets any
>         previous `color`, if set.
>
> +ifexists::
> +       Print required string only if the next atom specified in the
> +       '--format' option exists.
> +       e.g. --format="%(ifexists:[%s])%(symref)" prints the symref
> +       like "[<symref>]" only if the ref has a symref.  This was
> +       incorporated to simulate the output of 'git branch -vv', where
> +       we need to display the upstream branch in square brackets.
> +

I suggest documenting that the atom will be placed into the contents
of ifexists via the %s indicator, as you do show an example but don't
explicitely say %s is the formatting character.

>  In addition to the above, for commit and tag objects, the header
>  field names (`tree`, `parent`, `object`, `type`, and `tag`) can
>  be used to specify the value in the header field.
> diff --git a/ref-filter.c b/ref-filter.c
> index 3f40144..ff5a16b 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -58,6 +58,7 @@ static struct {
>         { "color" },
>         { "padright" },
>         { "colornext" },
> +       { "ifexists" },
>  };
>
>  /*
> @@ -722,6 +723,13 @@ static void populate_value(struct ref_array_item *ref)
>                         v->modifier_atom = 1;
>                         v->color_next = 1;
>                         continue;
> +               } else if (starts_with(name, "ifexists:")) {
> +                       skip_prefix(name, "ifexists:", &v->s);
> +                       if (!*v->s)
> +                               die(_("no string given with 'ifexists:'"));
> +                       v->modifier_atom = 1;
> +                       v->ifexists = 1;
> +                       continue;
>                 } else
>                         continue;
>
> @@ -1315,11 +1323,32 @@ static void apply_formatting_state(struct ref_formatting_state *state,
>  {
>         if (state->color_next && state->pad_to_right)
>                 die(_("cannot use `colornext` and `padright` together"));
> -       if (state->color_next) {
> +       if (state->pad_to_right && state->ifexists)
> +               die(_("cannot use 'align' and 'ifexists' together"));
> +       if (state->color_next && !state->ifexists) {
>                 strbuf_addf(value, "%s%s%s", state->color_next, v->s, GIT_COLOR_RESET);
>                 return;
> -       }
> -       else if (state->pad_to_right) {
> +       } else if (state->ifexists) {
> +               const char *sp = state->ifexists;
> +
> +               while (*sp) {
> +                       if (*sp != '%') {
> +                               strbuf_addch(value, *sp++);
> +                               continue;
> +                       } else if (sp[1] == '%') {
> +                               strbuf_addch(value, *sp++);
> +                               continue;
> +                       } else if (sp[1] == 's') {
> +                               if (state->color_next)
> +                                       strbuf_addf(value, "%s%s%s", state->color_next, v->s, GIT_COLOR_RESET);
> +                               else
> +                                       strbuf_addstr(value, v->s);
> +                               sp += 2;
> +                       }
> +               }
> +
> +               return;
> +       } else if (state->pad_to_right) {
>                 if (!is_utf8(v->s))
>                         strbuf_addf(value, "%-*s", state->pad_to_right, v->s);
>                 else {
> @@ -1413,6 +1442,8 @@ static void store_formatting_state(struct ref_formatting_state *state,
>                 state->color_next = atomv->s;
>         if (atomv->pad_to_right)
>                 state->pad_to_right = atomv->ul;
> +       if (atomv->ifexists)
> +               state->ifexists = atomv->s;
>  }
>
>  static void reset_formatting_state(struct ref_formatting_state *state)
> diff --git a/ref-filter.h b/ref-filter.h
> index a021b04..7d1871d 100644
> --- a/ref-filter.h
> +++ b/ref-filter.h
> @@ -28,13 +28,14 @@ struct atom_value {
>         unsigned long ul; /* used for sorting when not FIELD_STR */
>         unsigned int modifier_atom : 1, /*  atoms which act as modifiers for the next atom */
>                 pad_to_right : 1,
> -               color_next : 1;
> +               color_next : 1,
> +               ifexists : 1;
>  };
>
>  struct ref_formatting_state {
>         int quote_style;
>         unsigned int pad_to_right;
> -       const char *color_next;
> +       const char *color_next, *ifexists;
>  };
>
>  struct ref_sorting {
> diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
> index 6aad069..29ed97b 100755
> --- a/t/t6302-for-each-ref-filter.sh
> +++ b/t/t6302-for-each-ref-filter.sh
> @@ -149,4 +149,25 @@ test_expect_success 'check `colornext` format option' '
>         test_cmp expect actual
>  '
>
> +test_expect_success 'check `ifexists` format option' '
> +       cat >expect <<-\EOF &&
> +       [foo1.10]
> +       [foo1.3]
> +       [foo1.6]
> +       EOF
> +       git for-each-ref --format="%(ifexists:[%s])%(refname:short)" | grep "foo" >actual &&
> +       test_cmp expect actual
> +'
> +
> +cat >expect <<EOF &&
> +[$(get_color green)foo1.10$(get_color reset)]||foo1.10
> +[$(get_color green)foo1.3$(get_color reset)]||foo1.3
> +[$(get_color green)foo1.6$(get_color reset)]||foo1.6
> +EOF
> +
> +test_expect_success 'check `ifexists` with `colornext` format option' '
> +       git for-each-ref --format="%(ifexists:[%s])%(colornext:green)%(refname:short)||%(refname:short)" | grep "foo" >actual &&
> +       test_cmp expect actual
> +'
> +
>  test_done
> --
> 2.4.6
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
