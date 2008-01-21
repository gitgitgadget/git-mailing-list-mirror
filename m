From: Theodore Tso <tytso@MIT.EDU>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Mon, 21 Jan 2008 14:57:03 -0500
Message-ID: <20080121195703.GE29792@mit.edu>
References: <478F99E7.1050503@web.de> <alpine.LFD.1.00.0801171017460.14959@woody.linux-foundation.org> <F666FFD2-9777-47EA-BEF4-C78906CA8901@simplicidade.org> <alpine.LFD.1.00.0801171100330.14959@woody.linux-foundation.org> <Pine.LNX.4.64.0801181114430.817@ds9.cixit.se> <alpine.LFD.1.00.0801180909000.2957@woody.linux-foundation.org> <Pine.LNX.4.64.0801211509490.17095!@ds9.cixit.se> <440E4426-BFB5-4836-93DF-05C99EF204E6@sb.org> <alpine.LFD.1.00.0801210934400.2957@woody.linux-foundation.org> <C6C0E6A1-053B-48CE-90B3-8FFB44061C3B@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Karlsson <peter@softwolves.pp.se>,
	Mark Junker <mjscod@web.de>,
	Pedro Melo <melo@simplicidade.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Mon Jan 21 20:59:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JH2nO-0003ht-2k
	for gcvg-git-2@gmane.org; Mon, 21 Jan 2008 20:59:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752279AbYAUT6c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2008 14:58:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752470AbYAUT6b
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 14:58:31 -0500
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:44179 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752279AbYAUT6a (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Jan 2008 14:58:30 -0500
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id m0LJvFQS008742;
	Mon, 21 Jan 2008 14:57:15 -0500 (EST)
Received: from closure.thunk.org (c-76-19-244-124.hsd1.ma.comcast.net [76.19.244.124])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id m0LJv4q5017193
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 21 Jan 2008 14:57:04 -0500 (EST)
Received: from tytso by closure.thunk.org with local (Exim 4.67)
	(envelope-from <tytso@mit.edu>)
	id 1JH2lT-0007cJ-OJ; Mon, 21 Jan 2008 14:57:03 -0500
Content-Disposition: inline
In-Reply-To: <C6C0E6A1-053B-48CE-90B3-8FFB44061C3B@sb.org>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71323>

On Mon, Jan 21, 2008 at 02:05:51PM -0500, Kevin Ballard wrote:
> You're right, but it doesn't have to treat it as a binary stream at the 
> level I care about. I mean, no matter what you do at some level the string 
> is evaluated as a binary stream. For our purposes, just redefine the 
> hashing algorithm to hash all equivalent strings the same, and you can 
> implement that by using SHA1 on a particular encoding of the string.

That's horribly broken, for a couple of reasons.  First of all,
changing the hash algorithm breaks compatibility with existing
repositories; sure, you can try to guess what will least likely break
existing repository (which won't be the native MacOSX normalization
algorithm, since it's more likely the combined character will likely
be used on other environments), but there's still no guarantee there
aren't filenames that use some other form of byte-string for the
filename.

Secondly, the hash algorithm would not be stable.  Unicode is not
static, and new characters can get added that may be composable, and
thus would be normalized differently.  This is one of the reasons why
Unicode is so horribly broken as a standard.  It was originally
created by representatives from the printing world that were horribly
clueless about what was needed with respect to canonicalization
representation, so they compromised allowed both forms, not realizing
what a massive f*ckup this would cause later on.  So people have over
the years piled kludges on top of kludges in order to make Unicode
"work".  

So we can't blame all of the craziness on the MacOS designers,
although they have seen to have been very creative about how to take a
bad situation and make it worse....

					- Ted
