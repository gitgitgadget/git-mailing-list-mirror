From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 1/4] name-ref: factor out name shortening logic from name_ref()
Date: Mon, 08 Jul 2013 10:52:13 +0200
Message-ID: <51DA7DBD.7070405@alum.mit.edu>
References: <1373236424-25617-1-git-send-email-gitster@pobox.com> <1373236424-25617-2-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 08 10:52:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uw7BF-0003Xe-Qj
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jul 2013 10:52:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752419Ab3GHIwR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jul 2013 04:52:17 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:59920 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752386Ab3GHIwP (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Jul 2013 04:52:15 -0400
X-AuditID: 12074414-b7f626d0000001f1-44-51da7dbfb919
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 54.49.00497.FBD7AD15; Mon,  8 Jul 2013 04:52:15 -0400 (EDT)
Received: from [192.168.101.152] (mx.berlin.jpk.com [212.222.128.135] (may be forged))
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r688qD9R006720
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 8 Jul 2013 04:52:14 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130623 Thunderbird/17.0.7
In-Reply-To: <1373236424-25617-2-git-send-email-gitster@pobox.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKKsWRmVeSWpSXmKPExsUixO6iqLu/9lagwY8ubouuK91MFg29V5gd
	mDwuXlL2+LxJLoApitsmKbGkLDgzPU/fLoE7433LHaaCw3wVX+adZ2xgPMDdxcjJISFgInH3
	8FE2CFtM4sK99UA2F4eQwGVGiYNXf7KCJIQErjJJ3NwbBWLzCmhLHHt7nRnEZhFQlfh68DJY
	DZuArsSinmamLkYODlGBMIkrv1UhygUlTs58wgJiiwioSUxsO8QCUsIsIC7R/w8sLCwQLNH2
	7z4rSFhIoFxi9ltvkDCngJPEljlXwIYzC+hIvOt7wAxhy0tsfzuHeQKjwCwkC2YhKZuFpGwB
	I/MqRrnEnNJc3dzEzJzi1GTd4uTEvLzUIl0LvdzMEr3UlNJNjJAAFdnBeOSk3CFGAQ5GJR7e
	grM3A4VYE8uKK3MPMUpyMCmJ8prV3AoU4kvKT6nMSCzOiC8qzUktPsQowcGsJMIrzgqU401J
	rKxKLcqHSUlzsCiJ835brO4nJJCeWJKanZpakFoEk5Xh4FCS4J0OMlSwKDU9tSItM6cEIc3E
	wQkynEtKpDg1LyW1KLG0JCMeFKPxxcAoBUnxAO1dB9LOW1yQmAsUhWg9xWjMMfnslveMHAd+
	AEkhlrz8vFQpcd6tIKUCIKUZpXlwi2Cp6RWjONDfwrytIFU8wLQGN+8V0ComoFUNaWCrShIR
	UlINjCtemlbPn7w+PikkcoqAu92u/YePGE9ImhBs9zv1erRk7DLz7ZIbnjqetZqtLHvpYfwP
	4xyz7VPY1V/zFuzN4ehyOnLlz4krm7Q75Bv1L8uc6u4tve0wn9Nqbcb6H6+fnCjr 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229829>

On 07/08/2013 12:33 AM, Junio C Hamano wrote:
> The logic will be used in a new codepath for showing exact matches.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  builtin/name-rev.c | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/builtin/name-rev.c b/builtin/name-rev.c
> index 87d4854..1234ebb 100644
> --- a/builtin/name-rev.c
> +++ b/builtin/name-rev.c
> @@ -96,6 +96,17 @@ static int subpath_matches(const char *path, const char *filter)
>  	return -1;
>  }
>  
> +static const char *name_ref_abbrev(const char *refname, int shorten_unambiguous)
> +{
> +	if (shorten_unambiguous)
> +		refname = shorten_unambiguous_ref(refname, 0);
> +	else if (!prefixcmp(refname, "refs/heads/"))
> +		refname = refname + 11;
> +	else if (!prefixcmp(refname, "refs/"))
> +		refname = refname + 5;
> +	return refname;
> +}
> +

In my opinion this would be a tad clearer if each of the branches of the
"if" returned the value directly rather than setting refname and relying
on the "return" statement that follows.  But it's probably a matter of
taste.

>  struct name_ref_data {
>  	int tags_only;
>  	int name_only;
> @@ -134,13 +145,7 @@ static int name_ref(const char *path, const unsigned char *sha1, int flags, void
>  	if (o && o->type == OBJ_COMMIT) {
>  		struct commit *commit = (struct commit *)o;
>  
> -		if (can_abbreviate_output)
> -			path = shorten_unambiguous_ref(path, 0);
> -		else if (!prefixcmp(path, "refs/heads/"))
> -			path = path + 11;
> -		else if (!prefixcmp(path, "refs/"))
> -			path = path + 5;
> -
> +		path = name_ref_abbrev(path, can_abbreviate_output);
>  		name_rev(commit, xstrdup(path), 0, 0, deref);
>  	}
>  	return 0;
> 

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
