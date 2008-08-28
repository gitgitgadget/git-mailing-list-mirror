From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] dir.c: avoid c99 array initialization
Date: Thu, 28 Aug 2008 13:16:57 -0700
Message-ID: <20080828201657.GH21072@spearce.org>
References: <IH0MHSTEimhAN93AedvpRKq4qfzm1QA814ZYyhbSBtSdNbq8vuE6aw@cipher.nrlssc.navy.mil> <G-ipWASixyGW7nvO1KquifehvBB7FNKwjPtIB0ukyEJ1Si1CJWM34w@cipher.nrlssc.navy.mil> <81b0412b0808281301m29830c20l3e16432ea8aef45d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Brandon Casey <casey@nrlssc.navy.mil>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>, davidk@lysator.liu.se,
	Andreas Ericsson <ae@op5.se>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 28 22:18:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYnwU-0005vp-9F
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 22:18:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753993AbYH1UQ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 16:16:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753315AbYH1UQ6
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 16:16:58 -0400
Received: from george.spearce.org ([209.20.77.23]:55331 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753446AbYH1UQ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 16:16:58 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 6BBEC38375; Thu, 28 Aug 2008 20:16:57 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <81b0412b0808281301m29830c20l3e16432ea8aef45d@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94130>

Alex Riesen <raa.lkml@gmail.com> wrote:
> 
> For just these 5 values it is likely more effective to just use
> a conditional statement (less stack requested, less likely
> some stupid compiler tries to optimize it wrongly).
> And just as readable.
> 
> diff --git a/dir.c b/dir.c
> index 92452eb..1cf5985 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -680,17 +680,12 @@ static int cmp_name(const void *p1, const void *p2)
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
> +		if (!c || '?' == c || '\\' == c || '*' == c || '[' == c)

I am reminded of a year old thread with my patch to this:

  http://kerneltrap.org/mailarchive/git/2007/4/15/243541

The patch never applied.  I wonder why.  Was it just Dscho's comment?

-- 
Shawn.
