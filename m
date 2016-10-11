Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD1C11F4F8
	for <e@80x24.org>; Tue, 11 Oct 2016 19:40:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752020AbcJKTkg (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Oct 2016 15:40:36 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59272 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751966AbcJKTkf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2016 15:40:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A23A542792;
        Tue, 11 Oct 2016 15:27:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=beQCOl4TFEVLKtdnPbjrRmGOagY=; b=brbaqO
        /W3kOuFvg2NUqTb7L/ClHjKXzcIhYSwPhPqb/mvZQm7cgbSY/qAaJnknw/KTzxDO
        Q/5piBqEehVvC5d4/epXFyW1jfxVWGzqg6jxJf5DeCgs68v6ZrVBlXIay635UX/y
        Wx3x8kZzTrKMHuZAodgE3RDx7Mjj28uNTFwNo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=F8NNnuk/s7sg/DNk857qaJCqbulE6rf4
        iNcib0/ukG/OsLqpjI5gRYSspSvdqnkTb+mYzM/L5GuXZT3HMKo6cZiJ1AV15GuX
        tB/90bUP2o1fTqDvrkCe8d+OdTKGT3zwo7T1SaEXo8v6FO6f45y41f9pZgVuDpUV
        2xDNz5gMWZc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9853A42790;
        Tue, 11 Oct 2016 15:27:23 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 176CD4278F;
        Tue, 11 Oct 2016 15:27:23 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/2] Support `git reset --stdin`
References: <cover.1476202100.git.johannes.schindelin@gmx.de>
        <20161011183448.yasglfjelo4kgrq4@sigill.intra.peff.net>
Date:   Tue, 11 Oct 2016 12:27:21 -0700
In-Reply-To: <20161011183448.yasglfjelo4kgrq4@sigill.intra.peff.net> (Jeff
        King's message of "Tue, 11 Oct 2016 14:34:49 -0400")
Message-ID: <xmqqshs28z52.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BC066450-8FE8-11E6-B3B4-5F377B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Is git-reset the right layer to add scripting features? I thought we
> usually pushed people doing mass index manipulation to use update-index
> or read-tree. Is there something that reset makes easy that is hard with
> those tools (I could imagine "--hard", but I see it is not supported
> with your patch).
>
> Not that I'm necessarily opposed to the patch, I was just surprised.

If read-tree had pathspec support (i.e. "read these and only these
paths given from the command line into the index from a given
tree-ish"), that would have been the most natural place to extend
with "oh, by the way, instead of the command line, you can feed the
paths on the standard input".  

But it doesn't have one.

