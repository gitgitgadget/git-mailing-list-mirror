From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: RE: [PATCH 6/10] Fix header breakage with _XOPEN_SOURCE.
Date: Fri, 4 Aug 2006 02:19:56 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0608040211160.1800@wbgn013.biozentrum.uni-wuerzburg.de>
References: <001d01c6b664$285ff540$c47eedc1@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 04 02:20:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G8nQ1-0007Zg-GM
	for gcvg-git@gmane.org; Fri, 04 Aug 2006 02:20:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932323AbWHDAT6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 Aug 2006 20:19:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932373AbWHDAT6
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Aug 2006 20:19:58 -0400
Received: from mail.gmx.de ([213.165.64.20]:32461 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932323AbWHDAT5 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Aug 2006 20:19:57 -0400
Received: (qmail invoked by alias); 04 Aug 2006 00:19:56 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp042) with SMTP; 04 Aug 2006 02:19:56 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
In-Reply-To: <001d01c6b664$285ff540$c47eedc1@ramsay1.demon.co.uk>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24762>

Hi,

On Wed, 2 Aug 2006, Ramsay Jones wrote:

> [...] but strptime() remains undeclared.

Note that there is just one call to strptime() in the C sources: 
convert-objects.

Also, we have something more portable in git now: you might be able to 
substitute

	const char *next = strptime(buf, *fmt, &tm);
	if (next) {

by something like

	char buffer[50];
	int len = parse_date(buf, buffer, sizeof(buffer));
	const char *next = buf + len;

	if (len) {
		const char *tzstring = strchr(buffer, ' ') + 1;
		int tz = (int)strtol(tzstring, NULL, 10);
		tm = *time_to_tm(strtoul(buffer, NULL, 10), tz);

However, I did not test it, and this might be completely bogus.

Ciao,
Dscho
	
