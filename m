From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 06/11] replace.c: use the ref transaction functions for
 updates
Date: Sat, 19 Apr 2014 21:14:32 +0200
Message-ID: <5352CB18.5000007@alum.mit.edu>
References: <1397763987-4453-1-git-send-email-sahlberg@google.com> <1397763987-4453-7-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 19 21:14:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wbaim-0004BM-JQ
	for gcvg-git-2@plane.gmane.org; Sat, 19 Apr 2014 21:14:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755194AbaDSTOg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Apr 2014 15:14:36 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:64905 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755112AbaDSTOf (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Apr 2014 15:14:35 -0400
X-AuditID: 1207440e-f79c76d000003e2c-ae-5352cb1a54ab
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id A0.C3.15916.A1BC2535; Sat, 19 Apr 2014 15:14:34 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB2858.dip0.t-ipconnect.de [93.219.40.88])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s3JJEWIo018890
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Sat, 19 Apr 2014 15:14:33 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.4.0
In-Reply-To: <1397763987-4453-7-git-send-email-sahlberg@google.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAKsWRmVeSWpSXmKPExsUixO6iqCt1OijYoH+euEXXlW4mi38TahyY
	PBZsKvX4vEkugCmK2yYpsaQsODM9T98ugTuj9dJc9oL5fBXfT/WwNDAe4+5i5OSQEDCRmHbm
	OjOELSZx4d56ti5GLg4hgcuMEm0PrjFCOOeYJFourWYDqeIV0JZomT2PBcRmEVCVWNBxE8xm
	E9CVWNTTzNTFyMEhKhAk8eesIkS5oMTJmU/ASkQE7CTW31oItkxYIFTi64wDjCC2kEClxKOt
	nWBxTgFnif8fl7OCjJEQEJfoaQwCCTML6Ei863vADGHLS2x/O4d5AqPALCQbZiEpm4WkbAEj
	8ypGucSc0lzd3MTMnOLUZN3i5MS8vNQiXWO93MwSvdSU0k2MkBDl28HYvl7mEKMAB6MSD++G
	gMBgIdbEsuLK3EOMkhxMSqK8f9cHBQvxJeWnVGYkFmfEF5XmpBYfYpTgYFYS4Z2xByjHm5JY
	WZValA+TkuZgURLnVVui7ickkJ5YkpqdmlqQWgSTleHgUJLgXXYSqFGwKDU9tSItM6cEIc3E
	wQkynEtKpDg1LyW1KLG0JCMeFKfxxcBIBUnxAO31B2nnLS5IzAWKQrSeYtTluNCwooVJiCUv
	Py9VSpw35ARQkQBIUUZpHtwKWEJ6xSgO9LEw7wmQUTzAZAY36RXQEiagJX/PBIAsKUlESEk1
	MFqrtOQ6z/SpEWZ6/TTNfNUllUVf3n1WcREt1lioEnlsEbfYyj5L/YTA+ZnbToVc1r3I0sK1
	dhdT8EIH9rNJbur89zTeBaw/ZPyvOPT3yQTB5o/C0zLeb+g7tYCFr6gqKOXgGb/C 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246530>

On 04/17/2014 09:46 PM, Ronnie Sahlberg wrote:
> Update replace.c to use ref transactions for updates.
> 
> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
> ---
>  builtin/replace.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/builtin/replace.c b/builtin/replace.c
> index b62420a..d8bd6ee 100644
> --- a/builtin/replace.c
> +++ b/builtin/replace.c
> @@ -129,7 +129,7 @@ static int replace_object(const char *object_ref, const char *replace_ref,
>  	unsigned char object[20], prev[20], repl[20];
>  	enum object_type obj_type, repl_type;
>  	char ref[PATH_MAX];
> -	struct ref_lock *lock;
> +	struct ref_transaction *transaction;
>  
>  	if (get_sha1(object_ref, object))
>  		die("Failed to resolve '%s' as a valid ref.", object_ref);
> @@ -157,11 +157,14 @@ static int replace_object(const char *object_ref, const char *replace_ref,
>  	else if (!force)
>  		die("replace ref '%s' already exists", ref);
>  
> -	lock = lock_any_ref_for_update(ref, prev, 0, NULL);
> -	if (!lock)
> -		die("%s: cannot lock the ref", ref);
> -	if (write_ref_sha1(lock, repl, NULL) < 0)
> -		die("%s: cannot update the ref", ref);
> +	transaction = ref_transaction_begin();
> +	if (!transaction)
> +		die(_("%s: cannot start transaction"), ref);
> +	if (ref_transaction_update(transaction, ref, repl, prev,
> +				   0, !is_null_sha1(prev)))
> +		die(_("%s: cannot update transaction"), ref);
> +	if (ref_transaction_commit(transaction, NULL, UPDATE_REFS_DIE_ON_ERR))
> +		die(_("%s: cannot commit transaction"), ref);

The same comment that I made to 05/11 applies here too (and, I predict,
to other patches yet to come).

>  
>  	return 0;
>  }
> 

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
