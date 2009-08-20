From: Thell Fowler <git@tbfowler.name>
Subject: Re: [PATCH 3/6] Make diff -w handle trailing-spaces on incomplete
 lines.
Date: Thu, 20 Aug 2009 18:09:26 -0500 (CDT)
Message-ID: <alpine.DEB.2.00.0908201803170.2012@GWPortableVCS>
References: <1249428804.2774.52.camel@GWPortableVCS> <cover.1250719760.git.git@tbfowler.name> <alpine.DEB.2.00.0908191725440.2012@GWPortableVCS>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Thell Fowler <git@tbfowler.name>
X-From: git-owner@vger.kernel.org Fri Aug 21 01:09:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MeGlI-0007N8-Jb
	for gcvg-git-2@lo.gmane.org; Fri, 21 Aug 2009 01:09:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932086AbZHTXJd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Aug 2009 19:09:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755505AbZHTXJc
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Aug 2009 19:09:32 -0400
Received: from 216.38.49.125.servint.net ([216.38.49.125]:39045 "EHLO
	vps5.pyrapat.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1755404AbZHTXJa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Aug 2009 19:09:30 -0400
Received: from ip70-178-75-143.ks.ks.cox.net ([70.178.75.143] helo=GWPortableVCS.local)
	by vps5.pyrapat.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <git@tbfowler.name>)
	id 1MeGl8-0006pB-FO; Thu, 20 Aug 2009 18:09:30 -0500
X-X-Sender: almostautomated@GWPortableVCS
In-Reply-To: <alpine.DEB.2.00.0908191725440.2012@GWPortableVCS>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vps5.pyrapat.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - tbfowler.name
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126659>

Thell Fowler (git@tbfowler.name) wrote on Aug 19, 2009:

>   - When processing trailing spaces with --ignore-all-space a diff
>     would be found whenever one side had 0 spaces and either (or both)
>     sides was an incomplete line.  xdl_recmatch should process the
>     full length of the record instead of assuming both sides have a
>     terminator.
> 
> @@ -191,14 +191,14 @@ int xdl_recmatch(const char *l1, long s1, const char *l2, long s2, long flags)
>  	int i1, i2;
>  
>  	if (flags & XDF_IGNORE_WHITESPACE) {
> -		for (i1 = i2 = 0; i1 < s1 && i2 < s2; ) {
> +		for (i1 = i2 = 0; i1 <= s1 && i2 <= s2; ) {
>  			if (isspace(l1[i1]))
> -				while (isspace(l1[i1]) && i1 < s1)
> +				while (isspace(l1[i1]) && i1 <= s1)

The change from '<' to <=' obviously did do jack-diddly-squat, which I 
should have noticed earlier.

>  					i1++;
>  			if (isspace(l2[i2]))
> -				while (isspace(l2[i2]) && i2 < s2)
> +				while (isspace(l2[i2]) && i2 <= s2)

Here too.

>  					i2++;
> -			if (i1 < s1 && i2 < s2 && l1[i1++] != l2[i2++])
> +			if (i1 <= s1 && i2 <= s2 && l1[i1++] != l2[i2++])
>  				return 0;
>  		}
>  		return (i1 >= s1 && i2 >= s2);
> 


Those will be corrected for v2.

-- 
Thell
