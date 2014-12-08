From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 14/23] struct expire_reflog_cb: a new callback data type
Date: Mon, 8 Dec 2014 14:49:41 -0800
Message-ID: <20141208224941.GF25562@google.com>
References: <1417734515-11812-1-git-send-email-mhagger@alum.mit.edu>
 <1417734515-11812-15-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Dec 08 23:49:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xy77j-0002Gg-Ka
	for gcvg-git-2@plane.gmane.org; Mon, 08 Dec 2014 23:49:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755865AbaLHWto (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Dec 2014 17:49:44 -0500
Received: from mail-ob0-f201.google.com ([209.85.214.201]:51519 "EHLO
	mail-ob0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751405AbaLHWtn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Dec 2014 17:49:43 -0500
Received: by mail-ob0-f201.google.com with SMTP id nt9so649860obb.2
        for <git@vger.kernel.org>; Mon, 08 Dec 2014 14:49:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=0oUQEqOyOYLKVOlhZ8pvv7PeUcqZsrWW8KmDsB3lxxI=;
        b=NwYOqLeP5jLvdCib7CNsuEivEAIx0m2RKeOrqfa3zV8fOVln4b7j6Otwt/WBRk4LxU
         iVNVjSdFSItjGGI7Z0XfOoPtUJAa3AB3GRPeC6MeodJsmi69CZMwJGYyVdGy6hZA+Z5H
         w3WHMpOLSuXddk7uqdBY+rratf6JT5kBEh6SefRxh4WRUigg0OxFiDOj5EXpxpzHCbTp
         yFFL2MzP0EfWC8bvJkOsi4Nqer2P7A30obvFtls/n5/YOtUWZQAWIg4t/yJ5EGMLSZ50
         X1l0Z7WI9VomQz416um2+WE6+7njXGHD5QDSFkGgcplJ21Ux3kH+8x2HRRmqFAW1kJVc
         Yrjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=0oUQEqOyOYLKVOlhZ8pvv7PeUcqZsrWW8KmDsB3lxxI=;
        b=aIk+dNaTtJIoJPhS8eY5DGZLN3LlLL6kGSwGvBZNxhxRVhi8alkuvtFNOG+lX+WNAX
         yfLNBuZoGIX0ONH31N75v4SnXj8isbSdfGaaWmVqMQxrIsGZeWkrQHkS9TghNVANkOcJ
         dHowf08wvIqX79ofXujFoIGmp7kbdc7S2LV68tP5g7/55fh0/EO9Fgzy0MayjgVtbJqG
         eTtDU+UiKyuI5jHCjvbhc7TFo4M7xoWElYId8O3EHTgkr2ETkqh3U9bCqJ8UE3OC5Kg7
         2sYwdQf7V7owPEoAarZjfmsAcUBK1YcLm/8GrirbeJz/0/tFN4a/9jyPbAYSO6GMUIkE
         bgYA==
X-Gm-Message-State: ALoCoQk8MttQK5Y3EAr9GWRQUgwZ5ThH7H9B4EWtWwq+Eujz6HUHDoA8qqpZTpn9WEg0l2WApcV6
X-Received: by 10.42.52.208 with SMTP id k16mr35153487icg.23.1418078982630;
        Mon, 08 Dec 2014 14:49:42 -0800 (PST)
Received: from corpmail-nozzle1-2.hot.corp.google.com ([100.108.1.103])
        by gmr-mx.google.com with ESMTPS id t24si1695290yht.2.2014.12.08.14.49.42
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Dec 2014 14:49:42 -0800 (PST)
Received: from sbeller.mtv.corp.google.com ([172.27.69.125])
	by corpmail-nozzle1-2.hot.corp.google.com with ESMTP id Tf3orUNg.1; Mon, 08 Dec 2014 14:49:42 -0800
Received: by sbeller.mtv.corp.google.com (Postfix, from userid 279346)
	id 8EE02140BBD; Mon,  8 Dec 2014 14:49:41 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1417734515-11812-15-git-send-email-mhagger@alum.mit.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261091>

On Fri, Dec 05, 2014 at 12:08:26AM +0100, Michael Haggerty wrote:
> Add a new data type, "struct expire_reflog_cb", for holding the data
> that expire_reflog() passes to expire_reflog_ent() via
> for_each_reflog_ent(). For now it only holds a pointer to "struct
> expire_reflog_policy_cb". In future commits we will move some data
> from the latter to the former.
> 
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>

Reviewed-by: <sbeller@google.com>
> ---
>  builtin/reflog.c | 43 ++++++++++++++++++++++++++-----------------
>  1 file changed, 26 insertions(+), 17 deletions(-)
> 
> diff --git a/builtin/reflog.c b/builtin/reflog.c
> index 3538e4b..5dfa53a 100644
> --- a/builtin/reflog.c
> +++ b/builtin/reflog.c
> @@ -45,10 +45,15 @@ struct expire_reflog_policy_cb {
>  	struct commit_list *tips;
>  };
>  
> +struct expire_reflog_cb {
> +	void *policy_cb;
> +};
> +
>  struct collected_reflog {
>  	unsigned char sha1[20];
>  	char reflog[FLEX_ARRAY];
>  };
> +
>  struct collect_reflog_cb {
>  	struct collected_reflog **e;
>  	int alloc;
> @@ -323,28 +328,29 @@ static int expire_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
>  		const char *email, unsigned long timestamp, int tz,
>  		const char *message, void *cb_data)
>  {
> -	struct expire_reflog_policy_cb *cb = cb_data;
> +	struct expire_reflog_cb *cb = cb_data;
> +	struct expire_reflog_policy_cb *policy_cb = cb->policy_cb;
>  
> -	if (cb->cmd->rewrite)
> -		osha1 = cb->last_kept_sha1;
> +	if (policy_cb->cmd->rewrite)
> +		osha1 = policy_cb->last_kept_sha1;
>  
>  	if (should_expire_reflog_ent(osha1, nsha1, email, timestamp, tz,
> -				     message, cb_data)) {
> -		if (!cb->newlog)
> +				     message, policy_cb)) {
> +		if (!policy_cb->newlog)
>  			printf("would prune %s", message);
> -		else if (cb->cmd->verbose)
> +		else if (policy_cb->cmd->verbose)
>  			printf("prune %s", message);
>  	} else {
> -		if (cb->newlog) {
> +		if (policy_cb->newlog) {
>  			char sign = (tz < 0) ? '-' : '+';
>  			int zone = (tz < 0) ? (-tz) : tz;
> -			fprintf(cb->newlog, "%s %s %s %lu %c%04d\t%s",
> +			fprintf(policy_cb->newlog, "%s %s %s %lu %c%04d\t%s",
>  				sha1_to_hex(osha1), sha1_to_hex(nsha1),
>  				email, timestamp, sign, zone,
>  				message);
> -			hashcpy(cb->last_kept_sha1, nsha1);
> +			hashcpy(policy_cb->last_kept_sha1, nsha1);
>  		}
> -		if (cb->cmd->verbose)
> +		if (policy_cb->cmd->verbose)
>  			printf("keep %s", message);
>  	}
>  	return 0;
> @@ -423,12 +429,15 @@ static int expire_reflog(const char *refname, const unsigned char *sha1,
>  			 unsigned int flags, void *cb_data)
>  {
>  	struct cmd_reflog_expire_cb *cmd = cb_data;
> -	struct expire_reflog_policy_cb cb;
> +	struct expire_reflog_cb cb;
> +	struct expire_reflog_policy_cb policy_cb;
>  	struct ref_lock *lock;
>  	char *log_file;
>  	int status = 0;
>  
>  	memset(&cb, 0, sizeof(cb));
> +	memset(&policy_cb, 0, sizeof(policy_cb));
> +	cb.policy_cb = &policy_cb;
>  
>  	/*
>  	 * we take the lock for the ref itself to prevent it from
> @@ -446,16 +455,16 @@ static int expire_reflog(const char *refname, const unsigned char *sha1,
>  	if (!(flags & EXPIRE_REFLOGS_DRY_RUN)) {
>  		if (hold_lock_file_for_update(&reflog_lock, log_file, 0) < 0)
>  			goto failure;
> -		cb.newlog = fdopen_lock_file(&reflog_lock, "w");
> -		if (!cb.newlog)
> +		policy_cb.newlog = fdopen_lock_file(&reflog_lock, "w");
> +		if (!policy_cb.newlog)
>  			goto failure;
>  	}
>  
> -	cb.cmd = cmd;
> +	policy_cb.cmd = cmd;
>  
> -	reflog_expiry_prepare(refname, sha1, &cb);
> +	reflog_expiry_prepare(refname, sha1, &policy_cb);
>  	for_each_reflog_ent(refname, expire_reflog_ent, &cb);
> -	reflog_expiry_cleanup(&cb);
> +	reflog_expiry_cleanup(&policy_cb);
>  
>  	if (!(flags & EXPIRE_REFLOGS_DRY_RUN)) {
>  		if (close_lock_file(&reflog_lock)) {
> @@ -463,7 +472,7 @@ static int expire_reflog(const char *refname, const unsigned char *sha1,
>  					strerror(errno));
>  		} else if ((flags & EXPIRE_REFLOGS_UPDATE_REF) &&
>  			(write_in_full(lock->lock_fd,
> -				sha1_to_hex(cb.last_kept_sha1), 40) != 40 ||
> +				sha1_to_hex(policy_cb.last_kept_sha1), 40) != 40 ||
>  			 write_str_in_full(lock->lock_fd, "\n") != 1 ||
>  			 close_ref(lock) < 0)) {
>  			status |= error("Couldn't write %s",
> -- 
> 2.1.3
> 
