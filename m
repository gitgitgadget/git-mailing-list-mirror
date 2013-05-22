From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v13 02/15] path.c: refactor relative_path(), not only
 strip prefix
Date: Wed, 22 May 2013 10:06:57 +0200
Message-ID: <519C7CA1.2060402@alum.mit.edu>
References: <cover.1369186574.git.worldhello.net@gmail.com> <d730f00edb09449bf299be8d2083c895a1028c18.1369186574.git.worldhello.net@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 22 10:07:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uf44k-0007uP-L7
	for gcvg-git-2@plane.gmane.org; Wed, 22 May 2013 10:07:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753030Ab3EVIHG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 May 2013 04:07:06 -0400
Received: from ALUM-MAILSEC-SCANNER-2.MIT.EDU ([18.7.68.13]:56917 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752139Ab3EVIHB (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 May 2013 04:07:01 -0400
X-AuditID: 1207440d-b7fd06d000000905-bd-519c7ca41a30
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 96.6F.02309.4AC7C915; Wed, 22 May 2013 04:07:00 -0400 (EDT)
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135] (may be forged))
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r4M86vVi013566
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 22 May 2013 04:06:59 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130510 Thunderbird/17.0.6
In-Reply-To: <d730f00edb09449bf299be8d2083c895a1028c18.1369186574.git.worldhello.net@gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLKsWRmVeSWpSXmKPExsUixO6iqLukZk6gwcM/AhZdV7qZLBp6rzBb
	rH93ldmB2WPnrLvsHhcvKXt83iQXwBzFbZOUWFIWnJmep2+XwJ3RcuonU8EqyYpVr24zNTB+
	EOxi5OSQEDCRWHBlPTuELSZx4d56ti5GLg4hgcuMEveX/2SFcK4zSRy8NY8ZpIpXQFviyfbV
	TCA2i4CqxI+HCxhBbDYBXYlFPc1gcVGBMIn3y6ayQtQLSpyc+YQFxBYR0JA4vX0N2BxmATeJ
	DVMXAMU5OIQFIiTmvQ2H2NXHKLH66kSwOZwC8RIrty9ig6jXkXjX9wCqV15i+9s5zBMYBWYh
	WTELSdksJGULGJlXMcol5pTm6uYmZuYUpybrFicn5uWlFuka6eVmluilppRuYoQEL+8Oxv/r
	ZA4xCnAwKvHwPqidHSjEmlhWXJl7iFGSg0lJlNe/bE6gEF9SfkplRmJxRnxRaU5q8SFGCQ5m
	JRFehSCgHG9KYmVValE+TEqag0VJnFdtibqfkEB6YklqdmpqQWoRTFaGg0NJgrejGqhRsCg1
	PbUiLTOnBCHNxMEJMpxLSqQ4NS8ltSixtCQjHhSr8cXAaAVJ8QDtXQjSzltckJgLFIVoPcWo
	yzHjx+R3jEIsefl5qVLivItAigRAijJK8+BWwFLVK0ZxoI+FeVtBqniAaQ5u0iugJUxAS7Zb
	zgRZUpKIkJJqYExjFWjaXDIhZUWzwS9Wp6pMFludWP5jVx56SMcYb9e+oZpfyRpRe964xv/z
	xcxdz2+Hls4IaK3PPnejzGZP+eHKYyqTt93XMarVK7zfPedoBNNhjT/vQzqcjSST 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225139>

Sorry for coming late to the party.

On 05/22/2013 03:40 AM, Jiang Xin wrote:
> Original design of relative_path() is simple, just strip the prefix
> (*base) from the absolute path (*abs). In most cases, we need a real
> relative path, such as: ../foo, ../../bar. That's why there is another
> reimplementation (path_relative()) in quote.c.
> 
> Refactor relative_path() in path.c to return real relative path, so
> that user can reuse this function without reimplement his/her own.
> I will use this method for interactive git-clean later. Some of the
> implementations are borrowed from path_relative() in quote.c.
> 
> Different results for relative_path() before and after this refactor:
> 
>     abs path  base path  relative (original)  relative (refactor)
>     ========  =========  ===================  ===================
>     /a/b/c/   /a/b       c/                   c/
>     /a/b//c/  //a///b/   c/                   c/
>     /a/b      /a/b       .                    ./
>     /a/b/     /a/b       .                    ./
>     /a        /a/b/      /a                   ../
>     /         /a/b/      /                    ../../
>     /a/c      /a/b/      /a/c                 ../c
>     /a/b      (empty)    /a/b                 /a/b
>     /a/b      (null)     /a/b                 /a/b
>     (empty)   /a/b       (empty)              ./
>     (null)    (empty)    (null)               ./
>     (null)    /a/b       (segfault)           ./

The old and new versions both seem to be (differently) inconsistent
about when the output has a trailing slash.  What is the rule?

> diff --git a/path.c b/path.c
> index 04ff..0174d 100644
> --- a/path.c
> +++ b/path.c
> @@ -441,42 +441,104 @@ int adjust_shared_perm(const char *path)
>  	return 0;
>  }
>  
> -const char *relative_path(const char *abs, const char *base)
> +/*
> + * Give path as relative to prefix.
> + *
> + * The strbuf may or may not be used, so do not assume it contains the
> + * returned path.
> + */
> +const char *relative_path(const char *abs, const char *base,
> +			  struct strbuf *sb)

Thanks for adding documentation.  But I think it could be improved:

* The comment refers to "path" and "prefix" but the function parameters
are "abs" and "base".  I suggest making them agree.

* Who owns the memory pointed to by the return value?

* The comment says that "the strbuf may or may not be used".  So why is
it part of the interface?  (I suppose it is because the strbuf might be
given ownership of the returned memory if it has to be allocated.)
Would it be more straightforward to *always* return the result in the
strbuf?

* Please document when the return value contains a trailing slash and
also that superfluous internal slashes are (apparently) normalized away.

* Leading double-slashes have a special meaning on some operating
systems.  The old and new versions of this function both seem to ignore
differences between initial slashes.  Perhaps somebody who knows the
rules better could say whether this is an issue but I guess the problem
would rarely be encountered in practice.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
