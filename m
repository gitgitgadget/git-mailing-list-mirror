From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v20 27/48] sequencer.c: use ref transactions for all ref
 updates
Date: Tue, 08 Jul 2014 14:23:50 +0200
Message-ID: <53BBE2D6.2070809@alum.mit.edu>
References: <1403275409-28173-1-git-send-email-sahlberg@google.com> <1403275409-28173-28-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 08 14:23:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4URA-0005Zs-SK
	for gcvg-git-2@plane.gmane.org; Tue, 08 Jul 2014 14:23:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754346AbaGHMXx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2014 08:23:53 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:42406 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753801AbaGHMXw (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Jul 2014 08:23:52 -0400
X-AuditID: 1207440f-f79156d000006a5c-59-53bbe2d74638
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 52.F8.27228.7D2EBB35; Tue,  8 Jul 2014 08:23:51 -0400 (EDT)
Received: from [192.168.69.130] (p4FC97EC0.dip0.t-ipconnect.de [79.201.126.192])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s68CNoYN030199
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 8 Jul 2014 08:23:51 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.5.0
In-Reply-To: <1403275409-28173-28-git-send-email-sahlberg@google.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAKsWRmVeSWpSXmKPExsUixO6iqHv90e5gg3k3jS26rnQzWfybUOPA
	5LFgU6nH501yAUxR3DZJiSVlwZnpefp2CdwZc//fZil4IFzx7VsvSwPjPv4uRk4OCQETiUPv
	p7FC2GISF+6tZwOxhQQuM0p8+VLXxcgFZJ9nkviw4C0zSIJXQFvi7qml7CA2i4CqxMEDv8Ea
	2AR0JRb1NDOB2KICQRKzP89jh6gXlDg58wkLiC0iYCex/tZCsDnCAmES62Z/YIVYViPRc+oa
	WJxTwFXi5PeFQDM5gA4Sl+hpDAIJMwvoSLzre8AMYctLbH87h3kCo8AsJBtmISmbhaRsASPz
	Kka5xJzSXN3cxMyc4tRk3eLkxLy81CJdE73czBK91JTSTYyQEOXfwdi1XuYQowAHoxIP74qD
	u4KFWBPLiitzDzFKcjApifIK3t8dLMSXlJ9SmZFYnBFfVJqTWnyIUYKDWUmE98spoBxvSmJl
	VWpRPkxKmoNFSZxXfYm6n5BAemJJanZqakFqEUxWhoNDSYKXERiLQoJFqempFWmZOSUIaSYO
	TpDhXFIixal5KalFiaUlGfGgOI0vBkYqSIoHaO++hyB7iwsSc4GiEK2nGHU5Tt051sYkxJKX
	n5cqJc6bB1IkAFKUUZoHtwKWkF4xigN9LMx7DqSKB5jM4Ca9AlrCBLTk8/sdIEtKEhFSUg2M
	cw2bpkUvdHkjsWTZ8mL1xRbnQis1UvdbKgXtlLjPWcRxerPB/4ivB34oSIYfmOXyclOf247d
	03WWhi6XlU59//OPJyMzm+d606kTMi9UxsRYpj042T7tYAJ7pMn61ZNDrDdvfNrz 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253016>

On 06/20/2014 04:43 PM, Ronnie Sahlberg wrote:
> Change to use ref transactions for all updates to refs.
> 
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
> ---
>  sequencer.c | 24 ++++++++++++++++--------
>  1 file changed, 16 insertions(+), 8 deletions(-)
> 
> diff --git a/sequencer.c b/sequencer.c
> index 0a80c58..fd8acaf 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -272,23 +272,31 @@ static int error_dirty_index(struct replay_opts *opts)
>  static int fast_forward_to(const unsigned char *to, const unsigned char *from,
>  			int unborn, struct replay_opts *opts)
>  {
> -	struct ref_lock *ref_lock;
> +	struct ref_transaction *transaction;
>  	struct strbuf sb = STRBUF_INIT;
> -	int ret;
> +	struct strbuf err = STRBUF_INIT;
>  
>  	read_cache();
>  	if (checkout_fast_forward(from, to, 1))
>  		exit(1); /* the callee should have complained already */
> -	ref_lock = lock_any_ref_for_update("HEAD", unborn ? null_sha1 : from,
> -					   0, NULL);
> -	if (!ref_lock)
> -		return error(_("Failed to lock HEAD during fast_forward_to"));

I think you've changed the semantics when unborn is set.  Please note
that lock_any_ref_for_update() behaves differently if old_sha1 is NULL
(when no check is done) vs. when it is null_sha1 (when it verifies that
the reference didn't previously exist).  So when unborn is true, the old
code verifies that the reference previously didn't exist...

>  
>  	strbuf_addf(&sb, "%s: fast-forward", action_name(opts));
> -	ret = write_ref_sha1(ref_lock, to, sb.buf);
> +
> +	transaction = ref_transaction_begin(&err);
> +	if (!transaction ||
> +	    ref_transaction_update(transaction, "HEAD", to, from,
> +				   0, !unborn, &err) ||

...whereas when unborn is true, the new code does no check at all.  I
think you want

    ref_transaction_update(transaction, "HEAD",
                           to, unborn ? null_sha1 : from,
                           0, 1, &err) ||

> +	    ref_transaction_commit(transaction, sb.buf, &err)) {
> +		ref_transaction_free(transaction);
> +		error("%s", err.buf);
> +		strbuf_release(&sb);
> +		strbuf_release(&err);
> +		return -1;
> +	}
>  
>  	strbuf_release(&sb);
> -	return ret;
> +	ref_transaction_free(transaction);
> +	return 0;
>  }
>  
>  static int do_recursive_merge(struct commit *base, struct commit *next,
> 

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
