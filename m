From: Junio C Hamano <junkio@cox.net>
Subject: GIt.xs merge status
Date: Thu, 29 Jun 2006 18:28:35 -0700
Message-ID: <7vmzbvmny4.fsf_-_@assigned-by-dhcp.cox.net>
References: <7vzmg376ee.fsf@assigned-by-dhcp.cox.net>
	<20060624012202.4822.qmail@science.horizon.com>
	<7vfyhv11ej.fsf@assigned-by-dhcp.cox.net>
	<7vwtb6yip5.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0606241147480.6483@g5.osdl.org>
	<7vhd2atid1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Fri Jun 30 03:29:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fw7oR-0006ji-Uf
	for gcvg-git@gmane.org; Fri, 30 Jun 2006 03:28:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964924AbWF3B2i (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Jun 2006 21:28:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751396AbWF3B2i
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jun 2006 21:28:38 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:7301 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1751394AbWF3B2g (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jun 2006 21:28:36 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060630012836.DAWD8537.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 29 Jun 2006 21:28:36 -0400
To: git@vger.kernel.org
In-Reply-To: <7vhd2atid1.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sat, 24 Jun 2006 13:21:30 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22942>

Junio C Hamano <junkio@cox.net> writes:

> Pasky, can we first iron out kinks in the build procedure and
> installation before converting existing programs further?  The
> things I worry about currently are:
>
>  - the SITELIBARCH gotcha I sent you a message about (and you
>    responded to it already -- was that an Acked-by?);

I think this finally was cleared thanks to Pavel Roskin (and an
unrelated workaround at the tip of "pu" by me).

>  - RPM target -- we probably acquired a new build-dependency in
>    which case the .spec file needs to be updated;

I am having trouble with this.  I'd appreciate help from RPM
savvy people (the build failure log at the end).

>  - Make sure Git.xs builds and installed result works fine on
>    all platforms we care about, including Cygwin and other
>    non-Linux boxes.

Help wanted from the list here.  One thing to note is that I
understand Pasky is working on not using Devel::PPPort to make
the code work with 5.6, so if your build dies with problems in
that area you might want to wait until that is fixed.

> I'd even suggest we revert the changes to git-fmt-merge-msg to
> keep it working for now, until the above worries are resolved.
> Otherwise we cannot have it in "next" safely (and I REALLY _do_
> want to have Git.pm infrastructure in "next" soonish).

I am still undecided about the reverting, since in the places I
personally care about the program works ;-).

I test-built the tip of "pu" 57628f0e; the RPM build log ends
like this:

Requires(rpmlib): rpmlib(CompressedFileNames) <= 3.0.4-1 rpmlib(PayloadFilesHavePrefix) <= 4.0-1
Requires: /bin/sh git-core = 1.4.1.rc2.g5762-1 tk >= 8.4
Processing files: git-debuginfo-1.4.1.rc2.g5762-1
Provides: Git.so.debug()(64bit)
Requires(rpmlib): rpmlib(CompressedFileNames) <= 3.0.4-1 rpmlib(PayloadFilesHavePrefix) <= 4.0-1
Checking for unpackaged file(s): /usr/lib/rpm/check-files /var/tmp/git-1.4.1.rc2.g5762-1-root-junio
error: Installed (but unpackaged) file(s) found:
   /usr/lib64/perl5/5.8.6/x86_64-linux-thread-multi/perllocal.pod
   /usr/lib64/perl5/site_perl/5.8.6/x86_64-linux-thread-multi/Error.pm
   /usr/lib64/perl5/site_perl/5.8.6/x86_64-linux-thread-multi/Git.pm
   /usr/lib64/perl5/site_perl/5.8.6/x86_64-linux-thread-multi/auto/Git/.packlist
   /usr/lib64/perl5/site_perl/5.8.6/x86_64-linux-thread-multi/auto/Git/Git.bs
   /usr/lib64/perl5/site_perl/5.8.6/x86_64-linux-thread-multi/auto/Git/Git.so


RPM build errors:
    Installed (but unpackaged) file(s) found:
   /usr/lib64/perl5/5.8.6/x86_64-linux-thread-multi/perllocal.pod
   /usr/lib64/perl5/site_perl/5.8.6/x86_64-linux-thread-multi/Error.pm
   /usr/lib64/perl5/site_perl/5.8.6/x86_64-linux-thread-multi/Git.pm
   /usr/lib64/perl5/site_perl/5.8.6/x86_64-linux-thread-multi/auto/Git/.packlist
   /usr/lib64/perl5/site_perl/5.8.6/x86_64-linux-thread-multi/auto/Git/Git.bs
   /usr/lib64/perl5/site_perl/5.8.6/x86_64-linux-thread-multi/auto/Git/Git.so
make: *** [rpm] Error 1
