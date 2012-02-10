From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] diff --stat: use the real terminal width
Date: Thu, 09 Feb 2012 16:54:54 -0800
Message-ID: <7vaa4rtsm9.fsf@alter.siamese.dyndns.org>
References: <1328831921-27272-1-git-send-email-zbyszek@in.waw.pl>
 <1328831921-27272-4-git-send-email-zbyszek@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
X-From: git-owner@vger.kernel.org Fri Feb 10 01:55:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RvelS-0003Z5-N9
	for gcvg-git-2@plane.gmane.org; Fri, 10 Feb 2012 01:55:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754722Ab2BJAy5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 9 Feb 2012 19:54:57 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60014 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752843Ab2BJAy5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Feb 2012 19:54:57 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 99F3C63EB;
	Thu,  9 Feb 2012 19:54:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=JprLreXa5t13
	CySnMIf+ApAxjrA=; b=xzSnHmHNRFE+2FjZftLeA7x3dhoTPy9sYpaW2YjC7gfJ
	MsrCmUKkCH+uEv1WtCzDLCvdaEbJyB7J9oEjmS6SpkxOIJfB+R0um33zvOySTiTn
	rppUniO+hW+qrZMf0gi2KTB80S5euWKQzK+SWMolRkj8i3h2tWHhjWdqGjct/tc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Z4JnR3
	FN6+LQH1KGCdjarUkUQLboYTgCotY1lPHpjAAHjOO+0iR25qTPAvZAM81bmg7FSR
	xF5JXStE2Tus0LNVqqfRPS0vzvKzHFFnRO54G1LGjLmkOM9Xqke9DNAwTYbKn/sf
	p4cHXIikfFoh2pjsiYF28nMmiZmbqW1sOAadM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 90C7763EA;
	Thu,  9 Feb 2012 19:54:56 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 246B963E9; Thu,  9 Feb 2012
 19:54:56 -0500 (EST)
In-Reply-To: <1328831921-27272-4-git-send-email-zbyszek@in.waw.pl> ("Zbigniew
 =?utf-8?Q?J=C4=99drzejewski-Szmek=22's?= message of "Fri, 10 Feb 2012
 00:58:40 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D96E5AAA-5381-11E1-BB3E-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190358>

Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.waw.pl> writes:

> Some projects (especially in Java), have long filename paths, with
> nested directories or long individual filenames. When files are
> renamed, the stat output can be almost useless. If the middle part
> between { and } is long (because the file was moved to a completely
> different directory), then most of the path would be truncated.
>
> It makes sense to use the full terminal width.
>
> The output is still not optimal, because too many columns are devoted
> to +- output, and not enough to filenames, but this is a policy
> question, changed in next commit.
>
> Signed-off-by: Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.waw.pl>
> ---
>  diff.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
>
> diff --git a/diff.c b/diff.c
> index 7e15426..8406a0d 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -7,6 +7,7 @@
>  #include "diffcore.h"
>  #include "delta.h"
>  #include "xdiff-interface.h"
> +#include "help.h"
>  #include "color.h"
>  #include "attr.h"
>  #include "run-command.h"
> @@ -1341,7 +1342,7 @@ static void show_stats(struct diffstat_t *data,=
 struct diff_options *options)
>  		line_prefix =3D msg->buf;
>  	}
> =20
> -	width =3D options->stat_width ? options->stat_width : 80;
> +	width =3D options->stat_width ? options->stat_width : term_columns(=
);

The output from "git format-patch" shouldn't be affected at all by the
width of the terminal the patch sender happened to have used when the
command was run when the user did not explicitly ask a custom width by
giving a --stat-width command line option.

How do you prevent regression to the command in this series?
