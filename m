From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v9 1/7] refs.c: add err arguments to reflog functions
Date: Tue, 21 Jul 2015 12:50:02 -0700
Message-ID: <55AEA26A.6050800@alum.mit.edu>
References: <1437493504-3699-1-git-send-email-dturner@twopensource.com> <1437493504-3699-2-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: David Turner <dturner@twopensource.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 21 21:50:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZHdYY-0006lk-7Q
	for gcvg-git-2@plane.gmane.org; Tue, 21 Jul 2015 21:50:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753138AbbGUTuV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jul 2015 15:50:21 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:57132 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752510AbbGUTuU (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Jul 2015 15:50:20 -0400
X-AuditID: 1207440d-f79136d00000402c-81-55aea26c43e0
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id D2.92.16428.C62AEA55; Tue, 21 Jul 2015 15:50:04 -0400 (EDT)
Received: from [172.20.208.234] ([66.251.117.141])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t6LJo2CS027122
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 21 Jul 2015 15:50:03 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.7.0
In-Reply-To: <1437493504-3699-2-git-send-email-dturner@twopensource.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnleLIzCtJLcpLzFFi42IRYndR1M1ZtC7U4MoLDYv5m04wWnRd6Way
	+DehxoHZY8GmUo8Fz++ze3zeJBfAHMVtk5RYUhacmZ6nb5fAnXF5imZBi1DF00+r2RsYF/B1
	MXJySAiYSMzesJ0NwhaTuHBvPZDNxSEkcJlR4t6/p6wQziYmiaXL17KAVPEKaEuc6rvLCmKz
	CKhKzP27AaybTUBXYlFPM1MXIweHqECQxOuXuRDlghInZz4BaxURcJC4vOsoM4jNLKApsWnD
	C7AxwgKeEo03vrJD7GpmlFj9pxVsJqeAh8Sq9ZtYIRr0JHZc/wVly0s0b53NPIFRYBaSHbOQ
	lM1CUraAkXkVo1xiTmmubm5iZk5xarJucXJiXl5qka6RXm5miV5qSukmRkjg8u5g/L9O5hCj
	AAejEg9vRcvaUCHWxLLiytxDjJIcTEqivPEL14UK8SXlp1RmJBZnxBeV5qQWH2KU4GBWEuE9
	EQmU401JrKxKLcqHSUlzsCiJ86otUfcTEkhPLEnNTk0tSC2CycpwcChJ8BaCDBUsSk1PrUjL
	zClBSDNxcIIM55ISKU7NS0ktSiwtyYgHRWp8MTBWQVI8QHtLQNp5iwsSc4GiEK2nGBWlxHl3
	gCQEQBIZpXlwY2Hp6BWjONCXwrwHQKp4gKkMrvsV0GAmoMG3Zq0BGVySiJCSamAs4yh+E/Bv
	WXIgL5e21bITe2y/OV6b8txm4ezNOTEeOTwpHbbWjXFNf+wvJM02dWtnMyl8f1vO9m74xAyD
	wP0xWmlBASzzPree/LyTi+9z0/PHp375aO2cz/nl/jn1fXmTLsRlzIjPfRd41b/q 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274407>

There's one last error formatting niggle below.

On 07/21/2015 08:44 AM, David Turner wrote:
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
> Some error messages are slightly reordered.
> 
> Update of a patch by Ronnie Sahlberg.
> 
> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
> Signed-off-by: David Turner <dturner@twopensource.com>
> ---
>  builtin/checkout.c |   8 ++--
>  refs.c             | 129 ++++++++++++++++++++++++++++++-----------------------
>  refs.h             |   4 +-
>  3 files changed, 81 insertions(+), 60 deletions(-)
> 
> [...]
> diff --git a/refs.c b/refs.c
> index fb568d7..f090720 100644
> --- a/refs.c
> +++ b/refs.c
> [...]
> @@ -3288,12 +3288,17 @@ static int write_ref_to_lockfile(struct ref_lock *lock,
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
> +		char *old_msg = strbuf_detach(err, NULL);
> +		strbuf_addf(err, "Cannot update the ref '%s': '%s'",
> +			    lock->ref_name, old_msg);

The above error message has unnecessary quotes around old_msg.

> +		free(old_msg);
>  		unlock_ref(lock);
>  		return -1;
>  	}
> [...]

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
