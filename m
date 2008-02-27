From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
Subject: Re: [PATCHv2] clone: support cloning full bundles
Date: Thu, 28 Feb 2008 00:16:40 +0100
Message-ID: <8aa486160802271516h7c2c636dna3a9f067fc51da2@mail.gmail.com>
References: <1203934349-12125-1-git-send-email-sbejar@gmail.com>
	 <7v63waqasu.fsf@gitster.siamese.dyndns.org>
	 <8aa486160802271504r7744422ag290b1f4d1725210f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 28 00:17:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUVWg-0004gK-Qu
	for gcvg-git-2@gmane.org; Thu, 28 Feb 2008 00:17:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758030AbYB0XQp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Feb 2008 18:16:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756936AbYB0XQo
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Feb 2008 18:16:44 -0500
Received: from ti-out-0910.google.com ([209.85.142.191]:41317 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756973AbYB0XQn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Feb 2008 18:16:43 -0500
Received: by ti-out-0910.google.com with SMTP id 28so2431220tif.23
        for <git@vger.kernel.org>; Wed, 27 Feb 2008 15:16:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=QtivQq14tijyCHTqP0kmB88Deba12BQYWG53mfn2nzQ=;
        b=kiyDXtcAeiqUbCdel60rrU/l4ILtRPSu42UvZ/9PcasyTTbSMfZTN68u4uCIIbN/YNWgGqDZbTIJvBH7dMRCA8WwSnyDOPJLwlgQ39sydMflAC7hR9evu2O2kBOPVqJMhWjLsvR+QBkBo2ABDyVUcb/ddZbjKI2tB34oPtlpFCI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bHyOq7meHayj1e26jXK7DpZg72sfPhnL34kbNPod5UM06FNN2Rq/Ugbe/7LsWlAXdq+Oco2b55SRWca1E5655N5lyXIy1O07eGYj+JdLN6PtuHDT/fIanz1ugvIAmdi4FQXmIX8XW4GHm3gGbflVnajT+nL+dk+tMC2Us9Qoi3A=
Received: by 10.150.138.8 with SMTP id l8mr2562659ybd.72.1204154200395;
        Wed, 27 Feb 2008 15:16:40 -0800 (PST)
Received: by 10.150.205.9 with HTTP; Wed, 27 Feb 2008 15:16:40 -0800 (PST)
In-Reply-To: <8aa486160802271504r7744422ag290b1f4d1725210f@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75321>

On Thu, Feb 28, 2008 at 12:04 AM, Santi B=E9jar <sbejar@gmail.com> wrot=
e:
>
> On Wed, Feb 27, 2008 at 11:44 PM, Junio C Hamano <gitster@pobox.com> =
wrote:
>  > Santi B=E9jar <sbejar@gmail.com> writes:
>  >
>  >  > Signed-off-by: Santi B=E9jar <sbejar@gmail.com>
>  >
>  > > diff --git a/git-clone.sh b/git-clone.sh
>  >  > index 0d686c3..2efb947 100755
>  >  > --- a/git-clone.sh
>  >  > +++ b/git-clone.sh
>  >  > @@ -210,11 +210,14 @@ if base=3D$(get_repo_base "$repo"); then
>  >  >       then
>  >  >               local=3Dyes
>  >  >       fi
>  >  > +elif [ -f "$repo" ] ; then
>  >  > +     case "$repo" in /*);; *) repo=3D"$PWD/$repo" ; esac
>  >  >  fi
>  >  >
>  >  >  dir=3D"$2"
>  >  >  # Try using "humanish" part of source repo if user didn't spec=
ify one
>  >  >  [ -z "$dir" ] && dir=3D$(echo "$repo" | sed -e 's|/$||' -e 's|=
:*/*\.git$||' -e 's|.*[/:]||g')
>  >  > +[ -f "$dir" ] && dir=3D$(expr "$repo" : '.*/\([^/]*\)\.[^/]*')
>  >  >  [ -e "$dir" ] && die "destination directory '$dir' already exi=
sts."
>  >  >  [ yes =3D "$bare" ] && unset GIT_WORK_TREE
>  >  >  [ -n "$GIT_WORK_TREE" ] && [ -e "$GIT_WORK_TREE" ] &&
>  >
>  >  What is this [ -f "$dir" ] line doing?  The purpose of these
>  >  lines is:
>  >
>  >   - The user (might have) said "clone to $2";
>  >
>  >   - If the user didn't, then set dir to humanish part;
>  >
>  >   - If that exists, we barf.
>  >
>  >  I do not see any valid reason for an additional logic in this
>  >  sequence when adding a new clone _source_ type.
>  >
>  >  The check to see if "$dir" _exists_ is even worse.  If the user
>  >  said "clone _to_ this", then we would not have invented $dir
>  >  based on the $repo (which is what the user said "clone _from_")
>  >  but used whatever name the user has given us.  The existing
>  >  check to barf "Hey, that explicit location you told me to clone
>  >  to is WRONG!!!" should not be broken.
>  >
>
>  Oops, I did not thought about that possibility. The check was to be
>  able to clone a bundle that was in the local directory. So:
>
>  $ git clone git.bundle
>
>  clones git.bundle to the directory git. Maybe we can add an && in th=
e
>  previous line

and check for [ -f "$repo" ] insted of [ -f "$dir" ]

>  , or we can say simply that to clone a bundle in the same
>  directory you have to specify explicitly where to clone.
>
>  In another patch we could add an "official" extension to the bundles
>  (the same way as with the repositories "*.git") as project.bdl or
>  project.bundle and just remove this extension.

My preference are in order:

1) define an official extension + the && [ -f "$repo" ]
2) the && [ -f "$repo"]
3) just remove this line

but not that strong.

Santi
