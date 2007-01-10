From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] Replacing the system call pread() with
 lseek()/xread()/lseek() sequence.
Date: Tue, 09 Jan 2007 20:12:34 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0701092010090.4964@xanadu.home>
References: <45A40C15.1070200@shadowen.org> <20070109232540.GA30023@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Andy Whitcroft <apw@shadowen.org>,
	"Stefan-W. Hahn" <stefan.hahn@s-hahn.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 10 02:12:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4S1O-0003lr-JG
	for gcvg-git@gmane.org; Wed, 10 Jan 2007 02:12:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932614AbXAJBMw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Jan 2007 20:12:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932619AbXAJBMw
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jan 2007 20:12:52 -0500
Received: from relais.videotron.ca ([24.201.245.36]:55955 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932614AbXAJBMv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jan 2007 20:12:51 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JBM003DWOOYJMG0@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 09 Jan 2007 20:12:34 -0500 (EST)
In-reply-to: <20070109232540.GA30023@spearce.org>
X-X-Sender: nico@xanadu.home
To: "Shawn O. Pearce" <spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36460>

On Tue, 9 Jan 2007, Shawn O. Pearce wrote:

> Andy Whitcroft <apw@shadowen.org> wrote:
> > How likely are we ever to be in the right place here?  Seems vanishingly
> > small putting us firmly in the four syscalls per call space.  I wonder
> > if git ever actually cares about the seek location.  ie if we could stop
> > reading and resetting it.  Probabally not worth working it out I guess
> > as any _sane_ system has one.
> 
> Andy's right actually.  If we are using pread() we aren't relying
> on the current file pointer.  Which means its unnecessary to get
> the current pointer before seeking to the requested offset, and its
> unnecessary to restore it before the git_pread() function returns.

No this is wrong.  The original offset _has_ to be preserved.  
index-pack counts on it.


Nicolas
