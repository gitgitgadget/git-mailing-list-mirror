From: =?UTF-8?B?w5h5dmluZCBBLiBIb2xt?= <sunny@sunbase.org>
Subject: Re: t5150-request-pull.sh fails on newest master in Debian
Date: Sat, 5 Jul 2014 16:24:52 +0200
Message-ID: <CAA787rnMonCuON+C0U5FDXKzjTBdpOusCpGLeWytDWaA1torEw@mail.gmail.com>
References: <CAA787r=78UWio3E==s+J2PbVqshQdWXpS9hiJrmNz+F0vLiuGg@mail.gmail.com>
	<1404505370.3109.15.camel@stross>
	<CAA787rmf36V1=Sd8TZrc7DboTkeJDYKuEGgCe90mZLLKSp6=tw@mail.gmail.com>
	<1404525502.3109.25.camel@stross>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Sat Jul 05 16:25:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X3Qu2-0004gR-7H
	for gcvg-git-2@plane.gmane.org; Sat, 05 Jul 2014 16:25:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752222AbaGEOYz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 5 Jul 2014 10:24:55 -0400
Received: from mail-la0-f41.google.com ([209.85.215.41]:46525 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751309AbaGEOYy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 Jul 2014 10:24:54 -0400
Received: by mail-la0-f41.google.com with SMTP id hz20so1791918lab.28
        for <git@vger.kernel.org>; Sat, 05 Jul 2014 07:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=f9KF27YU4T4UV/4m1X5+UIPEIqBKWxave+/ut1lOpBE=;
        b=BCoJm8WlwOFppVvpcv/ZBK+qczUIbSwVlLqbAU2JPY6lP5b5CaUOILCr2Xm2TWCqQg
         QaTlPFoY6XoYKEoCC93qVCVU1uXlHOPsXsIDrZOEthjk/2crt836Fq7JOjX+ZEIjHTIQ
         KxNCVteJdE5pOhjky9Up+1V0BdQXyMqPCj96xaKuvS1HQU35ScYpiIN/PMCO9yO6G+Su
         HH1YQcMVDF3yAEbTdFerHVELE2LgSCyAcZpw57eZyICFSrHcs8TtuxZtX85xye9dCqba
         Kf5zSP59uXh3jEXV5WYRpNHG8CFlF2jxgJKuHiWTdddLq6nPftz3Epd2akykgCqXAOwz
         mKwg==
X-Received: by 10.152.1.99 with SMTP id 3mr13620418lal.43.1404570292533; Sat,
 05 Jul 2014 07:24:52 -0700 (PDT)
Received: by 10.112.142.7 with HTTP; Sat, 5 Jul 2014 07:24:52 -0700 (PDT)
In-Reply-To: <1404525502.3109.25.camel@stross>
X-Google-Sender-Auth: w73OBIMVkKnQnisF4nnrtOLNlBg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252917>

On 5 July 2014 03:58, David Turner <dturner@twopensource.com> wrote:
> On Sat, 2014-07-05 at 02:09 +0200, =C3=98yvind A. Holm wrote:
> <snip>
> > The test works. Seems as there's something fishy about the use of
> > --prefix in this specific commit (v2.0.1-472-g6f92e5f).
>
> Ok, now I can reproduce on my linode box (haven't tried it locally
> yet). I'll try to get a fix up once I figure out what's up.

Awesome. I've done some more "./configure --prefix" testing, and this i=
s
the result:

  # --prefix is set to non-existing directory
  ./configure --prefix=3D/usr/local/varprg/git.master.v2.0.1-472-g6f92e=
5f
    # ./t5150-request-pull.sh fails.

  # --prefix is set to non-existing directory, use trailing slash
  ./configure --prefix=3D/usr/local/varprg/git.master.v2.0.1-472-g6f92e=
5f/
    # ./t5150-request-pull.sh fails.

  # --prefix is set to existing directory
  ./configure --prefix=3D/usr/local/varprg/git.master.v2.0.1-442-g7fe68=
34
    # ./t5150-request-pull.sh fails.

  # --prefix is set to existing directory
  ./configure --prefix=3D/usr/local
    # ./t5150-request-pull.sh succeeds.

  # --prefix is set to existing directory
  ./configure --prefix=3D/usr/local/varprg
    # ./t5150-request-pull.sh succeeds.

  # --prefix is set to non-existing directory
  ./configure --prefix=3D/usr/local/varprg/a-long-directory-name-which-=
does-not-exist
    # ./t5150-request-pull.sh succeeds.

  ./configure --prefix=3D/usr/local/varprg/git.master.a-long-directory-=
name-which-does-not-exist
    # ./t5150-request-pull.sh succeeds.

So it's something with names like "git.master.v2.0.1-472-g6f92e5f" that
"./configure --prefix" is picky about.

When testing this last night, I pushed the following branches to
<https://github.com/sunny256/git> where I added all compiled files in
various stages with "git add -f .":

  t5150-fail.configure-without-prefix
    Succeeds.
    "./configure"

  t5150-fail.configure-with-prefix
    Fails.
    "./configure --prefix=3D/usr/local/varprg/git.master.v2.0.1-472-g6f=
92e5f"

  t5150-fail.configure-prefix-usr-local
    Succeeds.
    "./configure --prefix=3D/usr/local"

Maybe something will turn up by diffing those branches. I've got to
leave for now, but will have a look at this later tonight.

Cheers,
=C3=98yvind
