From: Alexander Potashev <aspotashev@gmail.com>
Subject: Re: [PATCH] Get format-patch to show first commit after root commit
Date: Fri, 9 Jan 2009 23:29:40 +0300
Message-ID: <20090109202940.GA17501@myhost>
References: <1231529725-19767-1-git-send-email-nathan.panike@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Nathan W. Panike" <nathan.panike@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 09 21:31:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLO0p-0007Vb-Ej
	for gcvg-git-2@gmane.org; Fri, 09 Jan 2009 21:31:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751045AbZAIU3j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jan 2009 15:29:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751111AbZAIU3j
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Jan 2009 15:29:39 -0500
Received: from mail-bw0-f21.google.com ([209.85.218.21]:38513 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750856AbZAIU3i (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jan 2009 15:29:38 -0500
Received: by bwz14 with SMTP id 14so29566852bwz.13
        for <git@vger.kernel.org>; Fri, 09 Jan 2009 12:29:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=MkFYzV+MHwZj6NFU+Lqmpo7oa7CTarEMB3kwaWRPj/E=;
        b=d/u8PlKc5JM7E+AO7qzGfj96f5dYhVxKU/r6FrzW8nfOSmSTRh931iHTL4Flftqq4p
         HtSIsXaZMsEInQpoj90HDzyeAfoYsHwrK46lqQEv5nmIEBfkBOmCrLC49e+V/HWxK2pP
         n+ZTC9Xy0Mdd0qALpTboljD3RyoIKrCWZiF+A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=IW0B5CoHYjFtQszGQSb1sGkU0bhScEHCpBRBvxvsAtxQ/QrMe9iB1OtpbksOAReGoe
         h0YhNsNs1r7JxbO/le7igXgqnM9S8YxIfW7N71FZJM+ItTb3QGbvU6uMRqwK6W2gDruF
         R2AmuoDTE8CojmISVsCLopaWXOHYeH5qeWbDo=
Received: by 10.103.228.19 with SMTP id f19mr9349682mur.18.1231532975934;
        Fri, 09 Jan 2009 12:29:35 -0800 (PST)
Received: from smtp.gmail.com (ppp91-77-12-84.pppoe.mtu-net.ru [91.77.12.84])
        by mx.google.com with ESMTPS id b9sm8652478mug.26.2009.01.09.12.29.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 09 Jan 2009 12:29:35 -0800 (PST)
Received: by smtp.gmail.com (sSMTP sendmail emulation); Fri, 09 Jan 2009 23:29:40 +0300
Content-Disposition: inline
In-Reply-To: <1231529725-19767-1-git-send-email-nathan.panike@gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105038>

Hello!

I experienced this problem today while preparing a simple patch for
reply in "[PATCH 2/2] Use is_pseudo_dir_name everywhere" thread.
I used a workaround: add a file, commit, remove it, commit, add it once
again, commit and after all format-patch.

On 13:35 Fri 09 Jan     , Nathan W. Panike wrote:
> Currently, the command
> 
> git format-patch -1 e83c5163316f89bfbde
> 
> in the git repository creates an empty file.  Instead, one is
> forced to do
> 
> git format-patch -1 --root e83c5163316f89bfbde
> 
> This seems arbitrary.  This patch fixes this case, so that
> 
> git format-patch -1 e83c5163316f89bfbde

Your patch doesn't solve the problem if there are more than one commit
(say, 2 commits) and you run 'git format-patch -2'. Even with your patch
format-patch writes an empty patch file corresponding to the root commit
(actually, it creates 2 patches, but the first is empty).

Please, correct me if I'm wrong.

> 
> will produce an actual patch.
> ---
>  builtin-log.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/builtin-log.c b/builtin-log.c
> index 4a02ee9..5e7b61f 100644
> --- a/builtin-log.c
> +++ b/builtin-log.c
> @@ -977,6 +977,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
>  		list[nr - 1] = commit;
>  	}
>  	total = nr;
> +	if (total == 1 && !list[0]->parents)
> +		rev.show_root_diff=1;
>  	if (!keep_subject && auto_number && total > 1)
>  		numbered = 1;
>  	if (numbered)
> -- 
> 1.6.1.76.gc123b.dirty
