From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git.el: Use git-add-file for unmerged files, remove
 git-resolve-file
Date: Tue, 08 Sep 2009 16:10:34 -0700
Message-ID: <7vtyzdrq1h.fsf@alter.siamese.dyndns.org>
References: <4AA026AC.10907@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Alexandre Julliard <julliard@winehq.org>
To: Martin Nordholts <enselic@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 09 01:11:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ml9qX-0000Ay-De
	for gcvg-git-2@lo.gmane.org; Wed, 09 Sep 2009 01:11:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752955AbZIHXKn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Sep 2009 19:10:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752956AbZIHXKn
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Sep 2009 19:10:43 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:49350 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752829AbZIHXKm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Sep 2009 19:10:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 29CE82ADEC;
	Tue,  8 Sep 2009 19:10:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MimMAT5D6vXMeavjuuytFxV5PFc=; b=mJZQiG
	sRl7C7hx0IfXc8PQrtq27TjvCwxTahNgLBgpKHyEKKk25taz0cjMkf1BTCq4S4gg
	9+Ly3DF/L47rKYkD01P+/GLNhuucVziKiFWZRa8lOSTX1y0/a7HnJoB1caeSs5kZ
	Wk9VmRM6K+klTNr/0pV/wBeghoNq8V4tL1mOw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=trNUpDuRS3k58yKPTZcIx2FPJ7499bfs
	BQ6MC9boM0mNhmUZV2jPTzp+MOFliU9jWGGQkPsVitFHG2jPeFFINCCDECXLUbtF
	2zlpT6aNJNmFjgv3R+zwqxKslCi8toOQ72VfLOYtat+9aheRc1y8NVjvDvzr5vh7
	HjLFyQoBVoU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id F36CE2ADE6;
	Tue,  8 Sep 2009 19:10:39 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1BF9D2ADE4; Tue,  8 Sep
 2009 19:10:35 -0400 (EDT)
In-Reply-To: <4AA026AC.10907@gmail.com> (Martin Nordholts's message of "Thu\,
 03 Sep 2009 22\:27\:24 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D348A7F2-9CCC-11DE-B783-A13518FFA523-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128048>

Martin Nordholts <enselic@gmail.com> writes:

> Use `git-add-file' to mark unmerged files as resolved in the
> *git-status* buffer to be consistent with git's CLI instructions. Also
> remove `git-resolve-file' to make it clear that that "R" is a now a
> free keybinding.

I do not know all the details of how Emacs keybinding works, but I had an
impression that something-x sequence is triggered if you type something-X
and you do not have an explicit binding for something-X but you do have a
binding for something-x.

IOW, if I only have

	(define-key global-map "\C-xc" 'compile)

then both "\C-xc" and "\C-xC" runs "compile", but in addition to the
above if I also have

	(define-key global-map "\C-xC" 'grep-find)

then I can invoke these two commands with lower- and upper- case 'c/C'
after control-x.

If people have been relying on the historical behaviour that typing "R"
marked the path resolved (which may internally have been implemented with
whatever way), and if you are removing that binding, wouldn't that now
expose them to whatever happens to be bound to "r"?

And worse, it is bound to git-remove-file.  Shouldn't you at least rebind
the "R" to something safer, like beep?

Am I grossly misunderstanding how Emacs keybindings work?  Is the
experiment I did in the initial part of the message with the global-map
relying on some "magic" that only appears in global-map, and there is no
problem doing this in the map this patch is about?

> Signed-off-by: Martin Nordholts <martinn@src.gnome.org>
> Acked-by: Alexandre Julliard <julliard@winehq.org>
> ---
>  contrib/emacs/git.el |   13 +------------
>  1 files changed, 1 insertions(+), 12 deletions(-)
>
> diff --git a/contrib/emacs/git.el b/contrib/emacs/git.el
> index 8c70ad8..214930a 100644
> --- a/contrib/emacs/git.el
> +++ b/contrib/emacs/git.el
> @@ -1046,7 +1046,7 @@ The FILES list must be sorted."
>  (defun git-add-file ()
>    "Add marked file(s) to the index cache."
>    (interactive)
> -  (let ((files (git-get-filenames (git-marked-files-state 'unknown 'ignored))))
> +  (let ((files (git-get-filenames (git-marked-files-state 'unknown 'ignored 'unmerged))))
>      ;; FIXME: add support for directories
>      (unless files
>        (push (file-relative-name (read-file-name "File to add: " nil nil t)) files))
> @@ -1119,15 +1119,6 @@ The FILES list must be sorted."
>                (when buffer (with-current-buffer buffer (revert-buffer t t t)))))
>            (git-success-message "Reverted" names))))))
>  
> -(defun git-resolve-file ()
> -  "Resolve conflicts in marked file(s)."
> -  (interactive)
> -  (let ((files (git-get-filenames (git-marked-files-state 'unmerged))))
> -    (when files
> -      (when (apply 'git-call-process-display-error "update-index" "--" files)
> -        (git-update-status-files files)
> -        (git-success-message "Resolved" files)))))
> -
>  (defun git-remove-handled ()
>    "Remove handled files from the status list."
>    (interactive)
> @@ -1556,7 +1547,6 @@ amended version of it."
>      (define-key map "P"   'git-prev-unmerged-file)
>      (define-key map "q"   'git-status-quit)
>      (define-key map "r"   'git-remove-file)
> -    (define-key map "R"   'git-resolve-file)
>      (define-key map "t"    toggle-map)
>      (define-key map "T"   'git-toggle-all-marks)
>      (define-key map "u"   'git-unmark-file)
> @@ -1598,7 +1588,6 @@ amended version of it."
>        ("Merge"
>  	["Next Unmerged File" git-next-unmerged-file t]
>  	["Prev Unmerged File" git-prev-unmerged-file t]
> -	["Mark as Resolved" git-resolve-file t]
>  	["Interactive Merge File" git-find-file-imerge t]
>  	["Diff Against Common Base File" git-diff-file-base t]
>  	["Diff Combined" git-diff-file-combined t]
> -- 
> 1.6.2.5
