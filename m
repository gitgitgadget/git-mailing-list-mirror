From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v3 27/44] refs.c: move peel_object to the common code
Date: Tue, 13 Oct 2015 11:34:51 +0200
Message-ID: <561CD03B.2080506@alum.mit.edu>
References: <1444686725-27660-1-git-send-email-dturner@twopensource.com> <1444686725-27660-29-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: David Turner <dturner@twopensource.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 13 11:35:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZlvzI-0000KJ-Bn
	for gcvg-git-2@plane.gmane.org; Tue, 13 Oct 2015 11:35:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751909AbbJMJfK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Oct 2015 05:35:10 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:52416 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750984AbbJMJfJ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Oct 2015 05:35:09 -0400
X-AuditID: 12074411-f797e6d000007df3-7e-561cd03d4d68
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 4B.A2.32243.D30DC165; Tue, 13 Oct 2015 05:34:53 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB2603.dip0.t-ipconnect.de [93.219.38.3])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t9D9YqJt022264
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 13 Oct 2015 05:34:53 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.8.0
In-Reply-To: <1444686725-27660-29-git-send-email-dturner@twopensource.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrDIsWRmVeSWpSXmKPExsUixO6iqGt7QSbM4NwSY4v5m04wWnRd6WZy
	YPJY8Pw+u8fnTXIBTFHcNkmJJWXBmel5+nYJ3BmdE3+xFBwSrri8uZu5gfE9XxcjJ4eEgInE
	jKdvmSFsMYkL99azdTFycQgJXGaUuDZpMxNIQkjgLJNE209vEJtXQFti5+U5rCA2i4CqxJ2G
	7ewgNpuArsSinmawelGBIIkVy18wQtQLSpyc+YQFxBYRcJC4vOso2DJhAU+Jh/uXs0Msa2OU
	+Pr8ItggTgEviRdfNoLZzAJ6Ejuu/2KFsOUltr+dwzyBkX8WkrmzkJTNQlK2gJF5FaNcYk5p
	rm5uYmZOcWqybnFyYl5eapGuqV5uZoleakrpJkZISAruYJxxUu4QowAHoxIP74tImTAh1sSy
	4srcQ4ySHExKoryau4FCfEn5KZUZicUZ8UWlOanFhxglOJiVRHiTWoByvCmJlVWpRfkwKWkO
	FiVxXr4l6n5CAumJJanZqakFqUUwWRkODiUJ3sDzQI2CRanpqRVpmTklCGkmDk6Q4VxSIsWp
	eSmpRYmlJRnxoJiMLwZGJUiKB2hv2zmQvcUFiblAUYjWU4yKUuK8p0ASAiCJjNI8uLGwRPOK
	URzoS2HeLyBVPMAkBdf9CmgwE9BgI3YpkMEliQgpqQZG9cPb443fP7j49bTlzptWxfUxc+a+
	bM8UnfDO/kvo1mY7/3X9szbP2Cboe7jsuzSPdrflL3mmIxLxbDWLI046KpuIzX9gIVf8PP6N
	T8hUuyWST1f+3Ld9okSGoc+qlM1Tz83iuTX9dQmXDWM+B/vPB6VxX+XNWLY+OK/e 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279492>

On 10/12/2015 11:51 PM, David Turner wrote:
> This function does not contain any backend specific code so we
> move it to the common code.
> 
> Signed-off-by: David Turner <dturner@twopensource.com>
> ---
>  refs-be-files.c | 53 -----------------------------------------------------
>  refs.c          | 31 +++++++++++++++++++++++++++++++
>  refs.h          | 27 +++++++++++++++++++++++++++
>  3 files changed, 58 insertions(+), 53 deletions(-)
> 
> [...]
> diff --git a/refs.c b/refs.c
> index bd8c71b..99b31f6 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -4,6 +4,9 @@
>  #include "cache.h"
>  #include "refs.h"
>  #include "lockfile.h"
> +#include "object.h"
> +#include "tag.h"
> +
>  /*
>   * We always have a files backend and it is the default.
>   */
> @@ -1059,6 +1062,34 @@ int refname_is_safe(const char *refname)
>  	return 1;
>  }
>  
> +/*
> + * Peel the named object; i.e., if the object is a tag, resolve the
> + * tag recursively until a non-tag is found.  If successful, store the
> + * result to sha1 and return PEEL_PEELED.  If the object is not a tag
> + * or is not valid, return PEEL_NON_TAG or PEEL_INVALID, respectively,
> + * and leave sha1 unchanged.
> + */

Please move the docstring to the header file.

> [...]
> diff --git a/refs.h b/refs.h
> index 3da5d09..636f959 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -76,6 +76,33 @@ extern int is_branch(const char *refname);
>   */
>  extern int peel_ref(const char *refname, unsigned char *sha1);
>  
> +enum peel_status {
> +	/* object was peeled successfully: */
> +	PEEL_PEELED = 0,
> +
> +	/*
> +	 * object cannot be peeled because the named object (or an
> +	 * object referred to by a tag in the peel chain), does not
> +	 * exist.
> +	 */
> +	PEEL_INVALID = -1,
> +
> +	/* object cannot be peeled because it is not a tag: */
> +	PEEL_NON_TAG = -2,
> +
> +	/* ref_entry contains no peeled value because it is a symref: */
> +	PEEL_IS_SYMREF = -3,
> +
> +	/*
> +	 * ref_entry cannot be peeled because it is broken (i.e., the
> +	 * symbolic reference cannot even be resolved to an object
> +	 * name):
> +	 */
> +	PEEL_BROKEN = -4
> +};
> +
> +enum peel_status peel_object(const unsigned char *name, unsigned char *sha1);
> +
>  /**
>   * Resolve refname in the nested "gitlink" repository that is located
>   * at path.  If the resolution is successful, return 0 and set sha1 to
> 

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
