From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Fri, 18 Jan 2008 11:49:12 +0300
Message-ID: <20080118084912.GC14871@dpotapov.dyndns.org>
References: <478E1FED.5010801@web.de> <F666FFD2-9777-47EA-BEF4-C78906CA8901@simplicidade.org> <alpine.LFD.1.00.0801171100330.14959@woody.linux-foundation.org> <200801180205.28742.robin.rosenberg.lists@dewire.com> <alpine.LFD.1.00.0801171716310.2957@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	Pedro Melo <melo@simplicidade.org>,
	Mark Junker <mjscod@web.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Jan 18 09:50:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFmvU-0003WB-BL
	for gcvg-git-2@gmane.org; Fri, 18 Jan 2008 09:50:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750893AbYARItm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jan 2008 03:49:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752067AbYARItm
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jan 2008 03:49:42 -0500
Received: from smtp03.mtu.ru ([62.5.255.50]:61664 "EHLO smtp03.mtu.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750853AbYARItl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jan 2008 03:49:41 -0500
Received: from smtp03.mtu.ru (localhost.mtu.ru [127.0.0.1])
	by smtp03.mtu.ru (Postfix) with ESMTP id DBA131870347;
	Fri, 18 Jan 2008 11:49:31 +0300 (MSK)
Received: from dpotapov.dyndns.org (ppp85-141-191-154.pppoe.mtu-net.ru [85.141.191.154])
	by smtp03.mtu.ru (Postfix) with ESMTP id 604571870493;
	Fri, 18 Jan 2008 11:49:12 +0300 (MSK)
Received: from dpotapov by dpotapov.dyndns.org with local (Exim 4.63)
	(envelope-from <dpotapov@gmail.com>)
	id 1JFmuW-0005DY-JK; Fri, 18 Jan 2008 11:49:12 +0300
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.00.0801171716310.2957@woody.linux-foundation.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-DCC-STREAM-Metrics: smtp03.mtu.ru 10002; Body=0 Fuz1=0 Fuz2=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70980>

On Thu, Jan 17, 2008 at 05:24:01PM -0800, Linus Torvalds wrote:
> 
> On Fri, 18 Jan 2008, Robin Rosenberg wrote:
> 
> > It uses the local 8-bit codepage, which is not UTF-8, often some latin-inspired
> > thingy, but in Asia multi-byte encodings are used. In western Europe it is
> > Windows-1252, which is almost, but not exactly iso-8859-1. Oh, and then we
> > have the cmd prompt which has another encoding in 8-bit mode.

Yes, the default code page for the command prompt uses so-called OEM
encoding, and GUI programs uses another one, which MS calls as "ANSI"
encoding. However, if you use Cygwin, then you have ANSI encoding in
the command prompt. So, in the same command prompt window, you can have
Cygwin programs using one encoding and other window console programs
using a different encoding.

> 
> Well, if it uses a 8-bit codepage, then that means that as far as the 
> POSIX filename interface is concerned, it has nothing what-so-ever to do 
> with Unicode (ie unicode is just a totally invisible internal encoding 
> issue, not externally visible).

Some people tried to set the current code page to 65001, which is
the Microsoft code page for UTF-8. However, it seems that does not
work very well.

http://support.microsoft.com/kb/175392
http://blogs.msdn.com/michkap/archive/2006/03/13/550191.aspx

It seems to me that Win32 API functions work correctly with
UTF-8 (after all, they are just wrappers over UTF-16 functions),
but Microsoft's C library cannot handle UTF-8 (or any other
encoding that requires more than two bytes per character).

> Anybody know which one cygwin/mingw does?

There is a patch for Cygwin that adds UTF-8 support for it, however,
Cygwin maintainers do not like it, so it is not integrated. I think
Cygwin 1.7 will support UTF-8, but I have no idea how soon it will be
released.

I don't know much about mingw, but if I am not mistaken, mingw relies
on Microsoft's C library, so I suppose it uses an "OEM" code page for
console programs by default.


Dmitry
