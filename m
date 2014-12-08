From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 18/23] Move newlog and last_kept_sha1 to "struct
 expire_reflog_cb"
Date: Mon, 8 Dec 2014 14:59:15 -0800
Message-ID: <20141208225915.GJ25562@google.com>
References: <1417734515-11812-1-git-send-email-mhagger@alum.mit.edu>
 <1417734515-11812-19-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Dec 08 23:59:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xy7Gz-0006uU-PG
	for gcvg-git-2@plane.gmane.org; Mon, 08 Dec 2014 23:59:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754248AbaLHW7S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Dec 2014 17:59:18 -0500
Received: from mail-ie0-f202.google.com ([209.85.223.202]:40366 "EHLO
	mail-ie0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751967AbaLHW7R (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Dec 2014 17:59:17 -0500
Received: by mail-ie0-f202.google.com with SMTP id rl12so657255iec.1
        for <git@vger.kernel.org>; Mon, 08 Dec 2014 14:59:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Xs0udf2Kg5Mst1isWUiiu4Qq1bjXjm853JZ1ZwadHWQ=;
        b=M3PLmFLEVZqx7TAsyxM5lLrJ0TDYZDRkABs9M+QnNbhop0XQgNRnrlPRynf15oc4l3
         p4zozmqkaLjxkJK8SGm+0qMdVbQgTVOlfpxs4V+5w1en29cz8csT3MJmv7iX86uuSdd7
         7sYQO+kr/yAkbaj0RO12BnqybXWt+5VUFPWVh1KVfqy0sVQuqnv+O96IXTkZ8rLj6ibh
         MnJo1W5zLQrcZdO8hAqCrSxGfKqTh3np3fjecIFI9ZWfJz0FJbniPtE2WQVvzOuilqHq
         Aw6e1Y1KWd/si0PxLRQn1F4/5u5G0GmBzSZJrnitXKMX0oX7MvR5UVN3HdqIIlDP2AiF
         kyUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=Xs0udf2Kg5Mst1isWUiiu4Qq1bjXjm853JZ1ZwadHWQ=;
        b=ebdHDlG+ks/2kNJHC+xfNineYGNx9SZJZTL9XfahPDaHlrwXT786HxeNqdRnhps+2x
         a26DffL+8fZW0f0Xd3au2sWfe3Scg3j7eDErjMOGmXkOTWOBKE3svnEHNBycB+5qX0wz
         LFpXjzRhXAoawP6fjSd60IGktnZmeoy9D5JXZfffani5zP9uuES8BX/u9b/dS4Le9NyV
         T2CZtPkRhaID85cDvmndq15VQFX+TySESdbSOAOYA2X42AH4GSXAVRU40cR3HpTizEv0
         rb+25J5oR2vxtiMCXQmDhg5yir5JgSqwXgP/kSjiynOJWGdquBotLIURXEmEJQlpM3yz
         EPpg==
X-Gm-Message-State: ALoCoQmNX1NcKGh/sWeqDOEc/5gMENj4kKETJwZGZCLYQyPjxp+MxIcc+LY8QCK0aaYt/OMj0+9N
X-Received: by 10.42.6.71 with SMTP id 7mr34868788icz.19.1418079556658;
        Mon, 08 Dec 2014 14:59:16 -0800 (PST)
Received: from corpmail-nozzle1-1.hot.corp.google.com ([100.108.1.104])
        by gmr-mx.google.com with ESMTPS id t28si1696134yhb.4.2014.12.08.14.59.16
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Dec 2014 14:59:16 -0800 (PST)
Received: from sbeller.mtv.corp.google.com ([172.27.69.125])
	by corpmail-nozzle1-1.hot.corp.google.com with ESMTP id Qc2Jpypq.1; Mon, 08 Dec 2014 14:59:16 -0800
Received: by sbeller.mtv.corp.google.com (Postfix, from userid 279346)
	id C8C77140BBD; Mon,  8 Dec 2014 14:59:15 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1417734515-11812-19-git-send-email-mhagger@alum.mit.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261095>

On Fri, Dec 05, 2014 at 12:08:30AM +0100, Michael Haggerty wrote:
> These members are not needed by the policy functions.
> 
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>

Reviewed-by: Stefan Beller <sbeller@google.com>
> ---
>  builtin/reflog.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/builtin/reflog.c b/builtin/reflog.c
> index 6294406..01b76d0 100644
> --- a/builtin/reflog.c
> +++ b/builtin/reflog.c
> @@ -36,7 +36,6 @@ struct cmd_reflog_expire_cb {
>  };
>  
>  struct expire_reflog_policy_cb {
> -	FILE *newlog;
>  	enum {
>  		UE_NORMAL,
>  		UE_ALWAYS,
> @@ -45,7 +44,6 @@ struct expire_reflog_policy_cb {
>  	struct commit_list *mark_list;
>  	unsigned long mark_limit;
>  	struct cmd_reflog_expire_cb *cmd;
> -	unsigned char last_kept_sha1[20];
>  	struct commit *tip_commit;
>  	struct commit_list *tips;
>  };
> @@ -53,6 +51,8 @@ struct expire_reflog_policy_cb {
>  struct expire_reflog_cb {
>  	unsigned int flags;
>  	void *policy_cb;
> +	FILE *newlog;
> +	unsigned char last_kept_sha1[20];
>  };
>  
>  struct collected_reflog {
> @@ -338,23 +338,23 @@ static int expire_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
>  	struct expire_reflog_policy_cb *policy_cb = cb->policy_cb;
>  
>  	if (cb->flags & EXPIRE_REFLOGS_REWRITE)
> -		osha1 = policy_cb->last_kept_sha1;
> +		osha1 = cb->last_kept_sha1;
>  
>  	if (should_expire_reflog_ent(osha1, nsha1, email, timestamp, tz,
>  				     message, policy_cb)) {
> -		if (!policy_cb->newlog)
> +		if (!cb->newlog)
>  			printf("would prune %s", message);
>  		else if (cb->flags & EXPIRE_REFLOGS_VERBOSE)
>  			printf("prune %s", message);
>  	} else {
> -		if (policy_cb->newlog) {
> +		if (cb->newlog) {
>  			char sign = (tz < 0) ? '-' : '+';
>  			int zone = (tz < 0) ? (-tz) : tz;
> -			fprintf(policy_cb->newlog, "%s %s %s %lu %c%04d\t%s",
> +			fprintf(cb->newlog, "%s %s %s %lu %c%04d\t%s",
>  				sha1_to_hex(osha1), sha1_to_hex(nsha1),
>  				email, timestamp, sign, zone,
>  				message);
> -			hashcpy(policy_cb->last_kept_sha1, nsha1);
> +			hashcpy(cb->last_kept_sha1, nsha1);
>  		}
>  		if (cb->flags & EXPIRE_REFLOGS_VERBOSE)
>  			printf("keep %s", message);
> @@ -457,8 +457,8 @@ static int expire_reflog(const char *refname, const unsigned char *sha1,
>  	if (!(flags & EXPIRE_REFLOGS_DRY_RUN)) {
>  		if (hold_lock_file_for_update(&reflog_lock, log_file, 0) < 0)
>  			goto failure;
> -		policy_cb.newlog = fdopen_lock_file(&reflog_lock, "w");
> -		if (!policy_cb.newlog)
> +		cb.newlog = fdopen_lock_file(&reflog_lock, "w");
> +		if (!cb.newlog)
>  			goto failure;
>  	}
>  
> @@ -474,7 +474,7 @@ static int expire_reflog(const char *refname, const unsigned char *sha1,
>  					strerror(errno));
>  		} else if ((flags & EXPIRE_REFLOGS_UPDATE_REF) &&
>  			(write_in_full(lock->lock_fd,
> -				sha1_to_hex(policy_cb.last_kept_sha1), 40) != 40 ||
> +				sha1_to_hex(cb.last_kept_sha1), 40) != 40 ||
>  			 write_str_in_full(lock->lock_fd, "\n") != 1 ||
>  			 close_ref(lock) < 0)) {
>  			status |= error("Couldn't write %s",
> -- 
> 2.1.3
> 
