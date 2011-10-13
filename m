From: Drew Northup <drew.northup@maine.edu>
Subject: Re: [PATCH 07/14] is_refname_available(): remove the "quiet"
	argument
Date: Thu, 13 Oct 2011 08:41:25 -0400
Message-ID: <1318509685.7231.6.camel@drew-northup.unet.maine.edu>
References: <1318492715-5931-1-git-send-email-mhagger@alum.mit.edu>
	 <1318492715-5931-8-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>
To: mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Oct 13 14:42:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REKbp-0006Ij-Qf
	for gcvg-git-2@lo.gmane.org; Thu, 13 Oct 2011 14:42:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754878Ab1JMMl5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Oct 2011 08:41:57 -0400
Received: from beryl.its.maine.edu ([130.111.32.94]:40089 "EHLO
	beryl.its.maine.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754499Ab1JMMl4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Oct 2011 08:41:56 -0400
Received: from [IPv6:2610:48:100:827::97] (drew-northup.unet.maine.edu [IPv6:2610:48:100:827::97])
	by beryl.its.maine.edu (8.13.8/8.13.8) with ESMTP id p9DCfSFI011217
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 13 Oct 2011 08:41:28 -0400
In-Reply-To: <1318492715-5931-8-git-send-email-mhagger@alum.mit.edu>
X-Mailer: Evolution 2.12.3 (2.12.3-8.el5_2.3) 
X-DCC-UniversityOfMaineSystem-Metrics: beryl.its.maine.edu 1003; Body=8 Fuz1=8
	Fuz2=8
X-MailScanner-Information: Please contact the ISP for more information
X-UmaineSystem-MailScanner-ID: p9DCfSFI011217
X-MailScanner: Found to be clean
X-MailScanner-From: drew.northup@maine.edu
X-UmaineSystem-MailScanner-Watermark: 1319114489.38004@0APxUV1do6kFfflWHXzsIg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183473>


On Thu, 2011-10-13 at 09:58 +0200, mhagger@alum.mit.edu wrote:
> From: Michael Haggerty <mhagger@alum.mit.edu>
> 
> quiet was always set to 0, so get rid of it.  Add a function docstring
> for good measure.

I would like to know if perhaps it was an unfinished project somewhere
to propagate the "quiet" option down to this level before removing the
function argument. Comments?

> +/*
> + * Return true iff a reference named refname could be created without

Did you really mean "iff" (as in "if and only if") or just plain "if"
here?

> + * conflicting with the name of an existing reference.  If oldrefname
> + * is non-NULL, ignore potential conflicts with oldrefname (e.g.,
> + * because oldrefname is scheduled for deletion in the same
> + * operation).
> + */
>  static int is_refname_available(const char *refname, const char *oldrefname,
> -				struct ref_array *array, int quiet)
> +				struct ref_array *array)
>  {
>  	int i, namlen = strlen(refname); /* e.g. 'foo/bar' */
>  	for (i = 0; i < array->nr; i++ ) {
> @@ -1062,9 +1069,8 @@ static int is_refname_available(const char *refname, const char *oldrefname,
>  			const char *lead = (namlen < len) ? entry->name : refname;
>  			if (!strncmp(refname, entry->name, cmplen) &&
>  			    lead[cmplen] == '/') {
> -				if (!quiet)
> -					error("'%s' exists; cannot create '%s'",
> -					      entry->name, refname);
> +				error("'%s' exists; cannot create '%s'",
> +				      entry->name, refname);
>  				return 0;
>  			}
>  		}
> @@ -1117,7 +1123,7 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
>  	 * name is a proper prefix of our refname.
>  	 */
>  	if (missing &&
> -	     !is_refname_available(refname, NULL, get_packed_refs(NULL), 0)) {
> +	     !is_refname_available(refname, NULL, get_packed_refs(NULL))) {
>  		last_errno = ENOTDIR;
>  		goto error_return;
>  	}
> @@ -1272,10 +1278,10 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
>  	if (!symref)
>  		return error("refname %s not found", oldrefname);
>  
> -	if (!is_refname_available(newrefname, oldrefname, get_packed_refs(NULL), 0))
> +	if (!is_refname_available(newrefname, oldrefname, get_packed_refs(NULL)))
>  		return 1;
>  
> -	if (!is_refname_available(newrefname, oldrefname, get_loose_refs(NULL), 0))
> +	if (!is_refname_available(newrefname, oldrefname, get_loose_refs(NULL)))
>  		return 1;
>  
>  	lock = lock_ref_sha1_basic(renamed_ref, NULL, 0, NULL);
-- 
-Drew Northup
________________________________________________
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
