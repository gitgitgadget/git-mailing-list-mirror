From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 2/2] pack-refs: add fully-peeled trait
Date: Sat, 16 Mar 2013 15:06:22 +0100
Message-ID: <51447C5E.3050808@alum.mit.edu>
References: <20130316090018.GA26708@sigill.intra.peff.net> <20130316090116.GB26855@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Mar 16 15:14:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UGrrx-0004Js-Ln
	for gcvg-git-2@plane.gmane.org; Sat, 16 Mar 2013 15:13:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755843Ab3CPONb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Mar 2013 10:13:31 -0400
Received: from ALUM-MAILSEC-SCANNER-6.MIT.EDU ([18.7.68.18]:46605 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755841Ab3CPONa (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 16 Mar 2013 10:13:30 -0400
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Sat, 16 Mar 2013 10:13:30 EDT
X-AuditID: 12074412-b7f216d0000008d4-2d-51447c62e9df
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 37.D8.02260.26C74415; Sat, 16 Mar 2013 10:06:26 -0400 (EDT)
Received: from [192.168.69.140] (p57A24A2D.dip.t-dialin.net [87.162.74.45])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r2GE6NY1021280
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 16 Mar 2013 10:06:24 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130308 Thunderbird/17.0.4
In-Reply-To: <20130316090116.GB26855@sigill.intra.peff.net>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFKsWRmVeSWpSXmKPExsUixO6iqJtU4xJo8Ocal0XXlW4mi4beK8wW
	P1p6mB2YPZ717mH0uHhJ2ePzJrkA5ihum6TEkrLgzPQ8fbsE7oy53cYFpzQrrl/ewd7AuE+h
	i5GTQ0LARGLC6pnMELaYxIV769m6GLk4hAQuM0o82fSBCcI5zSTxePkRNpAqXgFtibPvX4LZ
	LAKqEmvWnmAFsdkEdCUW9TQzgdiiAmESey9Mg6oXlDg58wkLiC0iICvx/fBGRhCbWcBaYncf
	RFxYwEri6qaXYFcICWRK7Dt1BayXE6jm7aQzQDUcQPXqEuvnCUG0yktsfzuHeQKjwCwkG2Yh
	VM1CUrWAkXkVo1xiTmmubm5iZk5xarJucXJiXl5qka6ZXm5miV5qSukmRkjYCu1gXH9S7hCj
	AAejEg9vhZ1zoBBrYllxZe4hRkkOJiVR3pNlLoFCfEn5KZUZicUZ8UWlOanFhxglOJiVRHir
	K4ByvCmJlVWpRfkwKWkOFiVx3p+L1f2EBNITS1KzU1MLUotgsjIcHEoSvCHVQI2CRanpqRVp
	mTklCGkmDk6Q4VxSIsWpeSmpRYmlJRnxoCiNLwbGKUiKB2ivNUg7b3FBYi5QFKL1FKMux+53
	j14wCrHk5eelSonz8oEUCYAUZZTmwa2AJalXjOJAHwvz6oBU8QATHNykV0BLmICW7LviBLKk
	JBEhJdXAaLReKmh5xZ5V304cZmi753r5SU0Ek5GXcK2Ka3nb7Zo9Z4VetVyf+IvP2ck6ac5O
	11WnohgynfSzZSOWZM3cqXxMeUXrR7lllRYs19cFdF2Wi+0Ik3Cs2SZSXHhlet3z 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218305>

ACK, with one ignorable comment.

Michael

On 03/16/2013 10:01 AM, Jeff King wrote:
> Older versions of pack-refs did not write peel lines for
> refs outside of refs/tags. This meant that on reading the
> pack-refs file, we might set the REF_KNOWS_PEELED flag for
> such a ref, even though we do not know anything about its
> peeled value.
> 
> The previous commit updated the writer to always peel, no
> matter what the ref is. That means that packed-refs files
> written by newer versions of git are fine to be read by both
> old and new versions of git. However, we still have the
> problem of reading packed-refs files written by older
> versions of git, or by other implementations which have not
> yet learned the same trick.
> 
> The simplest fix would be to always unset the
> REF_KNOWS_PEELED flag for refs outside of refs/tags that do
> not have a peel line (if it has a peel line, we know it is
> valid, but we cannot assume a missing peel line means
> anything). But that loses an important optimization, as
> upload-pack should not need to load the object pointed to by
> refs/heads/foo to determine that it is not a tag.
> 
> Instead, we add a "fully-peeled" trait to the packed-refs
> file. If it is set, we know that we can trust a missing peel
> line to mean that a ref cannot be peeled. Otherwise, we fall
> back to assuming nothing.

Another nice, clear explanation of the issue.

> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  pack-refs.c         |  2 +-
>  refs.c              | 16 +++++++++++++++-
>  t/t3211-peel-ref.sh | 22 ++++++++++++++++++++++
>  3 files changed, 38 insertions(+), 2 deletions(-)
> 
> diff --git a/pack-refs.c b/pack-refs.c
> index 10832d7..87ca04d 100644
> --- a/pack-refs.c
> +++ b/pack-refs.c
> @@ -128,7 +128,7 @@ int pack_refs(unsigned int flags)
>  		die_errno("unable to create ref-pack file structure");
>  
>  	/* perhaps other traits later as well */
> -	fprintf(cbdata.refs_file, "# pack-refs with: peeled \n");
> +	fprintf(cbdata.refs_file, "# pack-refs with: peeled fully-peeled \n");
>  
>  	for_each_ref(handle_one_ref, &cbdata);
>  	if (ferror(cbdata.refs_file))
> diff --git a/refs.c b/refs.c
> index 175b9fc..6a38c41 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -808,6 +808,7 @@ static void read_packed_refs(FILE *f, struct ref_dir *dir)
>  	struct ref_entry *last = NULL;
>  	char refline[PATH_MAX];
>  	int flag = REF_ISPACKED;
> +	int fully_peeled = 0;
>  
>  	while (fgets(refline, sizeof(refline), f)) {
>  		unsigned char sha1[20];
> @@ -818,13 +819,26 @@ static void read_packed_refs(FILE *f, struct ref_dir *dir)
>  			const char *traits = refline + sizeof(header) - 1;
>  			if (strstr(traits, " peeled "))
>  				flag |= REF_KNOWS_PEELED;
> +			if (strstr(traits, " fully-peeled "))
> +				fully_peeled = 1;
>  			/* perhaps other traits later as well */
>  			continue;
>  		}
>  
>  		refname = parse_ref_line(refline, sha1);
>  		if (refname) {
> -			last = create_ref_entry(refname, sha1, flag, 1);
> +			/*
> +			 * Older git did not write peel lines for anything
> +			 * outside of refs/tags/; if the fully-peeled trait
> +			 * is not set, we are dealing with such an older
> +			 * git and cannot assume an omitted peel value
> +			 * means the ref is not a tag object.
> +			 */
> +			int this_flag = flag;
> +			if (!fully_peeled && prefixcmp(refname, "refs/tags/"))
> +				this_flag &= ~REF_KNOWS_PEELED;
> +
> +			last = create_ref_entry(refname, sha1, this_flag, 1);
>  			add_ref(dir, last);
>  			continue;
>  		}

I have to admit that I am partial to my variant of this code [1] because
the logic makes it clearer when the affirmative decision can be made to
set the REF_KNOWS_PEELED flag.  But this version also looks correct to
me and equivalent (aside from the idea that a few lines later if a
peeled value is found then the REF_KNOWS_PEELED bit could also be set).

> diff --git a/t/t3211-peel-ref.sh b/t/t3211-peel-ref.sh
> index dd5b48b..a8eb1aa 100755
> --- a/t/t3211-peel-ref.sh
> +++ b/t/t3211-peel-ref.sh
> @@ -39,4 +39,26 @@ test_expect_success 'refs are peeled outside of refs/tags (packed)' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'create old-style pack-refs without fully-peeled' '
> +	# Git no longer writes without fully-peeled, so we just write our own
> +	# from scratch; we could also munge the existing file to remove the
> +	# fully-peeled bits, but that seems even more prone to failure,
> +	# especially if the format ever changes again. At least this way we
> +	# know we are emulating exactly what an older git would have written.
> +	{
> +		echo "# pack-refs with: peeled " &&
> +		print_ref "refs/heads/master" &&
> +		print_ref "refs/outside/foo" &&
> +		print_ref "refs/tags/base" &&
> +		print_ref "refs/tags/foo" &&
> +		echo "^$(git rev-parse "refs/tags/foo^{}")"
> +	} >tmp &&
> +	mv tmp .git/packed-refs
> +'
> +
> +test_expect_success 'refs are peeled outside of refs/tags (old packed)' '
> +	git show-ref -d >actual &&
> +	test_cmp expect actual
> +'
> +
>  test_done
> 

[1]
https://github.com/mhagger/git/commit/1c8d4daa2de15a03637d753471a9e5222b01b968

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
