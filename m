From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 05/22] lockfile: unlock file if lockfile permissions cannot
 be adjusted
Date: Mon, 07 Apr 2014 00:02:46 +0200
Message-ID: <5341CF06.9020501@alum.mit.edu>
References: <1396367910-7299-1-git-send-email-mhagger@alum.mit.edu> <1396367910-7299-6-git-send-email-mhagger@alum.mit.edu> <533BB28B.10906@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Mon Apr 07 00:02:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WWv9S-0005yM-8r
	for gcvg-git-2@plane.gmane.org; Mon, 07 Apr 2014 00:02:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753197AbaDFWCv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 Apr 2014 18:02:51 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:44137 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752777AbaDFWCu (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 Apr 2014 18:02:50 -0400
X-AuditID: 12074414-f79d96d000002d2b-96-5341cf090140
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id F3.89.11563.90FC1435; Sun,  6 Apr 2014 18:02:49 -0400 (EDT)
Received: from [192.168.69.148] (p4FDD47DB.dip0.t-ipconnect.de [79.221.71.219])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s36M2kWk007628
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Sun, 6 Apr 2014 18:02:47 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.4.0
In-Reply-To: <533BB28B.10906@web.de>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAKsWRmVeSWpSXmKPExsUixO6iqMt53jHY4GGHiEXXlW4mi4beK8wW
	P1p6mC06O74yOrB4POvdw+hx8ZKyx+dNch63n21jCWCJ4rZJSiwpC85Mz9O3S+DOWHyrlblg
	FnfFvlfbGRsY13N0MXJySAiYSDQvOMoIYYtJXLi3ng3EFhK4zCix72VxFyMXkH2OSeJJ+wRW
	kASvgLbE8uULmEBsFgFViS2fD4A1sAnoSizqaQaKc3CICgRJ/DmrCFEuKHFy5hMWEFtEwFri
	1ZNLLCAlzALxEk+OJoOEhQViJeYt3cMOsWoyo8Szm+fYQRKcAioSzT0zGUHqJQTEJXoag0DC
	zAI6Eu/6HjBD2PISzVtnM09gFJyFZNssJGWzkJQtYGRexSiXmFOaq5ubmJlTnJqsW5ycmJeX
	WqRroZebWaKXmlK6iRES4iI7GI+clDvEKMDBqMTDu+KQY7AQa2JZcWXuIUZJDiYlUV61M0Ah
	vqT8lMqMxOKM+KLSnNTiQ4wSHMxKIryaJkA53pTEyqrUonyYlDQHi5I477fF6n5CAumJJanZ
	qakFqUUwWRkODiUJ3oKzQI2CRanpqRVpmTklCGkmDk6Q4VxSIsWpeSmpRYmlJRnxoOiNLwbG
	L0iKB2ivH0g7b3FBYi5QFKL1FKMux4ZtaxqZhFjy8vNSpcR51UEOFwApyijNg1sBS2ivGMWB
	PhbmjQMZxQNMhnCTXgEtYQJa0hBmB7KkJBEhJdXAaFWx8N+CBbO/vEz5KODAFhe5V5I7vZhd
	dgqDq/yjBXsZfp6yuVTeFHCvjcX2e/fjWSearxmxm03OLe/hapjpKLj3XE3nSvMU 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245795>

On 04/02/2014 08:47 AM, Torsten B=F6gershausen wrote:
> []
>=20
> diff --git a/lockfile.c b/lockfile.c
> index c1af65b..1928e5e 100644
> --- a/lockfile.c
> +++ b/lockfile.c
> @@ -148,9 +148,11 @@ static int lock_file(struct lock_file *lk, const
> char *path, int flags)
>              lock_file_list =3D lk;
>              lk->on_list =3D 1;
>          }
> -        if (adjust_shared_perm(lk->filename))
> -            return error("cannot fix permission bits on %s",
> -                     lk->filename);
> +        if (adjust_shared_perm(lk->filename)) {
> +            error("cannot fix permission bits on %s", lk->filename);
> +            rollback_lock_file(lk);
> +            return -1;
>=20
> Would it make sense to change the order of rollback() and error()?
> Make the rollback first (and as early as possible) and whine then?

Thanks for the feedback.  It is a nice idea.  But given that
rollback_lock_file() erases the filename field, making the change you
suggest would require us to make a copy before calling
rollback_lock_file().  The only advantage would be that we hold the loc=
k
file for a moment less, right?  Since this code path is only reached
when the repository has screwy permissions anyway, the next caller will
probably fail too.  So the extra code complication doesn't seem worth i=
t
to me.

Michael

--=20
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
