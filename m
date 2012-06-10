From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH_v1] add 'git credential' plumbing command
Date: Sat, 09 Jun 2012 23:53:11 -0700
Message-ID: <7vzk8baca0.fsf@alter.siamese.dyndns.org>
References: <1339267502-13803-1-git-send-email-Javier.Roucher-Iglesias@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Javier Roucher <jroucher@gmail.com>,
	Pavel Volek <Pavel.Volek@ensimag.imag.fr>,
	NGUYEN Kim Thuat <Kim-Thuat.Nguyen@ensimag.imag.fr>,
	ROUCHER IGLESIAS Javier <roucherj@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: Javier.Roucher-Iglesias@ensimag.imag.fr
X-From: git-owner@vger.kernel.org Sun Jun 10 08:53:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sdc22-0001oC-K4
	for gcvg-git-2@plane.gmane.org; Sun, 10 Jun 2012 08:53:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751250Ab2FJGxO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Jun 2012 02:53:14 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38016 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751090Ab2FJGxN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2012 02:53:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 504A338B3;
	Sun, 10 Jun 2012 02:53:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=f47+tIbAjx6BRwqw45GKQ9RslJE=; b=cbeldb
	FDCU6viJnXSzjj7Y/yxwGQg+jxteH/npJqhLcEirFf40V89/ezVYkOPpZ9wNCpUC
	NVXVGaR/1ScQ0QrV7/ls0HSadgryyJRqQQZm8hVhp9f9ZEMguOp6hfTFvjBo9cis
	6mCgjxrtO4Y4Tosd/3r7MhRAtCMOTKYiaEhQA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ExMdFgoJou2bZpgYm69AOJt12h3wYXl6
	U4oMY+3AHTCPk+jRSNUf82On/TZaQyo9zII8NGYF9uJPF3tdSj9csLQxkbuuUts/
	K1v8vPI7BcTUkeu28uWeUAsO7iPLdZhnmGbo3+ixR7XcBAxtUJnP/f9Tngz3EGC3
	BSUF8Y2z7pk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 47DE138B2;
	Sun, 10 Jun 2012 02:53:13 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BE80D389F; Sun, 10 Jun 2012
 02:53:12 -0400 (EDT)
In-Reply-To: <1339267502-13803-1-git-send-email-Javier.Roucher-Iglesias@ensimag.imag.fr>
 (Javier Roucher-Iglesias's message of "Sat, 9 Jun 2012 20:45:02 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F26A7682-B2C8-11E1-A878-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199569>

Javier.Roucher-Iglesias@ensimag.imag.fr writes:

> +Git-credential permits to the user of the script to save:
> +username, password, host, path and protocol.

The above sounds like saying "A filesystem allows you to save
pathname and contents".  While it may not be _wrong_ per-se, usually
you would think of a filesystem as something you store contents in;
pathname is primarily used as a key to find the contents (i.e. you
do not store it in the filesystem).

Isn't the credential mechanism for storing password for <user,
protocol, host, path> tuple (i.e. the four-tuple is used as a
look-up key)?

> diff --git a/builtin/credential.c b/builtin/credential.c
> new file mode 100644
> index 0000000..9f00885
> --- /dev/null
> +++ b/builtin/credential.c
> @@ -0,0 +1,40 @@
> +#include <stdio.h>
> +#include "cache.h"
> +#include "credential.h"
> +#include "string-list.h"
> +
> +static const char usage_msg[] =
> +"credential <fill|approve|reject>";
> +
> +void cmd_credential (int argc, char **argv, const char *prefix){

Style:

        void cmd_credential(int argc, char **argv, const char *prefix)
        {

> diff --git a/git.c b/git.c
> index d232de9..7cbd7d8 100644
> --- a/git.c
> +++ b/git.c
> @@ -353,6 +353,7 @@ static void handle_internal_command(int argc, const char **argv)
>  		{ "commit-tree", cmd_commit_tree, RUN_SETUP },
>  		{ "config", cmd_config, RUN_SETUP_GENTLY },
>  		{ "count-objects", cmd_count_objects, RUN_SETUP },
> +		{ "credential", cmd_count_objects, RUN_SETUP },

Does "git credential" need to have a git repository (i.e. run in a
git repository or in a working tree that is controlled by one)?  A
scripted Porcelain you would write using "git credential" may want
to implement something like "git clone" or "git ls-remote" where you
do not have to be in an existing repository.
