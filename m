Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0189C433B4
	for <git@archiver.kernel.org>; Fri, 16 Apr 2021 19:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD9ED611AF
	for <git@archiver.kernel.org>; Fri, 16 Apr 2021 19:21:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242934AbhDPTWD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Apr 2021 15:22:03 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52053 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239187AbhDPTWB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Apr 2021 15:22:01 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0AF20CF3B7;
        Fri, 16 Apr 2021 15:21:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=S4utfwvHzDtpx8uAkrjrrSulJcM=; b=o2wnFd
        BhQO3TAOyIEtndk72Kin7u+7GKcrASpTyUu1LGY9Qc0pq4BIkyEV6koju2o3FV0r
        MlrYqmJfLk29pr3akBiMqqcP4LB+VQu7s33DctxPRqq43FEiL27JnhkClaEve1Mn
        8WevZ/4N73ZCDYDIe7ojY1+wlLPSBpYYeZ9iE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ZaqGH4Xjm6DiBi6hWzS3ytHcm3lkhfud
        1cb+G0e5YcDPMoviV2xTwSSnWOXkcoSAhZTqwE8mOEnBIP2ejNHyhV6DrKDiRPu1
        a8WO6WTScURa31juz3vdYsL452kxri2fJs+ajJPz5VZN8C0ffJzmo41brRidhdaz
        N10BRjpr3Ec=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 02180CF3B6;
        Fri, 16 Apr 2021 15:21:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 84A32CF3B5;
        Fri, 16 Apr 2021 15:21:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH v10 2/2] [GSOC] trailer: add new .cmd config option
References: <pull.913.v9.git.1618245568.gitgitgadget@gmail.com>
        <pull.913.v10.git.1618562875.gitgitgadget@gmail.com>
        <daa889bd0ade1111eb8b1471fe7e953fcb41d12b.1618562875.git.gitgitgadget@gmail.com>
Date:   Fri, 16 Apr 2021 12:21:34 -0700
In-Reply-To: <daa889bd0ade1111eb8b1471fe7e953fcb41d12b.1618562875.git.gitgitgadget@gmail.com>
        (ZheNing Hu via GitGitGadget's message of "Fri, 16 Apr 2021 08:47:55
        +0000")
Message-ID: <xmqqy2dikpc1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F5A2FADE-9EE8-11EB-B16E-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Introduce a new `trailer.<token>.cmd` configuration that
> takes higher precedence to deprecate and eventually remove
> `trailer.<token>.command`, which passes the value as an
> argument to the command.  Instead of "$ARG", users can
> refer to the value as positional argument, $1, in their
> scripts. At the same time, in order to allow
> `git interpret-trailers` to better simulate the behavior
> of `git command -s`, 'trailer.<token>.cmd' will not
> automatically execute.

OK.  I think there still will be disagreement on this last point
between Christian and I, but I'd be happy with this as the first cut
for newly introduced .cmd and then when it becomes needed add
something like the attached patch on top to optionally run the given
command when configured.


 trailer.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git c/trailer.c w/trailer.c
index 7c7cb61a94..39132211cc 100644
--- c/trailer.c
+++ w/trailer.c
@@ -723,7 +723,8 @@ static void process_command_line_args(struct list_head *arg_head,
 	/* Add an arg item for each configured trailer with a command */
 	list_for_each(pos, &conf_head) {
 		item = list_entry(pos, struct arg_item, list);
-		if (item->conf.command)
+		if ((item->conf.run_implicitly && item->conf.cmd) ||
+		    item->conf.command)
 			add_arg_item(arg_head,
 				     xstrdup(token_from_item(item, NULL)),
 				     xstrdup(""),

