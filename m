From: Junio C Hamano <junkio@cox.net>
Subject: Re: Quick merge status updates.
Date: Wed, 28 Jun 2006 01:49:18 -0700
Message-ID: <7v7j3164xd.fsf@assigned-by-dhcp.cox.net>
References: <7vodwe5dr8.fsf@assigned-by-dhcp.cox.net>
	<1151471040.4940.17.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 28 10:49:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FvVjf-0006rF-TB
	for gcvg-git@gmane.org; Wed, 28 Jun 2006 10:49:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423225AbWF1ItU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Jun 2006 04:49:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423228AbWF1ItU
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jun 2006 04:49:20 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:14778 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1423225AbWF1ItT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Jun 2006 04:49:19 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060628084919.BOBN11027.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 28 Jun 2006 04:49:19 -0400
To: Pavel Roskin <proski@gnu.org>
In-Reply-To: <1151471040.4940.17.camel@dv> (Pavel Roskin's message of "Wed, 28
	Jun 2006 01:04:00 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22780>

Pavel Roskin <proski@gnu.org> writes:

> PowerPC 32-bit, G3, Fedora Core 5, gcc 4.1.1, perl 5.8.8, pu branch
> (f5d33e0b4eaa4083b455118a7be473defb61f137)

Thanks.

> Warnings:
>
> quote.c: In function 'sq_quote_buf':
> quote.c:34: warning: value computed is not used
> quote.c:37: warning: value computed is not used

Thanks.  I think these are dealt with Jeff King's patches.

> combine-diff.c: In function 'diff_tree_combined':
> combine-diff.c:844: warning: assignment makes integer from pointer
> without a cast

Thanks.  The fix is actually simple (two paragraphs below).

> In file included
> from /usr/lib/perl5/5.8.8/ppc-linux-thread-multi/CORE/perl.h:756,
>                  from Git.xs:15:
> /usr/lib/perl5/5.8.8/ppc-linux-thread-multi/CORE/embed.h:4195:1:
> warning: "die" redefined
> Git.xs:11:1: warning: this is the location of the previous definition

I've seen this but haven't looked into it.  Pasky?

> I'm very concerned about the combine-diff.c warning.  The warning seems
> to be legitimate and I don't see an obvious fix.  The offending line
> comes from 3969cf7db1a13a78f3b7a36d8c1084bbe0a53459 ("Fix some more diff
> options changes"):
>
> show_log_first = rev->loginfo;

This is saying "If rev->loginfo is pointing at some string, we
are going to show the log message first and then output from the
diff machinery (otherwise rev->loginfo has NULL)".  I'll
rephrase it to read as:

	show_log_first = !!rev->loginfo;

> The testsuite passes, but "git-pull" is indeed broken:
>
> $ git-pull
> Can't locate Git.pm in @INC (@INC
> contains: /usr/lib/perl5/site_perl/5.8.8/ppc-linux-thread-multi /usr/lib/perl5/site_perl/5.8.7/ppc-linux-thread-multi /usr/lib/perl5/site_perl/5.8.6/ppc-linux-thread-multi /usr/lib/perl5/site_perl/5.8.5/ppc-linux-thread-multi /usr/lib/perl5/site_perl/5.8.4/ppc-linux-thread-multi /usr/lib/perl5/site_perl/5.8.3/ppc-linux-thread-multi /usr/lib/perl5/site_perl/5.8.8 /usr/lib/perl5/site_perl/5.8.7 /usr/lib/perl5/site_perl/5.8.6 /usr/lib/perl5/site_perl/5.8.5 /usr/lib/perl5/site_perl/5.8.4 /usr/lib/perl5/site_perl/5.8.3 /usr/lib/perl5/site_perl /usr/lib/perl5/vendor_perl/5.8.8/ppc-linux-thread-multi /usr/lib/perl5/vendor_perl/5.8.7/ppc-linux-thread-multi /usr/lib/perl5/vendor_perl/5.8.6/ppc-linux-thread-multi /usr/lib/perl5/vendor_perl/5.8.5/ppc-linux-thread-multi /usr/lib/perl5/vendor_perl/5.8.4/ppc-linux-thread-multi /usr/lib/perl5/vendor_perl/5.8.3/ppc-linux-thread-multi /usr/lib/perl5/ve
 ndor_perl/5.8.8 /usr/lib/perl5/vendor_perl/5.8.7 /usr/lib/perl5/vendor_perl/5.8.6 /usr/lib/perl5/vendor_perl/5.8.5 /usr/lib/perl5/vendor_perl/5.8.4 /usr/lib/perl5/vendor_perl/5.8.3 /usr/lib/perl5/vendor_perl /usr/lib/perl5/5.8.8/ppc-linux-thread-multi /usr/lib/perl5/5.8.8 .) at /home/proski/bin/git-fmt-merge-msg line 10.
> BEGIN failed--compilation aborted at /home/proski/bin/git-fmt-merge-msg
> line 10.
>
> Git.pm is installed into
> /home/proski/lib/perl5/site_perl/5.8.8/ppc-linux-thread-multi/

The same problem with the last paragraph.

> Speaking of x86_64 (also Fedora Core 5, gcc 4.1.1, perl 5.8.8), git
> doesn't even build:

	$ git grep -A1 -e 'Define USE_PIC" pu:Makefile

in other words:

	USE_PIC=YesPlease make

> The testsuite passes.  git-pull is also broken with a similar error
> message.  Git.pm is installed into
> /home/proski/lib64/perl5/site_perl/5.8.8/x86_64-linux-thread-multi/

I suspect this is either FC perl-dev package is broken (I doubt
it) or your installation procedure is pecurilar (much more
likely).  I pass the same set of prefix, bindir and friends to
"make" and "make install" and do not see the problem.
