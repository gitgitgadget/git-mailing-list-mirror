From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 2/7] show: obey --textconv for blobs
Date: Tue, 23 Apr 2013 08:14:01 -0700
Message-ID: <7va9opl1om.fsf@alter.siamese.dyndns.org>
References: <517298D4.3030802@drmicha.warpmail.net>
	<c631e41a9f9b02f1ad5e40dd4bcaf18670b27c59.1366718624.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Matthieu.Moy@grenoble-inp.fr,
	jeremy.rosen@openwide.fr, Jeff King <peff@peff.net>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Apr 23 17:14:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUevF-0007lH-Da
	for gcvg-git-2@plane.gmane.org; Tue, 23 Apr 2013 17:14:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756624Ab3DWPOP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Apr 2013 11:14:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43115 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755887Ab3DWPOO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Apr 2013 11:14:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5659C192A3;
	Tue, 23 Apr 2013 15:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9cdc5YEHdZV+CuJouWtnAp5ADNo=; b=GPtgC9
	7ymQD+3/gtJ7sdUgg9Muv03GNnzU4A83A/0cgmTk3KJZrEQqyrNHW5Iru/QANFQc
	T+8ak7u6RAICv8tBOsKyiDN+G2LKrqPpjeCXQ+choynZ4gsbeWkBYM2v8a3BAejP
	D5i0zdCgd/FZ1MO7i9a+ntvC+uwGPfWpgtS+U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RyJjoVQfYxwCX4QKeeYkuWOR5tJM1the
	v8uoKIw0W/WKGaNn2Yd4a7ya4joecKI1aPe/2rvUsiMDusd18qKpB7cjM+QMDbxY
	ZEVBP/FcARN2ZUOdY6btBsa2S2ajXlUc59A2pgx9KzsCHRr27Gkx4duRYqD6n2w8
	lOJSxRP1BRo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4B967192A2;
	Tue, 23 Apr 2013 15:14:14 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7F63619299;
	Tue, 23 Apr 2013 15:14:13 +0000 (UTC)
In-Reply-To: <c631e41a9f9b02f1ad5e40dd4bcaf18670b27c59.1366718624.git.git@drmicha.warpmail.net>
	(Michael J. Gruber's message of "Tue, 23 Apr 2013 14:11:54 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 74F2E8C4-AC28-11E2-AF59-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222174>

Michael J Gruber <git@drmicha.warpmail.net> writes:

>> Subject: Re: [PATCHv2 2/7] show: obey --textconv for blobs

s/obey/honor/;

> Currently, "diff" and "cat-file" for blobs honor "--textconv" options
> (with the former defaulting to "--textconv" and the latter to
> "--no-textconv") whereas "show" does not honor this option, even though
> it takes diff options.
>
> Make "show" on blobs behave like "diff", i.e. honor "--textconv" by
> default and "--no-textconv" when given.

It is the right thing to do to teach it to react to --[no-]textconv;
I am not sure if the default is right, though.

> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> ---
>  builtin/log.c            | 24 +++++++++++++++++++++---
>  t/t4030-diff-textconv.sh |  8 +++++++-
>  2 files changed, 28 insertions(+), 4 deletions(-)
>
> diff --git a/builtin/log.c b/builtin/log.c
> index 5f3ed77..fe0275e 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -436,10 +436,28 @@ static void show_tagger(char *buf, int len, struct rev_info *rev)
>  	strbuf_release(&out);
>  }
>  
> -static int show_blob_object(const unsigned char *sha1, struct rev_info *rev)
> +static int show_blob_object(const unsigned char *sha1, struct rev_info *rev, const char *obj_name)
>  {
> +	unsigned char sha1c[20];
> +	struct object_context obj_context;
> +	char *buf;
> +	unsigned long size;
> +
>  	fflush(stdout);
> -	return stream_blob_to_fd(1, sha1, NULL, 0);
> +	if (!DIFF_OPT_TST(&rev->diffopt, ALLOW_TEXTCONV))
> +		return stream_blob_to_fd(1, sha1, NULL, 0);
> +
> +	if (get_sha1_with_context(obj_name, 0, sha1c, &obj_context))
> +		die("Not a valid object name %s", obj_name);
> +	if (!obj_context.path[0] ||
> +	    !textconv_object(obj_context.path, obj_context.mode, sha1c, 1, &buf, &size))
> +		return stream_blob_to_fd(1, sha1, NULL, 0);
> +
> +	if (!buf)
> +		die("git show %s: bad file", obj_name);
> +
> +	write_or_die(1, buf, size);
> +	return 0;
>  }
>  
>  static int show_tag_object(const unsigned char *sha1, struct rev_info *rev)
> @@ -525,7 +543,7 @@ int cmd_show(int argc, const char **argv, const char *prefix)
>  		const char *name = objects[i].name;
>  		switch (o->type) {
>  		case OBJ_BLOB:
> -			ret = show_blob_object(o->sha1, NULL);
> +			ret = show_blob_object(o->sha1, &rev, name);
>  			break;
>  		case OBJ_TAG: {
>  			struct tag *t = (struct tag *)o;
> diff --git a/t/t4030-diff-textconv.sh b/t/t4030-diff-textconv.sh
> index 260ea92..f9d55e1 100755
> --- a/t/t4030-diff-textconv.sh
> +++ b/t/t4030-diff-textconv.sh
> @@ -90,12 +90,18 @@ test_expect_success 'status -v produces text' '
>  	git reset --soft HEAD@{1}
>  '
>  
> -test_expect_failure 'show blob produces text' '
> +test_expect_success 'show blob produces text' '
>  	git show HEAD:file >actual &&
>  	printf "0\\n1\\n" >expect &&
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'show --no-textconv blob produces binary' '
> +	git show --no-textconv HEAD:file >actual &&
> +	printf "\\0\\n\\1\\n" >expect &&
> +	test_cmp expect actual
> +'
> +
>  test_expect_success 'grep-diff (-G) operates on textconv data (add)' '
>  	echo one >expect &&
>  	git log --root --format=%s -G0 >actual &&
