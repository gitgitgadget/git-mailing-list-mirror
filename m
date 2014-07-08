From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v20 30/48] refs.c: change update_ref to use a transaction
Date: Tue, 08 Jul 2014 14:54:28 +0200
Message-ID: <53BBEA04.5040103@alum.mit.edu>
References: <1403275409-28173-1-git-send-email-sahlberg@google.com> <1403275409-28173-31-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 08 14:54:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4Uup-0000Km-G5
	for gcvg-git-2@plane.gmane.org; Tue, 08 Jul 2014 14:54:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754412AbaGHMyb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2014 08:54:31 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:54248 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754254AbaGHMya (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Jul 2014 08:54:30 -0400
X-AuditID: 12074414-f79446d000001f1d-24-53bbea065719
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id DE.4F.07965.60AEBB35; Tue,  8 Jul 2014 08:54:30 -0400 (EDT)
Received: from [192.168.69.130] (p4FC97EC0.dip0.t-ipconnect.de [79.201.126.192])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s68CsSMo031477
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 8 Jul 2014 08:54:29 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.5.0
In-Reply-To: <1403275409-28173-31-git-send-email-sahlberg@google.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplleLIzCtJLcpLzFFi42IRYndR1GV7tTvYYOUkDouuK91MFv8m1Dgw
	eSzYVOrxeZNcAFMUt01SYklZcGZ6nr5dAnfGynN7WAs+8lXM2HSMqYHxEncXIyeHhICJRNvJ
	o8wQtpjEhXvr2boYuTiEBC4zSsxdtokRwjnPJNF09Sw7SBWvgLbEy16IDhYBVYnJf3eCxdkE
	dCUW9TQzgdiiAkESsz/Pg6oXlDg58wkLiC0iYCex/tZCsF5hAV+J7f+/gNlCAjUS5xbPB6vn
	FHCVWHzqCFA9B9BF4hI9jUEgYWYBHYl3fQ+YIWx5ie1v5zBPYBSYhWTDLCRls5CULWBkXsUo
	l5hTmqubm5iZU5yarFucnJiXl1qka6GXm1mil5pSuokREqQiOxiPnJQ7xCjAwajEw7vi4K5g
	IdbEsuLK3EOMkhxMSqK8gvd3BwvxJeWnVGYkFmfEF5XmpBYfYpTgYFYS4f1yCijHm5JYWZVa
	lA+TkuZgURLn/bZY3U9IID2xJDU7NbUgtQgmK8PBoSTBW/4SqFGwKDU9tSItM6cEIc3EwQky
	nEtKpDg1LyW1KLG0JCMeFKnxxcBYBUnxAO2tA2nnLS5IzAWKQrSeYlSUEuctewGUEABJZJTm
	wY2FpZ5XjOJAXwrz+oK08wDTFlz3K6DBTECDP7/fATK4JBEhJdXA2D5r33+5bDmzSS5f6zrZ
	qkS0Lh6MuBagnmZhuON2z32Bhouyu4/9CCoSX6myrKnE7/KumfnX5K68OrCkZbPhSo/T+ssa
	vfwLIte+8lk3/UbVvSfHwm+Jres76LmeVToysD0ssDXcfOPWuY3rbIsFFebefn7k 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253020>

On 06/20/2014 04:43 PM, Ronnie Sahlberg wrote:
> Change the update_ref helper function to use a ref transaction internally.
> 
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
> ---
>  refs.c | 28 ++++++++++++++++++++++++----
>  1 file changed, 24 insertions(+), 4 deletions(-)
> 
> diff --git a/refs.c b/refs.c
> index 8c695ba..4bdccc5 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -3524,11 +3524,31 @@ int update_ref(const char *action, const char *refname,
>  	       const unsigned char *sha1, const unsigned char *oldval,
>  	       int flags, enum action_on_err onerr)
>  {
> -	struct ref_lock *lock;
> -	lock = update_ref_lock(refname, oldval, flags, NULL, onerr);
> -	if (!lock)
> +	struct ref_transaction *t;
> +	struct strbuf err = STRBUF_INIT;
> +
> +	t = ref_transaction_begin(&err);
> +	if (!t ||
> +	    ref_transaction_update(t, refname, sha1, oldval, flags,
> +				   !!oldval, &err) ||
> +	    ref_transaction_commit(t, action, &err)) {
> +		const char *str = "update_ref failed for ref '%s': %s";
> +
> +		ref_transaction_free(t);
> +		switch (onerr) {
> +		case UPDATE_REFS_MSG_ON_ERR:
> +			error(str, refname, err.buf);
> +			break;
> +		case UPDATE_REFS_DIE_ON_ERR:
> +			die(str, refname, err.buf);
> +			break;
> +		case UPDATE_REFS_QUIET_ON_ERR:
> +			break;
> +		}
> +		strbuf_release(&err);
>  		return 1;
> -	return update_ref_write(action, refname, sha1, lock, NULL, onerr);
> +	}
> +	return 0;
>  }
>  

Should this function be scheduled for the "take strbuf *err argument"
treatment instead of continuing to use an action_on_err parameter?
(Maybe you've changed this later in the patch series?)

I'm not saying this change has to be part of the current patch series,
but let's consider it for the future.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
