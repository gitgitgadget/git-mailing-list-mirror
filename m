From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v20 25/48] replace.c: use the ref transaction functions
 for updates
Date: Tue, 08 Jul 2014 14:35:04 +0200
Message-ID: <53BBE578.9030703@alum.mit.edu>
References: <1403275409-28173-1-git-send-email-sahlberg@google.com> <1403275409-28173-26-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 08 14:35:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4Uc6-0004O5-SU
	for gcvg-git-2@plane.gmane.org; Tue, 08 Jul 2014 14:35:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932104AbaGHMfI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2014 08:35:08 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:49944 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754401AbaGHMfH (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Jul 2014 08:35:07 -0400
X-AuditID: 1207440c-f79036d000005e77-67-53bbe57975eb
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 63.C2.24183.975EBB35; Tue,  8 Jul 2014 08:35:05 -0400 (EDT)
Received: from [192.168.69.130] (p4FC97EC0.dip0.t-ipconnect.de [79.201.126.192])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s68CZ4uj030661
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 8 Jul 2014 08:35:05 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.5.0
In-Reply-To: <1403275409-28173-26-git-send-email-sahlberg@google.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplleLIzCtJLcpLzFFi42IRYndR1K18ujvYYPkrY4uuK91MFv8m1Dgw
	eSzYVOrxeZNcAFMUt01SYklZcGZ6nr5dAnfG5t8/2Qv+8VS8/XKXtYFxG1cXIyeHhICJxPqr
	n9ghbDGJC/fWs3UxcnEICVxmlGh61c0K4Zxnkpj6YQszSBWvgLbEx4YNLCA2i4CqxMu+X0wg
	NpuArsSinmYwW1QgSGL253nsEPWCEidnPgGrFxGwk1h/ayHYHGGBSInOW2/A6oUEaiR+7OwB
	q+cUcJVYfO8zkM0BdJG4RE9jEEiYWUBH4l3fA2YIW15i+9s5zBMYBWYh2TALSdksJGULGJlX
	Mcol5pTm6uYmZuYUpybrFicn5uWlFuka6uVmluilppRuYoQEKc8Oxm/rZA4xCnAwKvHwrji4
	K1iINbGsuDL3EKMkB5OSKK/g/d3BQnxJ+SmVGYnFGfFFpTmpxYcYJTiYlUR4v5wCyvGmJFZW
	pRblw6SkOViUxHlVl6j7CQmkJ5akZqemFqQWwWRlODiUJHi5nwA1ChalpqdWpGXmlCCkmTg4
	QYZzSYkUp+alpBYllpZkxIMiNb4YGKsgKR6gvSEg7bzFBYm5QFGI1lOMilLivLYgCQGQREZp
	HtxYWOp5xSgO9KUw78vHQFU8wLQF1/0KaDAT0ODP73eADC5JREhJNTBaPp0st9jGSWPSzc1N
	xV3vNk56HVz3RUQlSM5lQvf0+c+WVlx6FFDyhut2u1b75em8CcxSdwXstorxi93a35iz4fer
	73Y31z6du0D2eZX13tTIvxMvMK5w2Bm+M6n17eo61Y3dho6OMxK3Llp1hfmP9S0Z 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253018>

On 06/20/2014 04:43 PM, Ronnie Sahlberg wrote:
> Update replace.c to use ref transactions for updates.
> 
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
> ---
>  builtin/replace.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/builtin/replace.c b/builtin/replace.c
> index 1bb491d..7528f3d 100644
> --- a/builtin/replace.c
> +++ b/builtin/replace.c
> @@ -153,7 +153,8 @@ static int replace_object_sha1(const char *object_ref,
>  	unsigned char prev[20];
>  	enum object_type obj_type, repl_type;
>  	char ref[PATH_MAX];
> -	struct ref_lock *lock;
> +	struct ref_transaction *transaction;
> +	struct strbuf err = STRBUF_INIT;
>  
>  	obj_type = sha1_object_info(object, NULL);
>  	repl_type = sha1_object_info(repl, NULL);
> @@ -166,12 +167,14 @@ static int replace_object_sha1(const char *object_ref,
>  
>  	check_ref_valid(object, prev, ref, sizeof(ref), force);
>  
> -	lock = lock_any_ref_for_update(ref, prev, 0, NULL);
> -	if (!lock)
> -		die("%s: cannot lock the ref", ref);
> -	if (write_ref_sha1(lock, repl, NULL) < 0)
> -		die("%s: cannot update the ref", ref);
> +	transaction = ref_transaction_begin(&err);
> +	if (!transaction ||
> +	    ref_transaction_update(transaction, ref, repl, prev,
> +				   0, !is_null_sha1(prev), &err) ||

Same problem here.  You need

    s/!is_null_sha1(prev)/1/

> +	    ref_transaction_commit(transaction, NULL, &err))
> +		die("%s", err.buf);
>  
> +	ref_transaction_free(transaction);
>  	return 0;
>  }
>  
> 


-- 
Michael Haggerty
mhagger@alum.mit.edu
