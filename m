From: Theodore Tso <tytso@MIT.EDU>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Mon, 21 Jan 2008 15:46:14 -0500
Message-ID: <20080121204614.GG29792@mit.edu>
References: <Pine.LNX.4.64.0801181114430.817@ds9.cixit.se> <alpine.LFD.1.00.0801180909000.2957@woody.linux-foundation.org> <Pine.LNX.4.64.0801211509490.17095!@ds9.cixit.se> <440E4426-BFB5-4836-93DF-05C99EF204E6@sb.org> <alpine.LFD.1.00.0801210934400.2957@woody.linux-foundation.org> <C6C0E6A1-053B-48CE-90B3-8FFB44061C3B@sb.org> <20080121195703.GE29792@mit.edu> <998717B0-0165-4383-AAB8-33BD2A49954E@sb.org> <20080121201530.GF29792@mit.edu> <8F85366A-C990-47B1-BF60-936185B9E438@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Karlsson <peter@softwolves.pp.se>,
	Mark Junker <mjscod@web.de>,
	Pedro Melo <melo@simplicidade.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Mon Jan 21 21:47:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JH3YH-0004ik-K2
	for gcvg-git-2@gmane.org; Mon, 21 Jan 2008 21:47:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752679AbYAUUrA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2008 15:47:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752592AbYAUUrA
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 15:47:00 -0500
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:63421 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752101AbYAUUq7 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Jan 2008 15:46:59 -0500
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id m0LKkGh6023671;
	Mon, 21 Jan 2008 15:46:17 -0500 (EST)
Received: from closure.thunk.org (c-76-19-244-124.hsd1.ma.comcast.net [76.19.244.124])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id m0LKkER1011996
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 21 Jan 2008 15:46:16 -0500 (EST)
Received: from tytso by closure.thunk.org with local (Exim 4.67)
	(envelope-from <tytso@mit.edu>)
	id 1JH3X4-0007s9-G1; Mon, 21 Jan 2008 15:46:14 -0500
Content-Disposition: inline
In-Reply-To: <8F85366A-C990-47B1-BF60-936185B9E438@sb.org>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71333>

On Mon, Jan 21, 2008 at 03:31:02PM -0500, Kevin Ballard wrote:
>> No, it's still broken, because of the Unicode-is-not-static problem.
>> What happens when you start adding more composable characters, which
>> some future version of HFS+ will start breaking apart?
>
> If you need a static representation, you normalize to a specific form. And 
> in fact, adding new composable characters doesn't matter, since if they 
> didn't exist before, you couldn't have possibly used them. 

Sure you can.  Suppose you unpack the same tar file or zip file that
contains one of these new-fangled characters, one on a MacOS 10.5
system, and one on a MacOS 10.9 system.  How HFS+ will corrupt that
filename will differ depending which version of MacOS you are running.
Hence, normalizing the filename when you store it is stupid and
broken.  MacOS and its applications and libraries want to do
normalization in the privacy of its own address space, that's it's
business.  It can pursue any fetish it wants, among consenting adults.
Safe, sane and consensual, and all that... well, consensual, anyway.
I'm not sure about "safe" and "sane"....

My arguement is basically is that there is absolutely no value in what
HFS+ is doing, by corrupting filenames --- if you want to call it
"normalizing" them, fine, but since Unicode is not static, so you
can't even call it a "canonical" form.  It's just some random
corruption of what was passed in at open(2) time, that can and will
change depending on what version of MacOS you are running.

If you want to play the insane Unicode game of "equivalent"
characters, you have to do it at comparison time, so there's no point
trying to "normalize" them when you store them.  It doesn't buy you
anything, and it causes all sorts of pain.

> Your entire argument is based on the assumption that HFS+ "corrupts" 
> filenames in order to allow dumb clients to do byte comparisons, and I 
> don't believe that to be the case. 

OK, what's your reason for why HFS+ corrupts filenames?  What do you
think is its excuse?  What problem does it solve?  If the answer is
"no reason at all, but because it *can*", according to the Great God
Unicode, then that's really not very impressive....

						- Ted
