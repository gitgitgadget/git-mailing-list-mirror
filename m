From: Pavel Roskin <proski@gnu.org>
Subject: Re: Quick merge status updates.
Date: Wed, 28 Jun 2006 01:04:00 -0400
Message-ID: <1151471040.4940.17.camel@dv>
References: <7vodwe5dr8.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 28 07:04:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FvSDv-0007md-00
	for gcvg-git@gmane.org; Wed, 28 Jun 2006 07:04:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932627AbWF1FEK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Jun 2006 01:04:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932523AbWF1FEJ
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jun 2006 01:04:09 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:14256 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S932627AbWF1FEI
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jun 2006 01:04:08 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1FvSDf-0002vC-1L
	for git@vger.kernel.org; Wed, 28 Jun 2006 01:04:07 -0400
Received: from proski by dv.roinet.com with local (Exim 4.62)
	(envelope-from <proski@dv.roinet.com>)
	id 1FvSDY-0006mg-T5; Wed, 28 Jun 2006 01:04:00 -0400
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vodwe5dr8.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Evolution 2.7.3 (2.7.3-4) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22772>

On Tue, 2006-06-27 at 17:23 -0700, Junio C Hamano wrote:
> For some time, "pu" was left in the state that does not to pass
> the testsuite, but I've fixed what's minimally needed (the
> breakage was mostly from the diff options rewrite).  People who
> regularly follow "next" on platforms other than i386 or x86-64
> Linux might want to try out tonight's "pu" to make sure
> "Git.xs/Git.pm" series works on their box before it hits "next".
> Breakage there would stop your "git pull" working, so this is
> somewhat important.

PowerPC 32-bit, G3, Fedora Core 5, gcc 4.1.1, perl 5.8.8, pu branch
(f5d33e0b4eaa4083b455118a7be473defb61f137)

Warnings:

quote.c: In function 'sq_quote_buf':
quote.c:34: warning: value computed is not used
quote.c:37: warning: value computed is not used
combine-diff.c: In function 'diff_tree_combined':
combine-diff.c:844: warning: assignment makes integer from pointer
without a cast
In file included
from /usr/lib/perl5/5.8.8/ppc-linux-thread-multi/CORE/perl.h:756,
                 from Git.xs:15:
/usr/lib/perl5/5.8.8/ppc-linux-thread-multi/CORE/embed.h:4195:1:
warning: "die" redefined
Git.xs:11:1: warning: this is the location of the previous definition

I'm very concerned about the combine-diff.c warning.  The warning seems
to be legitimate and I don't see an obvious fix.  The offending line
comes from 3969cf7db1a13a78f3b7a36d8c1084bbe0a53459 ("Fix some more diff
options changes"):

show_log_first = rev->loginfo;

The testsuite passes, but "git-pull" is indeed broken:

$ git-pull
Can't locate Git.pm in @INC (@INC
contains: /usr/lib/perl5/site_perl/5.8.8/ppc-linux-thread-multi /usr/lib/perl5/site_perl/5.8.7/ppc-linux-thread-multi /usr/lib/perl5/site_perl/5.8.6/ppc-linux-thread-multi /usr/lib/perl5/site_perl/5.8.5/ppc-linux-thread-multi /usr/lib/perl5/site_perl/5.8.4/ppc-linux-thread-multi /usr/lib/perl5/site_perl/5.8.3/ppc-linux-thread-multi /usr/lib/perl5/site_perl/5.8.8 /usr/lib/perl5/site_perl/5.8.7 /usr/lib/perl5/site_perl/5.8.6 /usr/lib/perl5/site_perl/5.8.5 /usr/lib/perl5/site_perl/5.8.4 /usr/lib/perl5/site_perl/5.8.3 /usr/lib/perl5/site_perl /usr/lib/perl5/vendor_perl/5.8.8/ppc-linux-thread-multi /usr/lib/perl5/vendor_perl/5.8.7/ppc-linux-thread-multi /usr/lib/perl5/vendor_perl/5.8.6/ppc-linux-thread-multi /usr/lib/perl5/vendor_perl/5.8.5/ppc-linux-thread-multi /usr/lib/perl5/vendor_perl/5.8.4/ppc-linux-thread-multi /usr/lib/perl5/vendor_perl/5.8.3/ppc-linux-thread-multi /usr/lib/perl5/vend
 or_perl/5.8.8 /usr/lib/perl5/vendor_perl/5.8.7 /usr/lib/perl5/vendor_perl/5.8.6 /usr/lib/perl5/vendor_perl/5.8.5 /usr/lib/perl5/vendor_perl/5.8.4 /usr/lib/perl5/vendor_perl/5.8.3 /usr/lib/perl5/vendor_perl /usr/lib/perl5/5.8.8/ppc-linux-thread-multi /usr/lib/perl5/5.8.8 .) at /home/proski/bin/git-fmt-merge-msg line 10.
BEGIN failed--compilation aborted at /home/proski/bin/git-fmt-merge-msg
line 10.

Git.pm is installed into
/home/proski/lib/perl5/site_perl/5.8.8/ppc-linux-thread-multi/

Speaking of x86_64 (also Fedora Core 5, gcc 4.1.1, perl 5.8.8), git
doesn't even build:

In file included
from /usr/lib64/perl5/5.8.8/x86_64-linux-thread-multi/CORE/perl.h:756,
                 from Git.xs:15:
/usr/lib64/perl5/5.8.8/x86_64-linux-thread-multi/CORE/embed.h:4195:1:
warning: "die" redefined
Git.xs:11:1: warning: this is the location of the previous definition
Running Mkbootstrap for Git ()
chmod 644 Git.bs
rm -f blib/arch/auto/Git/Git.so
gcc  -shared Git.o  -o blib/arch/auto/Git/Git.so ../libgit.a    \
   -lz -lcrypto         \
  
/usr/bin/ld: ../libgit.a(exec_cmd.o): relocation R_X86_64_32 against `a
local symbol' can not be used when making a shared object; recompile
with -fPIC
../libgit.a: could not read symbols: Bad value
collect2: ld returned 1 exit status
make[1]: *** [blib/arch/auto/Git/Git.so] Error 1
make[1]: Leaving directory `/usr/local/src/git/perl'
make: *** [all] Error 2

The build succeeds if I use following:
make CFLAGS='-g -O2 -Wall -fPIC'

The testsuite passes.  git-pull is also broken with a similar error
message.  Git.pm is installed into
/home/proski/lib64/perl5/site_perl/5.8.8/x86_64-linux-thread-multi/

-- 
Regards,
Pavel Roskin
