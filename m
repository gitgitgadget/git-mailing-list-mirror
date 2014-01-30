From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Running "make rpm" fails on a CentOS 6.3 machine
Date: Thu, 30 Jan 2014 10:16:43 -0800
Message-ID: <20140130181643.GG27577@google.com>
References: <CALMr_pWHfaHq46418UPcqGKm6bFc61jw-VqGJYV8Ogc9yuHDFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Todd Zullinger <tmz@pobox.com>
To: Erez Zilber <erezzi.list@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 30 19:16:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W8wAW-0000d7-0A
	for gcvg-git-2@plane.gmane.org; Thu, 30 Jan 2014 19:16:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753732AbaA3SQs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jan 2014 13:16:48 -0500
Received: from mail-pb0-f48.google.com ([209.85.160.48]:49319 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753653AbaA3SQr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jan 2014 13:16:47 -0500
Received: by mail-pb0-f48.google.com with SMTP id rr13so3430753pbb.35
        for <git@vger.kernel.org>; Thu, 30 Jan 2014 10:16:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=vi8JSPRLSvqKhhlkmlMXQrlmlp/O/tEs5zUSN/LO+9Q=;
        b=pClgPQHbgTsVj1ID6xXPAmhSkqlXNipYcC8GxqqOjIFNyoDWzevPptiz7ZLIyuzqzt
         3tNBOjn3Nczd6rg9y8ZT16JbOKRL23XpPLckhSxs7/6woMU+az0/NWhWIRnUUtzCfxqf
         siGqIy/vEpTUnFeItVBlvrOlsnN8yoRaDhMCwsZ65MciyfP40Xg6JPoD1dvU8cgAQtH+
         53SE6bp1A0gX0UtG7b8t1QdpmUXIO12AFLGSG/OfEgEnAkKMqVBgGaVnaJmoM8Nvtkmb
         v8CNwQv/bx+7980GfitfZ1fthl7+MVUr9ySr16vGe2saPiCyZh9v+9u4T6RI6rwg6HaE
         WTbA==
X-Received: by 10.66.240.4 with SMTP id vw4mr15830417pac.26.1391105806743;
        Thu, 30 Jan 2014 10:16:46 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id x5sm19658245pbw.26.2014.01.30.10.16.45
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 30 Jan 2014 10:16:45 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CALMr_pWHfaHq46418UPcqGKm6bFc61jw-VqGJYV8Ogc9yuHDFA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241275>

Hi,

Erez Zilber wrote:

> Writing perl.mak for Git
> Writing perl.mak for Git
> rename MakeMaker.tmp => perl.mak: No such file or directory at /usr/share/perl5/ExtUtils/MakeMaker.pm line 1024.
> make[3]: perl.mak: No such file or directory
> make[3]: perl.mak: No such file or directory
> make[3]: *** No rule to make target `perl.mak'.  Stop.

Looks like MakeMaker is racing against itself.  Alas, (on a fairly
current Debian system, with perl 5.14.2) I'm not able to reproduce that.

Instead, I get this:

| $ make -j8 rpm
[...]
| make[2]: Leaving directory `$HOME/rpmbuild/BUILD/git-1.8.5.3/Documentation'
| make[1]: Leaving directory `$HOME/rpmbuild/BUILD/git-1.8.5.3'
| + exit 0
| Executing(%install): /bin/sh -e /var/tmp/rpm-tmp.WqNYnx
| + umask 022
| + cd $HOME/rpmbuild/BUILD
| + cd git-1.8.5.3
| + rm -rf $HOME/rpmbuild/BUILDROOT/git-1.8.5.3-1.x86_64
| + make -j12 'CFLAGS=-O2 -g' \
	DESTDIR=$HOME/rpmbuild/BUILDROOT/git-1.8.5.3-1.x86_64 \
	ETC_GITCONFIG=/etc/gitconfig prefix=/usr \
	mandir=/usr/share/man htmldir=/usr/share/doc/git-1.8.5.3 \
	INSTALLDIRS=vendor install install-doc
| make[1]: Entering directory `$HOME/rpmbuild/BUILD/git-1.8.5.3'
| make[1]: warning: -jN forced in submake: disabling jobserver mode.
| make[1]: *** write jobserver: Bad file descriptor.  Stop.
| make[1]: *** Waiting for unfinished jobs....
| make[1]: *** write jobserver: Bad file descriptor.  Stop.
| error: Bad exit status from /var/tmp/rpm-tmp.WqNYnx (%install)
|
|
| RPM build errors:
|     Bad exit status from /var/tmp/rpm-tmp.WqNYnx (%install)
| make: *** [rpm] Error 1

Known problem?  A build without -j8 gets further.

Thanks,
Jonathan
