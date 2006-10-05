From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] vc-git.el: Switch to using git-blame instead of git-annotate.
Date: Thu, 05 Oct 2006 02:34:30 -0700
Message-ID: <7v4pujf6mx.fsf@assigned-by-dhcp.cox.net>
References: <87k63f9kjf.fsf@wine.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 05 11:34:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GVPcg-0006KX-QG
	for gcvg-git@gmane.org; Thu, 05 Oct 2006 11:34:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751572AbWJEJec (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Oct 2006 05:34:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751573AbWJEJec
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Oct 2006 05:34:32 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:19959 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1751571AbWJEJeb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Oct 2006 05:34:31 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061005093431.GNYU16798.fed1rmmtao09.cox.net@fed1rmimpo02.cox.net>;
          Thu, 5 Oct 2006 05:34:31 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id WZaZ1V00L1kojtg0000000
	Thu, 05 Oct 2006 05:34:34 -0400
To: Alexandre Julliard <julliard@winehq.org>
In-Reply-To: <87k63f9kjf.fsf@wine.dyndns.org> (Alexandre Julliard's message of
	"Thu, 05 Oct 2006 11:30:44 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28352>

Alexandre Julliard <julliard@winehq.org> writes:

> Signed-off-by: Alexandre Julliard <julliard@winehq.org>
> ---
>  contrib/emacs/vc-git.el |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/contrib/emacs/vc-git.el b/contrib/emacs/vc-git.el
> index 4a8f790..4189c4c 100644
> --- a/contrib/emacs/vc-git.el
> +++ b/contrib/emacs/vc-git.el
> @@ -119,10 +119,10 @@ (defun vc-git-checkout (file &optional e
>  (defun vc-git-annotate-command (file buf &optional rev)
>    ; FIXME: rev is ignored
>    (let ((name (file-relative-name file)))
> -    (call-process "git" nil buf nil "annotate" name)))
> +    (call-process "git" nil buf nil "blame" name)))

"blame -c" is advertised to give the same format as "annotate",
so I think you would not need other hunk if you did.

>  (defun vc-git-annotate-time ()
> -  (and (re-search-forward "[0-9a-f]+\t(.*\t\\([0-9]+\\)-\\([0-9]+\\)-\\([0-9]+\\) \\([0-9]+\\):\\([0-9]+\\):\\([0-9]+\\) \\([-+0-9]+\\)\t[0-9]+)" nil t)
> +  (and (re-search-forward "[0-9a-f]+ (.* \\([0-9]+\\)-\\([0-9]+\\)-\\([0-9]+\\) \\([0-9]+\\):\\([0-9]+\\):\\([0-9]+\\) \\([-+0-9]+\\) +[0-9]+)" nil t)
>         (vc-annotate-convert-time
>          (apply #'encode-time (mapcar (lambda (match) (string-to-number (match-string match))) '(6 5 4 3 2 1 7))))))

Not that I am preferring the annotate output format over blame's
native output format.  I just wanted to know if the reason you
did not do -c was because you tried and "blame -c" was not
compatible as advertised (in which case we have one more thing
to fix).
