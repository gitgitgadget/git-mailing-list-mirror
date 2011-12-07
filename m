From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/5] revert: free msg in format_todo()
Date: Wed, 7 Dec 2011 00:43:58 -0600
Message-ID: <20111207064358.GB11737@elie.hsd1.il.comcast.net>
References: <1323239877-24101-1-git-send-email-artagnon@gmail.com>
 <1323239877-24101-2-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 07 07:44:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYBEi-0001aJ-1h
	for gcvg-git-2@lo.gmane.org; Wed, 07 Dec 2011 07:44:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752052Ab1LGGoG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Dec 2011 01:44:06 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:38646 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751775Ab1LGGoE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Dec 2011 01:44:04 -0500
Received: by yenm1 with SMTP id m1so206860yen.19
        for <git@vger.kernel.org>; Tue, 06 Dec 2011 22:44:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=MfNXwdZ2BNnSROBgJEDtYIs5FhV1B9T7jzu4jyTfJOQ=;
        b=ppA7E3hpq5ij4XnxDAOz49xZ6R4bKq1gJXsEEsd9dTIt4dvIL+sepn4ZHAexODqGa7
         fcJ5sXNihld+a1ABiMvEqU5RzYIBdF4FvFABfK47zurP790w/nMdKh7+cx9v43T/fdzb
         snsEd27mIJgPPUICtt0oNgkyUXisPyOh1Xffc=
Received: by 10.236.179.7 with SMTP id g7mr24757283yhm.74.1323240244458;
        Tue, 06 Dec 2011 22:44:04 -0800 (PST)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id c10sm1548653yhj.2.2011.12.06.22.44.03
        (version=SSLv3 cipher=OTHER);
        Tue, 06 Dec 2011 22:44:03 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1323239877-24101-2-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186432>

Ramkumar Ramachandra wrote:

> Memory allocated to the fields of msg by get_message() isn't freed.
> This is potentially a big leak,
[because it is in a loop over commits being picked]

Acked-by: Jonathan Nieder <jrnieder@gmail.com>

>  builtin/revert.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/builtin/revert.c b/builtin/revert.c
> index 1ea525c..0c6d3d8 100644
> --- a/builtin/revert.c
> +++ b/builtin/revert.c
> @@ -706,6 +706,7 @@ static int format_todo(struct strbuf *buf, struct commit_list *todo_list,
>  		if (get_message(cur->item, &msg))
>  			return error(_("Cannot get commit message for %s"), sha1_abbrev);
>  		strbuf_addf(buf, "%s %s %s\n", action_str, sha1_abbrev, msg.subject);
> +		free_message(&msg);
>  	}
>  	return 0;
>  }
