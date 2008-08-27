From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t9700-perl-git.sh: Fix a test failure on cygwin
Date: Wed, 27 Aug 2008 12:34:23 -0700
Message-ID: <7vd4jup800.fsf@gitster.siamese.dyndns.org>
References: <48B5984B.4020901@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing-list <git@vger.kernel.org>,
	Lea Wiemann <lewiemann@gmail.com>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Wed Aug 27 21:35:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYQno-0007bf-EL
	for gcvg-git-2@gmane.org; Wed, 27 Aug 2008 21:35:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752677AbYH0Tec (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2008 15:34:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752507AbYH0Teb
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 15:34:31 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:62723 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751250AbYH0Teb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2008 15:34:31 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 68A1363603;
	Wed, 27 Aug 2008 15:34:29 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 9877163602; Wed, 27 Aug 2008 15:34:25 -0400 (EDT)
In-Reply-To: <48B5984B.4020901@ramsay1.demon.co.uk> (Ramsay Jones's message
 of "Wed, 27 Aug 2008 19:09:15 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 2A7F2244-746F-11DD-ADCD-B29498D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93929>

Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:

> Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
> ---
>
> This patch fixes the t9700 test failure on cygwin. Don't ask me to
> explain why the original test.pl fails on cygwin, but passes on Linux!
>
> My perl version:
>
>     $ perl --version
>
>     This is perl, v5.8.7 built for cygwin-thread-multi-64int
>     (with 1 registered patch, see perl -V for more detail)
>
>     Copyright 1987-2005, Larry Wall
>
>     Perl may be copied only under the terms of either the Artistic License or the
>     GNU General Public License, which may be found in the Perl 5 source kit.
>
>     Complete documentation for Perl, including FAQ lists, should be found on
>     this system using `man perl' or `perldoc perl'.  If you have access to the
>     Internet, point your browser at http://www.perl.org/, the Perl Home Page.
>     $ 
>
> [My perl version on Linux is whatever comes with Ubuntu 7.04]

Curious.

What does this give you:

	$ cd t
        $ sh t9700-perl-git.sh -v

with the attached patch?  Unfortunately this cannot be run with "-i -v"
because 'test_external_without_stderr' uses test_external which in turn
exits upon failure when -i is given, without letting the former to report
what was given to the standard error stream (this is slightly offtopic but
pertains to debuggability of tests, so Lea is Cc'ed).

For me, cwd() is the same as Cwd->cwd (this is from Perl 5.8.8); perhaps
it behaves differently on Cygwin?

 t/t9700/test.pl |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git i/t/t9700/test.pl w/t/t9700/test.pl
index 851cea4..139711d 100755
--- i/t/t9700/test.pl
+++ w/t/t9700/test.pl
@@ -15,6 +15,12 @@ BEGIN { use_ok('Git') }
 
 # set up
 our $abs_repo_dir = Cwd->cwd;
+our $cwd = cwd();
+print STDERR "Cwd->cwd says '$abs_repo_dir'\n";
+print STDERR "cwd() says '$cwd'\n";
+
+exit(1);
+
 ok(our $r = Git->repository(Directory => "."), "open repository");
 
 # config
