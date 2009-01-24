From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Change octal literals to be XEmacs friendly
Date: Fri, 23 Jan 2009 17:31:08 -0800
Message-ID: <7vocxxpk0z.fsf@gitster.siamese.dyndns.org>
References: <Pine.LNX.4.64.0901240219530.19590@linmac.oyster.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Alexandre Julliard <julliard@winehq.org>
To: Vassili Karpov <av1474@comtv.ru>
X-From: git-owner@vger.kernel.org Sat Jan 24 02:32:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQXOA-0005sQ-V1
	for gcvg-git-2@gmane.org; Sat, 24 Jan 2009 02:32:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753653AbZAXBbR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2009 20:31:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753625AbZAXBbQ
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jan 2009 20:31:16 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:40645 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753549AbZAXBbQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2009 20:31:16 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 2440E92AA6;
	Fri, 23 Jan 2009 20:31:15 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id AA37192AA5; Fri,
 23 Jan 2009 20:31:10 -0500 (EST)
In-Reply-To: <Pine.LNX.4.64.0901240219530.19590@linmac.oyster.ru> (Vassili
 Karpov's message of "Sat, 24 Jan 2009 02:20:52 +0300 (MSK)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B0D9B522-E9B6-11DD-A070-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106941>

Vassili Karpov <av1474@comtv.ru> writes:

Please don't use "format=flowed"; your patch is whitespace damaged and
does not apply.

> The type-of ?\octal in XEmacs is character while in FSF Emacs it is
> integer. Case expression using this syntax will not work correctly on
> XEmacs. #ooctal syntax on the other hand produces integers everywhere.
>
> Signed-off-by: Vassili Karpov <av1474@comtv.ru>
> ---
>  contrib/emacs/git.el |   30 +++++++++++++++---------------
>  1 files changed, 15 insertions(+), 15 deletions(-)
>
> diff --git a/contrib/emacs/git.el b/contrib/emacs/git.el
> index 09e8bae..715580a 100644
> --- a/contrib/emacs/git.el
> +++ b/contrib/emacs/git.el
> @@ -562,29 +562,29 @@ the process output as a string, or nil if the
> git command failed."
>    (let* ((old-type (lsh (or old-perm 0) -9))
>  	 (new-type (lsh (or new-perm 0) -9))
>  	 (str (case new-type
> -		(?\100  ;; file
> +		(#o100  ;; file
>  		 (case old-type
> -		   (?\100 nil)
> -		   (?\120 "   (type change symlink -> file)")
> -		   (?\160 "   (type change subproject -> file)")))
> -		 (?\120  ;; symlink
> +		   (#o100 nil)
> +		   (#o120 "   (type change symlink -> file)")
> +		   (#o160 "   (type change subproject -> file)")))
> +		 (#o120  ;; symlink
>  		  (case old-type
> -		    (?\100 "   (type change file -> symlink)")
> -		    (?\160 "   (type change subproject -> symlink)")
> +		    (#o100 "   (type change file -> symlink)")
> +		    (#o160 "   (type change subproject -> symlink)")
>  		    (t "   (symlink)")))
> -		  (?\160  ;; subproject
> +		  (#o160  ;; subproject
>  		   (case old-type
> -		     (?\100 "   (type change file -> subproject)")
> -		     (?\120 "   (type change symlink -> subproject)")
> +		     (#o100 "   (type change file -> subproject)")
> +		     (#o120 "   (type change symlink -> subproject)")
>  		     (t "   (subproject)")))
> -                  (?\110 nil)  ;; directory (internal, not a real git
> state)
> -		  (?\000  ;; deleted or unknown
> +                  (#o110 nil)  ;; directory (internal, not a real git
> state)
> +		  (#o000  ;; deleted or unknown
>  		   (case old-type
> -		     (?\120 "   (symlink)")
> -		     (?\160 "   (subproject)")))
> +		     (#o120 "   (symlink)")
> +		     (#o160 "   (subproject)")))
>  		  (t (format "   (unknown type %o)" new-type)))))
>      (cond (str (propertize str 'face 'git-status-face))
> -          ((eq new-type ?\110) "/")
> +          ((eq new-type #o110) "/")
>            (t ""))))
>
>  (defun git-rename-as-string (info)
> -- 
> 1.6.0.2.GIT
>
>
>
> -- 
> mailto:av1474@comtv.ru
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
