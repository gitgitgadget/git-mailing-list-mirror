From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: git bug(?) for commit baf18fc261ca475343fe3cb9cd2c0dded4bc1bb7
Date: Mon, 7 Nov 2011 16:30:00 +0700
Message-ID: <CACsJy8C25qurZwTLuuZ8X4EUzg-NP_qwFjcPTZoEs7QOOS-WBA@mail.gmail.com>
References: <BC404302028E4B6F8F2C27DC8E63545F@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Tony Wang <wwwjfy@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 07 10:30:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNLXI-0006ZP-QG
	for gcvg-git-2@lo.gmane.org; Mon, 07 Nov 2011 10:30:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752707Ab1KGJac convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Nov 2011 04:30:32 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:41884 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751734Ab1KGJab convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Nov 2011 04:30:31 -0500
Received: by bke11 with SMTP id 11so3409507bke.19
        for <git@vger.kernel.org>; Mon, 07 Nov 2011 01:30:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=WRECk7L1EjQDas7Lce1kXt9jmQ4UbjeUc2g5w9yWQY0=;
        b=ljgEfQzJqE4B/1o74kPc2JkwsoJA8s4+MjQD/I73lYz7ZxBRPoXrn6FtNUUfntHHEk
         IHuKc0h8Na8NnqB4ViFPTMdE2q0bpW2a7PMRedcsrGkvUxiXnxIxS0klKEj0hdN/IZzM
         zUJR2c5hFzraw2Ufh75DwZKatcN9DadBksEq4=
Received: by 10.204.16.67 with SMTP id n3mr18419898bka.6.1320658230112; Mon,
 07 Nov 2011 01:30:30 -0800 (PST)
Received: by 10.205.134.1 with HTTP; Mon, 7 Nov 2011 01:30:00 -0800 (PST)
In-Reply-To: <BC404302028E4B6F8F2C27DC8E63545F@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184963>

Hi,

On Mon, Nov 7, 2011 at 3:59 PM, Tony Wang <wwwjfy@gmail.com> wrote:
> Hi,
> I don't know if a better way to report this, so I write to the author=
 of the
> commit. Please let me know if I do wrong. :)

It's good that you bisect to the broken commit and send me. However
you should always send to git@vger just in case I'm unavailable.

> The thing is the commit=C2=A0baf18fc261ca475343fe3cb9cd2c0dded4bc1bb7=
 made an
> option broken sometimes (it's weird, but it's true that it didn't hap=
pen
> every time)
> I set "branch.master.mergeoptions=3D--squash" in config, but when I d=
o "git
> merge b", the squash didn't work, however, "git merge b --squash" wor=
ks as
> expected.

What was the expection? --squash was not effective or something else?

> I tried to debug, and found after this
> merge.c:1104
> head_commit =3D lookup_commit_or_die(head_sha1, "HEAD");
> the variable branch becomes "s/origin/b", which is previously "b".
> I used git bisect and found the
> commit=C2=A0baf18fc261ca475343fe3cb9cd2c0dded4bc1bb7 caused this.

Variable "head_sha1"? Strange because lookup_commit_or_die() takes
"const char *" and the compiler should catch any attempts to change
the variable.

If you can reproduce it, can you make a small test case to demonstrate
it? I'm not sure what "b" is and how you set up configuration for
branch master. BTW what git version did you use?

> I browsed the diff, and found the function=C2=A0lookup_commit_or_die
> uses=C2=A0lookup_commit_reference, but not=C2=A0lookup_commit which w=
as used
> before=C2=A0lookup_commit_or_die replaced it.
> Was it on purpose or typo?

It was on purpose. HEAD may contain a tag, in which case
lookup_commit() would to return a commit fail while
lookup_commit_reference() can peel the tag to the commit.

> If possible, it'll be good that I can know some details.
> Thanks!
--=20
Duy
