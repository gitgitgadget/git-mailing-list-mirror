From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 2/4] add a stat_validity struct
Date: Mon, 13 May 2013 04:29:34 +0200
Message-ID: <5190500E.8060907@alum.mit.edu>
References: <20130507023610.GA22053@sigill.intra.peff.net> <20130507023942.GB22940@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon May 13 04:29:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UbiWF-0006h5-QS
	for gcvg-git-2@plane.gmane.org; Mon, 13 May 2013 04:29:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753303Ab3EMC3j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 May 2013 22:29:39 -0400
Received: from ALUM-MAILSEC-SCANNER-1.MIT.EDU ([18.7.68.12]:62525 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752198Ab3EMC3j (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 May 2013 22:29:39 -0400
X-AuditID: 1207440c-b7ff06d0000008f7-51-519050128e3b
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id D1.D3.02295.21050915; Sun, 12 May 2013 22:29:38 -0400 (EDT)
Received: from [192.168.69.140] (p57A25404.dip0.t-ipconnect.de [87.162.84.4])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r4D2TZKN013679
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 12 May 2013 22:29:36 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
In-Reply-To: <20130507023942.GB22940@sigill.intra.peff.net>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNKsWRmVeSWpSXmKPExsUixO6iqCsUMCHQYPkPLouuK91MFg29V5gt
	5t3dxWTxo6WH2YHF49LL72wez3r3MHpcvKTs8XmTXABLFLdNUmJJWXBmep6+XQJ3xprXu5kL
	/ihVXO8/ytTA+FK6i5GTQ0LARGLSpl5WCFtM4sK99WxdjFwcQgKXGSWafl5mgnDOMkl0vlrO
	DlLFK6AtceNYJwuIzSKgKjH13y+wbjYBXYlFPc1MILaoQJjEqvXLmCHqBSVOznwCVi8iICvx
	/fBGRhCbWSBd4m3bO7C4sICxxPejc8B6hQQyJSZM7Afr5RSwlvh04izQRRxA9eoS6+cJQbTK
	S2x/O4d5AqPALCQbZiFUzUJStYCReRWjXGJOaa5ubmJmTnFqsm5xcmJeXmqRrqFebmaJXmpK
	6SZGSDDz7GD8tk7mEKMAB6MSD+8C5QmBQqyJZcWVuYcYJTmYlER5rfyAQnxJ+SmVGYnFGfFF
	pTmpxYcYJTiYlUR497oB5XhTEiurUovyYVLSHCxK4ryqS9T9hATSE0tSs1NTC1KLYLIyHBxK
	EryM/kCNgkWp6akVaZk5JQhpJg5OkOFcUiLFqXkpqUWJpSUZ8aA4jS8GRipIigdo7zyQm3iL
	CxJzgaIQracYjTlmbX3ympFj5RUgKcSSl5+XKiXOexakVACkNKM0D24RLI29YhQH+luYdyFI
	FQ8wBcLNewW0iglo1RmPfpBVJYkIKakGRnGDvW9477afy0wyTGH0Wl4rHfPg1/2+q6+73px/
	/y/g9yEW+di+PTd5I/cZGfi0yKyWmLuzWJEj/8N05dmrIx0+sO23uBK+q2/NVoFQ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224074>

On 05/07/2013 04:39 AM, Jeff King wrote:
> It can sometimes be useful to know whether a path in the
> filesystem has been updated without going to the work of
> opening and re-reading its content. We trust the stat()
> information on disk already to handle index updates, and we
> can use the same trick here.
> 
> This patch introduces a "stat_validity" struct which
> encapsulates the concept of checking the stat-freshness of a
> file. It is implemented on top of "struct cache_entry" to
> reuse the logic about which stat entries to trust for a
> particular platform, but hides the complexity behind two
> simple functions: check and update.

Given that "struct cache_entry" holds a lot of information that is
irrelevant to stat-freshness and that ce_match_stat_basic() has a lot of
logic that is geared towards cache_entries, it seems like there should
be some kind of "struct stat_data" that holds the portion of the stat
information that we use for checking whether a file might have been
changed between two accesses.  cache_entry would contain a stat_data as
a member, and the functionality for checking that part of a cache_entry
validity would be moved to a separate function.

Then your "struct validity_info" could hold a pointer to a stat_data
rather than to a cache_entry, and it wouldn't have to contain the
unrelated cache_entry stuff.

I'll send patches shortly to show what I mean.

Michael

> Signed-off-by: Jeff King <peff@peff.net>
> ---
> This one is prep for the next patch. I'm not super-happy with the way it
> builds around cache_entry, just because cache entries may end up
> following different rules in the long run. But I at least tried to
> encapsulate the grossness, so if it turns out to be a problem, we can
> factor out the relevant bits from ce_match_stat_basic into a shared
> function.
> 
>  cache.h      | 27 +++++++++++++++++++++++++++
>  read-cache.c | 31 +++++++++++++++++++++++++++++++
>  2 files changed, 58 insertions(+)
> 
> diff --git a/cache.h b/cache.h
> index 94ca1ac..adf2874 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -1326,4 +1326,31 @@ int sane_execvp(const char *file, char *const argv[]);
>  
>  int sane_execvp(const char *file, char *const argv[]);
>  
> +/*
> + * A struct to encapsulate the concept of whether a file has changed
> + * since we last checked it. This is a simplified version of the up-to-date
> + * checks we use for the index. The implementation is built on an index entry,
> + * but we shield the callers from that ugliness with our struct.
> + */
> +struct stat_validity {
> +	struct cache_entry *ce;
> +};
> +
> +void stat_validity_clear(struct stat_validity *sv);
> +
> +/*
> + * Returns 1 if the path matches the saved stat_validity, 0 otherwise.
> + * A missing or inaccessible file is considered a match if the struct was just
> + * initialized, or if the previous update found an inaccessible file.
> + */
> +int stat_validity_check(struct stat_validity *sv, const char *path);
> +
> +/*
> + * Update the stat_validity from a file opened at descriptor fd (if the file
> + * is missing or inaccessible, the validity will reflect that, and future
> + * calls to stat_validity_check will match only if it continues to be
> + * inaccessible).
> + */
> +void stat_validity_update(struct stat_validity *sv, int fd);
> +
>  #endif /* CACHE_H */
> diff --git a/read-cache.c b/read-cache.c
> index 04ed561..a0bd06c 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -1933,3 +1933,34 @@ void *read_blob_data_from_index(struct index_state *istate, const char *path, un
>  		*size = sz;
>  	return data;
>  }
> +
> +void stat_validity_clear(struct stat_validity *sv)
> +{
> +	free(sv->ce);
> +	sv->ce = NULL;
> +}
> +
> +int stat_validity_check(struct stat_validity *sv, const char *path)
> +{
> +	struct stat st;
> +
> +	if (stat(path, &st) < 0)
> +		return sv->ce == NULL;
> +	if (!sv->ce)
> +		return 0;
> +	return !ce_match_stat_basic(sv->ce, &st);
> +}
> +
> +void stat_validity_update(struct stat_validity *sv, int fd)
> +{
> +	struct stat st;
> +
> +	if (fstat(fd, &st) < 0)
> +		stat_validity_clear(sv);
> +	else {
> +		if (!sv->ce)
> +			sv->ce = xcalloc(1, cache_entry_size(0));
> +		fill_stat_cache_info(sv->ce, &st);
> +		sv->ce->ce_mode = create_ce_mode(st.st_mode);
> +	}
> +}
> 


-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
