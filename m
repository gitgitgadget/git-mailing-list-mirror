From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v10 22/44] fetch.c: clear errno before calling functions
 that might set it
Date: Sat, 17 May 2014 16:56:20 +0200
Message-ID: <53777894.7020408@alum.mit.edu>
References: <1400261852-31303-1-git-send-email-sahlberg@google.com> <1400261852-31303-23-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 17 16:56:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wlg2M-0007bs-6M
	for gcvg-git-2@plane.gmane.org; Sat, 17 May 2014 16:56:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932115AbaEQO4Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 May 2014 10:56:24 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:53774 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757043AbaEQO4X (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 17 May 2014 10:56:23 -0400
X-AuditID: 12074412-f79ba6d000000bc2-37-537778966db6
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 9F.A5.03010.69877735; Sat, 17 May 2014 10:56:22 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB3A76.dip0.t-ipconnect.de [93.219.58.118])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s4HEuKt0028383
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Sat, 17 May 2014 10:56:21 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.4.0
In-Reply-To: <1400261852-31303-23-git-send-email-sahlberg@google.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnleLIzCtJLcpLzFFi42IRYndR1J1WUR5s8GW5uEXXlW4mi38TahyY
	PBZsKvX4vEkugCmK2yYpsaQsODM9T98ugTtj9dQlrAXNghXzlm5kb2Dcy9vFyMkhIWAicerQ
	P1YIW0ziwr31bF2MXBxCApcZJTrXT2KCcM4zSSyeepYZpIpXQFtiVsdboA4ODhYBVYmbt/RA
	wmwCuhKLepqZQMKiAkESf84qQlQLSpyc+YQFxBYRsJNYf2sh2BRhgQSJh4v+g8WFBGokFk9Y
	ywRicwq4SqxcBXIDB9A94hI9jUEgYWYBHYl3fQ+YIWx5ie1v5zBPYBSYhWTDLCRls5CULWBk
	XsUol5hTmqubm5iZU5yarFucnJiXl1qka6aXm1mil5pSuokREqBCOxjXn5Q7xCjAwajEw5tg
	XxYsxJpYVlyZe4hRkoNJSZTXNrY8WIgvKT+lMiOxOCO+qDQntfgQowQHs5II7243oBxvSmJl
	VWpRPkxKmoNFSZz352J1PyGB9MSS1OzU1ILUIpisDAeHkgRvejlQo2BRanpqRVpmTglCmomD
	E2Q4l5RIcWpeSmpRYmlJRjwoSuOLgXEKkuIB2vu3DGRvcUFiLlAUovUUoy7HqTvH2piEWPLy
	81KlxHkVQHYIgBRllObBrYClo1eM4kAfC0OM4gGmMrhJr4CWMAEtebO3FGRJSSJCSqqBMfaN
	zZtKddUHHxjWBKncYSuVXfK890TDvi0WTnsmJzr4rlm3Rr7o+KnqtCNn5a/sct/jUp7p9qzm
	kpL2p6qyxYv/csy5cvVusPgsIT/tjXvWCKnMkgzcEK+/IUA3VfTvwrxiBSaO9oe3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249469>

On 05/16/2014 07:37 PM, Ronnie Sahlberg wrote:
> In s_update_ref there are two calls that when they fail we return an error
> based on the errno value. In particular we want to return a specific error
> if ENOTDIR happened. Both these functions do have failure modes where they
> may return an error without updating errno, in which case a previous and
> unrelated ENOTDIR may cause us to return the wrong error. Clear errno before
> calling any functions if we check errno afterwards.

If I understand correctly, this is a workaround for some other broken
functions that don't handle errno correctly.  Long-term, wouldn't it be
better to fix the other functions?  In other words, they should change
errno if an only if they return an error status, no?

Of course you are under no obligation to fix the universe, so this
change may be an expedient workaround anyway.  But if you go this route,
then I think a comment would be helpful to explain the unusual clearing
of errno.

Michael

> 
> Also skip initializing a static variable to 0. Statics live in .bss and
> are all automatically initialized to 0.
> 
> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
> ---
>  builtin/fetch.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index 55f457c..a93c893 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -44,7 +44,7 @@ static struct transport *gtransport;
>  static struct transport *gsecondary;
>  static const char *submodule_prefix = "";
>  static const char *recurse_submodules_default;
> -static int shown_url = 0;
> +static int shown_url;
>  
>  static int option_parse_recurse_submodules(const struct option *opt,
>  				   const char *arg, int unset)
> @@ -382,6 +382,8 @@ static int s_update_ref(const char *action,
>  	if (!rla)
>  		rla = default_rla.buf;
>  	snprintf(msg, sizeof(msg), "%s: %s", rla, action);
> +
> +	errno = 0;
>  	lock = lock_any_ref_for_update(ref->name,
>  				       check_old ? ref->old_sha1 : NULL,
>  				       0, NULL);
> 


-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
