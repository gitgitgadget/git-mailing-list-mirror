From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [PATCH v5 2/2] submodule: fix handling of relative superproject
 origin URLs
Date: Fri, 25 May 2012 08:09:12 +1000
Message-ID: <CAH3Anror5Q0HYWXGX+-Es2n3zabST5k35cATKrTZzW30dN85oQ@mail.gmail.com>
References: <1337830657-16400-1-git-send-email-jon.seymour@gmail.com>
	<1337830657-16400-3-git-send-email-jon.seymour@gmail.com>
	<CABURp0pE7TjSOx7aWNqak4iyK5dBS-70wf0xvBU4KXtsGu5tRw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com, Jens.Lehmann@web.de
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 25 00:09:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXgDg-0006Zw-9g
	for gcvg-git-2@plane.gmane.org; Fri, 25 May 2012 00:09:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933192Ab2EXWJP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 May 2012 18:09:15 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:59569 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752175Ab2EXWJO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 May 2012 18:09:14 -0400
Received: by wibhn6 with SMTP id hn6so249453wib.1
        for <git@vger.kernel.org>; Thu, 24 May 2012 15:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=Qp//SNGZldauT3/S/Pzg+3iWKkGNZcSeFNbqxnCFfQ8=;
        b=KrCWBGVS4fw9CUwxoREycvIpTsiOclA6k746RHYl8vLW3VXAnsOEL1yZqS3RwWPZc3
         L4p2nRZ34UBfq54kOv44VYXrE/1WxsdRmtn6nwOmQmQn4cBvVyVN6m1FL3V86wvKJ+bv
         rEtxp/66lj/OI2HTxCfSBWFouS9DNO5jJCTT3y+ut03oV4XIIb2dw7RJc7TS8dQ+bygK
         zmnnCbljgI73TXRa6UZbTwXvGZ2JAWoATBYDXz43lKB3uP+A14SwHFJtp86yoLQuC//4
         v3kEZGVB5mKfPoIeq8irpnDjY7QhpZnu1xa+ZdIbpS2lqjJ/lZOnmjIEWogm3a1UzGlU
         yhiQ==
Received: by 10.216.216.148 with SMTP id g20mr471765wep.187.1337897353026;
 Thu, 24 May 2012 15:09:13 -0700 (PDT)
Received: by 10.180.146.166 with HTTP; Thu, 24 May 2012 15:09:12 -0700 (PDT)
In-Reply-To: <CABURp0pE7TjSOx7aWNqak4iyK5dBS-70wf0xvBU4KXtsGu5tRw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198437>

On Fri, May 25, 2012 at 4:58 AM, Phil Hord <phil.hord@gmail.com> wrote:
> On Wed, May 23, 2012 at 11:37 PM, Jon Seymour <jon.seymour@gmail.com>=
 wrote:
>> +#
>> +# This behaviour is required to ensure that the origin URL
>
> "Required behavior" always seems overstated to me when I
> read it in comments and so I tend to distrust it. =C2=A0I'd prefer to
> see "This behaviour is intended to ensure..." =C2=A0But this is
> only my personal preference.

Sure.

>> + =C2=A0 =C2=A0 =C2=A0 #
>> + =C2=A0 =C2=A0 =C2=A0 # ensure all relative paths begin with ./ to =
enable
>

=46or clarity, this should be:

    ensure all relative superproject origin URLs begin with ./ to enabl=
e ...

> Are we talking about remote urls or local filesystem paths? =C2=A0I t=
hink this
> is all confusing enough without the comments also using terminology
> inconsistently. =C2=A0Would it be more correct to say "all relatiive =
urls" here?
> Or is this function only interested in local filesystem paths?
>
> I realize that urls are paths of a different nature. =C2=A0I pick thi=
s nit
> only in the cause of clarity.

How about I rewrite the function blurb as something like:

"The function takes at most 2 arguments. The first argument is the
relative URL that navigates from the superproject origin repo to the
submodule origin repo. The second up_path argument, if specified, is
the relative path that navigates from the submodule working tree to
the superproject working tree.

The output of the function is the origin URL of the submodule.

The output will either be an absolute URL or filesystem path (if the
superproject origin URL is an absolute URL or filesystem path,
respectively) or a relative file system path (if the superproject
origin URL is a relative file system path).

When the output is a relative file system path, the path is either
relative to the submodule working tree, if up_path is specified, or to
the superproject working tree otherwise."

Phil/Jens: Perhaps we should rename the function to be:
submodule_origin_url to reflect its intended use?

>
>> + =C2=A0 =C2=A0 =C2=A0 # selection relative branch of subsequent cas=
e "$remoteurl"
>> + =C2=A0 =C2=A0 =C2=A0 # statement.
>> + =C2=A0 =C2=A0 =C2=A0 #
>> + =C2=A0 =C2=A0 =C2=A0 # rewrites foo/bar to ./foo/bar but leaves /f=
oo, :foo ./foo
>> + =C2=A0 =C2=A0 =C2=A0 # and ../foo untouched.
>> + =C2=A0 =C2=A0 =C2=A0 #
>
> In many filesystems, ":foo" and "\foo" are valid filenames.
> I suspect it is unwise to employ them and expect them not
> to cause trouble, so I don't know if we should make
> special efforts to accept them here. =C2=A0But I think it
> is worth noting.
>
> On the other hand, I do not know how these special
> characters are represented in urls.

Perhaps I should indicate 'why' these paths are not touched? Something =
like:

"Rewrites foo/bar foo/bar as ./foo/bar but leaves ./foo, ../foo, /foo,
foo:bar, :bar untouched because the first 2 forms do not require
additional qualification and the last forms
are assumed to be absolute URLs or paths."

Perhaps I shouldn't be treating :foo as a possible absolute file
system path ? My knowledge of filesystems is not good enough to know
if there are filesystems that git supports where :foo might be
regarded a valid absolute path?

>
>> + =C2=A0 =C2=A0 =C2=A0 remoteurl=3D$(echo "$remoteurl" | sed "s|^[^/=
:\\.][^:]*\$|./&|")
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0remoteurl=3D${remoteurl%/}
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0sep=3D/
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0while test -n "$url"
>> @@ -45,6 +67,16 @@ resolve_relative_url ()
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0../*)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0url=3D"${url#../}"
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0case "$remoteurl" in
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 .*/*)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # remove last part
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 remoteurl=3D"${remoteurl%/*}"
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # remove redundant leading ./
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 remoteurl=3D"${remoteurl#./}"
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # prefix path from submodule wor=
k tree to superproject work tree
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 remoteurl=3D"${up_path}${remoteu=
rl}"
>
> Here we seem to be talking about paths since we are concerned
> with the worktrees. =C2=A0So maybe my earlier concern about "urls"
> vs. "paths" was miguided. =C2=A0My head swims.
>

This branch of the case statement is specifically when the origin
superproject URL is a relative file system path.

>
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # remove trailing /.
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 remoteurl=3D"${remoteurl%/.}"
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ;;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0*/*)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0remoteurl=3D"${remoteurl%/*}"
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0;;
>
> I haven't tested it, but the rest of this is making more sense to me =
now.
>
> Phil

Thanks for your review and suggestions.

jon.
