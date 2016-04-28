From: Jeff King <peff@peff.net>
Subject: Re: [RFC] How to pass Git config command line instructions to
 Submodule commands?
Date: Thu, 28 Apr 2016 09:40:47 -0400
Message-ID: <20160428134047.GA25364@sigill.intra.peff.net>
References: <60724588-B06E-47E8-9302-8709C4601826@gmail.com>
 <CAGZ79kYmAr-O6_Jw2KO9eZEfZQ+_WBiERF=nhOYLJCZpUjSSyA@mail.gmail.com>
 <CA+P7+xoaqNF+uBHVnD2QR7j-=0Hyvd-scTc_vOdV+etC0VS9jA@mail.gmail.com>
 <20160425212449.GA7636@sigill.intra.peff.net>
 <017AA7DB-5224-49C3-A4A6-6C93005BF006@gmail.com>
 <20160428112511.GA11522@sigill.intra.peff.net>
 <FF931AB2-2381-4DF9-AE28-CE30EEC5C352@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jacob Keller <jacob.keller@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Git Users <git@vger.kernel.org>, Jens.Lehmann@web.de
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 28 15:40:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avmBb-00060D-O3
	for gcvg-git-2@plane.gmane.org; Thu, 28 Apr 2016 15:40:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752377AbcD1Nku (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2016 09:40:50 -0400
Received: from cloud.peff.net ([50.56.180.127]:58323 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752188AbcD1Nku (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2016 09:40:50 -0400
Received: (qmail 25786 invoked by uid 102); 28 Apr 2016 13:40:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 28 Apr 2016 09:40:49 -0400
Received: (qmail 9674 invoked by uid 107); 28 Apr 2016 13:40:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 28 Apr 2016 09:40:51 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 28 Apr 2016 09:40:47 -0400
Content-Disposition: inline
In-Reply-To: <FF931AB2-2381-4DF9-AE28-CE30EEC5C352@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292881>

On Thu, Apr 28, 2016 at 02:05:20PM +0200, Lars Schneider wrote:

> I am no expert in the Submodule code but I think the cloning of
> the submodules is not yet guarded with sanitize_submodule_env [3].
> That means the submodule is cloned with the GIT_CONFIG_PARAMETERS
> of the super project. That might explain why t5550 passes as the 
> credential config is only used in that area.
> 
> The submodule checkout is guarded with sanitize_submodule_env
> and therefore my Git-LFS filter use case is affect.
> 
> Does this sound reasonable?

Yes, that's exactly what's going on. git-submodule.sh's code _is_
broken, which is what you're seeing. I've just posted a series to fix
this. I think it would be reasonable to add filter.* to the whitelist on
top of that series.

-Peff
