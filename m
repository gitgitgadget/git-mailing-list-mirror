From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 0/9] Some more sparse patches
Date: Thu, 07 Apr 2011 19:16:01 +0100
Message-ID: <4D9DFF61.8090302@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>, bebarino@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 07 20:53:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7uKD-0004hb-1Y
	for gcvg-git-2@lo.gmane.org; Thu, 07 Apr 2011 20:53:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756543Ab1DGSw4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Apr 2011 14:52:56 -0400
Received: from anchor-post-3.mail.demon.net ([195.173.77.134]:48557 "EHLO
	anchor-post-3.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756227Ab1DGSwz (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Apr 2011 14:52:55 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-3.mail.demon.net with esmtp (Exim 4.69)
	id 1Q7uK5-0001Om-pF; Thu, 07 Apr 2011 18:52:54 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171071>

Hi Junio,

My (git.git) sparse branch, which I've been feeding and updating for
over two years now, has recently started to shrink quite rapidly.
This (of course) is due to Stephen's recent commits (eg c2e86add
and 52d269da and 1e4cd68c). These patches are (most) of what
remains of my sparse branch (Some are just too ugly to send :-P ).

[Hmmm, I haven't read the list for a few days, so if Stephen has
already addressed these issues, sorry for the noise! ]

I suspect it is a little too late in this cycle for patches like
this, but I'm hoping you won't mind parking these in pu ready for
consideration early in the next cycle.

    [PATCH 1/9] Makefile: Use cgcc rather than sparse in the check target
    [PATCH 2/9] sparse: Fix an "symbol 'cmd_index_pack' not declared" warning
    [PATCH 3/9] sparse: Fix some "Using plain integer as NULL pointer" warnings
    [PATCH 4/9] sparse: Fix an "symbol 'format_subject' not declared" warning
    [PATCH 5/9] sparse: Fix an "symbol 'merge_file' not decared" warning
    [PATCH 6/9] gettext.h: Avoid using a non-standard C construct
    [PATCH 7/9] sparse: Fix errors due to missing target-specific variables
    [PATCH 8/9] sparse: Fix some "symbol not declared" warnings
    [PATCH 9/9] sparse: Fix argument number/type warnings caused by the main() macro

Note that I had originally not intended to send patch #9, but I mis-counted
the commits when running "format-patch" and didn't notice for a while ...
Also, patch #9 is the only one specific to MinGW; I have patched support for
MinGW into my local sparse (about two years ago...), but have not got around to
sending those patches back upstream ... So, you may want to drop that one.

After these patches, sparse issues no errors on Cygwin; MinGW still has about
25 warnings (but compat/nedmalloc/malloc.c.h seems to send sparse into an
infinite loop); Linux has two groups of warnings as follows:

    connect.c:226:39: warning: incorrect type in argument 2 (invalid types)
    connect.c:226:39:    expected union __CONST_SOCKADDR_ARG [usertype] __addr
    connect.c:226:39:    got struct sockaddr *ai_addr
    daemon.c:787:36: warning: incorrect type in argument 2 (invalid types)
    daemon.c:787:36:    expected union __CONST_SOCKADDR_ARG [usertype] __addr
    daemon.c:787:36:    got struct sockaddr *ai_addr
    daemon.c:918:67: warning: incorrect type in argument 2 (invalid types)
    daemon.c:918:67:    expected union __SOCKADDR_ARG [usertype] __addr
    daemon.c:918:67:    got struct sockaddr *<noident>
    imap-send.c:1119:42: warning: incorrect type in argument 2 (invalid types)
    imap-send.c:1119:42:    expected union __CONST_SOCKADDR_ARG [usertype] __addr
    imap-send.c:1119:42:    got struct sockaddr *ai_addr

These are due to sparse not (yet) supporting transparent unions (I have a patch
somewhere...), and

    notes.c:397:17: error: too long token expansion
    notes-merge.c:63:9: error: too long token expansion
    notes-merge.c:564:9: error: too long token expansion

Which is caused by overflowing an internal static buffer (again I have a patch).

ATB,
Ramsay Jones
