From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [RFC/PATCHv7 22/22] fast-import: Proper notes tree
	manipulation using the notes API
Date: Fri, 9 Oct 2009 07:25:24 -0700
Message-ID: <20091009142524.GQ9261@spearce.org>
References: <1255083738-23263-1-git-send-email-johan@herland.net> <1255083738-23263-24-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, Johannes.Schindelin@gmx.de,
	trast@student.ethz.ch, tavestbo@trolltech.com,
	git@drmicha.warpmail.net, chriscool@tuxfamily.org, sam@vilain.net
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Fri Oct 09 16:26:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MwGQC-00083U-W0
	for gcvg-git-2@lo.gmane.org; Fri, 09 Oct 2009 16:26:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932451AbZJIO0D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Oct 2009 10:26:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932230AbZJIO0D
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Oct 2009 10:26:03 -0400
Received: from george.spearce.org ([209.20.77.23]:56446 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757072AbZJIO0B (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Oct 2009 10:26:01 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id F2ADA381FE; Fri,  9 Oct 2009 14:25:24 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1255083738-23263-24-git-send-email-johan@herland.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129801>

Johan Herland <johan@herland.net> wrote:
> This patch teaches 'git fast-import' to use the notes API to organize
> the manipulation of note objects through a fast-import stream. Note
> objects are added to the notes tree through the 'N' command, and when
> we're about to store the tree object for the current commit, we walk
> through the notes tree and insert all the notes into the stored tree.

Some high level comments about this patch:

- You don't destroy the struct notes_tree during unload_one_branch()
  which means notes trees stay in memory even if the branch table
  is overflowing.  I think you should discard the notes tree when
  a branch unloads, and recreate it when the branch loads.

- Destroying and adding back all notes is OK with ~20k notes, but
  doing that with ~150k-~800k notes is going to slow down a lot,
  losing the "fast" part.

-- 
Shawn.
