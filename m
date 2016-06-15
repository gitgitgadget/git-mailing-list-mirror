From: Jeff Sipek <jeffpc@josefsipek.net>
Subject: Re: [GUILT] [PATCH]  get rid of "cat: write error: Broken pipe"
 error message
Date: Tue, 13 Mar 2012 09:41:46 -0400
Message-ID: <20120313134146.GA1807@poseidon.cudanet.local>
References: <4F5F4E20.6000706@opera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Per Cederqvist <cederp@opera.com>
X-From: git-owner@vger.kernel.org Tue Mar 13 14:50:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7S7r-00026C-Ip
	for gcvg-git-2@plane.gmane.org; Tue, 13 Mar 2012 14:50:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754330Ab2CMNuu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Mar 2012 09:50:50 -0400
Received: from josefsipek.net ([64.9.206.49]:41317 "EHLO josefsipek.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754086Ab2CMNuu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Mar 2012 09:50:50 -0400
X-Greylist: delayed 515 seconds by postgrey-1.27 at vger.kernel.org; Tue, 13 Mar 2012 09:50:49 EDT
Received: from poseidon.cudanet.local (unknown [12.200.95.45])
	by josefsipek.net (Postfix) with ESMTPSA id 9140F6414;
	Tue, 13 Mar 2012 09:42:13 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <4F5F4E20.6000706@opera.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193026>

Looks good!

Thanks,

Jeff.

On Tue, Mar 13, 2012 at 02:39:44PM +0100, Per Cederqvist wrote:
> In some circumstances (like running guilt in a M-x shell buffer in
> Emacs) cat may give the above error message when the reader of the
> output from cat exits without reading all input from cat.  (In other
> circumstances cat is just silently terminated with SIGPIPE.)
> 
> Get rid of the error by removing the useless use of cat in
> do_get_header and do_get_full_header.
> 
> Signed-off-by: Per Cederqvist <cederp@opera.com>
> ---
>  guilt |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/guilt b/guilt
> index d1e17d4..7f6806e 100755
> --- a/guilt
> +++ b/guilt
> @@ -359,7 +359,7 @@ do_get_header()
>  	# 4th line skips any empty lines thereafter.
>  	# 5th line turns off empty line skip upon seeing a non-empty line.
>  	# 6th line terminates execution when we encounter the diff
> -	cat "$1" | awk '
> +	awk '
>  BEGIN{body=0; subj=0}
>  /^Subject:/ && (body == 0 && subj == 0){subj=1; print substr($0,
> 10) "\n"; next}
>  /^(Subject:|From:|Author:|Date:|commit)/ && (body == 0){next}
> @@ -369,7 +369,7 @@ BEGIN{body=0; subj=0}
>  /^(diff |---$|--- )/{exit}
>  {print $0}
>  END{}
> -'
> +' < "$1"
>  }
> 
>  # usage: do_get_full_header patchfile
> @@ -377,12 +377,12 @@ do_get_full_header()
>  {
>  	# 2nd line checks for the begining of a patch
>  	# 3rd line outputs the line if it didn't get pruned by the above rules
> -	cat "$1" | awk '
> +	awk '
>  BEGIN{}
>  /^(diff |---$|--- )/{exit}
>  {print $0}
>  END{}
> -'
> +' < "$1"
>  }
> 
>  # usage: assert_head_check
> -- 
> 1.7.9
> 

-- 
Si hoc legere scis nimium eruditionis habes.
