From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v20 39/48] refs.c: make delete_ref use a transaction
Date: Tue, 08 Jul 2014 15:52:20 +0200
Message-ID: <53BBF794.1090702@alum.mit.edu>
References: <1403275409-28173-1-git-send-email-sahlberg@google.com> <1403275409-28173-40-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 08 15:52:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4Vop-0004mm-RA
	for gcvg-git-2@plane.gmane.org; Tue, 08 Jul 2014 15:52:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752836AbaGHNwX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2014 09:52:23 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:54486 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751610AbaGHNwW (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Jul 2014 09:52:22 -0400
X-AuditID: 12074414-f79446d000001f1d-6b-53bbf79688b6
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 48.31.07965.697FBB35; Tue,  8 Jul 2014 09:52:22 -0400 (EDT)
Received: from [192.168.69.130] (p4FC97EC0.dip0.t-ipconnect.de [79.201.126.192])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s68DqKnG001635
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 8 Jul 2014 09:52:21 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.5.0
In-Reply-To: <1403275409-28173-40-git-send-email-sahlberg@google.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphleLIzCtJLcpLzFFi42IRYndR1J32fXewwZUlQhZdV7qZLP5NqHFg
	8liwqdTj8ya5AKYobpukxJKy4Mz0PH27BO6Mm2siCy4LVXRPPs7cwHiHr4uRk0NCwETi1cnp
	rBC2mMSFe+vZuhi5OIQELjNK7J94lxXCOc8k8fDjEzaQKl4BbYmpf5ewgNgsAqoSrUvvgXWz
	CehKLOppZgKxRQWCJGZ/nscOUS8ocXLmE7B6EQE7ifW3FjKD2MICHhLv2x6A2UICNRKHLvxj
	BLE5BVwl3uzcCLSLA+gicYmexiCQMLOAjsS7PohyZgF5ie1v5zBPYBSYhWTDLCRls5CULWBk
	XsUol5hTmqubm5iZU5yarFucnJiXl1qka6GXm1mil5pSuokREqIiOxiPnJQ7xCjAwajEw7vi
	4K5gIdbEsuLK3EOMkhxMSqK8d97uDhbiS8pPqcxILM6ILyrNSS0+xCjBwawkwvvlFFCONyWx
	siq1KB8mJc3BoiTO+22xup+QQHpiSWp2ampBahFMVoaDQ0mCN/UbUKNgUWp6akVaZk4JQpqJ
	gxNkOJeUSHFqXkpqUWJpSUY8KE7ji4GRCpLiAdq79SvI3uKCxFygKETrKUZFKXHeF1+AEgIg
	iYzSPLixsMTzilEc6Eth3n8g7TzApAXX/QpoMBPQ4M/vd4AMLklESEk1MKZ/TS1Z5MEpbnz2
	3aHIR01eD1n4p9ifff3/sM77Wdp/O+a3XPh3e411+Jsph99tyFmmUflLXf/GQZ+j29q/rv3f
	NkvBcZrCP9O5bwWn2Cql/m88vj/nXLfqb7WNZRFzLVuWOCztVs47OqXkgPS3pW// 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253025>

On 06/20/2014 04:43 PM, Ronnie Sahlberg wrote:
> Change delete_ref to use a ref transaction for the deletion. At the same time
> since we no longer have any callers of repack_without_ref we can now delete
> this function.
> 
> Change delete_ref to return 0 on success and 1 on failure instead of the
> previous 0 on success either 1 or -1 on failure.
> 
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
> ---
>  refs.c | 34 +++++++++++++---------------------
>  1 file changed, 13 insertions(+), 21 deletions(-)
> 
> diff --git a/refs.c b/refs.c
> index 3d070d5..92a06d4 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -2544,11 +2544,6 @@ int repack_without_refs(const char **refnames, int n, struct strbuf *err)
>  	return ret;
>  }
>  
> -static int repack_without_ref(const char *refname)
> -{
> -	return repack_without_refs(&refname, 1, NULL);
> -}
> -
>  static int delete_ref_loose(struct ref_lock *lock, int flag)
>  {
>  	if (!(flag & REF_ISPACKED) || flag & REF_ISSYMREF) {
> @@ -2566,24 +2561,21 @@ static int delete_ref_loose(struct ref_lock *lock, int flag)
>  
>  int delete_ref(const char *refname, const unsigned char *sha1, int delopt)
>  {
> -	struct ref_lock *lock;
> -	int ret = 0, flag = 0;
> +	struct ref_transaction *transaction;
> +	struct strbuf err = STRBUF_INIT;
>  
> -	lock = lock_ref_sha1_basic(refname, sha1, delopt, &flag);

The old code checked that the old value of refname was sha1, regardless
of whether sha1 was null_sha1.  Presumably callers never set sha1 to
null_sha1...

> -	if (!lock)
> +	transaction = ref_transaction_begin(&err);
> +	if (!transaction ||
> +	    ref_transaction_delete(transaction, refname, sha1, delopt,
> +				   sha1 && !is_null_sha1(sha1), &err) ||

...But the new code explicitly skips the check if sha1 is null_sha1.
This shouldn't make a practical difference, because presumably callers
never set sha1 to null_sha1.  But given that the new policy elsewhere
for "delete" updates is that it is an error for old_sha1 to equal
null_sha1, it seems to me that this extra check shouldn't be here.  So I
think this should be changed to

    ref_transaction_delete(transaction, refname, sha1, delopt,
                           !!sha1, &err) ||


> [...]

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
