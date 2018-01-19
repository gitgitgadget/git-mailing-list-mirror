Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E46C1F404
	for <e@80x24.org>; Fri, 19 Jan 2018 19:08:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756172AbeASTIu (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Jan 2018 14:08:50 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58349 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756030AbeASTIs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jan 2018 14:08:48 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 20C12BD53C;
        Fri, 19 Jan 2018 14:08:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=gFav7vp67kkVuW45Nc/81IvACi4=; b=LpLc62
        74ZuzT9XstY4YelNNrcyvBJOt+61dSyCbdd8cKm0whtrUipZ0QH9R7xi5q72UtrH
        ZQG8jm9sMxtJidSV4vNiCYcsyP8uWH+JJpu8/A94NlTA+EGzguxt+HE3UmSTUzgV
        9ZjnRn1h0O9H1QuWlfj9rXkJ/1l2nyzg9CMUc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qVZESHvz98l6wD6ma8qUSV8yev7/tO+M
        ib3Nyj9YWi6VEug2yCu3KG9KCUX5oFD+oGP4cZ18osyIiIY3QjX7Z12HQ8WVe/bI
        IZOx024wRvGZZAHiP9MvtbSlDwrFtZIpCRtMxCo8gjDR1Zg9k0eWlf4z0hoPssBs
        6KlBzhFzavg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 183C6BD53B;
        Fri, 19 Jan 2018 14:08:48 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8AA85BD539;
        Fri, 19 Jan 2018 14:08:47 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Theodore Ts'o <tytso@mit.edu>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Chris Mason <clm@fb.com>
Subject: Re: [PATCH] enable core.fsyncObjectFiles by default
References: <20180117184828.31816-1-hch@lst.de>
        <xmqqd128s3wf.fsf@gitster.mtv.corp.google.com>
        <87h8rki2iu.fsf@evledraar.gmail.com>
        <CA+55aFzJ2QO0MH3vgbUd8X-dzg_65A-jKmEBMSVt8ST2bpmzSQ@mail.gmail.com>
        <20180117235220.GD6948@thunk.org>
        <CA+55aFxgg6MT5Z+Jox2xyG28g9jNJ4cL3jNZ5AgTOmUODuiBsA@mail.gmail.com>
        <20180118162721.GA26078@lst.de>
Date:   Fri, 19 Jan 2018 11:08:46 -0800
In-Reply-To: <20180118162721.GA26078@lst.de> (Christoph Hellwig's message of
        "Thu, 18 Jan 2018 17:27:21 +0100")
Message-ID: <xmqqzi59psxt.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2D345840-FD4C-11E7-9B1A-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christoph Hellwig <hch@lst.de> writes:

> [adding Chris to the Cc list - this is about the awful ext3 data=ordered
> behavior of syncing the whole file system data and metadata on each
> fsync]
>
> On Wed, Jan 17, 2018 at 03:57:53PM -0800, Linus Torvalds wrote:
>> On Wed, Jan 17, 2018 at 3:52 PM, Theodore Ts'o <tytso@mit.edu> wrote:
>> >
>> > Well, let's be fair; this is something *ext3* got wrong, and it was
>> > the default file system back them.
>> 
>> I'm pretty sure reiserfs and btrfs did too..
>
> I'm pretty sure btrfs never did, and reiserfs at least looks like
> it currently doesn't but I'd have to dig into history to check if
> it ever did.

So..., is it fair to say that the one you sent in

  https://public-inbox.org/git/20180117193510.GA30657@lst.de/

is the best variant we have seen in this thread so far?  I'll keep
that in my inbox so that I do not forget, but I think we would want
to deal with a hotfix for 2.16 on case insensitive platforms before
this topic.

Thanks.

