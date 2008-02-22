From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: Re: [PATCH] git.el: Add a git-grep command
Date: Fri, 22 Feb 2008 12:43:41 +0100
Message-ID: <877igx9pxu.fsf@lysator.liu.se>
References: <87odaa4tcl.fsf@lysator.liu.se>
	<m3myptcqji.fsf@localhost.localdomain> <87tzk19wn5.fsf@lysator.liu.se>
	<200802221121.35706.jnareb@gmail.com> <87ir0h9soh.fsf@lysator.liu.se>
	<87d4qpgs9y.dlv@maison.homelinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Alexandre Julliard <julliard@winehq.org>,
	Jakub Narebski <jnareb@gmail.com>
To: Remi Vanicat <vanicat@debian.org>
X-From: git-owner@vger.kernel.org Fri Feb 22 12:44:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSWKE-0003op-ES
	for gcvg-git-2@gmane.org; Fri, 22 Feb 2008 12:44:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754453AbYBVLnd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Feb 2008 06:43:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754489AbYBVLnd
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Feb 2008 06:43:33 -0500
Received: from mail.lysator.liu.se ([130.236.254.3]:36856 "EHLO
	mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751552AbYBVLnc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Feb 2008 06:43:32 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id 4DB4B200A24F;
	Fri, 22 Feb 2008 12:43:31 +0100 (CET)
Received: from mail.lysator.liu.se ([127.0.0.1])
	by localhost (lenin.lysator.liu.se [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 20167-01-38; Fri, 22 Feb 2008 12:43:30 +0100 (CET)
Received: from krank (oden.vtab.com [62.20.90.195])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id C224B200A1EA;
	Fri, 22 Feb 2008 12:43:30 +0100 (CET)
Received: by krank (Postfix, from userid 1000)
	id 36E747B4078; Fri, 22 Feb 2008 12:43:41 +0100 (CET)
In-Reply-To: <87d4qpgs9y.dlv@maison.homelinux.org> (Remi Vanicat's message of "Fri\, 22 Feb 2008 12\:11\:21 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at lysator.liu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74719>

Remi Vanicat <vanicat@debian.org> writes:

> Here is a modification with inclusion of git-grep only when the grep
> library is available.=20

Nice. I didn't even know that require had more parameters. But I'd
write nil instead of () in this case.

> To put it in another file might be a good idea to, but in this case,
> may be we could break this huge 1786 file in several smaller file.
>
> From 403143a61bf8f77d042893765b19cf7cc7062e59 Mon Sep 17 00:00:00 200=
1
> From: David K=C3=A5gedal <davidk@lysator.liu.se>
> Date: Fri, 22 Feb 2008 11:57:25 +0100
> Subject: [PATCH] git.el: Add a git-grep command
> MIME-Version: 1.0
> Content-Type: text/plain; charset=3Dutf-8
> Content-Transfer-Encoding: 8bit
>
> This allows easy access to git grep from Emacs.
>
> Signed-off-by: David K=C3=A5gedal <davidk@lysator.liu.se>
> Signed-off-by: R=C3=A9mi Vanicat <vanicat@debian.org>
> ---
>  contrib/emacs/git.el |   52 ++++++++++++++++++++++++++++++++++++++++=
++++++++++
>  1 files changed, 52 insertions(+), 0 deletions(-)
>
> diff --git a/contrib/emacs/git.el b/contrib/emacs/git.el
> index f69b697..afaf187 100644
> --- a/contrib/emacs/git.el
> +++ b/contrib/emacs/git.el
> @@ -49,6 +49,7 @@
>  (require 'ewoc)
>  (require 'log-edit)
>  (require 'easymenu)
> +(require 'grep () t)
> =20
> =20
>  ;;;; Customizations
> @@ -1496,6 +1497,7 @@ amended version of it."
>        ["Diff File" git-diff-file t]
>        ["Interactive Diff File" git-diff-file-idiff t]
>        ["Log" git-log-file t]
> +      ,@(if (featurep 'grep) (list ["Grep" git-grep t]) ())
>        "--------"
>        ["Mark" git-mark-file t]
>        ["Mark All" git-mark-all t]
> @@ -1584,5 +1586,55 @@ Meant to be used in `after-save-hook'."
>    (interactive)
>    (describe-function 'git-status-mode))
> =20
> +(when (featurep 'grep)
> +  (defvar git-grep-history nil)
> +
> +  (defun git-grep (regexp &optional files dir)
> +    "Recursively grep for REGEXP in FILES in directory tree rooted a=
t DIR.
> +The search is limited to file names matching shell pattern FILES.
> +FILES may use abbreviations defined in `grep-files-aliases', e.g.
> +entering `ch' is equivalent to `*.[ch]'.
> +
> +With \\[universal-argument] prefix, you can edit the constructed she=
ll command line
> +before it is executed.
> +With two \\[universal-argument] prefixes, directly edit and run `git=
-grep-find-command'.
> +
> +Collect output in a buffer.  While find runs asynchronously, you
> +can use \\[next-error] (M-x next-error), or \\<grep-mode-map>\\[comp=
ile-goto-error]
> +in the grep output buffer, to go to the lines where grep found match=
es."
> +    (interactive
> +     (cond
> +       ((equal current-prefix-arg '(16))
> +	(list (read-from-minibuffer "Run: " "git grep "
> +				    nil nil 'git-grep-history)
> +	      nil))
> +       (t (let* ((regexp (grep-read-regexp))
> +		 (files (grep-read-files regexp))
> +		 (dir (read-directory-name "Base directory: "
> +					   nil default-directory t)))
> +	    (list regexp files dir)))))
> +    (when (and (stringp regexp) (> (length regexp) 0))
> +      (if (null files)
> +	  (if (not (string=3D regexp grep-find-command))
> +	      (compilation-start regexp 'grep-mode))
> +	  (setq dir (file-name-as-directory (expand-file-name dir)))
> +	  (let ((command (concat
> +			  "git grep -n "
> +			  "-e " (shell-quote-argument regexp)
> +			  (if (string=3D files "*")
> +			      ""
> +			      (concat " -- " (shell-quote-argument files))))))
> +	    (when command
> +	      (if current-prefix-arg
> +		  (setq command
> +			(read-from-minibuffer "Confirm: "
> +					      command nil nil 'git-grep-history))
> +		  (add-to-history 'git-grep-history command))
> +	      (let ((default-directory dir))
> +		(compilation-start (concat "PAGER=3D " command) 'grep-mode))
> +	      ;; Set default-directory if we started rgrep in the *grep* bu=
ffer.
> +	      (if (eq next-error-last-buffer (current-buffer))
> +		  (setq default-directory dir))))))))
> +
>  (provide 'git)
>  ;;; git.el ends here
> --=20
> 1.5.4.2.191.g7b407

--=20
David K=C3=A5gedal
