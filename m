Return-Path: <SRS0=27Fn=A3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6CC2C433E0
	for <git@archiver.kernel.org>; Thu, 16 Jul 2020 16:32:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 969DC2076D
	for <git@archiver.kernel.org>; Thu, 16 Jul 2020 16:32:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="unhTKKy5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729270AbgGPQcm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jul 2020 12:32:42 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61535 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729048AbgGPQcm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jul 2020 12:32:42 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 24518E6F8B;
        Thu, 16 Jul 2020 12:32:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=31g7dMvvu110NL2D2gz9eTg6DeQ=; b=unhTKK
        y59RZRe72lqBXBUwEFJO4imUTKaUMVkIdNtm+77uvPk3mptIrGsG2Xeo+rRnyoUr
        G3aCdhVkMGGOYDPoIwWAzpn9MZG3zelsuy/BzX21Yl1rhF3WAreOoIKD1xLGSTPQ
        NADTI0e9W5x8qU+18PCHd2XvCU+3JU3+BzPc0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=he8raJQ06pE+v0j0pzG1AgSV9Abl6n5S
        oUJVjMGqsfGrbq/nMl/UqX7bnkoJ7tL/hwFoyCEf02A4/Iz+SWf5jqoAs5KDeKzw
        DR8Hq47FfiLU1xkeAIk2yXWhqL/s6pVnKveB07DFjjPOws3lMQ0EdsnJjzj0UeU6
        w0K5Lpa71kI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1C253E6F8A;
        Thu, 16 Jul 2020 12:32:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 5C770E6F89;
        Thu, 16 Jul 2020 12:32:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, delphij@google.com,
        Huan Huan Chen <huanhuanchen@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 2/2] repository: allow repository format upgrade with extensions
References: <pull.675.git.1594677321039.gitgitgadget@gmail.com>
        <0bede821-139a-d805-934a-142004abaa4c@gmail.com>
        <nycvar.QRO.7.76.6.2007141420300.52@tvgsbejvaqbjf.bet>
        <xmqqzh82ktgm.fsf@gitster.c.googlers.com>
        <xmqqpn8wkben.fsf@gitster.c.googlers.com>
        <20200716062054.GA3242764@google.com>
        <20200716062818.GC3242764@google.com>
        <xmqqh7u8hrka.fsf@gitster.c.googlers.com>
        <20200716110007.GD376357@coredump.intra.peff.net>
        <20200716122513.GA1050962@coredump.intra.peff.net>
Date:   Thu, 16 Jul 2020 09:32:35 -0700
In-Reply-To: <20200716122513.GA1050962@coredump.intra.peff.net> (Jeff King's
        message of "Thu, 16 Jul 2020 08:25:13 -0400")
Message-ID: <xmqq5zanifoc.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F5A1B230-C781-11EA-A4EE-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Hmm, this is actually a bit trickier than I expected because of the way
> the code is written. It's much easier to complain about extensions in a
> v0 repository than it is to ignore them. But I'm not sure if that isn't
> the right way to go anyway.
>
> The patch I came up with is below (and goes on top of Jonathan's). Even
> if we decide this is the right direction, it can definitely happen
> post-v2.28.

It must happen already in 'seen' if we want to keep bc/sha-2-part-3
with us, though ;-)

> So one option would be to rewrite that handling to record any new
> extensions (and their values) during the config parse, and then only
> after proceed to handle new ones only if we're in a v1 repository.

I do not think it would be too bad for read_repository_format() to
call git_config_from_file() to collect extensions.* in a string list
while looking for core.repositoryformatversion.  Then the function
can iterate over the string list to call check_repo_format() itself.

> I'm not sure if it's worth the trouble:
>
>   - ignoring extensions is likely to end up with broken results anyway
>     (e.g., ignoring a proposed objectformat extension means parsing any
>     object data is likely to encounter errors)

The primary reason why the safety calls for ignore/reject is the
namespace collision.  We may decide to use extensions.objectformat
to record what hash algorithms are used for objects in the
repository, while the end user and their tools may use it for
totally different purpose (perhaps they have a custom script around
"git repack" that reads the variable to learn what command line
options e.g. --window=800 to pass).  A new version of Git that
supports SHA-2 will suddenly break their configuration, when the
users are 100% happy with the current SHA-1 system, with the way
their tool uses extensions.objectformat configuration variable and a
newer version of Git that happens to know how to also work with SHA-2,
using their v0 repository.

And the reasoning 'ignoring would make the problem get noticed
anyway' does not apply to such users at all, does it?

We need to declare that any names under "extensions.*" is off limits
by end users regardless and write it in big flasing red letters if
we haven't already done so.  It is enforced in v1 repositories by
dying upon seeing an unrecognised extension, but not entirely.  When
the users are lucky, a known-but-name-collided extension may stop
with a type error (e.g. "extensions.objectformat=frotz" may say
"frotz is not among the accepted hash algorithms") but that is not
guaranteed.  In v0 repositories, enforcing it after the fact would
cause the same trouble as the tightening caused.

