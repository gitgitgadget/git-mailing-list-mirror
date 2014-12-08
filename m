From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 17/23] expire_reflog(): move rewrite to flags argument
Date: Mon, 8 Dec 2014 14:58:20 -0800
Message-ID: <20141208225820.GI25562@google.com>
References: <1417734515-11812-1-git-send-email-mhagger@alum.mit.edu>
 <1417734515-11812-18-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Dec 08 23:58:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xy7GK-0006cc-B4
	for gcvg-git-2@plane.gmane.org; Mon, 08 Dec 2014 23:58:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755489AbaLHW6g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Dec 2014 17:58:36 -0500
Received: from mail-oi0-f73.google.com ([209.85.218.73]:51412 "EHLO
	mail-oi0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751967AbaLHW6W (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Dec 2014 17:58:22 -0500
Received: by mail-oi0-f73.google.com with SMTP id a141so646971oig.0
        for <git@vger.kernel.org>; Mon, 08 Dec 2014 14:58:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=pK7+b6680VW3/0xEAezbelvnsCQaBfFEs/strtZvU5A=;
        b=kspQ8OvXWj0fddHubBnSSasKhU0LVkmL14CxAPvXSTm5HcvoujgKZttHHJKGbB1Vfa
         +wI55rJZJG+8AThZv+5g1LZGm+qAEtdVg8EVyaDEv/6svX6v19FArmHUCuboljSkmaIv
         WEjHgWxtBcXNp7XFYw1omhXBUVBYtNfqlWozp0VUk3832vaqaWSd3vOTMSasPjU6MHgs
         sdm1ZrcawEQWRe8oMVMywpaEW/qo+eByKGfoVD1qTcO8f+I8rmIvoTvF62OtUBPmwkR8
         TNpxQ9PEXhed+qiI2ZHGNZYklRJ+t0Kj0v/5+TMSDT4IzUDJmZ5VocEkzgNJovAJtKD5
         8Pmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=pK7+b6680VW3/0xEAezbelvnsCQaBfFEs/strtZvU5A=;
        b=REPAFMrcxA/nbkiOxDPxnhZJk1IgB8XFLMY3cZ/+qL+Trg1qOrEzLhCBVCFUsLWVLi
         XbRh6b/oEiNLRwLUco/4FLBH7r+GHmXGN968sxycVx6M9lDAbrgEvIV7TL4V9IwgQeHd
         yKnlDvUhDKuAWHFDNQ8Jph3Ur2sx7Ct0h0PPUOtXon5i5Cj8JjQlv/7Mk9l/5YihC/bO
         TGqfOqDp5KFspOrmIuCCJ08OM/deni9NRjxVEVev1q+DXTBLwW7NNh/NyfH2WO81Z12I
         WnNpEeSjLXMGHez0emyAi2d57MPq770pu3HHcvXYzp3UVm4ADJ52e3YBfSMGb4VFIhm0
         52wA==
X-Gm-Message-State: ALoCoQnkVX4TV3tgx9Tro8vYTmkW3r0ui5JY88pfk9ikYtmjIFdYT4/w912E211uOx2gAmwV7EZ3
X-Received: by 10.42.70.5 with SMTP id d5mr34243430icj.32.1418079501963;
        Mon, 08 Dec 2014 14:58:21 -0800 (PST)
Received: from corpmail-nozzle1-2.hot.corp.google.com ([100.108.1.103])
        by gmr-mx.google.com with ESMTPS id n63si1695905yho.5.2014.12.08.14.58.21
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Dec 2014 14:58:21 -0800 (PST)
Received: from sbeller.mtv.corp.google.com ([172.27.69.125])
	by corpmail-nozzle1-2.hot.corp.google.com with ESMTP id 4rDz4e2K.1; Mon, 08 Dec 2014 14:58:21 -0800
Received: by sbeller.mtv.corp.google.com (Postfix, from userid 279346)
	id E1824140BBD; Mon,  8 Dec 2014 14:58:20 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1417734515-11812-18-git-send-email-mhagger@alum.mit.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261094>

On Fri, Dec 05, 2014 at 12:08:29AM +0100, Michael Haggerty wrote:
> The policy objects don't care about "--rewrite". So move it to
> expire_reflog()'s flags parameter.
> 
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>

Reviewed-by: Stefan Beller <sbeller@google.com>

> ---
>  builtin/reflog.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/builtin/reflog.c b/builtin/reflog.c
> index cc7a220..6294406 100644
> --- a/builtin/reflog.c
> +++ b/builtin/reflog.c
> @@ -23,13 +23,13 @@ static unsigned long default_reflog_expire_unreachable;
>  enum expire_reflog_flags {
>  	EXPIRE_REFLOGS_DRY_RUN = 1 << 0,
>  	EXPIRE_REFLOGS_UPDATE_REF = 1 << 1,
> -	EXPIRE_REFLOGS_VERBOSE = 1 << 2
> +	EXPIRE_REFLOGS_VERBOSE = 1 << 2,
> +	EXPIRE_REFLOGS_REWRITE = 1 << 3
>  };
>  
>  struct cmd_reflog_expire_cb {
>  	struct rev_info revs;
>  	int stalefix;
> -	int rewrite;
>  	unsigned long expire_total;
>  	unsigned long expire_unreachable;
>  	int recno;
> @@ -337,7 +337,7 @@ static int expire_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
>  	struct expire_reflog_cb *cb = cb_data;
>  	struct expire_reflog_policy_cb *policy_cb = cb->policy_cb;
>  
> -	if (policy_cb->cmd->rewrite)
> +	if (cb->flags & EXPIRE_REFLOGS_REWRITE)
>  		osha1 = policy_cb->last_kept_sha1;
>  
>  	if (should_expire_reflog_ent(osha1, nsha1, email, timestamp, tz,
> @@ -673,7 +673,7 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
>  		else if (!strcmp(arg, "--stale-fix"))
>  			cb.stalefix = 1;
>  		else if (!strcmp(arg, "--rewrite"))
> -			cb.rewrite = 1;
> +			flags |= EXPIRE_REFLOGS_REWRITE;
>  		else if (!strcmp(arg, "--updateref"))
>  			flags |= EXPIRE_REFLOGS_UPDATE_REF;
>  		else if (!strcmp(arg, "--all"))
> @@ -755,7 +755,7 @@ static int cmd_reflog_delete(int argc, const char **argv, const char *prefix)
>  		if (!strcmp(arg, "--dry-run") || !strcmp(arg, "-n"))
>  			flags |= EXPIRE_REFLOGS_DRY_RUN;
>  		else if (!strcmp(arg, "--rewrite"))
> -			cb.rewrite = 1;
> +			flags |= EXPIRE_REFLOGS_REWRITE;
>  		else if (!strcmp(arg, "--updateref"))
>  			flags |= EXPIRE_REFLOGS_UPDATE_REF;
>  		else if (!strcmp(arg, "--verbose"))
> -- 
> 2.1.3
> 
