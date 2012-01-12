From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] git-blame.el: Fix compilation warnings.
Date: Thu, 12 Jan 2012 10:26:41 -0600
Message-ID: <20120112162617.GA2479@burratino>
References: <2608010.fNV39qBMLu@descartes>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, davidk@lysator.liu.se,
	Sergei Organov <osv@javad.com>, Kevin Ryde <user42@zip.com.au>
To: =?utf-8?Q?R=C3=BCdiger?= Sonderfeld <ruediger@c-plusplus.de>
X-From: git-owner@vger.kernel.org Thu Jan 12 17:27:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RlNUP-0003uo-Hj
	for gcvg-git-2@lo.gmane.org; Thu, 12 Jan 2012 17:26:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752835Ab2ALQ0w convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Jan 2012 11:26:52 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:33823 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751269Ab2ALQ0v convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Jan 2012 11:26:51 -0500
Received: by yhjj63 with SMTP id j63so1011433yhj.19
        for <git@vger.kernel.org>; Thu, 12 Jan 2012 08:26:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=XK53gMtJbUUueyyHaAT4a6Fs+dwbVC8gd5ADtq1Nz4A=;
        b=lU/n/k/543eCzypNB3f8NpmPH3vsJu3Hnx6OKrH17gB3ug8abgVSDmnsJilxbuqg0s
         vELYQEF3pCQ1fJX/etY3YCB9nwP/lI4RCH9WtlvAixfhexUdkkuvD4wj5hPu+jUrITbF
         HqgsbT/lTK9rI5t723XzjygYQUEZakV39vptA=
Received: by 10.236.145.234 with SMTP id p70mr6536463yhj.88.1326385611279;
        Thu, 12 Jan 2012 08:26:51 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id m10sm10107397ank.19.2012.01.12.08.26.49
        (version=SSLv3 cipher=OTHER);
        Thu, 12 Jan 2012 08:26:50 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <2608010.fNV39qBMLu@descartes>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188451>

(+cc: Sergei, Kevin)
Hi,

R=C3=BCdiger Sonderfeld wrote:

> From 4958c1b43d7a66654e15c92cbb878b38533d626e Mon Sep 17 00:00:00 200=
1
> From: =3D?UTF-8?q?R=3DC3=3DBCdiger=3D20Sonderfeld?=3D <ruediger@c-plu=
splus.de>
[...]

These lines should be left out [*].

> Replace mapcar with mapc because accumulation of the results was not
> needed. (git-blame-cleanup)
>
> Replace two occurrences of (save-excursion (set-buffer buf) ...)
> with (with-current-buffer buf ...). (git-blame-filter and
> git-blame-create-overlay)
>
> Replace goto-line with (goto-char (point-min)) (forward-line (1-
> start-line)). According to the documentation of goto-line it should
> not be called from elisp code. (git-blame-create-overlay)
>
> Signed-off-by: R=C3=BCdiger Sonderfeld <ruediger@c-plusplus.de>

I assume this was prompted by warning messages like this one:

	In git-blame-cleanup:
	git-blame.el:306:6:Warning: `mapcar' called for effect; use `mapc' or =
`dolist' instead

Looks reasonable to my very much untrained eyes, and it's consistent
with the hints Kevin gave at [1].

Thanks,
Jonathan

[1] http://bugs.debian.org/cgi-bin/bugreport.cgi?msg=3D63;bug=3D611931
[*] The "From " line and following lines are for your mailer and can
be omited unless they differ from the mail header when reading your
patch into an email body.  See the DISCUSSION sections of
git-format-patch(1) and git-am(1) for more on this.

(patch left unsnipped for Sergei and Kevin's convenience)

> ---
>  contrib/emacs/git-blame.el |   10 ++++------
>  1 files changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/contrib/emacs/git-blame.el b/contrib/emacs/git-blame.el
> index d351cfb..2e53fc6 100644
> --- a/contrib/emacs/git-blame.el
> +++ b/contrib/emacs/git-blame.el
> @@ -304,7 +304,7 @@ See also function `git-blame-mode'."
> =20
>  (defun git-blame-cleanup ()
>    "Remove all blame properties"
> -    (mapcar 'delete-overlay git-blame-overlays)
> +    (mapc 'delete-overlay git-blame-overlays)
>      (setq git-blame-overlays nil)
>      (remove-git-blame-text-properties (point-min) (point-max)))
> =20
> @@ -337,8 +337,7 @@ See also function `git-blame-mode'."
>  (defvar in-blame-filter nil)
> =20
>  (defun git-blame-filter (proc str)
> -  (save-excursion
> -    (set-buffer (process-buffer proc))
> +  (with-current-buffer (process-buffer proc)
>      (goto-char (process-mark proc))
>      (insert-before-markers str)
>      (goto-char 0)
> @@ -385,11 +384,10 @@ See also function `git-blame-mode'."
>            info))))
> =20
>  (defun git-blame-create-overlay (info start-line num-lines)
> -  (save-excursion
> -    (set-buffer git-blame-file)
> +  (with-current-buffer git-blame-file
>      (let ((inhibit-point-motion-hooks t)
>            (inhibit-modification-hooks t))
> -      (goto-line start-line)
> +      (goto-char (point-min)) (forward-line (1- start-line))
>        (let* ((start (point))
>               (end (progn (forward-line num-lines) (point)))
>               (ovl (make-overlay start end))
