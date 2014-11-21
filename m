From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 2/4] lock_ref_sha1_basic: simplify errno handling
Date: Fri, 21 Nov 2014 10:25:07 +0100
Message-ID: <546F04F3.5060407@alum.mit.edu>
References: <20141119013532.GA861@peff.net> <20141119013730.GB2135@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: sahlberg@google.com, jrnieder@gmail.com, gitster@pobox.com,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Nov 21 10:25:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XrkT6-0003ma-Bl
	for gcvg-git-2@plane.gmane.org; Fri, 21 Nov 2014 10:25:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754592AbaKUJZY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Nov 2014 04:25:24 -0500
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:48797 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752436AbaKUJZW (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Nov 2014 04:25:22 -0500
X-AuditID: 12074414-f797f6d000004084-db-546f04f579f0
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id A7.05.16516.5F40F645; Fri, 21 Nov 2014 04:25:09 -0500 (EST)
Received: from [192.168.69.130] (p5DDB272E.dip0.t-ipconnect.de [93.219.39.46])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id sAL9P7iF022247
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Fri, 21 Nov 2014 04:25:08 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.2.0
In-Reply-To: <20141119013730.GB2135@peff.net>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOKsWRmVeSWpSXmKPExsUixO6iqPuVJT/EYO0qI4uuK91MFg29V5gt
	3t5cwmjxo6WH2eLfhBqLzZvbWRzYPHbOusvusWBTqcez3j2MHhcvKXt83iQXwBrFbZOUWFIW
	nJmep2+XwJ1xe9Iv1oIfAhX/Nr1nbGDs4+1i5OSQEDCR2PxgLxuELSZx4d56IJuLQ0jgMqPE
	iQnroJxzTBItZy+zglTxCmhLvJqwl6WLkYODRUBV4u17QZAwm4CuxKKeZiYQW1QgSOLknuvs
	EOWCEidnPmEBsUUEHCWO/JoOtoxZIEbiy6wljCC2sICrxO7/18BqhAR8JJZOesMMYnMCzez4
	fpUVol5d4s+8S8wQtrzE9rdzmCcwCsxCsmIWkrJZSMoWMDKvYpRLzCnN1c1NzMwpTk3WLU5O
	zMtLLdK10MvNLNFLTSndxAgJdJEdjEdOyh1iFOBgVOLhXbE4L0SINbGsuDL3EKMkB5OSKK8v
	Y36IEF9SfkplRmJxRnxRaU5q8SFGCQ5mJRFeke9A5bwpiZVVqUX5MClpDhYlcd5vi9X9hATS
	E0tSs1NTC1KLYLIyHBxKErwHmIGGChalpqdWpGXmlCCkmTg4QYZzSYkUp+alpBYllpZkxIMi
	Nb4YGKsgKR6gvYIg7bzFBYm5QFGI1lOMilLivFNBEgIgiYzSPLixsPT1ilEc6Eth3hcgVTzA
	1AfX/QpoMBPQ4L9Lc0EGlyQipKQaGJU8a7l3nbRdJnRth5dVLbdhdshFz3UL31e9Xp4yV2/T
	o72pzBKvfYW+nbMtZBbS+u6R+mLHDG1Lh9kKsy9XzYrwLr78wEPrcFHvW/Fj7z9v 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/19/2014 02:37 AM, Jeff King wrote:
> Now that error() does not clobber errno, we do not have to
> take pains to save it ourselves.
> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  refs.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/refs.c b/refs.c
> index 5ff457e..169a46d 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -2232,7 +2232,6 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
>  	char *ref_file;
>  	const char *orig_refname = refname;
>  	struct ref_lock *lock;
> -	int last_errno = 0;
>  	int type, lflags;
>  	int mustexist = (old_sha1 && !is_null_sha1(old_sha1));
>  	int resolve_flags = 0;
> @@ -2260,7 +2259,6 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
>  		 */
>  		ref_file = git_path("%s", orig_refname);
>  		if (remove_empty_directories(ref_file)) {
> -			last_errno = errno;
>  			error("there are still refs under '%s'", orig_refname);
>  			goto error_return;
>  		}
> @@ -2270,7 +2268,6 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
>  	if (type_p)
>  	    *type_p = type;
>  	if (!refname) {
> -		last_errno = errno;
>  		error("unable to resolve reference %s: %s",
>  			orig_refname, strerror(errno));
>  		goto error_return;
> @@ -2283,7 +2280,7 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
>  	 */
>  	if (missing &&
>  	     !is_refname_available(refname, skip, get_packed_refs(&ref_cache))) {
> -		last_errno = ENOTDIR;
> +		errno = ENOTDIR;
>  		goto error_return;
>  	}
>  
> @@ -2311,7 +2308,6 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
>  			goto retry;
>  		/* fall through */
>  	default:
> -		last_errno = errno;
>  		error("unable to create directory for %s", ref_file);
>  		goto error_return;
>  	}
> @@ -2332,7 +2328,6 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
>  
>   error_return:
>  	unlock_ref(lock);
> -	errno = last_errno;
>  	return NULL;
>  }

error() doesn't clobber errno anymore, but unlock_ref() still might.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
