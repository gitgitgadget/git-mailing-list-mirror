Return-Path: <SRS0=LF8V=6I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BD37C54FCB
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 20:38:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 738B42098B
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 20:38:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="eB3B3low"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726032AbgDXUi5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Apr 2020 16:38:57 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58663 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbgDXUi5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Apr 2020 16:38:57 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E7287D5866;
        Fri, 24 Apr 2020 16:38:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=STH+hqQj9U8L2Whqf7DtRyjxhhU=; b=eB3B3l
        owBHMSmFq8+Sn+hJcZ2uiMsqYq9asXlZoi+DkFmsSTnZt2LSgOmWsIAPi0YTbhVm
        IO0GOpqHa8jXDJjXiEHxmT/Hwi7CzWRxuo/1m14vdvFk878TthuSskH2a2y9/EnW
        t4QRMaULAYPGxRno4YCQxY9QkgGMpUyL4j8Lw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=laTx+5M6GUy0+2S9xHZI6fAC3aXoZVM5
        HsYHIHUaoW5W8FKUVdq6Lq49LyKRaGC7UwjODTzubp4iCg5tcE6mwVrwVVVpdUpD
        gs42128shW/gwcdwu4u4bDGV80JVWyUD4yonO0Z1rQUbffW8Eg8i6w3+4haV8MzI
        RdbbwIU8LLA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DE44CD5865;
        Fri, 24 Apr 2020 16:38:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 27AA2D5861;
        Fri, 24 Apr 2020 16:38:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] push: anonymize URLs in error messages and warnings
References: <pull.618.git.1587738008248.gitgitgadget@gmail.com>
Date:   Fri, 24 Apr 2020 13:38:52 -0700
In-Reply-To: <pull.618.git.1587738008248.gitgitgadget@gmail.com> (Johannes
        Schindelin via GitGitGadget's message of "Fri, 24 Apr 2020 14:20:08
        +0000")
Message-ID: <xmqqtv18bov7.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9CFEA45A-866B-11EA-97B1-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

>  builtin/push.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Is this something we can protect with a test?  perhaps like 882d49ca
(push: anonymize URL in status output, 2016-07-13) did?

> diff --git a/builtin/push.c b/builtin/push.c
> index 6dbf0f0bb71..bd2a2cbfbd7 100644
> --- a/builtin/push.c
> +++ b/builtin/push.c
> @@ -340,6 +340,7 @@ static int push_with_options(struct transport *transport, struct refspec *rs,
>  {
>  	int err;
>  	unsigned int reject_reasons;
> +	char *anon_url = transport_anonymize_url(transport->url);

Do we need to anonymize this early, way before we know we'd fail the
push?  It wouldn't be that transport->url is going to be munged
before we realize that we have to issue an error message---otherwise
you'd not be writing a patch to replace transport->url in the error
message.  So this placement of anonymize call sounds like taking the
error path as the main flow of control.

In other words, would it break to squash the following change in?

 builtin/push.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/push.c b/builtin/push.c
index bd2a2cbfbd..b88948b07e 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -340,7 +340,6 @@ static int push_with_options(struct transport *transport, struct refspec *rs,
 {
 	int err;
 	unsigned int reject_reasons;
-	char *anon_url = transport_anonymize_url(transport->url);
 
 	transport_set_verbosity(transport, verbosity, progress);
 	transport->family = family;
@@ -364,13 +363,14 @@ static int push_with_options(struct transport *transport, struct refspec *rs,
 			     rs, flags, &reject_reasons);
 	trace2_region_leave("push", "transport_push", the_repository);
 	if (err != 0) {
+		char *anon_url = transport_anonymize_url(transport->url);
 		fprintf(stderr, "%s", push_get_color(PUSH_COLOR_ERROR));
 		error(_("failed to push some refs to '%s'"), anon_url);
 		fprintf(stderr, "%s", push_get_color(PUSH_COLOR_RESET));
+		free(anon_url);
 	}
 
 	err |= transport_disconnect(transport);
-	free(anon_url);
 	if (!err)
 		return 0;
 
