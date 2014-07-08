From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v20 23/48] refs.c: add transaction.status and track OPEN/CLOSED/ERROR
Date: Tue, 08 Jul 2014 14:00:15 +0200
Message-ID: <53BBDD4F.20403@alum.mit.edu>
References: <1403275409-28173-1-git-send-email-sahlberg@google.com> <1403275409-28173-24-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 08 14:00:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4U4W-00072w-AW
	for gcvg-git-2@plane.gmane.org; Tue, 08 Jul 2014 14:00:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754607AbaGHMAW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2014 08:00:22 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:42297 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754541AbaGHMAS (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Jul 2014 08:00:18 -0400
X-AuditID: 1207440f-f79156d000006a5c-68-53bbdd517d6b
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 93.18.27228.15DDBB35; Tue,  8 Jul 2014 08:00:17 -0400 (EDT)
Received: from [192.168.69.130] (p4FC97EC0.dip0.t-ipconnect.de [79.201.126.192])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s68C0GQp029174
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 8 Jul 2014 08:00:17 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.5.0
In-Reply-To: <1403275409-28173-24-git-send-email-sahlberg@google.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAKsWRmVeSWpSXmKPExsUixO6iqBt4d3ewwb9PxhZdV7qZLP5NqHFg
	8liwqdTj8ya5AKYobpukxJKy4Mz0PH27BO6MS5fWMhUclq/Y9fAxawPjMYkuRk4OCQETiTlT
	HjJB2GISF+6tZ+ti5OIQErjMKLFt2SsmCOc8k8TdU63sIFW8ApoStzpmgXWwCKhKzNx/gwXE
	ZhPQlVjU0wwWFxUIkpj9eR5UvaDEyZlPwGpEBOwk1t9ayAxiCwtESsyeDREXEqiRWLprPlCc
	g4NTwFWip1sKxJQQEJfoaQwCqWAW0JF41/eAGcKWl9j+dg7zBEaBWUgWzEJSNgtJ2QJG5lWM
	cok5pbm6uYmZOcWpybrFyYl5ealFuiZ6uZkleqkppZsYISHKv4Oxa73MIUYBDkYlHt4VB3cF
	C7EmlhVX5h5ilORgUhLlPXp8d7AQX1J+SmVGYnFGfFFpTmrxIUYJDmYlEd4vp4ByvCmJlVWp
	RfkwKWkOFiVxXvUl6n5CAumJJanZqakFqUUwWRkODiUJ3vg7QI2CRanpqRVpmTklCGkmDk6Q
	4VxSIsWpeSmpRYmlJRnxoDiNLwZGKkiKB2hvOEg7b3FBYi5QFKL1FKMux6k7x9qYhFjy8vNS
	pcR5l94GKhIAKcoozYNbAUtIrxjFgT4W5k0FGcUDTGZwk14BLWECWvL5/Q6QJSWJCCmpBkbD
	nZMfBlhN0p7P6yuV73LdVUcs13G36Jbk/Ydmu/5+UWOSOS+MzemNh8o6V+uF/0T+/jMsD1t2
	SOTvVYnO5ZUV3/ctP/pFfgFH8l0zuUX5/ga3ePOMp7hGq61p5jRc93Hnm19sB9dp 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253015>

On 06/20/2014 04:43 PM, Ronnie Sahlberg wrote:
> Track the status of a transaction in a new status field. Check the field for

The status field is not set or used anywhere.  The field that you use is
"state".

> sanity, i.e. that status must be OPEN when _commit/_create/_delete or
> _update is called or else die(BUG:...)
> 
> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
> ---
>  refs.c | 40 +++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 39 insertions(+), 1 deletion(-)
> 
> diff --git a/refs.c b/refs.c
> index 9cb7908..8c695ba 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -3387,6 +3387,25 @@ struct ref_update {
>  };
>  
>  /*
> + * Transaction states.
> + * OPEN:   The transaction is in a valid state and can accept new updates.
> + *         An OPEN transaction can be committed.
> + * CLOSED: If an open transaction is successfully committed the state will
> + *         change to CLOSED. No further changes can be made to a CLOSED
> + *         transaction.
> + *         CLOSED means that all updates have been successfully committed and
> + *         the only thing that remains is to free the completed transaction.
> + * ERROR:  The transaction has failed and is no longer committable.
> + *         No further changes can be made to a CLOSED transaction and it must
> + *         be rolled back using transaction_free.
> + */
> +enum ref_transaction_state {
> +	REF_TRANSACTION_OPEN   = 0,
> +	REF_TRANSACTION_CLOSED = 1,
> +	REF_TRANSACTION_ERROR  = 2,
> +};
> +
> +/*
>   * Data structure for holding a reference transaction, which can
>   * consist of checks and updates to multiple references, carried out
>   * as atomically as possible.  This structure is opaque to callers.
> @@ -3395,6 +3414,8 @@ struct ref_transaction {
>  	struct ref_update **updates;
>  	size_t alloc;
>  	size_t nr;
> +	enum ref_transaction_state state;
> +	int status;

The status field should probably be deleted.

>  };
>  
>  struct ref_transaction *ref_transaction_begin(struct strbuf *err)
> @@ -3437,6 +3458,9 @@ int ref_transaction_update(struct ref_transaction *transaction,
>  {
>  	struct ref_update *update;
>  
> +	if (transaction->state != REF_TRANSACTION_OPEN)
> +		die("BUG: update called for transaction that is not open");
> +
>  	if (have_old && !old_sha1)
>  		die("BUG: have_old is true but old_sha1 is NULL");
>  
> @@ -3457,6 +3481,9 @@ int ref_transaction_create(struct ref_transaction *transaction,
>  {
>  	struct ref_update *update;
>  
> +	if (transaction->state != REF_TRANSACTION_OPEN)
> +		die("BUG: create called for transaction that is not open");
> +
>  	if (!new_sha1 || is_null_sha1(new_sha1))
>  		die("BUG: create ref with null new_sha1");
>  
> @@ -3477,6 +3504,9 @@ int ref_transaction_delete(struct ref_transaction *transaction,
>  {
>  	struct ref_update *update;
>  
> +	if (transaction->state != REF_TRANSACTION_OPEN)
> +		die("BUG: delete called for transaction that is not open");
> +
>  	if (have_old && !old_sha1)
>  		die("BUG: have_old is true but old_sha1 is NULL");
>  
> @@ -3532,8 +3562,13 @@ int ref_transaction_commit(struct ref_transaction *transaction,
>  	int n = transaction->nr;
>  	struct ref_update **updates = transaction->updates;
>  
> -	if (!n)
> +	if (transaction->state != REF_TRANSACTION_OPEN)
> +		die("BUG: commit called for transaction that is not open");
> +
> +	if (!n) {
> +		transaction->state = REF_TRANSACTION_CLOSED;
>  		return 0;
> +	}
>  
>  	/* Allocate work space */
>  	delnames = xmalloc(sizeof(*delnames) * n);
> @@ -3595,6 +3630,9 @@ int ref_transaction_commit(struct ref_transaction *transaction,
>  	clear_loose_ref_cache(&ref_cache);
>  
>  cleanup:
> +	transaction->state = ret ? REF_TRANSACTION_ERROR
> +		: REF_TRANSACTION_CLOSED;
> +
>  	for (i = 0; i < n; i++)
>  		if (updates[i]->lock)
>  			unlock_ref(updates[i]->lock);
> 


-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
