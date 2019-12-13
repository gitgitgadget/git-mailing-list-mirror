Return-Path: <SRS0=h4OP=2D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2245FC43603
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 21:06:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CED824686
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 21:06:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ATXy+xA5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbfLMVGg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Dec 2019 16:06:36 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59134 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726141AbfLMVGf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Dec 2019 16:06:35 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C08C4A840F;
        Fri, 13 Dec 2019 16:06:34 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=NdYolyQP/BPu6/ZTPmGf/uQLjW8=; b=ATXy+x
        A5AEaFVTnigxUuhLs2tQ6Bqyrmveout01uvNiTyi1R/NeMO2N/7LfFq65pNSbxjO
        2g5cI9AmQBxn64ouqi93xAbdblVEZ4AiDzO3nOAdOqeA93uDSwU0/GUQUTEJt2kx
        mb+0704rI9oYmFGj4LQgSokGLiYTMSlRJpHYo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wRIGu2AOVGM9/QXmesHhAu/r7/qGytYM
        B3S+ckes4iqgLVWJ8oJlGZ3fgCccmVsNs+wPs0QUQF4V3eej6nvS7A9KhisizUvQ
        BfCW3icsTNBYh3K4+ulfD+nMWQy8OcVrubJR0wtRwGY8IdfmItnB6YUG8Vip9CJ+
        x8JmKfwgzIs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B8923A840E;
        Fri, 13 Dec 2019 16:06:34 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D4535A840D;
        Fri, 13 Dec 2019 16:06:31 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v4 03/15] bugreport: gather git version and build info
References: <20191213004312.169753-1-emilyshaffer@google.com>
        <20191213004312.169753-4-emilyshaffer@google.com>
Date:   Fri, 13 Dec 2019 13:06:29 -0800
In-Reply-To: <20191213004312.169753-4-emilyshaffer@google.com> (Emily
        Shaffer's message of "Thu, 12 Dec 2019 16:43:00 -0800")
Message-ID: <xmqqr218hr56.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 701FAF3E-1DEC-11EA-86E0-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> Knowing which version of Git a user has and how it was built allows us
> to more precisely pin down the circumstances when a certain issue
> occurs, so teach bugreport how to tell us the same output as 'git
> version --build-options'.
>
> It's not ideal to directly call 'git version --build-options' because
> that output goes to stdout. Instead, wrap the version string in a helper
> within help.[ch] library, and call that helper from within the bugreport
> library.

Move to strbuf() from stdio makes sense.  

> +	// add other contents

Style.

> diff --git a/help.h b/help.h
> index 9071894e8c..54f6b5f793 100644
> --- a/help.h
> +++ b/help.h
> @@ -37,6 +37,7 @@ void add_cmdname(struct cmdnames *cmds, const char *name, int len);
>  void exclude_cmds(struct cmdnames *cmds, struct cmdnames *excludes);
>  int is_in_cmdlist(struct cmdnames *cmds, const char *name);


Many new helpers are called get_frotz(), but only one among these is
called list_version_info().  I do not think the naming of the
get_*() ones, that are private to the bugreport tool, matters that
much, but unlike "list_commands()" whose purpose is to list the
commands ;-), the new function does not list versions---it just
gives information about a single version which is the one that is
being run, so perhaps it is a misnomer.

>  void list_commands(unsigned int colopts, struct cmdnames *main_cmds, struct cmdnames *other_cmds);
> +void list_version_info(struct strbuf *buf, int build_options);

It is not clear to the readers build_options is a boolean that
tells the function to include (or not to include) build options.
Perhaps rename it to "int show_build_options" or something?

