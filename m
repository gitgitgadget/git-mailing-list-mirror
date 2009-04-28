From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: update-server-info logic
Date: Tue, 28 Apr 2009 08:39:11 -0700
Message-ID: <20090428153911.GR23604@spearce.org>
References: <49F720BC.9080604@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mike Gaffney <mr.gaffo@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 28 17:39:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LypP0-0007E8-KP
	for gcvg-git-2@gmane.org; Tue, 28 Apr 2009 17:39:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755954AbZD1PjN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Apr 2009 11:39:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760730AbZD1PjN
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Apr 2009 11:39:13 -0400
Received: from george.spearce.org ([209.20.77.23]:45339 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756690AbZD1PjM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Apr 2009 11:39:12 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id B2A3F38215; Tue, 28 Apr 2009 15:39:11 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <49F720BC.9080604@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117793>

Mike Gaffney <mr.gaffo@gmail.com> wrote:
>    I was wondering if someone could reply with a quick rundown of the  
> update-server-info logic. I'm looking at implementing it in JGit and  
> wanted to make sure I had it correct.

Its two things:

* rewrite $GIT_DIR/info/refs to be a complete catalog of all refs.
  IIRC this format is one ref per line, sorted by the full ref name,
  with the line format being "$SHA1\t$NAME\n".

  Most of this is already implemented in RefWriter.
  See writeInfoRefs().

* rewrite $GIT_DIR/objects/info/packs to be a complete catalog of the
  packs in $GIT_DIR/objects/pack.  The format is one pack per line,
  written as "P pack-$HASH.pack\n".  A final blank line is written
  on the end of the file, for I don't know why.  Its a good idea to
  sort the lines by the last modified date of the pack, descending,
  as clients will evaulate the file in order when searching for a
  missing object, and the usually need the more recent pack first.

  Most of this is already implemented in WalkRemoteObjectDatabase.
  See writeInfoPacks().

-- 
Shawn.
