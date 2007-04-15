From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Correct dir.c to compile on Solaris 9
Date: Sun, 15 Apr 2007 18:25:48 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0704151824240.18846@racer.site>
References: <20070415043328.GA17285@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Apr 15 18:27:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hd7Zl-0001kn-7x
	for gcvg-git@gmane.org; Sun, 15 Apr 2007 18:27:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753083AbXDOQ1J (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Apr 2007 12:27:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753103AbXDOQ1I
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Apr 2007 12:27:08 -0400
Received: from mail.gmx.net ([213.165.64.20]:52888 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753083AbXDOQ1E (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Apr 2007 12:27:04 -0400
Received: (qmail invoked by alias); 15 Apr 2007 16:27:02 -0000
Received: from 88-110-140-199.dynamic.dsl.as9105.com (EHLO 88-110-140-199.dynamic.dsl.as9105.com) [88.110.140.199]
  by mail.gmx.net (mp029) with SMTP; 15 Apr 2007 18:27:02 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+9jX9jrYa9pdol7PuBF+pvuX9YtLITy3GnH5ZKhW
	k9Gbx7q/Pe5kp/
X-X-Sender: gene099@racer.site
In-Reply-To: <20070415043328.GA17285@spearce.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44498>

Hi,

On Sun, 15 Apr 2007, Shawn O. Pearce wrote:

> The compiler on my Solaris 9 system doesn't understand
> the array initialization syntax used here in dir.c.
> 
> Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
> ---
>  dir.c |   11 +++++------
>  1 files changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/dir.c b/dir.c
> index 7426fde..038fd82 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -423,18 +423,17 @@ static int cmp_name(const void *p1, const void *p2)
>   */
>  static int simple_length(const char *match)
>  {
> -	const char special[256] = {
> -		[0] = 1, ['?'] = 1,
> -		['\\'] = 1, ['*'] = 1,
> -		['['] = 1
> -	};
>  	int len = -1;
>  
>  	for (;;) {
>  		unsigned char c = *match++;
>  		len++;
> -		if (special[c])
> +		switch (c) {
> +		case 0: case '?':
> +		case '\\': case '*':
> +		case '[':
>  			return len;
> +		}
>  	}
>  }

You are replacing a table-based check with a switch based, which might be 
substantially slower (depends on how often cmp_name() is called).

Maybe there is another way to initialize the table (and make it static to 
begin with)?

Ciao,
Dscho
