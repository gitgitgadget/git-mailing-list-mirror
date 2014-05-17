From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v10 18/44] branch.c: use ref transaction for all ref updates
Date: Sat, 17 May 2014 15:33:06 +0200
Message-ID: <53776512.7080504@alum.mit.edu>
References: <1400261852-31303-1-git-send-email-sahlberg@google.com> <1400261852-31303-19-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 17 15:33:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wleji-0007gZ-CF
	for gcvg-git-2@plane.gmane.org; Sat, 17 May 2014 15:33:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756513AbaEQNdK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 May 2014 09:33:10 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:44675 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754941AbaEQNdI (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 17 May 2014 09:33:08 -0400
X-AuditID: 1207440d-f79c26d000000b51-f0-53776513e7af
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 45.3A.02897.31567735; Sat, 17 May 2014 09:33:08 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB3A76.dip0.t-ipconnect.de [93.219.58.118])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s4HDX6on024835
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Sat, 17 May 2014 09:33:07 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.4.0
In-Reply-To: <1400261852-31303-19-git-send-email-sahlberg@google.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplleLIzCtJLcpLzFFi42IRYndR1BVJLQ82ePaV0aLrSjeTxb8JNQ5M
	Hgs2lXp83iQXwBTFbZOUWFIWnJmep2+XwJ1xfP1BpoLj4hXXHwo0MJ4Q6mLk4JAQMJE4sVG1
	i5ETyBSTuHBvPRuILSRwmVFi8hLfLkYuIPs8k8S7IzdZQBK8AtoSE2+9BitiEVCVaD30gRHE
	ZhPQlVjU08wEMlNUIEjiz1lFiHJBiZMzn4C1igjYSay/tZAZxBYWCJBYtXUVM8SuGqBV18HG
	cAq4Srzd9pQF4jRxiZ7GIJAws4COxLu+B8wQtrzE9rdzmCcwCsxCsmEWkrJZSMoWMDKvYpRL
	zCnN1c1NzMwpTk3WLU5OzMtLLdI10svNLNFLTSndxAgJTt4djP/XyRxiFOBgVOLh5bAtCxZi
	TSwrrsw9xCjJwaQkymsbWx4sxJeUn1KZkVicEV9UmpNafIhRgoNZSYR3txtQjjclsbIqtSgf
	JiXNwaIkzqu2RN1PSCA9sSQ1OzW1ILUIJivDwaEkwbsxGahRsCg1PbUiLTOnBCHNxMEJMpxL
	SqQ4NS8ltSixtCQjHhSh8cXAGAVJ8QDt3QbSzltckJgLFIVoPcWoy3HqzrE2JiGWvPy8VClx
	3gyQIgGQoozSPLgVsFT0ilEc6GNh3l0gVTzANAY36RXQEiagJW/2loIsKUlESEk1MNonx/8s
	Pbk155d4J0P2NDOFckGuZQm3hZ++iX5xqaM0WGXtId+C7EK9Oa1mez8Z8G05dTRwU9SckiP/
	Vhzv/X79xMPd/RsC9+u88ZDmW1dbO+nQ5dv119rbGdYHMh4KmFqz1G7D7xDDRs6Q 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249468>

On 05/16/2014 07:37 PM, Ronnie Sahlberg wrote:
> Change create_branch to use a ref transaction when creating the new branch.
> ref_transaction_create will check that the ref does not already exist and fail
> otherwise meaning that we no longer need to keep a lock on the ref during the
> setup_tracking. This simplifies the code since we can now do the transaction
> in one single step.
> 
> If the forcing flag is false then use ref_transaction_create since this will
> fail if the ref already exist. Otherwise use ref_transaction_update.

s/exist/exists/

And the references to ref_transaction_create() in the commit message are
obsolete.

> 
> This also fixes a race condition in the old code where two concurrent
> create_branch could race since the lock_any_ref_for_update/write_ref_sha1
> did not protect against the ref already existing. I.e. one thread could end up
> overwriting a branch even if the forcing flag is false.
> 
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
> ---
>  branch.c | 29 +++++++++++++++--------------
>  1 file changed, 15 insertions(+), 14 deletions(-)
> 
> diff --git a/branch.c b/branch.c
> index 660097b..8bf7588 100644
> --- a/branch.c
> +++ b/branch.c
> @@ -226,7 +226,6 @@ void create_branch(const char *head,
>  		   int force, int reflog, int clobber_head,
>  		   int quiet, enum branch_track track)
>  {
> -	struct ref_lock *lock = NULL;
>  	struct commit *commit;
>  	unsigned char sha1[20];
>  	char *real_ref, msg[PATH_MAX + 20];
> @@ -285,15 +284,6 @@ void create_branch(const char *head,
>  		die(_("Not a valid branch point: '%s'."), start_name);
>  	hashcpy(sha1, commit->object.sha1);
>  
> -	if (!dont_change_ref) {
> -		lock = lock_any_ref_for_update(ref.buf, NULL, 0, NULL);
> -		if (!lock)
> -			die_errno(_("Failed to lock ref for update"));
> -	}
> -
> -	if (reflog)
> -		log_all_ref_updates = 1;
> -
>  	if (forcing)
>  		snprintf(msg, sizeof msg, "branch: Reset to %s",
>  			 start_name);
> @@ -301,13 +291,24 @@ void create_branch(const char *head,
>  		snprintf(msg, sizeof msg, "branch: Created from %s",
>  			 start_name);
>  
> +	if (reflog)
> +		log_all_ref_updates = 1;
> +
> +	if (!dont_change_ref) {
> +		struct ref_transaction *transaction;
> +		struct strbuf err = STRBUF_INIT;
> +
> +		transaction = ref_transaction_begin();
> +		if (!transaction ||
> +		    ref_transaction_update(transaction, ref.buf, sha1,
> +					   null_sha1, 0, !forcing, &err) ||
> +		    ref_transaction_commit(transaction, msg, &err))
> +			die("%s", err.buf);
> +	}
> +
>  	if (real_ref && track)
>  		setup_tracking(ref.buf + 11, real_ref, track, quiet);
>  
> -	if (!dont_change_ref)
> -		if (write_ref_sha1(lock, sha1, msg) < 0)
> -			die_errno(_("Failed to write ref"));
> -
>  	strbuf_release(&ref);
>  	free(real_ref);
>  }
> 


-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
