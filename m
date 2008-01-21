From: Nicolas Pitre <nico@cam.org>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Mon, 21 Jan 2008 12:08:29 -0500 (EST)
Message-ID: <alpine.LFD.1.00.0801211151180.20753@xanadu.home>
References: <478E1FED.5010801@web.de>
 <alpine.LFD.1.00.0801161424040.2806@woody.linux-foundation.org>
 <7652B11D-9B9F-45EA-9465-8294B701FE7C@sb.org>
 <alpine.LFD.1.00.0801161522160.2806@woody.linux-foundation.org>
 <B45968C6-3029-48B6-BED2-E7D5A88747F7@sb.org>
 <alpine.LFD.1.00.0801161707150.2806@woody.linux-foundation.org>
 <8AC4CC86-A711-483D-9F9C-5F8497006A1D@sb.org>
 <alpine.LFD.1.00.0801161959210.2806@woody.linux-foundation.org>
 <B719D4A2-0D05-4C55-95FC-AB880D58E1AC@wincent.com>
 <alpine.LFD.1.00.0801170842280.14959@woody.linux-foundation.org>
 <478F99E7.1050503@web.de>
 <alpine.LFD.1.00.0801171017460.14959@woody.linux-foundation.org>
 <F666FFD2-9777-47EA-BEF4-C78906CA8901@simplicidade.org>
 <alpine.LFD.1.00.0801171100330.14959@woody.linux-foundation.org>
 <Pine.LNX.4.64.0801181114430.817@ds9.cixit.se>
 <alpine.LFD.1.00.0801180909000.2957@woody.linux-foundation.org>
 <Pine.LNX.4.64.0801211509490.17095@ds9.cixit.se>
 <440E4426-BFB5-4836-93DF-05C99EF204E6@sb.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Peter Karlsson <peter@softwolves.pp.se>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Mark Junker <mjscod@web.de>,
	Pedro Melo <melo@simplicidade.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Mon Jan 21 18:09:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JH08r-0008PX-Fq
	for gcvg-git-2@gmane.org; Mon, 21 Jan 2008 18:09:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751338AbYAURIc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2008 12:08:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751404AbYAURIb
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 12:08:31 -0500
Received: from relais.videotron.ca ([24.201.245.36]:17799 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751065AbYAURIb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2008 12:08:31 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JV000KW87M0S880@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 21 Jan 2008 12:08:24 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <440E4426-BFB5-4836-93DF-05C99EF204E6@sb.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71296>

On Mon, 21 Jan 2008, Kevin Ballard wrote:

> On Jan 21, 2008, at 9:14 AM, Peter Karlsson wrote:
> 
> > I happen to prefer the text-as-string-of-characters (or code points,
> > since you use the other meaning of characters in your posts), since I
> > come from the text world, having worked a lot on Unicode text
> > processing.
> > 
> > You apparently prefer the text-as-sequence-of-octets, which I tend to
> > dislike because I would have thought computer engineers would have
> > evolved beyond this when we left the 1900s.
> 
> I agree. Every single problem that I can recall Linus bringing up as a
> consequence of HFS+ treating filenames as strings is in fact only a problem if
> you then think of the filename as octets at some point. If you stick with
> UTF-8 equivalence comparison the entire time, then everything just works.
> 
> Granted, this is a problem when you have to operate on a filesystem that
> thinks of filenames as octets, but as I said before, this doesn't mean the
> HFS+ approach is wrong, it just means it's incompatible with Linus's approach.

Linus' approach is _FAST_.

Why do you think Git has now acquired a reputation of kicking asses all 
around the SCM scene?

The HFS+ approach might be fine if you think of it in terms of "the user 
will be awfully confused if two file names are shown identically in the 
File Open dialog box".  But it otherwise sucks big time when it comes to 
high performance applications needing to deal with a huge amount of file 
names at once.

Normalization will always hurt performances.  This is an overhead.  
Sometimes that overhead might be insignificant and not be perceptible, 
but sometimes it is.  And Git is clearly in the later case. Performances 
will be hurt big time the day it is made aware of that normalization. 
This is why there is so much resistance about it, especially when the 
benefits of normalizing file names are not shown to be worth their cost 
in performance and complexity, as other systems do rather fine without 
it.


Nicolas
