From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v6 1/7] refs.c: add err arguments to reflog functions
Date: Mon, 06 Jul 2015 17:53:52 +0200
Message-ID: <559AA490.3080605@alum.mit.edu>
References: <1435609076-8592-1-git-send-email-dturner@twopensource.com> <1435609076-8592-2-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: David Turner <dturner@twopensource.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 06 17:54:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZC8jK-0006C6-GN
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jul 2015 17:54:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753677AbbGFPyp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jul 2015 11:54:45 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:42811 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753270AbbGFPyH (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Jul 2015 11:54:07 -0400
X-AuditID: 1207440e-f79516d0000012b3-58-559aa492de4e
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id CE.47.04787.294AA955; Mon,  6 Jul 2015 11:53:54 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB05DB.dip0.t-ipconnect.de [93.219.5.219])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t66Frq4K015729
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Mon, 6 Jul 2015 11:53:53 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.7.0
In-Reply-To: <1435609076-8592-2-git-send-email-dturner@twopensource.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphleLIzCtJLcpLzFFi42IRYndR1J20ZFaowfO3WhbzN51gtOi60s1k
	8W9CjQOzx4JNpR4Lnt9n9/i8SS6AOYrbJimxpCw4Mz1P3y6BO+Ntu1dBi13FlMfNTA2Miwy6
	GDk5JARMJO7P/s8KYYtJXLi3nq2LkYtDSOAyo8TnY4+hnLNMEn/mfgByODh4BbQlfm0LBmlg
	EVCVeHx7MzuIzSagK7Gop5kJpERUIEji9ctckDCvgKDEyZlPWEBsEQEHicu7jjKD2MwCmhKb
	NrxgBSkXFvCUWHPACiQsJNDMKHHzAthETgEPiVsvH7JDlOtJ7Lj+ixXClpdo3jqbeQKjwCwk
	G2YhKZuFpGwBI/MqRrnEnNJc3dzEzJzi1GTd4uTEvLzUIl1jvdzMEr3UlNJNjJCQ5dvB2L5e
	5hCjAAejEg9vRM3MUCHWxLLiytxDjJIcTEqivP6LZoUK8SXlp1RmJBZnxBeV5qQWH2KU4GBW
	EuF9NB0ox5uSWFmVWpQPk5LmYFES51Vbou4nJJCeWJKanZpakFoEk5Xh4FCS4H0CMlSwKDU9
	tSItM6cEIc3EwQkynEtKpDg1LyW1KLG0JCMeFKPxxcAoBUnxAO19A9LOW1yQmAsUhWg9xago
	Jc77GiQhAJLIKM2DGwtLRK8YxYG+FOYVWgxUxQNMYnDdr4AGMwENXq4LNrgkESEl1cC42uzO
	040ljm/jpjDZ7uRl5DM7vy3x+uysliZdz2dPVexy8y07Vn4TZjDYdu9WWMipD7N3Gid01dx6
	sW3Xoan2945LfDtodl0uoI5LIq//2j6jiRuiQoKX9v5+/3PRTWEGabt0OYOvP589 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273393>

On 06/29/2015 10:17 PM, David Turner wrote:
> Add an err argument to log_ref_setup that can explain the reason
> for a failure. This then eliminates the need to manage errno through
> this function since we can just add strerror(errno) to the err string
> when meaningful. No callers relied on errno from this function for
> anything else than the error message.
> 
> Also add err arguments to private functions write_ref_to_lockfile,
> log_ref_write_1, commit_ref_update. This again eliminates the need to
> manage errno in these functions.
> 
> Update of a patch by Ronnie Sahlberg.

First a general comment: we have a convention, not yet very well adhered
to, that error messages should start with lower-case letters. I know
that in many cases you are just carrying along pre-existing error
messages that are capitalized. But at a minimum, please avoid adding new
error messages that are capitalized. And if you are feeling ambitious,
feel free to lower-case some existing ones :-)

> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
> Signed-off-by: David Turner <dturner@twopensource.com>
> ---
>  builtin/checkout.c |   8 ++--
>  refs.c             | 111 ++++++++++++++++++++++++++++-------------------------
>  refs.h             |   4 +-
>  3 files changed, 66 insertions(+), 57 deletions(-)
> 
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> [...]
> diff --git a/refs.c b/refs.c
> index fb568d7..c97ca02 100644
> --- a/refs.c
> +++ b/refs.c
> [...]
> @@ -3216,26 +3217,25 @@ static int log_ref_write_1(const char *refname, const unsigned char *old_sha1,
>  	result = log_ref_write_fd(logfd, old_sha1, new_sha1,
>  				  git_committer_info(0), msg);
>  	if (result) {
> -		int save_errno = errno;
>  		close(logfd);
> -		error("Unable to append to %s", log_file);
> -		errno = save_errno;
> +		strbuf_addf(err, "Unable to append to %s. %s", log_file,
> +			    strerror(errno));
>  		return -1;

Above, the call to close(logfd) could clobber errno. It would be better
to exchange the calls.

>  	}
>  	if (close(logfd)) {
> -		int save_errno = errno;
> -		error("Unable to append to %s", log_file);
> -		errno = save_errno;
> +		strbuf_addf(err, "Unable to append to %s. %s", log_file,
> +			    strerror(errno));
>  		return -1;
>  	}
>  	return 0;
>  }
>  
>  static int log_ref_write(const char *refname, const unsigned char *old_sha1,
> -			 const unsigned char *new_sha1, const char *msg)
> +			 const unsigned char *new_sha1, const char *msg,
> +			 struct strbuf *err)
>  {
>  	struct strbuf sb = STRBUF_INIT;
> -	int ret = log_ref_write_1(refname, old_sha1, new_sha1, msg, &sb);
> +	int ret = log_ref_write_1(refname, old_sha1, new_sha1, msg, &sb, err);
>  	strbuf_release(&sb);
>  	return ret;
>  }
> [...]
> @@ -3288,12 +3290,15 @@ static int write_ref_to_lockfile(struct ref_lock *lock,
>   * necessary, using the specified lockmsg (which can be NULL).
>   */
>  static int commit_ref_update(struct ref_lock *lock,
> -			     const unsigned char *sha1, const char *logmsg)
> +			     const unsigned char *sha1, const char *logmsg,
> +			     struct strbuf *err)
>  {
>  	clear_loose_ref_cache(&ref_cache);
> -	if (log_ref_write(lock->ref_name, lock->old_oid.hash, sha1, logmsg) < 0 ||
> +	if (log_ref_write(lock->ref_name, lock->old_oid.hash, sha1, logmsg, err) < 0 ||
>  	    (strcmp(lock->ref_name, lock->orig_ref_name) &&
> -	     log_ref_write(lock->orig_ref_name, lock->old_oid.hash, sha1, logmsg) < 0)) {
> +	     log_ref_write(lock->orig_ref_name, lock->old_oid.hash, sha1, logmsg, err) < 0)) {
> +		strbuf_addf(err, "Cannot update the ref '%s'.",
> +			    lock->ref_name);
>  		unlock_ref(lock);
>  		return -1;
>  	}

Since you are passing err into log_ref_write(), I assume that it would
already have an error message written to it by the time you enter into
this block. Yet in the block you append more text to it.

It seems to me that you either want to clear err and replace it with
your own message, or create a new message that looks like

    Cannot update the ref '%s': %s

where the second "%s" is replaced with the error from log_ref_write().

> @@ -3317,7 +3322,8 @@ static int commit_ref_update(struct ref_lock *lock,
>  					      head_sha1, &head_flag);
>  		if (head_ref && (head_flag & REF_ISSYMREF) &&
>  		    !strcmp(head_ref, lock->ref_name))
> -			log_ref_write("HEAD", lock->old_oid.hash, sha1, logmsg);
> +			log_ref_write("HEAD", lock->old_oid.hash, sha1, logmsg,
> +				      err);

Here you don't check for errors from log_ref_write(). So it might or
might not have written something to err. If it has, is that error
handled correctly?

>  	}
>  	if (commit_ref(lock)) {
>  		error("Couldn't set %s", lock->ref_name);
> @@ -3336,6 +3342,7 @@ int create_symref(const char *ref_target, const char *refs_heads_master,
>  	int fd, len, written;
>  	char *git_HEAD = git_pathdup("%s", ref_target);
>  	unsigned char old_sha1[20], new_sha1[20];
> +	struct strbuf err = STRBUF_INIT;
>  
>  	if (logmsg && read_ref(ref_target, old_sha1))
>  		hashclr(old_sha1);
> @@ -3384,8 +3391,11 @@ int create_symref(const char *ref_target, const char *refs_heads_master,
>  #ifndef NO_SYMLINK_HEAD
>  	done:
>  #endif
> -	if (logmsg && !read_ref(refs_heads_master, new_sha1))
> -		log_ref_write(ref_target, old_sha1, new_sha1, logmsg);
> +	if (logmsg && !read_ref(refs_heads_master, new_sha1) &&
> +		log_ref_write(ref_target, old_sha1, new_sha1, logmsg, &err)) {
> +		error("%s", err.buf);
> +		strbuf_release(&err);
> +	}
>  
>  	free(git_HEAD);
>  	return 0;
> @@ -4021,14 +4031,13 @@ int ref_transaction_commit(struct ref_transaction *transaction,
>  				 * value, so we don't need to write it.
>  				 */
>  			} else if (write_ref_to_lockfile(update->lock,
> -							 update->new_sha1)) {
> +							 update->new_sha1,
> +							 err)) {
>  				/*
>  				 * The lock was freed upon failure of
>  				 * write_ref_to_lockfile():
>  				 */
>  				update->lock = NULL;
> -				strbuf_addf(err, "cannot update the ref '%s'.",
> -					    update->refname);

Previously, the error generated here was "cannot update the ref '%s'."
But now that you are letting write_ref_to_lockfile() fill err, the error
message will be something from that function. This might be OK or it
might not. If you think it is, it would be worth a word or two of
justification in the commit message.

>  				ret = TRANSACTION_GENERIC_ERROR;
>  				goto cleanup;
>  			} else {
> @@ -4054,11 +4063,9 @@ int ref_transaction_commit(struct ref_transaction *transaction,
>  
>  		if (update->flags & REF_NEEDS_COMMIT) {
>  			if (commit_ref_update(update->lock,
> -					      update->new_sha1, update->msg)) {
> +					      update->new_sha1, update->msg, err)) {
>  				/* freed by commit_ref_update(): */
>  				update->lock = NULL;
> -				strbuf_addf(err, "Cannot update the ref '%s'.",
> -					    update->refname);

Same story here: you use whatever error message that commit_ref_update()
emitted rather than the one that was previously chosen here.

>  				ret = TRANSACTION_GENERIC_ERROR;
>  				goto cleanup;
>  			} else {
> diff --git a/refs.h b/refs.h
> index e82fca5..debdefc 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -226,9 +226,9 @@ int pack_refs(unsigned int flags);
>  #define REF_NODEREF	0x01
>  
>  /*
> - * Setup reflog before using. Set errno to something meaningful on failure.
> + * Setup reflog before using. Fill in err and return -1 on failure.
>   */
> -int log_ref_setup(const char *refname, struct strbuf *logfile);
> +int log_ref_setup(const char *refname, struct strbuf *logfile, struct strbuf *err);
>  
>  /** Reads log for the value of ref during at_time. **/
>  extern int read_ref_at(const char *refname, unsigned int flags,
> 

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
