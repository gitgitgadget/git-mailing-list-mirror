From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 03/11] refs.c: change ref_transaction_create to do error
 checking and return status
Date: Sat, 19 Apr 2014 20:59:09 +0200
Message-ID: <5352C77D.3090106@alum.mit.edu>
References: <1397763987-4453-1-git-send-email-sahlberg@google.com> <1397763987-4453-4-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 19 20:59:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WbaTt-0001MF-OK
	for gcvg-git-2@plane.gmane.org; Sat, 19 Apr 2014 20:59:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755064AbaDSS7N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Apr 2014 14:59:13 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:47781 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754991AbaDSS7M (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Apr 2014 14:59:12 -0400
X-AuditID: 1207440f-f79326d000003c9f-3e-5352c77f518c
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 09.30.15519.F77C2535; Sat, 19 Apr 2014 14:59:11 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB2858.dip0.t-ipconnect.de [93.219.40.88])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s3JIx9Yt018207
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Sat, 19 Apr 2014 14:59:10 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.4.0
In-Reply-To: <1397763987-4453-4-git-send-email-sahlberg@google.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDKsWRmVeSWpSXmKPExsUixO6iqFt/PCjY4PR6RYuuK91MFv8m1Dgw
	eSzYVOrxeZNcAFMUt01SYklZcGZ6nr5dAnfG9o99LAW7xSvm/3jB2sC4S6iLkZNDQsBEYtGE
	JYwQtpjEhXvr2boYuTiEBC4zSmy538oK4Zxjkug/sZgNpIpXQFuidc8aZhCbRUBV4nLfeSYQ
	m01AV2JRTzOQzcEhKhAk8eesIkS5oMTJmU9YQGwRATuJ9bcWgrUKC2RK/FzzBKxVSKBSov96
	DyuIzSngLPGzrZMZZIyEgLhET2MQSJhZQEfiXd8DZghbXmL72znMExgFZiHZMAtJ2SwkZQsY
	mVcxyiXmlObq5iZm5hSnJusWJyfm5aUW6Zro5WaW6KWmlG5ihIQo/w7GrvUyhxgFOBiVeHg3
	BAQGC7EmlhVX5h5ilORgUhLl/bs+KFiILyk/pTIjsTgjvqg0J7X4EKMEB7OSCO+MPUA53pTE
	yqrUonyYlDQHi5I4r/oSdT8hgfTEktTs1NSC1CKYrAYHh8CVg0dmM0qx5OXnpSpJ8M4+BjRE
	sCg1PbUiLTOnBKGUiYMTZBGXlEhxal5KalFiaUlGPCh+44uBEQyS4gG6YTtIO29xQWIuUBSi
	9RSjLseFhhUtTEJgO6TEeWccBSoSACnKKM2DWwFLVK8YxYG+F+bdCTKKB5jk4Ca9AlrCBLTk
	75kAkCUliQgpqQbG4qPT583bUDz52u+2zJpmbo64bymq8rOfpr8y+VE5e+6UW7ulF/AL2m6T
	W9jgqjq9xu6L36bDfquq5xx7UuK3+fKpvr5dMY7PhPdxTervuS7MLdATx5a7x3X/ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246526>

On 04/17/2014 09:46 PM, Ronnie Sahlberg wrote:
> Do basic error checking in ref_transaction_create() and make it return
> status. Update all callers to check the result of ref_transaction_create()
> 
> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
> ---
>  builtin/update-ref.c |  4 +++-
>  refs.c               | 17 +++++++++++------
>  refs.h               |  8 ++++----
>  3 files changed, 18 insertions(+), 11 deletions(-)
> 
> diff --git a/builtin/update-ref.c b/builtin/update-ref.c
> index 12bfacc..1b8a087 100644
> --- a/builtin/update-ref.c
> +++ b/builtin/update-ref.c
> @@ -226,7 +226,9 @@ static const char *parse_cmd_create(struct strbuf *input, const char *next)
>  	if (*next != line_termination)
>  		die("create %s: extra input: %s", refname, next);
>  
> -	ref_transaction_create(transaction, refname, new_sha1, update_flags);
> +	if(ref_transaction_create(transaction, refname, new_sha1,
> +				  update_flags))

Space between "if" and opening parenthesis.

> +		die("failed transaction create for %s", refname);
>  
>  	update_flags = 0;
>  	free(refname);
> diff --git a/refs.c b/refs.c
> index da1761d..c46249f 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -3347,18 +3347,23 @@ int ref_transaction_update(struct ref_transaction *transaction,
>  	return 0;
>  }
>  
> -void ref_transaction_create(struct ref_transaction *transaction,
> -			    const char *refname,
> -			    const unsigned char *new_sha1,
> -			    int flags)
> +int ref_transaction_create(struct ref_transaction *transaction,
> +			   const char *refname,
> +			   const unsigned char *new_sha1,
> +			   int flags)
>  {
> -	struct ref_update *update = add_update(transaction, refname);
> +	struct ref_update *update;
> +
> +	if (!new_sha1 || is_null_sha1(new_sha1))
> +		return error("create ref with null new_sha1");

Please die("BUG: ...").

> +
> +	update = add_update(transaction, refname);
>  
> -	assert(!is_null_sha1(new_sha1));
>  	hashcpy(update->new_sha1, new_sha1);
>  	hashclr(update->old_sha1);
>  	update->flags = flags;
>  	update->have_old = 1;
> +	return 0;
>  }
>  
>  void ref_transaction_delete(struct ref_transaction *transaction,
> diff --git a/refs.h b/refs.h
> index 00e4f7b..8799e15 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -249,10 +249,10 @@ int ref_transaction_update(struct ref_transaction *transaction,
>   * null SHA-1.  It is verified that the reference does not exist
>   * already.
>   */
> -void ref_transaction_create(struct ref_transaction *transaction,
> -			    const char *refname,
> -			    const unsigned char *new_sha1,
> -			    int flags);
> +int ref_transaction_create(struct ref_transaction *transaction,
> +			   const char *refname,
> +			   const unsigned char *new_sha1,
> +			   int flags);
>  
>  /*
>   * Add a reference deletion to transaction.  If have_old is true, then
> 

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
