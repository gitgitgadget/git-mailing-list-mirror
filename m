From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 16/23] expire_reflog(): move verbose to flags argument
Date: Mon, 8 Dec 2014 14:56:30 -0800
Message-ID: <20141208225630.GH25562@google.com>
References: <1417734515-11812-1-git-send-email-mhagger@alum.mit.edu>
 <1417734515-11812-17-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Dec 08 23:56:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xy7EQ-0005gJ-TQ
	for gcvg-git-2@plane.gmane.org; Mon, 08 Dec 2014 23:56:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755938AbaLHW4e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Dec 2014 17:56:34 -0500
Received: from mail-pa0-f73.google.com ([209.85.220.73]:54556 "EHLO
	mail-pa0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754066AbaLHW4c (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Dec 2014 17:56:32 -0500
Received: by mail-pa0-f73.google.com with SMTP id lj1so800522pab.0
        for <git@vger.kernel.org>; Mon, 08 Dec 2014 14:56:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=XL8il84PlmSnJ2HlCbq844WPV5y/9GT2a9ZF/AyPxM8=;
        b=HVLDe5LXN47vkzGo7K3GilF6ySjpYA95jIBcw3shBRmFU2crHn33vlNQ/V50KE25R+
         6hunZZtHWr+9RWz8GSls+4Ml7TDzpv0TQ4soZHDLBPPEAsjofXB1kbs3AYCo8Mjf7Ngp
         A50MKzkbpHKbkWTZkuLlEDsSt4Rl4f76n0agNKdO+ggqmq2iyXlneBnHnzOoVm9+VcFE
         W+3O/DHrN29RkklfiQc1ivHHl15tVwDH4O1pOfrvUE3UpVI8FyjRGjnUdRw+vZGRhQsa
         HHhU8pQ2c2KnYethfhy1G/YW+bbnh0CsKO+4HePpVFTaL0kcacGOgA++Awr/JEaSR87j
         oIPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=XL8il84PlmSnJ2HlCbq844WPV5y/9GT2a9ZF/AyPxM8=;
        b=M7rfSliSrenRAjVdteNeYkqrOFGm+a60ovTKhEiSes6+w+c4yyAVUUUu1cDcEW+OwD
         ExAOMRuEHK+fnqcbALnM40rI0drSKfM3N6VIqZLoLLmrIPXJhpO/AfYAvkFn4StobGiL
         Jtnj1RRoNPZ45Z/Z1oJt+ooWuMz1TYEbFcoYL3kkDCD9wVKZMtqWfdt/3Fmtyj7VFZB8
         poCP4AKk+MqpxuhPep1rJpFy5Fs+4HxsOza+lrgAexo/LUowd3t3KdaS66Rz3e3zVUmx
         oD9rBB9bqFL6OilWVCmI+dwLARZJ7iFAQ/j5AxQvgrrQGCAoP7o0ub5/ECuqAFOCBWHG
         FGyw==
X-Gm-Message-State: ALoCoQmpcA+z9h+Z1HkmHXVbzO70Bqreq/JrWwEB3WLidINSGad1THuBHKImBGdNgy0HrTHM2mq4
X-Received: by 10.69.17.233 with SMTP id gh9mr32665137pbd.9.1418079391922;
        Mon, 08 Dec 2014 14:56:31 -0800 (PST)
Received: from corpmail-nozzle1-2.hot.corp.google.com ([100.108.1.103])
        by gmr-mx.google.com with ESMTPS id e24si1695665yhe.3.2014.12.08.14.56.31
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Dec 2014 14:56:31 -0800 (PST)
Received: from sbeller.mtv.corp.google.com ([172.27.69.125])
	by corpmail-nozzle1-2.hot.corp.google.com with ESMTP id fG1ifevj.1; Mon, 08 Dec 2014 14:56:31 -0800
Received: by sbeller.mtv.corp.google.com (Postfix, from userid 279346)
	id EB04A140BBD; Mon,  8 Dec 2014 14:56:30 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1417734515-11812-17-git-send-email-mhagger@alum.mit.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261093>

On Fri, Dec 05, 2014 at 12:08:28AM +0100, Michael Haggerty wrote:
> The policy objects don't care about "--verbose". So move it to
> expire_reflog()'s flags parameter.
> 
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>

Reviewed-by: Stefan Beller <sbeller@google.com>

> ---
>  builtin/reflog.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/builtin/reflog.c b/builtin/reflog.c
> index 1512b67..cc7a220 100644
> --- a/builtin/reflog.c
> +++ b/builtin/reflog.c
> @@ -20,11 +20,16 @@ static const char reflog_delete_usage[] =
>  static unsigned long default_reflog_expire;
>  static unsigned long default_reflog_expire_unreachable;
>  
> +enum expire_reflog_flags {
> +	EXPIRE_REFLOGS_DRY_RUN = 1 << 0,
> +	EXPIRE_REFLOGS_UPDATE_REF = 1 << 1,
> +	EXPIRE_REFLOGS_VERBOSE = 1 << 2
> +};
> +
>  struct cmd_reflog_expire_cb {
>  	struct rev_info revs;
>  	int stalefix;
>  	int rewrite;
> -	int verbose;
>  	unsigned long expire_total;
>  	unsigned long expire_unreachable;
>  	int recno;
> @@ -339,7 +344,7 @@ static int expire_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
>  				     message, policy_cb)) {
>  		if (!policy_cb->newlog)
>  			printf("would prune %s", message);
> -		else if (policy_cb->cmd->verbose)
> +		else if (cb->flags & EXPIRE_REFLOGS_VERBOSE)
>  			printf("prune %s", message);
>  	} else {
>  		if (policy_cb->newlog) {
> @@ -351,7 +356,7 @@ static int expire_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
>  				message);
>  			hashcpy(policy_cb->last_kept_sha1, nsha1);
>  		}
> -		if (policy_cb->cmd->verbose)
> +		if (cb->flags & EXPIRE_REFLOGS_VERBOSE)
>  			printf("keep %s", message);
>  	}
>  	return 0;
> @@ -421,11 +426,6 @@ static void reflog_expiry_cleanup(struct expire_reflog_policy_cb *cb)
>  
>  static struct lock_file reflog_lock;
>  
> -enum expire_reflog_flags {
> -	EXPIRE_REFLOGS_DRY_RUN = 1 << 0,
> -	EXPIRE_REFLOGS_UPDATE_REF = 1 << 1
> -};
> -
>  static int expire_reflog(const char *refname, const unsigned char *sha1,
>  			 unsigned int flags, void *cb_data)
>  {
> @@ -679,7 +679,7 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
>  		else if (!strcmp(arg, "--all"))
>  			do_all = 1;
>  		else if (!strcmp(arg, "--verbose"))
> -			cb.verbose = 1;
> +			flags |= EXPIRE_REFLOGS_VERBOSE;
>  		else if (!strcmp(arg, "--")) {
>  			i++;
>  			break;
> @@ -697,10 +697,10 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
>  	 */
>  	if (cb.stalefix) {
>  		init_revisions(&cb.revs, prefix);
> -		if (cb.verbose)
> +		if (flags & EXPIRE_REFLOGS_VERBOSE)
>  			printf("Marking reachable objects...");
>  		mark_reachable_objects(&cb.revs, 0, 0, NULL);
> -		if (cb.verbose)
> +		if (flags & EXPIRE_REFLOGS_VERBOSE)
>  			putchar('\n');
>  	}
>  
> @@ -759,7 +759,7 @@ static int cmd_reflog_delete(int argc, const char **argv, const char *prefix)
>  		else if (!strcmp(arg, "--updateref"))
>  			flags |= EXPIRE_REFLOGS_UPDATE_REF;
>  		else if (!strcmp(arg, "--verbose"))
> -			cb.verbose = 1;
> +			flags |= EXPIRE_REFLOGS_VERBOSE;
>  		else if (!strcmp(arg, "--")) {
>  			i++;
>  			break;
> -- 
> 2.1.3
> 
