Return-Path: <SRS0=Lnee=43=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9057EC10F27
	for <git@archiver.kernel.org>; Tue, 10 Mar 2020 17:51:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42DE120727
	for <git@archiver.kernel.org>; Tue, 10 Mar 2020 17:51:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="oO3tjGvr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbgCJRvC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Mar 2020 13:51:02 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64465 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbgCJRvB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Mar 2020 13:51:01 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9E254B33D2;
        Tue, 10 Mar 2020 13:50:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=AQ5SFHjyz1uMBhPOl1nH4r+MUl4=; b=oO3tjG
        vr1/5N4e8EK5fnORE36/EdfWmg4TDDikFy3mFNojQr2XBQAqWLNCYucix55iHFiZ
        v9vvquLL8CFYnaZAwRjESr9jATghASy+rvvPupKWit4WmPjfqCPfTQMGCUIRmjoI
        /g0q0GKC3zXmjWLbGrioyY7i4UDhf8v7hgcSw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=orae5Piy040w45UrB/weB+fnRE+78rK/
        brfyuwmmEprZ4VAeSmZDRXEiqOCMytzlK0yXwqaOLJUTo/yA+3RYQg5mD8YGsm5l
        /HhpPVJ5PCZr72TAdakryGcRVRQUZ5jx++hj6ih2fP8q5/sLsT/3zaXPJJ2ebX2Q
        Ensfbj+FX+Y=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 959B3B33D1;
        Tue, 10 Mar 2020 13:50:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id CFD4AB33D0;
        Tue, 10 Mar 2020 13:50:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Michael J Gruber <git@grubix.eu>,
        Matthieu Moy <git@matthieu-moy.fr>,
        John Keeping <john@keeping.me.uk>,
        Karthik Nayak <karthik.188@gmail.com>,
        Jeff King <peff@peff.net>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH v2 2/3] ref-filter: fix the API to correctly handle CRLF
References: <pull.576.git.1583692184.gitgitgadget@gmail.com>
        <pull.576.v2.git.1583807093.gitgitgadget@gmail.com>
        <aab1f45ba976d088a8c68573a21ed2458915d6a6.1583807093.git.gitgitgadget@gmail.com>
Date:   Tue, 10 Mar 2020 10:50:51 -0700
In-Reply-To: <aab1f45ba976d088a8c68573a21ed2458915d6a6.1583807093.git.gitgitgadget@gmail.com>
        (Philippe Blain via GitGitGadget's message of "Tue, 10 Mar 2020
        02:24:52 +0000")
Message-ID: <xmqqk13sjdz8.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AF7A2466-62F7-11EA-9F78-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Philippe Blain <levraiphilippeblain@gmail.com>
>
> The ref-filter API does not correctly handle commit or tag messages that
> ...

(I won't repeat myself here; see 0/3)

> Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
> ---
>  ref-filter.c             | 19 +++++++++++++++++--
>  t/t3203-branch-output.sh | 26 +++++++++++++++++++++-----
>  t/t6300-for-each-ref.sh  |  5 +++++
>  t/t7004-tag.sh           |  7 +++++++
>  4 files changed, 50 insertions(+), 7 deletions(-)
>
> diff --git a/ref-filter.c b/ref-filter.c
> index 79bb5206783..537cc4de42c 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -1050,10 +1050,18 @@ static char *copy_subject(const char *buf, unsigned long len)
>  {
>  	char *r = xmemdupz(buf, len);
>  	int i;
> +	struct strbuf sb = STRBUF_INIT;
>  
> -	for (i = 0; i < len; i++)
> +	strbuf_attach(&sb, r, len, len + 1);
> +	for (i = 0; i < sb.len; i++) {
>  		if (r[i] == '\n')
>  			r[i] = ' ';
> +		if (r[i] == '\r') {
> +			strbuf_remove(&sb, i, 1);
> +			i -= 1;
> +		}
> +	}
> +	strbuf_detach(&sb, NULL);
>  	return r;
>  }

So, the chosen solution is to only remove CR and do so only in the
first paragraph.  Even if the second and subsequent paragraphs use
CRLF line endings, those CRs are retained.  Also, a lone CR in the
first paragraph that is not part of CRLF end-of-line marker is lost,
but other control characters like "\a" are retained.  That sounds
like an almost "minimum" change but not quite.

The way strbuf is used in the implementation is a bit curious and
risky.  Currently we do not realloc to shrink a strbuf, but when we
start doing so, this code would break because you are relying on the
fact that just before calling strbuf_detach(), sb.buf happens to be
still the same as r.

As the point of the function is "we want to return a copy of what is
in buf[0..len] but the input is a (possibly multi-line) paragraph,
and we want a single line 'title', so replace end-of-line with a
SP", a minimal translation that is more faithful to the intended
meaning of the function would be:

	static char *copy_subject(const char *buf, unsigned long len)
	{
		struct strbuf sb = STRBUF_INIT;

		for (i = 0; i < len; i++) {
                	if (buf[i] == '\r' &&
			    i + 1 < len && buf[i + 1] == '\n')
                            continue; /* ignore CR in CRLF */

			if (buf[i] == '\n')
				strbuf_addch(&sb, ' ');
			else
				strbuf_addch(&sb, buf[i]);
		}
                return strbuf_detach(&sb, NULL);
	}

perhaps?  This retains CR in the middle if exists just like BEL in
the middle of the line, and uses strbuf in a safe way, I think.

> @@ -1184,15 +1192,22 @@ static void find_subpos(const char *buf,
>  		eol = strchrnul(buf, '\n');
>  		if (*eol)
>  			eol++;
> +		/*  protect against messages that might contain \r\n */
> +		if (*eol == '\r')
> +			eol++;

This is quite convoluted.  You found a LF and then are hoping to see
if the byte after LF is CR (i.e. you are looking for LFCR, not
CRLF).

>  		buf = eol;
>  	}
>  	*sublen = buf - *sub;
>  	/* drop trailing newline, if present */
>  	if (*sublen && (*sub)[*sublen - 1] == '\n')
>  		*sublen -= 1;
> +	/*  protect against commit messages that might contain \r\n */
> +	else if (*sublen && (*sub)[*sublen - 1] == '\r')
> +		*sublen -= 3; /* drop '\r\n\r' */

Yeek.  To find CR-LF-CR-LF, you look for CR-LF-CR?  You only checked
that the previous byte is NOT LF (because you are in else-if, so the
previous if must have failed) and you have at least one previous byte
that is CR.  What gives us OK that *sublen is sufficiently long that
we can safely subtract 3 from it (we only checked that it is not 0;
who says it is 3 or more in this code???) and the two bytes before
the CR we are looking at here are CRLF???
