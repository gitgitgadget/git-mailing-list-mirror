From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 1/2] pack-refs: write peeled entry for non-tags
Date: Sat, 16 Mar 2013 14:50:56 +0100
Message-ID: <514478C0.6060008@alum.mit.edu>
References: <20130316090018.GA26708@sigill.intra.peff.net> <20130316090103.GA26855@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Mar 16 14:58:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UGrd1-0004ry-Ld
	for gcvg-git-2@plane.gmane.org; Sat, 16 Mar 2013 14:58:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755886Ab3CPN6E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Mar 2013 09:58:04 -0400
Received: from ALUM-MAILSEC-SCANNER-6.MIT.EDU ([18.7.68.18]:57534 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755846Ab3CPN6B (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 16 Mar 2013 09:58:01 -0400
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Sat, 16 Mar 2013 09:58:01 EDT
X-AuditID: 12074412-b7f216d0000008d4-01-514478c3972a
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id CA.98.02260.3C874415; Sat, 16 Mar 2013 09:50:59 -0400 (EDT)
Received: from [192.168.69.140] (p57A24A2D.dip.t-dialin.net [87.162.74.45])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r2GDouVr020640
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 16 Mar 2013 09:50:58 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130308 Thunderbird/17.0.4
In-Reply-To: <20130316090103.GA26855@sigill.intra.peff.net>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOKsWRmVeSWpSXmKPExsUixO6iqHu4wiXQYF8zr0XXlW4mi4beK8wW
	P1p6mB2YPZ717mH0uHhJ2ePzJrkA5ihum6TEkrLgzPQ8fbsE7ozrLa/YCi4oVsy5x9fAuF6q
	i5GTQ0LARGLa6TesELaYxIV769lAbCGBy4wSi6+GdDFyAdmnmSR+PVnJ3MXIwcEroC0x8zQP
	SA2LgKrEhTU7GUFsNgFdiUU9zUwgtqhAmMTeC9PA5vAKCEqcnPmEBcQWEZCV+H54I1g9s4C1
	xO4+iLiwgLPEub13GEHGCwlkSvSt0QAJcwKV/L9/Emwrs4C6xPp5QhCd8hLb385hnsAoMAvJ
	glkIVbOQVC1gZF7FKJeYU5qrm5uYmVOcmqxbnJyYl5dapGuml5tZopeaUrqJERKwQjsY15+U
	O8QowMGoxMNbYeccKMSaWFZcmXuIUZKDSUmU92SZS6AQX1J+SmVGYnFGfFFpTmrxIUYJDmYl
	Ed79RkA53pTEyqrUonyYlDQHi5I478/F6n5CAumJJanZqakFqUUwWRkODiUJ3onlQI2CRanp
	qRVpmTklCGkmDk6Q4VxSIsWpeSmpRYmlJRnxoPiMLwZGKEiKB2jvT5CbeIsLEnOBohCtpxh1
	OXa/e/SCUYglLz8vVUqcdxXIDgGQoozSPLgVsPT0ilEc6GNh3rkgVTzA1AY36RXQEiagJfuu
	OIEsKUlESEk1MDpzvtr/NOx7yn6jS3s4bO3OOE0M21+X1ShvEtL3TrwtUC7ET+nGhrlbVcKc
	T/7hm81QbBHqPKehKSjbL1CuX0980dbt8xZ5TXsoqhNd6y4kb6obYVBioOdwbNOR 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218304>

Looks good aside from a couple of minor points mentioned below.

On 03/16/2013 10:01 AM, Jeff King wrote:
> When we pack an annotated tag ref, we write not only the
> sha1 of the tag object along with the ref, but also the sha1
> obtained by peeling the tag. This lets readers of the
> pack-refs file know the peeled value without having to
> actually load the object, speeding up upload-pack's ref
> advertisement.
> 
> The writer marks a packed-refs file with peeled refs using
> the "peeled" trait at the top of the file. When the reader
> sees this trait, it knows that each ref is either followed
> by its peeled value, or it is not an annotated tag.
> 
> However, there is a mismatch between the assumptions of the
> reader and writer. The writer will only peel refs under
> refs/tags, but the reader does not know this; it will assume
> a ref without a peeled value must not be a tag object. Thus
> an annotated tag object placed outside of the refs/tags
> hierarchy will not have its peeled value printed by
> upload-pack.
> 
> The simplest way to fix this is to start writing peel values
> for all refs. This matches what the reader expects for both
> new and old versions of git.
> 
> Signed-off-by: Jeff King <peff@peff.net>

I like your explanation of the problem.

> ---
>  pack-refs.c         | 16 ++++++++--------
>  t/t3211-peel-ref.sh | 42 ++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 50 insertions(+), 8 deletions(-)
>  create mode 100755 t/t3211-peel-ref.sh
> 
> diff --git a/pack-refs.c b/pack-refs.c
> index f09a054..10832d7 100644
> --- a/pack-refs.c
> +++ b/pack-refs.c
> @@ -27,6 +27,7 @@ static int handle_one_ref(const char *path, const unsigned char *sha1,
>  			  int flags, void *cb_data)
>  {
>  	struct pack_refs_cb_data *cb = cb_data;
> +	struct object *o;
>  	int is_tag_ref;
>  
>  	/* Do not pack the symbolic refs */
> @@ -39,14 +40,13 @@ static int handle_one_ref(const char *path, const unsigned char *sha1,
>  		return 0;
>  
>  	fprintf(cb->refs_file, "%s %s\n", sha1_to_hex(sha1), path);
> -	if (is_tag_ref) {
> -		struct object *o = parse_object(sha1);
> -		if (o->type == OBJ_TAG) {
> -			o = deref_tag(o, path, 0);
> -			if (o)
> -				fprintf(cb->refs_file, "^%s\n",
> -					sha1_to_hex(o->sha1));
> -		}
> +
> +	o = parse_object(sha1);
> +	if (o->type == OBJ_TAG) {

You suggested that I add a test (o != NULL) at the equivalent place in
my code (which was derived from this code).  Granted, my code was
explicitly intending to pass invalid SHA1 values to parse_object().  But
wouldn't it be a good defensive step to add the same check here?

> +		o = deref_tag(o, path, 0);
> +		if (o)
> +			fprintf(cb->refs_file, "^%s\n",
> +				sha1_to_hex(o->sha1));
>  	}
>  
>  	if ((cb->flags & PACK_REFS_PRUNE) && !do_not_prune(flags)) {
> diff --git a/t/t3211-peel-ref.sh b/t/t3211-peel-ref.sh
> new file mode 100755
> index 0000000..dd5b48b
> --- /dev/null
> +++ b/t/t3211-peel-ref.sh
> @@ -0,0 +1,42 @@
> +#!/bin/sh
> +
> +test_description='tests for the peel_ref optimization of packed-refs'
> +. ./test-lib.sh
> +
> +test_expect_success 'create annotated tag in refs/tags' '
> +	test_commit base &&
> +	git tag -m annotated foo
> +'
> +
> +test_expect_success 'create annotated tag outside of refs/tags' '
> +	git update-ref refs/outside/foo refs/tags/foo
> +'
> +
> +# This matches show-ref's output
> +print_ref() {
> +	echo "`git rev-parse "$1"` $1"
> +}
> +

CodingGuidelines prefers $() over ``.

> +test_expect_success 'set up expected show-ref output' '
> +	{
> +		print_ref "refs/heads/master" &&
> +		print_ref "refs/outside/foo" &&
> +		print_ref "refs/outside/foo^{}" &&
> +		print_ref "refs/tags/base" &&
> +		print_ref "refs/tags/foo" &&
> +		print_ref "refs/tags/foo^{}"
> +	} >expect
> +'
> +
> +test_expect_success 'refs are peeled outside of refs/tags (loose)' '
> +	git show-ref -d >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'refs are peeled outside of refs/tags (packed)' '
> +	git pack-refs --all &&
> +	git show-ref -d >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_done
> 


-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
