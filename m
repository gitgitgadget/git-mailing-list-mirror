From: Will Palmer <wmpalmer@gmail.com>
Subject: Re: Dangers of reset --hard (Re: Implicit stashes)
Date: Wed, 30 Jun 2010 09:19:32 +0100
Message-ID: <1277885972.2498.25.camel@wpalmer.simply-domain>
References: <AANLkTilTaQP6qARY1A495vm9HAvLVX_lqIQd1l3WIv7a@mail.gmail.com>
	 <20100630051326.GA17497@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: John Tapsell <johnflux@gmail.com>, Git List <git@vger.kernel.org>,
	Stephan Beyer <s-beyer@gmx.net>,
	Christian Couder <chriscool@tuxfamily.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 30 10:19:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OTsWJ-0003eQ-F3
	for gcvg-git-2@lo.gmane.org; Wed, 30 Jun 2010 10:19:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752334Ab0F3ITk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 30 Jun 2010 04:19:40 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:62758 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752313Ab0F3ITi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jun 2010 04:19:38 -0400
Received: by gxk23 with SMTP id 23so247343gxk.19
        for <git@vger.kernel.org>; Wed, 30 Jun 2010 01:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=E56fyhw5RMVZ60UTB/1mug3vAcly4p1uPAqrR5pQnP0=;
        b=I+mtPh4Gzry134UZn3jcaZY52MN9Y9UuK3KszYynnEkBaCLalm7KbllrlXgRcUmNxc
         7BITTm4J0CC+wRzrpXeNL94diI9jEOrthoAt6izUbFeZbnVXJ1JtycLaS7jURWM11muQ
         o9H4lPaKxD2HHmxRDbbDMqCPL0IzIv6rBalYE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:in-reply-to:references:content-type:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        b=KSbCMU2dh3yreIbN5WyBvl7gfsvodPSYYN81mwcIRrfMxp8u8bjIVWYk+ag3WJ0Hnc
         XG/eLPObxzI+rSfjkRXrKQwVnYBRoICS4cFSeCtfbHvUiGR6dyYyClySUAeTpYBmGi2P
         mWBsLIClnw88f5YsgRsIFyHvVpwwdIesxmI04=
Received: by 10.100.246.26 with SMTP id t26mr10211718anh.112.1277885977325;
        Wed, 30 Jun 2010 01:19:37 -0700 (PDT)
Received: from [192.168.2.64] ([193.164.118.24])
        by mx.google.com with ESMTPS id m13sm684615ybn.9.2010.06.30.01.19.34
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 30 Jun 2010 01:19:36 -0700 (PDT)
In-Reply-To: <20100630051326.GA17497@burratino>
X-Mailer: Evolution 2.28.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149951>

On Wed, 2010-06-30 at 00:13 -0500, Jonathan Nieder wrote:
> John Tapsell wrote:
>=20
> > $ git reset --hard
> >
> > I know this seems very explicit to delete changes, but I myself hav=
e
> > done this and accidentally lost changes.  For example, I write a un=
it
> > test and don't commit it in on purpose because I know that it
> > currently fails and I want to test it against older versions.  I
> > carefully git checkout older versions to find if the unit test fail=
s,
> > then in stupidity reset back to origin/master ..
>=20
> Aside: I assume you already know about it, but still I cannot help bu=
t
> take the opportunity to advertise =E2=80=98git reset --keep=E2=80=99.=
  I was added
> fairly recently (1.7.1 rc0) and I find myself annoyed when on machine=
s
> without it because of almost exactly this use case.

I tend to want "do a git reset --hard, but fail if anything would be
lost". The use-case here is that when I reset --hard, I want a
completely clean copy- but I don't want to accidentally lose anything.

This can probably be achieved with something like:
git diff-files --quiet &&
  git diff-index --quiet HEAD &&
  git diff-index --cached --quiet HEAD ||
  git reset --hard "$@"

I've got a half-done patch sitting at home which adds -g, --gentle to
"git reset", which is intended to do exactly that- but my git-fu is not
very strong on the C end of things, so for the foreseeable future it
will remain an idea without a working implementation.
