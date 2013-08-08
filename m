From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: Reproducible, corrupt packfile after fresh git-svn checkout
Date: Thu, 8 Aug 2013 14:31:07 +0200
Message-ID: <87fvuk2wl0.fsf@linux-k42r.v.cablecom.net>
References: <52037F47.5010302@exxcellent.de> <52037F84.9060006@exxcellent.de>
	<f1d8f80d6fa3678ac043bfdb19bebf6bf4261273@localhost>
	<877gfw4byx.fsf@linux-k42r.v.cablecom.net>
	<262a9f8309a3812970f47ac9f4e4b49bb972ca49@localhost>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>
To: <gitml.jexpert@recursor.net>
X-From: git-owner@vger.kernel.org Thu Aug 08 14:31:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7PN4-0002J1-UP
	for gcvg-git-2@plane.gmane.org; Thu, 08 Aug 2013 14:31:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757773Ab3HHMbJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Aug 2013 08:31:09 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:27275 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752515Ab3HHMbI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Aug 2013 08:31:08 -0400
Received: from CAS22.d.ethz.ch (172.31.51.112) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Thu, 8 Aug
 2013 14:31:04 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (129.132.153.253) by
 CAS22.d.ethz.ch (172.31.51.112) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Thu, 8 Aug 2013 14:31:06 +0200
In-Reply-To: <262a9f8309a3812970f47ac9f4e4b49bb972ca49@localhost> (gitml
	jexpert's message of "Thu, 08 Aug 2013 14:23:06 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.153.253]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231876>

gitml.jexpert@recursor.net writes:

>> Regardless of any possible fault in git-svn, there's an obvious bug here
>> with git-fsck.  Can you share the pack (if the project is public) or
>> compile a git-fsck without optimization and with debugging, and run it
>> under valgrind, to hopefully get us a backtrace of where the memory
>> management goes off the rails?
>
> Unfortunately I'm unable to share the pack.
>
> As Java Developer I'm note very savy, but I'd try.
> Do you have me any pointers on ".. without optimization and with
> debugging" and "run it under valgrind"?
>
> Currently I used
>    deb http://ppa.launchpad.net/git-core/ppa/ubuntu quantal main
> as source.

Try something like

  # The package names might be wrong and/or you may need additional -dev
  # packages, I don't know the specifics for ubuntu
  apt-get install gcc make valgrind libcurl-dev zlib-dev
  cd
  git clone git://git.kernel.org/pub/scm/git/git.git
  cd git
  echo 'CFLAGS = -O0 -g' >>config.mak
  make
  cd /path/to/repo
  valgrind --track-origins=yes ~/git/git-fsck

It'll be very slow, at least 20x the normal runtime, so don't be
surprised if it doesn't seem to get anywhere at first.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
