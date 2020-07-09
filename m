Return-Path: <SRS0=1oE7=AU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFBDDC433E0
	for <git@archiver.kernel.org>; Thu,  9 Jul 2020 01:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A589620708
	for <git@archiver.kernel.org>; Thu,  9 Jul 2020 01:21:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="tRnyc3LI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726122AbgGIBVi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jul 2020 21:21:38 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59684 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbgGIBVi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jul 2020 21:21:38 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2DA28E09F4;
        Wed,  8 Jul 2020 21:21:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KDrX5Lm0sMhiuwJVhG1kqO+iF+I=; b=tRnyc3
        LIRYK/dQcjBBBJ2oj9NyqV1edYUzSJPJcQE/tYDmwOg9IxHffD6YjRmkqh2NyTSi
        2AUAsIq3nPxX6mxikkR8jTNVxB9NkQGdRCpmblVj5XrqafE2AYQYrS28c6Pw+ziK
        Mrj8pXECA6TzNMZhCbmr9v107AfD9qrVsxZlA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=vIuIJRSuflhMnW72zjMFZgTsCnqgAFvO
        FTuLk3TxkwwLvifqzMjSiwbxeOJJa8weJgsyP6wZ7EhtQ1OhjMo9pB1+jlZxYs7w
        MqsUkS5qYigO5J4c3PB3oN4A4RhBN2NX505AMWTXykyaN7z3+WCqJ0Rv2gbg3lK2
        WoNSKUHn628=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2724DE09F3;
        Wed,  8 Jul 2020 21:21:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6C0E3E09F2;
        Wed,  8 Jul 2020 21:21:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        dstolee@microsoft.com, jayconrod@google.com,
        jonathantanmy@google.com
Subject: Re: [PATCH v2] commit.c: don't persist substituted parents when unshallowing
References: <20200707144338.GA26342@syl.lan>
        <1f769bbbb4f1b4ad67d29ee7b3e5282446e4cc0f.1594242582.git.me@ttaylorr.com>
        <20200709010042.GA8720@google.com>
Date:   Wed, 08 Jul 2020 18:21:33 -0700
In-Reply-To: <20200709010042.GA8720@google.com> (Jonathan Nieder's message of
        "Wed, 8 Jul 2020 18:00:42 -0700")
Message-ID: <xmqqpn95zdnm.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 87B01244-C182-11EA-A3F0-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> Taylor Blau wrote:
>
>> Reported-by: Jay Conrod <jayconrod@google.com>
>> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
>> Signed-off-by: Taylor Blau <me@ttaylorr.com>
>> ---
>
> This is indeed
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks, both.
