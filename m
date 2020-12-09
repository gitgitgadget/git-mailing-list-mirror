Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76563C4167B
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 01:09:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C5E123B79
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 01:09:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725883AbgLIBJe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Dec 2020 20:09:34 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61189 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbgLIBJe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Dec 2020 20:09:34 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 67D3BB7F11;
        Tue,  8 Dec 2020 20:08:50 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=AGuudGn0lrXjlZZoSa8CtCSHJOw=; b=oOpim5
        Mtpy5l6Plm6WOm4IkDGvv/vv2F0r5YduYhvJ0YuoEEkC6/USnmERaDyAOp6fK4LM
        /6w/hCWTAFL8F+raTs5sHEqg6CUR3WmLiFQSq5seYIig5oHmZBtGicYGTEcuCA+a
        jmg4WY4l6Xp4aI7sj1JYCMBGmy6E6YVy5z1nE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=gG60CBhm0XfScaMaXY6JOg+FJkeJfqSG
        Yw8qe6PTgX7/r2F35nYAHQ1I+ZFH3MraxVXR5uJOEWHIdgFV6oIlIykuM41i6Vw0
        p8qEDU5IvA2jnp8PMm9MVv5twMZNxfRsADQBwCqWKjKBdZbZu9beRiLcooJZACfD
        yKrHqmlCKcI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6090BB7F10;
        Tue,  8 Dec 2020 20:08:50 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DAC5EB7F0F;
        Tue,  8 Dec 2020 20:08:49 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH] Add project-wide .vimrc configuration
References: <20201209002619.25468-1-felipe.contreras@gmail.com>
Date:   Tue, 08 Dec 2020 17:08:48 -0800
In-Reply-To: <20201209002619.25468-1-felipe.contreras@gmail.com> (Felipe
        Contreras's message of "Tue, 8 Dec 2020 18:26:19 -0600")
Message-ID: <xmqqy2i74wgv.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 189753C0-39BB-11EB-8552-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> It's not efficient that everyone must set specific configurations in all
> their ~/.vimrc files; we can have a project-wide .vimrc that everyone
> can use.

Does .vimrc gets used from the current directory?  If so, just like
clang-format, it makes sense to place it with dot-prefix at the root
of the project, like this patch does.  But ...

>
> By default it's ignored, you need the following in your ~/.vimrc
>
>   set exrc
>   set secure

... it does not sound like it is the case.

And I am sensing that this ".vimrc that happens in the current
directory is not used by default" is not such a well known fact
among vim users (otherwise you wouldn't be writing it here), and if
that is the case, I am afraid that this invites an unneeded end-user
confusion when they see dot-commandname-rc file and see its contents
not honored at all.

Whether it is well known by intended audience that it is by default
unused, we should give the instruction we see above (and below, up
to the description of how to override) in a comment at the beginning
of the file, I think.  Then, once the user follows the insn, the new
file added by this patch would start working without any further user
action, which is very nice.

> Then the project-wide configuration is loaded, which sets the correct
> filetype for the documentation and tests, and also the default
> indentation of c, sh, and asciidoc files.
>
> If you have the shareness syntax file it will be used for the tests, but
> if not the sh syntax will still be used.
>
> These default configurations can be overriden in the typical way (by
> adding the corresponding file in ~/.vim/after/ftplugin).
>
> We could add the vim modelines at the bottom of every file, like other
> projects do, but this seems more sensible.
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  .vimrc | 9 +++++++++
>  1 file changed, 9 insertions(+)
>  create mode 100644 .vimrc
>
> diff --git a/.vimrc b/.vimrc
> new file mode 100644
> index 0000000000..d250ab26e0
> --- /dev/null
> +++ b/.vimrc
> @@ -0,0 +1,9 @@
> +augroup git
> +  au!
> +  au BufRead,BufNewFile */t/*.sh set ft=sharness.sh
> +  au BufRead,BufNewFile */Documentation/*.txt set ft=asciidoc
> +
> +  au FileType c setl noet ts=8 sw=0 cino=(s,:0,l1,t0
> +  au FileType sh setl noet ts=8 sw=0
> +  au FileType asciidoc setl noet ts=8 sw=0 autoindent
> +augroup END
