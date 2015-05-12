From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 02/18] is_refname_available(): revamp the comments
Date: Tue, 12 May 2015 14:04:18 -0700
Message-ID: <xmqq8uctfqy5.fsf@gitster.dls.corp.google.com>
References: <1431357920-25090-1-git-send-email-mhagger@alum.mit.edu>
	<1431357920-25090-3-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue May 12 23:04:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsHLp-0007Bk-SP
	for gcvg-git-2@plane.gmane.org; Tue, 12 May 2015 23:04:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754096AbbELVE0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 May 2015 17:04:26 -0400
Received: from mail-ie0-f175.google.com ([209.85.223.175]:36643 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753748AbbELVEV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 May 2015 17:04:21 -0400
Received: by iepk2 with SMTP id k2so12492468iep.3
        for <git@vger.kernel.org>; Tue, 12 May 2015 14:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=2k6Ix+V5RC1jYT7kpHUc1bgL+OZ5FHkJsXWGsMF9w58=;
        b=TSc7dBWtLKGzvXubk76opTIZ9ZupxsMwT2y7L8hc2BCyv75QsePdNCjlOQfzxfQCfy
         cEZP0eW5PjhOF00xbMqyVCCRzxdVjCh+BnOatQz21iCnQNqeHDQrbf9U/czd4ahopd26
         tvsKDh4FA+6OXgK5sAE6YVepEXXPMVNGWH1nNafZMTSjio4Bgqpsq98z6X9eOOmpDLZG
         BOv4mD9N/GC9AfU8YmkJXP9H8crvRZGdFUJSmd+bSdlXOzmiVFZaB31eseSt8OkDa/EC
         orURFbwGwfDwpvI8mJvbE2FltQoVSe9mYzmocJTKPpCUwS2RJgwR/QCFNmFyAN3UpXis
         2vKg==
X-Received: by 10.42.119.2 with SMTP id z2mr1274547icq.1.1431464660230;
        Tue, 12 May 2015 14:04:20 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:1d41:fac7:b879:7542])
        by mx.google.com with ESMTPSA id q29sm12703768ioi.9.2015.05.12.14.04.19
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 12 May 2015 14:04:19 -0700 (PDT)
In-Reply-To: <1431357920-25090-3-git-send-email-mhagger@alum.mit.edu> (Michael
	Haggerty's message of "Mon, 11 May 2015 17:25:04 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268883>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> Change the comments to a running example of running the function with
> refname set to "refs/foo/bar". Add some more explanation of the logic.

I initially had a hard time understanding what these two "running"s
were before reading the changes.  They all look good.

Thanks.


> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>  refs.c | 69 +++++++++++++++++++++++++++++++++++++++++++++---------------------
>  1 file changed, 47 insertions(+), 22 deletions(-)
>
> diff --git a/refs.c b/refs.c
> index 47e4e53..776bbce 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -876,9 +876,9 @@ static void report_refname_conflict(struct ref_entry *entry,
>   * operation).
>   *
>   * Two reference names conflict if one of them exactly matches the
> - * leading components of the other; e.g., "foo/bar" conflicts with
> - * both "foo" and with "foo/bar/baz" but not with "foo/bar" or
> - * "foo/barbados".
> + * leading components of the other; e.g., "refs/foo/bar" conflicts
> + * with both "refs/foo" and with "refs/foo/bar/baz" but not with
> + * "refs/foo/bar" or "refs/foo/barbados".
>   *
>   * skip must be sorted.
>   */
> @@ -891,19 +891,39 @@ static int is_refname_available(const char *refname,
>  	int pos;
>  	char *dirname;
>  
> +	/*
> +	 * For the sake of comments in this function, suppose that
> +	 * refname is "refs/foo/bar".
> +	 */
> +
>  	for (slash = strchr(refname, '/'); slash; slash = strchr(slash + 1, '/')) {
>  		/*
> -		 * We are still at a leading dir of the refname; we are
> -		 * looking for a conflict with a leaf entry.
> -		 *
> -		 * If we find one, we still must make sure it is
> -		 * not in "skip".
> +		 * We are still at a leading dir of the refname (e.g.,
> +		 * "refs/foo"; if there is a reference with that name,
> +		 * it is a conflict, *unless* it is in skip.
>  		 */
>  		pos = search_ref_dir(dir, refname, slash - refname);
>  		if (pos >= 0) {
> +			/*
> +			 * We found a reference whose name is a proper
> +			 * prefix of refname; e.g., "refs/foo".
> +			 */
>  			struct ref_entry *entry = dir->entries[pos];
> -			if (entry_matches(entry, skip))
> +			if (entry_matches(entry, skip)) {
> +				/*
> +				 * The reference we just found, e.g.,
> +				 * "refs/foo", is also in skip, so it
> +				 * is not considered a conflict.
> +				 * Moreover, the fact that "refs/foo"
> +				 * exists means that there cannot be
> +				 * any references anywhere under the
> +				 * "refs/foo/" namespace (because they
> +				 * would have conflicted with
> +				 * "refs/foo"). So we can stop looking
> +				 * now and return true.
> +				 */
>  				return 1;
> +			}
>  			report_refname_conflict(entry, refname);
>  			return 0;
>  		}
> @@ -911,19 +931,29 @@ static int is_refname_available(const char *refname,
>  
>  		/*
>  		 * Otherwise, we can try to continue our search with
> -		 * the next component; if we come up empty, we know
> -		 * there is nothing under this whole prefix.
> +		 * the next component. So try to look up the
> +		 * directory, e.g., "refs/foo/".
>  		 */
>  		pos = search_ref_dir(dir, refname, slash + 1 - refname);
> -		if (pos < 0)
> +		if (pos < 0) {
> +			/*
> +			 * There was no directory "refs/foo/", so
> +			 * there is nothing under this whole prefix,
> +			 * and we are OK.
> +			 */
>  			return 1;
> +		}
>  
>  		dir = get_ref_dir(dir->entries[pos]);
>  	}
>  
>  	/*
> -	 * We are at the leaf of our refname; we want to
> -	 * make sure there are no directories which match it.
> +	 * We are at the leaf of our refname (e.g., "refs/foo/bar").
> +	 * There is no point in searching for a reference with that
> +	 * name, because a refname isn't considered to conflict with
> +	 * itself. But we still need to check for references whose
> +	 * names are in the "refs/foo/bar/" namespace, because they
> +	 * *do* conflict.
>  	 */
>  	len = strlen(refname);
>  	dirname = xmallocz(len + 1);
> @@ -933,9 +963,9 @@ static int is_refname_available(const char *refname,
>  
>  	if (pos >= 0) {
>  		/*
> -		 * We found a directory named "refname". It is a
> -		 * problem iff it contains any ref that is not
> -		 * in "skip".
> +		 * We found a directory named "$refname/" (e.g.,
> +		 * "refs/foo/bar/"). It is a problem iff it contains
> +		 * any ref that is not in "skip".
>  		 */
>  		struct ref_entry *entry = dir->entries[pos];
>  		struct ref_dir *dir = get_ref_dir(entry);
> @@ -950,11 +980,6 @@ static int is_refname_available(const char *refname,
>  		return 0;
>  	}
>  
> -	/*
> -	 * There is no point in searching for another leaf
> -	 * node which matches it; such an entry would be the
> -	 * ref we are looking for, not a conflict.
> -	 */
>  	return 1;
>  }
