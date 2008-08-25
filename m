From: bdowning@lavos.net (Brian Downing)
Subject: Re: [RFC] mtn to git conversion script
Date: Mon, 25 Aug 2008 11:41:53 -0500
Message-ID: <20080825164153.GK31114@lavos.net>
References: <94a0d4530808240218j4bedbe3di99303da9addc93a4@mail.gmail.com> <20080825163530.GJ31114@lavos.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	monotone-devel@nongnu.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 25 18:48:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXfF8-0001nb-Pe
	for gcvg-git-2@gmane.org; Mon, 25 Aug 2008 18:48:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754082AbYHYQrf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Aug 2008 12:47:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754070AbYHYQre
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Aug 2008 12:47:34 -0400
Received: from qmta08.emeryville.ca.mail.comcast.net ([76.96.30.80]:46512 "EHLO
	QMTA08.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753129AbYHYQre (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Aug 2008 12:47:34 -0400
X-Greylist: delayed 336 seconds by postgrey-1.27 at vger.kernel.org; Mon, 25 Aug 2008 12:47:34 EDT
Received: from OMTA06.emeryville.ca.mail.comcast.net ([76.96.30.51])
	by QMTA08.emeryville.ca.mail.comcast.net with comcast
	id 6aby1a00716AWCUA8ghwvg; Mon, 25 Aug 2008 16:41:57 +0000
Received: from mnementh.lavos.net ([98.212.138.194])
	by OMTA06.emeryville.ca.mail.comcast.net with comcast
	id 6ghu1a0014BqYqi8Sghu4N; Mon, 25 Aug 2008 16:41:55 +0000
X-Authority-Analysis: v=1.0 c=1 a=powJzsOIrdUA:10 a=fa_nisRKZzn3U46LdqMA:9
 a=ltB3YH_2cWFKkBToJSGFvPOukIMA:4 a=LY0hPdMaydYA:10
Received: by mnementh.lavos.net (Postfix, from userid 1000)
	id B4EE4309F23; Mon, 25 Aug 2008 11:41:53 -0500 (CDT)
Content-Disposition: inline
In-Reply-To: <20080825163530.GJ31114@lavos.net>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93642>

On Mon, Aug 25, 2008 at 11:35:31AM -0500, Brian Downing wrote:
> Note that for monotone export to go fast you absolutely /must/ avoid the
> get_manifest operation.  In my converter I use the revision information
> directly.  Getting the renames right with this is a little tricky; IIRC,
> the ordering that works is:
> 
> * Rename all renamed files, innermost files first, to temporary names.
> * Delete all deleted files, innermost first.
> * Rename all temporary names to permanent names, outermost first.
> * Add all new/modified files.
> 
> Conveniently, all of the above can be done by directly emitting
> fast-import commands, so you don't have to keep track of trees directly.
> (With one exception, which I'll elaborate on in a different email.)

The exception is one commit in monotone's repository.  There was
actually a commit that did:

    rename '/' '/something'
    add '/other'

Monotone can apparently handle that, but git fast-import cannot, last I
checked.  One would have to "know" what all the files were and recreate
them by hand, which was what fast-import's move/copy commands were
supposed to avoid.

Obviously this use case is not too important to me, as patches have not
been forthcoming to fix this, but I figured I'd mention it in case it's
important to somebody else.

-bcd
