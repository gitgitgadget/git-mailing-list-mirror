From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 3/7] revert: Make commit descriptions in insn sheet
 optional
Date: Sun, 14 Aug 2011 11:09:23 -0500
Message-ID: <20110814160923.GL18466@elie.gateway.2wire.net>
References: <1313310789-10216-1-git-send-email-artagnon@gmail.com>
 <1313310789-10216-4-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 14 18:12:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QsdJ4-0004qk-Uj
	for gcvg-git-2@lo.gmane.org; Sun, 14 Aug 2011 18:12:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754405Ab1HNQJa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Aug 2011 12:09:30 -0400
Received: from mail-yi0-f46.google.com ([209.85.218.46]:62465 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754586Ab1HNQJ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Aug 2011 12:09:27 -0400
Received: by yie30 with SMTP id 30so2834851yie.19
        for <git@vger.kernel.org>; Sun, 14 Aug 2011 09:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=NoKaOUicinRS0YrrKtNjc4fJAuq5Icw5MrVQHT+k45U=;
        b=c6jTyFuY7z6mb4/6MSfs5irm2oKz24/z1q4sLiN7xuSHD7iouOvyZ9aG2COZgHVnEY
         JNBfJOP54KMh2Rk/iHLxr6oqnxA+sOG1ogzkUO4JxydWLXffRQ8ZYHKVyAA38k6J6QQ4
         pjhlToauHt0AhhGEqXZ7qCucKgAQhIRu1yAT8=
Received: by 10.151.40.17 with SMTP id s17mr4068312ybj.140.1313338167026;
        Sun, 14 Aug 2011 09:09:27 -0700 (PDT)
Received: from elie.gateway.2wire.net (adsl-68-255-108-227.dsl.chcgil.ameritech.net [68.255.108.227])
        by mx.google.com with ESMTPS id x3sm1209578ybd.12.2011.08.14.09.09.25
        (version=SSLv3 cipher=OTHER);
        Sun, 14 Aug 2011 09:09:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1313310789-10216-4-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179332>

Ramkumar Ramachandra wrote:

> --- a/builtin/revert.c
> +++ b/builtin/revert.c
> @@ -697,26 +697,23 @@ static struct commit *parse_insn_line(char *start, struct replay_opts *opts)
>  	unsigned char commit_sha1[20];
>  	char sha1_abbrev[40];
[...]
> +	q = p + strcspn(p, " \n");
> +	if (q - p + 1 > sizeof(sha1_abbrev))
>  		return NULL;

If I understand correctly, the current code makes it perfectly possible
to use commands like

	pick origin/master^^2~5

when that is more convenient to type.  So I wonder whether 40 is actually
a good limit.  Another possibility would be to do something like

	static struct strbuf cmit = STRBUF_INIT;

	strbuf_reset(&cmit);
	...
	strbuf_add(&cmit, p, q - p);

to avoid having to worry about the buffer size altogether.
