From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH V3 1/2] fetch --prune: Always print header url
Date: Fri, 03 Jan 2014 10:17:46 -0800
Message-ID: <xmqqk3ehlyk5.fsf@gitster.dls.corp.google.com>
References: <1388716132-71437-1-git-send-email-jackerran@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Tom Miller <jackerran@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 03 19:18:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vz9Js-0000n9-Pg
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jan 2014 19:18:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752446AbaACSSA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jan 2014 13:18:00 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62193 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751039AbaACSR7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jan 2014 13:17:59 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7DFA35CEBD;
	Fri,  3 Jan 2014 13:17:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bz/Wut+6XX8RVu49FRFBNutOVSY=; b=wjONp/
	zGKLZ5gdKk0sfmbgnkUdxB+tlhenKMbX0UvBpqev5/x7KMTcqMpTqS50mv+rNlbv
	XX7OsMm/9AA++kFSBLNODLwaN9llMG7MT09jjoZ33KIbY50rQ5D2fft3MhIiuw7x
	nu9ioK+hP8g+fg9j6MdxudHRtwGCilbt5luf0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NkR3BWKOWFC6cv7cXsOSmDdrv6Hm4H2m
	qZvj/4X0K3ho8wLMnkYwTt4ubVg/sZYRFwN6Z/h0N9PuM1P5CimIfVu5hVy2XKM6
	5wyXIQLS1QnHTFrgp6/T0YTWnhTj+6wMs2rf0PVbEowX488+VKglZB2EgUknW6q7
	SrqNI78cVuc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DB5685CEBB;
	Fri,  3 Jan 2014 13:17:50 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 12A375CEBA;
	Fri,  3 Jan 2014 13:17:48 -0500 (EST)
In-Reply-To: <1388716132-71437-1-git-send-email-jackerran@gmail.com> (Tom
	Miller's message of "Thu, 2 Jan 2014 20:28:51 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 5A118620-74A3-11E3-99F3-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239922>

Tom Miller <jackerran@gmail.com> writes:

> If "fetch --prune" is run with no new refs to fetch, but it has refs
> to prune. Then, the header url is not printed as it would if there were
> new refs to fetch.
>
> Output before this patch:
>
> 	$ git fetch --prune remote-with-no-new-refs
> 	 x [deleted]         (none)     -> origin/world
>
> Output after this patch:
>
> 	$ git fetch --prune remote-with-no-new-refs
> 	From https://github.com/git/git
> 	 x [deleted]         (none)     -> origin/test
>
> Signed-off-by: Tom Miller <jackerran@gmail.com>

And (needless to say) when there are refs to be fetched and also
pruned, the "shown_url" logic prevents us from giving two identical
headers "From <there>".  Sounds sane.

> ---
>
> I decided it is not worth writing a function to format the header url
> that is printed by fetch. Instead, I will duplicate the formatting logic
> for now because I plan on following up this patch set with another patch
> to stop striping the trailing "/" and ".git" from the url. When that
> patch is finished it will remove the majority of the duplicated logic.

OK, let's see how it goes.

Will replace what has been queued on 'pu'.  The incremental change
relative to the old one looked sensible and I think this one is
ready for 'next'.

Thanks.


>  builtin/fetch.c  | 32 +++++++++++++++++++++++++++-----
>  t/t5510-fetch.sh | 12 ++++++++++++
>  2 files changed, 39 insertions(+), 5 deletions(-)
>
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index 1e7d617..1b81cf9 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -44,6 +44,7 @@ static struct transport *gtransport;
>  static struct transport *gsecondary;
>  static const char *submodule_prefix = "";
>  static const char *recurse_submodules_default;
> +static int shown_url = 0;
>  
>  static int option_parse_recurse_submodules(const struct option *opt,
>  				   const char *arg, int unset)
> @@ -535,7 +536,7 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
>  {
>  	FILE *fp;
>  	struct commit *commit;
> -	int url_len, i, shown_url = 0, rc = 0;
> +	int url_len, i, rc = 0;
>  	struct strbuf note = STRBUF_INIT;
>  	const char *what, *kind;
>  	struct ref *rm;
> @@ -708,17 +709,36 @@ static int fetch_refs(struct transport *transport, struct ref *ref_map)
>  	return ret;
>  }
>  
> -static int prune_refs(struct refspec *refs, int ref_count, struct ref *ref_map)
> +static int prune_refs(struct refspec *refs, int ref_count, struct ref *ref_map,
> +		const char *raw_url)
>  {
> -	int result = 0;
> +	int url_len, i, result = 0;
>  	struct ref *ref, *stale_refs = get_stale_heads(refs, ref_count, ref_map);
> +	char *url;
>  	const char *dangling_msg = dry_run
>  		? _("   (%s will become dangling)")
>  		: _("   (%s has become dangling)");
>  
> +	if (raw_url)
> +		url = transport_anonymize_url(raw_url);
> +	else
> +		url = xstrdup("foreign");
> +
> +	url_len = strlen(url);
> +	for (i = url_len - 1; url[i] == '/' && 0 <= i; i--)
> +		;
> +
> +	url_len = i + 1;
> +	if (4 < i && !strncmp(".git", url + i - 3, 4))
> +		url_len = i - 3;
> +
>  	for (ref = stale_refs; ref; ref = ref->next) {
>  		if (!dry_run)
>  			result |= delete_ref(ref->name, NULL, 0);
> +		if (verbosity >= 0 && !shown_url) {
> +			fprintf(stderr, _("From %.*s\n"), url_len, url);
> +			shown_url = 1;
> +		}
>  		if (verbosity >= 0) {
>  			fprintf(stderr, " x %-*s %-*s -> %s\n",
>  				TRANSPORT_SUMMARY(_("[deleted]")),
> @@ -726,6 +746,7 @@ static int prune_refs(struct refspec *refs, int ref_count, struct ref *ref_map)
>  			warn_dangling_symref(stderr, dangling_msg, ref->name);
>  		}
>  	}
> +	free(url);
>  	free_refs(stale_refs);
>  	return result;
>  }
> @@ -854,11 +875,12 @@ static int do_fetch(struct transport *transport,
>  		 * don't care whether --tags was specified.
>  		 */
>  		if (ref_count) {
> -			prune_refs(refs, ref_count, ref_map);
> +			prune_refs(refs, ref_count, ref_map, transport->url);
>  		} else {
>  			prune_refs(transport->remote->fetch,
>  				   transport->remote->fetch_refspec_nr,
> -				   ref_map);
> +				   ref_map,
> +				   transport->url);
>  		}
>  	}
>  	free_refs(ref_map);
> diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
> index 5d4581d..87e896d 100755
> --- a/t/t5510-fetch.sh
> +++ b/t/t5510-fetch.sh
> @@ -614,4 +614,16 @@ test_expect_success 'all boundary commits are excluded' '
>  	test_bundle_object_count .git/objects/pack/pack-${pack##pack	}.pack 3
>  '
>  
> +test_expect_success 'fetch --prune prints the remotes url' '
> +	git branch goodbye &&
> +	git clone . only-prunes &&
> +	git branch -D goodbye &&
> +	(
> +		cd only-prunes &&
> +		git fetch --prune origin 2>&1 | head -n1 >../actual
> +	) &&
> +	echo "From ${D}/." >expect &&
> +	test_cmp expect actual
> +'
> +
>  test_done
