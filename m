From: Tor Arvid Lund <torarvid@gmail.com>
Subject: Re: [PATCH] Support different branch layouts in git-p4
Date: Tue, 8 Feb 2011 00:27:12 +0100
Message-ID: <AANLkTimGKc4MTwb=AnZ_Bv1EGS7yfgrFupxBOVVSm4s8@mail.gmail.com>
References: <4D489068.2040704@vmware.com>
	<AANLkTi=ozDk9SqYaYWKHXSjVChV-93-88F_LUCwfSiDc@mail.gmail.com>
	<4D4F3738.7010603@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Ian Wienand <ianw@vmware.com>
X-From: git-owner@vger.kernel.org Tue Feb 08 00:27:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmaUK-0005P2-EG
	for gcvg-git-2@lo.gmane.org; Tue, 08 Feb 2011 00:27:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755267Ab1BGX1O convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Feb 2011 18:27:14 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:56985 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755092Ab1BGX1N convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Feb 2011 18:27:13 -0500
Received: by ywo7 with SMTP id 7so1699642ywo.19
        for <git@vger.kernel.org>; Mon, 07 Feb 2011 15:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=BadkNTjwEOMZFHDG1w3bh9r8g1uhAElKoANfJrNv8WU=;
        b=Vim8vUKum4vFfIAHMMOuPfXr4a+icXEC/YqKKuXNLbAyPvUvWiSnh/xHpoqxdbJdY7
         zrFocUKLL/z8LFffTHbDxqTeIklF3vunOpLABx8qbYkzJAmH+IPvvRQJq6vO6LNXsAgL
         9eqfmf1xDMPQuvVkUqsoYx6l956A5fK9Ji17E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Grp6B4AqnmCwYodmlKHPnyayet0AgTSJin4FLdQt8St6R583rJ4cKFYvKDluAGhm36
         mBpJBMsFWIFaGOTkuyUtg0BnXsjnxfsFj4y8NOQTVsrcPxEOt3CnBmZx7pdjiIT9YRrL
         XLQ8mHaVwN5oGwVG6R0EhoMNdx+5UJKtL50Ig=
Received: by 10.100.165.20 with SMTP id n20mr9972729ane.114.1297121232131;
 Mon, 07 Feb 2011 15:27:12 -0800 (PST)
Received: by 10.101.1.19 with HTTP; Mon, 7 Feb 2011 15:27:12 -0800 (PST)
In-Reply-To: <4D4F3738.7010603@vmware.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166309>

On Mon, Feb 7, 2011 at 1:05 AM, Ian Wienand <ianw@vmware.com> wrote:
> On 04/02/11 16:37, Tor Arvid Lund wrote:
>> For starters, I don't think that I like git-p4 being taught to solve
>> problems that seem to be caused by a poor/unfortunate perforce layou=
t.
>
> I do think this //depot/project/branch type layout is pretty typical,
> although I admit I don't have a lot of experience with alternative p4
> setups.

You may be right, although I suspect that
//depot/department/project/branch may be equally typical. At my
$dayjob, we have gone through several "reorganizations" of the
perforce layouts. I'm the guy that never likes any of them ;)

>> A solution which I think would work well for everyone, is if files
>> would be placed according to the right-hand patterns in the
>> client-spec.
>
> I did consider this at first. =C2=A0My only issue is that it is a bit
> confusing to use the client spec for filtering (and in this case
> re-writing), but not for actually selecting the depots to clone, whic=
h
> I still need to replicate on the command line. =C2=A0However that is =
a much
> larger change.
>
> What do you think of this one?

In general, me thinks me likes it :-)

(and it turned out much smaller than I would have originally guessed)

I should probably mention that I haven't tested your patch at all. I
will have a pretty rough week at work, so it would be great if anyone
else feels like chiming in on this one... But I have some quick
observations below:

