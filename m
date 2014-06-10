From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 15/15] commit: record buffer length in cache
Date: Tue, 10 Jun 2014 07:12:37 +0200 (CEST)
Message-ID: <20140610.071237.852310668484562387.chriscool@tuxfamily.org>
References: <20140609180236.GA24644@sigill.intra.peff.net>
	<20140609181538.GO20315@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com, jnareb@gmail.com,
	sunshine@sunshineco.com
To: peff@peff.net
X-From: git-owner@vger.kernel.org Tue Jun 10 07:13:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuEMr-0008S5-NV
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jun 2014 07:13:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754686AbaFJFNA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2014 01:13:00 -0400
Received: from [194.158.98.14] ([194.158.98.14]:53764 "EHLO mail-1y.bbox.fr"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750994AbaFJFNA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2014 01:13:00 -0400
Received: from localhost (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-1y.bbox.fr (Postfix) with ESMTP id B6B0A40;
	Tue, 10 Jun 2014 07:12:37 +0200 (CEST)
In-Reply-To: <20140609181538.GO20315@sigill.intra.peff.net>
X-Mailer: Mew version 6.3 on Emacs 23.3 / Mule 6.0 (HANACHIRUSATO)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251157>

From: Jeff King <peff@peff.net>
>
> --- a/builtin/blame.c
> +++ b/builtin/blame.c
> @@ -2313,7 +2313,7 @@ static struct commit *fake_working_tree_commit(struct diff_options *opt,
>  		    ident, ident, path,
>  		    (!contents_from ? path :
>  		     (!strcmp(contents_from, "-") ? "standard input" : contents_from)));
> -	set_commit_buffer(commit, strbuf_detach(&msg, NULL));
> +	set_commit_buffer(commit, msg.buf, msg.len);

I find the above strange. I would have done something like:

-	set_commit_buffer(commit, strbuf_detach(&msg, NULL));
+	size_t size;
+	char *buf = strbuf_detach(&msg, &size);
+	set_commit_buffer(commit, buf, size);

Thanks,
Christian.
