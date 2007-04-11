From: Junio C Hamano <junkio@cox.net>
Subject: Re: sscanf/strtoul: parse integers robustly
Date: Wed, 11 Apr 2007 00:55:29 -0700
Message-ID: <7v4pnnqr9q.fsf@assigned-by-dhcp.cox.net>
References: <871witxicn.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jim Meyering <jim@meyering.net>
X-From: git-owner@vger.kernel.org Wed Apr 11 15:00:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbXfy-0005Ke-Gx
	for gcvg-git@gmane.org; Wed, 11 Apr 2007 09:55:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751042AbXDKHzb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Apr 2007 03:55:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751044AbXDKHzb
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Apr 2007 03:55:31 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:41038 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750897AbXDKHza (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2007 03:55:30 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070411075531.VUOI1268.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Wed, 11 Apr 2007 03:55:31 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id ljvV1W00W1kojtg0000000; Wed, 11 Apr 2007 03:55:30 -0400
In-Reply-To: <871witxicn.fsf@rho.meyering.net> (Jim Meyering's message of
	"Tue, 10 Apr 2007 01:01:44 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44217>

Jim Meyering <jim@meyering.net> writes:

> diff --git a/git-compat-util.h b/git-compat-util.h
> index 139fc19..5f6a281 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -301,4 +301,17 @@ static inline int prefixcmp(const char *str, const char *prefix)
>  	return strncmp(str, prefix, strlen(prefix));
>  }
>  
> +static inline int strtoul_ui(char const *s, int base, unsigned int *result)
> +{
> +	unsigned long ul;
> +	char *p;
> +
> +	errno = 0;
> +	ul = strtoul(s, &p, base);
> +	if (errno || *p || p == s || (unsigned int) ul != ul)
> +		return -1;
> +	*result = ul;
> +	return 0;
> +}
> +
>  #endif

War on sscanf is fine, but I wonder if this is small enough to
be a good candidate for inlining.
