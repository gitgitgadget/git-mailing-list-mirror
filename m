From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 8/9] revert: report fine-grained error messages from insn
 parser
Date: Fri, 9 Dec 2011 14:47:15 -0600
Message-ID: <20111209204715.GM20913@elie.hsd1.il.comcast.net>
References: <1323445326-24637-1-git-send-email-artagnon@gmail.com>
 <1323445326-24637-9-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 09 21:47:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZ7Lo-0001Pb-Mg
	for gcvg-git-2@lo.gmane.org; Fri, 09 Dec 2011 21:47:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754626Ab1LIUrU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Dec 2011 15:47:20 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:42679 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751079Ab1LIUrT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Dec 2011 15:47:19 -0500
Received: by yenm11 with SMTP id m11so2418658yen.19
        for <git@vger.kernel.org>; Fri, 09 Dec 2011 12:47:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=OBwyIXzAmED+aveU7Mk8tJG1qsdCtGCK46lkkd10+gQ=;
        b=dI4TD89zm4EJJ7CVkfgUx+TUGJWFISg9HMxa7wpHCkQCadVuAnL753gZSB8E717a+7
         qF43OorMyUm8emEGjoIQSi9O1Evqj/f7lpfqsDK8qJaU+h6x8eAeNQULz5uttQc4AnT5
         OakAB5mz4XlkgdJdAvcfY+52mDwlJWqKNZFj8=
Received: by 10.236.155.36 with SMTP id i24mr14770694yhk.43.1323463639370;
        Fri, 09 Dec 2011 12:47:19 -0800 (PST)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id 3sm27011005anv.7.2011.12.09.12.47.17
        (version=SSLv3 cipher=OTHER);
        Fri, 09 Dec 2011 12:47:18 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1323445326-24637-9-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186693>

Ramkumar Ramachandra wrote:

> --- a/builtin/revert.c
> +++ b/builtin/revert.c
> @@ -719,8 +719,10 @@ static int format_todo(struct strbuf *buf, struct replay_insn_list *todo_list)
>  	return 0;
>  }
>  
> -static int parse_insn_line(char *bol, char *eol, struct replay_insn_list *item)
> +static int parse_insn_line(char *bol, char *eol,
> +			struct replay_insn_list *item, int lineno)
>  {
> +	const char *todo_file = git_path(SEQ_TODO_FILE);
>  	unsigned char commit_sha1[20];

I know that this function does not call git_path() again before the
value is used, so this is safe today, but I do not trust people in the
future to preserve that property (for example, maybe someone will want
to call get_sha1() earlier).  Why not wait to call git_path() when it
is time to use the value it returns?
