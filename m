From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-fetch per-repository speed issues
Date: Mon, 3 Jul 2006 21:19:49 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0607032115340.12404@g5.osdl.org>
References: <1151949764.4723.51.camel@neko.keithp.com> 
 <Pine.LNX.4.64.0607031603290.12404@g5.osdl.org>  <1151973438.4723.70.camel@neko.keithp.com>
  <Pine.LNX.4.64.0607032008590.12404@g5.osdl.org> <1151985747.4723.102.camel@neko.keithp.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 04 06:20:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FxcOc-00077C-Cx
	for gcvg-git@gmane.org; Tue, 04 Jul 2006 06:20:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750838AbWGDET6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Jul 2006 00:19:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750861AbWGDET5
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Jul 2006 00:19:57 -0400
Received: from smtp.osdl.org ([65.172.181.4]:60311 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750838AbWGDET4 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Jul 2006 00:19:56 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k644JonW016613
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 3 Jul 2006 21:19:51 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k644JnlP016318;
	Mon, 3 Jul 2006 21:19:50 -0700
To: Keith Packard <keithp@keithp.com>
In-Reply-To: <1151985747.4723.102.camel@neko.keithp.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.81__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23247>



On Mon, 3 Jul 2006, Keith Packard wrote:
> 
> Yeah, it says that only once. And, it runs the fetch-pack in about .5
> seconds. And, now the whole process completes in 4.7 seconds; perhaps
> the remote server is less loaded than earlier this afternoon?

Well, that's still strange. What takes 4.2 seconds then?

> > And then it should leave a "fetch.trace" file in your working directory, 
> > which should show where that _one_ thing spends its time.
> 
> It looks boring to me and spent 0.55 from start to finish. I can send
> along the whole trace if you have an acute desire to peer at it.

No, the 0.5 seconds is what I _expected_. There's something strange going 
on in your git fetch that it takes any longer than that.

Can you instrument your "git-fetch.sh" script (just add random

	(echo $LINENO ; date) >&2

lines all over) to see what is so expensive? 

That fetch-pack really should be the most expensive part by far (and half 
a second sounds right), but it clearly isn't. At 4.7s, your fetch is still 
taking about ten times longer than it _should_.

		Linus
