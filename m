From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH] Fix "inside work tree" detection on case-insensitive
 filesystems
Date: Tue, 29 Dec 2015 15:47:36 +0100
Message-ID: <56829D08.1060107@alum.mit.edu>
References: <ac9733a6b922572ec10f09f89e07cde37ba43f13.1443456630.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 29 15:54:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aDvfh-0000mh-P2
	for gcvg-git-2@plane.gmane.org; Tue, 29 Dec 2015 15:54:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752982AbbL2Oym (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Dec 2015 09:54:42 -0500
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:48633 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752690AbbL2Oyk (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Dec 2015 09:54:40 -0500
X-Greylist: delayed 421 seconds by postgrey-1.27 at vger.kernel.org; Tue, 29 Dec 2015 09:54:40 EST
X-AuditID: 12074412-f79a76d000007c8b-b7-56829d0a70a1
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 28.9D.31883.A0D92865; Tue, 29 Dec 2015 09:47:38 -0500 (EST)
Received: from [192.168.69.130] (p4FC97AF1.dip0.t-ipconnect.de [79.201.122.241])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id tBTEla4A025727
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 29 Dec 2015 09:47:37 -0500
X-Enigmail-Draft-Status: N1110
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.4.0
In-Reply-To: <ac9733a6b922572ec10f09f89e07cde37ba43f13.1443456630.git.johannes.schindelin@gmx.de>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNKsWRmVeSWpSXmKPExsUixO6iqMs1tynMYMdkeYuuK91MFg29V5gt
	+pd3sTkwe3z4GOdx8ZKyx+dNcgHMUdw2SYklZcGZ6Xn6dgncGWuWnmAu+CtYceL7R8YGxol8
	XYycHBICJhI7+jtZIGwxiQv31rN1MXJxCAlcZpR4c+gPI4RzgUni0JYNTCBVwgLhEocnP2AD
	sUUEEiV+7/zNDGILCSRIXOuYxw5iMwuIS6ybex7MZhPQlVjU08wEsUFOord7Etg2XgFtiaN3
	dgPFOThYBFQlHs+SAQmLCoRI7N3ZAVUiKHFy5hMwmxNoVfu6biaI8XoSO67/YoWw5SWat85m
	nsAoOAtJyywkZbOQlC1gZF7FKJeYU5qrm5uYmVOcmqxbnJyYl5dapGuml5tZopeaUrqJERLQ
	QjsY15+UO8QowMGoxMObOakxTIg1say4MvcQoyQHk5Ior357U5gQX1J+SmVGYnFGfFFpTmrx
	IUYJDmYlEV7FSUA53pTEyqrUonyYlDQHi5I478/F6n5CAumJJanZqakFqUUwWRkODiUJ3uez
	gRoFi1LTUyvSMnNKENJMHJwgw7mkRIpT81JSixJLSzLiQREcXwyMYZAUD9Beuzkge4sLEnOB
	ohCtpxgVpcR520ASAiCJjNI8uLGwNPWKURzoS2HefSDbeYApDq77FdBgJqDBM6fWgwwuSURI
	STUwzrmZItKl85NHzNffIam1/vTla2Usa89575l3Yd/yyJPr3M91elRcDo6zjTVr7pz3x3Wb
	UdMurrBClZWGRmenffPfPmPlX5XGo9EnC9xYbPO1Ym1/v7n42PV9XKr2QY8aVZsd 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283134>

On 09/28/2015 06:12 PM, Johannes Schindelin wrote:
> Git has a config variable to indicate that it is operating on a file
> system that is case-insensitive: core.ignoreCase. But the
> `dir_inside_of()` function did not respect that. As a result, if Git's
> idea of the current working directory disagreed in its upper/lower case
> with the `GIT_WORK_TREE` variable (e.g. `C:\test` vs `c:\test`) the
> user would be greeted by the error message
> 
> 	fatal: git-am cannot be used without a working tree.
> 
> when trying to run a rebase.
> 
> This fixes https://github.com/git-for-windows/git/issues/402 (reported by
> Daniel Harding).

I was just going through the 2.7 release notes when I saw this patch. My
understanding was that many of the case-insensitive filesystems also
support Unicode. Is the byte-oriented code in this patch adequate? I
would have thought it necessary to use a Unicode-aware algorithm here,
that knows:

* that bytes != characters
* how to do a case-insensitive comparison of strings that include
non-ASCII characters
* (possibly) insensitivity to NFC vs. NFD vs. non-normalized forms

I suppose that such OSs have built-in functions for deciding whether two
paths are equivalent. Possibly these could be used?

Michael

> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  dir.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/dir.c b/dir.c
> index b90484a..fba938b 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -2107,6 +2107,15 @@ int file_exists(const char *f)
>  	return lstat(f, &sb) == 0;
>  }
>  
> +static int cmp_icase(char a, char b)
> +{
> +	if (a == b)
> +		return 0;
> +	if (ignore_case)
> +		return toupper(a) - toupper(b);
> +	return a - b;
> +}
> +
>  /*
>   * Given two normalized paths (a trailing slash is ok), if subdir is
>   * outside dir, return -1.  Otherwise return the offset in subdir that
> @@ -2118,7 +2127,7 @@ int dir_inside_of(const char *subdir, const char *dir)
>  
>  	assert(dir && subdir && *dir && *subdir);
>  
> -	while (*dir && *subdir && *dir == *subdir) {
> +	while (*dir && *subdir && !cmp_icase(*dir, *subdir)) {
>  		dir++;
>  		subdir++;
>  		offset++;
> 


-- 
Michael Haggerty
mhagger@alum.mit.edu
