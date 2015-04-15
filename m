From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 3/3] refs.c: remove lock_fd from struct ref_lock
Date: Wed, 15 Apr 2015 10:49:12 +0200
Message-ID: <552E2608.7020104@alum.mit.edu>
References: <1429050308-9617-1-git-send-email-sbeller@google.com> <1429050308-9617-4-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Apr 15 10:50:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YiJ0k-0003Sc-NH
	for gcvg-git-2@plane.gmane.org; Wed, 15 Apr 2015 10:49:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753401AbbDOIt0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Apr 2015 04:49:26 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:48123 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751443AbbDOItX (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Apr 2015 04:49:23 -0400
X-AuditID: 12074412-f79e46d0000036b4-2f-552e260b8290
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id E7.38.14004.B062E255; Wed, 15 Apr 2015 04:49:15 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB0DD5.dip0.t-ipconnect.de [93.219.13.213])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t3F8nDqv011933
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 15 Apr 2015 04:49:14 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.5.0
In-Reply-To: <1429050308-9617-4-git-send-email-sbeller@google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjleLIzCtJLcpLzFFi42IRYndR1OVW0ws1OPJPwqLrSjeTRUPvFWaL
	zZvbWRyYPRZsKvW4eEnZ4/MmuQDmKG6bpMSSsuDM9Dx9uwTujCsdfcwFy3krdj7+ytjAeIyr
	i5GTQ0LAROLorP8sELaYxIV769m6GLk4hAQuM0o0T1rBBpIQEjjPJLF+YzGIzSugLbFwQjMz
	iM0ioCqxZuV3MJtNQFdiUU8zE4gtKhAk8fLWX0aIekGJkzOfgC0QEbCUuPTpNNBMDg5mAXGJ
	/n9gYWEBF4nPXXuZIVaVS8w5ehdsLaeAk8TNTfPBxjAL6EnsuP6LFcKWl2jeOpt5AqPALCQb
	ZiEpm4WkbAEj8ypGucSc0lzd3MTMnOLUZN3i5MS8vNQiXTO93MwSvdSU0k2MkLAV2sG4/qTc
	IUYBDkYlHt4FC3RDhVgTy4orcw8xSnIwKYnyTlfRCxXiS8pPqcxILM6ILyrNSS0+xCjBwawk
	wpsgCJTjTUmsrEotyodJSXOwKInz/lys7ickkJ5YkpqdmlqQWgSTleHgUJLg/QEyVLAoNT21
	Ii0zpwQhzcTBCTKcS0qkODUvJbUosbQkIx4Up/HFwEgFSfEA7V0B0s5bXJCYCxSFaD3FqCgl
	zpsOkhAASWSU5sGNhSWjV4ziQF8K84aBVPEAExlc9yugwUxAg48H6oIMLklESEk1MAaUxbo+
	bTx4XGCJ19Rdh6/vkupI2HVHu5WbQWl1qrTE3t5d71pmXZq/75HgipYVevW7L9U096Rt+SBc
	ubXhv8IU1qpOp9Qnan+UDf2S375qbZt8xPtifL7w2tia9WteHnFo4340YXlZS9aq 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267192>

On 04/15/2015 12:25 AM, Stefan Beller wrote:
> The 'lock_fd' is the same as 'lk->fd'. No need to store it twice so remove
> it. You may argue this introduces more coupling as we need to know more
> about the internals of the lock file mechanism, but this will be solved in
> a later patch.
> 
> No functional changes intended.

This whole series LGTM; however, I suggest that this patch be split up.
See below.

> Signed-off-by: Stefan Beller <sbeller@google.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  refs.c | 16 ++++++----------
>  1 file changed, 6 insertions(+), 10 deletions(-)
> 
> diff --git a/refs.c b/refs.c
> index 14e52ca..4066752 100644
> --- a/refs.c
> +++ b/refs.c
> [...]
> @@ -2335,8 +2333,8 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
>  		goto error_return;
>  	}
>  
> -	lock->lock_fd = hold_lock_file_for_update(lock->lk, ref_file, lflags);
> -	if (lock->lock_fd < 0) {
> +	if (hold_lock_file_for_update(lock->lk, ref_file, lflags) < 0) {
> +		last_errno = errno;
>  		if (errno == ENOENT && --attempts_remaining > 0)
>  			/*
>  			 * Maybe somebody just deleted one of the
> [...]

Here you add the line "last_errno = errno". It is a good change, but it
is not part of removing ref_lock::lock_fd.

I suggest that you move this change to a separate commit. You might also
consider moving the new line to the "else" clause, because it's really
about preserving errno around the call to error() and preparing for
"goto error_return".

With or without this split, this patch is

Reviewed-by: Michael Haggerty <mhagger@alum.mit.edu>

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
