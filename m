From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: [RFC 0/2] Git-over-TLS (gits://) client side support
Date: Wed, 13 Jan 2010 22:00:27 +0200
Message-ID: <20100113200027.GA8207@Knoppix>
References: <1263388786-6880-1-git-send-email-ilari.liusvaara@elisanet.fi>
 <fcaeb9bf1001130539p2971caavd101d46de9269769@mail.gmail.com>
 <20100113135753.GA7095@Knoppix>
 <32541b131001131111u6bb0de01qe6cc1ecde5119084@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 13 21:00:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NV9OY-000068-3Q
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jan 2010 21:00:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755602Ab0AMUAi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2010 15:00:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755474Ab0AMUAi
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jan 2010 15:00:38 -0500
Received: from emh05.mail.saunalahti.fi ([62.142.5.111]:54678 "EHLO
	emh05.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755428Ab0AMUAh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2010 15:00:37 -0500
Received: from saunalahti-vams (vs3-11.mail.saunalahti.fi [62.142.5.95])
	by emh05-2.mail.saunalahti.fi (Postfix) with SMTP id C08218BDB7;
	Wed, 13 Jan 2010 22:00:31 +0200 (EET)
Received: from emh06.mail.saunalahti.fi ([62.142.5.116])
	by vs3-11.mail.saunalahti.fi ([62.142.5.95])
	with SMTP (gateway) id A023A7BD4B4; Wed, 13 Jan 2010 22:00:31 +0200
Received: from LK-Perkele-V (a88-113-39-59.elisa-laajakaista.fi [88.113.39.59])
	by emh06.mail.saunalahti.fi (Postfix) with ESMTP id 9A8CDE51C7;
	Wed, 13 Jan 2010 22:00:28 +0200 (EET)
Content-Disposition: inline
In-Reply-To: <32541b131001131111u6bb0de01qe6cc1ecde5119084@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136869>

On Wed, Jan 13, 2010 at 02:11:14PM -0500, Avery Pennarun wrote:
> On Wed, Jan 13, 2010 at 8:57 AM, Ilari Liusvaara
> <ilari.liusvaara@elisanet.fi> wrote:
> It sounds to me like you're doing two different things with this patch series:
> 
> 1) Adding additional authorization features (assuming the user is
> already authenticated) to git-daemon
>
> 2) Creating a TLS encryption layer with authentication support.
>
> #1 sounds like it could be its own patch series even if you don't have
> #2, and could be reviewed separately.

This series (really only one patch, only split because its large) only
contains client parts, not server ones (not seperately or via patching
git-daemon).

And besides the daemon for gits:// was written from libraries up.

> #2 sounds like it is not even git-specific.  You've decided that ssh
> and stunnel don't fit your needs; what makes your solution not a
> general TLS-based authentication layer, like stunnel but with
> different certificate management? 

Stunnel seems mainly "tunnel stuff using SSL/TLS" type thing and any
support for auth in it seems afterthought. At least that's what I got
from reading the manuals for it.

> If it's really a general layer,
> maybe it should be distributed separately and git could be taught how
> to use it *or* stunnel (or ssh, as it does now) for its transport
> encryption/authentication.

The way serverside works is quite different from git-daemon. On client
side there are also some virtually inavoidable bidirectional couplings
(breaks layering) between generic and git-specific parts.

Yes, the code is split into two layers, but both layers contain git-
specific details. And the lower layer is low-level transport control code,
that doesn't even know how to configure TLS connection (that is quite
high-level task).

And ssh:// is not git:// tunneled over SSH, the request passing is done
differently.

-Ilari
