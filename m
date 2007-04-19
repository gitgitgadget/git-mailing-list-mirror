From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH] Fix merge-recursive on cygwin: broken errno when unlinking a directory
Date: Thu, 19 Apr 2007 20:31:06 +0200
Message-ID: <20070419183106.GB3396@uranus.ravnborg.org>
References: <20070418223327.GC2477@steel.home> <alpine.LFD.0.98.0704181537590.9964@woody.linux-foundation.org> <20070418234034.GE2477@steel.home> <81b0412b0704190128o7fccbe77h8df3114328d6a0da@mail.gmail.com> <alpine.LFD.0.98.0704190932450.9964@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <junkio@cox.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Apr 19 20:31:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HebPF-0005ow-6K
	for gcvg-git@gmane.org; Thu, 19 Apr 2007 20:30:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751024AbXDSSav (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Apr 2007 14:30:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753504AbXDSSav
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Apr 2007 14:30:51 -0400
Received: from pasmtpb.tele.dk ([80.160.77.98]:58068 "EHLO pasmtpB.tele.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751024AbXDSSau (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Apr 2007 14:30:50 -0400
Received: from ravnborg.org (0x535d98d8.vgnxx8.adsl-dhcp.tele.dk [83.93.152.216])
	by pasmtpB.tele.dk (Postfix) with ESMTP id E2A6EE301AE;
	Thu, 19 Apr 2007 20:30:15 +0200 (CEST)
Received: by ravnborg.org (Postfix, from userid 1000)
	id 87881580D2; Thu, 19 Apr 2007 20:31:06 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.98.0704190932450.9964@woody.linux-foundation.org>
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45034>

> +		if (status == -3) {
> +			/* something else exists */
> +			error(msg, path, ": perhaps a D/F conflict?");

It would be more helpful it you spelled it out like:
Directory/File conflict?


> +			return -1;
> +		}
> +		die(msg, path, "");
> +	}
> +
> +	/* Successful unlink is good.. */
> +	if (!unlink(path))
> +		return 0;
> +	/* .. and so is no existing file */
> +	if (errno == ENOENT)
> +		return 0;
> +	/* .. but not some other error (who really cares what?) */
> +	return error(msg, path, ": perhaps a D/F conflict?");
ditto.

I know this was how it looked previously too but thats just a lame excuse.

	Sam
