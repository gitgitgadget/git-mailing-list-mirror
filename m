From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 00/12] Support columinized output in tag/branch/ls-files/grep
Date: Wed, 10 Mar 2010 07:27:10 +0700
Message-ID: <fcaeb9bf1003091627p65ad6e60u4bbae2eb4e859f13@mail.gmail.com>
References: <1267963785-473-1-git-send-email-pclouds@gmail.com>
	 <4B9504C9.5000703@lsrfire.ath.cx>
	 <fcaeb9bf1003080632o622c8c79x85b816edcf893bc3@mail.gmail.com>
	 <4B967C36.90309@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Wed Mar 10 01:27:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Np9ld-0000I7-Hq
	for gcvg-git-2@lo.gmane.org; Wed, 10 Mar 2010 01:27:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755994Ab0CJA1P convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Mar 2010 19:27:15 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:40865 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755788Ab0CJA1M convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Mar 2010 19:27:12 -0500
Received: by pwj5 with SMTP id 5so116058pwj.19
        for <git@vger.kernel.org>; Tue, 09 Mar 2010 16:27:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=LIsKIw7tivbG7cGHkjE0gEZ7QH+vZPd57G5P1O1geEY=;
        b=Auz+euY3a2XIPxKNgW/O8z/vaXA71rpvo6bvYl1yVQW6nk0bXpjTw+Z0iLtsgO8Wmo
         V6hy9Nf1Mu9DgFPng/HtfuHm5ukKXUI6GZ/BrkqwdBbUTgLM75/98NUmh2PI52HcBPfC
         kHXtM5uMfOWmVP4K6D8kAZ+/L+RdVzpy8brkM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Xl/qRAGTQaXZ6Mb5rxWjxnEfYMPS5PF0lU9yt5ckYmpck/yo/8HQtZt5pEI26yp8LV
         M9QOZW5aOXAfaCS+7piQn0rtxUpyKBxiHUzf7novTNA43EW2yjbYL7RNXDgTfE/r+meD
         BOSS47GLTZ6TysMuwngi8aeDWBgVVPvi1dZAg=
Received: by 10.115.66.3 with SMTP id t3mr343011wak.101.1268180831087; Tue, 09 
	Mar 2010 16:27:11 -0800 (PST)
In-Reply-To: <4B967C36.90309@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141859>

On 3/9/10, Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> wrote:
> Am 08.03.2010 15:32, schrieb Nguyen Thai Ngoc Duy:
>
> > On 3/8/10, Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> wrote:
>
> >>  I'm not so sure about the interface, though.  Does the task reall=
y
>  >>  warrant adding a new git command?
>  >
>  > Several reasons:
>  >  - Can be reused outside of git (I was surprised Solaris did not h=
ave "column")
>
>
> Granted, we have a precedent: git stripspace.  But I don't like that
>  one, either. ;)  If it's not specific to git, then it should not be =
a
>  git command.
>
>  Perhaps name it git-column--helper, so that it can still be used by =
git
>  commands that are implemented as scripts?

OK.

>
>  >  - Easier to test
>
>  Name it test-column?

If it turns out no external process is needed for column layout.

>  >  - Minimum code change in modifed commands
>
>
> OK, forking out is easy, but replacing printf() calls with calls to f=
eed
>  the columnizer shouldn't be _that_ intrusive, either.

Well, also fwrite() and write(). If disliked "if (blah) feed_it();
else printf(as normal);" construct. But we can wrap it to
feed_or_printf(). We may also need to buffer printf() results until a
full line is received. Let me try and see how intrusive it is.

>  >  - I can play with more complicated column layout, with minimum co=
de
>  > change in git (ok, that's the third reason).
>
>
> This is possible regardless of the way how the columnizer is invoked =
if
>  its full functionality is exposed through the command line parameter=
=2E
>
>  With "more complicated", do you perhaps mean what GNU ls does, namel=
y
>  having non-uniform column widths?  I never consciously noticed that =
it
>  actually goes out of its way to cram as may columns on the screen as
>  possible, it just feels so natural. :)

That. And aligned grep output like this

pclouds@do ~/w/git/builtin $ git grep -n 38
count-objects.c  |  35 |                if (cp - ent->d_name !=3D 38)
count-objects.c  |  39 |                        memcpy(path + len + 3,
ent->d_name, 38);
count-objects.c  |  59 |                memcpy(hex+2, ent->d_name, 38);
fsck.c           | 405 |                if (strlen(de->d_name) =3D=3D 3=
8) {
gc.c             | 112 |                if (strspn(ent->d_name,
"0123456789abcdef") !=3D 38 ||
gc.c             | 113 |                    ent->d_name[38] !=3D '\0')
prune-packed.c   |  24 |                if (strlen(de->d_name) !=3D 38)
prune-packed.c   |  26 |                memcpy(hex+2, de->d_name, 38);
prune-packed.c   |  31 |                memcpy(pathname + len, de->d_na=
me, 38);
prune.c          |  64 |                if (strlen(de->d_name) =3D=3D 3=
8) {
receive-pack.c   | 588 |        char hdr_arg[38];
upload-archive.c |  86 |        char buf[16384];

>  >>  If a --column parameter is added, I think it should expose the f=
ull
>  >>  range of options, i.e. fill columns first (ls -C style), fill ro=
ws first
>  >>  (ls -x style) as well as off (ls -1 style) and auto.
>  >
>  > Maybe an env variable would be better, so you can pass abitrary
>  > arguments to git-column. "--column=3Dauto" should be supported, of
>  > course.
>
>
> I don't see any benefit of an environment variable over config option=
s.

Currently we may pass --column=3D<foo> from a porcelain to "git column
--mode=3D<foo>", <foo> could be column first, or row first, or either
with non-uniform columns (not implemented yet). We can also pass other
things to "git column". Putting everything in "<foo>" is OK, although
looks ugly. In my private tree, I also have "git column
--min-rows/--max-items" that forces the columnizer to one column mode
if:
 - there will be only one or two rows after columnized, too wide
screen for example (--min-rows)
 - too many lines and the layout has not been fixed, so nothing gets
printed (--max-items). Forcing back to one column mode to stop wait
time.
--=20
Duy
