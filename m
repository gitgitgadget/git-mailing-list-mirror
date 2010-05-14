From: "Gary V. Vaughan" <git@mlists.thewrittenword.com>
Subject: Re: [PATCH v5 01/18] Makefile: pass CPPFLAGS through to fllow
 customization
Date: Fri, 14 May 2010 12:01:16 +0000
Message-ID: <20100514120116.GC31921@thor.il.thewrittenword.com>
References: <20100514093131.249094000@mlists.thewrittenword.com>
 <20100514093725.884968000@mlists.thewrittenword.com>
 <robbat2-20100514T094909-157386852Z@orbis-terrarum.net>
 <20100514105832.GB31921@thor.il.thewrittenword.com>
 <robbat2-20100514T110034-766521339Z@orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: "Robin H. Johnson" <robbat2@gentoo.org>
X-From: git-owner@vger.kernel.org Fri May 14 14:01:24 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OCtZz-0002EB-M7
	for gcvg-git-2@lo.gmane.org; Fri, 14 May 2010 14:01:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758042Ab0ENMBS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 May 2010 08:01:18 -0400
Received: from mail1.thewrittenword.com ([69.67.212.77]:62639 "EHLO
	mail1.thewrittenword.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754327Ab0ENMBR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 May 2010 08:01:17 -0400
Received: from mail1.il.thewrittenword.com (emma-internal-gw.il.thewrittenword.com [192.168.13.25])
	by mail1.thewrittenword.com (Postfix) with ESMTP id 471D35C44;
	Fri, 14 May 2010 12:18:09 +0000 (UTC)
X-DKIM: Sendmail DKIM Filter v2.4.4 mail1.thewrittenword.com 471D35C44
Received: from thor.il.thewrittenword.com (thor.il.thewrittenword.com [10.191.57.1])
	by mail1.il.thewrittenword.com (Postfix) with ESMTP id CEAFBCA0;
	Fri, 14 May 2010 12:01:16 +0000 (UTC)
Received: by thor.il.thewrittenword.com (Postfix, from userid 1048)
	id C5650BAAE; Fri, 14 May 2010 12:01:16 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <robbat2-20100514T110034-766521339Z@orbis-terrarum.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Virus-Scanned: clamav-milter 0.96 at maetel.il.thewrittenword.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147084>

Hi Robin,

On Fri, May 14, 2010 at 11:04:59AM +0000, Robin H. Johnson wrote:
> On Fri, May 14, 2010 at 10:58:32AM +0000, Gary V. Vaughan wrote:
> > As a matter of fact, Automake even jumps through hoops with
> > AM_CPPFLAGS to make sure that the package maintainer doesn't
> > accidentally trample over the package builder's CPPFLAGS settings - I
> > can't think of a scenario where the person who writes the build system
> > for a package knows more about what CPPFLAGS the person who builds it
> > will need that the person doing the actual building.
> AM_CFLAGS != AM_CPPFLAGS. My concern was the mixing of them.

While I agree that mixing up AM_CFLAGS and AM_CPPFLAGS, or even
AM_CXXFLAGS and AM_CFLAGS is likely to break your build, that's no
reason to deprecate the user's CPPFLAGS setting!

> As a middle ground:
> CFLAGS = $(OPTCFLAGS) -Wall
> CPPFLAGS = $(OPTCPPFLAGS)
> LDFLAGS = $(OPTLDFLAGS)
> CC = $(OPTCC)
> AR = $(OPTAR)

Okay, I think we are mostly in agreement here.  In all the packages we
build here at TWW, we let the user use CFLAGS, CPPFLAGS, LDFLAGS etc,
and to preserve that we'll jump through some Automake-like hoops so
that the build system doesn't overwrite them at build time.

You actually propose the same separation, except that you want the
package builder to use the OPTCFLAGS, OPTCPPFLAGS, OPTLDFLAGS etc so
that the build system can use CFLAGS et al.  I don't think this
buys you anything but confusion when anyone used to building on Unix
over the last 20 or 30 years tries to pass flags into the build using
the tried and tested mechanism (CFLAGS, CPPFLAGS et al) to no effect.

Git already follows the tried and tested mechanism, but forgot to
honor the user's CPPFLAGS setting, which is what this patch is trying
to address.

Cheers,
-- 
Gary V. Vaughan (gary@thewrittenword.com)
