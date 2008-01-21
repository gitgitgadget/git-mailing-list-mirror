From: Theodore Tso <tytso@MIT.EDU>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Mon, 21 Jan 2008 16:18:02 -0500
Message-ID: <20080121211802.GH29792@mit.edu>
References: <Pine.LNX.4.64.0801211509490.17095!@ds9.cixit.se> <440E4426-BFB5-4836-93DF-05C99EF204E6@sb.org> <alpine.LFD.1.00.0801210934400.2957@woody.linux-foundation.org> <C6C0E6A1-053B-48CE-90B3-8FFB44061C3B@sb.org> <20080121195703.GE29792@mit.edu> <998717B0-0165-4383-AAB8-33BD2A49954E@sb.org> <20080121201530.GF29792@mit.edu> <8F85366A-C990-47B1-BF60-936185B9E438@sb.org> <20080121204614.GG29792@mit.edu> <6E303071-82A4-4D69-AA0C-EC41168B9AFE@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Karlsson <peter@softwolves.pp.se>,
	Mark Junker <mjscod@web.de>,
	Pedro Melo <melo@simplicidade.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Mon Jan 21 22:19:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JH439-0007em-3z
	for gcvg-git-2@gmane.org; Mon, 21 Jan 2008 22:19:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758524AbYAUVSm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2008 16:18:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759661AbYAUVSl
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 16:18:41 -0500
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:46855 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759613AbYAUVSk (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Jan 2008 16:18:40 -0500
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id m0LLI4v4027668;
	Mon, 21 Jan 2008 16:18:04 -0500 (EST)
Received: from closure.thunk.org (c-76-19-244-124.hsd1.ma.comcast.net [76.19.244.124])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id m0LLI2oA000437
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 21 Jan 2008 16:18:03 -0500 (EST)
Received: from tytso by closure.thunk.org with local (Exim 4.67)
	(envelope-from <tytso@mit.edu>)
	id 1JH41q-00083E-Go; Mon, 21 Jan 2008 16:18:02 -0500
Content-Disposition: inline
In-Reply-To: <6E303071-82A4-4D69-AA0C-EC41168B9AFE@sb.org>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71342>

On Mon, Jan 21, 2008 at 03:58:03PM -0500, Kevin Ballard wrote:
> You're making the huge assumption that the HFS+ normalization algorithms 
> will change. As the technote states:
>
> "Platform algorithms tend to evolve with the Unicode standard. The HFS Plus 
> algorithms cannot evolve because such evolution would invalidate existing 
> HFS Plus volumes."

Great, so even worse.  Does the tech note then specify exactly what
version of Unicode HFS+ is using to do its "normalization"?  Or
exactly what characters it will normalize?  After all, Unicode has
added all sorts of characters since 1998, and I'm sure some of them
were combining characters.

And you *really* want to continue argue that a sane thing for a
cross-platform system to do is to pervert its hash algorithm to take
into account *one* particular OS that happened to freeze a
normalization algorithm at some arbitrary point in time, approximately
nine years ago?  Talk about the tail wagging the dog!!  Especially
when you can't even justify why it was done nine years ago!

> It must have bought somebody something, or they never would have done it.

Your faith in the HFS+ designers is touching.

> I have no idea why HFS+ stores filenames in a normalized form, and further 
> I am smart enough to know that speculating is completely pointless. I 
> assume the authors had a good reason (which should be a safe assumption, 
> filesystem authors are a smart bunch). The reason may not be valid anymore, 
> but if it was valid back in 1998, then I can accept it without complaining.

Well, I *AM* a filesystem designer (ext2/ext3/ext4), and well before
1998, I knew that trying to do anything with Unicode normalization was
a fool's errand.  So if you're going to blindly trust filesystme
designers (not something I would recommend, actually :-), trust me.
What HFS+ is doing is dumb, dumb, dumb.

And even if *you* can accept it, why should the git designers pervert
any core part of git's design to support this behaviour?  Especially
if it's legacy behaviour which will hopefully be going away, say when
MacOS adopts ZFS --- there's an opportunity for them to start afresh,
and not make the same mistakes they made nine years ago!

So why don't you suggest some kind of sane fix in the Mac specific
code that doesn't impact any core part of git, such as its hash
algorithm?  It would be far more productive than trying to defend a
bad design decision made nine years ago....   :-}

					- Ted
