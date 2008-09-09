From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: Re: [PATCH] git.el: Add "git grep" functionality in a grep-style compilation buffer
Date: Tue, 09 Sep 2008 17:14:16 +0200
Message-ID: <87sks973nb.fsf@lysator.liu.se>
References: <1220122523-68561-1-git-send-email-david@endpoint.com>
	<871vzt8ydp.fsf@lysator.liu.se> <87d4jdcqyk.dlv@maison.homelinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, julliard@winehq.org,
	David Christensen <david@endpoint.com>
To: vanicat@debian.org (=?utf-8?Q?R=C3=A9mi?= Vanicat)
X-From: git-owner@vger.kernel.org Tue Sep 09 17:20:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kd4wM-0001b2-5v
	for gcvg-git-2@gmane.org; Tue, 09 Sep 2008 17:15:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753478AbYIIPOT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Sep 2008 11:14:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751442AbYIIPOT
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Sep 2008 11:14:19 -0400
Received: from mail.lysator.liu.se ([130.236.254.3]:54588 "EHLO
	mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753128AbYIIPOS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2008 11:14:18 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id 79680200AC60;
	Tue,  9 Sep 2008 17:14:17 +0200 (CEST)
Received: from mail.lysator.liu.se ([127.0.0.1])
	by localhost (lenin.lysator.liu.se [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 06655-01-33; Tue, 9 Sep 2008 17:14:17 +0200 (CEST)
Received: from krank (dns.vtab.com [62.20.90.195])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id D844D200A24D;
	Tue,  9 Sep 2008 17:14:16 +0200 (CEST)
Received: by krank (Postfix, from userid 1000)
	id 5D6077B4039; Tue,  9 Sep 2008 17:14:16 +0200 (CEST)
In-Reply-To: <87d4jdcqyk.dlv@maison.homelinux.org> (=?utf-8?Q?=22R=C3=A9mi?=
 Vanicat"'s message of "Tue\, 09 Sep 2008 16\:51\:47 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at lysator.liu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95397>

vanicat@debian.org (R=C3=A9mi Vanicat) writes:

> From: David K=C3=A5gedal <davidk@lysator.liu.se>
> Subject: [PATCH] [PATCH] git.el: Add a git-grep command
>
> This allows easy access to git grep from Emacs.
>
> Signed-off-by: David K=C3=A5gedal <davidk@lysator.liu.se>
> Tested-by: R=C3=A9mi Vanicat <vanicat@debian.org>
> ---
> David K=C3=A5gedal <davidk@lysator.liu.se> writes:
>
>> David Christensen <david@endpoint.com> writes:
>>
>>> Signed-off-by: David Christensen <david@endpoint.com>
>>
>> I posted a longer version of git-grep that built on the grep command=
s
>> in Emacs 22 a while ago. It gives you a better was to navigate to th=
e
>> hits etc. I'll dig it up again.
>
> Was it this one ?

Kindof. This seems to be an improved version that doesn't fail on
older emacsen and that adds a menu. I'm not sure who contributed that,
but it's probably also in some mail somewhere. I use this every day
(but without the improvements) and I think it is really useful.

> --=20
> R=C3=A9mi Vanicat
>  contrib/emacs/git.el |   52 ++++++++++++++++++++++++++++++++++++++++=
++++++++++
>  1 files changed, 52 insertions(+), 0 deletions(-)
>
> diff --git a/contrib/emacs/git.el b/contrib/emacs/git.el
> index c1cf1cb..57351a5 100644
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
> +       (list (read-from-minibuffer "Run: " "git grep "
> +                                   nil nil 'git-grep-history)
> +             nil))
> +       (t (let* ((regexp (grep-read-regexp))
> +                (files (grep-read-files regexp))
> +                (dir (read-directory-name "Base directory: "
> +                                          nil default-directory t)))
> +           (list regexp files dir)))))
> +    (when (and (stringp regexp) (> (length regexp) 0))
> +      (if (null files)
> +         (if (not (string=3D regexp grep-find-command))
> +             (compilation-start regexp 'grep-mode))
> +         (setq dir (file-name-as-directory (expand-file-name dir)))
> +         (let ((command (concat
> +                         "git grep -n "
> +                         "-e " (shell-quote-argument regexp)
> +                         (if (string=3D files "*")
> +                             ""
> +                             (concat " -- " (shell-quote-argument fi=
les))))))
> +           (when command
> +             (if current-prefix-arg
> +                 (setq command
> +                       (read-from-minibuffer "Confirm: "
> +                                             command nil nil 'git-gr=
ep-history))
> +                 (add-to-history 'git-grep-history command))
> +             (let ((default-directory dir))
> +               (compilation-start (concat "PAGER=3D " command) 'grep=
-mode))
> +             ;; Set default-directory if we started rgrep in the *gr=
ep* buffer.
> +             (if (eq next-error-last-buffer (current-buffer))
> +                 (setq default-directory dir))))))))
> +
>  (provide 'git)
>  ;;; git.el ends here

--=20
David K=C3=A5gedal
