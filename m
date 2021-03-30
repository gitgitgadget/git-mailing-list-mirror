Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 029F2C433DB
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 22:07:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0B66619CF
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 22:07:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232894AbhC3WG7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Mar 2021 18:06:59 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59761 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232884AbhC3WGu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Mar 2021 18:06:50 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7358911B2C3;
        Tue, 30 Mar 2021 18:06:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=JapvY8qnHW5o5mwnEMStN4TxTEI=; b=nZGfAM
        sH7oNwLbpUkFqPb8Nejee1R4m42HbqGhzzeuRBWJ6Tptlk+MVuHfQ19Uo8H6uwwD
        FjgTSe3VvXGjttMhPFDmfHzfEXFcAWPYTww1GwrDtrX3me3g2N+n4jHn8A70HH3p
        L6G733RDdUulfMyOvNxCKZMpco+RgsV67LbKc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=x2S8Tx47uaQwnC1OX7AHPxPneH6h5o53
        AFLtDqFcZ22W3DeCv3p3N1mL2MZM6bpM5GBqmMwGsth5nkj9JF2Z9xv/lqyFQKoU
        wCeUr+lvLQrIbshuNVXFBbxhW1M1HPITHPpHVMHS6KaMC0Z9hmlUCi8BuISyotDW
        qUeFCsesnnE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6CA5A11B2C2;
        Tue, 30 Mar 2021 18:06:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9930211B2C1;
        Tue, 30 Mar 2021 18:06:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Dominyk Tiller <dominyktiller@gmail.com>
Cc:     git@vger.kernel.org,
        Dominyk Tiller via GitGitGadget <gitgitgadget@gmail.com>
Subject: Re: [PATCH] persistent-https: add go.mod to fix compile
References: <pull.989.git.git.1617109668438.gitgitgadget@gmail.com>
        <xmqqy2e4cvbl.fsf@gitster.g>
        <3dd5a0cd-94cc-e7ec-b1b1-feb39c65e85d@gmail.com>
Date:   Tue, 30 Mar 2021 15:06:45 -0700
In-Reply-To: <3dd5a0cd-94cc-e7ec-b1b1-feb39c65e85d@gmail.com> (Dominyk
        Tiller's message of "Tue, 30 Mar 2021 22:30:26 +0100")
Message-ID: <xmqq1rbwcn4a.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 38AC88E2-91A4-11EB-9D27-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dominyk Tiller <dominyktiller@gmail.com> writes:

> Junio C Hamano wrote on 30/03/2021 20:09:
>> "Dominyk Tiller via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>
>>> From: Dominyk Tiller <dominyktiller@gmail.com>
>>>
>>> GOPATH-based builds and non module-aware builds are being deprecated
>>> by golang upstream, which currently causes this to fail. This adds a
>>> barebones mod file to fix the build.
>>>
>>> The `persistent-https` code hasn't been touched for a long time but
>>> I assume this is preferable to simply removing it from the codebase.
>>>
>>> Before this change:
>>> ```
>>> case $(go version) in \
>>> 	"go version go"1.[0-5].*) EQ=" " ;; *) EQ="=" ;; esac && \
>>> 	go build -o git-remote-persistent-https \
>>> 		-ldflags "-X main._BUILD_EMBED_LABEL${EQ}"
>>> go: cannot find main module, but found .git/config in ../git
>>> 	to create a module there, run:
>>> 	cd ../.. && go mod init
>>> make: *** [git-remote-persistent-https] Error 1
>>> ```
>> With which version of go?  Any recent version would fail the same
>> way, or only 1.16 and later?
> The link I referenced in the notes explains a little more in depth, but
> there's an environment variable you can use with 1.16 to temporarily
> mitigate the failure, i.e. `export GO111MODULE=off`, but regardless of
> the presence of that the lack of module-awareness will become a hard
> failure in Go 1.17. The lack of module awareness is only a failure on Go
> 1.16 and later. Module support was added in basic form as far back as Go
> 1.11, released late 2018.
>>
>>> Ref: https://blog.golang.org/go116-module-changes.
>>> diff --git a/contrib/persistent-https/go.mod b/contrib/persistent-https/go.mod
>>> new file mode 100644
>>> index 000000000000..6028b1fe5e62
>>> --- /dev/null
>>> +++ b/contrib/persistent-https/go.mod
>>> @@ -0,0 +1,3 @@
>>> +module github.com/git/git/contrib/persistent-https
>>> +
>>> +go 1.16
>> Can I ask what is affected by this 1.16 version number?  Do the
>> users have to use 1.16 and nothing older or newer?
>>
>> As a non Go user, I am trying to see if this change is "make it work
>> for all users of reasonably new versions of Go" (if that is the
>> case, what is the "reasonably new") or "make it work for those with
>> 1.16, and everybody else should either install 1.16 or figure out 
>> their own solutions".
>>
>> Thanks.
> This is more thoroughly detailed here:
> https://golang.org/ref/mod#go-mod-file-go, but essentially the version
> number was/is intended to be the minimum Go version the module is
> designed to work with. We could set it lower to play it safe if the Git
> project wishes, but to date there have been no backwards
> incompatibilities with the module system and the way we're using the
> module system is so basic I don't see any way we'd trigger the
> version-based behaviours detailed in the link above. For what it's worth
> testing locally against 1.15 it builds without issue, despite being a
> lower version number than specified in the string.

I've done the same experiment with 1.15 before writing the message
you are responding to.

It felt a bit of magic as I never expected 1.15 binary to anticipate
what is in 1.16, or to be able to say that a version from the future
(from 1.15 binary's point of view) has backward incompatible
semantics to stop the use of the module (the reason why I used 1.15
was because it was readily available in Debian).  Public
documentation by Go folks that explain go.mod file format seems to
use "go 1.12" in the examples everywhere, so it might be a sane
version string to use?

In any case, explaining these things in this response is good, but
eventually we need to make sure that the readers of the resulting
commit would not have to ask the same question, without having to
refer to external documentation.

Thanks.
