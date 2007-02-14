From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: mingw, windows, crlf/lf, and git
Date: Wed, 14 Feb 2007 10:31:39 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702141027380.3604@woody.linux-foundation.org>
References: <45CFA30C.6030202@verizon.net>
 <Pine.LNX.4.63.0702141653440.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <45D346B6.5020802@verizon.net> <200702141917.51341.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Mark Levedahl <mlevedahl@verizon.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mark Levedahl <mdl123@verizon.net>,
	Junio C Hamano <junkio@cox.net>,
	Alexander Litvinov <litvinov2004@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Wed Feb 14 19:32:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHOvj-00064J-JB
	for gcvg-git@gmane.org; Wed, 14 Feb 2007 19:32:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932438AbXBNScB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Feb 2007 13:32:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932440AbXBNScB
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 13:32:01 -0500
Received: from smtp.osdl.org ([65.172.181.24]:38547 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932438AbXBNScA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Feb 2007 13:32:00 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l1EIVehB011057
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 14 Feb 2007 10:31:40 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l1EIVdla005296;
	Wed, 14 Feb 2007 10:31:39 -0800
In-Reply-To: <200702141917.51341.robin.rosenberg.lists@dewire.com>
X-Spam-Status: No, hits=-0.409 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.117__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39722>



On Wed, 14 Feb 2007, Robin Rosenberg wrote:
> 
> That may be why an excellent piece of software, TortoiseCVS,  doesn't trust 
> cvs or cvsnt to do the job. Here is how they do the binary detection (and 
> some more):
> 
> http://tortoisecvs.cvs.sourceforge.net/tortoisecvs/TortoiseCVS/src/CVSGlue/CVSStatus.cpp?revision=1.172&view=markup

Well, it does seem to boil down to what Junio already got to:

 - 0-31 and 127 are never in text, except for BEL, BS, HT, LF, FF, CR and 
   ESC.
 - 128-255 can all be in either iso-8859 or extended ascii (or they 
   explicitly add NEL but not 128+27 to "normal ASCII", which is strange)

So they've effectively added BEL and ESC to the listof characters that 
Junio has now. But they also make it an absolute error to have anything 
else (no "1% rule").

But they also do the filename tests, and I think that's more important in 
many ways.

		Linus
