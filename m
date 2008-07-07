From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: Re: [msysGit] [PATCH 10/12] Add ANSI control code emulation for the Windows console
Date: Mon, 7 Jul 2008 20:41:00 +0200
Message-ID: <200807072041.00680.johannes.sixt@telecom.at>
References: <15FB2EE9-298D-41D1-B66A-DDC786282ECB@zib.de> <1214987532-23640-9-git-send-email-prohaska@zib.de> <1214987532-23640-10-git-send-email-prohaska@zib.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: msysGit <msysgit@googlegroups.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: prohaska@zib.de, Peter <git@peter.is-a-geek.org>
X-From: git-owner@vger.kernel.org Mon Jul 07 20:42:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFvex-0007l2-Ql
	for gcvg-git-2@gmane.org; Mon, 07 Jul 2008 20:42:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754918AbYGGSlF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jul 2008 14:41:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754797AbYGGSlE
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jul 2008 14:41:04 -0400
Received: from smtp2.srv.eunet.at ([193.154.160.116]:47548 "EHLO
	smtp2.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754479AbYGGSlD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jul 2008 14:41:03 -0400
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp2.srv.eunet.at (Postfix) with ESMTP id 0459BBEE43;
	Mon,  7 Jul 2008 20:41:01 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id C1A8A19EC4;
	Mon,  7 Jul 2008 20:41:00 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <1214987532-23640-10-git-send-email-prohaska@zib.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87641>

On Mittwoch, 2. Juli 2008, Steffen Prohaska wrote:
> This adds only the minimum necessary to keep git pull/merge's diffstat from
> wrapping. Notably absent is support for the K (erase) operation, and
> support for POSIX write.

I've tested this patch, and it is no longer ready for prime-time in its 
current form. It doesn't do what it advertises (colorize diffstat of merge) 
because the diff machinery since some time now uses fprintf, not printf, so 
the replacements are not called and escape characters are left in the console 
window.

> +#ifdef WIN_ANSI
> +extern int git_fputs(const char *str, FILE *stream);
> +extern int git_printf(const char *format, ...) __attribute__((format
> (printf, 1, 2))); +#define fputs git_fputs
> +#define printf(...) git_printf(__VA_ARGS__)
> +#endif
> +
>  #endif

Put this (without #ifdef WIN_ANSI) in mingw.h and don't change the Makefile.

-- Hannes
