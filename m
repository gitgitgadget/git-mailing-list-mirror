From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] allow OFS_DELTA objects during a push
Date: Mon, 4 May 2009 15:11:29 -0700
Message-ID: <20090504221129.GF23604@spearce.org>
References: <20090415182754.GF23644@curie-int> <alpine.LFD.2.00.0904151443030.6741@xanadu.home> <7vy6tj109a.fsf@gitster.siamese.dyndns.org> <alpine.LFD.2.00.0905011616130.6741@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	"Robin H. Johnson" <robbat2@gentoo.org>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue May 05 00:11:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M16Nu-0007Xh-Qt
	for gcvg-git-2@gmane.org; Tue, 05 May 2009 00:11:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754074AbZEDWLa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 May 2009 18:11:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752640AbZEDWLa
	(ORCPT <rfc822;git-outgoing>); Mon, 4 May 2009 18:11:30 -0400
Received: from george.spearce.org ([209.20.77.23]:50667 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752104AbZEDWL3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 May 2009 18:11:29 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id E368838195; Mon,  4 May 2009 22:11:29 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0905011616130.6741@xanadu.home>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118267>

Nicolas Pitre <nico@cam.org> wrote:
> The fetching of OFS_DELTA objects has been negotiated between both peers 
> since git version 1.4.4.  However, this was missing from the push side 
> where every OFS_DELTA objects were always converted to REF_DELTA objects 
> causing an increase in transferred data.

Folks, this may have broken git push for me.

I'm trying to debug it right now, but something in next between
46488d2 and 03e1664 has caused "git push" to not create a pack
file, sending the remote peer 0 objects, when really we should have
transmitted objects, e.g. in the case I just looked at, we should
have sent 11.

FWIW, I'm currently blaming this change as its the only thing to
touch builtin-send-pack.c in that commit range.  :-)

/me goes off to debug this further...
 
>  builtin-receive-pack.c |   22 +++++++++++++++-------
>  builtin-send-pack.c    |    8 +++++++-
>  send-pack.h            |    1 +
>  3 files changed, 23 insertions(+), 8 deletions(-)

-- 
Shawn.
