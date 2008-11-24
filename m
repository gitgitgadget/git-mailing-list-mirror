From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] builtin-clone: fix a memory leak in cmd_clone()
Date: Sun, 23 Nov 2008 19:51:36 -0800
Message-ID: <7vabbpok6v.fsf@gitster.siamese.dyndns.org>
References: <cover.1227227976.git.vmiklos@frugalware.org>
 <6bd31bceb3840f14d747972b4858e1c5b215744d.1227227976.git.vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Mon Nov 24 04:53:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L4SVW-0002GX-TK
	for gcvg-git-2@gmane.org; Mon, 24 Nov 2008 04:53:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751133AbYKXDvt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Nov 2008 22:51:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751170AbYKXDvt
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Nov 2008 22:51:49 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:42799 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751075AbYKXDvs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Nov 2008 22:51:48 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id B25817F19B;
	Sun, 23 Nov 2008 22:51:46 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id A46BC7F199; Sun,
 23 Nov 2008 22:51:38 -0500 (EST)
In-Reply-To: <6bd31bceb3840f14d747972b4858e1c5b215744d.1227227976.git.vmiklos@frugalware.org> (Miklos Vajna's message of "Fri, 21 Nov 2008 01:44:58 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 37442B08-B9DB-11DD-8FC2-8214C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101588>

Miklos Vajna <vmiklos@frugalware.org> writes:

> Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
> ---
>  builtin-clone.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/builtin-clone.c b/builtin-clone.c
> index 8e1a1d3..da21cab 100644
> --- a/builtin-clone.c
> +++ b/builtin-clone.c
> @@ -516,6 +516,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>  		refs = transport_get_remote_refs(transport);
>  		transport_fetch_refs(transport, refs);
>  	}
> +	free(dir);
>  
>  	clear_extra_refs();

Can't this be done much earlier?  This variable can potentially be
assigned to work_tree, but after we set up the atexit handler neither dir
nor work_tree are not used (it is a bit hard to see as this function
itself is a bit too big to be maintainable).
