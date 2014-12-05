From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 09/23] expire_reflog(): extract two policy-related
 functions
Date: Fri, 5 Dec 2014 11:02:59 -0800
Message-ID: <20141205190259.GA16682@google.com>
References: <1417734515-11812-1-git-send-email-mhagger@alum.mit.edu>
 <1417734515-11812-10-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Dec 05 20:03:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xwy9j-0002Vu-K0
	for gcvg-git-2@plane.gmane.org; Fri, 05 Dec 2014 20:03:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751510AbaLETDC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Dec 2014 14:03:02 -0500
Received: from mail-pa0-f73.google.com ([209.85.220.73]:62638 "EHLO
	mail-pa0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750975AbaLETDB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Dec 2014 14:03:01 -0500
Received: by mail-pa0-f73.google.com with SMTP id lj1so163850pab.0
        for <git@vger.kernel.org>; Fri, 05 Dec 2014 11:03:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=iQhW6U44ewIs5JmA1tJ12c5GcRlN2hTS6MSrJwNiuLg=;
        b=RWOzIZlm9NqYxVSYKvimOeJU9+9D3QbJhC3gzVb6qPIBWDs2KlgYnFGHrys2o3EP9s
         /p6aPIUQ63mEfXWRCFw9K1kK43uPw23ePhsX1sErnmkgKnQ8L7vzHf7yzxFuuhFuXIjd
         3U2uzHnF2TIZuOrrN8rN7cOiEqzLSKriOtPE4Tsc8GhEgMh+EdFx30RuS/pDctt+Vowo
         qMLEASycJPC4qGStCNzJCRZJwLnzmrOHzIK7A9f8jlz+gqIq41Js8Z3hP07sAcMQqDJU
         8M4ePXod5Z+hD5xAp38gMpl728pqu41ISLp4k1cqcTCPnIyZxuhzA5d/GgXPea1hQQ1z
         0TYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=iQhW6U44ewIs5JmA1tJ12c5GcRlN2hTS6MSrJwNiuLg=;
        b=UuW/FuVD5RuNfl7RXfZK2kKh7XOGW7MPNBF8ZLGCWa7Lw6kNMYP/aGZJhStLrAwoVq
         2ffU4NWG4dIXKtWC+t6BNpalH/TI/2tjs6abZGvY61YxVlS55UgZfQgehYZngLUNensS
         HgETzkc1yT7frHdpbzUtPjxzZ9QyEpPEFtNPfm5yKe9yx85ZGo6wQo6drQALY/KWcI17
         N8oj57+4gsNelAsLIsrhDMICRkk7ucTCN5x1wgY/ac8lU1Jo8gQkGiPQKSh5XSx8AA2f
         BQii3C6+HeO07VfeshFmV6L9Ro09SzkmMiMywhxftakg7CqH7Dd+J093gcXYP/cdryvH
         pimg==
X-Gm-Message-State: ALoCoQl8V2D3NfY/DF6QuCVcFLh6hIq/m6Q7pG96xDElD34fJz6WlHL3l5OZmfmtwGPTBs9Q5dHp
X-Received: by 10.66.100.166 with SMTP id ez6mr15292576pab.39.1417806180463;
        Fri, 05 Dec 2014 11:03:00 -0800 (PST)
Received: from corpmail-nozzle1-2.hot.corp.google.com ([100.108.1.103])
        by gmr-mx.google.com with ESMTPS id 5si1304234yhd.6.2014.12.05.11.02.59
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Dec 2014 11:03:00 -0800 (PST)
Received: from sbeller.mtv.corp.google.com ([172.27.69.125])
	by corpmail-nozzle1-2.hot.corp.google.com with ESMTP id Qy1Xvkwi.1; Fri, 05 Dec 2014 11:03:00 -0800
Received: by sbeller.mtv.corp.google.com (Postfix, from userid 279346)
	id 61417140B70; Fri,  5 Dec 2014 11:02:59 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1417734515-11812-10-git-send-email-mhagger@alum.mit.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260882>

On Fri, Dec 05, 2014 at 12:08:21AM +0100, Michael Haggerty wrote:
> Extract two functions, reflog_expiry_prepare() and
> reflog_expiry_cleanup(), from expire_reflog(). This is a further step
> towards separating the code for deciding on expiration policy from the
> code that manages the physical expiration.
> 
> This change requires a couple of local variables from expire_reflog()
> to be turned into fields of "struct expire_reflog_cb". More
> reorganization of the callback data will follow in later commits.
> 
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Reviewed-by: Stefan Beller <sbeller@google.com>

> ---
> In fact, the work done in reflog_expire_cleanup() doesn't really need
> to be done via a callback, because it doesn't need to be done while
> the reference lock is held. But the symmetry between prepare and
> cleanup is kindof nice. Perhaps some future policy decision will want
> to do some final work under the reference lock?
> 
> But it would be easy to get rid of this third callback function and
> have the callers do the work themselves after calling expire_reflog().
> I don't have a string feeling either way.
> 
>  builtin/reflog.c | 94 +++++++++++++++++++++++++++++++-------------------------
>  1 file changed, 52 insertions(+), 42 deletions(-)
> 
> diff --git a/builtin/reflog.c b/builtin/reflog.c
> index 7bc6e0f..ebfa635 100644
> --- a/builtin/reflog.c
> +++ b/builtin/reflog.c
> @@ -43,6 +43,8 @@ struct expire_reflog_cb {
>  	unsigned long mark_limit;
>  	struct cmd_reflog_expire_cb *cmd;
>  	unsigned char last_kept_sha1[20];
> +	struct commit *tip_commit;
> +	struct commit_list *tips;
>  };
>  
>  struct collected_reflog {
> @@ -363,6 +365,54 @@ static int push_tip_to_list(const char *refname, const unsigned char *sha1, int
>  	return 0;
>  }
>  
> +static void reflog_expiry_prepare(const char *refname,
> +				  const unsigned char *sha1,
> +				  struct expire_reflog_cb *cb)
> +{
> +	if (!cb->cmd->expire_unreachable || !strcmp(refname, "HEAD")) {
> +		cb->tip_commit = NULL;
> +		cb->unreachable_expire_kind = UE_HEAD;
> +	} else {
> +		cb->tip_commit = lookup_commit_reference_gently(sha1, 1);
> +		if (!cb->tip_commit)
> +			cb->unreachable_expire_kind = UE_ALWAYS;
> +		else
> +			cb->unreachable_expire_kind = UE_NORMAL;
> +	}
> +
> +	if (cb->cmd->expire_unreachable <= cb->cmd->expire_total)
> +		cb->unreachable_expire_kind = UE_ALWAYS;
> +
> +	cb->mark_list = NULL;
> +	cb->tips = NULL;
> +	if (cb->unreachable_expire_kind != UE_ALWAYS) {
> +		if (cb->unreachable_expire_kind == UE_HEAD) {
> +			struct commit_list *elem;
> +			for_each_ref(push_tip_to_list, &cb->tips);
> +			for (elem = cb->tips; elem; elem = elem->next)
> +				commit_list_insert(elem->item, &cb->mark_list);
> +		} else {
> +			commit_list_insert(cb->tip_commit, &cb->mark_list);
> +		}
> +		cb->mark_limit = cb->cmd->expire_total;
> +		mark_reachable(cb);
> +	}
> +}
> +
> +static void reflog_expiry_cleanup(struct expire_reflog_cb *cb)
> +{
> +	if (cb->unreachable_expire_kind != UE_ALWAYS) {
> +		if (cb->unreachable_expire_kind == UE_HEAD) {
> +			struct commit_list *elem;
> +			for (elem = cb->tips; elem; elem = elem->next)
> +				clear_commit_marks(elem->item, REACHABLE);
> +			free_commit_list(cb->tips);
> +		} else {
> +			clear_commit_marks(cb->tip_commit, REACHABLE);
> +		}
> +	}
> +}
> +
>  static struct lock_file reflog_lock;
>  
>  static int expire_reflog(const char *refname, const unsigned char *sha1, void *cb_data)
> @@ -371,8 +421,6 @@ static int expire_reflog(const char *refname, const unsigned char *sha1, void *c
>  	struct expire_reflog_cb cb;
>  	struct ref_lock *lock;
>  	char *log_file;
> -	struct commit *tip_commit;
> -	struct commit_list *tips;
>  	int status = 0;
>  
>  	memset(&cb, 0, sizeof(cb));
> @@ -400,47 +448,9 @@ static int expire_reflog(const char *refname, const unsigned char *sha1, void *c
>  
>  	cb.cmd = cmd;
>  
> -	if (!cmd->expire_unreachable || !strcmp(refname, "HEAD")) {
> -		tip_commit = NULL;
> -		cb.unreachable_expire_kind = UE_HEAD;
> -	} else {
> -		tip_commit = lookup_commit_reference_gently(sha1, 1);
> -		if (!tip_commit)
> -			cb.unreachable_expire_kind = UE_ALWAYS;
> -		else
> -			cb.unreachable_expire_kind = UE_NORMAL;
> -	}
> -
> -	if (cmd->expire_unreachable <= cmd->expire_total)
> -		cb.unreachable_expire_kind = UE_ALWAYS;
> -
> -	cb.mark_list = NULL;
> -	tips = NULL;
> -	if (cb.unreachable_expire_kind != UE_ALWAYS) {
> -		if (cb.unreachable_expire_kind == UE_HEAD) {
> -			struct commit_list *elem;
> -			for_each_ref(push_tip_to_list, &tips);
> -			for (elem = tips; elem; elem = elem->next)
> -				commit_list_insert(elem->item, &cb.mark_list);
> -		} else {
> -			commit_list_insert(tip_commit, &cb.mark_list);
> -		}
> -		cb.mark_limit = cmd->expire_total;
> -		mark_reachable(&cb);
> -	}
> -
> +	reflog_expiry_prepare(refname, sha1, &cb);
>  	for_each_reflog_ent(refname, expire_reflog_ent, &cb);
> -
> -	if (cb.unreachable_expire_kind != UE_ALWAYS) {
> -		if (cb.unreachable_expire_kind == UE_HEAD) {
> -			struct commit_list *elem;
> -			for (elem = tips; elem; elem = elem->next)
> -				clear_commit_marks(elem->item, REACHABLE);
> -			free_commit_list(tips);
> -		} else {
> -			clear_commit_marks(tip_commit, REACHABLE);
> -		}
> -	}
> +	reflog_expiry_cleanup(&cb);
>  
>  	if (cb.newlog) {
>  		if (close_lock_file(&reflog_lock)) {
> -- 
> 2.1.3
> 
