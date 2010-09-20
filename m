From: Kumar Appaiah <a.kumar@alumni.iitm.ac.in>
Subject: Re: [tig] Re: compilation error: undefined reference to
 `set_tabsize'
Date: Mon, 20 Sep 2010 18:13:49 -0500
Message-ID: <20100920231349.GK23119@bowser.ece.utexas.edu>
References: <20100920174200.GA13017@vidovic>
 <loom.20100920T203217-346@post.gmane.org>
 <20100920204344.GB13017@vidovic>
 <20100920230559.GJ23119@bowser.ece.utexas.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Stefan =?iso-8859-1?Q?N=E4we?= <stefan.naewe@googlemail.com>,
	fonseca@diku.dk
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 21 01:14:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxpYo-0008MY-DR
	for gcvg-git-2@lo.gmane.org; Tue, 21 Sep 2010 01:14:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754745Ab0ITXNw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Sep 2010 19:13:52 -0400
Received: from irongate.mail.utexas.edu ([146.6.25.6]:21351 "EHLO
	irongate.mail.utexas.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753940Ab0ITXNw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Sep 2010 19:13:52 -0400
X-IronPort-MID: 55928813
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ApUGAB6Hl0yAU36S/2dsb2JhbACULI10ccR1hUEEhE6FaoR4
Received: from wb7-a.mail.utexas.edu ([128.83.126.146])
  by irongate.mail.utexas.edu with ESMTP; 20 Sep 2010 18:13:51 -0500
Received: (qmail 46922 invoked from network); 20 Sep 2010 23:13:51 -0000
Received: from bowser.ece.utexas.edu (a.kumar@146.6.33.245)
  by wb7.mail.utexas.edu with (RC4-SHA encrypted) ESMTPSSA; 20 Sep 2010 23:13:51 -0000
Content-Disposition: inline
In-Reply-To: <20100920230559.GJ23119@bowser.ece.utexas.edu>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156677>

On Mon, Sep 20, 2010 at 06:05:59PM -0500, Kumar Appaiah wrote:
> On Mon, Sep 20, 2010 at 10:43:44PM +0200, Nicolas Sebrecht wrote:
> > > That change works for me on Cygwin, Ubuntu 10.04, Debian 5.0.6
> > > 
> > > Maybe you should say something about your system/OS version ?
> > 
> > Naturally. I'm running on Gentoo.
> > 
> 
> Ack that this also breaks build on CentOS. The simple reason is that
> the ncurses version on CentOS 5.5 is ncurses-5.5, while that on Debian
> Lenny is 5.7+. According to the changelog, 5.6 onwards has
> set_tabsize, so checking for that version of ncurses might be a good
> option.

I have attached a patch which uses the patch number to determine this:


HTH, Thanks!

Kumar

>From d10b7f15160b7d8da74f899f25018591cb33eec0 Mon Sep 17 00:00:00 2001
From: Kumar Appaiah <a.kumar@alumni.iitm.ac.in>
Date: Mon, 20 Sep 2010 18:10:11 -0500
Subject: [PATCH] Check the ncurse version before using set_tabsize

This patch checks the ncurses patch level to decide if set_tabsize is
to be used in place of the TABSIZE macro, for setting the tab size.
---
 tig.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/tig.c b/tig.c
index 7bc5daa..01b55d7 100644
--- a/tig.c
+++ b/tig.c
@@ -7111,7 +7111,11 @@ init_display(void)
 	keypad(status_win, TRUE);
 	wbkgdset(status_win, get_line_attr(LINE_STATUS));
 
+#if defined(NCURSES_VERSION_PATCH) && (NCURSES_VERSION_PATCH >= 20080119)
 	set_tabsize(opt_tab_size);
+#else
+	TABSIZE = opt_tab_size;
+#endif
 
 	term = getenv("XTERM_VERSION") ? NULL : getenv("COLORTERM");
 	if (term && !strcmp(term, "gnome-terminal")) {
-- 
1.7.2.3
