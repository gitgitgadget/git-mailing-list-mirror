From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: gitweb.cgi
Date: Tue, 18 Oct 2005 17:27:53 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0510181645200.3369@g5.osdl.org>
References: <43546492.3020401@zytor.com> <20051018110725.GB6929@vrfy.org>
 <43552FC2.3000000@zytor.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Kay Sievers <kay.sievers@vrfy.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Oct 19 02:28:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ES1oG-0002MB-EU
	for gcvg-git@gmane.org; Wed, 19 Oct 2005 02:28:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932333AbVJSA15 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 18 Oct 2005 20:27:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932334AbVJSA14
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Oct 2005 20:27:56 -0400
Received: from smtp.osdl.org ([65.172.181.4]:5527 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932333AbVJSA1z (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Oct 2005 20:27:55 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j9J0RsFC019054
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 18 Oct 2005 17:27:54 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j9J0RrXu007833;
	Tue, 18 Oct 2005 17:27:53 -0700
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <43552FC2.3000000@zytor.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.125 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10243>



On Tue, 18 Oct 2005, H. Peter Anvin wrote:
> 
> I set up mod_cache (which I didn't know about, silly me) and so far it seems
> to work and has produced a tremendous decrease in load and improvement in
> response time.

It really doesn't work very well with the "front page" though..

Doing a "Save page as.." shows that it's not a huge page: it's roughly 700 
lines long and 57kB in size, but pressing the reload button (or just going 
somewhere else and coming back immediately) takes 45 seconds to reload for 
me.

Trying again shows that it _is_ cached if you press the reload button 
immediately again, but I haven't quite figured out how long the cache 
timeout is. It seems to be around one minute (from some very preliminary 
tests it's more than 25 seconds, but less than a minute and a half).

Considering that apparently the load is enough that it takes 45 seconds to 
generate (scary in itself), is should clearly be cached for more than one 
minute. More like ten minutes or half an hour, especially since mirroring 
any content changes takes longer than that anyway.

Now, I suspect all the content on kernel.org could easily be cached for 
ten minutes.

As far as I can tell, mod_cache without any expiry information uses

	CacheDefaultExpire 

which should default to one hour according to the docs. Have you changed 
that to one minute? Maybe making it 10 minutes would be better?

That said, I tried to figure out how the front page is generated, but 
haven't quite. Can somebody (Kay?) please say what it does most, and I can 
try to make sure git does that efficiently.. 

			Linus
