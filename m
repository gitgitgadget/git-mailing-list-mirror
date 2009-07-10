From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT PATCH] Allow http_proxy values without protocol-part
Date: Fri, 10 Jul 2009 08:22:09 -0700
Message-ID: <20090710152209.GE11191@spearce.org>
References: <20090709232822.00000164@unknown>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>, git@vger.kernel.org
To: Christian Halstrick <christian.halstrick@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 10 17:22:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MPHvZ-0003gj-B6
	for gcvg-git-2@gmane.org; Fri, 10 Jul 2009 17:22:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751724AbZGJPWL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jul 2009 11:22:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751580AbZGJPWL
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Jul 2009 11:22:11 -0400
Received: from george.spearce.org ([209.20.77.23]:35218 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750974AbZGJPWK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jul 2009 11:22:10 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id B52043819F; Fri, 10 Jul 2009 15:22:09 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20090709232822.00000164@unknown>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123057>

Sorry I didn't respond earlier this week, I was more or less offline
for basically 2.5 days.

Christian Halstrick <christian.halstrick@gmail.com> wrote:
> jgit reads the environment variable http_proxy to configure the proxy
> for http traffic in the same way as applications using the libcurl
> library. It would be nice if jgit would understand the same values as
> libcurl, but for libcurl the protocol part is optional (e.g.
> http_proxy=proxy:8080 is valid). I changed jgit to also support
> http_proxy values without a protocol spec. When no protocol is
> specified "http://" is assumed.

This didn't really fit with our style of commit messages.  Instead of
saying what you did, we prefer to say *why* you did it.  The what
is clear from the diff.  The why is usually less clear.

I replaced the message with the following:

--8<--
Allow http_proxy values without protocol-part

jgit reads the environment variable http_proxy to configure the
JRE's URL library for HTTP traffic through the proxy in the same
way as other applications that are using the libcurl library.
libcurl assumes "http://" when the protocol is not specified in
http_proxy, so jgit should do the same.

Thus http_proxy=proxy:8080 is now valid.

Signed-off-by: Christian Halstrick <christian.halstrick@sap.com>
Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
-->8--

> diff --git a/org.spearce.jgit/src/org/spearce/jgit/util/HttpSupport.java b/org.spearce.jgit/src/org/spearce/jgit/util/HttpSupport.java
> index 33dfcee..5f21677 100644
> --- a/org.spearce.jgit/src/org/spearce/jgit/util/HttpSupport.java
> +++ b/org.spearce.jgit/src/org/spearce/jgit/util/HttpSupport.java
> @@ -69,7 +69,7 @@ public static void configureHttpProxy() throws MalformedURLException {
>  		if (s == null || s.equals(""))
>  			return;
>  
> -		final URL u = new URL(s);
> +		final URL u = new URL((s.indexOf("://")==-1) ? "http://"+s : s);

Also, our formatting rules tend to place spaces around operators,
so this line was reformatted slightly to honor that convention.
If you are using Eclipse, the projects should be configured
automatically with our preferred code formatting rules, though
Eclipse often gets Javadoc blocks wrong and adds a trailing space
on the end of a blank line.

But, patches applied clean, so your techique of sending works.
Thanks.

-- 
Shawn.
