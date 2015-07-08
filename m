From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v7 1/8] refs.c: add err arguments to reflog functions
Date: Wed, 08 Jul 2015 13:36:34 +0200
Message-ID: <559D0B42.1040607@alum.mit.edu>
References: <1436316963-25520-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: David Turner <dturner@twopensource.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 08 13:36:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCnec-0000YU-Kc
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jul 2015 13:36:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934127AbbGHLgj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jul 2015 07:36:39 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:63627 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932617AbbGHLgg (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Jul 2015 07:36:36 -0400
X-AuditID: 1207440d-f79136d00000402c-5f-559d0b4438e2
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id A4.D7.16428.44B0D955; Wed,  8 Jul 2015 07:36:36 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB0310.dip0.t-ipconnect.de [93.219.3.16])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t68BaYAR004353
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 8 Jul 2015 07:36:35 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.7.0
In-Reply-To: <1436316963-25520-1-git-send-email-dturner@twopensource.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplleLIzCtJLcpLzFFi42IRYndR1HXhnhtqsGclt8X8TScYLbqudDNZ
	/JtQ48DssWBTqceC5/fZPT5vkgtgjuK2SUosKQvOTM/Tt0vgznjx7zJrwS6JihtzjrA3MK4U
	7mLk5JAQMJGY+OkOO4QtJnHh3nq2LkYuDiGBy4wSE5a1s0A4Z5gkHh2ZyAxSxSugLTFz2yOw
	DhYBVYlJy9axgthsAroSi3qamboYOThEBYIkXr/MhSgXlDg58wkLiC0i4CBxeddRsDHMApoS
	mza8YAUpFxbwlHi7xBIkLCTgIfHk4A2wKZxA4XtvlCCq9SR2XP/FCmHLSzRvnc08gVFgFpIF
	s5CUzUJStoCReRWjXGJOaa5ubmJmTnFqsm5xcmJeXmqRrpFebmaJXmpK6SZGSNDy7mD8v07m
	EKMAB6MSD69HzJxQIdbEsuLK3EOMkhxMSqK8cY+AQnxJ+SmVGYnFGfFFpTmpxYcYJTiYlUR4
	z3PODRXiTUmsrEotyodJSXOwKInzqi1R9xMSSE8sSc1OTS1ILYLJynBwKEnwqnABNQoWpaan
	VqRl5pQgpJk4OEGGc0mJFKfmpaQWJZaWZMSDojS+GBinICkeoL1sIO28xQWJuUBRiNZTjIpS
	4rz6IAkBkERGaR7cWFgqesUoDvSlMO8zkLN5gGkMrvsV0GAmoMHLdWeBDC5JREhJNTBWMjXz
	TrLWPi3W2LY/gE+oesYNuaPB1Vt+v2k8VXf15ffk74zX5D7wLVzmfezis4DuswK3f+6UmOuk
	H39UbZd12wkz6Tmpu+z6RcU2aBr/qeSOWNp+Wf/Viik1N0NmBP+tOnxHwuxdZuJ8 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273672>

On 07/08/2015 02:55 AM, David Turner wrote:
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
> Some error messages change slightly.  For instance, we sometimes lose
> "cannot update ref" and instead only show the specific cause of ref
> update failure.

Did you check that the new error messages are at least as clear to the
user as the old ones? (Sometimes errors from deep in the call stack
provide details but don't make it clear how the details connect back to
the action that the user was trying to do.)

> Update of a patch by Ronnie Sahlberg.
> 
> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
> Signed-off-by: David Turner <dturner@twopensource.com>
> ---
>  builtin/checkout.c |   8 ++--
>  refs.c             | 130 +++++++++++++++++++++++++++++------------------------
>  refs.h             |   4 +-
>  3 files changed, 79 insertions(+), 63 deletions(-)
> 
> [...]
> diff --git a/refs.c b/refs.c
> index fb568d7..e891bed 100644
> --- a/refs.c
> +++ b/refs.c
> [...]
> @@ -3288,14 +3290,20 @@ static int write_ref_to_lockfile(struct ref_lock *lock,
>   * necessary, using the specified lockmsg (which can be NULL).
>   */
>  static int commit_ref_update(struct ref_lock *lock,
> -			     const unsigned char *sha1, const char *logmsg)
> +			     const unsigned char *sha1, const char *logmsg,
> +			     struct strbuf *err)
>  {
> +	int result = 0;

Please put a blank line between local variable definitions and the start
of code.

>  	clear_loose_ref_cache(&ref_cache);
> -	if (log_ref_write(lock->ref_name, lock->old_oid.hash, sha1, logmsg) < 0 ||
> +	if (log_ref_write(lock->ref_name, lock->old_oid.hash, sha1, logmsg, err) < 0 ||
>  	    (strcmp(lock->ref_name, lock->orig_ref_name) &&
> -	     log_ref_write(lock->orig_ref_name, lock->old_oid.hash, sha1, logmsg) < 0)) {
> -		unlock_ref(lock);
> -		return -1;
> +	     log_ref_write(lock->orig_ref_name, lock->old_oid.hash, sha1, logmsg, err) < 0)) {
> +		char *old_msg = strbuf_detach(err, NULL);
> +		strbuf_addf(err, "Cannot update the ref '%s': '%s'",
> +			    lock->ref_name, old_msg);
> +		free(old_msg);
> +		result = -1;
> +		goto done;
>  	}

I see this code already did what I complained about in my earlier email
[*]: fail a reference transaction after it is already partly committed.
In my opinion this is incorrect for the reasons stated there. But you
don't have to consider it to be in the scope of your patch series.

[*] http://article.gmane.org/gmane.comp.version-control.git/273668

>  	if (strcmp(lock->orig_ref_name, "HEAD") != 0) {
>  		/*
> [...]

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
