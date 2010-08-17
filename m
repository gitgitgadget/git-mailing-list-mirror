From: Robert Buck <buck.robert.j@gmail.com>
Subject: Re: [PATCH 0/6] Extensions of core.ignorecase=true support
Date: Tue, 17 Aug 2010 15:36:13 -0400
Message-ID: <AANLkTi=0j_JFWBp=kJG6v+YBUxKAiVAVc4UtG0LWmipq@mail.gmail.com>
References: <cover.1281985411.git.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Joshua Jensen <jjensen@workspacewhiz.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Tue Aug 17 21:36:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OlRxO-0006Fh-Ka
	for gcvg-git-2@lo.gmane.org; Tue, 17 Aug 2010 21:36:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751197Ab0HQTgQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Aug 2010 15:36:16 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:49121 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750705Ab0HQTgP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Aug 2010 15:36:15 -0400
Received: by ewy23 with SMTP id 23so3295318ewy.19
        for <git@vger.kernel.org>; Tue, 17 Aug 2010 12:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=WC4nTsCU8a+Whk3DkHaUW8MxNYQQ2jBCCNYWyHZE+bQ=;
        b=Kt5eWH2GXqfDQZEF8bAbM/3OGUCfj2T1eh7/CGV3nX+t7m2XAqV/HuRCEk9Ybd7YT6
         YdmvDmBIHCxHbYPOSMj+AEjgAUG+KiNZm1WjoRd/JdBCxkRiY6fgis7MJiTv1lfB2Uiy
         Sp6cgWt+Kpg04RHkImCy5+WSpOXbGuTQuH2tY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Ez49rAf+LLsBNAVYfQ8ZklGt7OF7UWEGa6Rw2lnHNpcebpc3FAlivl0FjzKeR2UTTW
         eziBHd9K+X22lpGfptA2KzOgVLScq8hGZHQr1MgayfhWrTwrCZyOLnZ5ljdP6dI4Ta8m
         jGdTbfa5aVmFOJyohsnB5+La+iEsrPAO5WZd4=
Received: by 10.213.108.143 with SMTP id f15mr1221117ebp.11.1282073773756;
 Tue, 17 Aug 2010 12:36:13 -0700 (PDT)
Received: by 10.14.47.7 with HTTP; Tue, 17 Aug 2010 12:36:13 -0700 (PDT)
In-Reply-To: <cover.1281985411.git.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153776>

While I tend to agree with case-insensitive searches, I would tend to
question the use of a non-case-preserving / last-use methodology
reminiscent of the days of DOS. I was never terribly fond of DOS nor
of Windows for Workgroups, and this change smacks of that. That said,
as an algorithm it is one legitimate option, I just would not tend to
use it.

Have you thought of other approaches that are case-preserving /
case-insensitive (modern Windows implementations and Mac OS X) or of
case-sensitive (UNIX)? What about giving the user the choice?

Looking back at how flexible and simple folks here on this list made
the EOL support (the best I have seen to date) what if you followed a
similar approach and provided the flexibility to the users by giving
the options to control the behavior themselves, then fall back to
reasonable defaults if left unspecified?

I would imagine having two properties would be somewhat more useful:

core.casepreserving=3Dtrue|false
core.caseinsensitive=3Dtrue|false

=46or Unix-centric environments the defaults would be true & false,
respectively. For mixed Windows/Unix environments users would
configure it as true & true. A combination of false & true,
respectively, would be appropriate for DOS users, but this may be
another option for mixed environments. A combination of false & false
would be impossible by definition.

What this would mean is that searches in the purely Unix world would
store and match sensitively; but in such an environment there may be
issues should any Windows users attempt to work with the repository if
two files having a similar names existed. For Windows users the last
read operation would overwrite the first (not a good thing).

=46or mixed configurations there are two options, the Windows/Mac
option, and the DOS option.

The nice thing about case-insensitivity is that when requesting a file
by name any capitalization can be used. The bad thing, well come to
think of it, there is none that I can think of, but for those more
religious than I about Unix they may cite otherwise.

-Bob

On Mon, Aug 16, 2010 at 3:38 PM, Johannes Sixt <j6t@kdbg.org> wrote:
> The following patch series extends the core.ignorecase=3Dtrue support=
 to
> handle case insensitive comparisons for the .gitignore file, git stat=
us,
> and git ls-files. =C2=A0git add and git fast-import will fold the cas=
e of the
> file being added, matching that of an already added directory entry. =
=C2=A0Case
> folding is also applied to git fast-import for renames, copies, and d=
eletes.
>
> The most notable benefit, IMO, is that the case of directories in the
> worktree does not matter if, and only if, the directory exists alread=
y in
> the index with some different case variant. =C2=A0This helps applicat=
ions on
> Windows that change the case even of directories in unpredictable way=
s.
> Joshua mentioned Perforce as the primary example.
>
> Concerning the implementation, Joshua explained when he initially sub=
mitted
> the series to the msysgit mailing list:
>
> =C2=A0git status and add both use an update made to name-hash.c where
> =C2=A0directories, specifically names with a trailing slash, can be l=
ooked up
> =C2=A0in a case insensitive manner. After trying a myriad of solution=
s, this
> =C2=A0seemed to be the cleanest. Does anyone see a problem with embed=
ding the
> =C2=A0directory names in the same hash as the file names? I couldn't =
find one,
> =C2=A0especially since I append a slash to each directory name.
>
> =C2=A0The git add path case folding functionality is a somewhat radic=
al
> =C2=A0departure from what Git does now. It is described in detail in =
patch 5.
> =C2=A0Does anyone have any concerns?
>
> I support the idea of this patch, and I can confirm that it works: I'=
ve
> used this series in production both with core.ignorecase set to true =
and
> to false, and in the former case, with directories and files with cas=
e
> different from the index.
>
> Joshua Jensen (6):
> =C2=A0Add string comparison functions that respect the ignore_case
> =C2=A0 =C2=A0variable.
> =C2=A0Case insensitivity support for .gitignore via core.ignorecase
> =C2=A0Add case insensitivity support for directories when using git s=
tatus
> =C2=A0Add case insensitivity support when using git ls-files
> =C2=A0Support case folding for git add when core.ignorecase=3Dtrue
> =C2=A0Support case folding in git fast-import when core.ignorecase=3D=
true
>
> =C2=A0dir.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0105 +++++++++++++++++=
+++++++++++++++++++++++++++++----------
> =C2=A0dir.h =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A04 ++
> =C2=A0fast-import.c | =C2=A0 =C2=A07 ++--
> =C2=A0name-hash.c =C2=A0 | =C2=A0 72 ++++++++++++++++++++++++++++++++=
++++++-
> =C2=A0read-cache.c =C2=A0| =C2=A0 23 ++++++++++++
> =C2=A05 files changed, 188 insertions(+), 23 deletions(-)
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>
