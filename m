Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C9D871FAFB
	for <e@80x24.org>; Tue, 28 Mar 2017 22:34:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932242AbdC1Wdy (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Mar 2017 18:33:54 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54192 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752870AbdC1Wdx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2017 18:33:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6DDBB74173;
        Tue, 28 Mar 2017 18:33:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2Z4jbo/WJ1oiseZFUY4qoIup7Lg=; b=THGp/r
        QfI7Z4cd3S/6tn/LUbpruQ606ce2HOTYC0xuAU1fCsBH/zDxMY1DqbkRmgzhQrAo
        YvpRPuKEvZd/hhOMDDZXlgypfgusGqtlf2j1/eG3PzSLMf30AG/GMho5DzvF7EEe
        RvsnF6yHjtJ0nIHKLNy7sSBLHjR5CbilkU1JA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=svO6gP4FDZmpUPYP0n1V8mzmnJmSa1j8
        ySh2RzKa47wkIyUT+u2XkkYOrgWdhAm46Z3s3SH8b3HI4aKX4DkoZ365EqSTyGP+
        AGbkFrC2eXcpqPAQJnRCUO7Yv6a0sS2FAFqZx6VF4Z2vVjDmYqg73pRXr4cYkeRF
        JaHM8s4YITI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 66DAF74172;
        Tue, 28 Mar 2017 18:33:51 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 06A6574170;
        Tue, 28 Mar 2017 18:33:49 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/18] snprintf cleanups
References: <20170328194255.vf7nfzzmmzxsbn36@sigill.intra.peff.net>
Date:   Tue, 28 Mar 2017 15:33:48 -0700
In-Reply-To: <20170328194255.vf7nfzzmmzxsbn36@sigill.intra.peff.net> (Jeff
        King's message of "Tue, 28 Mar 2017 15:42:56 -0400")
Message-ID: <xmqq60itc9pv.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9D5A6B44-1406-11E7-A718-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> It's a lot of patches, but hopefully they're all pretty straightforward
> to read.

Yes, quite a lot of changes.  I didn't see anything questionable in
there.

As to the "patch-id" thing, I find the alternate one slightly easier
to read.  Also, exactly because this is not a performance critical
codepath, it may be better if patch_id_add_string() filtered out
whitespaces; that would allow the source to express things in more
natural way, e.g.

		patch_id_addf(&ctx, "new file mode");
		patch_id_addf(&ctx, "%06o", p->two->mode);
		patch_id_addf(&ctx, "--- /dev/null");
		patch_id_addf(&ctx, "+++ b/%.*s", len2, p->two->path);

Or I may be going overboard by bringing "addf" into the mix X-<.
