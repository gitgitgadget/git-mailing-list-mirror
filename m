From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: make install rewrites source files
Date: Thu, 26 Jan 2012 23:52:31 +0100
Message-ID: <20120126225231.GA14753@ecki>
References: <hbf.20120123bz2f@bombur.uio.no>
 <7vhazm89bo.fsf@alter.siamese.dyndns.org>
 <hbf.20120123j61g@bombur.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Hallvard Breien Furuseth <h.b.furuseth@usit.uio.no>
X-From: git-owner@vger.kernel.org Fri Jan 27 00:01:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RqYJT-0003Ma-48
	for gcvg-git-2@lo.gmane.org; Fri, 27 Jan 2012 00:01:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753614Ab2AZXA5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jan 2012 18:00:57 -0500
Received: from bsmtp3.bon.at ([213.33.87.17]:43227 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753449Ab2AZXA5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jan 2012 18:00:57 -0500
Received: from localhost (p5B22C50C.dip.t-dialin.net [91.34.197.12])
	by bsmtp.bon.at (Postfix) with ESMTP id D1CFF130044;
	Fri, 27 Jan 2012 00:00:51 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <hbf.20120123j61g@bombur.uio.no>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189172>

On Mon, Jan 23, 2012 at 09:57:51PM +0100, Hallvard Breien Furuseth wrote:
> 
> 'profile-all' makes 'all' with different CFLAGS from those in
> Makefile.

How about removing the profile-all target and making it a build option
instead? To enable it, do the usual:

 echo PROFILE_BUILD=YesPlease >> config.mak
 echo prefix=... >> config.mak
 make
 su make install

In the Makefile, we would have

ifdef PROFILE_BUILD
 all:
	$(MAKE) CFLAGS=... -fprofile-generate ... all-one
	$(MAKE) CFLAGS=... -fprofile-use ... all-one
else
 all: all-one
endif

and each previous instance of 'all' replaced with 'all-one'.

Clemens