> ---
>
> diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
> index 04ce7e3..eb9620c 100755
> --- a/contrib/fast-import/git-p4
> +++ b/contrib/fast-import/git-p4
> @@ -878,6 +878,7 @@ class P4Sync(Command):
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.cloneExclude =3D []
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.useClientSpec =3D False
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.clientSpecDirs =3D []
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0self.clientName =3D None
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 if gitConfig("git-p4.syncFromOrigin") =3D=
=3D "false":
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.syncWithOrigin =3D Fal=
se
> @@ -910,6 +911,22 @@ class P4Sync(Command):
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 return files
>
> =C2=A0 =C2=A0 def stripRepoPath(self, path, prefixes):
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0if self.useClientSpec:
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# if using the client spec=
, we use the output directory
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# specified in the client.=
 =C2=A0For example, a view
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# =C2=A0 //depot/foo/branc=
h/... //client/branch/foo/...
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# will end up putting all =
foo/branch files into
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# =C2=A0branch/foo/
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for val in self.clientSpec=
Dirs:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if path.star=
tswith(val[0]):
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
# replace the depot path with the client path
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
path =3D path.replace(val[0], val[1][1])
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
# now strip out the client (//client/...)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
path =3D re.sub("^(//[^/]+/)", '', path)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
# the rest is all path
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
return path
> +
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 if self.keepRepoPath:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 prefixes =3D [re.sub("^(//[=
^/]+/).*", r'\1', prefixes[0])]
>
> @@ -1032,7 +1049,7 @@ class P4Sync(Command):
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 includeFile =3D True
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for val in self.clientSpecD=
irs:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if f['path'].=
startswith(val[0]):
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
if val[1] <=3D 0:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
if val[1][0] <=3D 0:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 includeFile =3D False
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 break
>
> @@ -1474,20 +1491,36 @@ class P4Sync(Command):
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 temp =3D {}
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 for entry in specList:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for k,v in entry.iteritems(=
):
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if k.startsw=
ith("Client"):
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
self.clientName =3D v
> +
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if k.startswi=
th("View"):
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 if v.startswith('"'):
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 start =3D 1
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 else:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 start =3D 0
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 index =3D v.find("...")
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
# save the "client view"; i.e the RHS of the view
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
# line that tells the client where to put the
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
# files for this view.
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
cv =3D v[index+4:] # +4 to remove previous '... '

This feels less robust than what we might want. Isn't the format of a
client-spec line either:

-?//depot/path[/...]\s+//client/path[/...]\n

or

-?"//depot/path with spaces/path[/...]"\s+"//client/path with spaces/pa=
th[/...]"

=2E. where -? means an optional '-' char, and \s+ is
'whatever-length-and-kind-of-whitespace'. I'm just guessing from
memory regarding these patterns, but assuming that the section
separator is exactly the string '... ' seems risky, no? :)

> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
cv_index =3D cv.find("...")
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
cv=3Dcv[:cv_index]

What if a line doesn't end with "..." ? Maybe add an "if cv_index >=3D =
0"

> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
# now save the view; +index means included, -index
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
# means it should be filtered out.
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 v =3D v[start:index]
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 if v.startswith("-"):
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 v =3D v[1:]
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0temp[v] =3D -len(v)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0include =3D -len(v)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 else:
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0temp[v] =3D len(v)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0include =3D len(v)
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
temp[v] =3D (include, cv)
> +
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.clientSpecDirs =3D temp.items()
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0self.clientSpecDirs.sort( lambda x, y: a=
bs( y[1] ) - abs( x[1] ) )
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0self.clientSpecDirs.sort( lambda x, y: a=
bs( y[1][0] ) - abs( x[1][0] ) )
>
> =C2=A0 =C2=A0 def run(self, args):
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.depotPaths =3D []
> diff --git a/contrib/fast-import/git-p4.txt b/contrib/fast-import/git=
-p4.txt
> index 49b3359..e09da44 100644
> --- a/contrib/fast-import/git-p4.txt
> +++ b/contrib/fast-import/git-p4.txt
> @@ -191,6 +191,11 @@ git-p4.useclientspec
>
> =C2=A0 git config [--global] git-p4.useclientspec false
>
> +The P4CLIENT environment variable should be correctly set for p4 to =
be
> +able to find the relevant client. =C2=A0This client spec will be use=
d to
> +both filter the files cloned by git and set the directory layout as
> +specified in the client (this implies --keep-path style semantics).
> +
> =C2=A0Implementation Details...
> =C2=A0=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
>
>

Aight. I need some sleep now. Nice work so far, Ian! :)

    -- Tor Arvid
