From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] fetch-pack: Prepare for a side-band demultiplexer in a
	thread.
Date: Sun, 18 Nov 2007 02:05:32 +0100
Message-ID: <20071118010532.GC7664@steel.home>
References: <200711172309.28364.johannes.sixt@telecom.at> <7vtznkz8nw.fsf@gitster.siamese.dyndns.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 18 02:05:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ItYbh-0001J5-KT
	for gcvg-git-2@gmane.org; Sun, 18 Nov 2007 02:05:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754722AbXKRBFg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Nov 2007 20:05:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754705AbXKRBFg
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Nov 2007 20:05:36 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:21498 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754151AbXKRBFf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Nov 2007 20:05:35 -0500
Received: from tigra.home (Fc945.f.strato-dslnet.de [195.4.201.69])
	by post.webmailer.de (klopstock mo54) (RZmta 14.0)
	with ESMTP id N047bajAI03v8j ; Sun, 18 Nov 2007 02:05:33 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 186C6277AE;
	Sun, 18 Nov 2007 02:05:33 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id AC74B56D22; Sun, 18 Nov 2007 02:05:32 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7vtznkz8nw.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaFzAPrzg==
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65329>

Junio C Hamano, Sun, Nov 18, 2007 01:42:11 +0100:
> Johannes Sixt <johannes.sixt@telecom.at> writes:
> 
> > 	This change again originates from the MinGW port. Since we don't
> > 	have fork(2) on Windows, we must run the sideband demultiplexer
> > 	in a thread.
> 
> If the rationale was "running in a thread is more natural on the
> platform", I would understand it.
> 
> But "_must_ run because there is no fork(2)" solicits a "Huh?
> How does Cygwin does it then?" from me.
> 

You wont believe it: they start the currently running program again
and copy parents memory over into the child. Sometimes it fails.
If you want something scary:
http://cygwin.com/cgi-bin/cvsweb.cgi/src/winsup/cygwin/fork.cc?rev=1.193&content-type=text/x-cvsweb-markup&cvsroot=src
