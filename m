Return-Path: <SRS0=27Fn=A3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B730BC433DF
	for <git@archiver.kernel.org>; Thu, 16 Jul 2020 20:27:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76974207E8
	for <git@archiver.kernel.org>; Thu, 16 Jul 2020 20:27:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="eD5+d/Lk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726079AbgGPU13 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jul 2020 16:27:29 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56823 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725921AbgGPU12 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jul 2020 16:27:28 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6921AE78F9;
        Thu, 16 Jul 2020 16:27:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=boI8On6XWuJI9srgoQ8xufm0vug=; b=eD5+d/
        LkVEZnf9eHSK6fuTm+P0PKw7u7XC8jd1QPgVw5kxq413pKdOTu5IuwN+/sIcNDsP
        w0GKL+hBA96H5B0O73Oi2bZ6iC0Gm44lLi9PWOv3syDZrYoqJjm754qBZaAcxvDO
        0Q7i+/syURMrVbbAXH2mNnWiF7v87e6xHzYuc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=T07UDoIn6iv9LlNp0UqIMROfjKl73IPC
        /fI9PP6bashLejGW9pPrazKZspgPs4RTJTC7MN9ZB9YnQcSrqbQWDq2f5VP/J2Ji
        GfivBKQfdZXA6bLGx96WyArM0H96kLtPzYyVYcQcGoc81GyJ7AZ2rLeJ5ei++z+4
        Gf0QEbiufAg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4E07FE78F8;
        Thu, 16 Jul 2020 16:27:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 93A85E78F5;
        Thu, 16 Jul 2020 16:27:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
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
        <xmqq5zanifoc.fsf@gitster.c.googlers.com>
Date:   Thu, 16 Jul 2020 13:27:20 -0700
In-Reply-To: <xmqq5zanifoc.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Thu, 16 Jul 2020 09:32:35 -0700")
Message-ID: <xmqq4kq7gq8n.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C1149F16-C7A2-11EA-8A6E-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> Hmm, this is actually a bit trickier than I expected because of the way
>> the code is written. It's much easier to complain about extensions in a
>> v0 repository than it is to ignore them. But I'm not sure if that isn't
>> the right way to go anyway.
>>
>> The patch I came up with is below (and goes on top of Jonathan's). Even
>> if we decide this is the right direction, it can definitely happen
>> post-v2.28.
>
> It must happen already in 'seen' if we want to keep bc/sha-2-part-3
> with us, though ;-)

FWIW, I needed to adjust t0001 while merging the SHA-2 topic.  The
internal use of "git config" via test_config triggers the "this is
not a Git repository as the value of repositoryformatversion and the
defined set of extensions are incompatible".

diff --cc t/t0001-init.sh
index 6d2467995e,34d2064660..ff538c0eed
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
 ...
 -test_expect_success 'extensions.objectFormat is not honored with repo version 0' '
++test_expect_success 'extensions.objectFormat would cause an error in repo version 0' '
+ 	git init --object-format=sha256 explicit-v0 &&
 -	test_config -C explicit-v0 core.repositoryformatversion 0 &&
 -	git -C explicit-v0 rev-parse --show-object-format >actual &&
 -	echo sha1 >expected &&
 -	test_cmp expected actual
++	v=$(git config --file=explicit-v0/.git/config core.repositoryformatversion 0) &&
++	test_when_finished "
++		git config --file=explicit-v0/.git/config core.repositoryformatversion $v
++	" &&
++	git config --file=explicit-v0/.git/config core.repositoryformatversion 0 &&
++	test_must_fail git -C explicit-v0 rev-parse --show-object-format >actual
+ '

