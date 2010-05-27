From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [PATCH] compat: Add another rudimentary poll() emulation
Date: Thu, 27 May 2010 13:00:33 +0200
Message-ID: <AANLkTikYa2vq4PrKrO2QIkHVxYqbhUZRw42kQq875FNT@mail.gmail.com>
References: <1274948384-167-1-git-send-email-abcd@gentoo.org>
	<1274948384-167-2-git-send-email-abcd@gentoo.org>
	<20100527101043.GA4390@progeny.tock>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Callen <abcd@gentoo.org>, git@vger.kernel.org,
	mduft@gentoo.org, Sverre Rabbelier <srabbelier@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Johannes Sixt <j6t@kdbg.org>,
	msysGit <msysgit@googlegroups.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 27 13:00:41 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OHapN-0006ys-F3
	for gcvg-git-2@lo.gmane.org; Thu, 27 May 2010 13:00:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757886Ab0E0LAf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 27 May 2010 07:00:35 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:55689 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756888Ab0E0LAe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 May 2010 07:00:34 -0400
Received: by wwb34 with SMTP id 34so118471wwb.19
        for <git@vger.kernel.org>; Thu, 27 May 2010 04:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:reply-to
         :in-reply-to:references:date:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=YXCGGtHy68sTJd2OTGcLU92RHaRHeafbOqgqwTIlCkk=;
        b=bI732H1l7LAS3V1UjCcNnVeX2HF8L7ckfQW10hDZdVw3tDrNfhXXya7OtPBexxqfN8
         RBxrzuzv71gTfvq6FLUL/0C+tO29fkZq+hJmG2vQe3OwQHAikkinRNnzx0s/WCbKeb0G
         YqDHbl7qyCoAuTTa5xYx1w4lPig7jnDe3ajDI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        b=Bc+0nbrZP29CfLSnNX08YtraqS6SxGoxSgiua7nfJ8jfBUMOG7DF27wW489Y9FgsVs
         iT3XlyC2QjGWoy2WhCGHEQLtwDJ6mshVNWwjAJw00pZ2ZfHkTgRKIDdym4T+sHqqU/xg
         tmsoTEHNbOERA1QaPlMYsng6/RbfMmV3vi9zs=
Received: by 10.216.155.65 with SMTP id i43mr526336wek.98.1274958033124; Thu, 
	27 May 2010 04:00:33 -0700 (PDT)
Received: by 10.216.21.73 with HTTP; Thu, 27 May 2010 04:00:33 -0700 (PDT)
In-Reply-To: <20100527101043.GA4390@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147844>

On Thu, May 27, 2010 at 12:10 PM, Jonathan Nieder <jrnieder@gmail.com> =
wrote:
> Implement the subset of poll() semantics needed by git in terms of
> select(), for use by the Interix port. =A0Inspired by commit 6ed807f
> (Windows: A rudimentary poll() emulation, 2007-12-01).
>

A possible problem with this approach is that the maximum number of
file descriptors poll can handle limited by RLIMIT_NOFILE, whereas the
maximum number of file descriptors select can handle is limited by
=46D_SETSIZE.

I don't think this is a big problem in reality, though - both values
seem to be pretty high in most implementations. And IIRC git-daemon is
the only one who needs more than 2, and it doesn't even check
RLIMIT_NOFILE.

If we decide to go this route, perhaps it'd make sense to change to
this code for Windows also? Our Windows-implementation of poll() has
some annoying limitations...

--=20
Erik "kusma" Faye-Lund
