From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 00/17] Clean up how fetch_pack() handles the heads list
Date: Sun, 02 Sep 2012 09:02:17 +0200
Message-ID: <50430479.3060006@alum.mit.edu>
References: <1345709442-16046-1-git-send-email-mhagger@alum.mit.edu> <20120823092624.GG6963@sigill.intra.peff.net> <49DEA56853C64B9B900D3C7F886D4FA6@PhilipOakley> <20120823195648.GB15268@sigill.intra.peff.net> <20120823203152.GA1810@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Philip Oakley <philipoakley@iee.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Sep 02 09:03:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T84DA-00064E-Jj
	for gcvg-git-2@plane.gmane.org; Sun, 02 Sep 2012 09:03:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753423Ab2IBHCX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Sep 2012 03:02:23 -0400
Received: from ALUM-MAILSEC-SCANNER-8.MIT.EDU ([18.7.68.20]:53686 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751548Ab2IBHCW (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 Sep 2012 03:02:22 -0400
X-AuditID: 12074414-b7f846d0000008b8-09-5043047d353b
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 09.92.02232.D7403405; Sun,  2 Sep 2012 03:02:21 -0400 (EDT)
Received: from [192.168.69.140] (p57A25648.dip.t-dialin.net [87.162.86.72])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q8272IO1026123
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 2 Sep 2012 03:02:19 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:14.0) Gecko/20120714 Thunderbird/14.0
In-Reply-To: <20120823203152.GA1810@sigill.intra.peff.net>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMKsWRmVeSWpSXmKPExsUixO6iqFvL4hxg8PyKnEXXlW4mi4beK8wW
	P1p6mC06p8o6sHgsX7qO0eNZ7x5Gj4uXlD0+b5ILYInitklKLCkLzkzP07dL4M54+XcXY8EE
	54rWLq8GxmMmXYycHBICJhI3lt5khLDFJC7cW8/WxcjFISRwmVHi47xdzBDOKSaJ06fuAFVx
	cPAKaEt0XKsCaWARUJVY96yDCcRmE9CVWNTTDGaLCoRIrPk2BWwor4CgxMmZT1hAbBEBWYnv
	hzeCxZkFsiTmbXzLDGILC3hLvPndzgSx6z+jxJblh9lBEpwCVhIdJ1ezguxlFlCXWD9PCKJX
	XmL72znMExgFZiFZMQuhahaSqgWMzKsY5RJzSnN1cxMzc4pTk3WLkxPz8lKLdC30cjNL9FJT
	SjcxQgJZZAfjkZNyhxgFOBiVeHgnr3cKEGJNLCuuzD3EKMnBpCTKa/MNKMSXlJ9SmZFYnBFf
	VJqTWnyIUYKDWUmEN/A2UI43JbGyKrUoHyYlzcGiJM77bbG6n5BAemJJanZqakFqEUxWhoND
	SYK3hck5QEiwKDU9tSItM6cEIc3EwQkynEtKpDg1LyW1KLG0JCMeFKXxxcA4BUnxAO1dDNLO
	W1yQmAsUhWg9xajL8fnpybuMQix5+XmpUuK8tsxARQIgRRmleXArYGnrFaM40MfCEKN4gCkP
	btIroCVMQEvkNOxBlpQkIqSkGhi7lL/YHNUqf9UfetCiJMa0nCd58e7uN25evDaJHH0pJ91D
	nshNt7lfG+2if37n80j1q/8lGb2y7vr0Ho256lUnrTZHxWjznk31vedDYlUOzdFV 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204664>

On 08/23/2012 10:31 PM, Jeff King wrote:
> On Thu, Aug 23, 2012 at 03:56:48PM -0400, Jeff King wrote:
> 
>> This code blames back to:
>>
>>  commit 4bcb310c2539b66d535e87508d1b7a90fe29c083
>>  Author: Alexandre Julliard <julliard@winehq.org>
>>  Date:   Fri Nov 24 16:00:13 2006 +0100
>>
>>     fetch-pack: Do not fetch tags for shallow clones.
>>
>>     A better fix may be to only fetch tags that point to commits that we
>>     are downloading, but git-clone doesn't have support for following
>>     tags. This will happen automatically on the next git-fetch though.
>>
>> So it is about making sure that "git clone --depth=1" does not
>> accidentally pull a single commit from v1.0, v1.1, v1.2, and so forth,
>> losing the purpose of using --depth in the first place. These days it is
>> largely irrelevant, since this code path is not followed by clone, and
>> clone will automatically restrict its list of fetched refs to a single
>> branch if --depth is used.
> 
> I think part of the confusion of this code is that inside the loop over
> the refs it is sometimes checking aspects of the ref, and sometimes
> checking invariants of the loop (like args.fetch_all). Splitting it into
> separate loops makes it easier to see what is going on, like the patch
> below (on top of Michael's series).
> 
> I'm not sure if it ends up being more readable, since the generic "cut
> down this linked list" function has to operate through callbacks with a
> void pointer. On the other hand, that function could also be used
> elsewhere.
> 
> diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
> index 90683ca..877cf38 100644
> --- a/builtin/fetch-pack.c
> +++ b/builtin/fetch-pack.c
> @@ -521,51 +521,80 @@ static void mark_recent_complete_commits(unsigned long cutoff)
>  	}
>  }
>  
> -static void filter_refs(struct ref **refs, int *nr_heads, char **heads)
> +static void filter_refs_callback(struct ref **refs,
> +				 int (*want)(struct ref *, void *),
> +				 void *data)
>  {
> -	struct ref *newlist = NULL;
> -	struct ref **newtail = &newlist;
> +	struct ref **tail = refs;
>  	struct ref *ref, *next;
> -	int match_pos = 0, unmatched = 0;
>  
>  	for (ref = *refs; ref; ref = next) {
> -		int keep_ref = 0;
>  		next = ref->next;
> -		if (!memcmp(ref->name, "refs/", 5) &&
> -		    check_refname_format(ref->name, 0))
> -			; /* trash */
> -		else if (args.fetch_all &&
> -			   (!args.depth || prefixcmp(ref->name, "refs/tags/")))
> -			keep_ref = 1;
> -		else
> -			while (match_pos < *nr_heads) {
> -				int cmp = strcmp(ref->name, heads[match_pos]);
> -				if (cmp < 0) { /* definitely do not have it */
> -					break;
> -				} else if (cmp == 0) { /* definitely have it */
> -					free(heads[match_pos++]);
> -					keep_ref = 1;
> -					break;
> -				} else { /* might have it; keep looking */
> -					heads[unmatched++] = heads[match_pos++];
> -				}
> -			}
> -
> -		if (keep_ref) {
> -			*newtail = ref;
> -			ref->next = NULL;
> -			newtail = &ref->next;
> -		} else {
> +		if (want(ref, data))
> +			tail = &ref->next;
> +		else {
>  			free(ref);
> +			*tail = next;
>  		}
>  	}
> +}
>  
> -	/* copy any remaining unmatched heads: */
> -	while (match_pos < *nr_heads)
> -		heads[unmatched++] = heads[match_pos++];
> -	*nr_heads = unmatched;
> +static int ref_name_is_ok(struct ref *ref, void *data)
> +{
> +	return memcmp(ref->name, "refs/", 5) ||
> +		!check_refname_format(ref->name, 0);
> +}
> +
> +static int ref_ok_for_shallow(struct ref *ref, void *data)
> +{
> +	return prefixcmp(ref->name, "refs/tags/");
> +}
>  
> -	*refs = newlist;
> +struct filter_by_name_data {
> +	char **heads;
> +	int nr_heads;
> +	int match_pos;
> +	int unmatched;
> +};
> +
> +static int want_ref_name(struct ref *ref, void *data)
> +{
> +	struct filter_by_name_data *f = data;
> +
> +	while (f->match_pos < f->nr_heads) {
> +		int cmp = strcmp(ref->name, f->heads[f->match_pos]);
> +		if (cmp < 0) /* definitely do not have it */
> +			return 0;
> +		else if (cmp == 0) { /* definitely have it */
> +			free(f->heads[f->match_pos++]);
> +			return 1;
> +		} else /* might have it; keep looking */
> +			f->heads[f->unmatched++] = f->heads[f->match_pos++];
> +	}
> +	return 0;
> +}
> +
> +static void filter_refs(struct ref **refs, int *nr_heads, char **heads)
> +{
> +	struct filter_by_name_data f;
> +
> +	filter_refs_callback(refs, ref_name_is_ok, NULL);
> +
> +	if (args.fetch_all) {
> +		if (args.depth)
> +			filter_refs_callback(refs, ref_ok_for_shallow, NULL);
> +		return;
> +	}
> +
> +	memset(&f, 0, sizeof(f));
> +	f.heads = heads;
> +	f.nr_heads = *nr_heads;
> +	filter_refs_callback(refs, want_ref_name, &f);
> +
> +	/* copy any remaining unmatched heads: */
> +	while (f.match_pos < f.nr_heads)
> +		heads[f.unmatched++] = heads[f.match_pos++];
> +	*nr_heads = f.unmatched;
>  }
>  
>  static void mark_alternate_complete(const struct ref *ref, void *unused)
> 

I need a sanity check here.  I don't see that it is forbidden to call
"git fetch-pack --all --depth=N" and also specify some explicit
references.  (This usage would make it possible for the user to do a
shallow clone while also retrieving some specific tags.)

However, if I try to do this I get (before your change)

    $ git fetch-pack -v --all --depth=1 $URL refs/heads/master
    Server supports multi_ack_detailed
    Server supports side-band-64k
    Server supports ofs-delta
    want 9c9f2f4453a7260d0d60926c73811f025be98ded (HEAD)
    want 9c9f2f4453a7260d0d60926c73811f025be98ded (refs/heads/master)
    done
    remote: Counting objects: 6, done.
    remote: Compressing objects: 100% (4/4), done.
    remote: Total 6 (delta 0), reused 0 (delta 0)
    Unpacking objects: 100% (6/6), done.
    error: no such remote ref refs/heads/master
    9c9f2f4453a7260d0d60926c73811f025be98ded HEAD
    9c9f2f4453a7260d0d60926c73811f025be98ded refs/heads/master

Note the error message "no such remote ref refs/heads/master", which is
incorrect.  This happens because when the (fetch_all && (!depth ||
ref_non_tag(ref))) branch of the if statement succeeds, then the
look-in-heads-list branch is never executed, and therefore the requested
reference is never marked as having been found among the remote references.

On the other hand, if I try the same with an (existing) tag, before your
change I get

    $ git fetch-pack -v --all --depth=1 $URL refs/tags/c
    Server supports multi_ack_detailed
    Server supports side-band-64k
    Server supports ofs-delta
    fatal: The remote end hung up unexpectedly

Now this is obviously broken in git-fetch-pack, because when fetch_all
is specified, return_refs is never initialized, but the
look-in-heads-list branch of the if is executed nevertheless.

It is not hard to fix these problems in the old code: (1)
unconditionally initialize return_refs, and (2) exchange the
look-in-heads-list handling and the fetch_all handling.


After your change the first problem (spurious error when asking for a
head) remains unchanged.  The second problem is changed from a crash to
a misbehavior:

    $ git fetch-pack -v --all --depth=1 $URL refs/tags/c
    Initialized empty Git repository in /home/mhagger/tmp/cl/c/.git/
    Server supports multi_ack_detailed
    Server supports side-band-64k
    Server supports ofs-delta
    want 9c9f2f4453a7260d0d60926c73811f025be98ded (HEAD)
    want 9c9f2f4453a7260d0d60926c73811f025be98ded (refs/heads/master)
    done
    remote: Counting objects: 6, done.
    remote: Compressing objects: 100% (4/4), done.
    remote: Total 6 (delta 0), reused 0 (delta 0)
    Unpacking objects: 100% (6/6), done.
    error: no such remote ref refs/tags/c
    9c9f2f4453a7260d0d60926c73811f025be98ded HEAD
    9c9f2f4453a7260d0d60926c73811f025be98ded refs/heads/master

Note that "refs/tags/c" is not obtained from the remote even though it
was specifically requested.  The reason that your patch makes the crash
disappear is that when fetch_all is true, then the look-in-heads-list
branch is not executed at all -- but this is also why "refs/tags/c" is
not obtained.

So, assuming that we want to support

    git fetch-pack --all --depth=N $URL refs/tags/TAG

correctly, then your filter_refs_callback() refactoring won't work, at
least not the way that you have written it.  I will continue working on
this.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
