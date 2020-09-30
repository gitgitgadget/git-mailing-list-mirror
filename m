Return-Path: <SRS0=XLsf=DH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62628C4363D
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 21:05:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EEE32076A
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 21:05:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Uc2crC6u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729785AbgI3VF2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Sep 2020 17:05:28 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54253 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgI3VF1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Sep 2020 17:05:27 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0659C8879B;
        Wed, 30 Sep 2020 17:05:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=RAfPb8mUHUFDSy6dRF6XcJMqPjg=; b=Uc2crC
        6uAgU5Xf44n8JxKurqg7WZ/7uSUdBo8fJk9QXRcGUpXDNqI/Ph77tgmV8rxJJ2ht
        hXNvpYdutEwIZXIXxGw/hfnYPATEy65gkjpW+FGC9IONs6z/o5ogo/Dy2s644a5O
        JPqOmqp2BtPJq98x8buQiHiqyH1zhwiIutPVk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ZqZPY3A1NhE+XQ4H/FfxdxaYdL063lWS
        HjzQQLptAYu4Blnyh7T1r1LJhwiiVBp/f31xZz7pbceLEl1g5EqsNeHcATUcyYZU
        K+LNgWUUWNvqrmM8RK7/7O2+gG7z/UCZxeee7FJsJ2ct4nUsx0KVP6kfBpQkUT5V
        XB15qJB7Aic=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F059288798;
        Wed, 30 Sep 2020 17:05:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7057888797;
        Wed, 30 Sep 2020 17:05:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH v3 1/1] refspec: add support for negative refspecs
References: <20200925210740.1939450-1-jacob.e.keller@intel.com>
        <20200925210740.1939450-2-jacob.e.keller@intel.com>
        <nycvar.QRO.7.76.6.2009301428580.50@tvgsbejvaqbjf.bet>
        <CA+P7+xpDoqspwEG_PABvP33FL-+mo6zXvWxf5FKOiSrydXjBKQ@mail.gmail.com>
Date:   Wed, 30 Sep 2020 14:05:23 -0700
In-Reply-To: <CA+P7+xpDoqspwEG_PABvP33FL-+mo6zXvWxf5FKOiSrydXjBKQ@mail.gmail.com>
        (Jacob Keller's message of "Wed, 30 Sep 2020 13:49:53 -0700")
Message-ID: <xmqqv9fvf018.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A8918220-0360-11EB-829F-01D9BED8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller <jacob.keller@gmail.com> writes:

> Ack.... I swore I fixed this... I'm not sure what happened on my end here.

I do recall adding a SQUASH??? commit on top when I queued the last
round, but I didn't do so for this round (and the patches changed
sufficiently enough that the old squash commit no longer applies).

