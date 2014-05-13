From: Jeff Sipek <jeffpc@josefsipek.net>
Subject: Re: [GUILT v2 06/29] Fix the do_get_patch function.
Date: Tue, 13 May 2014 17:13:27 -0400
Message-ID: <20140513211326.GE4791@meili.valhalla.31bits.net>
References: <1400013065-27919-1-git-send-email-cederp@opera.com>
 <1400013065-27919-7-git-send-email-cederp@opera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Per Cederqvist <cederp@opera.com>
X-From: git-owner@vger.kernel.org Tue May 13 23:13:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkK0r-0007V9-2A
	for gcvg-git-2@plane.gmane.org; Tue, 13 May 2014 23:13:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753911AbaEMVNW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2014 17:13:22 -0400
Received: from josefsipek.net ([64.9.206.49]:1673 "EHLO josefsipek.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752935AbaEMVNU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2014 17:13:20 -0400
Received: from meili.valhalla.31bits.net (c-98-209-117-250.hsd1.mi.comcast.net [98.209.117.250])
	by josefsipek.net (Postfix) with ESMTPSA id D49D855654;
	Tue, 13 May 2014 17:13:19 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1400013065-27919-7-git-send-email-cederp@opera.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248856>

On Tue, May 13, 2014 at 10:30:42PM +0200, Per Cederqvist wrote:
> A patch file consists of:
> 
> (1) the description
> (2) optional diffstat
> (3) the patches
> 
> When extracting the patch, we only want part 3.  The do_get_patch used
> to give us part 2 and part 3.  That made for instance this series of
> operations fail if guilt.diffstat is true:
> 
>     guilt push empty-1
>     guilt push empty-2
>     guilt pop
>     guilt fold empty-2
>     guilt pop
>     guilt push

I would probably include the actual error here.  I got the following (using
patch names a & b):

$ guilt pop
Now at a.
$ guilt fold b
error: No changes
$ guilt pop
All patches popped.
$ guilt pu
Applying patch..a
error: No changes
To force apply this patch, use 'guilt push -f'


The diff itself is good.

Signed-off-by: Josef 'Jeff' Sipek <jeffpc@josefsipek.net>

> 
> Signed-off-by: Per Cederqvist <cederp@opera.com>
> ---
>  guilt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/guilt b/guilt
> index 8701481..3fc524e 100755
> --- a/guilt
> +++ b/guilt
> @@ -334,7 +334,7 @@ do_get_patch()
>  {
>  	awk '
>  BEGIN{}
> -/^(diff |---$|--- )/ {patch = 1}
> +/^(diff |--- )/ {patch = 1}
>  patch == 1 {print $0}
>  END{}
>  ' < "$1"
> -- 
> 1.8.3.1
> 

-- 
I already backed up the [server] once, I can do it again.
		- a sysadmin threatening to do more frequent backups
