Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96FBBEE4993
	for <git@archiver.kernel.org>; Mon, 21 Aug 2023 19:00:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbjHUTAk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Aug 2023 15:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjHUTAj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Aug 2023 15:00:39 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FFDC3C8C
        for <git@vger.kernel.org>; Mon, 21 Aug 2023 12:00:05 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2D7DB1BA986;
        Mon, 21 Aug 2023 14:39:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=VtNE03dAbPbiumjGdpnKZiiA4YBsWEpbifW68U
        TMPGE=; b=NuFqcGg5u2dAfF50WB0IaLhIRoFRyd0vnTOzdCGN0tn8mNVlE6QhUp
        otHO/NxLuCE7Ux4lhaQ/EwpDKdRZWnyK+pnxo+gBBUsptRf+aLss3TvK8w9NG7k3
        0yhPwq/E62ZjM04uZCC07XbXvKltt2BEdnruE0SO1CGrVD8vDO1iI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 25F601BA985;
        Mon, 21 Aug 2023 14:39:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.58.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 800C71BA984;
        Mon, 21 Aug 2023 14:39:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Romain Chossart <romainchossart@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] diff: handle negative status in diff_result_code()
References: <CAHxTZ4AUxow1p7mNG0fuRtfhkaOu=Wpc7cYvM8wRaB80hPNf9Q@mail.gmail.com>
        <20230821003532.GA1113755@coredump.intra.peff.net>
        <xmqqlee4s82d.fsf@gitster.g>
        <20230821180943.GA2617193@coredump.intra.peff.net>
Date:   Mon, 21 Aug 2023 11:39:36 -0700
In-Reply-To: <20230821180943.GA2617193@coredump.intra.peff.net> (Jeff King's
        message of "Mon, 21 Aug 2023 14:09:43 -0400")
Message-ID: <xmqqfs4cp7dj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 14CB1DF8-4052-11EE-A962-25B3960A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> That would make the code simpler. It does feel a bit like going in the
> opposite direction of recent "pass errors up the stack rather than
> dying" libification efforts. I think that's OK for the builtin_* helpers
> in diff.c, which are just serving the diff porcelain. But things like
> run_diff_files(), while pretty big operations, are something we might
> call as small part of another operation (like git-describe).

True, for things in diff-lib.c we likely would want to go in the
opposite "return an error to be handled by the caller" route.
