From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: diff-patch: Avoid emitting double-slashes in textual patch.
Date: Fri, 23 Feb 2007 17:07:16 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702231705370.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0702201944340.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vzm76fpia.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0702221724090.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vvehuf4ic.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0702221926390.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vmz36f1bv.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0702222051490.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vd542dji4.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0702222148050.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vmz353xpd.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Feb 23 17:07:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HKcxA-0006I0-4r
	for gcvg-git@gmane.org; Fri, 23 Feb 2007 17:07:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933113AbXBWQHU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Feb 2007 11:07:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933114AbXBWQHU
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Feb 2007 11:07:20 -0500
Received: from mail.gmx.net ([213.165.64.20]:44571 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933113AbXBWQHS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Feb 2007 11:07:18 -0500
Received: (qmail invoked by alias); 23 Feb 2007 16:07:16 -0000
X-Provags-ID: V01U2FsdGVkX1/BbA4Xo4HBRNy3n39/6otSQ/LJIbAEOyzQgMMF71
	Nz+g==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vmz353xpd.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40447>

Hi,

On Fri, 23 Feb 2007, Junio C Hamano wrote:

> -	a_one = quote_two("a/", name_a);
> -	b_two = quote_two("b/", name_b);
> +	a_one = quote_two("a/", name_a + (*name_a == '/'));
> +	b_two = quote_two("b/", name_b + (*name_b == '/'));

I briefly thought about something like this instead:

-	a_one = quote_two("a/", name_a + (*name_a == '/'));
-	b_two = quote_two("b/", name_b + (*name_b == '/'));
+	a_one = quote_two(*name_a == '/' ? "" : "a/", name_a);
+	b_two = quote_two(*name_b == '/' ? "" : "b/", name_b);
 	lbl[0] = DIFF_FILE_VALID(one) ? a_one : "/dev/null";
 	lbl[1] = DIFF_FILE_VALID(two) ? b_two : "/dev/null";
-	printf("%sdiff --git %s %s%s\n", set, a_one, b_two, reset);
+	printf("%sdiff %s%s %s%s\n", set, *name_a == '/' || *name_b == '/' ?
+			"" : "--git ", a_one, b_two, reset);

but I think your approach is better.

Ciao,
Dscho
