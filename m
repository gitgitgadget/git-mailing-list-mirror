From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git on Cygwin: Not a valid object name HEAD
Date: Tue, 7 Aug 2007 10:36:16 -0400
Message-ID: <20070807143616.GO9527@spearce.org>
References: <f99cem$4a4$1@sea.gmane.org> <Pine.LNX.4.64.0708071257350.14781@racer.site> <f99nm6$9vi$1@sea.gmane.org> <f99rei$ou$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 07 16:36:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIQAa-0002I8-Gr
	for gcvg-git@gmane.org; Tue, 07 Aug 2007 16:36:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756616AbXHGOgU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Aug 2007 10:36:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755739AbXHGOgU
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Aug 2007 10:36:20 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:50948 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755293AbXHGOgT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Aug 2007 10:36:19 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1IIQAO-0004y3-Im; Tue, 07 Aug 2007 10:36:12 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 6E25220FBAE; Tue,  7 Aug 2007 10:36:16 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <f99rei$ou$1@sea.gmane.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55261>

Sebastian Schuberth <sschuberth@gmail.com> wrote:
> I wonder if this happens because git never passes "b" to any fopen() 
> calls (as there is no such thing like opening a file in binary mode 
> under Linux, because files are always opened "binary"). If fopen() 
> safely ignores the "b" option under Linux, I think it should always be 
> specified so Cygwin's git will work with text mode mounts when compiled 
> from the original git sources.

Actually we never use fopen() when we care about the data (and we
always care about object data and working tree data).  We always
use open(2) and use system call IO directly to perform all reads
and writes.  fopen() is only used on trivial things, like say the
.git/config file.

Now on a normal UNIX system open(2) *always* by definition does
binary IO.  But Cygwin's text mount option tries to make UNIX
programs DOS-friendly by making all files treated as text, even if
it supposedly doing binary IO via open(2).

I think its a mis-feature of Cygwin.  Git has no way (that I know
of) to defend itself from this, other than to tell the user to make
sure they only store a Git repository in a location that is mounted
with the binary flag.

-- 
Shawn.
