From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [EGIT PATCH 1/4] Change history page table to SWT.VIRTUAL.
Date: Mon, 31 Mar 2008 23:36:14 -0400
Message-ID: <20080401033614.GP10274@spearce.org>
References: <1206890314-3712-1-git-send-email-rogersoares@intelinet.com.br> <20080331053430.GJ10274@spearce.org> <47F1AB1B.90309@intelinet.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, robin.rosenberg@dewire.com
To: "Roger C. Soares" <rogersoares@intelinet.com.br>
X-From: git-owner@vger.kernel.org Tue Apr 01 05:37:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JgXJ3-0006vR-C6
	for gcvg-git-2@gmane.org; Tue, 01 Apr 2008 05:37:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752931AbYDADgX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Mar 2008 23:36:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752098AbYDADgW
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Mar 2008 23:36:22 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:58433 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751895AbYDADgW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Mar 2008 23:36:22 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JgXI4-0002u7-Qv; Mon, 31 Mar 2008 23:36:04 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 509E220FBAE; Mon, 31 Mar 2008 23:36:15 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <47F1AB1B.90309@intelinet.com.br>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78620>

"Roger C. Soares" <rogersoares@intelinet.com.br> wrote:
> Shawn O. Pearce escreveu:
> >Yea, I originally wrote my series around the VIRTUAL flag but on
> >Win32 it caused ArrayIndexOutOfBoundsExceptions to be thrown from
> >deep down within the Win32 implementation of the SWT Table widget.
> >
> >Appears to be something of a known bug, based on the Eclipse issue
> >tracker, but not much work happening to fix it.
>
> Hum, a VIRTUAL table sounds like a very usefull feature to be badly 
> broken on windows, at least there should be some workaround... is it 
> easily reproducible?

I tested your patch this evening on Win32.  Its nearly instant.
Seriously.  gitk can't touch it on the same system.  The bug I
was seeing didn't happen.

Originally I wrote the graph table using the ILazyContentProvider
*and* the SWT.VIRTUAL flag.  I didn't realize you had the option to
set only the SWT.VIRTUAL flag.  I think the bug on Win32 is related
to how the ILazyContentProvider gets used by the JFace TableViewer
and less about the SWT.VIRTUAL flag itself.

So anyway, I see no breakage on Mac OS X or Win32 with your patch,
and you said you tested it on Linux, so I'm going to include it.
Thanks for figuring that one out, its a nice performance boost.

> >I'll retest this tomorrow on Win32, but I'm pretty certain its
> >a bad idea on that platform.  What are you running on, Linux?
> >Maybe we can set this flag everywhere except on Win32
>
> Yep, linux.
> 
> Maybe another option to try before leaving windows out is the 
> ILazyContentProvider. Have you noticed that while GenerateHistoryJob is 
> updating the table you can't use it? Because the input is regenerated 
> every time, the table keeps going back to the first row.

Hmm.  I didn't notice that, but at this point its so damn fast for
me that I don't have the reflexes to really try and use the table
before GenerateHistoryJob is complete.  I'll have to add some sleeps
in there to make it slow down its work and see if I can reproduce
what you are describing.

-- 
Shawn.
