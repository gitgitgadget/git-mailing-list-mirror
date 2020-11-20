Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5095C8300F
	for <git@archiver.kernel.org>; Fri, 20 Nov 2020 18:31:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 904692415A
	for <git@archiver.kernel.org>; Fri, 20 Nov 2020 18:31:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="sOqZOhGe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730077AbgKTSbI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Nov 2020 13:31:08 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54816 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729889AbgKTSbF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Nov 2020 13:31:05 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 17BCAEE956;
        Fri, 20 Nov 2020 13:31:02 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Vd1/QniIqLwS
        jkn/R1zcMbomooA=; b=sOqZOhGeQbn6e8v30nsfdVQb0r3xP5DqVemAywKBkmzE
        o2N+sBL5nxsx6CXxbArAmczJJQ/FLRZBOHq1EunfYVL3xb9NfuB+TFEwTT+X2/JY
        KPx0i2PUC5e2wvFOZ/ZFUeDUnbvyi7BoknYaTh+1n+1GQsDUqiOabcFAsSnZirI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=LKbd8y
        kVch1iMGtDIXdPA5/UMlaGG0xil8vzZqBDPsQWvbbxdnb3DGcipu7Jb615tGlmjk
        35Ha6Kg32z49S4DsSeoJI8J0jn7d0obBxPFBBvlp4qGrLOhjPTgKbWRGtcACJNkh
        HzrT+ZDDnEYOkJMt0IYneETGnAid+HP3svS14=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1121DEE955;
        Fri, 20 Nov 2020 13:31:02 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 52A76EE953;
        Fri, 20 Nov 2020 13:30:59 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 0/7] config: add --literal-value option
References: <pull.796.git.1605801143.gitgitgadget@gmail.com>
        <87k0ugp3mg.fsf@evledraar.gmail.com>
        <e7973fe1-eb64-2f5a-ecb3-fadf2ba9764d@gmail.com>
Date:   Fri, 20 Nov 2020 10:30:57 -0800
In-Reply-To: <e7973fe1-eb64-2f5a-ecb3-fadf2ba9764d@gmail.com> (Derrick
        Stolee's message of "Fri, 20 Nov 2020 08:23:07 -0500")
Message-ID: <xmqqk0ufubha.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 89314A3E-2B5E-11EB-8E43-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> On 11/20/2020 8:19 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>=20
>> On Thu, Nov 19 2020, Derrick Stolee via GitGitGadget wrote:
>>=20
>>> As reported [1], 'git maintenance unregister' fails when a repository=
 is
>>> located in a directory with regex glob characters.
>>=20
>> Just as bikeshedding on the name: Did you consider something
>> thematically similar to the corresponding git-grep option,
>> i.e. --fixed-string[s]. I see -F is also free in git-config(1).
>
> I definitely wanted to be specific about "value" in the name,
> since some options include regexes on the key as well. I'm open
> to new ideas, and combining your idea with mine would introduce
> "--fixed-value". Thoughts?

I very much appreciate "value" is in the name, with the current
semantics that this only controls how the pattern matching is done
on the value side and not on the key side.  When making an obvious
addition of a separate option to control how the pattern matching is
done on keys in the future, we would regret if we called this option
"--fixed-strings" today.  And no, I do not think it is an acceptable
option to introduce "--fixed-strings" that only affects value side
and then later change its behaviour to affect also on the key side.

	Side note.  It _is_ possible to ship such a "--fixed-strings"
	option that does not work on the key side and document it as
	a known bug, later to be fixed.  I am not sure if I like it.

But stepping back a bit, is the extra flexibility that allows us to
control the matching on keys and values separately with such a
scheme really worth the complexity (at the end-user facing interface
level, not the implementation level)?

So an alternative may be to use a single option, whose name would
probably be one of "--(literal|fixed)-(match|strings)", but extend
the implementation in this series to make the single option affect
both the value and key matching the same way.

That would however be more work in the shorter term.  Offhand, I am
not sure if I like it (i.e. spending time and effort that is more
than the absolute minimum necessary to fix a breakage.  And the end
result of doing so is less powerful/flexible, even though it may be
easier to explain to users simply because the feature is less
powerful than it could be).  It would be easier, if I can convince
myself that the extra flexibility is not worth it, to just declare
that simpler is better here, but I am not quite ready to do so yet.

As to "-F", I do not think it is a good idea; in some context "-F"
means work on a <file> given via that option, i.e. "-F <file>".

Thanks.
