From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: CPPCheck found 24 high risk bugs in Git v.1.8.3.4
Date: Tue, 20 Aug 2013 20:44:37 +0200
Message-ID: <87eh9op5gq.fsf@igel.home>
References: <85C8141E5DAD94428A121F706995A31F010F116FDAD3@MX1.net.tbe.com>
	<33FCCE7A2CD5494B88F3C5CDBC341DFD@PhilipOakley>
	<166132E40AA54EE387BA9B4558823C55@PhilipOakley>
	<CABPQNSZidMv4MEW+SqVm94pX4szw9QW8LFWsvBTOXYH7ezzycw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Philip Oakley <philipoakley@iee.org>,
	"Koch\, Rick \(Subcontractor\)" <Rick.Koch@tbe.com>,
	Git List <git@vger.kernel.org>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Tue Aug 20 20:44:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VBqvA-0002TN-4D
	for gcvg-git-2@plane.gmane.org; Tue, 20 Aug 2013 20:44:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751246Ab3HTSoo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Aug 2013 14:44:44 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:49891 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750931Ab3HTSon (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Aug 2013 14:44:43 -0400
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3cKLX72CGjz4KK2L;
	Tue, 20 Aug 2013 20:44:39 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3cKLX723sDzbbky;
	Tue, 20 Aug 2013 20:44:39 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id AxB5tzMHMUwb; Tue, 20 Aug 2013 20:44:38 +0200 (CEST)
X-Auth-Info: WKLnlj9LiCNjQSOgQq+V+qPTGdF4zm4dBwY3/cyCY8A=
Received: from igel.home (ppp-88-217-111-200.dynamic.mnet-online.de [88.217.111.200])
	by mail.mnet-online.de (Postfix) with ESMTPA;
	Tue, 20 Aug 2013 20:44:38 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
	id C35E02C0282; Tue, 20 Aug 2013 20:44:37 +0200 (CEST)
X-Yow: I am KING BOMBA of Sicily!..I will marry LUCILLE BALL next Friday!
In-Reply-To: <CABPQNSZidMv4MEW+SqVm94pX4szw9QW8LFWsvBTOXYH7ezzycw@mail.gmail.com>
	(Erik Faye-Lund's message of "Tue, 20 Aug 2013 01:15:02 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232627>

Erik Faye-Lund <kusmabite@gmail.com> writes:

> diff --git a/compat/win32/syslog.c b/compat/win32/syslog.c
> index d015e43..0641f4e 100644
> --- a/compat/win32/syslog.c
> +++ b/compat/win32/syslog.c
> @@ -43,11 +43,14 @@ void syslog(int priority, const char *fmt, ...)
>   va_end(ap);
>
>   while ((pos = strstr(str, "%1")) != NULL) {
> - str = realloc(str, ++str_len + 1);
> - if (!str) {
> + char *tmp = realloc(str, ++str_len + 1);
> + if (!tmp) {
>   warning("realloc failed: '%s'", strerror(errno));
> + free(str);
>   return;
>   }
> + pos = tmp + (pos - str);

Pedantically, this is undefined (uses of both pos and str may trap after
realloc has freed the original pointer), it is better to calculate the
difference before calling realloc.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
