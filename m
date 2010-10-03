From: Robert Buck <buck.robert.j@gmail.com>
Subject: Re: [PATCH v2 0/6] Extensions of core.ignorecase=true support
Date: Sun, 3 Oct 2010 07:48:08 -0400
Message-ID: <AANLkTinZzM=HeT_J-tF5F9DBdvts3i+nboPkPy-uc8V5@mail.gmail.com>
References: <20101003043221.1960.73178.stgit@SlamDunk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, j6t@kdbg.org
To: Joshua Jensen <jjensen@workspacewhiz.com>
X-From: git-owner@vger.kernel.org Sun Oct 03 13:53:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2N8e-0000OX-F4
	for gcvg-git-2@lo.gmane.org; Sun, 03 Oct 2010 13:53:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752849Ab0JCLsL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Oct 2010 07:48:11 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:38798 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751553Ab0JCLsK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 3 Oct 2010 07:48:10 -0400
Received: by eyb6 with SMTP id 6so1593687eyb.19
        for <git@vger.kernel.org>; Sun, 03 Oct 2010 04:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=kZ1SGuQpyYtz4X4w4uj/qnkek9WoWQTRh4OeL2NLMB8=;
        b=mgj6pElUiGxMLb9hlVKT4NxAO2mE8Fb//H5PVYDk5mwHJjPvhXpFXaRbEF5B2GGtLp
         Kpvn4NwLMWdiICbx77rXfWizXkfxMHwXuTTJj8X+NIdWQSs51uDmrF6BDX8Bt2asmfLP
         JfQIwH2GFBin8F9akwg8ImwFWWSYhtSMHyJp4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=HqvRJ/2+vzXzftDE+Pox4w5e/8NtKcoWqWRyLkt5kr7XirYuZCOAAUoJPsyhBA6MMF
         xiApdSfUPhwfa0rgfQ8kDRySYVdIrJ8JS9ZBPoc/TNJjsSvgJ0F8pVt+coCcSZMZwKgA
         0aE3Cy3J4JKSE8FGGHjLL6OPeVkf6/Z1JN9s4=
Received: by 10.14.119.7 with SMTP id m7mr4868902eeh.40.1286106488510; Sun, 03
 Oct 2010 04:48:08 -0700 (PDT)
Received: by 10.14.47.74 with HTTP; Sun, 3 Oct 2010 04:48:08 -0700 (PDT)
In-Reply-To: <20101003043221.1960.73178.stgit@SlamDunk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157861>

Referring back to my earlier comment to this patch series, which was
proposed on August 17, while I tend to agree to the changes that help
listing- operations, those changes that fold case concern me. Let me
explain...

You may find there is a strong contingent of people that would approve
of, and would want to use, case insensitivity for gitignore and ls,
for example; but by tying the same single property (core.ignorecase)
to the case folding behaviors some people would avoid the feature all
together, which would be unfortunate, when they otherwise could
benefit from at least one part of the new behavior.

There were several key things that went wrong in early git
development, this and the eol support were two casualties. The eol
support, as you recall, deprecated the old property in favor of a
couple new superior ones. I would recommend that the same thing be
done here, deprecate the old ignorecase property by introducing two
better ones.

So I could we please separate the behaviors that change intent
(folding) from the behaviors that merely alter how things are
displayed (listing) by splitting this into two separate properties?
=46or example,

core.casepreserving=3Dtrue|false
core.caseinsensitive=3Dtrue|false

The former property would control folding, the latter property would
apply to listing and pattern matching. Then people could opt out of
the folding behaviors (add, import), while continuing to adopt listing
and pattern matching (status, ls, ignore).

Again, deprecate core.ignorecase by making it default to {false,false}
for the new properties if unspecified, which would also be the default
if all three of the properties are unspecified. If ignorecase is
specified to be true, then default to {false, true}, respectively.

Would this be possible?

On Sun, Oct 3, 2010 at 12:32 AM, Joshua Jensen
<jjensen@workspacewhiz.com> wrote:
> The second version of this patch series fixes the problematic case
> insensitive fnmatch call in patch 1 that relied on an apparently GNU-=
only
> extension. =C2=A0Instead, the pattern and string are lowercased into
> temporary buffers, and the standard fnmatch is called without relying
> on the GNU extension.
>
> Patches 2-6 received no modifications.
>
> The original cover for the patch series follows as posted by Johannes=
 Sixt:
>
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
> =C2=A0 =C2=A0 =C2=A0Add string comparison functions that respect the =
ignore_case variable.
> =C2=A0 =C2=A0 =C2=A0Case insensitivity support for .gitignore via cor=
e.ignorecase
> =C2=A0 =C2=A0 =C2=A0Add case insensitivity support for directories wh=
en using git status
> =C2=A0 =C2=A0 =C2=A0Add case insensitivity support when using git ls-=
files
> =C2=A0 =C2=A0 =C2=A0Support case folding for git add when core.ignore=
case=3Dtrue
> =C2=A0 =C2=A0 =C2=A0Support case folding in git fast-import when core=
=2Eignorecase=3Dtrue
>
>
> =C2=A0dir.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0152 +++++++++++++++++=
+++++++++++++++++++++++++++++++++-------
> =C2=A0dir.h =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A04 ++
> =C2=A0fast-import.c | =C2=A0 =C2=A07 ++-
> =C2=A0name-hash.c =C2=A0 | =C2=A0 72 +++++++++++++++++++++++++++
> =C2=A0read-cache.c =C2=A0| =C2=A0 23 +++++++++
> =C2=A05 files changed, 235 insertions(+), 23 deletions(-)
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>
