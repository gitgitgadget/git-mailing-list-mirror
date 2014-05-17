From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v10 14/44] replace.c: use the ref transaction functions
 for updates
Date: Sat, 17 May 2014 15:14:28 +0200
Message-ID: <537760B4.4010904@alum.mit.edu>
References: <1400261852-31303-1-git-send-email-sahlberg@google.com> <1400261852-31303-15-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 17 15:14:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WleRf-0002aV-Lj
	for gcvg-git-2@plane.gmane.org; Sat, 17 May 2014 15:14:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755660AbaEQNOc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 May 2014 09:14:32 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:44613 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753964AbaEQNOb (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 17 May 2014 09:14:31 -0400
X-AuditID: 1207440d-f79c26d000000b51-ec-537760b67f09
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 0E.E9.02897.6B067735; Sat, 17 May 2014 09:14:30 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB3A76.dip0.t-ipconnect.de [93.219.58.118])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s4HDES2l024057
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Sat, 17 May 2014 09:14:29 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.4.0
In-Reply-To: <1400261852-31303-15-git-send-email-sahlberg@google.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjleLIzCtJLcpLzFFi42IRYndR1N2WUB5sMPmrtEXXlW4mi38TahyY
	PBZsKvX4vEkugCmK2yYpsaQsODM9T98ugTvj54THzAVXeSp2XFvH3sDYz9XFyMkhIWAi0XX/
	MiuELSZx4d56NhBbSOAyo8SaTs0uRi4g+zyTxKrWlWBFvALaEs+6LzCD2CwCqhJ3e3cygdhs
	AroSi3qagWwODlGBIIk/ZxUhygUlTs58wgJiiwjYSay/tRCsVVggUmLn9bPsELtqJJ69PscM
	0sop4Coxf2Y0iCkhIC7R0xgEUsEsoCPxru8BM4QtL7H97RzmCYwCs5AsmIWkbBaSsgWMzKsY
	5RJzSnN1cxMzc4pTk3WLkxPz8lKLdI30cjNL9FJTSjcxQsKTdwfj/3UyhxgFOBiVeHg5bMuC
	hVgTy4orcw8xSnIwKYny2saWBwvxJeWnVGYkFmfEF5XmpBYfYpTgYFYS4d3tBpTjTUmsrEot
	yodJSXOwKInzqi1R9xMSSE8sSc1OTS1ILYLJynBwKEnwtsUDNQoWpaanVqRl5pQgpJk4OEGG
	c0mJFKfmpaQWJZaWZMSDYjS+GBilICkeoL0NIO28xQWJuUBRiNZTjLocp+4ca2MSYsnLz0uV
	EueNAikSACnKKM2DWwFLRq8YxYE+FuatB6niASYyuEmvgJYwAS15s7cUZElJIkJKqoFxouMl
	HuYz+uUJT5S0n11iPaq/aEfGy+9Jf7u7F0fM3PTi7DefoikOCncNjPbZzvg/teNxYNmRnccm
	ZH/KqpV9kcG983rU4kAxs7vzZzGw17/juK9q7r/ZlmFntrrLL4M12R2P9h5x1pLV 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249467>

On 05/16/2014 07:37 PM, Ronnie Sahlberg wrote:
> Update replace.c to use ref transactions for updates.
> 
> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
> ---
>  builtin/replace.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/builtin/replace.c b/builtin/replace.c
> index 3da1bae..e8932cd 100644
> --- a/builtin/replace.c
> +++ b/builtin/replace.c
> @@ -133,7 +133,8 @@ static int replace_object_sha1(const char *object_ref,
>  	unsigned char prev[20];
>  	enum object_type obj_type, repl_type;
>  	char ref[PATH_MAX];
> -	struct ref_lock *lock;
> +	struct ref_transaction *transaction;
> +	struct strbuf err = STRBUF_INIT;
>  
>  	if (snprintf(ref, sizeof(ref),
>  		     "refs/replace/%s",
> @@ -156,11 +157,12 @@ static int replace_object_sha1(const char *object_ref,
>  	else if (!force)
>  		die("replace ref '%s' already exists", ref);
>  
> -	lock = lock_any_ref_for_update(ref, prev, 0, NULL);
> -	if (!lock)
> -		die("%s: cannot lock the ref", ref);
> -	if (write_ref_sha1(lock, repl, NULL) < 0)
> -		die("%s: cannot update the ref", ref);
> +	transaction = ref_transaction_begin();
> +	if (!transaction ||
> +	    ref_transaction_update(transaction, ref, repl, prev,
> +				   0, !is_null_sha1(prev), &err) ||
> +	    ref_transaction_commit(transaction, NULL, &err))
> +		die("%s", err.buf);

Same here: err can be empty if ref_transaction_begin() fails.  Please
check later patches for the same error.

>  
>  	return 0;
>  }
> 


-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
