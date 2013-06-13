From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH/RFC 3/4] git-mw: Adding git-mw.perl script
Date: Thu, 13 Jun 2013 15:01:10 +0200
Message-ID: <vpq4nd2rwq1.fsf@anie.imag.fr>
References: <1371118039-18925-1-git-send-email-benoit.person@ensimag.fr>
	<1371118039-18925-4-git-send-email-benoit.person@ensimag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Celestin Matte <celestin.matte@ensimag.fr>,
	Jeff King <peff@peff.net>
To: benoit.person@ensimag.fr
X-From: git-owner@vger.kernel.org Thu Jun 13 15:01:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Un79c-0004U6-FN
	for gcvg-git-2@plane.gmane.org; Thu, 13 Jun 2013 15:01:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755577Ab3FMNBX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Jun 2013 09:01:23 -0400
Received: from mx2.imag.fr ([129.88.30.17]:39042 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754183Ab3FMNBW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Jun 2013 09:01:22 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r5DD19pC022355
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 13 Jun 2013 15:01:09 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Un79K-0004zI-Ra; Thu, 13 Jun 2013 15:01:10 +0200
In-Reply-To: <1371118039-18925-4-git-send-email-benoit.person@ensimag.fr>
	(benoit person's message of "Thu, 13 Jun 2013 12:07:18 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 13 Jun 2013 15:01:10 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227725>

benoit.person@ensimag.fr writes:

> From: Benoit Person <benoit.person@ensimag.fr>
>
> This script will be used for all tools and command related to a mediawiki
> remote. In this commit we introduce the tool, the way it parses argument
> and subcommands and an example of subcommand: "help". It also updates
> the Makefile so that the new tool is installed properly.

How does the "make" Vs "make install" work? How does a developer run the
tool without installing?

I first tried:

$ ../../bin-wrappers/git mw
git: 'mw' is not a git command. See 'git --help'.

Then, this first seem OK:

$ ./git-mw 
usage: git mw <command> <args>

git mw commands are:
    Help        Display help information about git mw
    Preview     Parse and render local file into HTML

BUT, this will take the installed GitMediawiki.pm if it is available,
and we don't want this (if one hacks GitMediawiki.pm locally, one wants
the new hacked to be taken into account without "make install"ing it).

To understand better how it works, try adding this in git-mw.perl:

  print "$_\n" for @INC;

I get this:

/home/moy/local/usr-squeeze/share/perl/5.14.2
/home/moy/local/usr-squeeze/src/MediaWiki-API-0.39/blib/lib
/etc/perl
/usr/local/lib/perl/5.14.2
/usr/local/share/perl/5.14.2
/usr/lib/perl5
/usr/share/perl5
/usr/lib/perl/5.14
/usr/share/perl/5.14
/usr/local/lib/site_perl
.

The '.' is there, but it comes after the hardcoded
/home/moy/local/usr-squeeze/share/perl/5.14.2 (which has to comes first,
to let the install version be robust to whatever comes after).

I think you need an equivalent of Git's toplevel bin-wrappers/git, or
perhaps use the same bin-wrapper/git but let "make install" in
contrib/mw-to-git/ install GitMediawiki.pm in perl/blib/lib

BTW, I just noticed we had a Git::SVN, so perhaps GitMediawiki should be
Git::MediaWiki.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
