From: Yann Dirson <ydirson@altern.org>
Subject: Re: How do we import patches from non-git sources?
Date: Thu, 24 May 2007 23:22:02 +0200
Message-ID: <20070524212202.GW19253@nan92-1-81-57-214-146.fbx.proxad.net>
References: <1180017010.21181.2.camel@zealous.synapsedev.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Marc Singer <elf@synapse.com>
X-From: git-owner@vger.kernel.org Thu May 24 23:24:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrKmy-0005Bw-Kg
	for gcvg-git@gmane.org; Thu, 24 May 2007 23:24:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751925AbXEXVX5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 May 2007 17:23:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751560AbXEXVX5
	(ORCPT <rfc822;git-outgoing>); Thu, 24 May 2007 17:23:57 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:50540 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751296AbXEXVX4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2007 17:23:56 -0400
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 31EA15A393;
	Thu, 24 May 2007 23:23:51 +0200 (CEST)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id 7FD402022; Thu, 24 May 2007 23:22:02 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1180017010.21181.2.camel@zealous.synapsedev.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48308>

On Thu, May 24, 2007 at 07:30:10AM -0700, Marc Singer wrote:
> Is there a way to import patches that did not come from git?  Remember
> that we'd like to include the functionality of git-am that adds new
> files to the index.

I have written a patch-application tool as part of the (otherwise
stalled) ArcheoloGIT project, clonable from
http://ydirson.free.fr/soft/git/argit.git/.

Side note: it could make sense to finalize this script and integrate
it in git proper.  Opinions ?


Although the command-line interface would probably benefit from an
overhaul, it is fully functionning, notably supporting:

- application of several patches in one row
- application of non-incremental patches - eg. the 2.4.19rmk2 patch
applies to plain 2.4.19, not to 2.4.19rmk1

| $ ../argit/ag-import-patch --help
| Usage: ag-import-patch ( [-v] [-n] [-b BASE|-i] [-N NAME] [-p PARENT]... [-t TAG] PATCH )*
| 
| Import a revision in a GIT history from a patch.
| Part of the ArcheoloGIT toolkit.
| Copyright (c) Yann Dirson, 2005
| Distributed under version 2 of the GNU GPL.

Since it lacks doc, here is it:

-i		- process subsequent paches as incremental (the default)
-b BASE		- process subsequent paches as applying to commit BASE
-N NAME 	- use given NAME instead of patch filename for generating
		  commit message (useful for /dev/stdin import)
-t TAG		- tag after import
-p PARENT	- add PARENT to the parents

eg:

$ git checkout v2.4.19
$ ag-import-patch -b v2.4.19 \
	-p v2.4.18rmk6 -t v2.4.19rmk1 patch-2.4.19rmk1.diff \
	-t v2.4.19rmk2 patch-2.4.19rmk2.diff 

Hope this helps,
-- 
Yann.
