Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08609C433EF
	for <git@archiver.kernel.org>; Wed,  1 Jun 2022 20:43:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbiFAUnu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Jun 2022 16:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbiFAUn1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Jun 2022 16:43:27 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA0D71B828E
        for <git@vger.kernel.org>; Wed,  1 Jun 2022 13:26:10 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 64D6A18754F;
        Wed,  1 Jun 2022 16:21:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9pbnO/M2Ov6ZlYsWS2INWUiX7BJPaDn896cDlD
        UK1KY=; b=RmL+QbX4FbZctyFrnDOD6z2W/IAUJbsGoL09o29ylc5yoGqf57Ok7x
        w8o/zlNvfHzQlQqcfSLko8dj99sNl0dBPeH6tAj2b4FKpQ8/OMUg00QLmsK2AX1Z
        i1Evwk/jNmqteOBAFuFtCWjiOyjc9YEqD7XsnHbGnL5fc2hdNxgRY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5CF3018754E;
        Wed,  1 Jun 2022 16:21:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id F311018754D;
        Wed,  1 Jun 2022 16:21:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, peff@peff.net, me@ttaylorr.com,
        christian.couder@gmail.com, johannes.schindelin@gmx.de,
        jrnieder@gmail.com,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Robert Coup <robert.coup@koordinates.com>
Subject: Re: [PATCH v3 2/2] usage: add warn_once() helper for repeated warnings
References: <pull.1237.v2.git.1653658034086.gitgitgadget@gmail.com>
        <pull.1237.v3.git.1654046173.gitgitgadget@gmail.com>
        <8e29ac807c6a0cf94ea3a44ee3304011c2ad159c.1654046173.git.gitgitgadget@gmail.com>
        <220601.868rqg1qo2.gmgdl@evledraar.gmail.com>
        <8f96563b-87c5-2a8c-fe35-19fd0cc3c7d2@github.com>
Date:   Wed, 01 Jun 2022 13:21:27 -0700
In-Reply-To: <8f96563b-87c5-2a8c-fe35-19fd0cc3c7d2@github.com> (Derrick
        Stolee's message of "Wed, 1 Jun 2022 14:42:13 -0400")
Message-ID: <xmqq35gorv7c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6B474E6E-E1E8-11EC-BA30-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

> We could certainly investigate this more, but it seems like a more
> problematic approach than the one taken here. We could add a "is_valid"
> bit to struct remote, but then could some code path modify that struct
> after it was validated?

Two separate parser parsing the same string to produce (supposedly)
equivalent parse results is a bit disturbing, and I am not sure if
"is_valid" bit helps that.

Adding "user" and "password" members to the struct, and retire the
existing "parser" (instead it would just use the pre-parsed
components stored in the struct) would.  It would be a much more
involved change, and it is something more than we would want to do
in a regression fix patch.

But this series is a new feature development, so...




