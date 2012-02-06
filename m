From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH/RFC v4] grep: Add the option '--exclude'
Date: Mon, 6 Feb 2012 22:16:59 +0700
Message-ID: <CACsJy8DhtjG6AhPkb0SEm4g6zhtmuRb5x+4+P3A6eS0+_7OQNw@mail.gmail.com>
References: <1328192753-29162-1-git-send-email-surfingalbert@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: Albert Yale <surfingalbert@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 06 16:17:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuQK2-0005Wf-JW
	for gcvg-git-2@plane.gmane.org; Mon, 06 Feb 2012 16:17:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755318Ab2BFPRd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Feb 2012 10:17:33 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:59174 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755077Ab2BFPRc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Feb 2012 10:17:32 -0500
Received: by wgbdt10 with SMTP id dt10so6325909wgb.1
        for <git@vger.kernel.org>; Mon, 06 Feb 2012 07:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=3jADfQjs92YRagI9WDbK7TK5YHvSGcAQKaecArzOw4g=;
        b=Nz5VmUvRdYEC+SDjng5vgSL9SN8m5wxypNS7RS69YmV7g2iau82egnAV+5f6gXoO2S
         EV2bGRqxi+GCFJxIwstkB0UwbYkP+2tRC9lQBi5x2HimcKepZMTk6WHZWvkcyv845KkV
         UKFkh8wEBCldy/vdiCL9y3nMnfNO/18vLnAp0=
Received: by 10.180.86.9 with SMTP id l9mr28090552wiz.15.1328541450235; Mon,
 06 Feb 2012 07:17:30 -0800 (PST)
Received: by 10.223.2.139 with HTTP; Mon, 6 Feb 2012 07:16:59 -0800 (PST)
In-Reply-To: <1328192753-29162-1-git-send-email-surfingalbert@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190072>

On Thu, Feb 2, 2012 at 9:25 PM, Albert Yale <surfingalbert@gmail.com> w=
rote:
> I added a "struct pathspec_set" as you suggested
> in your previous review. It had the side effect
> of forcing me to update a few more files than was
> previously necessary.

Please make it a separate patch, it's hard to follow an all-in-one
patch. Although those changes might be unnecessary (see below).

> --- a/builtin/grep.c
> +++ b/builtin/grep.c
> @@ -566,6 +566,10 @@ static int grep_tree(struct grep_opt *opt, const=
 struct pathspec *pathspec,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0while (tree_entry(tree, &entry)) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int te_len =3D=
 tree_entry_len(&entry);
>
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!match_pathspe=
c_depth(pathspec,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
entry.path, strlen(entry.path),
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
0, NULL))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 continue;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (match !=3D=
 all_entries_interesting) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0match =3D tree_entry_interesting(&entry, base, tn_len, pa=
thspec);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0if (match =3D=3D all_entries_not_interesting)

tree_entry_interesting() is equivalent to match_pathspec_depth(). The
only difference is that the former is designed to match on trees why
the latter a list. And tree_entry_interesting() is more efficient than
match_pathspec_depth(). As you can see there's
tree_entry_interesting() call above already. You should make the
tree_entry_interesting() understand exclude pathspec instead of adding
match_pathspec_depth() in.

> @@ -295,6 +298,25 @@ int match_pathspec_depth(const struct pathspec *=
ps,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return retval;
> =C2=A0}
>
> +int match_pathspec_depth(const struct pathspec *ps,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0const char *name, int namelen,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0int prefix, char *seen)
> +{
> + =C2=A0 =C2=A0 =C2=A0 int retval =3D match_pathspec_set_depth(&ps->i=
nclude,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 ps->recursive, ps->max_depth,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 name, namelen, prefix, seen);
> +
> + =C2=A0 =C2=A0 =C2=A0 if (retval && ps->exclude.nr)
> + =C2=A0 =C2=A0 =C2=A0 {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (match_pathspec=
_set_depth(&ps->exclude,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0ps->recursive, ps->max_depth,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0name, namelen, prefix, seen))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 return 0;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 return retval;
> +}
> +
> =C2=A0static int no_wildcard(const char *string)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return string[strcspn(string, "*?[{\\")] =3D=
=3D '\0';

It makes me wonder, why not add match_pathspec_with_exclusion(const
struct pathspec *include_ps, const struct pathspec *exclude_ps,...),
use the new function in grep.c and revert struct pathspec back to
original? The same can be applied to tree_entry_interesting() (i.e.
add a new one that takes two pathspec sets, which supports exclusion)

I think you may make less changes that way. I'm bad at naming. It's up
to you to rename match_pathspec_with_exclusion to something meaningful
and short enough.
--=20
Duy
