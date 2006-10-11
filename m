From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitweb: Show project README if available
Date: Wed, 11 Oct 2006 12:32:37 -0700
Message-ID: <7v3b9utzqi.fsf@assigned-by-dhcp.cox.net>
References: <20061010025627.19317.70511.stgit@rover>
	<egfndo$lg6$1@sea.gmane.org> <20061010104149.GP20017@pasky.or.cz>
	<200610111423.00656.jnareb@gmail.com>
	<20061011181729.GB2897@coredump.intra.peff.net>
	<egje5k$5rn$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>,
	Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Oct 11 21:33:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXjpC-000547-Pg
	for gcvg-git@gmane.org; Wed, 11 Oct 2006 21:33:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161362AbWJKTck (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Oct 2006 15:32:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161363AbWJKTcj
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Oct 2006 15:32:39 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:22694 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1161362AbWJKTcj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Oct 2006 15:32:39 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061011193238.FSER12909.fed1rmmtao05.cox.net@fed1rmimpo02.cox.net>;
          Wed, 11 Oct 2006 15:32:38 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Z7Yg1V01C1kojtg0000000
	Wed, 11 Oct 2006 15:32:41 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <egje5k$5rn$1@sea.gmane.org> (Jakub Narebski's message of "Wed,
	11 Oct 2006 20:46:14 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28740>

Jakub Narebski <jnareb@gmail.com> writes:

> Jeff King wrote:
>
>> On Wed, Oct 11, 2006 at 02:23:00PM +0200, Jakub Narebski wrote:
>> 
>>> Can any Perl expert tell us how Perl truly solve this? What is the best
>>> way to dump whole [remaining] contents of file (from filehandle) to STDOUT?
>> 
>> The same you would in C: read fix-sized buffers and dump them.
> [...]
>> Or you can use the File::Copy module, which is part of the standard
>> distribution (and I believe has been so for all perl5 versions, but I
>> could be wrong):
>
> And 
>
>         {
>                 local $/;
>                 print <$fd>;
>         }
>
> doesn't do the right thing?

Jakub, you asked for "the best way" not "any way that would
produce a correct result".  Your 4-liner is shorter in the
source but it risks slurping a 10 megabyte file into memory
first, only to discard it after immediately writing it out.

You can strace your Perl to see what yours does yourself:

	strace perl -e 'print <STDIN>' >/dev/null <some-huge-file

You will see a bunch of read(0, ..., 4096) and after all of that
finishes, finally you will see a bunch of write(1, ..., 4096).
Where do you think the data is in the meantime?

Jeff gave you better ways that do not have that problem.
