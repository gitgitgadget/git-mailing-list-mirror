Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD39F1F462
	for <e@80x24.org>; Tue, 28 May 2019 16:56:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbfE1Q41 (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 May 2019 12:56:27 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61449 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726512AbfE1Q41 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 May 2019 12:56:27 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 130B76BFA9;
        Tue, 28 May 2019 12:56:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GDRyH1rZuz6B5GOSxCMZODH+SVs=; b=sxoYSa
        6n9x9WerscHJTetndNh9YEjbLuTIIFgDz4UNE3j9NlqjnOmQF7yDUlg6pwnp40zd
        IvbjnhjOvn9hs6W/K1y8yup03BROuNL5vhtn0C51oOq7p1XTgTrgIl+bUnskYXMZ
        kXmwuJCdbJKY3tzdfVscCr8oIMsrKyyl0E4Fk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Xb+yYtvxdseqgw9XHJcfFa+pLaH6Yzvu
        gymm1Fei4IUQ1U9TDEqhTFuxvDlZxROB1sQbBLHcD9KGyxx3Zj6sKWVDyb8dcGuc
        aTc7iw7CVnVwAV1VYwHPKp26cAKm3uRgWctUJ+2UNK4HTobydKjb2AcWOq9Wx0FP
        gRz9LpzIa4I=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0A4026BFA8;
        Tue, 28 May 2019 12:56:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id AC6B46BFA7;
        Tue, 28 May 2019 12:56:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jakub Narebski <jnareb@gmail.com>
Cc:     Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Adam Roben <aroben@apple.com>,
        Bryan Larsen <bryan.larsen@gmail.com>,
        Matthias Urlichs <smurf@smurf.noris.de>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 2/3] hash-object doc: elaborate on -w and --literally promises
References: <20190520215312.10363-1-avarab@gmail.com>
        <20190520215312.10363-3-avarab@gmail.com>
        <20190522050839.GB29933@sigill.intra.peff.net>
        <86woigp3ro.fsf@gmail.com>
Date:   Tue, 28 May 2019 09:56:19 -0700
In-Reply-To: <86woigp3ro.fsf@gmail.com> (Jakub Narebski's message of "Fri, 24
        May 2019 12:04:27 +0200")
Message-ID: <xmqq8suq4ix8.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 852ADB9E-8169-11E9-B3C7-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jakub Narebski <jnareb@gmail.com> writes:

> I thik that this implemetation detail of `--literally` is here to stay;
> how would you otherwise fix the issue if garbage object makes Git crash?

By repacking, presumably ;-).

More importantly, there needs a way to extend "enum object_type" to
allow unbounded number of arbitrary (garbage) types before we can
allow --literally to record such a garbage type in a pack stream.

So I'd expect the implementation detail would stay for a long time.
But there is nothing that says `--literally` inherently must write
loose.  It is plausible that a new implementation writes objects of
known/valid types to a pack stream, while unknown/garbage types to
loose objects.

> However, I would prefer to have options state _intent_; if there is
> legitimate need for a tool that creates loose objects, it would be
> better to have separate `--loose` option to `git hash-object` (which
> would imply `-w`, otherwise it doesn't have sense).

Yes, I very much agree with that.
