From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: [PATCH v5 01/18] Makefile: pass CPPFLAGS through to fllow
 customization
Date: Fri, 14 May 2010 09:53:30 +0000
Message-ID: <robbat2-20100514T094909-157386852Z@orbis-terrarum.net>
References: <20100514093131.249094000@mlists.thewrittenword.com>
 <20100514093725.884968000@mlists.thewrittenword.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 14 12:00:23 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OCrgs-0004IM-Nk
	for gcvg-git-2@lo.gmane.org; Fri, 14 May 2010 12:00:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758893Ab0ENKAQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 May 2010 06:00:16 -0400
Received: from b01.ext.isohunt.com ([208.71.112.51]:41848 "EHLO
	mail.isohunt.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751585Ab0ENKAO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 May 2010 06:00:14 -0400
X-Greylist: delayed 395 seconds by postgrey-1.27 at vger.kernel.org; Fri, 14 May 2010 06:00:13 EDT
Received: (qmail 24510 invoked from network); 14 May 2010 09:53:31 -0000
Received: from tsi-static.orbis-terrarum.net (HELO grubbs.orbis-terrarum.net) (76.10.188.108)
    by mail.isohunt.com (qpsmtpd/0.33-dev on beta01) with (CAMELLIA256-SHA encrypted) ESMTPS; Fri, 14 May 2010 09:53:31 +0000
Received: (qmail 21797 invoked by uid 10000); 14 May 2010 09:53:30 -0000
Content-Disposition: inline
In-Reply-To: <20100514093725.884968000@mlists.thewrittenword.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147077>

On Fri, May 14, 2010 at 09:31:32AM +0000, Gary V. Vaughan wrote:
> Without this patch there is no straight forward way to pass additional
> CPPFLAGS at configure-time.  At TWW, everything non-vendor package is
> installed to its own subdirectory, so we need the following to show
> the preprocessor where the headers for the libraries we will link
> later can be found:
As a point of comparision, this is what we use in Gentoo, to allow us to
override many of the variables:
sed -i \
    -e 's:^\(CFLAGS =\).*$:\1 $(OPTCFLAGS) -Wall:' \
    -e 's:^\(LDFLAGS =\).*$:\1 $(OPTLDFLAGS):' \
    -e 's:^\(CC = \).*$:\1$(OPTCC):' \
    -e 's:^\(AR = \).*$:\1$(OPTAR):' \
    Makefile || die "sed failed"

Which would be equivilent to changing the Makefile to have:
CFLAGS = $(OPTCFLAGS) -Wall
LDFLAGS = $(OPTLDFLAGS)
CC = $(OPTCC)
AR = $(OPTAR)

Thereafter, we pass in the relevant values for those variables.

CPPFLAGS is reserved for flags destined for ONLY the preprocessor, and we don't
want to introduce for that reason.

-- 
Robin Hugh Johnson
Gentoo Linux: Developer, Trustee & Infrastructure Lead
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85
