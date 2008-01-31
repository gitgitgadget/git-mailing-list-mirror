From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [RFC] Authenticate push via PGP signature, not SSH
Date: Thu, 31 Jan 2008 00:43:05 -0500
Message-ID: <20080131054304.GY24004@spearce.org>
References: <479D5611.4010205@vilain.net> <20080128081258.GE24004@spearce.org> <479E5021.7010404@vilain.net> <20080129041000.GK24004@spearce.org> <20080129190845.GC30093@artemis.madism.org> <20080130042201.GO24004@spearce.org> <47A02EA8.50507@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Pierre Habouzit <madcoder@debian.org>, Sam Vilain <sam@vilain.net>,
	git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Jan 31 06:43:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JKSDA-0004W3-Q8
	for gcvg-git-2@gmane.org; Thu, 31 Jan 2008 06:43:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753295AbYAaFnL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jan 2008 00:43:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753239AbYAaFnK
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jan 2008 00:43:10 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:53030 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753062AbYAaFnJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jan 2008 00:43:09 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JKSCZ-0004II-3b; Thu, 31 Jan 2008 00:43:07 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id B178C20FBAE; Thu, 31 Jan 2008 00:43:05 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <47A02EA8.50507@viscovery.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72102>

Johannes Sixt <j.sixt@viscovery.net> wrote:
> Shawn O. Pearce schrieb:
> > I'm currently finishing a side-band-64k protocol extension to the
> > send-pack/receive-pack pair.  My next task after I flush those
> > RFC patches out to the list tonight will be to prototype at least
> > some of the auth1 extension I described.
> 
> I propose to make the syntax of the extension
> 
> server capability:  auth=<list of hash methods>:<challenge>
> client response:    auth=<chosen hash method>
> 
> where <challenge> is a random sequence of non-blank ASCII text, not
> necessarily of a fixed length, but perhaps of a minimum length.
> 
> Then we can extend the list of hash algorithms (that are used for
> authentication purposes) if people think that SHA1 is not secure enough:
> 
>     auth=SHA1,SHA256:random-stuff-goes-here
> 
> I'm not a security expert, so take this with a grain of salt.

I'm not certain this is worth the extra complexity.

One reason I proposed "auth-1" as the extension name is so we could
introduce an "auth-2" and make changes in the future if we need to.

But I think there's little value in this authentication hash being
anything other than SHA-1.  Remember that the data itself in the
packfile following the authentication is only protected by SHA-1.
If SHA-1 is considered too weak to protect the ref update commands
then its likely also too weak to protect the file content following
behind those same commands.

Getting stronger authentication here than SHA-1 would probably
require changing the commit object name hash to something stronger
than SHA-1, and the tree object name hash, etc.  Remember that
signed tags are only using the SHA-1 of the commit and that's only
got the SHA-1 of the tree... ;-)

-- 
Shawn.
