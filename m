From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] cherry-pick: No advice to commit if --no-commit
Date: Tue, 21 Feb 2012 16:23:22 -0600
Message-ID: <20120221222049.GA31934@burratino>
References: <1329858317-3066-1-git-send-email-hordp@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Phil Hord <phil.hord@gmail.com>
To: Phil Hord <hordp@cisco.com>
X-From: git-owner@vger.kernel.org Tue Feb 21 23:23:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rzy7U-0005YX-SE
	for gcvg-git-2@plane.gmane.org; Tue, 21 Feb 2012 23:23:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755941Ab2BUWXc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Feb 2012 17:23:32 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:51399 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755816Ab2BUWXb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Feb 2012 17:23:31 -0500
Received: by iacb35 with SMTP id b35so9466874iac.19
        for <git@vger.kernel.org>; Tue, 21 Feb 2012 14:23:30 -0800 (PST)
Received-SPF: pass (google.com: domain of jrnieder@gmail.com designates 10.42.80.3 as permitted sender) client-ip=10.42.80.3;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of jrnieder@gmail.com designates 10.42.80.3 as permitted sender) smtp.mail=jrnieder@gmail.com; dkim=pass header.i=jrnieder@gmail.com
Received: from mr.google.com ([10.42.80.3])
        by 10.42.80.3 with SMTP id t3mr29635883ick.49.1329863010625 (num_hops = 1);
        Tue, 21 Feb 2012 14:23:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=ITEX1WctjfJwI4+nWV4QepBN7Q1uRKd4kPKoGGTxl/w=;
        b=q+QcxWn9iGt7vjZBsqWxxXer8a2+0jguitOttVqH+35gWHIrLZpCzQn8noXvvSDExK
         WzFlMTOYdMewKtOyFRg+OoJzlTvPydddYKH8ZIMys0PwCWNCoIUfQCSxiYshTiJANgOv
         aDbNHHcGl8uC8UCN/Qw+yph1QPCbyq0g1ONlI=
Received: by 10.42.80.3 with SMTP id t3mr23699961ick.49.1329863010575;
        Tue, 21 Feb 2012 14:23:30 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id df2sm11421164igb.0.2012.02.21.14.23.29
        (version=SSLv3 cipher=OTHER);
        Tue, 21 Feb 2012 14:23:30 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1329858317-3066-1-git-send-email-hordp@cisco.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191191>

Hi Phil,

Phil Hord wrote:

> Signed-off-by: Phil Hord <hordp@cisco.com>

Thanks.

> +++ b/sequencer.c
[...]
> @@ -138,10 +138,12 @@ static void print_advice(int show_hint)
>  		return;
>  	}
>  
> -	if (show_hint)
> +	if (show_hint) {
>  		advise(_("after resolving the conflicts, mark the corrected paths\n"
> -			 "with 'git add <paths>' or 'git rm <paths>'\n"
> -			 "and commit the result with 'git commit'"));
> +			 "with 'git add <paths>' or 'git rm <paths>'"));
> +		if (!opts->no_commit)
> +			advise(_( "and commit the result with 'git commit'"));

"cherry-pick --no-commit" was not about to commit, but the user might
have been.  I think the hint is intended to convey that authorship
will be correctly preserved if the user continues with "git commit"
and no special -c option is necessary.

Could you say a little more about the motivation for this patch?  For
example, did the existing message confuse someone, or was it grating
in the context of some particular workflow?

A smaller detail: splitting the message into two like this gives
translators less control over how to phrase the message and where to
wrap lines.  Luckily that is easy to fix with

	if (opts->no_commit)
		advise(...);
	else
		advise(...);

which means more flexibility in phrasing the message with pertinent
advice for each case. ;-)

Ciao,
Jonathan
