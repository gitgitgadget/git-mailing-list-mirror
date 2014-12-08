From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 10/23] expire_reflog(): add a "flags" argument
Date: Mon, 8 Dec 2014 14:35:11 -0800
Message-ID: <20141208223511.GB25562@google.com>
References: <1417734515-11812-1-git-send-email-mhagger@alum.mit.edu>
 <1417734515-11812-11-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Dec 08 23:35:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xy6tk-0003ns-DU
	for gcvg-git-2@plane.gmane.org; Mon, 08 Dec 2014 23:35:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752885AbaLHWfO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Dec 2014 17:35:14 -0500
Received: from mail-vc0-f202.google.com ([209.85.220.202]:62375 "EHLO
	mail-vc0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752039AbaLHWfN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Dec 2014 17:35:13 -0500
Received: by mail-vc0-f202.google.com with SMTP id hy10so317481vcb.1
        for <git@vger.kernel.org>; Mon, 08 Dec 2014 14:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=2JvO4GWgcyN5aiR1vzUH34Hk+k0KHIxYzq+kg2GxYV4=;
        b=HI3Bnp+8sc220ugrBVuz+7qAo2B0eLOj3inZLCsDYshVHnvpNhhDyrDvkb+8l6A0ib
         MxmFgZV6nbOP+md7sBoxnVOP5n2hXiWJUcuQlus3MAY3zraSEpKo06RrJiWH9L/l0at0
         6WBW8IwHCLnOXR/4hHXQGHkgfsQskKF9bNA44fKtqR1GDhW/FwtppduHt1eQGgQZ1G67
         Him/kFaoB0LGDyQGxBnbeqbHSX9doRO9wG4IKcA7LdSkzc3/2Gn/kR+ppjOyt0SfKMyg
         o/p7HeX9csPztjyhjvpko9gcEBezcpkrfeX5K10+U9ZOT3V2nSGO6p/c+wh8hkhJ6Smy
         PaIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=2JvO4GWgcyN5aiR1vzUH34Hk+k0KHIxYzq+kg2GxYV4=;
        b=NEk8qk/xTtH3/FBdcEE/a+eAQyaejmHM5yhX5IwxqdB8m0BUmFuOJI/aJhjUai2YgR
         wLNm4FaK3RBC8nPF4Xjs1SJuDlfnmSigGjc+RP9+IVOYiv8S2Na9MtIqU55e9Tq2hjft
         0UCwTEffAC87okalHS6+Ay1Su5Nk0AStsXEMzW4DN2f8KlEK781YeqbjEvTUdXr9qnrE
         Vy3vnOWAtIRGz2Lfd80SQphxPvgASZRt8S6cVXsPxY0W0G9f+VRf7UwgJ1D0iDjN251C
         Fjf1tUb2oqDGNO4AkF/Fsu8vtbcjtU+3nokZA+xxUJxWiYEc+4XDZLyFKWJL++ORy1vV
         0sKQ==
X-Gm-Message-State: ALoCoQlbYwYJ5CkHwixnYwgTyL0eWlvzm6dNaItq6EVv4l0CuKPfexXTcmDrIWNV5Dk+HsQcvvCc
X-Received: by 10.52.35.238 with SMTP id l14mr30931147vdj.8.1418078112117;
        Mon, 08 Dec 2014 14:35:12 -0800 (PST)
Received: from corpmail-nozzle1-2.hot.corp.google.com ([100.108.1.103])
        by gmr-mx.google.com with ESMTPS id 5si1692228yhd.6.2014.12.08.14.35.11
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Dec 2014 14:35:12 -0800 (PST)
Received: from sbeller.mtv.corp.google.com ([172.27.69.125])
	by corpmail-nozzle1-2.hot.corp.google.com with ESMTP id 4YnJ4ZEz.1; Mon, 08 Dec 2014 14:35:12 -0800
Received: by sbeller.mtv.corp.google.com (Postfix, from userid 279346)
	id 39EA0140BBD; Mon,  8 Dec 2014 14:35:11 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1417734515-11812-11-git-send-email-mhagger@alum.mit.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261087>

On Fri, Dec 05, 2014 at 12:08:22AM +0100, Michael Haggerty wrote:
> We want to separate the options relevant to the expiry machinery from
> the options affecting the expiration policy. So add a "flags" argument
> to expire_reflog() to hold the former.
> 
> The argument doesn't yet do anything.
> 
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>

Reviewed-by: <sbeller@google.com>

> ---
>  builtin/reflog.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/builtin/reflog.c b/builtin/reflog.c
> index ebfa635..319f0d2 100644
> --- a/builtin/reflog.c
> +++ b/builtin/reflog.c
> @@ -415,7 +415,8 @@ static void reflog_expiry_cleanup(struct expire_reflog_cb *cb)
>  
>  static struct lock_file reflog_lock;
>  
> -static int expire_reflog(const char *refname, const unsigned char *sha1, void *cb_data)
> +static int expire_reflog(const char *refname, const unsigned char *sha1,
> +			 unsigned int flags, void *cb_data)
>  {
>  	struct cmd_reflog_expire_cb *cmd = cb_data;
>  	struct expire_reflog_cb cb;
> @@ -627,6 +628,7 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
>  	unsigned long now = time(NULL);
>  	int i, status, do_all;
>  	int explicit_expiry = 0;
> +	unsigned int flags = 0;
>  
>  	default_reflog_expire_unreachable = now - 30 * 24 * 3600;
>  	default_reflog_expire = now - 90 * 24 * 3600;
> @@ -696,7 +698,7 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
>  		for (i = 0; i < collected.nr; i++) {
>  			struct collected_reflog *e = collected.e[i];
>  			set_reflog_expiry_param(&cb, explicit_expiry, e->reflog);
> -			status |= expire_reflog(e->reflog, e->sha1, &cb);
> +			status |= expire_reflog(e->reflog, e->sha1, flags, &cb);
>  			free(e);
>  		}
>  		free(collected.e);
> @@ -710,7 +712,7 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
>  			continue;
>  		}
>  		set_reflog_expiry_param(&cb, explicit_expiry, ref);
> -		status |= expire_reflog(ref, sha1, &cb);
> +		status |= expire_reflog(ref, sha1, flags, &cb);
>  	}
>  	return status;
>  }
> @@ -729,6 +731,7 @@ static int cmd_reflog_delete(int argc, const char **argv, const char *prefix)
>  {
>  	struct cmd_reflog_expire_cb cb;
>  	int i, status = 0;
> +	unsigned int flags = 0;
>  
>  	memset(&cb, 0, sizeof(cb));
>  
> @@ -781,7 +784,7 @@ static int cmd_reflog_delete(int argc, const char **argv, const char *prefix)
>  			cb.expire_total = 0;
>  		}
>  
> -		status |= expire_reflog(ref, sha1, &cb);
> +		status |= expire_reflog(ref, sha1, flags, &cb);
>  		free(ref);
>  	}
>  	return status;
> -- 
> 2.1.3
> 
