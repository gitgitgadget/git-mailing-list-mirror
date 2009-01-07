From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH/RFC] Allow writing loose objects that are corrupted in a
 pack file
Date: Tue, 06 Jan 2009 20:25:38 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0901062005290.26118@xanadu.home>
References: <20081209093627.77039a1f@perceptron>
 <1231282320.8870.52.camel@starfruit>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_w3IaqeRslgSuAg0o3Kl8Ng)"
Cc: =?ISO-8859-15?Q?Jan_Kr=FCger?= <jk@jk.gs>,
	Git ML <git@vger.kernel.org>
To: "R. Tyler Ballance" <tyler@slide.com>
X-From: git-owner@vger.kernel.org Wed Jan 07 02:27:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKNCP-0004rB-64
	for gcvg-git-2@gmane.org; Wed, 07 Jan 2009 02:27:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755391AbZAGBZq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2009 20:25:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755127AbZAGBZq
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jan 2009 20:25:46 -0500
Received: from relais.videotron.ca ([24.201.245.36]:33554 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753838AbZAGBZp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2009 20:25:45 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KD2006REULF7SH1@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 06 Jan 2009 20:24:52 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <1231282320.8870.52.camel@starfruit>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104743>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_w3IaqeRslgSuAg0o3Kl8Ng)
Content-type: TEXT/PLAIN; charset=UTF-8
Content-transfer-encoding: 8BIT

On Tue, 6 Jan 2009, R. Tyler Ballance wrote:

> On Tue, 2008-12-09 at 09:36 +0100, Jan Krüger wrote:
> > For fixing a corrupted repository by using backup copies of individual
> > files, allow write_sha1_file() to write loose files even if the object
> > already exists in a pack file, but only if the existing entry is marked
> > as corrupted.
> 
> I figured I'd reply to this again, since the issue cropped up again.
> 
> We started experiencing *large* numbers of corruptions like the ones
> that started the thread (one developer was receiving them once or twice
> a day) with v1.6.0.4
> 
> We went ahead and upgraded to a custom build of v1.6.1 with Jan's patch
> (below) and the issues /seem/ to have resolved themselves. I'm not
> certain whether Jan's patch was really responsible, or if there was
> another issue that caused this to correct itself in v1.6.1. 
> 
> As it stands, I think it's safe to assume that given the frequency of
> the occurances that they were not tied to a memory or disk error (or
> other levels of the machine's stack would be suffering as well). The
> only thing I can think of is that /some/ developers who've experienced
> the issue are using Samba mount points and changing files in Mac OS X,
> but using Git on the mounted share (i.e. TextMate changes a file hosted
> on Samba, changes are committed in an SSH session on that machine), but
> that doesn't account for everything.
> 
> If there was something else included in the v1.6.1 release please let me
> know so I can back Jan's patch out.

Please back it out.  As it stands, that patch is a no op because of the 
way git is used, and even if the patch was to work as intended, its 
purpose is not to magically fix corruptions without special action from 
your part.  If you have corruption problems coming back only because of 
the removal of this patch then something is really really fishy and I 
would really like to know about it.

There were indeed many changes between v1.6.0.4 and v1.6.1: the exact 
number is 1029.  A couple of them are especially addressing increased 
robustness against some kind of pack corruptions.  But in any case you 
still should see error messages appearing about them.

And don't underestimate the power of disk corruptions.  I started to 
work on git corruption resilience simply because I ended up with a 
corrupted pack at some point.  Then a while later I got another 
corrupted pack.  Then another while later I lost my filesystem entirely 
and had to reinstall my system (after buying a new disk).  Turns out 
that my old disk is silently corrupting data without signaling any 
errors to the host.


Nicolas

--Boundary_(ID_w3IaqeRslgSuAg0o3Kl8Ng)--
