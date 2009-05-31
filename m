From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH 14/17] http*: add http_get_info_packs
Date: Sun, 31 May 2009 17:02:56 +0200
Message-ID: <20090531150256.GA27958@localhost>
References: <20090530015933.030ad46b.rctay89@gmail.com> <20090530015937.c402e5f2.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mike Hommey <mh@glandium.org>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 31 17:03:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MAmZJ-0005gn-Ju
	for gcvg-git-2@gmane.org; Sun, 31 May 2009 17:03:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757893AbZEaPDO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 May 2009 11:03:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757590AbZEaPDN
	(ORCPT <rfc822;git-outgoing>); Sun, 31 May 2009 11:03:13 -0400
Received: from postman.fh-hagenberg.at ([193.170.124.96]:43931 "EHLO
	mail.fh-hagenberg.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756800AbZEaPDM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 May 2009 11:03:12 -0400
Received: from darc.dnsalias.org ([80.123.242.182]) by mail.fh-hagenberg.at over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sun, 31 May 2009 17:03:13 +0200
Received: from drizzd by darc.dnsalias.org with local (Exim 4.69)
	(envelope-from <drizzd@aon.at>)
	id 1MAmYq-0007Yw-5m; Sun, 31 May 2009 17:02:56 +0200
Content-Disposition: inline
In-Reply-To: <20090530015937.c402e5f2.rctay89@gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-OriginalArrivalTime: 31 May 2009 15:03:13.0575 (UTC) FILETIME=[EB810B70:01C9E200]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120403>

On Sat, May 30, 2009 at 01:59:37AM +0800, Tay Ray Chuan wrote:
> --- a/http-push.c
> +++ b/http-push.c
> @@ -950,182 +950,16 @@ static int add_send_request(struct object *obj, struct remote_lock *lock)
[...]
>  static int fetch_indices(void)
>  {
[...]
> -		if (results.curl_result != CURLE_OK) {
> -			strbuf_release(&buffer);
> -			free(url);
> -			if (results.http_code == 404)
> -				return 0;
> -			else
> -				return error("%s", curl_errorstr);
> -		}
[...]
> +	if (http_get_info_packs(repo->url, &repo->packs) == HTTP_OK)
> +		return 0;
> +	else
> +		return -1;

fetch_indices() used to return 0 if the pack info was missing. Now it
returns an error. I also think we could get rid of repo->has_info_packs.
This could easily be handled within fetch_indices().

Clemens
