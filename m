From: Albert Yale <surfingalbert@gmail.com>
Subject: Re: [PATCH/RFC v2] grep: Add the option '--exclude'
Date: Sun, 29 Jan 2012 19:01:25 -0500
Message-ID: <CALEc4zEQz1eVAgqGz2g5taEDnSMwLWePxHiT=543LWX-7zCDFg@mail.gmail.com>
References: <1327876934-61526-1-git-send-email-surfingalbert@gmail.com> <7vvcnudsda.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 30 01:02:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RrehK-00066I-Ks
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jan 2012 01:02:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754011Ab2A3ACH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 29 Jan 2012 19:02:07 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:55208 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753268Ab2A3ACG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 Jan 2012 19:02:06 -0500
Received: by wgbed3 with SMTP id ed3so3946527wgb.1
        for <git@vger.kernel.org>; Sun, 29 Jan 2012 16:02:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=pnmE0vn0FwBcUEpxUVstXjtPHp54YEwdWZcAUZcYAMA=;
        b=EYQKtKQz35PCcHKS2fJBE8aCBwzHjLZI8Maj9a022Ya54DFfVvt7H5BIErQeRXa4mW
         +qgto/9+XN+0R0EMvM8o0ZnHjJ5tttfIivT7uCrIhtLThbwN8F683mNUQxuKsWUi8X+E
         O/dUCdnYCxlVOrZDJ8B7DHBSQIBBvhIeDwQCI=
Received: by 10.180.97.166 with SMTP id eb6mr24208649wib.5.1327881725064; Sun,
 29 Jan 2012 16:02:05 -0800 (PST)
Received: by 10.216.167.200 with HTTP; Sun, 29 Jan 2012 16:01:25 -0800 (PST)
In-Reply-To: <7vvcnudsda.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189309>

Thank you for your feedback Junio.
I'll revise my patch next weekend.

Albert Yale

On Sun, Jan 29, 2012 at 6:02 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
>
> Albert Yale <surfingalbert@gmail.com> writes:
>
> > Feedback would again be appreciated,
>
> Hmm.
>
> > =A0 =A0 =A0 =A0 =A0[-f <file>] [-e] <pattern>
> > + =A0 =A0 =A0 =A0[-x<pattern>|--exclude<pattern>]
>
> Compare the above two lines and notice some funny in the added one?
>
> > @@ -124,6 +125,12 @@ OPTIONS
> > =A0 =A0 =A0 Use fixed strings for patterns (don't interpret pattern
> > =A0 =A0 =A0 as a regex).
> >
> > +-x<pattern>::
> > +--exclude<pattern>::
> > + =A0 =A0 In addition to those found in .gitignore (per directory) =
and
> > + =A0 =A0 $GIT_DIR/info/exclude, also consider these patterns to be=
 in the
> > + =A0 =A0 set of the ignore rules in effect.
> > +
>
> Likewise.
>
> > diff --git a/builtin/grep.c b/builtin/grep.c
> > index 9ce064a..9772fa4 100644
> > --- a/builtin/grep.c
> > +++ b/builtin/grep.c
> > @@ -530,6 +530,10 @@ static int grep_cache(struct grep_opt *opt, co=
nst struct pathspec *pathspec, int
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!match_pathspec_depth(pathspec, ce-=
>name, ce_namelen(ce), 0, NULL))
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
> > + =A0 =A0 =A0 =A0 =A0 =A0 if (pathspec->exclude &&
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pathspec->exclude->nr &&
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 match_pathspec_depth(path=
spec->exclude, ce->name, ce_namelen(ce), 0, NULL))
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
>
> Why isn't this just
>
> =A0 =A0 =A0 =A0if (!match_pathspec_depth(pathspec, ce->name, ce_namel=
en(ce), 0, NULL))
>
> that is, *no change whatsoever* on the existing codepaths that call
> match_pathspec_depth()? =A0Can't the "even if one of the positive pat=
hspec
> matched, if one of the excluded one matches, declare that the path do=
es
> *not* match" logic live in match_pathspec_depth() itself?
>
> Exactly the same comment applies to all the other additions that call=
s
> match_pathspec_depth() with pathspec->exclude as its first parameter =
in
> this patch.
>
> > @@ -1053,6 +1084,12 @@ int cmd_grep(int argc, const char **argv, co=
nst char *prefix)
> > =A0 =A0 =A0 pathspec.max_depth =3D opt.max_depth;
> > =A0 =A0 =A0 pathspec.recursive =3D 1;
> >
> > + =A0 =A0 if( exclude_list.nr ) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 create_pathspec_from_string_list(&pathspe=
c.exclude, &exclude_list);
> > + =A0 =A0 =A0 =A0 =A0 =A0 pathspec.exclude->max_depth =3D opt.max_d=
epth;
> > + =A0 =A0 =A0 =A0 =A0 =A0 pathspec.exclude->recursive =3D 1;
> > + =A0 =A0 }
> > +
>
> Style. Notice where SPs should be near parentheses on "if" statement =
in
> our codebase.
