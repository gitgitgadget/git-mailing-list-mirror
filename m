From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] git-remote rename: support branches->config
 migration
Date: Tue, 11 Nov 2008 16:49:14 -0800
Message-ID: <7v63mtvkdx.fsf@gitster.siamese.dyndns.org>
References: <cover.1226349595.git.vmiklos@frugalware.org>
 <95e56b46e30b41af31da86789625c93511f1faef.1226349595.git.vmiklos@frugalware.org> <033bc63195299e494791e4e6d8a41f142d848bba.1226349595.git.vmiklos@frugalware.org> <cover.1226349595.git.vmiklos@frugalware.org> <b32cf68df41e417079a49dc02e46ffc0c571029b.1226349595.git.vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Brandon Casey <casey@nrlssc.navy.mil>,
	git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Wed Nov 12 01:51:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L03xJ-0002F9-Om
	for gcvg-git-2@gmane.org; Wed, 12 Nov 2008 01:51:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751984AbYKLAuW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Nov 2008 19:50:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751603AbYKLAuW
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Nov 2008 19:50:22 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:57743 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751179AbYKLAuV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Nov 2008 19:50:21 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 6E9C896388;
	Tue, 11 Nov 2008 19:50:17 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id A987896378; Tue,
 11 Nov 2008 19:49:21 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: DFCBA7F6-B053-11DD-939A-4F5276724C3F-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100703>

Miklos Vajna <vmiklos@frugalware.org> writes:

> This is similar to the remotes->config one, but it makes the
> branches->config conversion possible.
>
> Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
> ---
>  builtin-remote.c  |    2 ++
>  t/t5505-remote.sh |   12 ++++++++++++
>  2 files changed, 14 insertions(+), 0 deletions(-)
>
> diff --git a/builtin-remote.c b/builtin-remote.c
> index d9d0ba3..3af1876 100644
> --- a/builtin-remote.c
> +++ b/builtin-remote.c
> @@ -384,6 +384,8 @@ static int migrate_file(struct remote *remote)
>  					remote->fetch_refspec[i], buf.buf);
>  	if (remote->origin == REMOTE_REMOTES)
>  		path = git_path("remotes/%s", remote->name);
> +	else if (remote->origin == REMOTE_BRANCHES)
> +		path = git_path("branches/%s", remote->name);

There is something fishy going on between 2/4 and 3/4.  2/4 was advertised
to migrate remotes to config and had a call to migrate_file() for that
purpose.  Here this one now allows to convert branches but there is no
change to the callsite of migrate_file().

Which would mean that 2/4 would convert branches/foo too.  And this one is
only to remove the leftover branches/foo file.

Or am I utterly confused?
