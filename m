From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v10 04/44] refs.c: add an err argument to repack_without_refs
Date: Sat, 17 May 2014 14:40:01 +0200
Message-ID: <537758A1.9080809@alum.mit.edu>
References: <1400261852-31303-1-git-send-email-sahlberg@google.com> <1400261852-31303-5-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 17 14:40:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlduO-0003tz-7A
	for gcvg-git-2@plane.gmane.org; Sat, 17 May 2014 14:40:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757253AbaEQMkG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 May 2014 08:40:06 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:44910 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753115AbaEQMkE (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 17 May 2014 08:40:04 -0400
X-AuditID: 1207440c-f79656d000000c83-8b-537758a365ec
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id A8.31.03203.3A857735; Sat, 17 May 2014 08:40:03 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB3A76.dip0.t-ipconnect.de [93.219.58.118])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s4HCe18e022664
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Sat, 17 May 2014 08:40:02 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.4.0
In-Reply-To: <1400261852-31303-5-git-send-email-sahlberg@google.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAKsWRmVeSWpSXmKPExsUixO6iqLs4ojzYoOWnvEXXlW4mi38TahyY
	PBZsKvX4vEkugCmK2yYpsaQsODM9T98ugTtjyZeJ7AUn9Cv+P13C1sD4ULWLkZNDQsBEYtH+
	3UwQtpjEhXvr2boYuTiEBC4zShx8vIYJwjnPJNH09A9YFa+AtsT3GUdZQWwWAVWJWw9+MoLY
	bAK6Eot6moFqODhEBYIk/pxVhCgXlDg58wkLiC0iYCex/tZCZhBbWCBQYs/MNewgtpBAtcSc
	a+fA4pwCLhITL6xgBBkjISAu0dMYBBJmFtCReNf3gBnClpfY/nYO8wRGgVlINsxCUjYLSdkC
	RuZVjHKJOaW5urmJmTnFqcm6xcmJeXmpRbqGermZJXqpKaWbGCEhyrOD8ds6mUOMAhyMSjy8
	HLZlwUKsiWXFlbmHGCU5mJREeb+GlgcL8SXlp1RmJBZnxBeV5qQWH2KU4GBWEuHd7QaU401J
	rKxKLcqHSUlzsCiJ86ouUfcTEkhPLEnNTk0tSC2CycpwcChJ8FqEAzUKFqWmp1akZeaUIKSZ
	ODhBhnNJiRSn5qWkFiWWlmTEg+I0vhgYqSApHqC9tSDtvMUFiblAUYjWU4y6HKfuHGtjEmLJ
	y89LlRLnvREGVCQAUpRRmge3ApaQXjGKA30szNsIMooHmMzgJr0CWsIEtOTN3lKQJSWJCCmp
	BkYD+XNdp5/oKO809Lo6UdvjZbdFbKa33Kyv/Qdrt2148nfrXN1rOkXtSb6347vMuv8YudUv
	3Ja0JbF0QunVvMLXV66/URBYOfHa54+mbzsPe1v2bn5uILCL57Xux9fvi9cVBG/c 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249465>

