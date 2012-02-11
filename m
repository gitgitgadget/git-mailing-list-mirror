From: =?UTF-8?B?TWljaGHFgg==?= Kiedrowicz <michal.kiedrowicz@gmail.com>
Subject: Re: [PATCH 1/8] gitweb: Extract print_sidebyside_diff_lines()
Date: Sun, 12 Feb 2012 00:03:25 +0100
Message-ID: <20120212000325.2f6bc9f0@gmail.com>
References: <1328865494-24415-1-git-send-email-michal.kiedrowicz@gmail.com>
	<1328865494-24415-2-git-send-email-michal.kiedrowicz@gmail.com>
	<m3obt5tn0g.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 12 00:03:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RwLyi-0001Pf-LD
	for gcvg-git-2@plane.gmane.org; Sun, 12 Feb 2012 00:03:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754931Ab2BKXDb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 11 Feb 2012 18:03:31 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:46172 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754725Ab2BKXDa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 11 Feb 2012 18:03:30 -0500
Received: by eaah12 with SMTP id h12so1341828eaa.19
        for <git@vger.kernel.org>; Sat, 11 Feb 2012 15:03:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        bh=ZXcNFcMAlSSf6E2a8kiUTVRW8TdNl2a2QMpKt2xZKyE=;
        b=UNRPzjheQ9I94CJ0um6LxBmWOg6NMA9mYnzIUnJIbtHELxgZD6LYJgjQmaExAy8U+A
         U/7TFGxKM/ZUcCJKvnGpnbJy+0AkLiLZRg94oXCAhYtLVRoRujPk1jJRP8tDGP+1ROhr
         Z+q8J3Xwd6PXPWE2KOUHzF18cMefmf3VKzCqo=
Received: by 10.213.33.145 with SMTP id h17mr1925900ebd.89.1329001408493;
        Sat, 11 Feb 2012 15:03:28 -0800 (PST)
Received: from localhost (77-177-78-94.net.stream.pl. [94.78.177.77])
        by mx.google.com with ESMTPS id y12sm41001058eeb.11.2012.02.11.15.03.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 11 Feb 2012 15:03:28 -0800 (PST)
In-Reply-To: <m3obt5tn0g.fsf@localhost.localdomain>
X-Mailer: Claws Mail 3.7.10 (GTK+ 2.24.8; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190538>

Jakub Narebski <jnareb@gmail.com> wrote:

> Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com> writes:
>=20
> > Currently, print_sidebyside_diff_chunk() does two things: it
> > accumulates diff lines and prints them. Accumulation may be used to
> > perform additional operations on diff lines, so it makes sense to s=
plit
> > these two things. Thus, the code that prints diff lines in a side-b=
y-side
> > manner is moved out of print_sidebyside_diff_chunk() to a separate
> > subroutine.
> >=20
> > The outcome of this patch is that print_sidebyside_diff_chunk() is =
now
> > much shorter and easier to read.
> >=20
> > This change is meant to be a simple code movement. No behavior chan=
ge is
> > intended.
> >=20
> > Signed-off-by: Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com>
>=20
> As it is pure refactoring, and improves readibility of code quite a
> bit, I am all for it, but...
>=20
> You replace the following set of conditions
>=20
> > -		## print from accumulator when type of class of lines change
> > -		# empty contents block on start rem/add block, or end of chunk
> > -		if (@ctx && (!$class || $class eq 'rem' || $class eq 'add')) {
>=20
> and
>=20
> > -		# empty add/rem block on start context block, or end of chunk
> > -		if ((@rem || @add) && (!$class || $class eq 'ctx')) {
> > -			if (!@add) {
> [...]
> > -			} elsif (!@rem) {
> [...]
> > -			} else {
>=20
>=20
> with these (I have reindented the code to match)
>=20
> > +		## print from accumulator when have some add/rem lines or end
> > +		# of chunk (flush context lines)
> > +		if (((@rem || @add) && $class eq 'ctx') || !$class) {
>=20
> > +                     if (@$ctx) {
> [...]
> > +                     }
> > +                     if (!@$add) {
> [...]
> > +                     } elsif (!@$rem) {
> [...]
> > +                     } else {
>=20
> It is not obvious that the final result is the same.

You are right. I should have described it in the commit message.

>=20
> BTW doesn't new code print context when printing added and removed
> lines, and not as soon as class changes?  This doesn't change the
> output, but it slightly changes behavior.
>=20

This is also true. I'll describe it in the commit message. I could also
create two functions: one that prints @ctx and second one that prints
@rem and @add but then I would have to create two other functions for
inline diff.
