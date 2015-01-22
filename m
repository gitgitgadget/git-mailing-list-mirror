From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCHv2 5/5] refs.c: enable large transactions
Date: Thu, 22 Jan 2015 12:24:23 +0100
Message-ID: <54C0DDE7.8030708@alum.mit.edu>
References: <1421893929-7447-1-git-send-email-sbeller@google.com> <1421893929-7447-6-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
To: Stefan Beller <sbeller@google.com>, peff@peff.net,
	git@vger.kernel.org, gitster@pobox.com, loic@dachary.org
X-From: git-owner@vger.kernel.org Thu Jan 22 12:31:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEFz5-0000Qm-0X
	for gcvg-git-2@plane.gmane.org; Thu, 22 Jan 2015 12:31:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751211AbbAVLbb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2015 06:31:31 -0500
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:45351 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750915AbbAVLba (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Jan 2015 06:31:30 -0500
X-Greylist: delayed 421 seconds by postgrey-1.27 at vger.kernel.org; Thu, 22 Jan 2015 06:31:30 EST
X-AuditID: 12074414-f797f6d000004084-a9-54c0dde9815b
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 8A.56.16516.9EDD0C45; Thu, 22 Jan 2015 06:24:25 -0500 (EST)
Received: from [192.168.69.130] (p5DDB02C5.dip0.t-ipconnect.de [93.219.2.197])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t0MBONAj008455
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Thu, 22 Jan 2015 06:24:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.3.0
In-Reply-To: <1421893929-7447-6-git-send-email-sbeller@google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEKsWRmVeSWpSXmKPExsUixO6iqPvy7oEQg8WHzSy6rnQzWTT0XmG2
	eLXdx+JHSw+zxebN7SwOrB7PtrF6LNhU6vGsdw+jx8VLyh6fN8kFsEZx2yQllpQFZ6bn6dsl
	cGf8u9LKXnBJqOL8m/gGxhV8XYwcHBICJhLNh5i6GDmBTDGJC/fWs3UxcnEICVxmlDg/+Q8r
	hHOOSeLSzAssIFW8AtoSU9ZMYAFpZhFQlTg1SRgkzCagK7GopxlskKhAkMSVls3MEOWCEidn
	PgFrFRGokLi4+Q4biC0sYCNxsOUqG8gYIYFyiS1zU0DCnAJOEtcmnQArYRbQk9hx/RcrhC0v
	0bx1NvMERv5ZSKbOQlI2C0nZAkbmVYxyiTmlubq5iZk5xanJusXJiXl5qUW6Fnq5mSV6qSml
	mxgh4Suyg/HISblDjAIcjEo8vBnFB0KEWBPLiitzDzFKcjApifJOvAkU4kvKT6nMSCzOiC8q
	zUktPsQowcGsJMJregIox5uSWFmVWpQPk5LmYFES5/22WN1PSCA9sSQ1OzW1ILUIJivDwaEk
	wSsJjFMhwaLU9NSKtMycEoQ0EwcnyHAuKZHi1LyU1KLE0pKMeFAsxhcDoxEkxQO0Vwiknbe4
	IDEXKArReopRUUqcVwokIQCSyCjNgxsLS0qvGMWBvhTmnXMHqIoHmNDgul8BDWYCGlywHWxw
	SSJCSqqBcbKvaL33vNTTv3ozH/+7cDFxnbbKrbKLF1ui+g50Shiov28z9b4jIDb11xJ976r1
	5mrvJK+eFmHc4b+ZVYXF2OTBHZltN+KijvMZhX2bbF8bmvywvs7zDfcnIUdfnqP9 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262817>

On 01/22/2015 03:32 AM, Stefan Beller wrote:
> By closing the file descriptors after creating the lock file we are not
> limiting the size of the transaction by the number of available file
> descriptors.
> 
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  refs.c                | 17 +++++++++++++----
>  t/t1400-update-ref.sh |  4 ++--
>  2 files changed, 15 insertions(+), 6 deletions(-)
> 
> diff --git a/refs.c b/refs.c
> index 2013d37..9d01102 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -3055,11 +3055,18 @@ int is_branch(const char *refname)
>  static int write_sha1_to_lock_file(struct ref_lock *lock,
>  				   const unsigned char *sha1)
>  {
> -	if (fdopen_lock_file(lock->lk, "w") < 0
> -	    || fprintf(lock->lk->fp, "%s\n", sha1_to_hex(sha1)) != 41)
> +	if (lock->lk->fd == -1) {
> +		if (reopen_lock_file(lock->lk) < 0
> +		    || fdopen_lock_file(lock->lk, "w") < 0
> +		    || fprintf(lock->lk->fp, "%s\n", sha1_to_hex(sha1)) != 41
> +		    || close_lock_file(lock->lk) < 0)
> +		    return -1;
> +	} else {
> +		if (fdopen_lock_file(lock->lk, "w") < 0
> +		    || fprintf(lock->lk->fp, "%s\n", sha1_to_hex(sha1)) != 41)
>  		return -1;
> -	else
> -		return 0;
> +	}
> +	return 0;
>  }

I can't figure out where to apply this series or where to fetch it from,
so I can't see these changes in context, so maybe I'm misunderstanding
something. It looks like this code is doing

    open(), close(), open(), fdopen(), write(), fclose(), rename()

on each lockfile. But don't we have enough information to write the
SHA-1 into the lockfile the first time we touch it? I.e., couldn't we
reduce this to

    open(), fdopen(), write(), fclose(), rename()

, where the first four calls all happen in the initial loop? If a
problem is discovered when writing a later reference, we would roll back
the transaction anyway.

I understand that this would require a bigger rewrite, so maybe it is
not worth it.

>  /*
> @@ -3761,6 +3768,8 @@ int ref_transaction_commit(struct ref_transaction *transaction,
>  				    update->refname);
>  			goto cleanup;
>  		}
> +		/* Do not keep all lock files open at the same time. */
> +		close_lock_file(update->lock->lk);
>  	}
>  
>  	/* Perform updates first so live commits remain referenced */
> [...]

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
