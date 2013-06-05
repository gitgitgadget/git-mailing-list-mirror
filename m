From: Jeff King <peff@peff.net>
Subject: Re: deletion of branch seems to modify tag as well?
Date: Wed, 5 Jun 2013 11:51:24 -0400
Message-ID: <20130605155124.GB8664@sigill.intra.peff.net>
References: <58EAA08AF8232344ADDB2E31D4996BFD39F271BA@SMRPEXCHIDAG2.prod.ad.merc.chicago.cme.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "Lyons, Roy" <Roy.Lyons@cmegroup.com>
X-From: git-owner@vger.kernel.org Wed Jun 05 17:51:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UkFzn-0006QZ-Jv
	for gcvg-git-2@plane.gmane.org; Wed, 05 Jun 2013 17:51:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756376Ab3FEPv1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Jun 2013 11:51:27 -0400
Received: from cloud.peff.net ([50.56.180.127]:51628 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755311Ab3FEPv0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Jun 2013 11:51:26 -0400
Received: (qmail 29689 invoked by uid 102); 5 Jun 2013 15:52:12 -0000
Received: from c-71-62-74-146.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.62.74.146)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 05 Jun 2013 10:52:12 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 05 Jun 2013 11:51:24 -0400
Content-Disposition: inline
In-Reply-To: <58EAA08AF8232344ADDB2E31D4996BFD39F271BA@SMRPEXCHIDAG2.prod.ad.merc.chicago.cme.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226454>

On Wed, Jun 05, 2013 at 03:26:18PM +0000, Lyons, Roy wrote:

> $ git push origin :ABRANCHNAME
> remote: Firing Pre - receive hook
> remote:
> remote:
> remote: Firing Post receive hook
> remote:
> remote: Branch is ABRANCHNAME -- not creating Trigger file since this is not _int branch
> remote: error: Trying to write ref refs/tags/ABRANCHNAME!SN-BL-20130605_100513_04363 with nonexistent object 0000000000000000000000000000000000000000
> remote: fatal: refs/tags/ABRANCHNAME!SN-BL-20130605_100513_04363: cannot update the ref
> To ssh://git@ourgitserver/repositoryname.git
> - [deleted] ABRANCHNAME
> 
> I would not expect this behavior.  Is git attempting to modify the
> tags associated to the HEAD commit on the branch in addition to the
> branch?   If so, I would like to consider this a bug report...

I do not think git is doing anything of the sort. The output you see
above comes from custom hooks on the server. We cannot say for certain
without seeing the hook's code, but it looks like the post-receive hook
is trying to create a tag to point to the tip of every push, but whoever
wrote the hook did not take into account branch deletions (and the fact
that you cannot create a tag pointing at a deletion).

-Peff
