From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 5/8] Teach run_command how to setup a stdin pipe
Date: Sun, 11 Mar 2007 03:07:11 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703110305000.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20070310082808.GE4133@spearce.org>
 <Pine.LNX.4.63.0703101753440.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <20070311014533.GA10343@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Mar 11 03:07:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQDTB-000300-4q
	for gcvg-git@gmane.org; Sun, 11 Mar 2007 03:07:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932465AbXCKCHP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Mar 2007 21:07:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932468AbXCKCHO
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Mar 2007 21:07:14 -0500
Received: from mail.gmx.net ([213.165.64.20]:58235 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932465AbXCKCHN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Mar 2007 21:07:13 -0500
Received: (qmail invoked by alias); 11 Mar 2007 02:07:11 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO wbgn013.biozentrum.uni-wuerzburg.de) [132.187.25.13]
  by mail.gmx.net (mp054) with SMTP; 11 Mar 2007 03:07:11 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19XFLxUuhdXVOUGYIC2viHagyJ0ycyVt62LzB0KvN
	ox9zUvChpZbKcX
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <20070311014533.GA10343@spearce.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41896>

Hi,

On Sat, 10 Mar 2007, Shawn O. Pearce wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > On Sat, 10 Mar 2007, Shawn O. Pearce wrote:
> > 
> > > Sometimes callers trying to use run_command to execute a child 
> > > process will want to setup a pipe or file descriptor to redirect 
> > > into the child's stdin.
> > > 
> > > This idea is completely stolen from builtin-bundle's fork_with_pipe, 
> > > written by Johannes Schindelin.  All credit (and blame) should lie 
> > > with Dscho.  ;-)
> > 
> > ;-)
> > 
> > Thank you for starting this thread. I think it makes a lot of sense in 
> > the face of the MinGW port. (I am not interested in the hook stuff 
> > personally, so I'll not comment on that.)
> 
> I'd like to see run_command learn how to also redirect stdout, then 
> replace fork_with_pipe in builtin-bundle with run_command. We should be 
> able to also improve some of our other more direct uses of fork to use 
> run_command at that point too.

I concur.

> I don't know squat about MinGW, so I don't know if having the 
> run_command abstraction really helps there or not, but I know we tried 
> to make it with the good intentions of being able to use it to wrap that 
> asinine CreateProcess() thing that Win32 has...

There is only one place that I am aware of, where this is not enough: For 
the shallow thing, upload-pack fork()s but does not execute another 
program, but lists all the objects to be uploaded. (For shallow, this 
_cannot_ be an external process, since it mucks with the commits which are 
to be treated as shallow).

Ciao,
Dscho
