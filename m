From: Al Haraka <alharaka@gmail.com>
Subject: Re: Gitweb 1.7.5 and Textconv Configuration
Date: Sat, 2 Jul 2011 22:18:55 +0300
Message-ID: <CALWDD1zrOUwS2FeQs1SsFuLnaDzhCHZVFLvFXv7aLex1K2v5zw@mail.gmail.com>
References: <CALWDD1x-_rEx+c9bpAgVk-hvnGz1bt0mbJoDkSjZkbe=gLscUg@mail.gmail.com>
	<20110702104313.GA10245@sigill.intra.peff.net>
	<20110702104437.GA10538@sigill.intra.peff.net>
	<CALWDD1woB0ytL6T-DwD92f824dnpz0mek=SYgz5jwqR0efnkpw@mail.gmail.com>
	<20110702185724.GA14390@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jul 02 21:19:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qd5if-0002lv-EY
	for gcvg-git-2@lo.gmane.org; Sat, 02 Jul 2011 21:19:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752832Ab1GBTS5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 2 Jul 2011 15:18:57 -0400
Received: from mail-fx0-f52.google.com ([209.85.161.52]:52784 "EHLO
	mail-fx0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752303Ab1GBTS4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 2 Jul 2011 15:18:56 -0400
Received: by fxd18 with SMTP id 18so4122552fxd.11
        for <git@vger.kernel.org>; Sat, 02 Jul 2011 12:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=Zksi00d3Xzp3c6sa5EXUjp6hFNR5m/W5/JILwesxNXs=;
        b=kncxMV0Hzyziw9Gj6d4KKThpPcrjGHOx19vQMWus5nNyfMmjbKmUXT+ApUWtQ51PVq
         ZMImCvgXL2wuMqUIKhbWj+7PMgLOwW/UmAhSplHFutce1/O06ZVM1o3pBq1t2iX/94Z2
         ghiOBLUr0HtMo4Fcvi7ZFaeLMtOrctE9M4zCc=
Received: by 10.223.75.138 with SMTP id y10mr6803843faj.36.1309634335356; Sat,
 02 Jul 2011 12:18:55 -0700 (PDT)
Received: by 10.223.101.207 with HTTP; Sat, 2 Jul 2011 12:18:55 -0700 (PDT)
In-Reply-To: <20110702185724.GA14390@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176565>

On Sat, Jul 2, 2011 at 9:57 PM, Jeff King <peff@peff.net> wrote:
> You could try setting "$ENV{GIT_TRACE} =3D 1", which will dump all of=
 the
> git commands being called to stderr (and presumaby your log). That wo=
uld
> double-check that the option is being passed.

Great.  Thanks for the tip.

> I think what might be happening, though, is that git does not do a go=
od
> job checking .gitattributes files inside trees; it only checks the
> .gitattributes in the working tree, even if you are diffing a tree. B=
ut
> in the case of a bare repository, we don't even have a working tree a=
t
> all.
>
> You can try working around it like this:
>
> =C2=A0cd /path/to/bare/repo.git
> =C2=A0git show HEAD:.gitattributes >info/attributes

This did not work, for what I think might be an obvious reason; I do
not have a .gitattributes file *in* the repo or any repos anymore, but
a global one.  See below.

[dreamhost-server]$ git show HEAD:.gitattributes >info/attributes
fatal: Path '.gitattributes' exists on disk, but not in 'HEAD'.

> which will make the repository-wide non-version-controlled gitattribu=
tes
> the same as the last committed version. The problem is that it won't =
be
> automatically updated as you commit and push changes to .gitattribute=
s.

I thought my plan was to try and avoid this by using the
core.attributesfile directive, forcing this stuff to operate system
(well, account, besides the point here) wide on all repos with
specifying a .gitattributes (or, since it base bare, as you pointed
out yourself, $GIT_REPO_DIR/info/attributes) every single time.  Did I
misunderstand the mailing list thread that mentioned this a while
back?

[dreamhost-server]$ git config --list --global
diff.odf.textconv=3Dodt2txt
diff.odf.binary=3Dfalse
diff.pdf.textconv=3Dpdftotext
diff.pdf.binary=3Dfalse
core.attributesfile=3D~/.gitattributes

Inside one of the troublesome repos (so resultant collection of global
and repo-specific config):

[dreamhost-server]$ git config --list
diff.odf.textconv=3Dodt2txt
diff.odf.binary=3Dfalse
diff.pdf.textconv=3Dpdftotext
diff.pdf.binary=3Dfalse
core.attributesfile=3D~/.gitattributes
core.repositoryformatversion=3D0
core.filemode=3Dtrue
core.bare=3Dtrue
gitweb.owner=3Dalharaka@gmail.com
diff.odf.textconv=3Dodt2txt

This is the reason I went through the trouble of compiling an updated
version in my account (as opposed to the installed version on the
Dreamhost box; they are stuck at version 1.7.1.1; I saw this mentioned
on a thread somewhere and wanted to get the "latest" (well latest
stable version) to avoid this kind of problem?  Was that the right
thing to do?  Will it even work in this case?  I get the feeling from
your response I was expecting a lot with RTFM'ing more.  I have a
script, as described in the Github HOWTO, that creates the bare repo
as desired for me.  So, if this will not work, I will just modify my
version of the bash script to handle this.  I just am obviously not
sure what the "proper" approach or best practice is anymore.

Thanks again for your help.  I really appreciate it.  I am new to git,
but LOVE what you guys have being doing.  I never used any DRCS before
this, personally or professionally, but read snippets of howtos and so
much good press I decided it was time I mooch off you guys to organize
my life.  :-)
