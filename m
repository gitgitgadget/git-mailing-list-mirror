From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: Re: [PATCH 2/2] builtin-reflog: fix deletion of HEAD entries
Date: Sun, 10 Aug 2008 13:12:48 +0200
Message-ID: <200808101312.48213.johannes.sixt@telecom.at>
References: <7vd4kh4r9m.fsf@gitster.siamese.dyndns.org> <1218360901-36215-1-git-send-email-pdebie@ai.rug.nl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Pieter de Bie <pdebie@ai.rug.nl>
X-From: git-owner@vger.kernel.org Sun Aug 10 13:13:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KS8ry-0000BT-Qw
	for gcvg-git-2@gmane.org; Sun, 10 Aug 2008 13:13:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752906AbYHJLMw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Aug 2008 07:12:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752896AbYHJLMw
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Aug 2008 07:12:52 -0400
Received: from smtp2.srv.eunet.at ([193.154.160.116]:40313 "EHLO
	smtp2.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752782AbYHJLMw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Aug 2008 07:12:52 -0400
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp2.srv.eunet.at (Postfix) with ESMTP id 221AABEE50;
	Sun, 10 Aug 2008 13:12:49 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id ACEFD6991E;
	Sun, 10 Aug 2008 13:12:48 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <1218360901-36215-1-git-send-email-pdebie@ai.rug.nl>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91829>

On Sonntag, 10. August 2008, Pieter de Bie wrote:
> diff --git a/builtin-reflog.c b/builtin-reflog.c
> index 5af3f28..a8311a6 100644
> --- a/builtin-reflog.c
> +++ b/builtin-reflog.c
> @@ -541,14 +541,15 @@ static int cmd_reflog_expire(int argc, const char
> **argv, const char *prefix) }
>
>  	while (i < argc) {
> -		const char *ref = argv[i++];
> +		char *ref;
>  		unsigned char sha1[20];
> -		if (!resolve_ref(ref, sha1, 1, NULL)) {
> -			status |= error("%s points nowhere!", ref);
> +		if (!dwim_log(argv[i], strlen(argv[i]), sha1, &ref)) {
> +			status |= error("%s points nowhere!", argv[i]);
>  			continue;
>  		}
>  		set_reflog_expiry_param(&cb, explicit_expiry, ref);
>  		status |= expire_reflog(ref, sha1, 0, &cb);
> +		i++;
>  	}
>  	return status;
>  }

This runs into an endless loop in the error case because it doesn't increase 
i.

-- Hannes
