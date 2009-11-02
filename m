From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Update packfile transfer protocol documentation
Date: Mon, 2 Nov 2009 15:57:07 -0800
Message-ID: <20091102235707.GV10505@spearce.org>
References: <d411cc4a0911011518q15a8267bn642e6937be8c9ab1@mail.gmail.com> <7vzl74trmc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Scott Chacon <schacon@gmail.com>, git list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 03 00:57:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N56lv-0000Ok-JT
	for gcvg-git-2@lo.gmane.org; Tue, 03 Nov 2009 00:57:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757320AbZKBX5E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Nov 2009 18:57:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757318AbZKBX5D
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Nov 2009 18:57:03 -0500
Received: from george.spearce.org ([209.20.77.23]:34315 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757160AbZKBX5D (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Nov 2009 18:57:03 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 72FD1381FE; Mon,  2 Nov 2009 23:57:07 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7vzl74trmc.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131937>

Junio C Hamano <gitster@pobox.com> wrote:
> Scott Chacon <schacon@gmail.com> writes:
> > +
> > +A pack-file MUST be sent if either create or update command is used.
> 
> Easier to read if MUST is followed by "_even_ if", like so:
> 
>     ... MUST be sent when a create or update command is used, even if the
>     server already has all the necessary objects.
> 
> Shouldn't we say "the client MUST NOT make reference update request if
> everything is up to date" which would imply that in practice there is no
> reason to send an empty pack data?

Create a new branch to point at an existing object.  Branch creation
causes a pack to be expected, but if you are creating a new branch
that points at an existing object there is nothing to pack.  E.g.:

  git remote add -f A user@host:proj.git
  git push A A/master:refs/heads/new-branch

causes a 0 object pack file to be sent, assuming the remote project's
master branch has not changed in between the two commands.
 
> > +  pack-file         = "PACK" 24*(OCTET)
> 
> Curious---where does this 24 come from?

Hmmph.  Its wrong actually.  I was trying to write the minimum
number of bytes that make up a pack file, which is actually 28.
(12 in the header minus 4 as "PACK" was already spelled out, plus
20 in the footer for the SHA-1).
 
-- 
Shawn.
