From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH/RFC] recv_sideband: Band #2 always goes to stderr
Date: Tue, 10 Mar 2009 13:35:30 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0903101329370.30483@xanadu.home>
References: <cover.1236639280u.git.johannes.schindelin@gmx.de>
 <e2b19f6c7c50e5b0a652c40b0d8e4947134ed669.1236639280u.git.johannes.schindelin@gmx.de>
 <49B61377.90103@viscovery.net> <49B61703.8030602@viscovery.net>
 <20090310144646.GQ11989@spearce.org> <49B680F7.4040103@viscovery.net>
 <alpine.DEB.1.00.0903101605460.14295@intel-tinevez-2-302>
 <49B683BC.3030104@viscovery.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	gitster@pobox.com, Peter Harris <git@peter.is-a-geek.org>,
	Sebastian Schuberth <sschuberth@gmail.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Mar 10 18:37:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lh5tC-0005LO-M7
	for gcvg-git-2@gmane.org; Tue, 10 Mar 2009 18:37:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755221AbZCJRfq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Mar 2009 13:35:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754769AbZCJRfp
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Mar 2009 13:35:45 -0400
Received: from relais.videotron.ca ([24.201.245.36]:51011 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754591AbZCJRfo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Mar 2009 13:35:44 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KGA00AUYWV6MN60@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 10 Mar 2009 13:35:30 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <49B683BC.3030104@viscovery.net>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112834>

On Tue, 10 Mar 2009, Johannes Sixt wrote:

> Johannes Schindelin schrieb:
> > I think, indeed, that you can avoid the memcpy() by using %.*s.  The 
> > private buffer is only used to make sure that the text is written in one 
> > go anyway (i.e. that two sidebands messages are not written to the same 
> > line because they use multiple calls to fprintf()/fwrite() per line), 
> > right?
> 
> It must be something like that, yes. ;)

It is a bit more complex than that.

Messages received over sideband #2 may have two kinds of line break 
characters: \r or \n.  We also have a string suffix which is used to 
clear the remaining of the screen line in those cases where a previous 
line is overwritten and the previous line was longer.  That may happen 
if the previous line was terminated with \r.  In that case, the string 
suffix _must_ be inserted before the line break character for obvious 
reasons.


Nicolas
