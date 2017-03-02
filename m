Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DBAF41F5FB
	for <e@80x24.org>; Thu,  2 Mar 2017 20:45:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751557AbdCBUo7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Mar 2017 15:44:59 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55748 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750892AbdCBUo6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Mar 2017 15:44:58 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 03E4083369;
        Thu,  2 Mar 2017 15:43:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=TZo5pAnBnSchNswdVnk2XsOfmDk=; b=Z0LhcR
        RxstM5w1dxrcHhQ3nl1+pbTNmTXq1ABT0ipBWleg3F6C/SY/PTQ2cGha7rtA6V+y
        rIpgxP4LvkrnUxyXmZ+WB0TnNexlfrbjxRlQDARSOoYSuBFXahjWykoinbqqCZ3O
        R89NU9EZLfJx7lkl7WYqh4mOyBpAzg5NN2DvQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Eo0zp/ZeSy2BUyexOIVaiRYvN0kB1pBD
        wIHltNoWjqpjmEkEokMs4R+ASHk2aEbsyEs+qc0sScXqjptV8M7ivdS/FdgKyi+h
        0Va5hnj+gddsQJI3azXSvPd72oVfdqHvIaDWr+P+qT/HRKP/xKOU5WDCf8DpZDoe
        tSyseJ56CRU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D234083368;
        Thu,  2 Mar 2017 15:43:51 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 45F3A83367;
        Thu,  2 Mar 2017 15:43:51 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jeff King <peff@peff.net>,
        Ian Jackson <ijackson@chiark.greenend.org.uk>,
        Joey Hess <id@joeyh.name>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: SHA1 collisions found
References: <20170223164306.spg2avxzukkggrpb@kitenet.net>
        <22704.19873.860148.22472@chiark.greenend.org.uk>
        <xmqq60jz5wbm.fsf@gitster.mtv.corp.google.com>
        <20170224233929.p2yckbc6ksyox5nu@sigill.intra.peff.net>
        <CA+55aFw6BLjPK-F0RGd9LT7X5xosKOXOxuhmKX65ZHn09r1xow@mail.gmail.com>
        <CA+55aFwXaSAMF41Dz3u3nS+2S24umdUFv0+k+s18UyPoj+v31g@mail.gmail.com>
Date:   Thu, 02 Mar 2017 12:43:50 -0800
In-Reply-To: <CA+55aFwXaSAMF41Dz3u3nS+2S24umdUFv0+k+s18UyPoj+v31g@mail.gmail.com>
        (Linus Torvalds's message of "Thu, 2 Mar 2017 11:55:45 -0800")
Message-ID: <xmqqk287be9l.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F174F1BE-FF88-11E6-A70D-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> Anyway, I do have a suggestion for what the "object version" would be,
> but I'm not even going to mention it, because I want people to first
> think about the _concept_ and not the implementation.
>
> So: What do you think about the concept?

My reaction heavily depends on how that "object version" thing
works.  When I think I have "variant #1" of an object and say

  have 860cd699c285f02937a2edbdb78e8231292339a5#1

is there any guarantee that the other end has a (small) set of
different objects all sharing the same SHA-1 and it thinks it has
"variant #1" only when it has the same thing as I have (otherwise,
it may have "variant #2" that is an unrelated object but happens to
share the same hash)?  If so, I think I understand how things would
work within your "concept".  But otherwise, I am not really sure.

Would "object version" be like a truncated SHA-1 over the same data
but with different IV or something, i.e. something that guarantees
anybody would get the same result given the data to be hashed?


