From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 19/23] expire_reflog(): treat the policy callback data as
 opaque
Date: Mon, 8 Dec 2014 15:12:42 -0800
Message-ID: <20141208231242.GK25562@google.com>
References: <1417734515-11812-1-git-send-email-mhagger@alum.mit.edu>
 <1417734515-11812-20-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Dec 09 00:12:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xy7U5-0004no-R1
	for gcvg-git-2@plane.gmane.org; Tue, 09 Dec 2014 00:12:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753135AbaLHXMo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Dec 2014 18:12:44 -0500
Received: from mail-oi0-f73.google.com ([209.85.218.73]:51449 "EHLO
	mail-oi0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751738AbaLHXMn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Dec 2014 18:12:43 -0500
Received: by mail-oi0-f73.google.com with SMTP id a141so650013oig.0
        for <git@vger.kernel.org>; Mon, 08 Dec 2014 15:12:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Vx2mc0Ynma+vjSr4woVil1ZqUU+QrObppxwS7D1unpM=;
        b=KJha+MzG8mAHh9sbfkZ0C4SiZu5t5KrUV0gSjT3EpgeyyGd4AS8DIDqYZ0Cs5eVByv
         A2ivgfWQGzBQofgsy7KR9ahXg97AIQjKAfIbrmAaOUMC2M16Ga1AE9394N5j0oX9h20f
         tjJ+QXYC4NbHChpYtLHhOsPYxvXMj9tayfJQTzuwGBhphzrGY6ijeYMGqyKMsMAFixXD
         SXBIPtjmnXvIUgfDUVUZn394CNTCRiYZDvVHeRY6bm8zn/4QftkhqJAaZQsAOqnHdL67
         MLwpbqbqlFr2xlQXe/9uVcxL7cdF5GD4JJjPMCo6pU++UjpNKRPJX/CfMRAllQMA8R3j
         wZfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=Vx2mc0Ynma+vjSr4woVil1ZqUU+QrObppxwS7D1unpM=;
        b=TNKkYpXBRMX0TW2icXFqkmN/E0GxCuwLQFHWWFTVX42eil1JMbPXT1tnabKlr9b600
         R3qwc7rzzbR/GFteRlUn3ZtyIOYZo0rGPLXCIEVFVcquuiIUbaQF7NQsf4Ith+Rpxmii
         +g3hBavNNefAit+5B+N9hdsYVkcIBuoRcxJg0NS8MSMMWGDA5bAblEkS1N3GwWtkI+np
         IRK6e9hlIHugjM5rDz8AeMjTO6n6jHKbAxyl8j1+HVnrGq7k4O1iq4Qli08AVpc1sABu
         0QTEf0MGosmWIqAMhjVzVujmFO3kns1+S3EWy22urGDXh/BOsuGSQZKrHyV7lPA9rLmO
         lTNA==
X-Gm-Message-State: ALoCoQmq4fw5h1UDyCPC7ipI4KmkmPElvXvwPrN/fSzOkLKncsAcybVmcqOspYYximUnEr8x2c3h
X-Received: by 10.182.130.162 with SMTP id of2mr33120734obb.33.1418080363154;
        Mon, 08 Dec 2014 15:12:43 -0800 (PST)
Received: from corpmail-nozzle1-1.hot.corp.google.com ([100.108.1.104])
        by gmr-mx.google.com with ESMTPS id s23si1699474yhf.0.2014.12.08.15.12.42
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Dec 2014 15:12:43 -0800 (PST)
Received: from sbeller.mtv.corp.google.com ([172.27.69.125])
	by corpmail-nozzle1-1.hot.corp.google.com with ESMTP id 4phu9qZN.1; Mon, 08 Dec 2014 15:12:43 -0800
Received: by sbeller.mtv.corp.google.com (Postfix, from userid 279346)
	id 20524140BBD; Mon,  8 Dec 2014 15:12:42 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1417734515-11812-20-git-send-email-mhagger@alum.mit.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261096>

On Fri, Dec 05, 2014 at 12:08:31AM +0100, Michael Haggerty wrote:
> Now that expire_reflog() doesn't actually look in the
> expire_reflog_policy_cb data structure, we can make it opaque:
> 
> * Change its callers to pass it a pointer to an entire "struct
>   expire_reflog_policy_cb".
> 
> * Change it to pass the pointer through as a "void *".
> 
> * Change the policy functions, reflog_expiry_prepare(),
>   reflog_expiry_cleanup(), and should_expire_reflog_ent(), to accept
>   "void *cb_data" arguments and cast them to "struct
>   expire_reflog_policy_cb" internally.
> 
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>

Reviewed-by: Stefan Beller <sbeller@google.com>
> ---
>  builtin/reflog.c | 73 ++++++++++++++++++++++++++++----------------------------
>  1 file changed, 36 insertions(+), 37 deletions(-)
> 
> diff --git a/builtin/reflog.c b/builtin/reflog.c
> index 01b76d0..c30936bb 100644
> --- a/builtin/reflog.c
> +++ b/builtin/reflog.c
> @@ -43,7 +43,7 @@ struct expire_reflog_policy_cb {
>  	} unreachable_expire_kind;
>  	struct commit_list *mark_list;
>  	unsigned long mark_limit;
> -	struct cmd_reflog_expire_cb *cmd;
> +	struct cmd_reflog_expire_cb cmd;
>  	struct commit *tip_commit;
>  	struct commit_list *tips;
>  };
> @@ -309,22 +309,22 @@ static int should_expire_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
>  	struct expire_reflog_policy_cb *cb = cb_data;
>  	struct commit *old, *new;
>  
> -	if (timestamp < cb->cmd->expire_total)
> +	if (timestamp < cb->cmd.expire_total)
>  		return 1;
>  
>  	old = new = NULL;
> -	if (cb->cmd->stalefix &&
> +	if (cb->cmd.stalefix &&
>  	    (!keep_entry(&old, osha1) || !keep_entry(&new, nsha1)))
>  		return 1;
>  
> -	if (timestamp < cb->cmd->expire_unreachable) {
> +	if (timestamp < cb->cmd.expire_unreachable) {
>  		if (cb->unreachable_expire_kind == UE_ALWAYS)
>  			return 1;
>  		if (unreachable(cb, old, osha1) || unreachable(cb, new, nsha1))
>  			return 1;
>  	}
>  
> -	if (cb->cmd->recno && --(cb->cmd->recno) == 0)
> +	if (cb->cmd.recno && --(cb->cmd.recno) == 0)
>  		return 1;
>  
>  	return 0;
> @@ -378,9 +378,11 @@ static int push_tip_to_list(const char *refname, const unsigned char *sha1,
>  
>  static void reflog_expiry_prepare(const char *refname,
>  				  const unsigned char *sha1,
> -				  struct expire_reflog_policy_cb *cb)
> +				  void *cb_data)
>  {
> -	if (!cb->cmd->expire_unreachable || !strcmp(refname, "HEAD")) {
> +	struct expire_reflog_policy_cb *cb = cb_data;
> +
> +	if (!cb->cmd.expire_unreachable || !strcmp(refname, "HEAD")) {
>  		cb->tip_commit = NULL;
>  		cb->unreachable_expire_kind = UE_HEAD;
>  	} else {
> @@ -391,7 +393,7 @@ static void reflog_expiry_prepare(const char *refname,
>  			cb->unreachable_expire_kind = UE_NORMAL;
>  	}
>  
> -	if (cb->cmd->expire_unreachable <= cb->cmd->expire_total)
> +	if (cb->cmd.expire_unreachable <= cb->cmd.expire_total)
>  		cb->unreachable_expire_kind = UE_ALWAYS;
>  
>  	cb->mark_list = NULL;
> @@ -405,13 +407,15 @@ static void reflog_expiry_prepare(const char *refname,
>  		} else {
>  			commit_list_insert(cb->tip_commit, &cb->mark_list);
>  		}
> -		cb->mark_limit = cb->cmd->expire_total;
> +		cb->mark_limit = cb->cmd.expire_total;
>  		mark_reachable(cb);
>  	}
>  }
>  
> -static void reflog_expiry_cleanup(struct expire_reflog_policy_cb *cb)
> +static void reflog_expiry_cleanup(void *cb_data)
>  {
> +	struct expire_reflog_policy_cb *cb = cb_data;
> +
>  	if (cb->unreachable_expire_kind != UE_ALWAYS) {
>  		if (cb->unreachable_expire_kind == UE_HEAD) {
>  			struct commit_list *elem;
> @@ -427,19 +431,16 @@ static void reflog_expiry_cleanup(struct expire_reflog_policy_cb *cb)
>  static struct lock_file reflog_lock;
>  
>  static int expire_reflog(const char *refname, const unsigned char *sha1,
> -			 unsigned int flags, void *cb_data)
> +			 unsigned int flags, void *policy_cb_data)
>  {
> -	struct cmd_reflog_expire_cb *cmd = cb_data;
>  	struct expire_reflog_cb cb;
> -	struct expire_reflog_policy_cb policy_cb;
>  	struct ref_lock *lock;
>  	char *log_file;
>  	int status = 0;
>  
>  	memset(&cb, 0, sizeof(cb));
> -	memset(&policy_cb, 0, sizeof(policy_cb));
>  	cb.flags = flags;
> -	cb.policy_cb = &policy_cb;
> +	cb.policy_cb = policy_cb_data;
>  
>  	/*
>  	 * we take the lock for the ref itself to prevent it from
> @@ -462,11 +463,9 @@ static int expire_reflog(const char *refname, const unsigned char *sha1,
>  			goto failure;
>  	}
>  
> -	policy_cb.cmd = cmd;
> -
> -	reflog_expiry_prepare(refname, sha1, &policy_cb);
> +	reflog_expiry_prepare(refname, sha1, cb.policy_cb);
>  	for_each_reflog_ent(refname, expire_reflog_ent, &cb);
> -	reflog_expiry_cleanup(&policy_cb);
> +	reflog_expiry_cleanup(cb.policy_cb);
>  
>  	if (!(flags & EXPIRE_REFLOGS_DRY_RUN)) {
>  		if (close_lock_file(&reflog_lock)) {
> @@ -639,7 +638,7 @@ static void set_reflog_expiry_param(struct cmd_reflog_expire_cb *cb, int slot, c
>  
>  static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
>  {
> -	struct cmd_reflog_expire_cb cb;
> +	struct expire_reflog_policy_cb cb;
>  	unsigned long now = time(NULL);
>  	int i, status, do_all;
>  	int explicit_expiry = 0;
> @@ -653,25 +652,25 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
>  	do_all = status = 0;
>  	memset(&cb, 0, sizeof(cb));
>  
> -	cb.expire_total = default_reflog_expire;
> -	cb.expire_unreachable = default_reflog_expire_unreachable;
> +	cb.cmd.expire_total = default_reflog_expire;
> +	cb.cmd.expire_unreachable = default_reflog_expire_unreachable;
>  
>  	for (i = 1; i < argc; i++) {
>  		const char *arg = argv[i];
>  		if (!strcmp(arg, "--dry-run") || !strcmp(arg, "-n"))
>  			flags |= EXPIRE_REFLOGS_DRY_RUN;
>  		else if (starts_with(arg, "--expire=")) {
> -			if (parse_expiry_date(arg + 9, &cb.expire_total))
> +			if (parse_expiry_date(arg + 9, &cb.cmd.expire_total))
>  				die(_("'%s' is not a valid timestamp"), arg);
>  			explicit_expiry |= EXPIRE_TOTAL;
>  		}
>  		else if (starts_with(arg, "--expire-unreachable=")) {
> -			if (parse_expiry_date(arg + 21, &cb.expire_unreachable))
> +			if (parse_expiry_date(arg + 21, &cb.cmd.expire_unreachable))
>  				die(_("'%s' is not a valid timestamp"), arg);
>  			explicit_expiry |= EXPIRE_UNREACH;
>  		}
>  		else if (!strcmp(arg, "--stale-fix"))
> -			cb.stalefix = 1;
> +			cb.cmd.stalefix = 1;
>  		else if (!strcmp(arg, "--rewrite"))
>  			flags |= EXPIRE_REFLOGS_REWRITE;
>  		else if (!strcmp(arg, "--updateref"))
> @@ -695,11 +694,11 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
>  	 * even in older repository.  We cannot trust what's reachable
>  	 * from reflog if the repository was pruned with older git.
>  	 */
> -	if (cb.stalefix) {
> -		init_revisions(&cb.revs, prefix);
> +	if (cb.cmd.stalefix) {
> +		init_revisions(&cb.cmd.revs, prefix);
>  		if (flags & EXPIRE_REFLOGS_VERBOSE)
>  			printf("Marking reachable objects...");
> -		mark_reachable_objects(&cb.revs, 0, 0, NULL);
> +		mark_reachable_objects(&cb.cmd.revs, 0, 0, NULL);
>  		if (flags & EXPIRE_REFLOGS_VERBOSE)
>  			putchar('\n');
>  	}
> @@ -712,7 +711,7 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
>  		for_each_reflog(collect_reflog, &collected);
>  		for (i = 0; i < collected.nr; i++) {
>  			struct collected_reflog *e = collected.e[i];
> -			set_reflog_expiry_param(&cb, explicit_expiry, e->reflog);
> +			set_reflog_expiry_param(&cb.cmd, explicit_expiry, e->reflog);
>  			status |= expire_reflog(e->reflog, e->sha1, flags, &cb);
>  			free(e);
>  		}
> @@ -726,7 +725,7 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
>  			status |= error("%s points nowhere!", argv[i]);
>  			continue;
>  		}
> -		set_reflog_expiry_param(&cb, explicit_expiry, ref);
> +		set_reflog_expiry_param(&cb.cmd, explicit_expiry, ref);
>  		status |= expire_reflog(ref, sha1, flags, &cb);
>  	}
>  	return status;
> @@ -736,15 +735,15 @@ static int count_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
>  		const char *email, unsigned long timestamp, int tz,
>  		const char *message, void *cb_data)
>  {
> -	struct cmd_reflog_expire_cb *cb = cb_data;
> -	if (!cb->expire_total || timestamp < cb->expire_total)
> -		cb->recno++;
> +	struct expire_reflog_policy_cb *cb = cb_data;
> +	if (!cb->cmd.expire_total || timestamp < cb->cmd.expire_total)
> +		cb->cmd.recno++;
>  	return 0;
>  }
>  
>  static int cmd_reflog_delete(int argc, const char **argv, const char *prefix)
>  {
> -	struct cmd_reflog_expire_cb cb;
> +	struct expire_reflog_policy_cb cb;
>  	int i, status = 0;
>  	unsigned int flags = 0;
>  
> @@ -791,12 +790,12 @@ static int cmd_reflog_delete(int argc, const char **argv, const char *prefix)
>  
>  		recno = strtoul(spec + 2, &ep, 10);
>  		if (*ep == '}') {
> -			cb.recno = -recno;
> +			cb.cmd.recno = -recno;
>  			for_each_reflog_ent(ref, count_reflog_ent, &cb);
>  		} else {
> -			cb.expire_total = approxidate(spec + 2);
> +			cb.cmd.expire_total = approxidate(spec + 2);
>  			for_each_reflog_ent(ref, count_reflog_ent, &cb);
> -			cb.expire_total = 0;
> +			cb.cmd.expire_total = 0;
>  		}
>  
>  		status |= expire_reflog(ref, sha1, flags, &cb);
> -- 
> 2.1.3
> 
