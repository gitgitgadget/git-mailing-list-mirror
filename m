From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Replacement for cvs2cl, for generating ChangeLog
Date: Tue, 27 Feb 2007 16:56:32 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702271648430.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <877iu3q13r.fsf@latte.josefsson.org> <200702271257.37437.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Simon Josefsson <simon@josefsson.org>
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 27 16:56:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HM4gw-0003W0-5J
	for gcvg-git@gmane.org; Tue, 27 Feb 2007 16:56:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751627AbXB0P4f (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 10:56:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751642AbXB0P4f
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 10:56:35 -0500
Received: from mail.gmx.net ([213.165.64.20]:41117 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751627AbXB0P4e (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 10:56:34 -0500
Received: (qmail invoked by alias); 27 Feb 2007 15:56:32 -0000
X-Provags-ID: V01U2FsdGVkX1+VUVNCT0iVGRR4gX9J3ZEIzkgk7YTxrQsE0e4M69
	Q1dw==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <200702271257.37437.andyparkins@gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40751>

Hi,

On Tue, 27 Feb 2007, Andy Parkins wrote:

> [...] perhaps a change to git's own log generator to support
> 
>  git-rev-list --pretty=gnucl
> 
> would be more appropriate.

I was already hacking on a builtin changelog command, because I was 
convinced that this breaks our model in builtin-log: We show the commit 
information first, and _then_ we call the diff machinery. And GNU 
ChangeLog format mixes these informations: the date and the author are 
commit information, but the files are tree information, and the oneline is 
commit information again.

However, your mail made me think again.

I now reused (AKA misused) the stats separator to take the oneline 
description, which is set in show_log() when revs->commit_format == 
CMIT_FMT_CHANGELOG, which is output by diff_flush() when the 
diff_options->output_format == DIFF_FORMAT_CHANGELOG.

BTW I already found a subtle bug. In finalize_changelog(), 
options->stat_sep can be NULL, if no oneline was found.

But AFAIK we do not allow empty commit messages, so this bug would never 
have been triggered.

Ciao,
Dscho
