From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 12/23] expire_reflog(): move updateref to flags argument
Date: Mon, 8 Dec 2014 14:42:06 -0800
Message-ID: <20141208224206.GD25562@google.com>
References: <1417734515-11812-1-git-send-email-mhagger@alum.mit.edu>
 <1417734515-11812-13-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Dec 08 23:42:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xy70R-0006xv-L3
	for gcvg-git-2@plane.gmane.org; Mon, 08 Dec 2014 23:42:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752543AbaLHWmK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Dec 2014 17:42:10 -0500
Received: from mail-yk0-f201.google.com ([209.85.160.201]:64847 "EHLO
	mail-yk0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751520AbaLHWmI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Dec 2014 17:42:08 -0500
Received: by mail-yk0-f201.google.com with SMTP id 142so318084ykq.4
        for <git@vger.kernel.org>; Mon, 08 Dec 2014 14:42:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=O5iZvZ3x9EMbioAKg/hw2FB2M5Dh7uALs1DkoMA1i1U=;
        b=B7j7EAnIJqyqZba03kp7LGRFTHBGQyLRHvKU0d3DoxGpbzhrc83kiyQiopaZIN0fqO
         Q5z9ZBSaBGqVnn0NtWzOHHz3WBXi2FOSP1EHWkeGXba/jsas4MxU2/aps35QI28eynTU
         8VSaeFvLH9x7ixZVulv7aR1WANArAMztdTk9CpKxHRNDuENt0XbEEeCg1t24pB5jeLg6
         6QPmCpVwGOBip6GENmk/2FRQXmdLwnd8nYzQZ2fThVAHXANr8l6XTqPBkCcmb5ZMhfD1
         Ojg7cHJ0bdgEFCmhG1O/fFE040QBEaEHB8hTJmdbRmbgty+QbjIa6XBbkRlAJ3iOgNOU
         HZfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=O5iZvZ3x9EMbioAKg/hw2FB2M5Dh7uALs1DkoMA1i1U=;
        b=RFNvg7eyUYVNf1EOxfDsgNuv4NiY+ABVe+IijW1P4bAafByRPinU13jCCBMdTK9WY5
         oCPENz8DTjIVhMOsd0bv8R4KgD8M/Lj2Q0LtYJqC6dUxGDQh4XwxNfDvM6e8TPcbYoyR
         KdYLbPf13HIeYbkmNcuG6wN2om6TKOTU+m8kV3ecjz0J1eVqBlrRAn8Upm4iOhwgxouT
         c+061fX8358/pM4s7ee+H+Fi0PYYGb2h3S/1qZAnhBQeg4E+DgCzGMXsX4idjCCQDlNu
         f3C64QuvI7r9cdwfi+TyoymHCsAXH17s1/BDMf74YHIx6VyuMcoV6Ug942YR9lm20UBS
         dqTA==
X-Gm-Message-State: ALoCoQkArkfmxiR7S1fGKajHDSCpO0pHvgmUY20PWh990G4WoGGKIdWxCRHD+O7Swxw45pLd4wG1
X-Received: by 10.224.125.132 with SMTP id y4mr9370146qar.0.1418078527963;
        Mon, 08 Dec 2014 14:42:07 -0800 (PST)
Received: from corpmail-nozzle1-1.hot.corp.google.com ([100.108.1.104])
        by gmr-mx.google.com with ESMTPS id r6si1695079yhg.1.2014.12.08.14.42.07
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Dec 2014 14:42:07 -0800 (PST)
Received: from sbeller.mtv.corp.google.com ([172.27.69.125])
	by corpmail-nozzle1-1.hot.corp.google.com with ESMTP id a9UVZpkw.1; Mon, 08 Dec 2014 14:42:07 -0800
Received: by sbeller.mtv.corp.google.com (Postfix, from userid 279346)
	id 02766140BBD; Mon,  8 Dec 2014 14:42:06 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1417734515-11812-13-git-send-email-mhagger@alum.mit.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261089>

On Fri, Dec 05, 2014 at 12:08:24AM +0100, Michael Haggerty wrote:
> The policy objects don't care about "--updateref". So move it to
> expire_reflog()'s flags parameter.
> 
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>

Reviewed-by: <sbeller@google.com>

> ---
>  builtin/reflog.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/builtin/reflog.c b/builtin/reflog.c
> index a490193..597c547 100644
> --- a/builtin/reflog.c
> +++ b/builtin/reflog.c
> @@ -24,7 +24,6 @@ struct cmd_reflog_expire_cb {
>  	struct rev_info revs;
>  	int stalefix;
>  	int rewrite;
> -	int updateref;
>  	int verbose;
>  	unsigned long expire_total;
>  	unsigned long expire_unreachable;
> @@ -415,7 +414,8 @@ static void reflog_expiry_cleanup(struct expire_reflog_cb *cb)
>  static struct lock_file reflog_lock;
>  
>  enum expire_reflog_flags {
> -	EXPIRE_REFLOGS_DRY_RUN = 1 << 0
> +	EXPIRE_REFLOGS_DRY_RUN = 1 << 0,
> +	EXPIRE_REFLOGS_UPDATE_REF = 1 << 1
>  };
>  
>  static int expire_reflog(const char *refname, const unsigned char *sha1,
> @@ -460,7 +460,7 @@ static int expire_reflog(const char *refname, const unsigned char *sha1,
>  		if (close_lock_file(&reflog_lock)) {
>  			status |= error("Couldn't write %s: %s", log_file,
>  					strerror(errno));
> -		} else if (cmd->updateref &&
> +		} else if ((flags & EXPIRE_REFLOGS_UPDATE_REF) &&
>  			(write_in_full(lock->lock_fd,
>  				sha1_to_hex(cb.last_kept_sha1), 40) != 40 ||
>  			 write_str_in_full(lock->lock_fd, "\n") != 1 ||
> @@ -471,7 +471,7 @@ static int expire_reflog(const char *refname, const unsigned char *sha1,
>  		} else if (commit_lock_file(&reflog_lock)) {
>  			status |= error("cannot rename %s.lock to %s",
>  					log_file, log_file);
> -		} else if (cmd->updateref && commit_ref(lock)) {
> +		} else if ((flags & EXPIRE_REFLOGS_UPDATE_REF) && commit_ref(lock)) {
>  			status |= error("Couldn't set %s", lock->ref_name);
>  		}
>  	}
> @@ -663,7 +663,7 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
>  		else if (!strcmp(arg, "--rewrite"))
>  			cb.rewrite = 1;
>  		else if (!strcmp(arg, "--updateref"))
> -			cb.updateref = 1;
> +			flags |= EXPIRE_REFLOGS_UPDATE_REF;
>  		else if (!strcmp(arg, "--all"))
>  			do_all = 1;
>  		else if (!strcmp(arg, "--verbose"))
> @@ -745,7 +745,7 @@ static int cmd_reflog_delete(int argc, const char **argv, const char *prefix)
>  		else if (!strcmp(arg, "--rewrite"))
>  			cb.rewrite = 1;
>  		else if (!strcmp(arg, "--updateref"))
> -			cb.updateref = 1;
> +			flags |= EXPIRE_REFLOGS_UPDATE_REF;
>  		else if (!strcmp(arg, "--verbose"))
>  			cb.verbose = 1;
>  		else if (!strcmp(arg, "--")) {
> -- 
> 2.1.3
> 
