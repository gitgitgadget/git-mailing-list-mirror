From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] remote-curl: let users turn off smart http
Date: Fri, 21 Sep 2012 10:34:22 -0700
Message-ID: <7vmx0j700x.fsf@alter.siamese.dyndns.org>
References: <20120920165938.GB18655@sigill.intra.peff.net>
 <20120920170517.GB18981@sigill.intra.peff.net>
 <7va9wkbmyc.fsf@alter.siamese.dyndns.org>
 <20120920181231.GA19204@sigill.intra.peff.net>
 <7vzk4ka6dp.fsf@alter.siamese.dyndns.org>
 <20120920205107.GB22284@sigill.intra.peff.net>
 <7vd31g9z13.fsf@alter.siamese.dyndns.org>
 <20120920213058.GA23904@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Sep 21 19:34:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TF77d-0000NF-5j
	for gcvg-git-2@plane.gmane.org; Fri, 21 Sep 2012 19:34:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932212Ab2IURe2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Sep 2012 13:34:28 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62836 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932087Ab2IUReZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Sep 2012 13:34:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 991799B46;
	Fri, 21 Sep 2012 13:34:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sI53l0n2u/HHym+qfHl1aj9R8Z4=; b=Q+NZkr
	wfMxM7kiBNQs6PE0zAx986TW9bF29pzQ8IokJ3JbwKq/H6zuNP5m1jmX54vI6Q1L
	d8KZwLCN0+AHATWZuqVz2dCpRhzRaN/D//ehzR7Q5Py+88vMiJfhUJfqCjYpOwxe
	R/83RD5LCDPWMhVxIOPZpuhIaezM5NtvXrO3A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pb+MKrJSDMQW4FjzYsLm38NygCVSfWfY
	vdSgiU2s/Zjv9w8+Aphtuj9A+ZbodPDeOVaA7PShHfrShGv4ojPJC7O+GK9OeyNQ
	i+CRC/+oNrIX76dT3IONrhmou+cuokiV4ImBVhhh+97EobMF2iIAWkNGJg72rI+O
	EqpFFaVxrKo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 85ABA9B45;
	Fri, 21 Sep 2012 13:34:24 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B72B99B41; Fri, 21 Sep 2012
 13:34:23 -0400 (EDT)
In-Reply-To: <20120920213058.GA23904@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 20 Sep 2012 17:30:58 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 956FAEA2-0412-11E2-9916-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206141>

Jeff King <peff@peff.net> writes:

> On Thu, Sep 20, 2012 at 02:15:20PM -0700, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>> 
>> > I'm half-tempted to just drop the config entirely, leave
>> > GIT_SMART_HTTP=false as an escape hatch, and see if anybody even cares.
>> 
>> Sounds like a very attractive minimalistic way to go forward.  We
>> can always add per-remote configuration when we find it necessary,
>> but once we add support, we cannot easily yank it out.
>
> Like this?

Yeah.  Will queue this one instead.  The simpler, the better ;-)

>
> -- >8 --
> Subject: [PATCH] remote-curl: let users turn off smart http
>
> Usually there is no need for users to specify whether an
> http remote is smart or dumb; the protocol is designed so
> that a single initial request is made, and the client can
> determine the server's capability from the response.
>
> However, some misconfigured dumb-only servers may not like
> the initial request by a smart client, as it contains a
> query string. Until recently, commit 703e6e7 worked around
> this by making a second request. However, that commit was
> recently reverted due to its side effect of masking the
> initial request's error code.
>
> Since git has had that workaround for several years, we
> don't know exactly how many such misconfigured servers are
> out there. The reversion of 703e6e7 assumes they are rare
> enough not to worry about. Still, that reversion leaves
> somebody who does run into such a server with no escape
> hatch at all. Let's give them an environment variable they
> can tweak to perform the "dumb" request.
>
> This is intentionally not a documented interface. It's
> overly simple and is really there for debugging in case
> somebody does complain about git not working with their
> server. A real user-facing interface would entail a
> per-remote or per-URL config variable.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  remote-curl.c         |  3 ++-
>  t/t5551-http-fetch.sh | 12 ++++++++++++
>  2 files changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/remote-curl.c b/remote-curl.c
> index c0b98cc..7b19ebb 100644
> --- a/remote-curl.c
> +++ b/remote-curl.c
> @@ -102,7 +102,8 @@ static struct discovery* discover_refs(const char *service)
>  	free_discovery(last);
>  
>  	strbuf_addf(&buffer, "%sinfo/refs", url);
> -	if (!prefixcmp(url, "http://") || !prefixcmp(url, "https://")) {
> +	if ((!prefixcmp(url, "http://") || !prefixcmp(url, "https://")) &&
> +	     git_env_bool("GIT_SMART_HTTP", 1)) {
>  		maybe_smart = 1;
>  		if (!strchr(url, '?'))
>  			strbuf_addch(&buffer, '?');
> diff --git a/t/t5551-http-fetch.sh b/t/t5551-http-fetch.sh
> index 2db5c35..8427943 100755
> --- a/t/t5551-http-fetch.sh
> +++ b/t/t5551-http-fetch.sh
> @@ -129,6 +129,18 @@ test_expect_success 'clone from auth-only-for-push repository' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'disable dumb http on server' '
> +	git --git-dir="$HTTPD_DOCUMENT_ROOT_PATH/repo.git" \
> +		config http.getanyfile false
> +'
> +
> +test_expect_success 'GIT_SMART_HTTP can disable smart http' '
> +	(GIT_SMART_HTTP=0 &&
> +	 export GIT_SMART_HTTP &&
> +	 cd clone &&
> +	 test_must_fail git fetch)
> +'
> +
>  test -n "$GIT_TEST_LONG" && test_set_prereq EXPENSIVE
>  
>  test_expect_success EXPENSIVE 'create 50,000 tags in the repo' '
