From: Chris Wright <chrisw@osdl.org>
Subject: Re: [ANNOUNCE] Cogito-0.11.3
Date: Thu, 9 Jun 2005 14:06:41 -0700
Message-ID: <20050609210641.GK5324@shell0.pdx.osdl.net>
References: <20050609091909.GF29665@pasky.ji.cz> <42A81584.90605@antselovich.com> <42A83F0C.5020809@gmail.com> <20050609205503.GJ5324@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dan Holmsand <holmsand@gmail.com>, git@vger.kernel.org,
	Konstantin Antselovich <konstantin@antselovich.com>,
	Petr Baudis <pasky@ucw.cz>
X-From: git-owner@vger.kernel.org Thu Jun 09 23:04:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DgUB3-0003Tw-8k
	for gcvg-git@gmane.org; Thu, 09 Jun 2005 23:03:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262492AbVFIVHC (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Jun 2005 17:07:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262470AbVFIVHC
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Jun 2005 17:07:02 -0400
Received: from smtp.osdl.org ([65.172.181.4]:483 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262492AbVFIVGz (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Jun 2005 17:06:55 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j59L6fjA005017
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 9 Jun 2005 14:06:42 -0700
Received: from shell0.pdx.osdl.net (localhost [127.0.0.1])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j59L6f2q021721;
	Thu, 9 Jun 2005 14:06:41 -0700
Received: (from chrisw@localhost)
	by shell0.pdx.osdl.net (8.13.1/8.13.1/Submit) id j59L6fpX021720;
	Thu, 9 Jun 2005 14:06:41 -0700
To: Chris Wright <chrisw@osdl.org>
Content-Disposition: inline
In-Reply-To: <20050609205503.GJ5324@shell0.pdx.osdl.net>
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

* Chris Wright (chrisw@osdl.org) wrote:
> * Dan Holmsand (holmsand@gmail.com) wrote:
> > Konstantin Antselovich wrote:
> > >I have updated to Cogito-0.11.3, it compiles and runs
> > >but make test returns multiple error messages (see below)
> > 
> > There's a typo in rev-list.c. This fixes the tests for me:
> 
> This patch is white space damaged.  I fixed it, and added it to the
> cogito-0.11.3 rpm.  Below is the refreshed patch.

Looks like showdate() is having some minor trouble.  A simple cg-log
gave me errors indicating the tz is being interpreted as octal.
There's probably a better way, but bruteforce works ;-) This patch is
in the RPM packages which are now uploading.

thanks,
-chris
--

Strip leading zero from timezone to keep it from being interpreted as
octal causing error such as:

/usr/lib/cogito/cg-Xlib: line 69: 0800: value too great for base (error token is "0800")

Signed-off-by: Chris Wright <chrisw@osdl.org>

--- a/cg-Xlib
+++ b/cg-Xlib
@@ -65,7 +65,9 @@ showdate () {
 	[ "$format" ] || format=-R
 	sec=${date[0]}; tz=${date[1]}
 	if [ "$has_gnudate" ]; then
-	        dtz=${tz/+/}
+	        dtz=${tz/-0/-}
+	        dtz=${dtz/+/}
+	        dtz=${dtz/#0/}
 		lsec=$(($dtz / 100 * 3600 + $dtz % 100 * 60 + $sec))
 	        pdate="$(date -ud "1970-01-01 UTC + $lsec sec" "$format" 2>/dev/null)"
 	else
