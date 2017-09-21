Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 25C1A20281
	for <e@80x24.org>; Thu, 21 Sep 2017 05:29:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751581AbdIUF3e (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Sep 2017 01:29:34 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52172 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750912AbdIUF3d (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Sep 2017 01:29:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 97CD7958A1;
        Thu, 21 Sep 2017 01:29:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=rOth0+oP/zmfM9FUWyG/W6BfuFk=; b=ujebDT
        WUfIEQDL2ZxwOIbn6wugN20jlSofP6det78SJ1d1rZ+9ccH24kB7ustsOAJGZiJ9
        Gp8/Kp10M3NryxW/3Me/3wQHS/KI/uIj/VKKJIG/ZF2jX6TM9Bk/SIl4g40jlPJb
        uBNajxT64aLcMsfh0APXRFDvHApHHmpsWO2MY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qagfCsA6yj//n3pGRRaGs76C0txyFqkp
        aOYZmC59FOs0iYaH53//yUZpbbXF6+BoDye23TWP8tqLqZCfuqWfEBh7aOcvk7A9
        Oz/mh8bQFHVItykf39F+CK+3378iY3CkKKJY4RTOcIYSjnDXH9ilicUEttJLET25
        rheTRz1L02Q=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8EECA958A0;
        Thu, 21 Sep 2017 01:29:32 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EE1269589F;
        Thu, 21 Sep 2017 01:29:31 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH] git: add --no-optional-locks option
References: <20170921043214.pyhdsrpy4omy54rm@sigill.intra.peff.net>
        <xmqqbmm4lkf5.fsf@gitster.mtv.corp.google.com>
        <20170921050835.mrbgx2zryy3jusdk@sigill.intra.peff.net>
Date:   Thu, 21 Sep 2017 14:29:30 +0900
In-Reply-To: <20170921050835.mrbgx2zryy3jusdk@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 21 Sep 2017 01:08:36 -0400")
Message-ID: <xmqq377gliv9.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D89E3552-9E8D-11E7-9A26-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I admit that's just adding more hand-waving to the pile. But I don't
> think it really _hurts_ to leave that door open (aside from making the
> documentation a bit wishy-washy). And it helps because callers would
> pick up the new features automatically, without having to learn about a
> new option.

Oh, I do agree it is a good idea to leave that door open, so that
scripts that rely on today's --no-optional-locks option will not
have to be updated when a similar feature (like the "ref compaction"
example you mentioned) against which "let's disable when we are not
the primary process, in order to keep the interference to the
minimum" would be something we would want to say.  The option being
added here should cover these future needs.

> And I think that's really what this option is. It is less about the
> caller asking for some specific behavior, and more about them telling
> Git about the context in which it's executing so it can make intelligent
> decisions.

Yes, indeed.
