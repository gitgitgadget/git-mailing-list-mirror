From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Sun, 20 Jan 2008 00:17:06 +0300
Message-ID: <20080119211706.GK14871@dpotapov.dyndns.org>
References: <alpine.LFD.1.00.0801170842280.14959@woody.linux-foundation.org> <478F99E7.1050503@web.de> <alpine.LFD.1.00.0801171017460.14959@woody.linux-foundation.org> <F666FFD2-9777-47EA-BEF4-C78906CA8901@simplicidade.org> <alpine.LFD.1.00.0801171100330.14959@woody.linux-foundation.org> <Pine.LNX.4.64.0801181114430.817@ds9.cixit.se> <alpine.LFD.1.00.0801180909000.2957@woody.linux-foundation.org> <2E6F57FC-3E78-4DD2-9B5B-CF75975D6A60@sb.org> <20080119084814.GH14871@dpotapov.dyndns.org> <FD3512A5-1CC6-4F02-8C56-4CAD6F50981B@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Karlsson <peter@softwolves.pp.se>,
	Mark Junker <mjscod@web.de>,
	Pedro Melo <melo@simplicidade.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Sat Jan 19 22:17:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGL4b-00072Q-54
	for gcvg-git-2@gmane.org; Sat, 19 Jan 2008 22:17:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751307AbYASVRM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jan 2008 16:17:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751270AbYASVRM
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Jan 2008 16:17:12 -0500
Received: from smtp08.mtu.ru ([62.5.255.55]:53368 "EHLO smtp08.mtu.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751292AbYASVRL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jan 2008 16:17:11 -0500
Received: from smtp08.mtu.ru (localhost [127.0.0.1])
	by smtp08.mtu.ru (Postfix) with ESMTP id B5460F7742F;
	Sun, 20 Jan 2008 00:17:08 +0300 (MSK)
Received: from dpotapov.dyndns.org (ppp85-141-188-224.pppoe.mtu-net.ru [85.141.188.224])
	by smtp08.mtu.ru (Postfix) with ESMTP id AB276F775D9;
	Sun, 20 Jan 2008 00:17:05 +0300 (MSK)
Received: from dpotapov by dpotapov.dyndns.org with local (Exim 4.63)
	(envelope-from <dpotapov@gmail.com>)
	id 1JGL3q-0000pO-1q; Sun, 20 Jan 2008 00:17:06 +0300
Content-Disposition: inline
In-Reply-To: <FD3512A5-1CC6-4F02-8C56-4CAD6F50981B@sb.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-DCC-STREAM-Metrics: smtp08.mtu.ru 10001; Body=0 Fuz1=0 Fuz2=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71132>

On Sat, Jan 19, 2008 at 09:55:45AM -0500, Kevin Ballard wrote:
> 
> >[And please stop calling by normalization what is not. Mac does NOT
> >normalize Unicode strings, it uses some sub-standard conversion,
> >which neither produce a normalized string nor is guaranteed to be
> >stable across versions of Unicode.]
> 
> From what the HFS+ technote says, it produces a variant of Normal  
> Form D. 

There is no such thing in the standard as a variant of NFD. Moreover,
even if this conversion were described in the standard, it would never
called as normalization, because normalization means conversion that
makes all equivalent strings having identical binary representations.
HFS+ conversion does not met this criterion, so it not normalization.

> This variant, while not guaranteed to be stable across  
> versions of HFS+, but in practice it is stable.
> 
> What would you prefer I call it?

Apple calls it as decomposition, which is correct even if it is not full
decomposition as stated in the technote.

> 
> >>This doesn't mean treating filenames as unicode strings is wrong, it
> >>just means that the world would be much better if every filesystem  
> >>had
> >>the same behaviour here. It's kinda like the endian issue, except
> >>there's no simple solution here.
> >
> >Actually, there is, if you care to do something. You can write a  
> >wrapper
> >around readdir(3) that will recodes filenames in Unicode Normal  
> >Forms C.
> >This does not require much knowledge of Git -- what it requires the
> >desire to do something to solve the problem. Of course, this step  
> >alone
> >is not a complete solution (it does not solve case-insensitive issue),
> >but the first step in the right direction...
> 
> I'm not sure how that would solve anything. Sure, it would provide a  
> stable, known encoding for git to compare filenames against, but that  
> would only work if the filename is known to be Unicode, and as it has  
> been pointed out on other filesystems the filename can be whatever  
> encoding the user chooses (which, IMHO, is a flaw).

I believe that Git internally should use only UTF-8 for encoding file
names, commit messages, etc. The problem with some other filesystems
should be addressed separately (by those who work on those systems or
at least have access to them). Regardless interoperability with other
systems, this change alone should solve the issue that was described
in the first message of this thread.

Dmitry
