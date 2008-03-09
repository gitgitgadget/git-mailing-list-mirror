From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: [jgit] index v2 pull request
Date: Mon, 10 Mar 2008 00:51:55 +0100
Message-ID: <200803100051.55367.robin.rosenberg@dewire.com>
References: <20080308025027.GZ8410@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Dave Watson <dwatson@mimvista.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Mar 10 00:53:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYVKD-00022q-Ac
	for gcvg-git-2@gmane.org; Mon, 10 Mar 2008 00:53:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752727AbYCIXv7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Mar 2008 19:51:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752636AbYCIXv7
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Mar 2008 19:51:59 -0400
Received: from [83.140.172.130] ([83.140.172.130]:28765 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751113AbYCIXv6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Mar 2008 19:51:58 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id B6567802671;
	Mon, 10 Mar 2008 00:51:56 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fX+mWc+vHya1; Mon, 10 Mar 2008 00:51:56 +0100 (CET)
Received: from [10.9.0.7] (unknown [10.9.0.7])
	by dewire.com (Postfix) with ESMTP id 05EBF802655;
	Mon, 10 Mar 2008 00:51:55 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <20080308025027.GZ8410@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76686>

Den Saturday 08 March 2008 03.50.27 skrev Shawn O. Pearce:
> So I've started to hack on jgit again, to build out more of the lower
> level library.
Welcome back Shawn!

> This particular series adds support for pack file index v2, which
> Nico added to C Git several months ago and is slated to become the
> default pack index file format in a future release of Git, due to
> its increased error checking during delta reuse.
This i great news. I've been thinking about it, praying that you'd come
and do the work. :)

> We now actually use the following .git/config options to control
> how the window cache limits work:
>
>   core.packedGitWindowSize
>   core.packedGitLimit
>   core.deltaBaseCacheLimit
>   core.packedGitMMAP

Will the net effect, in practice, be the same on Jgit as on C Git?

>   repo.or.cz:/srv/git/egit/spearce.git master
Something missing in the formatting?

> Shawn O. Pearce (41):
>       Make the absolute path of a WindowedFile available to callers
>       Include the pack index file name when reporting a bad header
>       Report pack file open failures to the console
>       Refactor index reading code from PackFile to PackIndex
>       Rename PackIndex.readIndexHeader to loadVersion1
>       Read pack index files using FileInputStream and not WindowedFile
>       Don't bother checking the index file length after reading it
>       Move index:pack object count checking into PackFile class
>       Refactor PackIndex version 1 handling code into PackIndexV1
>       Fully document the PackIndex API
>       Hoist readFully and decodeUInt32 up from PackIndexV1 to PackIndex
>       Refactor PackIndex.readFully to support reading into the middle
>       Read the pack index header to perform automatic version detection
>       Add complete reading support for pack index v2
Yum, yum. My 15 minute review so far likes it.
>       Stop creating "new format" loose objects as C Git no longer likes
> them Refactor RepositoryConfig to be stacked many levels deep
And there goes the unit test for reading them...

>       Don't make unit tests depend upon compressed file lengths
>       Corrected name of the method that reloads the packed-refs data
>       Cleanup misspelling in Javadoc of Repository class
>       Extract StGitPatch from Repository to its own top-level type
I'm considering dropping stacked git support. We should have much
more of it and I don't use it myself anymore to what support we have
gets very little testing.

>       Refactor RepositoryState into its own top-level type
\ No newline at end of file

>       Refactor PackFile construction to take the idxFile path from scan
>       Shuffle the length of a WindowedFile down into its provider
>       Defer opening pack files until we actually need object data
>       Use Java 5 bit twiddling APIs rather than hand-rolling bit counting
I'm surprised *you* didn't know about them bitcounting algorithm java uses 
before. It's pretty common.

>       Support reading config file integers with k/m/g suffixes
>       Honor core.packedGitWindowSize, packedGitLimit, packedGitMMAP config
>       Enable easy access to the user's ~/.gitconfig
>       Use a single WindowCache for the entire Eclipse workspace
>       Modify the WindowedFile API to pass around a WindowCursor during reads 
>       Change ByteWindow implementations to hold data by SoftReferences 
>       Refactor WindowedFile/WindowCache so all windows are a uniform size
>       Simplify WindowCache and WindowedFile internal APIs to be private Use 
a proper ReferenceQueue to avoid duplpicate window entries
>       New  RepositoryConfig getInt,getBoolean helper methods with no 
subsection Change delta packed object loaders to use a PackedObjectLoader for 
base Implement core.deltaBaseCacheLimit to improve unpacking performance
>       Remove unnecessary bitwise AND masks in readTree 
Good catch
>       Precount the number of tree entries during readTree
this one too
>       Change the ObjectLoader.getType method to return int
>       Fix ArrayIndexOutOfBoundsException in WindowCache

Very good work (as always) Shawn. I've only read the code so far. I'll do some 
testing too before pushing. Do you have any unit tests for the v2 pack format 
(config reading too for that matter)?

-- robin
