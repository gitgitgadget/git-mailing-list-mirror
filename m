From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH] tar: on extract, -o is --no-same-owner
Date: Sat, 24 Oct 2009 15:06:57 +0200
Message-ID: <m2ocnxuej2.fsf@igel.home>
References: <1256328943-22136-1-git-send-email-rep.dot.nop@gmail.com>
	<20091023202524.GE4615@mx.loc> <20091023210648.GA23122@mx.loc>
	<7vocnxajj6.fsf@alter.siamese.dyndns.org>
	<20091024091758.GF4615@mx.loc> <m28wf1unop.fsf@whitebox.home>
	<20091024100502.GG4615@mx.loc> <m2ocnxt6jl.fsf@whitebox.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, vda.linux@googlemail.com,
	busybox@busybox.net, git@vger.kernel.org
To: Bernhard Reutner-Fischer <rep.dot.nop@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 24 15:07:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N1gL2-00042e-5a
	for gcvg-git-2@lo.gmane.org; Sat, 24 Oct 2009 15:07:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753317AbZJXNHD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Oct 2009 09:07:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753312AbZJXNHC
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Oct 2009 09:07:02 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:53627 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753308AbZJXNG5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Oct 2009 09:06:57 -0400
Received: from mail01.m-online.net (mail.m-online.net [192.168.3.149])
	by mail-out.m-online.net (Postfix) with ESMTP id D598B1C000F5;
	Sat, 24 Oct 2009 15:06:58 +0200 (CEST)
Received: from localhost (dynscan2.mnet-online.de [192.168.1.215])
	by mail.m-online.net (Postfix) with ESMTP id D6EAF9015C;
	Sat, 24 Oct 2009 15:06:58 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.3.149])
	by localhost (dynscan2.mnet-online.de [192.168.1.215]) (amavisd-new, port 10024)
	with ESMTP id 2oNwOqfx-3YE; Sat, 24 Oct 2009 15:06:57 +0200 (CEST)
Received: from igel.home (DSL01.83.171.146.84.ip-pool.NEFkom.net [83.171.146.84])
	by mail.mnet-online.de (Postfix) with ESMTP;
	Sat, 24 Oct 2009 15:06:57 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id 6CF5A10D975; Sat, 24 Oct 2009 15:06:57 +0200 (CEST)
X-Yow: How's the wife?  Is she at home enjoying capitalism?
In-Reply-To: <m2ocnxt6jl.fsf@whitebox.home> (Andreas Schwab's message of "Sat,
	24 Oct 2009 12:44:46 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131161>

Andreas Schwab <schwab@linux-m68k.org> writes:

> Bernhard Reutner-Fischer <rep.dot.nop@gmail.com> writes:
>
>> On Sat, Oct 24, 2009 at 11:49:10AM +0200, Andreas Schwab wrote:
>>>Bernhard Reutner-Fischer <rep.dot.nop@gmail.com> writes:
>>>
>>>> I suppose xf - -o would work?
>>>
>>>Isn't that the same as 'xfo -'?
>>
>> Not really (if you do not permute the arguments which we don't in
>> busybox, for size reasons).
>
> There is no argument permutation.  The traditional argument parsing of
> tar does not cluster option letters with option arguments.
>
> Of course, just using 'xof -' will work around this busybox bug.

Like this.

Andreas.

>From ebadb41b346c305b94f27e3bb787bf0ba6bb8a5b Mon Sep 17 00:00:00 2001
From: Andreas Schwab <schwab@linux-m68k.org>
Date: Sat, 24 Oct 2009 15:01:03 +0200
Subject: [PATCH] Work around option parsing bug in the busybox tar implementation

Traditionally the first argument of the tar command was interpreted a
bundle of letters specifying the mode of operation and additional options,
with any option arguments taken from subsequent words on the command line
as needed.  The implementation of tar in busybox apparently treats this
bundle as if preceded by a dash and then parses it by getopt rules, which
mishandles 'tar xfo -'.  Use 'tar xof -' instead which is parsed the same
way by both traditional tar implementations and busybox.

Signed-off-by: Andreas Schwab <schwab@linux-m68k.org>
---
 templates/Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/templates/Makefile b/templates/Makefile
index a12c6e2..408f013 100644
--- a/templates/Makefile
+++ b/templates/Makefile
@@ -50,4 +50,4 @@ clean:
 install: all
 	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(template_instdir_SQ)'
 	(cd blt && $(TAR) cf - .) | \
-	(cd '$(DESTDIR_SQ)$(template_instdir_SQ)' && umask 022 && $(TAR) xfo -)
+	(cd '$(DESTDIR_SQ)$(template_instdir_SQ)' && umask 022 && $(TAR) xof -)
-- 
1.6.5.1


-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
