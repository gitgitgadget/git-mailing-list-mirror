From: Alexandre Julliard <julliard@winehq.org>
Subject: Re: git emacs mode patch
Date: Sat, 17 Mar 2007 11:04:25 +0100
Message-ID: <87y7lwxk2e.fsf@wine.dyndns.org>
References: <200703151403.56552.mega@retes.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?G=C3=A1bor?= Melis <mega@retes.hu>
X-From: git-owner@vger.kernel.org Sat Mar 17 11:04:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HSVm6-0007gT-7M
	for gcvg-git@gmane.org; Sat, 17 Mar 2007 11:04:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933681AbXCQKEb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 17 Mar 2007 06:04:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933691AbXCQKEb
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Mar 2007 06:04:31 -0400
Received: from mail.codeweavers.com ([216.251.189.131]:40514 "EHLO
	mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933681AbXCQKEa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 17 Mar 2007 06:04:30 -0400
Received: from adsl-84-227-0-184.adslplus.ch ([84.227.0.184] helo=wine.dyndns.org)
	by mail.codeweavers.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1HSVm0-0000jI-DI; Sat, 17 Mar 2007 04:04:28 -0600
Received: by wine.dyndns.org (Postfix, from userid 1000)
	id B865D109F1C; Sat, 17 Mar 2007 11:04:25 +0100 (CET)
In-Reply-To: <200703151403.56552.mega@retes.hu> (=?utf-8?Q?G=C3=A1bor?=
 Melis's message of "Thu\, 15 Mar 2007 14\:03\:56 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.93 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42428>

G=C3=A1bor Melis <mega@retes.hu> writes:

> +(defcustom git-hide-unknown t
> +  "Hide files with unknown status by default."
> +  :group 'git
> +  :type 'boolean)

This one should default to nil for backwards compatibility.

> @@ -1017,15 +1028,18 @@ and returns the process output as a string."
>        (with-temp-buffer
>          (git-run-command t nil "diff-index" "-z" "-M" "HEAD")
>          (git-parse-status status)))
> +    (unless (member 'up-to-date hidden-statuses)
>        (with-temp-buffer
> -        (git-run-command t nil "ls-files" "-z" "-u")
> -        (git-parse-ls-unmerged status))
> +        (git-run-command t nil "ls-files" "-z" "-t")
> +        (git-parse-ls-files status 'unknown)))
> +    (unless (member 'unknown hidden-statuses)

Why are you removing the ls-files -u?  This will break the detection
of unmerged files.

> +(defun git-toggle-up-to-date ()
> +  (interactive)
> +  (if (member 'up-to-date hidden-statuses)
> +      (setq hidden-statuses (remove 'up-to-date hidden-statuses))
> +    (push 'up-to-date hidden-statuses))

The status should be named 'uptodate instead of 'up-to-date since
that's what's used for individual files. Having two different
spellings for the same word would be very confusing.

--=20
Alexandre Julliard
julliard@winehq.org
