From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [RFH PATCH] Teach the emacs git mode about core.excludesfile
Date: Tue, 31 Jul 2007 03:58:23 +0200
Message-ID: <vpqzm1dqqps.fsf@bauges.imag.fr>
References: <20070731011100.23561.27554.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Alexandre Julliard <julliard@winehq.org>, git@vger.kernel.org
To: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Tue Jul 31 03:58:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFh0X-0003Jw-Li
	for gcvg-git@gmane.org; Tue, 31 Jul 2007 03:58:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932650AbXGaB6m convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 30 Jul 2007 21:58:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932174AbXGaB6m
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jul 2007 21:58:42 -0400
Received: from imag.imag.fr ([129.88.30.1]:54914 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1765678AbXGaB6l (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2007 21:58:41 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id l6V1wNJS016088
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 31 Jul 2007 03:58:23 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1IFh0B-0004LP-7z; Tue, 31 Jul 2007 03:58:23 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1IFh0B-0001lx-5Z; Tue, 31 Jul 2007 03:58:23 +0200
Mail-Followup-To: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>,
 Alexandre Julliard <julliard@winehq.org>,  git@vger.kernel.org
In-Reply-To: <20070731011100.23561.27554.stgit@yoghurt> ("Karl
 =?iso-8859-1?Q?Hasselstr=F6m=22's?= message of "Tue\, 31 Jul 2007
 03\:13\:50 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.97 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Tue, 31 Jul 2007 03:58:23 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54308>

Karl Hasselstr=F6m <kha@treskal.com> writes:

> If there is a core.excludesfile option specified, let the emacs git
> mode take exclude patterns from that file, since that's what the docs
> say, and what everyone else is already doing.
>
> Signed-off-by: Karl Hasselstr=F6m <kha@treskal.com>
> ---
>
> This is a Request For Help. The patch works, but is clearly the work
> of someone who is not very fluent in elisp. Just look at all that
> duplicated code I've introduced!
>
>  contrib/emacs/git.el |   19 ++++++++++++++++---
>  1 files changed, 16 insertions(+), 3 deletions(-)
>
> diff --git a/contrib/emacs/git.el b/contrib/emacs/git.el
> index 53dd703..357e6d2 100644
> --- a/contrib/emacs/git.el
> +++ b/contrib/emacs/git.el
> @@ -589,6 +589,13 @@ Return the list of files that haven't been handl=
ed."
>            (when node (push (ewoc-data node) unmerged-files))))
>        (git-set-files-state unmerged-files 'unmerged))))
> =20
> +(defun git-core-excludesfile ()
> +  "The file core.excludesfile, or nil if it isn't specified."
> +  (let ((fn (git-config "core.excludesfile")))
> +    (if (and fn (file-readable-p fn))
> +        fn
> +      nil)))
> +
>  (defun git-update-status-files (files &optional default-state)
>    "Update the status of FILES from the index."
>    (unless git-status (error "Not in git-status buffer."))
> @@ -600,9 +607,15 @@ Return the list of files that haven't been handl=
ed."
>      (git-run-ls-unmerged status files)
>      (when (and (or (not files) remaining-files)
>                 (file-readable-p ".git/info/exclude"))
> -      (setq remaining-files (git-run-ls-files status remaining-files
> -                                              'unknown "-o" "--exclu=
de-from=3D.git/info/exclude"
> -                                              (concat "--exclude-per=
-directory=3D" git-per-dir-ignore-file))))

What you're looking for probably looks like that:

         (let ((ce (git-core-excludesfile)))
           (setq remaining-files (apply 'git-run-ls-files=20
                                      `(,status ,remaining-files
                                        unknown "-o" ... ,@(when ce
                                                             (list ce))=
))))

(the magic is in the backquote and the ,@ in `(... ,@(...)))

(totally untested, probably bogus)

--=20
Matthieu
