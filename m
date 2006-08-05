From: "Ramsay Jones" <ramsay@ramsay1.demon.co.uk>
Subject: RE: [PATCH 6/10] Fix header breakage with _XOPEN_SOURCE.
Date: Sat, 5 Aug 2006 18:11:28 +0100
Message-ID: <000101c6b8b2$30c76060$c47eedc1@ramsay1.demon.co.uk>
References: <Pine.LNX.4.63.0608040211160.1800@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>, <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Aug 05 19:11:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G9PgU-0007qd-8D
	for gcvg-git@gmane.org; Sat, 05 Aug 2006 19:11:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030225AbWHERLX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 5 Aug 2006 13:11:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030257AbWHERLX
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Aug 2006 13:11:23 -0400
Received: from anchor-post-33.mail.demon.net ([194.217.242.91]:5388 "EHLO
	anchor-post-33.mail.demon.net") by vger.kernel.org with ESMTP
	id S1030225AbWHERLW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Aug 2006 13:11:22 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-33.mail.demon.net with smtp (Exim 4.42)
	id 1G9PgD-00070C-Ck; Sat, 05 Aug 2006 17:11:18 +0000
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook 8.5, Build 4.71.2173.0
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V4.72.2106.4
In-Reply-To: <Pine.LNX.4.63.0608040211160.1800@wbgn013.biozentrum.uni-wuerzburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24921>


On Fri, 2006-08-04 at 1:20, Johannes Schindelin wrote:
> Hi,
> 
> On Wed, 2 Aug 2006, Ramsay Jones wrote:
> 
> > [...] but strptime() remains undeclared.
> 
> Note that there is just one call to strptime() in the C sources: 
> convert-objects.
> 
> Also, we have something more portable in git now: you might be able to 
> substitute
> 
> 	const char *next = strptime(buf, *fmt, &tm);
> 	if (next) {
> 
> by something like
> 
> 	char buffer[50];
> 	int len = parse_date(buf, buffer, sizeof(buffer));
> 	const char *next = buf + len;
> 
> 	if (len) {
> 		const char *tzstring = strchr(buffer, ' ') + 1;
> 		int tz = (int)strtol(tzstring, NULL, 10);
> 		tm = *time_to_tm(strtoul(buffer, NULL, 10), tz);
> 
> However, I did not test it, and this might be completely bogus.
> 

Yes, I'm sure something like that could be done, but I really don't
think we need anything that intrusive to fix such a simple problem.
Indeed, I would rather Junio ignore the patch if it appears to cause
anyone else a problem. I can maintain it locally (it's only one line!).
After all, I'm pretty sure I'm the only idiot^H^H^H^H^H person using a
six year old dev system.

Ramsay
