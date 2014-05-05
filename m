From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v6 08/42] refs.c: change ref_transaction_update() to do
 error checking and return status
Date: Mon, 05 May 2014 15:08:17 +0200
Message-ID: <53678D41.8010100@alum.mit.edu>
References: <1398976662-6962-1-git-send-email-sahlberg@google.com> <1398976662-6962-9-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 06 18:41:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Whi0h-0006KZ-GH
	for gcvg-git-2@plane.gmane.org; Tue, 06 May 2014 18:14:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932342AbaEENIV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2014 09:08:21 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:45267 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932323AbaEENIU (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 May 2014 09:08:20 -0400
X-AuditID: 12074412-f79d46d000002e58-d3-53678d439d82
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id CD.85.11864.34D87635; Mon,  5 May 2014 09:08:19 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB24B0.dip0.t-ipconnect.de [93.219.36.176])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s45D8IB7026451
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Mon, 5 May 2014 09:08:19 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.4.0
In-Reply-To: <1398976662-6962-9-git-send-email-sahlberg@google.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNKsWRmVeSWpSXmKPExsUixO6iqOvcmx5s8PiOjkXXlW4mi38TahyY
	PBZsKvX4vEkugCmK2yYpsaQsODM9T98ugTtj24FfjAXz5Ss6zsxmbGA8I9HFyMEhIWAicWNv
	bRcjJ5ApJnHh3nq2LkYuDiGBy4wSE3v/s0M455gkGld+ZwOp4hXQljg+eyojiM0ioCrR0Tef
	BcRmE9CVWNTTzAQyVFQgSOLPWUWIckGJkzOfgJWICNhJrL+1kBnEFhbIk9i0ZT/YGCGBSokN
	zxvBxnMKOEv8Xn+eGeI2cYmexiCQMLOAjsS7vgfMELa8xPa3c5gnMArMQrJhFpKyWUjKFjAy
	r2KUS8wpzdXNTczMKU5N1i1OTszLSy3SNdPLzSzRS00p3cQICVChHYzrT8odYhTgYFTi4U1g
	Tg8WYk0sK67MPcQoycGkJMp7rwEoxJeUn1KZkVicEV9UmpNafIhRgoNZSYR3KUiONyWxsiq1
	KB8mJc3BoiTO+3Oxup+QQHpiSWp2ampBahFMVoODQ+DKwSOzGaVY8vLzUpUkeI91Aw0RLEpN
	T61Iy8wpQShl4uAEWcQlJVKcmpeSWpRYWpIRD4re+GJg/IKkeIBueAvSzltckJgLFIVoPcWo
	y3GhYUULkxDYDilx3pYuoCIBkKKM0jy4FbA09YpRHOh7Yd5DIKN4gCkObtIroCVMQEu4jMGW
	lCQipKQaGNenvpB74vfH49ykizWHTpm8S8p7WdJ/cyPbOz//xDUfvI0V/vy4N3cz/8PZa+vc
	7k/YfXjv/Ix171PWTT2mm/vv8GejV49fb1dlOlHfUbb7ylM7TReNb84zd648PjPC 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248147>

On 05/01/2014 10:37 PM, Ronnie Sahlberg wrote:
> Update ref_transaction_update() do some basic error checking and return
> true on error. Update all callers to check ref_transaction_update() for error.
> There are currently no conditions in _update that will return error but there
> will be in the future.

I would change s/true/non-zero/, because error return values are not
just boolean values; the error values sometimes encode the type of error
that occurred.

> 
> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
> ---
>  builtin/update-ref.c | 10 ++++++----
>  refs.c               |  9 +++++++--
>  refs.h               | 10 +++++-----
>  3 files changed, 18 insertions(+), 11 deletions(-)
> 
> diff --git a/builtin/update-ref.c b/builtin/update-ref.c
> index 2bef2a0..59c4d6b 100644
> --- a/builtin/update-ref.c
> +++ b/builtin/update-ref.c
> @@ -197,8 +197,9 @@ static const char *parse_cmd_update(struct strbuf *input, const char *next)
>  	if (*next != line_termination)
>  		die("update %s: extra input: %s", refname, next);
>  
> -	ref_transaction_update(transaction, refname, new_sha1, old_sha1,
> -			       update_flags, have_old);
> +	if (ref_transaction_update(transaction, refname, new_sha1, old_sha1,
> +				   update_flags, have_old))
> +		die("update %s: failed", refname);
>  
>  	update_flags = 0;
>  	free(refname);
> @@ -286,8 +287,9 @@ static const char *parse_cmd_verify(struct strbuf *input, const char *next)
>  	if (*next != line_termination)
>  		die("verify %s: extra input: %s", refname, next);
>  
> -	ref_transaction_update(transaction, refname, new_sha1, old_sha1,
> -			       update_flags, have_old);
> +	if (ref_transaction_update(transaction, refname, new_sha1, old_sha1,
> +				   update_flags, have_old))
> +		die("failed transaction update for %s", refname);
>  
>  	update_flags = 0;
>  	free(refname);
> diff --git a/refs.c b/refs.c
> index 308e13e..1a903fb 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -3333,19 +3333,24 @@ static struct ref_update *add_update(struct ref_transaction *transaction,
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
> +		die("have_old is true but old_sha1 is NULL");

This new check is orthogonal to the rest of the patch, isn't it?

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
> index bc7715e..0364a3e 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -237,11 +237,11 @@ void ref_transaction_rollback(struct ref_transaction *transaction);
>   * that the reference should have had before the update, or zeros if
>   * it must not have existed beforehand.
>   */

Please update the docstring above to explain the return value.

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

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
