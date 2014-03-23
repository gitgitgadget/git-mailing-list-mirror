From: Jeff Sipek <jeffpc@josefsipek.net>
Subject: Re: [GUILT 06/28] Fix and simplify the do_get_patch function.
Date: Sun, 23 Mar 2014 13:09:33 -0400
Message-ID: <20140323170932.GH1661@meili.valhalla.31bits.net>
References: <1395387126-13681-1-git-send-email-cederp@opera.com>
 <1395387126-13681-7-git-send-email-cederp@opera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Per Cederqvist <cederp@opera.com>
X-From: git-owner@vger.kernel.org Sun Mar 23 18:09:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WRltj-0002Mb-48
	for gcvg-git-2@plane.gmane.org; Sun, 23 Mar 2014 18:09:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752462AbaCWRJT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Mar 2014 13:09:19 -0400
Received: from josefsipek.net ([64.9.206.49]:1757 "EHLO josefsipek.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752291AbaCWRJS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Mar 2014 13:09:18 -0400
Received: from meili.valhalla.31bits.net (c-98-209-117-250.hsd1.mi.comcast.net [98.209.117.250])
	by josefsipek.net (Postfix) with ESMTPSA id BCF59554D8;
	Sun, 23 Mar 2014 13:09:17 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1395387126-13681-7-git-send-email-cederp@opera.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244796>

On Fri, Mar 21, 2014 at 08:31:44AM +0100, Per Cederqvist wrote:
> When extracting the patch, we only want the actual patches.  We don't
> want the "---" delimiter.  Simplify the extraction by simply deleting
> everything before the first "diff " line.  (Use sed instead of awk to
> simplify the code.)
> 
> Without this patch, "guilt fold" and "guilt push" sometimes fails if
> guilt.diffstat is true.
> 
> Signed-off-by: Per Cederqvist <cederp@opera.com>
> ---
>  guilt | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/guilt b/guilt
> index 8701481..c59cd0f 100755
> --- a/guilt
> +++ b/guilt
> @@ -332,12 +332,7 @@ do_make_header()
>  # usage: do_get_patch patchfile
>  do_get_patch()
>  {
> -	awk '
> -BEGIN{}
> -/^(diff |---$|--- )/ {patch = 1}
> -patch == 1 {print $0}
> -END{}
> -' < "$1"
> +	sed -n '/^diff /,$p' < "$1"

So, the thought behind this mess was to allow minimal patches to work.  The
'diff' line is *not* required by patch(1)!

Is it a problem if a patch description contains a line that starts with
'diff '?  (The current code has this issue as well.)

For the record, this ambiguity is what's on several occasions made me
consider splitting the header and the patch into separate files.  Yeah, it'd
be messier.  :/

>  }
>  
>  # usage: do_get_header patchfile
> -- 
> 1.8.3.1
> 

-- 
Defenestration n. (formal or joc.):
  The act of removing Windows from your computer in disgust, usually
  followed by the installation of Linux or some other Unix-like operating
  system.
