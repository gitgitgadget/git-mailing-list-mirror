Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A8CC1F462
	for <e@80x24.org>; Tue, 28 May 2019 16:50:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbfE1QuH (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 May 2019 12:50:07 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64925 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbfE1QuG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 May 2019 12:50:06 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BDD146E646;
        Tue, 28 May 2019 12:50:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=QyvZIeWDESnw
        NTeUT/tXAPRlNmc=; b=kL5zpyF0JtZpwMuwjaHyaQ4mZpXan4oR3+Ylr+hN252t
        sZGQeuoGuoVaHgtL1wl9lACIQJduL/qnTaUXVBdQj+TGjBOBcgZnf67cUHs1JM+K
        jHZrKSVgaqkjPIZROrvET6K16YNagN81itlRTv3MtiGnEF40YEZrQ7yDiebrtQI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=PfIMaM
        nyn7RA67guGMWVK/jSdyUugvKjEQavL3kHXzguIGinfKUMz5tr+KB45+hU60Jfl1
        WGhsg2inTT625hggmDHhGzcrfJEoRN4O2gWPDlHd9bXzQlyDVporLnri6d9jEGaW
        9dwZRyTQkeT1jD5HRHUjFuJuyFtzaGGIckKxg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B690B6E645;
        Tue, 28 May 2019 12:50:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id CFFB26E640;
        Tue, 28 May 2019 12:50:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Adam Roben <aroben@apple.com>,
        Bryan Larsen <bryan.larsen@gmail.com>,
        Matthias Urlichs <smurf@smurf.noris.de>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 2/3] hash-object doc: elaborate on -w and --literally promises
References: <20190520215312.10363-1-avarab@gmail.com>
        <20190520215312.10363-3-avarab@gmail.com>
Date:   Tue, 28 May 2019 09:49:59 -0700
In-Reply-To: <20190520215312.10363-3-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Mon, 20 May 2019 23:53:11 +0200")
Message-ID: <xmqqd0k24j7s.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: A2C161F6-8168-11E9-B04B-B0405B776F7B-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Clarify the hash-object docs to explicitly note that the --literally
> option guarantees that a loose object will be written, but that a
> normal -w ("write") invocation doesn't.
>
> At first I thought talking about "loose object" in the docs was a
> mistake in 83115ac4a8 ("git-hash-object.txt: document --literally
> option", 2015-05-04), but as is clear from 5ba9a93b39 ("hash-object:
> add --literally option", 2014-09-11) this was intended all along.

I have to admit that this "loose only" was the doing of my
defeatism.  IOW, I was utterly pessimistic that I would be able to
add more types (and more importantly, unbounded number of random
types) of objects in the packstream.

So, "loose object" limitation is a practical one for those of us who
cannot think of a reasonable way to cram arbitrary number of random
new types into just 3 bits of the "type" bitfield, and not inherent
to the "hash-object --literally" command.

So I am very happy to see the first hunk of this patch, but I doubt
there is much value in the last sentence the second hunk adds.

Thanks.
