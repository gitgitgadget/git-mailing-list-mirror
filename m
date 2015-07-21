From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v8 1/7] refs.c: add err arguments to reflog functions
Date: Tue, 21 Jul 2015 06:17:16 -0700
Message-ID: <55AE465C.6000905@alum.mit.edu>
References: <1436482260-28088-1-git-send-email-dturner@twopensource.com> <1436482260-28088-2-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: David Turner <dturner@twopensource.com>, git@vger.kernel.org,
	j6t@kdbg.org
X-From: git-owner@vger.kernel.org Tue Jul 21 15:17:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZHXQP-0004vB-VQ
	for gcvg-git-2@plane.gmane.org; Tue, 21 Jul 2015 15:17:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752336AbbGUNRd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jul 2015 09:17:33 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:43491 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751219AbbGUNRc (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Jul 2015 09:17:32 -0400
X-AuditID: 1207440f-f79df6d000007c0f-9e-55ae465fd8a6
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id FD.BC.31759.F564EA55; Tue, 21 Jul 2015 09:17:19 -0400 (EDT)
Received: from [172.20.208.234] ([66.251.117.141])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t6LDHG53005765
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 21 Jul 2015 09:17:17 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.7.0
In-Reply-To: <1436482260-28088-2-git-send-email-dturner@twopensource.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJKsWRmVeSWpSXmKPExsUixO6iqBvvti7UYFcXh8X8TScYLbqudDNZ
	PJl7l9ni34QaBxaPBZtKPR6+6mL3WPD8PrvH501yASxR3DZJiSVlwZnpefp2CdwZR5s+sxX0
	y1X8mzuPuYGxWbyLkZNDQsBEYuL1NnYIW0ziwr31bCC2kMBlRokr+0S7GLmA7E1MEps2r2YC
	SfAKaEvMWvcdrIhFQFXi/LV7zCA2m4CuxKKeZqAaDg5RgSCJ1y9zIcoFJU7OfMICYosI+Els
	65rDCGIzC2hKbNrwghXEFhbwlHjw7C8jxK5WRomZP1eAzecESjxsucIG0aAnseP6L1YIW16i
	eets5gmMArOQ7JiFpGwWkrIFjMyrGOUSc0pzdXMTM3OKU5N1i5MT8/JSi3RN9HIzS/RSU0o3
	MUKCmX8HY9d6mUOMAhyMSjy8F9rWhgqxJpYVV+YeYpTkYFIS5dU3WhcqxJeUn1KZkVicEV9U
	mpNafIhRgoNZSYT3iz1QjjclsbIqtSgfJiXNwaIkzqu+RN1PSCA9sSQ1OzW1ILUIJivDwaEk
	wSvqCtQoWJSanlqRlplTgpBm4uAEGc4lJVKcmpeSWpRYWpIRD4rU+GJgrIKkeID2qoG08xYX
	JOYCRSFaTzEqSonzKoIkBEASGaV5cGNhKeoVozjQl8K85SBVPMD0Btf9CmgwE9DgW7PWgAwu
	SURISTUwrnza2Rjj07HWRveu7vSCgtyGfb52my4prHKPNF/9JWSaRteOhjevTT6W5jDzX2W9
	/1Lq6oVvRkd56o9nbd3auuCeO5fRvtkPr1ywemnIcrdWXZh1q+khtkt1R1f+U3gk 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274374>

On 07/09/2015 03:50 PM, David Turner wrote:
> Add an err argument to log_ref_setup that can explain the reason
> for a failure. This then eliminates the need to manage errno through
> this function since we can just add strerror(errno) to the err string
> when meaningful. No callers relied on errno from this function for
> anything else than the error message.
> 
> Also add err arguments to private functions write_ref_to_lockfile,
> log_ref_write_1, commit_ref_update. This again eliminates the need to
> manage errno in these functions.
> 
> Some error messages are slightly reordered.
> 
> Update of a patch by Ronnie Sahlberg.
> 
> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
> Signed-off-by: David Turner <dturner@twopensource.com>
> ---
>  builtin/checkout.c |   8 ++--
>  refs.c             | 127 +++++++++++++++++++++++++++++++----------------------
>  refs.h             |   4 +-
>  3 files changed, 81 insertions(+), 58 deletions(-)
> 
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index c018ab3..93f63d3 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -624,16 +624,18 @@ static void update_refs_for_switch(const struct checkout_opts *opts,
>  				struct strbuf log_file = STRBUF_INIT;
>  				int ret;
>  				const char *ref_name;
> +				struct strbuf err = STRBUF_INIT;
>  
>  				ref_name = mkpath("refs/heads/%s", opts->new_orphan_branch);
>  				temp = log_all_ref_updates;
>  				log_all_ref_updates = 1;
> -				ret = log_ref_setup(ref_name, &log_file);
> +				ret = log_ref_setup(ref_name, &log_file, &err);
>  				log_all_ref_updates = temp;
>  				strbuf_release(&log_file);
>  				if (ret) {
> -					fprintf(stderr, _("Can not do reflog for '%s'\n"),
> -					    opts->new_orphan_branch);
> +					fprintf(stderr, _("Can not do reflog for '%s'. %s\n"),
> +						opts->new_orphan_branch, err.buf);

Our usual pattern for chaining error messages is

    $problem: $reason

In this patch (and maybe later patches too? I haven't checked yet) I see

    $problem. $reason

and also

    $problem. '$reason'

I think it would be good to use the first pattern consistently.

> +					strbuf_release(&err);
>  					return;
>  				}
>  			}
> diff --git a/refs.c b/refs.c
> index fb568d7..03e7505 100644
> --- a/refs.c
> +++ b/refs.c
> [...]
> @@ -3247,25 +3247,28 @@ int is_branch(const char *refname)
>  
>  /*
>   * Write sha1 into the open lockfile, then close the lockfile. On
> - * errors, rollback the lockfile and set errno to reflect the problem.
> + * errors, rollback the lockfile, fill in *err and
> + * return -1.
>   */
>  static int write_ref_to_lockfile(struct ref_lock *lock,
> -				 const unsigned char *sha1)
> +				 const unsigned char *sha1, struct strbuf *err)
>  {
>  	static char term = '\n';
>  	struct object *o;
>  
>  	o = parse_object(sha1);
>  	if (!o) {
> -		error("Trying to write ref %s with nonexistent object %s",
> -			lock->ref_name, sha1_to_hex(sha1));
> +		strbuf_addf(err,
> +			    "Trying to write ref %s with nonexistent object %s",
> +			    lock->ref_name, sha1_to_hex(sha1));
>  		unlock_ref(lock);
>  		errno = EINVAL;

Is it intentional that this function is still setting errno (here and a
few lines farther down)? I'm guessing that this is no longer needed,
though I haven't audited the callers.

>  		return -1;
>  	}
>  	if (o->type != OBJ_COMMIT && is_branch(lock->ref_name)) {
> -		error("Trying to write non-commit object %s to branch %s",
> -			sha1_to_hex(sha1), lock->ref_name);
> +		strbuf_addf(err,
> +			    "Trying to write non-commit object %s to branch %s",
> +			    sha1_to_hex(sha1), lock->ref_name);
>  		unlock_ref(lock);
>  		errno = EINVAL;
>  		return -1;
> [...]

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
