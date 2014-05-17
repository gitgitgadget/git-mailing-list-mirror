From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v10 24/44] fetch.c: use a single ref transaction for all
 ref updates
Date: Sat, 17 May 2014 17:05:05 +0200
Message-ID: <53777AA1.1020107@alum.mit.edu>
References: <1400261852-31303-1-git-send-email-sahlberg@google.com> <1400261852-31303-25-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 17 17:05:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlgAm-00025Y-Ju
	for gcvg-git-2@plane.gmane.org; Sat, 17 May 2014 17:05:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964781AbaEQPFJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 May 2014 11:05:09 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:45538 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S964773AbaEQPFI (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 17 May 2014 11:05:08 -0400
X-AuditID: 1207440c-f79656d000000c83-4f-53777aa34f90
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id EF.64.03203.3AA77735; Sat, 17 May 2014 11:05:07 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB3A76.dip0.t-ipconnect.de [93.219.58.118])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s4HF55MT028753
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Sat, 17 May 2014 11:05:06 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.4.0
In-Reply-To: <1400261852-31303-25-git-send-email-sahlberg@google.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplleLIzCtJLcpLzFFi42IRYndR1F1cVR5ssOY9u0XXlW4mi38TahyY
	PBZsKvX4vEkugCmK2yYpsaQsODM9T98ugTvj4vcLTAV7tCp6by1lbGD8otDFyMkhIWAisf/b
	MlYIW0ziwr31bF2MXBxCApcZJbZ8v8sC4Zxnkjh4fRWQw8HBK6AtMfFYJkgDi4CqROfRlUwg
	NpuArsSinmYmkBJRgSCJP2cVQcK8AoISJ2c+YQGxRQTsJNbfWsgMYgsLRElceDWBDaRcSKBG
	4uvLdBCTU8BVYtczQxBTQkBcoqcxCKSYWUBH4l3fA2YIW15i+9s5zBMYBWYhmT8LSdksJGUL
	GJlXMcol5pTm6uYmZuYUpybrFicn5uWlFuka6uVmluilppRuYoQEJ88Oxm/rZA4xCnAwKvHw
	ctiWBQuxJpYVV+YeYpTkYFIS5bWNLQ8W4kvKT6nMSCzOiC8qzUktPsQowcGsJMK72w0ox5uS
	WFmVWpQPk5LmYFES51Vdou4nJJCeWJKanZpakFoEk5Xh4FCS4GUERqGQYFFqempFWmZOCUKa
	iYMTZDiXlEhxal5KalFiaUlGPChC44uBMQqS4gHam1UBsre4IDEXKArReopRl+PUnWNtTEIs
	efl5qVLivDogOwRAijJK8+BWwFLRK0ZxoI+FeflBqniAaQxu0iugJUxAS97sLQVZUpKIkJJq
	YOzjP7DFs//0vNflx9dduKR/VEBN7s6uXyGPDpv+yD8jyJZxW+WE/7tTvz9Mtu+JnTDN4N88
	nt8fjv/VcP+7xkfsEmMWa/fCYlPLph7nv00H382qShfuqZixy7hgukDPh0d+hokH 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249470>

On 05/16/2014 07:37 PM, Ronnie Sahlberg wrote:
> Change store_updated_refs to use a single ref transaction for all refs that
> are updated during the fetch. This makes the fetch more atomic when update
> failures occur.
> 
> Since ref update failures will now no longer occur in the code path for
> updating a single ref in s_update_ref, we no longer have as detailed error
> message logging the exact reference and the ref log action as in the old cod

s/cod/code/ ?

> Instead since we fail the entire transaction we log a much more generic
> message. But since we commit the transaction using MSG_ON_ERR we will log
> an error containing the ref name if either locking of writing the ref would

s/of/or/ ?
s/would/would fail,/ ?

> so the regression in the log message is minor.
> 
> This will also change the order in which errors are checked for and logged
> which may alter which error will be logged if there are multiple errors
> occuring during a fetch.

s/occuring/occurring/

