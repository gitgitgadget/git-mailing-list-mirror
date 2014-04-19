From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 02/11] refs.c: change ref_transaction_update() to do error
 checking and return status
Date: Sat, 19 Apr 2014 20:55:18 +0200
Message-ID: <5352C696.9010601@alum.mit.edu>
References: <1397763987-4453-1-git-send-email-sahlberg@google.com> <1397763987-4453-3-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 19 20:55:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WbaQM-0005cs-ET
	for gcvg-git-2@plane.gmane.org; Sat, 19 Apr 2014 20:55:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755171AbaDSSzZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Apr 2014 14:55:25 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:55298 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754851AbaDSSzV (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Apr 2014 14:55:21 -0400
X-AuditID: 12074412-f79d46d000002e58-98-5352c698704a
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 8C.A4.11864.896C2535; Sat, 19 Apr 2014 14:55:20 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB2858.dip0.t-ipconnect.de [93.219.40.88])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s3JItIE4018049
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Sat, 19 Apr 2014 14:55:19 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.4.0
In-Reply-To: <1397763987-4453-3-git-send-email-sahlberg@google.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDKsWRmVeSWpSXmKPExsUixO6iqDvjWFCwwZnPahZdV7qZLP5NqHFg
	8liwqdTj8ya5AKYobpukxJKy4Mz0PH27BO6M2zdOsRd0yVU0NfQzNTBeEO9i5OSQEDCROL16
	ISuELSZx4d56ti5GLg4hgcuMEi87etghnHNMEg9nTWAEqeIV0Jb4cambHcRmEVCVeLW6Gcxm
	E9CVWNTTzNTFyMEhKhAk8eesIkS5oMTJmU9YQGwRATuJ9bcWMoPYwgLZEvtvLQJrFRKolPix
	rQeshlPAWeLXn15GkDESAuISPY1BIGFmAR2Jd30PmCFseYntb+cwT2AUmIVkwywkZbOQlC1g
	ZF7FKJeYU5qrm5uYmVOcmqxbnJyYl5dapGuml5tZopeaUrqJERKiQjsY15+UO8QowMGoxMO7
	ISAwWIg1say4MvcQoyQHk5Io79/1QcFCfEn5KZUZicUZ8UWlOanFhxglOJiVRHhn7AHK8aYk
	VlalFuXDpKQ5WJTEeX8uVvcTEkhPLEnNTk0tSC2CyWpwcAhcOXhkNqMUS15+XqqSBO+ro0BD
	BItS01Mr0jJzShBKmTg4QRZxSYkUp+alpBYllpZkxIPiN74YGMEgKR6gG3pA2nmLCxJzgaIQ
	racYdTkuNKxoYRIC2yElzjsDpEgApCijNA9uBSxRvWIUB/pemPc4SBUPMMnBTXoFtIQJaMnf
	MwEgS0oSEVJSDYwzLHZZPahZ6ii+XW/nXL+uf0dmpuZyW9+YeW3y0v6HCUb7u8IvvMuYJj0n
	SU+7WG3BFFWueaV9vpN2y+76d2u7eYhy3Oz18e3yxbXXYhh52qe93JpncHQy823e 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246524>

On 04/17/2014 09:46 PM, Ronnie Sahlberg wrote:
> Update ref_transaction_update() do some basic error checking and return
> true on error. Update all callers to check ref_transaction_update() for error.
> 
> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
> ---
>  builtin/update-ref.c | 11 +++++++----
>  refs.c               |  9 +++++++--
>  refs.h               | 10 +++++-----
>  3 files changed, 19 insertions(+), 11 deletions(-)
> 
> diff --git a/builtin/update-ref.c b/builtin/update-ref.c
> index 405267f..12bfacc 100644
> --- a/builtin/update-ref.c
> +++ b/builtin/update-ref.c
> @@ -197,8 +197,10 @@ static const char *parse_cmd_update(struct strbuf *input, const char *next)
>  	if (*next != line_termination)
>  		die("update %s: extra input: %s", refname, next);
>  
> -	ref_transaction_update(transaction, refname, new_sha1, old_sha1,
> -			       update_flags, have_old);
> +	if (ref_transaction_update(transaction, refname, new_sha1, old_sha1,
> +				   update_flags, have_old))
> +		die("failed transaction update for %s", refname);
> +
>  
>  	update_flags = 0;
>  	free(refname);
> @@ -286,8 +288,9 @@ static const char *parse_cmd_verify(struct strbuf *input, const char *next)
>  	if (*next != line_termination)
>  		die("verify %s: extra input: %s", refname, next);
>  
> -	ref_transaction_update(transaction, refname, new_sha1, old_sha1,
> -			       update_flags, have_old);
> +	if (ref_transaction_update(transaction, refname, new_sha1, old_sha1,
> +			       update_flags, have_old))
> +		die("failed transaction update for %s", refname);
>  
>  	update_flags = 0;
>  	free(refname);
> diff --git a/refs.c b/refs.c
> index 138ab70..da1761d 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -3327,19 +3327,24 @@ static struct ref_update *add_update(struct ref_transaction *transaction,
>  	return update;
>  }
>  
> -void ref_transaction_update(struct ref_transaction *transaction,
> +int ref_transaction_update(struct ref_transaction *transaction,
>  			    const char *refname,
>  			    const unsigned char *new_sha1,
>  			    const unsigned char *old_sha1,
>  			    int flags, int have_old)
>  {
> -	struct ref_update *update = add_update(transaction, refname);
> +	struct ref_update *update;
> +
> +	if (have_old && !old_sha1)
> +		return error("have_old is true but old_sha1 is NULL");

The function documentation doesn't seem to allow old_sha1 == NULL.  That
means that calling it that way is a bug, not an error.  Therefore, I
think this should result in

    die("BUG: have_old is true but old_sha1 is NULL");

>  
> +	update = add_update(transaction, refname);
>  	hashcpy(update->new_sha1, new_sha1);
>  	update->flags = flags;
>  	update->have_old = have_old;
>  	if (have_old)
>  		hashcpy(update->old_sha1, old_sha1);
> +	return 0;
>  }
>  
>  void ref_transaction_create(struct ref_transaction *transaction,
> diff --git a/refs.h b/refs.h
> index 892c5b6..00e4f7b 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -237,11 +237,11 @@ void ref_transaction_rollback(struct ref_transaction *transaction);
>   * that the reference should have had before the update, or zeros if
>   * it must not have existed beforehand.
>   */
> -void ref_transaction_update(struct ref_transaction *transaction,
> -			    const char *refname,
> -			    const unsigned char *new_sha1,
> -			    const unsigned char *old_sha1,
> -			    int flags, int have_old);
> +int ref_transaction_update(struct ref_transaction *transaction,
> +			   const char *refname,
> +			   const unsigned char *new_sha1,
> +			   const unsigned char *old_sha1,
> +			   int flags, int have_old);
>  
>  /*
>   * Add a reference creation to transaction.  new_sha1 is the value
> 


-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
