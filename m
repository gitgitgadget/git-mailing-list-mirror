From: Ryan Anderson <ryan@michonline.com>
Subject: Re: [PATCH] git-send-email.perl extract_valid_address issue
Date: Mon, 29 May 2006 13:00:27 -0700
Message-ID: <20060529200026.GA32457@h4x0r5.com>
References: <200605290000.44463.ntroncos@alumnos.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 29 22:01:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FknvZ-0007gx-DB
	for gcvg-git@gmane.org; Mon, 29 May 2006 22:01:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751249AbWE2UBU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 May 2006 16:01:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751256AbWE2UBU
	(ORCPT <rfc822;git-outgoing>); Mon, 29 May 2006 16:01:20 -0400
Received: from h4x0r5.com ([70.85.31.202]:28939 "EHLO h4x0r5.com")
	by vger.kernel.org with ESMTP id S1751249AbWE2UBU (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 May 2006 16:01:20 -0400
Received: from ryan by h4x0r5.com with local (Exim 4.50)
	id 1Fknue-0008Ul-67; Mon, 29 May 2006 13:00:28 -0700
To: Nicolas Troncoso Carrere <ntroncos@alumnos.inf.utfsm.cl>
Content-Disposition: inline
In-Reply-To: <200605290000.44463.ntroncos@alumnos.inf.utfsm.cl>
User-Agent: Mutt/1.5.9i
X-michonline.com-MailScanner: Found to be clean
X-michonline.com-MailScanner-From: ryan@h4x0r5.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20967>

On Mon, May 29, 2006 at 12:00:44AM -0400, Nicolas Troncoso Carrere wrote:
> 
> The third fallback was returning if the match was done or not instead of
> returning the actual email address that was matched. This prevented sending
> the mail to the people included in the CC. This bug only affect those that
> dont have Email::Valid.
> 
> I initialized $valid_email as undef so it would mimic the behavior of 
> Email::Verify->address(), which returns undef if no valid address was found.

Odd, I noticed the same thing this weekend.

> Signed-off-by: Nicolas <ntroncos@inf.utfsm.cl>
Acked-by: Ryan Anderson <ryan@michonline.com>

(Or pick up my patch that fixes this in a slightly different way)

> 
> 
> ---
> 
>  git-send-email.perl |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
> 
> 84853ca89c15de7a24e9eb9fd422654b86c63be9
> diff --git a/git-send-email.perl b/git-send-email.perl
> index 312a4ea..dfff3e6 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -316,7 +316,9 @@ sub extract_valid_address {
>  	} else {
>  		# less robust/correct than the monster regexp in Email::Valid,
>  		# but still does a 99% job, and one less dependency
> -		return ($address =~ /([^\"<>\s]+@[^<>\s]+)/);
> +                my $valid_email=undef;
> +                ($valid_email ) = ($address =~ /([^\"<>\s]+@[^<>\s]+)/);
> +                return ($valid_email);
>  	}
>  }
> -- 
> Nicol?s Troncoso Carr?re                        User #272312 counter.li.org
> Estudiante Mag?ster en Ciencias de la Inform?tica
> Universidad T?cnica Federico Santa Mar?a
> http://www.alumnos.inf.utfsm.cl/~ntroncos
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
