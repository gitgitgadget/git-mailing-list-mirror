From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v20 33/48] walker.c: use ref transaction for ref updates
Date: Tue, 08 Jul 2014 15:33:39 +0200
Message-ID: <53BBF333.903@alum.mit.edu>
References: <1403275409-28173-1-git-send-email-sahlberg@google.com> <1403275409-28173-34-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 08 15:33:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4VWl-0000yu-0A
	for gcvg-git-2@plane.gmane.org; Tue, 08 Jul 2014 15:33:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753507AbaGHNdm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2014 09:33:42 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:50438 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753495AbaGHNdm (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Jul 2014 09:33:42 -0400
X-AuditID: 12074413-f79ed6d000002501-79-53bbf335e124
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id D7.0F.09473.533FBB35; Tue,  8 Jul 2014 09:33:41 -0400 (EDT)
Received: from [192.168.69.130] (p4FC97EC0.dip0.t-ipconnect.de [79.201.126.192])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s68DXdmK000784
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 8 Jul 2014 09:33:40 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.5.0
In-Reply-To: <1403275409-28173-34-git-send-email-sahlberg@google.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphleLIzCtJLcpLzFFi42IRYndR1DX9vDvY4NQZZYuuK91MFv8m1Dgw
	eSzYVOrxeZNcAFMUt01SYklZcGZ6nr5dAnfGv1nPWAruKlYcf3uapYFxkVQXIyeHhICJxNwV
	J1ghbDGJC/fWs3UxcnEICVxmlLiy/hU7hHOeSeLFqU1ADgcHr4C6xOXvmiANLAKqEgfvz2IC
	sdkEdCUW9TSD2aICQRKzP89jB7F5BQQlTs58wgJiiwjYSay/tZAZxBYW8JG48O0uWL2QQI3E
	pK42sDingKvEqcN7wFZJCIhL9DQGgYSZBXQk3vU9YIaw5SW2v53DPIFRYBaSDbOQlM1CUraA
	kXkVo1xiTmmubm5iZk5xarJucXJiXl5qka65Xm5miV5qSukmRkiICu9g3HVS7hCjAAejEg/v
	ioO7goVYE8uKK3MPMUpyMCmJ8t55uztYiC8pP6UyI7E4I76oNCe1+BCjBAezkgjvl1NAOd6U
	xMqq1KJ8mJQ0B4uSOK/aEnU/IYH0xJLU7NTUgtQimKwMB4eSBG/CJ6BGwaLU9NSKtMycEoQ0
	EwcnyHAuKZHi1LyU1KLE0pKMeFCcxhcDIxUkxQO0Nw+knbe4IDEXKArReopRUUqcVwwkIQCS
	yCjNgxsLSzyvGMWBvhTmrQSp4gEmLbjuV0CDmYAGf36/A2RwSSJCSqqB0XHKiVXvYi99CHDY
	N+W5ssZr+y1Hz7Lp9ug+qhaKsrqkpDFP8/7Jw6kv2NI0H9+7ffvdnFTjHrHUyCwZvs8ua0Oy
	g2Mvy1hJyebsXhm2S3l5aL2WQZznix/ME4TD8tXXXOe8N+f73K/Pn7f/qo2d5yn3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253023>

On 06/20/2014 04:43 PM, Ronnie Sahlberg wrote:
> Switch to using ref transactions in walker_fetch(). As part of the refactoring
> to use ref transactions we also fix a potential memory leak where in the
> original code if write_ref_sha1() would fail we would end up returning from
> the function without free()ing the msg string.
> 
> Note that this function is only called when fetching from a remote HTTP
> repository onto the local (most of the time single-user) repository which
> likely means that the type of collissions that the previous locking would

s/collissions/collisions/

> protect against and cause the fetch to fail for to be even more rare.

Grammatico: s/to be/are/ ?

> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
> ---
>  walker.c | 59 +++++++++++++++++++++++++++++++++++------------------------
>  1 file changed, 35 insertions(+), 24 deletions(-)
> 
> diff --git a/walker.c b/walker.c
> index 1dd86b8..60d9f9e 100644
> --- a/walker.c
> +++ b/walker.c
> @@ -251,39 +251,36 @@ void walker_targets_free(int targets, char **target, const char **write_ref)
>  int walker_fetch(struct walker *walker, int targets, char **target,
>  		 const char **write_ref, const char *write_ref_log_details)
>  {
> -	struct ref_lock **lock = xcalloc(targets, sizeof(struct ref_lock *));
> +	struct strbuf ref_name = STRBUF_INIT;
> +	struct strbuf err = STRBUF_INIT;
> +	struct ref_transaction *transaction = NULL;
>  	unsigned char *sha1 = xmalloc(targets * 20);
> -	char *msg;
> -	int ret;
> +	char *msg = NULL;
>  	int i;
>  
>  	save_commit_buffer = 0;
>  
> -	for (i = 0; i < targets; i++) {
> -		if (!write_ref || !write_ref[i])
> -			continue;
> -
> -		lock[i] = lock_ref_sha1(write_ref[i], NULL);
> -		if (!lock[i]) {
> -			error("Can't lock ref %s", write_ref[i]);
> -			goto unlock_and_fail;
> +	if (write_ref) {
> +		transaction = ref_transaction_begin(&err);
> +		if (!transaction) {
> +			error("%s", err.buf);
> +			goto rollback_and_fail;
>  		}
>  	}
> -

Is there some reason why the transaction cannot be built up during a
single iteration over targets, thereby also avoiding the need for the
sha1[20*i] stuff?  This seems like exactly the kind of situation where
transactions should *save* code.  But perhaps I've overlooked a
dependency between the two loops.

>  	if (!walker->get_recover)
>  		for_each_ref(mark_complete, NULL);
>  
>  	for (i = 0; i < targets; i++) {
>  		if (interpret_target(walker, target[i], &sha1[20 * i])) {
>  			error("Could not interpret response from server '%s' as something to pull", target[i]);
> -			goto unlock_and_fail;
> +			goto rollback_and_fail;
>  		}
>  		if (process(walker, lookup_unknown_object(&sha1[20 * i])))
> -			goto unlock_and_fail;
> +			goto rollback_and_fail;
>  	}
>  
>  	if (loop(walker))
> -		goto unlock_and_fail;
> +		goto rollback_and_fail;
>  
>  	if (write_ref_log_details) {
>  		msg = xmalloc(strlen(write_ref_log_details) + 12);
> @@ -294,19 +291,33 @@ int walker_fetch(struct walker *walker, int targets, char **target,
>  	for (i = 0; i < targets; i++) {
>  		if (!write_ref || !write_ref[i])
>  			continue;
> -		ret = write_ref_sha1(lock[i], &sha1[20 * i], msg ? msg : "fetch (unknown)");
> -		lock[i] = NULL;
> -		if (ret)
> -			goto unlock_and_fail;
> +		strbuf_reset(&ref_name);
> +		strbuf_addf(&ref_name, "refs/%s", write_ref[i]);
> +		if (ref_transaction_update(transaction, ref_name.buf,
> +					   &sha1[20 * i], NULL, 0, 0,
> +					   &err)) {
> +			error("%s", err.buf);
> +			goto rollback_and_fail;
> +		}
> +	}
> +	if (write_ref) {
> +		if (ref_transaction_commit(transaction,
> +					   msg ? msg : "fetch (unknown)",
> +					   &err)) {
> +			error("%s", err.buf);
> +			goto rollback_and_fail;
> +		}
> +		ref_transaction_free(transaction);
>  	}
> -	free(msg);
>  
> +	free(msg);
>  	return 0;
>  
> -unlock_and_fail:
> -	for (i = 0; i < targets; i++)
> -		if (lock[i])
> -			unlock_ref(lock[i]);
> +rollback_and_fail:
> +	ref_transaction_free(transaction);
> +	free(msg);
> +	strbuf_release(&err);
> +	strbuf_release(&ref_name);
>  
>  	return -1;
>  }
> 

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
