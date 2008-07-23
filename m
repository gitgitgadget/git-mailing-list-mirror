From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] git daemon: avoid waking up too often
Date: Wed, 23 Jul 2008 11:17:00 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807231112310.2830@eeepc-johanness>
References: <alpine.DEB.1.00.0807222251570.8986@racer> <alpine.DEB.1.00.0807222302440.8986@racer> <4886D503.7030106@viscovery.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Jul 23 11:17:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLaT8-0004Vs-FK
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 11:17:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751817AbYGWJQK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 05:16:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751772AbYGWJQJ
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 05:16:09 -0400
Received: from mail.gmx.net ([213.165.64.20]:58310 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751570AbYGWJQI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 05:16:08 -0400
Received: (qmail invoked by alias); 23 Jul 2008 09:16:05 -0000
Received: from 88-107-142-10.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.142.10]
  by mail.gmx.net (mp060) with SMTP; 23 Jul 2008 11:16:05 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+29aFmeBi2EYt4WuBwVaF//6JjMA9omOC8Bgz8mL
	Od4EQSzKsKCHAf
X-X-Sender: user@eeepc-johanness
In-Reply-To: <4886D503.7030106@viscovery.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.66
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89615>

Hi,

On Wed, 23 Jul 2008, Johannes Sixt wrote:

> Johannes Schindelin schrieb:
> > To avoid waking up unnecessarily, a pipe is set up that is only ever
> > written to by child_handler(), when a child disconnects, as suggested
> > per Junio.
> > 
> > This avoids waking up the main process every second to see if a child
> > was disconnected.
> 
> This makes porting this beast to Windows practically impossible because we
> cannot have a poll() implementation that waits both on a listening socket
> and a pipe. :-(

Umm.  We also do not have signal handlers, do we?  AFAICT you wanted to 
simulate _this_ program's fork() with a start_async(), right?  All you 
have to do is to refactor the code with the pipe to do the update 
(properly guarded by a mutex, which is called "CriticalSection" in Windows 
speak, since it is impossible for Microsoft to accept common conventions).

The biggest part to get this beast running on Windows is to move it to the 
start_async() method, not above-mentioned refactoring.

Ciao,
Dscho
