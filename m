From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] daemon: send stderr of service programs to the syslog
Date: Mon, 15 Jun 2009 11:34:15 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0906151117560.16467@xanadu.home>
References: <200906142238.51725.j6t@kdbg.org>
 <20090615145716.GW16497@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Johannes Sixt <j6t@kdbg.org>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Jun 15 17:34:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGECa-0005pz-Oa
	for gcvg-git-2@gmane.org; Mon, 15 Jun 2009 17:34:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754565AbZFOPeU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jun 2009 11:34:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754105AbZFOPeS
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jun 2009 11:34:18 -0400
Received: from relais.videotron.ca ([24.201.245.36]:52385 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753178AbZFOPeS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jun 2009 11:34:18 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KLA00MZADERZ8A0@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 15 Jun 2009 11:23:15 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20090615145716.GW16497@spearce.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121615>

On Mon, 15 Jun 2009, Shawn O. Pearce wrote:

> But I have to wonder, why are we doing this?  Why can't we teach the
> individual server program to record its error to the syslog before
> it aborts?  Are we looking for SIGSEGV or something?  Its only the
> daemon program staying around in memory, but that's a lot of little
> daemons doing nothing waiting for their children to terminate.

Those daemons certainly have very little in terms of private data memory 
usage, so all of them will share the same memory pages in practice. And 
it is certainly best to have only one location to deal with syslog usage 
than having each server programs to do it, after figuring out if they 
are actually invoked in a context that requires syslog instead of 
stderr.  Having the git daemon deal with syslog, and log any abnormal 
exit code from the programs it spawn is IMHO a pretty logical thing to 
do.


Nicolas
