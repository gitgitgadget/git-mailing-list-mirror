From: Phil Hord <phil.hord@gmail.com>
Subject: Re: [PATCH v5 2/2] submodule: fix handling of relative superproject
 origin URLs
Date: Thu, 24 May 2012 14:58:25 -0400
Message-ID: <CABURp0pE7TjSOx7aWNqak4iyK5dBS-70wf0xvBU4KXtsGu5tRw@mail.gmail.com>
References: <1337830657-16400-1-git-send-email-jon.seymour@gmail.com> <1337830657-16400-3-git-send-email-jon.seymour@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com, Jens.Lehmann@web.de
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 24 20:59:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXdFn-0005bC-Ry
	for gcvg-git-2@plane.gmane.org; Thu, 24 May 2012 20:59:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756105Ab2EXS7P convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 May 2012 14:59:15 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:51239 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751513Ab2EXS7N convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 May 2012 14:59:13 -0400
Received: by yhmm54 with SMTP id m54so129137yhm.19
        for <git@vger.kernel.org>; Thu, 24 May 2012 11:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=MIYT72A9+RcFwN55Tqge9qMW5SfEawnpvwJB3RVTmII=;
        b=BWUvmB7OcpgAIzlBX5z2EHfCcTTvJqldzLsPIKcSpxtdDEg9mv+eOHRecnabjbhDIw
         +8G6laaKaHw5TMCqJNVwKiOZ4njPAKcPVRiE+o7IP0sNzFUza9gYAuvt+CHre6/PxbQl
         R/Kgnk8r8AMKX24tSDh0ZcFLQfYw9dUUICPz4h0Yo3z6LYp8cxA54M1HXxSXAZl0rcq4
         sAlc+hGMe1jwErpPZPPV8yw9Z5G8s8lP2vYTCNWJAuCg0SazTeO9WH2S2W/CSBEXGxa3
         7sx0u9CXC81hKmSf8sJZ0ttHVcb2z3PhRAmZ7kz/hrIDwDnjv1s7ZNSJzggB/uz9NK14
         Blrg==
Received: by 10.60.27.134 with SMTP id t6mr407889oeg.70.1337885952897; Thu, 24
 May 2012 11:59:12 -0700 (PDT)
Received: by 10.182.67.168 with HTTP; Thu, 24 May 2012 11:58:25 -0700 (PDT)
In-Reply-To: <1337830657-16400-3-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198408>

On Wed, May 23, 2012 at 11:37 PM, Jon Seymour <jon.seymour@gmail.com> w=
rote:
> -# Resolve relative url by appending to parent's url
> +# Resolve relative url by appending the submodule url
> +# to the superproject's origin URL
> +#
> +# If the origin URL is itself a relative URL prepend
> +# an additional prefix, if present, that represents
> +# the relative path from the submodule's working tree
> +# to the superprojects' working tree.
> +#
> +# This behaviour is required to ensure that the origin URL

"Required behavior" always seems overstated to me when I
read it in comments and so I tend to distrust it.  I'd prefer to
see "This behaviour is intended to ensure..."  But this is
only my personal preference.


> +# of a submodule, when relative, is relative to the
> +# submodule's work tree and not to the superproject's work tree.
> +#
> =A0resolve_relative_url ()
> =A0{
> =A0 =A0 =A0 =A0remote=3D$(get_default_remote)
> =A0 =A0 =A0 =A0remoteurl=3D$(git config "remote.$remote.url") ||
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0remoteurl=3D$(pwd) # the repository is=
 its own authoritative upstream
> =A0 =A0 =A0 =A0url=3D"$1"
> + =A0 =A0 =A0 up_path=3D"$2"
> +
> + =A0 =A0 =A0 #
> + =A0 =A0 =A0 # ensure all relative paths begin with ./ to enable

Are we talking about remote urls or local filesystem paths?  I think th=
is
is all confusing enough without the comments also using terminology
inconsistently.  Would it be more correct to say "all relatiive urls" h=
ere?
Or is this function only interested in local filesystem paths?

I realize that urls are paths of a different nature.  I pick this nit
only in the cause of clarity.

> + =A0 =A0 =A0 # selection relative branch of subsequent case "$remote=
url"
> + =A0 =A0 =A0 # statement.
> + =A0 =A0 =A0 #
> + =A0 =A0 =A0 # rewrites foo/bar to ./foo/bar but leaves /foo, :foo .=
/foo
> + =A0 =A0 =A0 # and ../foo untouched.
> + =A0 =A0 =A0 #

In many filesystems, ":foo" and "\foo" are valid filenames.
I suspect it is unwise to employ them and expect them not
to cause trouble, so I don't know if we should make
special efforts to accept them here.  But I think it
is worth noting.

On the other hand, I do not know how these special
characters are represented in urls.

> + =A0 =A0 =A0 remoteurl=3D$(echo "$remoteurl" | sed "s|^[^/:\\.][^:]*=
\$|./&|")
> =A0 =A0 =A0 =A0remoteurl=3D${remoteurl%/}
> =A0 =A0 =A0 =A0sep=3D/
> =A0 =A0 =A0 =A0while test -n "$url"
> @@ -45,6 +67,16 @@ resolve_relative_url ()
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0../*)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0url=3D"${url#../}"
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0case "$remoteurl" in
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .*/*)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 # remov=
e last part
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 remoteu=
rl=3D"${remoteurl%/*}"
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 # remov=
e redundant leading ./
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 remoteu=
rl=3D"${remoteurl#./}"
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 # prefi=
x path from submodule work tree to superproject work tree
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 remoteu=
rl=3D"${up_path}${remoteurl}"

Here we seem to be talking about paths since we are concerned
with the worktrees.  So maybe my earlier concern about "urls"
vs. "paths" was miguided.  My head swims.


> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 # remov=
e trailing /.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 remoteu=
rl=3D"${remoteurl%/.}"
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ;;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/*)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0remote=
url=3D"${remoteurl%/*}"
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0;;

I haven't tested it, but the rest of this is making more sense to me no=
w.

Phil
