Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F72C433E9
	for <git@archiver.kernel.org>; Mon,  8 Feb 2021 22:42:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BBFB64E7A
	for <git@archiver.kernel.org>; Mon,  8 Feb 2021 22:42:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbhBHWmR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Feb 2021 17:42:17 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52981 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbhBHWmQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Feb 2021 17:42:16 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6E25F11D3FF;
        Mon,  8 Feb 2021 17:41:34 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=pfOyaofjke8l
        OZD4p82J+ZHUazc=; b=CwB/RWc9mdLWnq0NJXkLiHlJqjqUdHF9d3gDSu2BYQkn
        1bI0Z0GIm2Z756dUpNiYf/QOu+HKbCR11xPlVptBm40MfLWMu8WV4aU6cb+4w2/N
        ynNZrK3XDLC37QRlscHhUP6EfBxzABoXJqNUjo6DbiINxDr+DhB7ItbpGGbLdnA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=E7zO11
        FeiIYgqI3HZ+L0TfjEBXrP8+5xcPD+UdHP9njP/6fSfFtv1biiXGOYrw6LiAFm5y
        /QJYOVTPHr4M+D29tMNy5o99ohfxfRvo0F1AHM+4hgvhOEtLWpIex1ynbs2V95Lj
        bi/fqn+O3jM0TESn9YY7caURng+MHiSpOma4o=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 67A5411D3FE;
        Mon,  8 Feb 2021 17:41:34 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9FB8411D3FD;
        Mon,  8 Feb 2021 17:41:30 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Eli Schwartz <eschwartz@archlinux.org>, git@vger.kernel.org
Subject: Re: gitattributes export-subst and software versioning
References: <7418f1d8-78c2-61a7-4f03-62360b986a41@archlinux.org>
        <ac1288b8-5cdf-8e1e-702a-815c5fbc2da3@web.de>
Date:   Mon, 08 Feb 2021 14:41:28 -0800
In-Reply-To: <ac1288b8-5cdf-8e1e-702a-815c5fbc2da3@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Mon, 8 Feb 2021 20:46:06 +0100")
Message-ID: <xmqq8s7y41yf.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: C99993F8-6A5E-11EB-9652-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Anyway, we can of course do something like in the patch below.  It
> works, it's easy, it's fast enough for git archive, and it's quite
> hideous.  Hopefully it's bad enough to motivate someone to come up with
> a cleaner, faster solution.

Yeah, I can see it would work, it is no-brainer-easy, it is clean,
and I can believe it would be fast enough and overall, the best
implementation for the purpose of "git archive".

Perhaps not for "log", but then I do not know if there is a good way
to have it natively run inside "log" without major surgery, as the
"describe" operation itself is fairly resource intensive to remember
which tagged commit is the closest to compute description for even a
single commit.

