Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0802120986
	for <e@80x24.org>; Tue, 27 Sep 2016 16:55:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935099AbcI0Qzj (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Sep 2016 12:55:39 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62656 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S934185AbcI0Qzh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2016 12:55:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C6C133C997;
        Tue, 27 Sep 2016 12:55:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/x9xHzSFS2UcYfXbhfgIpkGl8fQ=; b=NRqh5B
        XbIK1poXDks6HQFP3+ndaFk/xz/XNBciawpCfK8DLV021pgGw1pLvnb7yFt6NjdW
        auiCXhpgFFy81xDHC33+A64XOCMaygGn4dDy5GlgzbTsaXGKptfoNyuc6QVIIb+r
        J/iQXPMateVBNRRT8QxKycGyH2k86FhyPzI9o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=U9Z4csoqLPDXzzACmBKLUqZ/qgX35lvR
        V4AOEJeMe39v+2o45C+lcCqGKmytkCMnSNGg/hX6zwqpw7uiFLquwDsytHdwo3O7
        f1aGG/QE0LAaI7870nXS+xSSTfQ3tHDEj/5U2Pf0zqBE2PCuxu+RxBbBz+6aowYH
        4TEW/3uFlKk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BD4693C996;
        Tue, 27 Sep 2016 12:55:35 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 245D53C994;
        Tue, 27 Sep 2016 12:55:35 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     David Turner <dturner@twosigma.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH v3 1/3] tree-walk: be more specific about corrupt tree errors
References: <1474989806-5002-1-git-send-email-dturner@twosigma.com>
Date:   Tue, 27 Sep 2016 09:55:33 -0700
In-Reply-To: <1474989806-5002-1-git-send-email-dturner@twosigma.com> (David
        Turner's message of "Tue, 27 Sep 2016 11:23:24 -0400")
Message-ID: <xmqqwphxp9iy.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 357B8A5C-84D3-11E6-9E22-EAAE7A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

David Turner <dturner@twosigma.com> writes:

> From: Jeff King <peff@peff.net>
>
> When the tree-walker runs into an error, it just calls
> die(), and the message is always "corrupt tree file".
> However, we are actually covering several cases here; let's
> give the user a hint about what happened.
>
> Let's also avoid using the word "corrupt", which makes it
> seem like the data bit-rotted on disk. Our sha1 check would
> already have found that. These errors are ones of data that
> is malformed in the first place.
>
> Signed-off-by: David Turner <dturner@twosigma.com>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  t/t1007-hash-object.sh | 21 +++++++++++++++++++--
>  tree-walk.c            | 12 +++++++-----
>  2 files changed, 26 insertions(+), 7 deletions(-)

Nice that we now prepare the test data ourselves without shipping as
part of the source.