> 
> For example, assume we have a fetch for two refs that both would fail.
> Where the first ref would fail with ENOTDIR due to a directory in the ref
> path not existing, and the second ref in the fetch would fail due to
> the check in update_logical_ref():
>         if (current_branch &&
>             !strcmp(ref->name, current_branch->name) &&
>             !(update_head_ok || is_bare_repository()) &&
>             !is_null_sha1(ref->old_sha1)) {
>                 /*
>                  * If this is the head, and it's not okay to update
>                  * the head, and the old value of the head isn't empty...
>                  */
> 
> In the old code since we would update the refs one ref at a time we would
> first fail the ENOTDIR and then fail the second update of HEAD as well.
> But since the first ref failed with ENOTDIR we would eventually fail the who

s/who/whole/

> fetch with STORE_REF_ERROR_DF_CONFLICT
> 
> In the new code, since we defer committing the transaction until all refs
> have been processed, we would now detect that the second ref was bad and
> rollback the transaction before we would even try start writing the update t

s/try/try to/
s/t$/to/

> disk and thus we would not return STORE_REF_ERROR_DF_CONFLICT for this case.
> 
> I think this new behaviour is more correct, since if there was a problem
> we would not even try to commit the transaction but need to highlight this
> change in how/what errors are reported.
> This change in what error is returned only occurs if there are multiple
> refs that fail to update and only some, but not all, of them fail due to
> ENOTDIR.

Thanks for the detailed explanation.  The change in behavior seems
reasonable to me.

> 
> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
> ---
>  builtin/fetch.c | 34 ++++++++++++++++------------------
>  1 file changed, 16 insertions(+), 18 deletions(-)
> 
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index 8cf70cd..5b0cc31 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -45,6 +45,7 @@ static struct transport *gsecondary;
>  static const char *submodule_prefix = "";
>  static const char *recurse_submodules_default;
>  static int shown_url;
> +static struct ref_transaction *transaction;
>  
>  static int option_parse_recurse_submodules(const struct option *opt,
>  				   const char *arg, int unset)
> @@ -373,27 +374,13 @@ static int s_update_ref(const char *action,
>  			struct ref *ref,
>  			int check_old)
>  {
> -	char msg[1024];
> -	char *rla = getenv("GIT_REFLOG_ACTION");
> -	struct ref_transaction *transaction;
> -
>  	if (dry_run)
>  		return 0;
> -	if (!rla)
> -		rla = default_rla.buf;
> -	snprintf(msg, sizeof(msg), "%s: %s", rla, action);
>  
> -	errno = 0;
> -	transaction = ref_transaction_begin();
> -	if (!transaction ||
> -	    ref_transaction_update(transaction, ref->name, ref->new_sha1,
> -				   ref->old_sha1, 0, check_old, NULL) ||
> -	    ref_transaction_commit(transaction, msg, NULL)) {
> -		ref_transaction_free(transaction);
> -		return errno == ENOTDIR ? STORE_REF_ERROR_DF_CONFLICT :
> -					  STORE_REF_ERROR_OTHER;
> -	}
> -	ref_transaction_free(transaction);
> +	if (ref_transaction_update(transaction, ref->name, ref->new_sha1,
> +				   ref->old_sha1, 0, check_old, NULL))
> +		return STORE_REF_ERROR_OTHER;
> +
>  	return 0;
>  }
>  
> @@ -565,6 +552,13 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
>  		goto abort;
>  	}
>  
> +	errno = 0;
> +	transaction = ref_transaction_begin();
> +	if (!transaction) {
> +		rc = error(_("cannot start ref transaction\n"));
> +		goto abort;
> +	}
> +
>  	/*
>  	 * We do a pass for each fetch_head_status type in their enum order, so
>  	 * merged entries are written before not-for-merge. That lets readers
> @@ -676,6 +670,10 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
>  			}
>  		}
>  	}
> +	if (ref_transaction_commit(transaction, "fetch_ref transaction", NULL))
> +		rc |= errno == ENOTDIR ? STORE_REF_ERROR_DF_CONFLICT :
> +		  STORE_REF_ERROR_OTHER;
> +	ref_transaction_free(transaction);
>  
>  	if (rc & STORE_REF_ERROR_DF_CONFLICT)
>  		error(_("some local refs could not be updated; try running\n"
> 


-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
