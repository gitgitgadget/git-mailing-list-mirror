From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git clone http://git.savannah.gnu.org/cgit/xboard.git
 segfaults
Date: Mon, 17 Aug 2009 16:22:19 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908171620160.4991@intel-tinevez-2-302>
References: <20090817135651.GA4570@harikalardiyari> <alpine.DEB.1.00.0908171616340.4991@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Ali Polatel <polatel@gmail.com>, Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 17 16:22:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Md36U-0007FY-2X
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 16:22:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754203AbZHQOWU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 10:22:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753164AbZHQOWU
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 10:22:20 -0400
Received: from mail.gmx.net ([213.165.64.20]:38037 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753406AbZHQOWT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2009 10:22:19 -0400
Received: (qmail invoked by alias); 17 Aug 2009 14:22:19 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp048) with SMTP; 17 Aug 2009 16:22:19 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/vgEJvdjzvWFiSVCHml37DrZXNDF8B7LTExdvIUv
	upGN07QGF+UcAl
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <alpine.DEB.1.00.0908171616340.4991@intel-tinevez-2-302>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126185>

Hi,

On Mon, 17 Aug 2009, Johannes Schindelin wrote:

> On Mon, 17 Aug 2009, Ali Polatel wrote:
> 
> > Here's what gdb has to say about it:
> >
> > [...]
> 
> Here's what valgrind has to say about it (with a current 'next' + 
> patches):
> 
> ==25434== Invalid read of size 8
> ==25434==    at 0x407433: process_object_response (http-walker.c:91)
> ==25434==    by 0x405713: finish_active_slot (http.c:657)
> ==25434==    by 0x40448F: process_curl_messages (http.c:119)
> ==25434==    by 0x40546A: step_active_slots (http.c:571)
> ==25434==    by 0x4080E8: fetch_object (http-walker.c:476)
> ==25434==    by 0x408316: fetch (http-walker.c:526)
> ==25434==    by 0x42876C: loop (walker.c:176)
> ==25434==    by 0x428C65: walker_fetch (walker.c:287)
> ==25434==    by 0x40401F: main (remote-curl.c:111)

Oops, forgot the more important part:

==25434==  Address 0x87a7bd0 is 0 bytes inside a block of size 64 free'd
==25434==    at 0x4C265AF: free (vg_replace_malloc.c:323)
==25434==    by 0x4075F5: release_object_request (http-walker.c:128)
==25434==    by 0x408022: abort_object_request (http-walker.c:452)
==25434==    by 0x4080D7: fetch_object (http-walker.c:470)
==25434==    by 0x408316: fetch (http-walker.c:526)
==25434==    by 0x42876C: loop (walker.c:176)
==25434==    by 0x428C65: walker_fetch (walker.c:287)
==25434==    by 0x40401F: main (remote-curl.c:111)

Seems that an object request is aborted, but the slot, and therefore the 
callback, is called nevertheless.  Tay, does that ring a bell?

Ciao,
Dscho
