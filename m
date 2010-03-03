From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: Re: 3 failures on test t9100 (svn)
Date: Wed, 3 Mar 2010 01:58:04 +0100
Message-ID: <20100303005804.GA17120@vidovic>
References: <20100302194518.GA12942@vidovic> <20100302212806.GA21413@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 03 01:58:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nmcut-0001DF-Gs
	for gcvg-git-2@lo.gmane.org; Wed, 03 Mar 2010 01:58:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755140Ab0CCA6Q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Mar 2010 19:58:16 -0500
Received: from mail-bw0-f209.google.com ([209.85.218.209]:54399 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755070Ab0CCA6P (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Mar 2010 19:58:15 -0500
Received: by bwz1 with SMTP id 1so314924bwz.21
        for <git@vger.kernel.org>; Tue, 02 Mar 2010 16:58:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=EAJRDY8h2Aytn+kgZispHjzUOq7yl2v3li0H4/NFWTA=;
        b=hSOQNPnu+u7hFuS4zgZVLZmOuWt70n6NvkgoxWzP6SDXcnOZ9M3eO623p7IrZzF5nQ
         lBHVzGPptIFixCyQPnP5L8pF34E7ckQ9/Z5s1kAiEqJRxxiqo9qlTK/hdezxoMn+Oe57
         C6Nc0b51IygvfyVRHH5gNMiUO+yjbm3KdNr+g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=VbRchJPzXYHIf6sTdSwaQcIroslV3p7RrolI0fpZSKF4M+XG9ZtBc0V6E+swHWYIbC
         kNNjoNmIZDCOcEvJZ92nuiH+cQrl63RPzmolVfMXMJjCd77agNGgGp8oVDt+4bCqbiYZ
         reF1EbBEon9OlJf0BITLG3NHs+CUSj3Poz1WY=
Received: by 10.204.130.72 with SMTP id r8mr5435534bks.25.1267577892948;
        Tue, 02 Mar 2010 16:58:12 -0800 (PST)
Received: from @ (91-164-132-214.rev.libertysurf.net [91.164.132.214])
        by mx.google.com with ESMTPS id a15sm6306588bke.7.2010.03.02.16.58.06
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 02 Mar 2010 16:58:08 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20100302212806.GA21413@coredump.intra.peff.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141425>

The 02/03/10, Jeff King wrote:
> On Tue, Mar 02, 2010 at 08:45:18PM +0100, Nicolas Sebrecht wrote:
>=20
> > Some tests in t9100 don't pass here with current next (full log
> > attached). Any idea?
> > [...]
> >   test_cmp:1: command not found: diff -u
>=20
> Probably related to this line. Assuming you have "diff" in your PATH,

  $ which diff
  /usr/bin/diff
  $ diff --version
  diff (GNU diffutils) 2.8.7

> based on that message I would guess that your shell is trying to exec=
ute
> "diff -u" as a single file, which obviously won't work. The relevant
> code in test-lib.sh is something like:
>=20
>   GIT_TEST_CMP=3D'diff -u'
>   test_cmp() {
>     $GIT_TEST_CMP "$@"
>   }
>=20
> which _should_ split the "diff -u" on whitespace.

I've tried with these exact lines without more success.

>                                                   What platform are y=
ou
> on? Which shell is /bin/sh on your system?

I'm running Gentoo. I had

  $ ls -ld $(which sh)
  lrwxrwxrwx 1 root root 4 f=E9vr. 13  2009 /bin/sh -> bash
  $ bash --version
  GNU bash, version 3.2.39(1)-release (x86_64-pc-linux-gnu)

I've changed the symbolic link to point to /bin/zsh (my every day shell=
)
but this didn't help.

  $ zsh --version
  zsh 4.3.9 (x86_64-pc-linux-gnu)

I think your diagnosis is right or very near from the problem. But I
would have expected that changing to another shell did the trick. Odd.


That said, I did the svn tests because sometimes I have reproductible
errors with 'git svn fetch' or 'git svn clone'. I'm not sure how both
problems could be related... git-svn is a Perl script. The given messag=
e
for this one is "error: died with signal 11" from what I remember (but
I'm sure about the "signal 11" part).

I'll do more investigations at work tomorrow. I've already tried to add
the "-d" flag in git-svn and it didn't help neither: git looked like in
an infinite loop. Odd, odd, odd.

--=20
Nicolas Sebrecht
