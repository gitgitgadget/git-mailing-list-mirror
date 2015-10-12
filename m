From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v3 19/44] refs-be-files.c: add a backend method
 structure with transaction functions
Date: Mon, 12 Oct 2015 18:25:06 -0400
Organization: Twitter
Message-ID: <1444688706.7234.1.camel@twopensource.com>
References: <1444686725-27660-1-git-send-email-dturner@twopensource.com>
	 <1444686725-27660-21-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: mhagger@alum.mit.edu
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 13 00:25:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZllWt-0003Mt-SO
	for gcvg-git-2@plane.gmane.org; Tue, 13 Oct 2015 00:25:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752254AbbJLWZJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2015 18:25:09 -0400
Received: from mail-qg0-f50.google.com ([209.85.192.50]:36681 "EHLO
	mail-qg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751670AbbJLWZI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2015 18:25:08 -0400
Received: by qgx61 with SMTP id 61so130119906qgx.3
        for <git@vger.kernel.org>; Mon, 12 Oct 2015 15:25:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=01SV1nBd1SN+wggccn1AOEE7qzsbTy9g0veALrc6aAQ=;
        b=Q7ReBHI5NGtyepsF8i+KO7SnR34fY6R1FuXv/yHkhBTmabyOxCvSCRHs+0YfprT+JC
         BEbrBhgCKn+63XStlP/F9vQG0dWLAnH49Zb/th74h9HZqvBgPfvaa0OLeQy03WVp1R9i
         7v34GeVYbqUdiyro0W7iddqAH0sTSxA2/iUvja4Y4PxIV7SZhc9zsVUQebVRWCVvqrE/
         +Y6ROsnnxaCk9bWqSATaJrsiTmQMoRGVOHhvSFq2/g0XWd7vkaCq07g5hHVPPcBkpsYp
         ze08jVycbp7VG31V/bc6NClSJxo3yUhaCxznUGSnUcrWOhNf/u2Hd9XO2uRothpjv9lM
         IArw==
X-Gm-Message-State: ALoCoQl+hF6eSZrNYjbPvyOPnvpJ30d8QQ+xHj7Hg/vgN/t/u1uCo4LUmVgMbHRCoUF0HpRc/9uJ
X-Received: by 10.140.217.70 with SMTP id n67mr37291400qhb.96.1444688707721;
        Mon, 12 Oct 2015 15:25:07 -0700 (PDT)
Received: from ubuntu ([192.133.79.147])
        by smtp.gmail.com with ESMTPSA id 142sm7913383qhg.13.2015.10.12.15.25.06
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Oct 2015 15:25:06 -0700 (PDT)
In-Reply-To: <1444686725-27660-21-git-send-email-dturner@twopensource.com>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279468>

Please disregard this one; I rewrorded the commit message and forgot to
delete this patch.  

On Mon, 2015-10-12 at 17:51 -0400, David Turner wrote:
> From: Ronnie Sahlberg <sahlberg@google.com>
> 
> Add a ref structure for backend methods. Start by adding a method pointer
> for the transaction commit function.
> 
> Add a function set_refs_backend to switch between backends. The files
> based backend is the default.
> 
> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
> Signed-off-by: David Turner <dturner@twopensource.com>
> ---
>  refs-be-files.c | 10 ++++++++--
>  refs.c          | 30 ++++++++++++++++++++++++++++++
>  refs.h          | 15 +++++++++++++++
>  3 files changed, 53 insertions(+), 2 deletions(-)
> 
> diff --git a/refs-be-files.c b/refs-be-files.c
> index 1308955..3050f1d 100644
> --- a/refs-be-files.c
> +++ b/refs-be-files.c
> @@ -3225,8 +3225,8 @@ static int ref_update_reject_duplicates(struct string_list *refnames,
>  	return 0;
>  }
>  
> -int ref_transaction_commit(struct ref_transaction *transaction,
> -			   struct strbuf *err)
> +static int files_transaction_commit(struct ref_transaction *transaction,
> +				    struct strbuf *err)
>  {
>  	int ret = 0, i;
>  	int n = transaction->nr;
> @@ -3612,3 +3612,9 @@ int reflog_expire(const char *refname, const unsigned char *sha1,
>  	unlock_ref(lock);
>  	return -1;
>  }
> +
> +struct ref_be refs_be_files = {
> +	NULL,
> +	"files",
> +	files_transaction_commit,
> +};
> diff --git a/refs.c b/refs.c
> index 25ad3b5..f930fe0 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -4,6 +4,29 @@
>  #include "cache.h"
>  #include "refs.h"
>  #include "lockfile.h"
> +/*
> + * We always have a files backend and it is the default.
> + */
> +struct ref_be *the_refs_backend = &refs_be_files;
> +/*
> + * List of all available backends
> + */
> +struct ref_be *refs_backends = &refs_be_files;
> +
> +/*
> + * This function is used to switch to an alternate backend.
> + */
> +int set_refs_backend(const char *name)
> +{
> +	struct ref_be *be;
> +
> +	for (be = refs_backends; be; be = be->next)
> +		if (!strcmp(be->name, name)) {
> +			the_refs_backend = be;
> +			return 0;
> +		}
> +	return 1;
> +}
>  
>  static int is_per_worktree_ref(const char *refname)
>  {
> @@ -985,3 +1008,10 @@ int ref_transaction_verify(struct ref_transaction *transaction,
>  				      NULL, old_sha1,
>  				      flags, NULL, err);
>  }
> +
> +/* backend functions */
> +int ref_transaction_commit(struct ref_transaction *transaction,
> +			   struct strbuf *err)
> +{
> +	return the_refs_backend->transaction_commit(transaction, err);
> +}
> diff --git a/refs.h b/refs.h
> index 4940ae9..419abf4 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -619,4 +619,19 @@ extern int reflog_expire(const char *refname, const unsigned char *sha1,
>  			 reflog_expiry_cleanup_fn cleanup_fn,
>  			 void *policy_cb_data);
>  
> +/* refs backends */
> +typedef int ref_transaction_commit_fn(struct ref_transaction *transaction,
> +				      struct strbuf *err);
> +typedef void ref_transaction_free_fn(struct ref_transaction *transaction);
> +
> +struct ref_be {
> +	struct ref_be *next;
> +	const char *name;
> +	ref_transaction_commit_fn *transaction_commit;
> +};
> +
> +
> +extern struct ref_be refs_be_files;
> +int set_refs_backend(const char *name);
> +
>  #endif /* REFS_H */