On 05/16/2014 07:36 PM, Ronnie Sahlberg wrote:
> Update repack_without_refs to take an err argument and update it if there
> is a failure. Pass the err variable from ref_transaction_commit to this
> function so that callers can print a meaningful error message if _commit
> fails due to a problem in repack_without_refs.
> 
> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
> ---
>  cache.h    |  2 ++
>  lockfile.c | 21 ++++++++++++---------
>  refs.c     | 25 +++++++++++++++++++------
>  3 files changed, 33 insertions(+), 15 deletions(-)
> 
> diff --git a/cache.h b/cache.h
> index 8c6cdc2..48548d6 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -559,6 +559,8 @@ struct lock_file {
>  #define LOCK_DIE_ON_ERROR 1
>  #define LOCK_NODEREF 2
>  extern int unable_to_lock_error(const char *path, int err);
> +extern void unable_to_lock_strbuf(const char *path, int err,
> +				  struct strbuf *buf);
>  extern NORETURN void unable_to_lock_index_die(const char *path, int err);
>  extern int hold_lock_file_for_update(struct lock_file *, const char *path, int);
>  extern int hold_lock_file_for_append(struct lock_file *, const char *path, int);
> diff --git a/lockfile.c b/lockfile.c
> index 8fbcb6a..9e04b43 100644
> --- a/lockfile.c
> +++ b/lockfile.c
> @@ -157,33 +157,36 @@ static int lock_file(struct lock_file *lk, const char *path, int flags)
>  	return lk->fd;
>  }
>  
> -static char *unable_to_lock_message(const char *path, int err)
> +void unable_to_lock_strbuf(const char *path, int err, struct strbuf *buf)
>  {
> -	struct strbuf buf = STRBUF_INIT;
>  
>  	if (err == EEXIST) {
> -		strbuf_addf(&buf, "Unable to create '%s.lock': %s.\n\n"
> +		strbuf_addf(buf, "Unable to create '%s.lock': %s.\n\n"
>  		    "If no other git process is currently running, this probably means a\n"
>  		    "git process crashed in this repository earlier. Make sure no other git\n"
>  		    "process is running and remove the file manually to continue.",
>  			    absolute_path(path), strerror(err));
>  	} else
> -		strbuf_addf(&buf, "Unable to create '%s.lock': %s",
> +		strbuf_addf(buf, "Unable to create '%s.lock': %s",
>  			    absolute_path(path), strerror(err));
> -	return strbuf_detach(&buf, NULL);
>  }
>  
>  int unable_to_lock_error(const char *path, int err)
>  {
> -	char *msg = unable_to_lock_message(path, err);
> -	error("%s", msg);
> -	free(msg);
> +	struct strbuf buf = STRBUF_INIT;
> +
> +	unable_to_lock_strbuf(path, err, &buf);
> +	error("%s", buf.buf);
> +	strbuf_release(&buf);
>  	return -1;
>  }
>  
>  NORETURN void unable_to_lock_index_die(const char *path, int err)
>  {
> -	die("%s", unable_to_lock_message(path, err));
> +	struct strbuf buf = STRBUF_INIT;
> +
> +	unable_to_lock_strbuf(path, err, &buf);
> +	die("%s", buf.buf);
>  }
>  
>  int hold_lock_file_for_update(struct lock_file *lk, const char *path, int flags)
> diff --git a/refs.c b/refs.c
> index 686b802..a470e51 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -2208,6 +2208,7 @@ int commit_packed_refs(void)
>  	struct packed_ref_cache *packed_ref_cache =
>  		get_packed_ref_cache(&ref_cache);
>  	int error = 0;
> +	int save_errno;
>  
>  	if (!packed_ref_cache->lock)
>  		die("internal error: packed-refs not locked");
> @@ -2217,10 +2218,13 @@ int commit_packed_refs(void)
>  	do_for_each_entry_in_dir(get_packed_ref_dir(packed_ref_cache),
>  				 0, write_packed_entry_fn,
>  				 &packed_ref_cache->lock->fd);
> -	if (commit_lock_file(packed_ref_cache->lock))
> +	if (commit_lock_file(packed_ref_cache->lock)) {
> +		save_errno = errno;
>  		error = -1;
> +	}
>  	packed_ref_cache->lock = NULL;
>  	release_packed_ref_cache(packed_ref_cache);
> +	errno = save_errno;

This code involving save_errno looks like a bug fix orthogonal to the
rest of the patch.  It should at least be mentioned in the commit
message if not broken into a separate patch.

>  	return error;
>  }
>  
> @@ -2427,12 +2431,12 @@ static int curate_packed_ref_fn(struct ref_entry *entry, void *cb_data)
>  	return 0;
>  }
>  
> -static int repack_without_refs(const char **refnames, int n)
> +static int repack_without_refs(const char **refnames, int n, struct strbuf *err)
>  {
>  	struct ref_dir *packed;
>  	struct string_list refs_to_delete = STRING_LIST_INIT_DUP;
>  	struct string_list_item *ref_to_delete;
> -	int i, removed = 0;
> +	int i, ret, removed = 0;
>  
>  	/* Look for a packed ref */
>  	for (i = 0; i < n; i++)
> @@ -2444,6 +2448,11 @@ static int repack_without_refs(const char **refnames, int n)
>  		return 0; /* no refname exists in packed refs */
>  
>  	if (lock_packed_refs(0)) {
> +		if (err) {
> +			unable_to_lock_strbuf(git_path("packed-refs"), errno,
> +					      err);
> +			return 1;

error() returns -1, but here you have changed the return value to 1.  Is
there a reason for the change?

> +		}
>  		unable_to_lock_error(git_path("packed-refs"), errno);
>  		return error("cannot delete '%s' from packed refs", refnames[i]);
>  	}
> @@ -2470,12 +2479,16 @@ static int repack_without_refs(const char **refnames, int n)
>  	}
>  
>  	/* Write what remains */
> -	return commit_packed_refs();
> +	ret = commit_packed_refs();
> +	if (ret && err)
> +		strbuf_addf(err, "unable to overwrite old ref-pack file: %s",
> +			    strerror(errno));
> +	return ret;
>  }
>  
>  static int repack_without_ref(const char *refname)
>  {
> -	return repack_without_refs(&refname, 1);
> +	return repack_without_refs(&refname, 1, NULL);
>  }
>  
>  static int delete_ref_loose(struct ref_lock *lock, int flag)
> @@ -3481,7 +3494,7 @@ int ref_transaction_commit(struct ref_transaction *transaction,
>  		}
>  	}
>  
> -	ret |= repack_without_refs(delnames, delnum);
> +	ret |= repack_without_refs(delnames, delnum, err);
>  	for (i = 0; i < delnum; i++)
>  		unlink_or_warn(git_path("logs/%s", delnames[i]));
>  	clear_loose_ref_cache(&ref_cache);
> 


-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
