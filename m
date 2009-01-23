From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Change octal literals to be XEmacs friendly
Date: Fri, 23 Jan 2009 00:09:04 -0800
Message-ID: <7vbpty1m1r.fsf@gitster.siamese.dyndns.org>
References: <871vuwbnio.fsf@linmac.oyster.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Alexandre Julliard <julliard@winehq.org>
To: malc@pulsesoft.com, Vassili Karpov <av1474@comtv.ru>
X-From: git-owner@vger.kernel.org Fri Jan 23 09:10:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQH7e-0001pH-4A
	for gcvg-git-2@gmane.org; Fri, 23 Jan 2009 09:10:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753571AbZAWIJN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2009 03:09:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753419AbZAWIJN
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jan 2009 03:09:13 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:41713 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753363AbZAWIJM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2009 03:09:12 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 4CB9493557;
	Fri, 23 Jan 2009 03:09:12 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 6EDCE93556; Fri,
 23 Jan 2009 03:09:06 -0500 (EST)
In-Reply-To: <871vuwbnio.fsf@linmac.oyster.ru> (malc@pulsesoft.com's message
 of "Wed, 21 Jan 2009 20:02:39 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 1E5652A0-E925-11DD-AC27-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106854>

malc@pulsesoft.com writes:

> case uses eql and (eql ?\001 1) evaluates to nil under XEmacs
> (probably because some internal type of ?\001 is char)

And I presume the new way to spell is compatible with non XEmacs emacs?
It may be obvious to you, but please spell it out.  Parenthesized
"probably" does not help building the confidence in the patch either.

> Signed-off-by: Vassili Karpov <av1474@comtv.ru>

How are the (nameless) author of the patch malc@pulsesoft.com and Vassili
Karpov, the person who signed off, related?

Next time, please spend a few minutes to see if there are active
developers who are familiar in the area you are touching, and Cc your
patch to ask their input.

    git blame -L562,+29 contrib/emacs/git.el

tells me that most of this came from 40f162b (git.el: Display file types
and type changes., 2008-01-06) by Alexandre, so I am Cc'ing him.

> ---
>  contrib/emacs/git.el |   30 +++++++++++++++---------------
>  1 files changed, 15 insertions(+), 15 deletions(-)
>
> diff --git a/contrib/emacs/git.el b/contrib/emacs/git.el
> index 09e8bae..715580a 100644
> --- a/contrib/emacs/git.el
> +++ b/contrib/emacs/git.el
> @@ -562,29 +562,29 @@ the process output as a string, or nil if the git command failed."
>    (let* ((old-type (lsh (or old-perm 0) -9))
>          (new-type (lsh (or new-perm 0) -9))
>          (str (case new-type
> -               (?\100  ;; file
> +               (#o100  ;; file
>                  (case old-type
> -                  (?\100 nil)
> -                  (?\120 "   (type change symlink -> file)")
> -                  (?\160 "   (type change subproject -> file)")))
> -                (?\120  ;; symlink
> +                  (#o100 nil)
> +                  (#o120 "   (type change symlink -> file)")
> +                  (#o160 "   (type change subproject -> file)")))
> +                (#o120  ;; symlink
>                   (case old-type
> -                   (?\100 "   (type change file -> symlink)")
> -                   (?\160 "   (type change subproject -> symlink)")
> +                   (#o100 "   (type change file -> symlink)")
> +                   (#o160 "   (type change subproject -> symlink)")
>                     (t "   (symlink)")))
> -                 (?\160  ;; subproject
> +                 (#o160  ;; subproject
>                    (case old-type
> -                    (?\100 "   (type change file -> subproject)")
> -                    (?\120 "   (type change symlink -> subproject)")
> +                    (#o100 "   (type change file -> subproject)")
> +                    (#o120 "   (type change symlink -> subproject)")
>                      (t "   (subproject)")))
> -                  (?\110 nil)  ;; directory (internal, not a real git state)
> -                 (?\000  ;; deleted or unknown
> +                  (#o110 nil)  ;; directory (internal, not a real git state)
> +                 (#o000  ;; deleted or unknown
>                    (case old-type
> -                    (?\120 "   (symlink)")
> -                    (?\160 "   (subproject)")))
> +                    (#o120 "   (symlink)")
> +                    (#o160 "   (subproject)")))
>                   (t (format "   (unknown type %o)" new-type)))))
>      (cond (str (propertize str 'face 'git-status-face))
> -          ((eq new-type ?\110) "/")
> +          ((eq new-type #o110) "/")
>            (t ""))))
>  
>  (defun git-rename-as-string (info)
>
> -- 
> mailto:av1474@comtv.ru
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
