From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Request for detailed documentation of git pack protocol
Date: Wed, 3 Jun 2009 13:24:29 -0700
Message-ID: <20090603202429.GO3355@spearce.org>
References: <200905122329.15379.jnareb@gmail.com> <200906031851.12160.jnareb@gmail.com> <20090603165613.GJ3355@spearce.org> <200906032220.00238.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Scott Chacon <schacon@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 03 22:24:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBx0m-0006rN-JW
	for gcvg-git-2@gmane.org; Wed, 03 Jun 2009 22:24:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753053AbZFCUY2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2009 16:24:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752540AbZFCUY1
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jun 2009 16:24:27 -0400
Received: from george.spearce.org ([209.20.77.23]:50703 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750954AbZFCUY0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2009 16:24:26 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 0F5CC381D1; Wed,  3 Jun 2009 20:24:29 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <200906032220.00238.jnareb@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120638>

Jakub Narebski <jnareb@gmail.com> wrote:
> 
> >>> Oh, and send-pack/receive-pack protocol now has ".have" refs [...]
> 
> So the output (for fetch or clone) would look like this for repository
> with alternates (shared object database):

No.  fetch/clone (aka fetch-pack/upload-pack protocl) does not use
the .have feature.
 
> Does it matter for fetch, or is it important only for pushing?

Because yea, it only matters for pushing.  Actually, in the case of
fetch, we shouldn't advertise what our alternate has, the client
should just fetch from the alternate.

In push it matters because the client wants to know what the remote
has, so it can trim the pack down to only the new objects, to reduce
transfer time.
 
> BTW. do "include-tag" capability MUST NOT (REQUIRED) be send if there
> are not tags (tag objects?), or just SHOULD NOT (RECOMMENDED), or even
> MAY NOT (OPTIONAL).  GitHub server doesn't send it if there are no 
> tags...

Clients MAY always send include-tag, hardcoding it into a request.
The decision for a client to request include-tag only has to do
with the client's desires for tag data, whether or not a server
had advertised objects in the refs/tags/* namespace.

Clients SHOULD NOT send include-tag if remote.name.tagopt was set
to --no-tags, as the client doesn't want tag data.

Servers MUST accept include-tag without error or warning, even if the
server does not understand or support the option.

Servers SHOULD pack the tags if their referrant is packed and the
client has requested include-tag.

Clients MUST be prepared for the case where a server has ignored
include-tag and has not actually sent tags in the pack.  In such
cases the client SHOULD issue a subsequent fetch to acquire the
tags that include-tag would have otherwise given the client.

-- 
Shawn.
