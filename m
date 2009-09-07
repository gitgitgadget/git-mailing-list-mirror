From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Issue 323 in msysgit: Can't clone over http
Date: Sun, 06 Sep 2009 21:59:41 -0700
Message-ID: <7v8wgrbb9e.fsf@alter.siamese.dyndns.org>
References: <7viqfzvwf1.fsf@alter.siamese.dyndns.org>
 <0016e6470f36315b8a0472bc75a8@google.com>
 <20090904212956.f02b0c60.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, msysgit@googlegroups.com
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 07 07:00:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MkWKj-0008Im-Cf
	for gcvg-git-2@lo.gmane.org; Mon, 07 Sep 2009 07:00:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753635AbZIGE7v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Sep 2009 00:59:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753232AbZIGE7v
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Sep 2009 00:59:51 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:63873 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753202AbZIGE7u (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Sep 2009 00:59:50 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id AA8FB46847;
	Mon,  7 Sep 2009 00:59:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mWUBZhD2OhvNj6nZ2mLU+C1M48A=; b=OLOl9K
	vrrkEDt70/zVeoB5iVm3qymYPtakYxhR8fL2SYUyGLxGDcBxwVGEmccJfdK0TZTp
	Xq45AMjmWI0+dybdJu5Z8ctaPyxcpwoBu8izvBde7Js8EFuyTFP47HzFoCyJ4B/z
	otOQPU7Q4ahh5Bm8Q3wf+DeqEouNqCccbDO5s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SsDp/v38Q/QgDgf1ORODjzkLCjk8sQgR
	fndpJXChdr802Ail9kZ6gBmgWsa33d3KC7cUCTstGO0tUlE9ymizqIS0y1eww1Xv
	mh+w3Hkg0CoUrlQEY9o1XcztK4keH5o+mABwqRjI2mUEz3qXsg4WNZs28LeDxNbD
	COW8TxIMv80=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8003A46836;
	Mon,  7 Sep 2009 00:59:49 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id DDD9646834; Mon,  7 Sep 2009
 00:59:42 -0400 (EDT)
In-Reply-To: <20090904212956.f02b0c60.rctay89@gmail.com> (Tay Ray Chuan's
 message of "Fri\, 4 Sep 2009 21\:29\:56 +0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 4555A97A-9B6B-11DE-A4C8-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127882>

Tay Ray Chuan <rctay89@gmail.com> writes:

> Subject: [PATCH] http.c: clarify missing-pack-check
>
> Abort the pack transfer only if the pack is not available in the HTTP-
> served repository; otherwise, allow the transfer to continue, even if
> the check failed.
>
> This addresses an issue raised by bjelli:
>
>   http://code.google.com/p/msysgit/issues/detail?id=323
>
> Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
> ---
>  http.c |   10 +++++++---
>  1 files changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/http.c b/http.c
> index 5926c5b..cba7e9a 100644
> --- a/http.c
> +++ b/http.c
> @@ -864,6 +864,7 @@ int http_fetch_ref(const char *base, struct ref *ref)
>  static int fetch_pack_index(unsigned char *sha1, const char *base_url)
>  {
>  	int ret = 0;
> +	int result;
>  	char *hex = xstrdup(sha1_to_hex(sha1));
>  	char *filename;
>  	char *url;
> @@ -874,11 +875,14 @@ static int fetch_pack_index(unsigned char *sha1, const char *base_url)
>  	strbuf_addf(&buf, "objects/pack/pack-%s.pack", hex);
>  	url = strbuf_detach(&buf, 0);
>
> -	if (http_get_strbuf(url, NULL, 0)) {
> -		ret = error("Unable to verify pack %s is available",
> +	result = http_get_strbuf(url, NULL, 0);
> +	if (result == HTTP_MISSING_TARGET) {
> +		ret = error("Unable to find pack %s",
>  			    hex);
>  		goto cleanup;
> -	}
> +	} else if (result && http_is_verbose)
> +		fprintf(stderr, "Unable to verify pack %s is available\n",
> +			hex);
>
>  	if (has_pack_index(sha1)) {
>  		ret = 0;

You said:

> Releases including and after v1.6.4 will have this issue:
>
>>> error: Unable to verify pack 382c25c935b744e909c749532578112d72a4aff9 is
>>> available
>>> error: Unable to find 0a41ac04d56ccc96491989dc71d9875cd804fc6b under
>>> http://github.com/tekkub/addontemplate.git
>
> The issue at hand is due to git checking the http repository for the
> pack file before commencing the transfer; failing which, the transfer
> aborts.
>
> Right now, git chokes on the 500 error that github.com gives it, which
> shouldn't be the case, even though that's a weird response.

I am assuming that you meant 39dc52c was the culprit by "including and
after v1.6.4", but it is not quite clear how this patch helps if that is
the case.

Before 39dc52c (http: use new http API in fetch_index(), 2009-06-06), we
used to run the slot by hand and checked results.curl_request against
CURLE_OK.  Everything else was an error.

With the updated code, that all went to http_get_strbuf() which in turn
calls http_request() that does the same thing, and the function returns
HTTP_OK only when it gets CURLE_OK, but now it says MISSING_TARGET when we
ask for an idx file we think exists in the repository but the server says
it doesn't, and all other errors will be ignored with this patch.

If this codepath is what was broken by github returning 500 [*1*], the
client before 39dc52c would have failed the same way.  I do not think
loosening error checking like this is a real solution, but I may be
reading the patch incorrectly.

Do people on the github side see something strange in the log?  Perhaps we
think we are making a request to objects/pack/ of the repository but by
mistake the request is going to somewhere completely off (but then we
would get 401 not 500).


[Footnote]

*1* Which I do agree is somewhat strange thing to say for a request to a
file in the objects/pack directory in a public repository---I would
understand it if it were 404, but then it means the repository is
inconsistent, i.e. has a stale objects/info/packs relative to its set of
packs it has.
