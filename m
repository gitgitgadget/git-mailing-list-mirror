From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] emacs: make 'git-status' work with separate git dirs
Date: Sat, 24 Nov 2012 22:22:32 -0800
Message-ID: <7v4nkeyzfb.fsf@alter.siamese.dyndns.org>
References: <1353599934-23222-1-git-send-email-enrico.scholz@sigma-chemnitz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
To: Alexandre Julliard <julliard@winehq.org>
X-From: git-owner@vger.kernel.org Sun Nov 25 07:31:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TcVk6-00076V-Bj
	for gcvg-git-2@plane.gmane.org; Sun, 25 Nov 2012 07:31:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750975Ab2KYGWh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Nov 2012 01:22:37 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61133 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750850Ab2KYGWg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Nov 2012 01:22:36 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 75DA469E8;
	Sun, 25 Nov 2012 01:22:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cBOn5q50zvUroZdg92WpbfT40QY=; b=g/9wO0
	XR/0VWi7Dc8SIQbvA7Ofo3N36sfj4ATXygi1tm+ENwdvCc7ePulsite1r2gvqxDw
	vwzCGib6uB1GdoIzzmaLk/DbdA+cZ/TCrY5zB2IUs1nW0II6Dg6/UHaIo9qM8oyL
	+Y+u/VsDrhqFilyPkXsWlzoYjBcePXiQEhWrc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SqXAJ9ePTXGMM2N2/yInoGU6Bd1pRKPZ
	pvL9rd9GdAwpVCUAfc6mk2Ay+idpojSPczpgarFL162ogrR1H1msKqx9uu3GEWLE
	224B4ccShwrTO9EAkGv9FoQE+T8oNS6dpGj+Q2yWSmSW2pAnsoM22vnsHYWAu/fV
	lo/lzD268Yk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6394069E7;
	Sun, 25 Nov 2012 01:22:35 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C4E1569E5; Sun, 25 Nov 2012
 01:22:34 -0500 (EST)
In-Reply-To: <1353599934-23222-1-git-send-email-enrico.scholz@sigma-chemnitz.de> (Enrico
 Scholz's message of "Thu, 22 Nov 2012 16:58:54 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8048B8F0-36C8-11E2-955D-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210332>

Enrico Scholz <enrico.scholz@sigma-chemnitz.de> writes:

> when trying 'M-x git-status' in a submodule created with recent (1.7.5+)
> git, the command fails with
>
> | ... is not a git working tree
>
> This is caused by creating submodules with '--separate-git-dir' but
> still checking for a working tree by testing for a '.git' directory.
>
> The patch fixes this by relaxing the existing detection a little bit.
>
> Signed-off-by: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
> ---

This script already relies on the assumption that nobody sane would
create a directory named ".git" that is not a git repository, and
this loosens the assumption that nobody would create a file named
".git", either.  So I would think it is a sane thing to do, but just
in case if the area expert has better ideas, I am forwarding it.

Ack?

>  contrib/emacs/git.el | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/contrib/emacs/git.el b/contrib/emacs/git.el
> index 65c95d9..5ffc506 100644
> --- a/contrib/emacs/git.el
> +++ b/contrib/emacs/git.el
> @@ -1671,7 +1671,7 @@ Commands:
>    "Entry point into git-status mode."
>    (interactive "DSelect directory: ")
>    (setq dir (git-get-top-dir dir))
> -  (if (file-directory-p (concat (file-name-as-directory dir) ".git"))
> +  (if (file-exists-p (concat (file-name-as-directory dir) ".git"))
>        (let ((buffer (or (and git-reuse-status-buffer (git-find-status-buffer dir))
>                          (create-file-buffer (expand-file-name "*git-status*" dir)))))
>          (switch-to-buffer buffer)
