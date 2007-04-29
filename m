From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 1/5] Make xstrndup common
Date: Sun, 29 Apr 2007 14:19:28 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0704291416370.28708@iabervon.org>
References: Pine.LNX.4.64.0704281303371.28708@iabervon.org
 <46339819.8030007@freedesktop.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Josh Triplett <josh@freedesktop.org>
X-From: git-owner@vger.kernel.org Sun Apr 29 20:19:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HiDzh-0005vN-2U
	for gcvg-git@gmane.org; Sun, 29 Apr 2007 20:19:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030914AbXD2STa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Apr 2007 14:19:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030840AbXD2STa
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Apr 2007 14:19:30 -0400
Received: from iabervon.org ([66.92.72.58]:2995 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030914AbXD2ST3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Apr 2007 14:19:29 -0400
Received: (qmail 21285 invoked by uid 1000); 29 Apr 2007 18:19:28 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 29 Apr 2007 18:19:28 -0000
In-Reply-To: <46339819.8030007@freedesktop.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45826>

On Sat, 28 Apr 2007, Josh Triplett wrote:

> Daniel Barkalow wrote:
> > It was implemented in commit.c; move it with the other x memory functions.
> [...]
> > +static inline char *xstrndup(const char *str, int len)
> > +{
> > +	char *ret = xmalloc(len + 1);
> > +	memcpy(ret, str, len);
> > +	ret[len] = '\0';
> > +	return ret;
> > +}
> > +
> 
> I don't know if it matters, but this definition of xstrndup, like the version
> in commit.c, doesn't match the definition of strndup.  strndup duplicates a
> string, copying up to n characters or the length of the string.  This xstrndup
> always copies n characters, reading past the end of the string if it doesn't
> have at least n characters.

Good catch. Replacing the memcpy with strncpy solves this, right? 
(Potentially allocating a bit of extra memory if someone is actually using 
it on too short a string for some reason, of course).

	-Daniel
*This .sig left intentionally blank*
