From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v4 2/2] diff: generate pretty filenames in
	prep_temp_blob()
Date: Fri, 29 May 2009 15:55:37 -0400
Message-ID: <20090529195537.GA13961@coredump.intra.peff.net>
References: <1243558164-74756-1-git-send-email-davvid@gmail.com> <1243558164-74756-2-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: gitster@pobox.com, git@vger.kernel.org, markus.heidelberg@web.de,
	jnareb@gmail.com, j.sixt@viscovery.net
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 29 21:56:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MA8BQ-0004Uk-NA
	for gcvg-git-2@gmane.org; Fri, 29 May 2009 21:56:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760352AbZE2Tzp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 May 2009 15:55:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756944AbZE2Tzo
	(ORCPT <rfc822;git-outgoing>); Fri, 29 May 2009 15:55:44 -0400
Received: from peff.net ([208.65.91.99]:54269 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756515AbZE2Tzo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 May 2009 15:55:44 -0400
Received: (qmail 28351 invoked by uid 107); 29 May 2009 19:55:49 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 29 May 2009 15:55:49 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 29 May 2009 15:55:37 -0400
Content-Disposition: inline
In-Reply-To: <1243558164-74756-2-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120308>

On Thu, May 28, 2009 at 05:49:24PM -0700, David Aguilar wrote:

> @@ -1964,8 +1964,24 @@ static void prep_temp_blob(const char *path, struct diff_tempfile *temp,
>  {
>  	int fd;
>  	struct strbuf buf = STRBUF_INIT;
> +	struct strbuf template = STRBUF_INIT;
> +	char *basename = ((char*)path) + strlen(path) - 1;

Why do you drop constness in this assignment?

> +	/* Windows lacks basename() */
> +	while(*basename && basename > path) {
> +		basename--;
> +		if (is_dir_sep(*basename)) {
> +			basename++;
> +			break;
> +		}
> +	}

This is such an easily-factorable bit, maybe it makes sense to add as
basename() in compat/?

-Peff
