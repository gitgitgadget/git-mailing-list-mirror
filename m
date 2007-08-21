From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: confused about preserved permissions
Date: Mon, 20 Aug 2007 21:35:41 -0400
Message-ID: <20070821013541.GC27913@spearce.org>
References: <20070820164411.GA15637@piper.oerlikon.madduck.net> <20070820174142.GA7943@glandium.org> <867inqhyuk.fsf@lola.quinscape.zz> <20070820181357.GA8264@glandium.org> <86zm0mgicy.fsf@lola.quinscape.zz> <20070820184829.GA8617@glandium.org> <853ayeos82.fsf@lola.goethe.zz> <20070820205042.GB10173@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: David Kastrup <dak@gnu.org>, git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Tue Aug 21 03:36:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INIfI-0006Eo-6u
	for gcvg-git@gmane.org; Tue, 21 Aug 2007 03:36:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754315AbXHUBfs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Aug 2007 21:35:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753173AbXHUBfs
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Aug 2007 21:35:48 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:47438 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752128AbXHUBfs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2007 21:35:48 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1INIea-0005sR-NN; Mon, 20 Aug 2007 21:35:32 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 03B2920FBAE; Mon, 20 Aug 2007 21:35:42 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20070820205042.GB10173@glandium.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56271>

Mike Hommey <mh@glandium.org> wrote:
> > >> > sprintf "%06o %s\0%s", $mode, $file, pack("H[40]", $sha1)
> 
> The question here was why the permissions are encoded with "%06o" while
> the hash is packed. Anyways, it's just a boring detail.

Because text format is simple and pretty much everyone understands
it, especially when you are talking about UNIX mode/permission
bits in octal, the name is "text", and then oh, wait, those 40
bytes of hex is a lot of data - we'll just make that 20 bytes of
binary instead.  :-)

OK, I don't know if that's really true.  Probably only Linus can
speak to why the tree format is what it is.  Its just how I have
rationalized it myself.

Pack v4 changes the storage of the mode to be in binary, at least
within the packfile, but it does still have to convert it back to the
"%06o" format when computing the SHA-1 of a tree object.  Believe it
or not, pack v4 is being worked on again... so maybe in a future
version of Git the tree modes will take up a tiny bit less space.

I haven't specifically looked at this, but I would also suspect that
within any given tree's zlib dictionary the mode string portion is
given a reasonably short bit sequence.  So its doubtful that the
mode takes up 6 bytes when compressed by zlib, its probably more
likely around 1 byte.  Pack v4's big win here isn't due to the mode,
its due to the filenames being compressed better across trees.

-- 
Shawn.
