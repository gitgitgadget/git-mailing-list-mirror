From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: [RFC PATCH 6/8] Remove special casing of http, https and ftp
Date: Wed, 2 Dec 2009 07:52:53 +0200
Message-ID: <20091202055253.GB31244@Knoppix>
References: <1259675838-14692-1-git-send-email-ilari.liusvaara@elisanet.fi>
 <1259675838-14692-7-git-send-email-ilari.liusvaara@elisanet.fi>
 <alpine.LNX.2.00.0912011351220.14365@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Dec 02 06:53:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFi9B-0005eb-BX
	for gcvg-git-2@lo.gmane.org; Wed, 02 Dec 2009 06:53:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751590AbZLBFww (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2009 00:52:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751581AbZLBFww
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Dec 2009 00:52:52 -0500
Received: from emh03.mail.saunalahti.fi ([62.142.5.109]:59667 "EHLO
	emh03.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751035AbZLBFwv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2009 00:52:51 -0500
Received: from saunalahti-vams (vs3-12.mail.saunalahti.fi [62.142.5.96])
	by emh03-2.mail.saunalahti.fi (Postfix) with SMTP id 25315EBCB6;
	Wed,  2 Dec 2009 07:52:57 +0200 (EET)
Received: from emh04.mail.saunalahti.fi ([62.142.5.110])
	by vs3-12.mail.saunalahti.fi ([62.142.5.96])
	with SMTP (gateway) id A05DF1E9F6E; Wed, 02 Dec 2009 07:52:56 +0200
Received: from LK-Perkele-V (a88-113-39-59.elisa-laajakaista.fi [88.113.39.59])
	by emh04.mail.saunalahti.fi (Postfix) with ESMTP id 54D2C41BEB;
	Wed,  2 Dec 2009 07:52:54 +0200 (EET)
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.0912011351220.14365@iabervon.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134300>

On Tue, Dec 01, 2009 at 02:15:17PM -0500, Daniel Barkalow wrote:
> On Tue, 1 Dec 2009, Ilari Liusvaara wrote:
> 
> > HTTP, HTTPS and FTP are no longer special to transport code. Also
> > add support for FTPS (curl supports it so it is easy).
> 
> We've been through this extensively, and settled on having a special case 
> for URLs that specify a pure location. That is, the distinction between 
> http and ftp is at the level of how you get to the content for that 
> location, not what you do to interact with it. (Even with webdav or the 
> git-specific smart server support, we use the same detection method on all 
> locations, and ftp simply never has the possibility of having these 
> features detected.)

Currently the only thing about http:// and co git main executable knows is
to pass them to curl remote helper (and print error if compiled with NO_CURL,
possibly causing problems with version desync). Git main executable does
not know any difference between say http:// and ftp:// (the remote helper must
obiviously know the difference, but remote helper is not part of git main
executable).

> It would be fine to add "ftps" to the list of URL schemes that indicate a 
> pure location, except that it's plausible that ftps supports writing, but 
> obviously not by webdav, which is what the push support via curl will 
> attempt, so it's more likely to be confusing than helpful.

remote-curl.c code doesn't seem to do anything stupid with ftps:// that it
wouldn't try with ftp://, and trying to push counts as "stupid" here (and
remember that many FTP servers do allow unencrypted uploads, especially with
authentication and CURL can AFAIK handle that).

-Ilari
