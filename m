Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EA06C433EF
	for <git@archiver.kernel.org>; Fri, 22 Jul 2022 18:47:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236439AbiGVSri (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jul 2022 14:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235586AbiGVSrg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jul 2022 14:47:36 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27DF9A9B9F
        for <git@vger.kernel.org>; Fri, 22 Jul 2022 11:47:35 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 954C41B55C6;
        Fri, 22 Jul 2022 14:47:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=NxG8ao+knraX
        Pkix+VYMQFCQ53+iaLmeVo8oisYxo8Q=; b=Lg9JVE+8SlPgug5t80Wt8Q4uY2Ff
        KC/Z+SUV+SNazr4rsyIjW7WTzGuBNHq6xXpjnfJ+B8JEnV3F39NsMtLDpt1CmAVZ
        tKQXFfscUXlFVM1Y+2Jah9V1sUxkAvBX6iufQyShRUZAtqWuMnhkVCcOIdlID5So
        vTb4yl/IGb9Jn5E=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8E69A1B55C5;
        Fri, 22 Jul 2022 14:47:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.40.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D6D591B55C3;
        Fri, 22 Jul 2022 14:47:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>
Subject: Re: [PATCH v3 02/26] submodule--helper: stop conflating "sb" in
 clone_submodule()
References: <cover-v2-00.24-00000000000-20220719T204458Z-avarab@gmail.com>
        <cover-v3-00.26-00000000000-20220721T191249Z-avarab@gmail.com>
        <patch-v3-02.26-32e4ae7ead5-20220721T191249Z-avarab@gmail.com>
        <xmqqlesmf9or.fsf@gitster.g>
        <220722.86y1wlqmqr.gmgdl@evledraar.gmail.com>
Date:   Fri, 22 Jul 2022 11:47:29 -0700
In-Reply-To: <220722.86y1wlqmqr.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Fri, 22 Jul 2022 15:50:32 +0200")
Message-ID: <xmqq8rolc7cu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: BDC401C2-09EE-11ED-AFB3-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>> This looks like a roundabout way to say xstrfmt().
>
> Yes, I can fix this and others while I'm at it, but a lot of things lik=
e
> that in this code are funny uses of APIs that we could improve.
>
> I think it's probably best to just leave these for now.

Agreed.  We could instead have a separate series to fix API usage
before these and then build leak-plugging on top, or the other way
around, and in general "clean then plug" would make it easier to
review the plugging patches (simply because it would be working on
clean code, not code that misuses the API in strange ways), but it
is too late now.  Lets make sure we do not forget to revisit the API
misuse but lets avoid mixing it into the series.
