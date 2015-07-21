From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v9 3/7] refs: new public ref function: safe_create_reflog
Date: Tue, 21 Jul 2015 12:57:59 -0700
Message-ID: <55AEA447.1080805@alum.mit.edu>
References: <1437493504-3699-1-git-send-email-dturner@twopensource.com> <1437493504-3699-4-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: David Turner <dturner@twopensource.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 21 21:58:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZHdg6-0002wM-3O
	for gcvg-git-2@plane.gmane.org; Tue, 21 Jul 2015 21:58:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932090AbbGUT6I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jul 2015 15:58:08 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:56094 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752299AbbGUT6D (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Jul 2015 15:58:03 -0400
X-AuditID: 12074411-f797e6d000007df3-c8-55aea44a24c6
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 46.F5.32243.A44AEA55; Tue, 21 Jul 2015 15:58:02 -0400 (EDT)
Received: from [172.20.208.234] ([66.251.117.141])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t6LJvx9J027520
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 21 Jul 2015 15:58:02 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.7.0
In-Reply-To: <1437493504-3699-4-git-send-email-dturner@twopensource.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFIsWRmVeSWpSXmKPExsUixO6iqOu1ZF2owb+JNhbzN51gtOi60s3k
	wOSx4Pl9do/Pm+QCmKK4bZISS8qCM9Pz9O0SuDM6d6YVHBeuOHLrHmMD4wH+LkZODgkBE4lt
	216wQ9hiEhfurWfrYuTiEBK4zCix8PJzZghnE5PErc9HWUCqeAW0Je4938YKYrMIqEpMmdoC
	FmcT0JVY1NPM1MXIwSEqECTx+mUuRLmgxMmZT8BKRAQcJC7vOsoMYgsL+EqcWXOHCWJ+M6PE
	yXMbWUB6OQU8JB42eoPUMAvoSey4/osVwpaX2P52DvMERv5ZSMbOQlI2C0nZAkbmVYxyiTml
	ubq5iZk5xanJusXJiXl5qUW6pnq5mSV6qSmlmxgh4Si4g3HGSblDjAIcjEo8vBfa1oYKsSaW
	FVfmHmKU5GBSEuWNX7guVIgvKT+lMiOxOCO+qDQntfgQowQHs5II74lIoBxvSmJlVWpRPkxK
	moNFSZyXb4m6n5BAemJJanZqakFqEUxWhoNDSYJXfDFQo2BRanpqRVpmTglCmomDE2Q4l5RI
	cWpeSmpRYmlJRjwoHuOLgREJkuIB2isN0s5bXJCYCxSFaD3FqCglzrt0EVBCACSRUZoHNxaW
	ZF4xigN9KcyrAdLOA0xQcN2vgAYzAQ2+NWsNyOCSRISUVAPjsnPdQdp7i5tWpbemf2QpynTO
	yvowf9tbo5bH+76oLOgMfFuRp3z43cWYaL66p2++L/V/1H5+I1OP+8r++ndHXZtrNE30I1aW
	qy0z8S0UEpEzu7Nr1ucTYZMf7n8/91VLzLHt+i+/R73/xfj/b4/j9LAOnT3aD0WS 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274409>

On 07/21/2015 08:45 AM, David Turner wrote:
> The safe_create_reflog function creates a reflog, if it does not
> already exist.
> 
> The log_ref_setup function becomes private and gains a force_create
> parameter to force the creation of a reflog even if log_all_ref_updates
> is false or the refname is not one of the special refnames.
> 
> The new parameter also reduces the need to store, modify, and restore
> the log_all_ref_updates global before reflog creation.
> 
> In a moment, we will use this to add reflog creation commands to
> git-reflog.
> 
> Signed-off-by: David Turner <dturner@twopensource.com>
> ---
>  builtin/checkout.c | 14 +++++---------
>  refs.c             | 24 ++++++++++++++++++++----
>  refs.h             |  2 +-
>  3 files changed, 26 insertions(+), 14 deletions(-)
> 
> [...]
> diff --git a/refs.c b/refs.c
> index 2efa2dc..3277768 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -3128,8 +3128,13 @@ static int should_autocreate_reflog(const char *refname)
>  		!strcmp(refname, "HEAD");
>  }
>  
> -/* This function will fill in *err and return -1 on failure */
> -int log_ref_setup(const char *refname, struct strbuf *sb_logfile, struct strbuf *err)
> +/*
> + * Create a reflog for a ref.  If force_create = 0, the reflog will
> + * only be created for certain refs (those for which
> + * should_autocreate_reflog returns non-zero.  Otherwise, create it
> + * regardless of the ref name.  Fill in *err and return -1 on failure.
> + */
> +static int log_ref_setup(const char *refname, struct strbuf *sb_logfile, struct strbuf *err, int force_create)
>  {
>  	int logfd, oflags = O_APPEND | O_WRONLY;
>  	char *logfile;
> @@ -3138,7 +3143,7 @@ int log_ref_setup(const char *refname, struct strbuf *sb_logfile, struct strbuf
>  	logfile = sb_logfile->buf;
>  	/* make sure the rest of the function can't change "logfile" */
>  	sb_logfile = NULL;
> -	if (should_autocreate_reflog(refname)) {
> +	if (force_create || should_autocreate_reflog(refname)) {
>  		if (safe_create_leading_directories(logfile) < 0) {
>  			strbuf_addf(err, "unable to create directory for %s: "
>  				    "%s", logfile, strerror(errno));

I think usually the "strbuf *err" parameter is the last one in our APIs.
I noticed this when reviewing patch 5/7, where there is a similar flags
argument that comes *before* "err". Consistency would suggest that
"force_create" come before "err".

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
