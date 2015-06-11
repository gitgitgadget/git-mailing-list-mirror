From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 3/8] Convert struct ref to use object_id.
Date: Thu, 11 Jun 2015 17:41:17 +0200
Message-ID: <5579AC1D.6000606@alum.mit.edu>
References: <1433867316-663554-1-git-send-email-sandals@crustytoothpaste.net> <1433867316-663554-4-git-send-email-sandals@crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1?= =?UTF-8?B?eQ==?= 
	<pclouds@gmail.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 11 17:41:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z34bt-0005Ph-Oo
	for gcvg-git-2@plane.gmane.org; Thu, 11 Jun 2015 17:41:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752319AbbFKPli (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jun 2015 11:41:38 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:45123 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752046AbbFKPlg (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Jun 2015 11:41:36 -0400
X-AuditID: 1207440d-f79c76d000000bf7-08-5579ac200ef9
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 12.C1.03063.02CA9755; Thu, 11 Jun 2015 11:41:20 -0400 (EDT)
Received: from [192.168.69.130] (p4FC97261.dip0.t-ipconnect.de [79.201.114.97])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t5BFfInV000588
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Thu, 11 Jun 2015 11:41:19 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.7.0
In-Reply-To: <1433867316-663554-4-git-send-email-sandals@crustytoothpaste.net>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOKsWRmVeSWpSXmKPExsUixO6iqKuwpjLU4MBiK4uuK91MFt1T3jJa
	/GjpYbZom/mDyYHFY/nNv0weO2fdZfd41ruH0ePzJrkAlihum6TEkrLgzPQ8fbsE7oz/s+6z
	F/xUr3i9o6aB8YlcFyMnh4SAiUT/riPMELaYxIV769m6GLk4hAQuM0pcn9rBCpIQEjjPJPFg
	mgOIzSugLTF1RhtLFyMHB4uAqsTyGfwgYTYBXYlFPc1MIGFRgSCJ1y9zIaoFJU7OfMICYosI
	eEnMfzQDbCKzQLXEv2tf2UBsYQFbif6f7YwQa/sZJR7tvQbWwCngJ/FuYyszyExmAXWJ9fOE
	IHrlJZq3zmaewCgwC8mKWQhVs5BULWBkXsUol5hTmqubm5iZU5yarFucnJiXl1qka6SXm1mi
	l5pSuokREsi8Oxj/r5M5xCjAwajEw1txoiJUiDWxrLgy9xCjJAeTkihvtmtlqBBfUn5KZUZi
	cUZ8UWlOavEhRgkOZiUR3s3LgHK8KYmVValF+TApaQ4WJXFetSXqfkIC6YklqdmpqQWpRTBZ
	GQ4OJQlekdVAjYJFqempFWmZOSUIaSYOTpDhXFIixal5KalFiaUlGfGgCI0vBsYoSIoHaK8s
	SDtvcUFiLlAUovUUo6KUOO/7VUAJAZBERmke3FhYenrFKA70pTDvWZAqHmBqg+t+BTSYCWjw
	QuZykMEliQgpqQbGJPWkXUd/30j6dKcnxCXzxKriSbEvTu14dmmnVKGnYPmuNs6rD+9ucbx7
	N6B2/oZnBo88qy291t63TZ+s+zF45+mu6zz7fJW1av2qLhh8evQx3ft3ks/JCzVf 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271420>

I visually inspected patches 1 and 2 without finding any problems.

Regarding this patch, I saw a few functions where you could convert
local variables to "struct object_id" and then change function calls
like hashcpy() to oidcpy(). See below. I'm not sure if it makes sense to
do that in this same patch.

For that matter, it seems to me that it should be possible to change
*all* local

    unsigned char $variable[20];

to

    struct object_id $variable;

without having to change any external interfaces. I wonder whether it
would be advisable to make that change early in this transition? It
would have the advantage that during later refactorings, where, e.g., a
function needs a "struct object_id *" parameter, you would often already
have one handy.

Michael

On 06/09/2015 06:28 PM, brian m. carlson wrote:
> Use struct object_id in three fields in struct ref and convert all the
> necessary places that use it.
> 
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  builtin/clone.c        | 16 +++++++-------
>  builtin/fetch-pack.c   |  4 ++--
>  builtin/fetch.c        | 50 +++++++++++++++++++++----------------------
>  builtin/ls-remote.c    |  2 +-
>  builtin/receive-pack.c |  2 +-
>  builtin/remote.c       | 12 +++++------
>  connect.c              |  2 +-
>  fetch-pack.c           | 18 ++++++++--------
>  http-push.c            | 46 +++++++++++++++++++--------------------
>  http.c                 |  2 +-
>  remote-curl.c          | 10 ++++-----
>  remote.c               | 58 +++++++++++++++++++++++++-------------------------
>  remote.h               |  6 +++---
>  send-pack.c            | 16 +++++++-------
>  transport-helper.c     | 18 ++++++++--------
>  transport.c            | 32 ++++++++++++++--------------
>  transport.h            |  8 +++----
>  walker.c               |  2 +-
>  18 files changed, 152 insertions(+), 152 deletions(-)
> 
> [...]
> diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
> index 4a6b340..19215b3 100644
> --- a/builtin/fetch-pack.c
> +++ b/builtin/fetch-pack.c
> @@ -17,7 +17,7 @@ static void add_sought_entry_mem(struct ref ***sought, int *nr, int *alloc,
>  	unsigned char sha1[20];
>  
>  	if (namelen > 41 && name[40] == ' ' && !get_sha1_hex(name, sha1)) {
> -		hashcpy(ref->old_sha1, sha1);
> +		hashcpy(ref->old_oid.hash, sha1);
>  		name += 41;
>  		namelen -= 41;
>  	}

Variable "sha1" in this function could become "struct object_id".

> [...]
> diff --git a/connect.c b/connect.c
> index c0144d8..f8b10eb 100644
> --- a/connect.c
> +++ b/connect.c
> @@ -165,7 +165,7 @@ struct ref **get_remote_heads(int in, char *src_buf, size_t src_len,
>  		if (!check_ref(name, flags))
>  			continue;
>  		ref = alloc_ref(buffer + 41);
> -		hashcpy(ref->old_sha1, old_sha1);
> +		hashcpy(ref->old_oid.hash, old_sha1);
>  		*list = ref;
>  		list = &ref->next;
>  		got_at_least_one_head = 1;

old_sha1 in this function could become "struct object_id". Also, this
function has a few "20" and "41" and "42" hard-coded literals.

> [...]
> diff --git a/remote-curl.c b/remote-curl.c
> index af7b678..80cb4c7 100644
> --- a/remote-curl.c
> +++ b/remote-curl.c
> [...]
> @@ -814,7 +814,7 @@ static void parse_fetch(struct strbuf *buf)
>  				die("protocol error: expected sha/ref, got %s'", p);
>  
>  			ref = alloc_ref(name);
> -			hashcpy(ref->old_sha1, old_sha1);
> +			hashcpy(ref->old_oid.hash, old_sha1);
>  
>  			*list = ref;
>  			list = &ref->next;

old_sha1 in this code block could be converted to "struct object_id".

> diff --git a/remote.c b/remote.c
> index 26504b7..706d2fb 100644
> --- a/remote.c
> +++ b/remote.c
> [...]
> @@ -1131,7 +1131,7 @@ static int try_explicit_object_name(const char *name,
>  
>  	if (match) {
>  		*match = alloc_ref(name);
> -		hashcpy((*match)->new_sha1, sha1);
> +		hashcpy((*match)->new_oid.hash, sha1);
>  	}
>  	return 0;
>  }

The "sha1" variable in this function could become a "struct object_id".

> [...]
> @@ -2181,7 +2181,7 @@ static int one_local_ref(const char *refname, const struct object_id *oid,
>  
>  	len = strlen(refname) + 1;
>  	ref = xcalloc(1, sizeof(*ref) + len);
> -	hashcpy(ref->new_sha1, oid->hash);
> +	hashcpy(ref->new_oid.hash, oid->hash);

This could become oidcopy().

>  	memcpy(ref->name, refname, len);
>  	**local_tail = ref;
>  	*local_tail = &ref->next;
> [...]
> diff --git a/transport-helper.c b/transport-helper.c
> index 5d99a6b..4ca3e80 100644
> --- a/transport-helper.c
> +++ b/transport-helper.c
> [...]
> @@ -883,7 +883,7 @@ static int push_refs_with_export(struct transport *transport,
>  		if (private && !get_sha1(private, sha1)) {
>  			strbuf_addf(&buf, "^%s", private);
>  			string_list_append(&revlist_args, strbuf_detach(&buf, NULL));
> -			hashcpy(ref->old_sha1, sha1);
> +			hashcpy(ref->old_oid.hash, sha1);
>  		}
>  		free(private);
>  

sha1 in this function could become "struct object_id".

> [...]

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
