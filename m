From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Decompression speed: zip vs lzo
Date: Fri, 11 Jan 2008 08:03:13 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0801110759160.3148@woody.linux-foundation.org>
References: <e5bfff550801091401y753ea883p8d08b01f2b391147@mail.gmail.com> <7v4pdmfw27.fsf@gitster.siamese.dyndns.org> <47855765.9090001@vilain.net> <alpine.LSU.1.00.0801092328580.31053@racer.site> <47856E8D.4010006@vilain.net> <4785A6DB.3080007@vilain.net>
 <20080110091607.GA17944@artemis.madism.org> <alpine.LFD.1.00.0801101332150.3054@xanadu.home> <alpine.LFD.1.00.0801101252030.3148@woody.linux-foundation.org> <478691EB.1080704@vilain.net> <alpine.LFD.1.00.0801101400550.3148@woody.linux-foundation.org>
 <47869C24.3000400@vilain.net> <alpine.LFD.1.00.0801101454440.3148@woody.linux-foundation.org> <4786BFCD.1000303@vilain.net> <alpine.LFD.1.00.0801101805540.3148@woody.linux-foundation.org> <47870CDF.4010606@vilain.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nicolas Pitre <nico@cam.org>,
	Pierre Habouzit <madcoder@debian.org>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Marco Costalba <mcostalba@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Fri Jan 11 17:06:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDMNv-0001Wg-V4
	for gcvg-git-2@gmane.org; Fri, 11 Jan 2008 17:05:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760728AbYAKQFE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2008 11:05:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760701AbYAKQFE
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jan 2008 11:05:04 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:52187 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759867AbYAKQFC (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Jan 2008 11:05:02 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0BG3F6V006773
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 11 Jan 2008 08:03:16 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0BG3D3Y017398;
	Fri, 11 Jan 2008 08:03:14 -0800
In-Reply-To: <47870CDF.4010606@vilain.net>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-2.722 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70171>



On Fri, 11 Jan 2008, Sam Vilain wrote:
> 
> The difference seems only barely measurable;

Ok. 

It may be that it might help other cases, but that seems unlikely.

The more likely answer is that it's either of:

 - yes, zlib uncompression is noticeable in profiles, but that the 
   cold-cache access is simply the bigger problem, and getting rid of zlib 
   just moves the expense to whatever other thing that needs to access it 
   (memcpy, xdelta apply, whatever)

or

 - I don't know exactly which patch you used (did you just do the 
   "core.deltacompression=0" thing?), and maybe zlib is fairly expensive 
   even for just the setup crud, even when it doesn't really need to be.

but who knows..

		Linus
