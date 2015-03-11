From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 02/10] Define utility functions for object IDs.
Date: Wed, 11 Mar 2015 13:44:56 +0100
Message-ID: <550038C8.80601@alum.mit.edu>
References: <1425770645-628957-1-git-send-email-sandals@crustytoothpaste.net> <1425770645-628957-3-git-send-email-sandals@crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Andreas Schwab <schwab@linux-m68k.org>
To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 11 13:45:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YVg0o-0007or-83
	for gcvg-git-2@plane.gmane.org; Wed, 11 Mar 2015 13:45:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753034AbbCKMpT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Mar 2015 08:45:19 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:53913 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752277AbbCKMpO (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Mar 2015 08:45:14 -0400
X-AuditID: 12074413-f79f26d0000030e7-22-550038cc94ab
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 67.90.12519.CC830055; Wed, 11 Mar 2015 08:45:00 -0400 (EDT)
Received: from [192.168.69.130] (p4FC960B5.dip0.t-ipconnect.de [79.201.96.181])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t2BCivEk003552
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 11 Mar 2015 08:44:59 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.5.0
In-Reply-To: <1425770645-628957-3-git-send-email-sandals@crustytoothpaste.net>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEKsWRmVeSWpSXmKPExsUixO6iqHvGgiHU4OUzPouuK91MFm0zfzBZ
	9C/tYHNg9lh+8y+Tx6HDHYwenzfJBTBHcdskJZaUBWem5+nbJXBnPP+whLHgBV/F8pkvGBsY
	P3F3MXJySAiYSHy83cAOYYtJXLi3ng3EFhK4zCjxe5F3FyMXkH2eSeJT23tmkASvgKbEpynv
	wRpYBFQlNl2ZwQJiswnoSizqaWYCsUUFgiRe3vrLCFEvKHFy5hOwGhEBL4n5j2awgtjMAloS
	EyevBFsmLOAmse5nFxPEsn5GiRfL3oE1cAr4SSxYepQRokFPYsf1X1DN8hLb385hnsAoMAvJ
	jllIymYhKVvAyLyKUS4xpzRXNzcxM6c4NVm3ODkxLy+1SNdcLzezRC81pXQTIyR8hXcw7jop
	d4hRgINRiYd35qz/IUKsiWXFlbmHGCU5mJREeaNNGEKF+JLyUyozEosz4otKc1KLDzFKcDAr
	ifCeVgXK8aYkVlalFuXDpKQ5WJTEedWWqPsJCaQnlqRmp6YWpBbBZGU4OJQkeA+bAzUKFqWm
	p1akZeaUIKSZODhBhnNJiRSn5qWkFiWWlmTEg2I1vhgYrSApHqC9X0DaeYsLEnOBohCtpxgV
	pcR5d4AkBEASGaV5cGNhSekVozjQl8K8l0GqeIAJDa77FdBgJqDBLNZA//MWlyQipKQaGKcn
	fha7HyQ5sUBmwVl3E+FldxaoM8jyO2q45z2tvLB2zuGn9rWRfVOt//t2L2pTrVY8Z3swY5ei
	8NrLm7e3J2cIvjfT5tkQKWlqIr1tEfNT+3SV6cdVuNMOqa7fv9zs1Kbsqc77VGIm 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265324>

On 03/08/2015 12:23 AM, brian m. carlson wrote:
> There are several utility functions (hashcmp and friends) that are used
> for comparing object IDs (SHA-1 values).  Using these functions, which
> take pointers to unsigned char, with struct object_id requires tiresome
> access to the sha1 member, which bloats code and violates the desired
> encapsulation.  Provide wrappers around these functions for struct
> object_id for neater, more maintainable code.  Use the new constants to
> avoid the hard-coded 20s and 40s throughout the original functions.
> 
> These functions simply call the underlying pointer-to-unsigned-char
> versions to ensure that any performance improvements will be passed
> through to the new functions.
> 
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
> I'm not very excited about having to put the #include in the middle of
> cache.h.  The alternative, of course, is to move enum object_type up,
> which I can do if necessary.  Another alternative is to simply move the
> struct object_id definitions to cache.h instead of object.h, which might
> be cleaner.
> 
> I'm interested in hearing opinions about the best way to go forward.
> 
>  cache.h | 37 +++++++++++++++++++++++++++++++++----
>  hex.c   | 16 +++++++++++++---
>  2 files changed, 46 insertions(+), 7 deletions(-)
> 
> diff --git a/cache.h b/cache.h
> index 761c570..f9addcc 100644
> --- a/cache.h
> +++ b/cache.h
> [...]
> @@ -724,20 +729,42 @@ static inline int hashcmp(const unsigned char *sha1, const unsigned char *sha2)
>  	return 0;
>  }
>  
> +static inline int oidcmp(const struct object_id *o1, const struct object_id *o2)
> +{
> +	return hashcmp(o1->sha1, o2->sha1);
> +}
> +

Maybe rename o1 -> oid1 and o2 -> oid2 just to make things blindingly
obvious?

> [...]

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
