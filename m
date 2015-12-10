From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 13/16] init: allow alternate backends to be set for new
 repos
Date: Thu, 10 Dec 2015 13:02:13 -0500
Message-ID: <20151210180213.GA27152@sigill.intra.peff.net>
References: <1449102921-7707-1-git-send-email-dturner@twopensource.com>
 <1449102921-7707-14-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Thu Dec 10 19:02:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a75Xq-0001wE-Lh
	for gcvg-git-2@plane.gmane.org; Thu, 10 Dec 2015 19:02:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754894AbbLJSCS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Dec 2015 13:02:18 -0500
Received: from cloud.peff.net ([50.56.180.127]:39880 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754088AbbLJSCR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Dec 2015 13:02:17 -0500
Received: (qmail 27878 invoked by uid 102); 10 Dec 2015 18:02:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 10 Dec 2015 12:02:17 -0600
Received: (qmail 22257 invoked by uid 107); 10 Dec 2015 18:02:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 10 Dec 2015 13:02:21 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 10 Dec 2015 13:02:13 -0500
Content-Disposition: inline
In-Reply-To: <1449102921-7707-14-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282218>

On Wed, Dec 02, 2015 at 07:35:18PM -0500, David Turner wrote:

> @@ -510,9 +511,36 @@ int validate_headref(const char *path)
>  	unsigned char sha1[20];
>  	int fd;
>  	ssize_t len;
> +	struct refdb_config_data refdb_data = {NULL, NULL};
> +
> +	if (lstat(path, &st) < 0) {
> +		int backend_type_set;
> +		struct strbuf config_path = STRBUF_INIT;
> +		if (path) {
> +			char *pathdup = xstrdup(path);
> +			char *git_dir = dirname(pathdup);
> +			strbuf_addf(&config_path, "%s/%s", git_dir, "config");
> +			free(pathdup);
> +		} else {
> +			strbuf_addstr(&config_path, "config");
> +		}

Can we ever follow this "else" branch? It would mean feeding NULL to
lstat.

-Peff
