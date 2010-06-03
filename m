From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Bug? "git branch" failing to list all branches
Date: Wed, 2 Jun 2010 23:22:18 -0500
Message-ID: <20100603042218.GA21254@progeny.tock>
References: <AANLkTimTOucIfzSxsYNvmML7MALwj0E3BUASIIKIN1lN@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Simo Melenius <simo.melenius@iki.fi>
X-From: git-owner@vger.kernel.org Thu Jun 03 06:22:15 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OK1wb-0004Yv-Lq
	for gcvg-git-2@lo.gmane.org; Thu, 03 Jun 2010 06:22:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751176Ab0FCEWJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Jun 2010 00:22:09 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:52532 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750777Ab0FCEWH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jun 2010 00:22:07 -0400
Received: by iwn6 with SMTP id 6so1618623iwn.19
        for <git@vger.kernel.org>; Wed, 02 Jun 2010 21:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=ZWTcAHhKjn8w1JskDyj+hcUVqIDGLhPEVVaflJkP3SI=;
        b=rQBJk0sKxOLaHYtQHwzRh2EaF6OHonTH4SisnMQGnpKlQh15S/KJxoWRp47SSAFpCI
         mHxOID20KJQqek0HafyKyix+9SJBF/9lMMNb2UDA3nLq3pvg5eAATZYvtCr1m/cqLdAr
         wKMfHn5fZ3+DyxWeIMSQhgklhKgvpgFScOdeY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=GdCWURTrun57xaXl8BiN64RHOq3Y6CP1CUR/18eb0XhwAqpxF8H3iPHMMPJ7h8/bPp
         rRaYOTLdxNCPm8F5i0EcyWccxBVKljXBbLDK2iuepqHaqf7qOaodPZg1d7i7udt76Bwp
         OvExDBjCSGl2JJbOi52warxK4Tq1Og+hz47Hk=
Received: by 10.231.125.223 with SMTP id z31mr11079079ibr.78.1275538923557;
        Wed, 02 Jun 2010 21:22:03 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id r12sm2395854ibi.14.2010.06.02.21.22.02
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 02 Jun 2010 21:22:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTimTOucIfzSxsYNvmML7MALwj0E3BUASIIKIN1lN@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148290>

Hi Simo,

Simo Melenius wrote:

> I noticed this because "git branch -a" and "git branch -av"
> unexpectedly gave a very different output.

Hmm --- so the error message must not have been very visible...

> When listing branches, "git branch" will in certain cases terminate
> iteration at the first broken ref that doesn't point to a commit.

Even in a broken repository, the full branch list would be useful for
getting one=E2=80=99s bearings.  Thanks.

>                 commit =3D lookup_commit_reference_gently(sha1, 1);
>                 if (!commit)
> -                       return error("branch '%s' does not point at a
> commit", refname);
> +               {
> +                       error("branch '%s' does not point at a
> commit", refname);
> +                       return 0;
> +               }

Will this make =E2=80=98git branch=E2=80=99 exit with status zero?  Scr=
ipts and people
with fancy prompts benefit from a nonzero exit status.

If I have 37 branches and an error is encountered looking up one of
them, with this patch the error message will scroll off the screen.
Is this worth worrying about?  It depends on what the usual causes for
broken branch refs are and whether they require attention or can be
safely ignored.

One other thought: this patch is line-wrapped, which means it cannot
be mechanically applied.  Documentation/SubmittingPatches has some
tips on sending a patch unmangled (and please also see the section
labelled "Sign your work").

Cheers,
Jonathan
