From: Steven Grimm <koreth@midwinter.com>
Subject: Re: [PATCH] Teach git-commit about commit message templates.
Date: Mon, 23 Jul 2007 18:23:48 +0800
Message-ID: <46A481B4.7000502@midwinter.com>
References: <20070723041741.GA22461@midwinter.com> <Pine.LNX.4.64.0707231059490.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jul 23 12:24:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICv50-0006Xc-UJ
	for gcvg-git@gmane.org; Mon, 23 Jul 2007 12:23:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759556AbXGWKXv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Jul 2007 06:23:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759612AbXGWKXv
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jul 2007 06:23:51 -0400
Received: from 91.86.32.216.static.reverse.layeredtech.com ([216.32.86.91]:39123
	"HELO midwinter.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with SMTP id S1759523AbXGWKXu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2007 06:23:50 -0400
Received: (qmail 12791 invoked from network); 23 Jul 2007 10:23:50 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=guj8W+S1eD32uVHrRo0CAkFa0Svsjh47HU+n+X67oMAyh0Y6a+njE/R+UduFzvy0  ;
Received: from localhost (HELO sgrimm-mbp.local) (koreth@127.0.0.1)
  by localhost with SMTP; 23 Jul 2007 10:23:49 -0000
User-Agent: Thunderbird 2.0.0.5 (Macintosh/20070716)
In-Reply-To: <Pine.LNX.4.64.0707231059490.14781@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53422>

Johannes Schindelin wrote:
> Up until here, I was with you.  But this feels very wrong.
>
> Why not compare COMMIT_MSG to the templatefile, if there is one?  I.e.
>
> test ! -z "$templatefile" && cmp "$GIT_DIR"/COMMIT_MSG "$templatefile" &&
> 	die "Unchanged message; will not commit"
>   

The template can itself have comments -- instructions or explanations of 
fields to fill in, for example -- and since comments have been stripped 
from COMMIT_MSG at this point, a comparison against such a template 
would always fail. And, consistent with the current behavior, simply 
adding a Signed-off-by: line shouldn't count as supplying a commit message.

I could do this test before stripping comments from COMMIT_MSG, but then 
I'd still fail the comparison if the user just deleted some comment 
lines manually, which also seems wrong to me -- the comments should be 
totally ignored when doing this comparison, IMO. Plus that wouldn't 
ignore Signed-off-by: lines.

If I'm coming at the design the wrong way, I'm of course happy to adjust 
it, but insensitivity to both comments and Signed-off-by: lines seemed 
like the right behavior from the user's POV to me, and I didn't see a 
cleaner way to do it.

Thanks for looking at the patch!

-Steve
