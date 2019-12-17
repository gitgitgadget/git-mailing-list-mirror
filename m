Return-Path: <SRS0=ZKiS=2H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 012B7C43603
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 18:55:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5356206D7
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 18:55:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="dIvvDNdj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbfLQSzl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Dec 2019 13:55:41 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58054 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726623AbfLQSzl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Dec 2019 13:55:41 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 954D29AE16;
        Tue, 17 Dec 2019 13:55:36 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Qr5nXSyzi+i6K8QDwlvrytQYq+Q=; b=dIvvDN
        djB8bj0li6J1liY7bOjILy7u2b8aImnC/RV1bYat/I07ZItLFMPZrj7I4m5g+gLI
        gyy4nYMd7jFO9v13dWX+UOiWvpWeGFvCluHs1TtXLHqmubymmgEK2lLq5Dy3Daqc
        HmulBPC+/tNbmqyv0mMNDIdfKOXLML4L6OGIc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=u0o+oRoEt41XrxQp1vdX5eePXNlvoX1q
        9B+YOnCXx9Ue389POPtRhoKRAl1SqagtXsFaG36sJpHiMyaJQO7d8M7ZZBZ5BB45
        Vdkqc8mW9G0FT2/QbGw2w1yg9IIydZ5tHtmlr5RKE+eFbiJhSDypmXC+2ez6dWr0
        lwoSJhnfsbc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8C0FC9AE14;
        Tue, 17 Dec 2019 13:55:36 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C139C9AE13;
        Tue, 17 Dec 2019 13:55:33 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 10/15] t1306: convert `test_might_fail rm` to `rm -f`
References: <cover.1576583819.git.liu.denton@gmail.com>
        <d39422505f16a14c64514b8a78ae351f41b75c44.1576583819.git.liu.denton@gmail.com>
Date:   Tue, 17 Dec 2019 10:55:31 -0800
In-Reply-To: <d39422505f16a14c64514b8a78ae351f41b75c44.1576583819.git.liu.denton@gmail.com>
        (Denton Liu's message of "Tue, 17 Dec 2019 04:01:35 -0800")
Message-ID: <xmqqk16uhjdo.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CDFF68A0-20FE-11EA-9A44-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> The test_must_fail() family of functions (including test_might_fail())
> should only be used on git commands. Replace `test_might_fail rm` with
> `rm -f` so that we don't use `test_might_fail` on a non-git command.

"rm -f X" can return non-zero status if "X" exists and cannot be
removed (e.g. "X" is a directory, X is in a directory you cannot
write to).  The only thing "-f" prevents the command from returning
non-zero status is when "X" does not exist.

That means that this change will change the behaviour.  Let's see if
it does in a good way or a bad way.

>  test_expect_success 'Checking attributes in a non-XDG global attributes file' '
> -	test_might_fail rm .gitattributes &&
> +	rm -f .gitattributes &&

This is so that leftover .gitattributes from previous tests will not
affect the outcome of this test.  If .gitattributes left by earlier
tests cannot be removed for whatever reason, we would want to know
about it, so changing to "rm -f" to make the tests more strict is a
good move.

>  	echo "f attr_f=test" >"$HOME"/my_gitattributes &&
>  	git config core.attributesfile "$HOME"/my_gitattributes &&
>  	echo "f: attr_f: test" >expected &&
> @@ -165,7 +165,7 @@ test_expect_success 'Checking attributes in a non-XDG global attributes file' '
>  test_expect_success 'write: xdg file exists and ~/.gitconfig doesn'\''t' '
>  	mkdir -p "$HOME"/.config/git &&
>  	>"$HOME"/.config/git/config &&
> -	test_might_fail rm "$HOME"/.gitconfig &&
> +	rm -f "$HOME"/.gitconfig &&

Likewise.

>  	git config --global user.name "write_config" &&
>  	echo "[user]" >expected &&
>  	echo "	name = write_config" >>expected &&
> @@ -183,8 +183,8 @@ test_expect_success 'write: xdg file exists and ~/.gitconfig exists' '
>  
>  
>  test_expect_success 'write: ~/.config/git/ exists and config file doesn'\''t' '
> -	test_might_fail rm "$HOME"/.gitconfig &&
> -	test_might_fail rm "$HOME"/.config/git/config &&
> +	rm -f "$HOME"/.gitconfig &&
> +	rm -f "$HOME"/.config/git/config &&

Likewise, but I think it makes more sense to remove them with a
single invocation of "rm -f".

>  	git config --global user.name "write_gitconfig" &&
>  	echo "[user]" >expected &&
>  	echo "	name = write_gitconfig" >>expected &&

Thanks.  In short, I think all of the changes in the patch are good.
