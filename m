From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] fast-import: Fix crash when referencing already existing objects
Date: Wed, 23 May 2007 23:44:15 -0400
Message-ID: <20070524034415.GF28023@spearce.org>
References: <200705232301.49667.simon@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Simon Hausmann <simon@lst.de>
X-From: git-owner@vger.kernel.org Thu May 24 05:44:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hr4FU-0004E9-2H
	for gcvg-git@gmane.org; Thu, 24 May 2007 05:44:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758354AbXEXDoU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 May 2007 23:44:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758927AbXEXDoU
	(ORCPT <rfc822;git-outgoing>); Wed, 23 May 2007 23:44:20 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:54318 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758354AbXEXDoT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 May 2007 23:44:19 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1Hr4FA-0003Gy-Hj; Wed, 23 May 2007 23:44:04 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id A05FE20FBAE; Wed, 23 May 2007 23:44:15 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <200705232301.49667.simon@lst.de>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48215>

Simon Hausmann <simon@lst.de> wrote:
> Commit a5c1780a0355a71b9fb70f1f1977ce726ee5b8d8 sets the pack_id of existing
> objects to MAX_PACK_ID. When the same object is referenced later again it is
> found in the local object hash. With such a pack_id fast-import should not try
> to locate that object in the newly created pack(s).

Thanks, that was a _really_ nasty bug.  :-(

Turns out there's more cases.  Such as if we reload a mark table of
commits (--import-marks) and then try to create a branch from them.
The existing commit will also have a pack_id of MAX_PACK_ID and
we'll go right into the same corruption you saw and fixed here.

I will be pushing your two patches and my additional fixup to
my maint branch tonight.

-- 
Shawn.
