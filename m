From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v18 07/48] lockfile.c: make lock_file return a meaningful
 errno on failurei
Date: Wed, 18 Jun 2014 22:36:31 +0200
Message-ID: <53A1F84F.2010308@alum.mit.edu>
References: <1403020442-31049-1-git-send-email-sahlberg@google.com> <1403020442-31049-8-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 18 22:36:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxMb9-000755-Tp
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jun 2014 22:36:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755516AbaFRUgg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2014 16:36:36 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:63705 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755498AbaFRUge (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Jun 2014 16:36:34 -0400
X-AuditID: 12074413-f79bc6d000000b9e-b3-53a1f851b3c3
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 2A.58.02974.158F1A35; Wed, 18 Jun 2014 16:36:33 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB19A6.dip0.t-ipconnect.de [93.219.25.166])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s5IKaWHf028239
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 18 Jun 2014 16:36:33 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.5.0
In-Reply-To: <1403020442-31049-8-git-send-email-sahlberg@google.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIKsWRmVeSWpSXmKPExsUixO6iqBv4Y2GwwYcOPYuuK91MFv8m1Dgw
	eSzYVOrxeZNcAFMUt01SYklZcGZ6nr5dAnfGvqWNbAUvBCve9V5mamB8wNvFyMkhIWAi8WzO
	XzYIW0ziwr31QDYXh5DAZUaJXU+eskI455kk/i9YywRSxSugLTHz1W+wDhYBVYlvU/8wgths
	AroSi3qawWpEBYIkZn+exw5RLyhxcuYTFhBbRMBOYv2thcwgtrBAokT7kfNgtpBAtcTh/k6w
	Gk4BF4mHV/4A2RxAF4lL9DQGgYSZBXQk3vU9YIaw5SW2v53DPIFRYBaSDbOQlM1CUraAkXkV
	o1xiTmmubm5iZk5xarJucXJiXl5qka65Xm5miV5qSukmRkiQCu9g3HVS7hCjAAejEg/vgssL
	g4VYE8uKK3MPMUpyMCmJ8kZ8BwrxJeWnVGYkFmfEF5XmpBYfYpTgYFYS4XV6AJTjTUmsrEot
	yodJSXOwKInzqi1R9xMSSE8sSc1OTS1ILYLJynBwKEnw8oIMFSxKTU+tSMvMKUFIM3Fwggzn
	khIpTs1LSS1KLC3JiAdFanwxMFZBUjxAe/1A2nmLCxJzgaIQracYdTlO3TnWxiTEkpeflyol
	zvvrG1CRAEhRRmke3ApYSnrFKA70sTDvapAqHmA6g5v0CmgJE9ASlYnzQJaUJCKkpBoYdb4r
	zfmoySu3ju/3I5Zt/F9/+TFIv/7/bl7x/2U3Wnf5nWMuiJP1nRZ1im/qJAW3J30PlmXpvV6x
	Q/nG0673HnFz9i6t5Ne7e/rC/vtW8XqTpzmWvlZv/WYi6F2UWJGgE5/fFX3g+jyj 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252066>

On 06/17/2014 05:53 PM, Ronnie Sahlberg wrote:
> Making errno when returning from lock_file() meaningful, which should
> fix
> 
>  * an existing almost-bug in lock_ref_sha1_basic where it assumes
>    errno==ENOENT is meaningful and could waste some work on retries
> 
>  * an existing bug in repack_without_refs where it prints
>    strerror(errno) and picks advice based on errno, despite errno
>    potentially being zero and potentially having been clobbered by
>    that point
> 
> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
> ---
>  lockfile.c | 17 ++++++++++++-----
>  refs.c     |  1 +
>  refs.h     |  1 +
>  3 files changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/lockfile.c b/lockfile.c
> index 464031b..a921d77 100644
> --- a/lockfile.c
> +++ b/lockfile.c
> @@ -121,7 +121,7 @@ static char *resolve_symlink(char *p, size_t s)
>  	return p;
>  }
>  
> -
> +/* Make sure errno contains a meaningful value on error */
>  static int lock_file(struct lock_file *lk, const char *path, int flags)
>  {
>  	/*
> @@ -130,8 +130,10 @@ static int lock_file(struct lock_file *lk, const char *path, int flags)
>  	 */
>  	static const size_t max_path_len = sizeof(lk->filename) - 5;
>  
> -	if (strlen(path) >= max_path_len)
> +	if (strlen(path) >= max_path_len) {
> +		errno = ENAMETOOLONG;
>  		return -1;
> +	}
>  	strcpy(lk->filename, path);
>  	if (!(flags & LOCK_NODEREF))
>  		resolve_symlink(lk->filename, max_path_len);
> @@ -148,9 +150,13 @@ static int lock_file(struct lock_file *lk, const char *path, int flags)
>  			lock_file_list = lk;
>  			lk->on_list = 1;
>  		}
> -		if (adjust_shared_perm(lk->filename))
> -			return error("cannot fix permission bits on %s",
> -				     lk->filename);
> +		if (adjust_shared_perm(lk->filename)) {
> +			int save_errno = errno;
> +			error("cannot fix permission bits on %s",
> +			      lk->filename);
> +			errno = save_errno;
> +			return -1;
> +		}

Wouldn't it make sense for error() to save and restore errno instead of
scattering the save/restore code around everywhere?  I saw the same type
of code about three commits later, too.

> [...]

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
