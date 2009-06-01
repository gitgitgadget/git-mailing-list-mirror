From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [OT] Using object store for other (java) applications
Date: Mon, 1 Jun 2009 07:34:48 -0700
Message-ID: <20090601143448.GF30527@spearce.org>
References: <4A22F39A.9010900@cedarsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Johannes Schneider <mailings@cedarsoft.com>
X-From: git-owner@vger.kernel.org Mon Jun 01 16:34:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MB8bJ-0006Ag-Mg
	for gcvg-git-2@gmane.org; Mon, 01 Jun 2009 16:34:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752157AbZFAOer (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jun 2009 10:34:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751632AbZFAOeq
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Jun 2009 10:34:46 -0400
Received: from george.spearce.org ([209.20.77.23]:39415 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751386AbZFAOeq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jun 2009 10:34:46 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 35535381D1; Mon,  1 Jun 2009 14:34:48 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <4A22F39A.9010900@cedarsoft.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120472>

Johannes Schneider <mailings@cedarsoft.com> wrote:
> what do you think: Is it possible to use the object store (hash based  
> and optimized storage) within another Java application?

Sure.  So long as your storage model fits well onto the Git object
store.  If all you want is a content keyed lookup, Git is possibly
overkill, but you could use it.

> Maybe the JGIT implementation contains anything that could be used?

Yes.  Use the Repository class to access the local repository, use
an ObjectWriter to store blobs and compute their names.  Use the
openBlob method on Repository to obtain an ObjectLoader for a blob
content you previously had stored.

ObjectWriter stores everything as loose files.  Eventually, you may
want to pack them.  Use a PackWriter.  JGit lacks `git prune-packed`
support, but this probably could be coded up in Java and contributed
to JGit with fairly little effort.

If you store data, you probably should connect the blobs into a
tree and into commits, so that the blobs are considered reachable
and can't be cleaned out by `git gc`.

But, if you only ever use your own application against the
repository, and use JGit to manage it, you would never be invoking
GC and thus would never need to worry about it.

-- 
Shawn.
