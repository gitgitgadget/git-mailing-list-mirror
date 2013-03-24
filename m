From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: propagating repo corruption across clone
Date: Sun, 24 Mar 2013 21:16:14 +0200
Message-ID: <20130324191614.GA15275@LK-Perkele-VII>
References: <20130324183133.GA11200@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Mar 24 20:24:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJqWz-000688-Hq
	for gcvg-git-2@plane.gmane.org; Sun, 24 Mar 2013 20:24:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754603Ab3CXTYG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Mar 2013 15:24:06 -0400
Received: from emh04.mail.saunalahti.fi ([62.142.5.110]:47327 "EHLO
	emh04.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754583Ab3CXTYA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Mar 2013 15:24:00 -0400
X-Greylist: delayed 463 seconds by postgrey-1.27 at vger.kernel.org; Sun, 24 Mar 2013 15:24:00 EDT
Received: from saunalahti-vams (vs3-11.mail.saunalahti.fi [62.142.5.95])
	by emh04.mail.saunalahti.fi (Postfix) with SMTP id BC8D91A25D8;
	Sun, 24 Mar 2013 21:16:15 +0200 (EET)
Received: from emh03.mail.saunalahti.fi ([62.142.5.109])
	by vs3-11.mail.saunalahti.fi ([62.142.5.95])
	with SMTP (gateway) id A0419AB02B0; Sun, 24 Mar 2013 21:16:15 +0200
Received: from LK-Perkele-VII (a88-112-44-140.elisa-laajakaista.fi [88.112.44.140])
	by emh03.mail.saunalahti.fi (Postfix) with ESMTP id 82D84188781;
	Sun, 24 Mar 2013 21:16:15 +0200 (EET)
Content-Disposition: inline
In-Reply-To: <20130324183133.GA11200@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218967>

On Sun, Mar 24, 2013 at 02:31:33PM -0400, Jeff King wrote:
> 
> Fscking the incoming objects does work, but of course it comes at a cost
> in the normal case (for linux-2.6, I measured an increase in CPU time
> with "index-pack --strict" from ~2.5 minutes to ~4 minutes). And I think
> it is probably overkill for finding corruption; index-pack already
> recognizes bit corruption inside an object, and
> check_everything_connected can detect object graph problems much more
> cheaply.

AFAIK, standard checks index-pack has to do + checking that the object
graph has no broken links (and every ref points to something valid) will
catch everything except:

- SHA-1 collisions between corrupt objects and clean ones.
- Corrupted refs (that still point to something valid).
- "Born-corrupted" objects.

> One thing I didn't check is bit corruption inside a packed object that
> still correctly zlib inflates. check_everything_connected will end up
> reading all of the commits and trees (to walk them), but not the blobs.

Checking that everything is connected will (modulo SHA-1 collisions) save
you there, at least if packv3 is used as transport stream.

-Ilari
