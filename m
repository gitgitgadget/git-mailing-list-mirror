From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 04/11] refs.c: ref_transaction_delete to check for error
 and return status
Date: Sat, 19 Apr 2014 21:00:09 +0200
Message-ID: <5352C7B9.80405@alum.mit.edu>
References: <1397763987-4453-1-git-send-email-sahlberg@google.com> <1397763987-4453-5-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 19 21:00:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WbaUr-0002fv-Cp
	for gcvg-git-2@plane.gmane.org; Sat, 19 Apr 2014 21:00:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755107AbaDSTAN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Apr 2014 15:00:13 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:47787 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755101AbaDSTAL (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Apr 2014 15:00:11 -0400
X-AuditID: 1207440f-f79326d000003c9f-95-5352c7bb7831
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id EB.30.15519.BB7C2535; Sat, 19 Apr 2014 15:00:11 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB2858.dip0.t-ipconnect.de [93.219.40.88])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s3JJ09eV018287
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Sat, 19 Apr 2014 15:00:10 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.4.0
In-Reply-To: <1397763987-4453-5-git-send-email-sahlberg@google.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnleLIzCtJLcpLzFFi42IRYndR1N19PCjY4NFfXouuK91MFv8m1Dgw
	eSzYVOrxeZNcAFMUt01SYklZcGZ6nr5dAnfGmvNrGQvei1dsv3COrYHxolAXIyeHhICJxLLG
	i8wQtpjEhXvr2boYuTiEBC4zSqz6fogRwjnHJLHg111WkCpeAU2J3e0dYDaLgKpEx98rbCA2
	m4CuxKKeZqYuRg4OUYEgiT9nFSHKBSVOznzCAmKLCNhJrL+1kBmkRFggQeJvryNIWEigUuLh
	z4dgUzgFnCWOvuhhBymREBCX6GkMAgkzC+hIvOt7wAxhy0tsfzuHeQKjwCwkC2YhKZuFpGwB
	I/MqRrnEnNJc3dzEzJzi1GTd4uTEvLzUIl0TvdzMEr3UlNJNjJAA5d/B2LVe5hCjAAejEg/v
	hoDAYCHWxLLiytxDjJIcTEqivH/XBwUL8SXlp1RmJBZnxBeV5qQWH2KU4GBWEuGdsQcox5uS
	WFmVWpQPk5LmYFES51Vfou4nJJCeWJKanZpakFoEk5Xh4FCS4L16DKhRsCg1PbUiLTOnBCHN
	xMEJMpxLSqQ4NS8ltSixtCQjHhSl8cXAOAVJ8QDt3Q7SzltckJgLFIVoPcWoy3GhYUULkxBL
	Xn5eqpQ474yjQEUCIEUZpXlwK2Dp6BWjONDHwrw7QUbxAFMZ3KRXQEuYgJb8PRMAsqQkESEl
	1cDI4qStPttmn8zLJ6lGu1eX/QiT339rxmlN4cXnt56YaaCjqm+izWnGvO+rQpzEj4Bre1p3
	33uwtv6h6/f7x+5fc1unKhu18bGWjqD4yc9dHY/vZVxjn1Oi3/dUMDtN2y5HdvPd 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246527>

On 04/17/2014 09:46 PM, Ronnie Sahlberg wrote:
> Change ref_transaction_delete() to do basic error checking and return
> status. Update all callers to check the return for ref_transaction_delete()
> 
> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
> ---
>  builtin/update-ref.c |  5 +++--
>  refs.c               | 15 ++++++++++-----
>  refs.h               |  8 ++++----
>  3 files changed, 17 insertions(+), 11 deletions(-)
> 
> diff --git a/builtin/update-ref.c b/builtin/update-ref.c
> index 1b8a087..6ff8b86 100644
> --- a/builtin/update-ref.c
> +++ b/builtin/update-ref.c
> @@ -258,8 +258,9 @@ static const char *parse_cmd_delete(struct strbuf *input, const char *next)
>  	if (*next != line_termination)
>  		die("delete %s: extra input: %s", refname, next);
>  
> -	ref_transaction_delete(transaction, refname, old_sha1,
> -			       update_flags, have_old);
> +	if (ref_transaction_delete(transaction, refname, old_sha1,
> +				   update_flags, have_old))
> +		die("failed transaction delete for %s", refname);
>  
>  	update_flags = 0;
>  	free(refname);
> diff --git a/refs.c b/refs.c
> index c46249f..9cbcffa 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -3366,19 +3366,24 @@ int ref_transaction_create(struct ref_transaction *transaction,
>  	return 0;
>  }
>  
> -void ref_transaction_delete(struct ref_transaction *transaction,
> -			    const char *refname,
> -			    const unsigned char *old_sha1,
> -			    int flags, int have_old)
> +int ref_transaction_delete(struct ref_transaction *transaction,
> +			   const char *refname,
> +			   const unsigned char *old_sha1,
> +			   int flags, int have_old)
>  {
> -	struct ref_update *update = add_update(transaction, refname);
> +	struct ref_update *update;
>  
> +	if (have_old && !old_sha1)
> +		return error("have_old is true but old_sha1 is NULL");

Ditto.

> +
> +	update = add_update(transaction, refname);
>  	update->flags = flags;
>  	update->have_old = have_old;
>  	if (have_old) {
>  		assert(!is_null_sha1(old_sha1));
>  		hashcpy(update->old_sha1, old_sha1);
>  	}
> +	return 0;
>  }
>  
>  int update_ref(const char *action, const char *refname,
> diff --git a/refs.h b/refs.h
> index 8799e15..7050da2 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -259,10 +259,10 @@ int ref_transaction_create(struct ref_transaction *transaction,
>   * old_sha1 holds the value that the reference should have had before
>   * the update (which must not be the null SHA-1).
>   */
> -void ref_transaction_delete(struct ref_transaction *transaction,
> -			    const char *refname,
> -			    const unsigned char *old_sha1,
> -			    int flags, int have_old);
> +int ref_transaction_delete(struct ref_transaction *transaction,
> +			   const char *refname,
> +			   const unsigned char *old_sha1,
> +			   int flags, int have_old);
>  
>  /*
>   * Commit all of the changes that have been queued in transaction, as
> 

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
