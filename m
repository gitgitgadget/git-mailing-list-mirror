From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] http-push: support full URI in handle_remote_ls_ctx()
Date: Sun, 18 Jan 2009 13:28:04 -0800
Message-ID: <7v63kcuwwr.fsf@gitster.siamese.dyndns.org>
References: <1232278116-6631-1-git-send-email-catap@catap.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Kirill A. Korinskiy" <catap@catap.ru>
X-From: git-owner@vger.kernel.org Sun Jan 18 22:29:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOfD7-00080Y-AR
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 22:29:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754904AbZARV2N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jan 2009 16:28:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754881AbZARV2L
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jan 2009 16:28:11 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:42020 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752179AbZARV2J (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2009 16:28:09 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 89A3E1BC43;
	Sun, 18 Jan 2009 16:28:09 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 637F41B56B; Sun,
 18 Jan 2009 16:28:06 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E7195976-E5A6-11DD-849D-2E3B113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106286>

"Kirill A. Korinskiy" <catap@catap.ru> writes:

> @@ -1424,9 +1425,18 @@ static void handle_remote_ls_ctx(struct xml_ctx *ctx, int tag_closed)
>  				ls->userFunc(ls);
>  			}
>  		} else if (!strcmp(ctx->name, DAV_PROPFIND_NAME) && ctx->cdata) {
> -			ls->dentry_name = xmalloc(strlen(ctx->cdata) -
> +			char *path = ctx->cdata;
> +			if (!strcmp(ctx->cdata, "http://")) {
> +				path = strchr(path + sizeof("http://") - 1, '/');
> +			} else if (!strcmp(ctx->cdata, "https://")) {
> +				path = strchr(path + sizeof("https://") - 1, '/');
> +			}
> +
> +			path += remote->path_len;

I see you chose to address the issue I pointed out in:

    http://thread.gmane.org/gmane.comp.version-control.git/103804/focus=104363

by being more strict.  That's the only change I can spot compared to
e1f33ef (http-push: support full URI in handle_remote_ls_ctx(),
2008-12-23) that is already in maint.

Could you make this into an incremental patch?
