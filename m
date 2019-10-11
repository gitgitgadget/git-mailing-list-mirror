Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC77A1F4C0
	for <e@80x24.org>; Fri, 11 Oct 2019 04:29:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726243AbfJKE3b (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Oct 2019 00:29:31 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63605 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbfJKE3a (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Oct 2019 00:29:30 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6F8952269F;
        Fri, 11 Oct 2019 00:29:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=m5MY8qHRZQiKWJtk4SRwY9Zmna0=; b=At5ZFT
        PaYoYIcCYn5eI1xePA3GL19BQYnItE4uiVBrXkr2YHn459YN8nZP1ZEiYahkjYf6
        tOJCXJ3Xy2gfw+HVp7m7GAwndB+CZfE8oY5MZ4qLhchamlsRNgX1x91ucjxILLYJ
        tynzEXlZKktnoxQ141UNsDJKigkCeQwIAewf4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=g6qqbBzdb+0p5pxVk+plud4JePn6MBpe
        omA56cvDdSOgy535xvOkH85EERjS+Yt3aANoa+mUNq/dk6b5tK77muRACJHUj3mf
        H1VSFUByCbF1gxVFsdnr4Yfe7eS0EqQfnHUzccDIy3IdqXX+taTm95ji5CpjrXCz
        YiyYwg7V9Wk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 671492269E;
        Fri, 11 Oct 2019 00:29:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C68B22269D;
        Fri, 11 Oct 2019 00:29:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        patchwork@lists.ozlabs.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Eric Blake <eblake@redhat.com>,
        Christian Schoenebeck <qemu_oss@crudebyte.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] parser: Unmangle From: headers that have been mangled for DMARC purposes
References: <20191010062047.21549-1-ajd@linux.ibm.com>
        <20191010194132.GA191800@google.com>
        <20191010225405.GA19475@sigill.intra.peff.net>
Date:   Fri, 11 Oct 2019 13:29:26 +0900
In-Reply-To: <20191010225405.GA19475@sigill.intra.peff.net> (Jeff King's
        message of "Thu, 10 Oct 2019 18:54:06 -0400")
Message-ID: <xmqqblunj461.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B6305472-EBDF-11E9-9A41-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> This might provide an alternate solution (or vice versa). I kind of like
> this one better in that it doesn't require the sender to do anything
> differently (but it may be less robust, as it assumes the receiver
> reliably de-mangling).

I share the assessment.  I also feel that relying on Reply-To: would
make the result a lot less reliable (I do not have much problem with
the use of X-Original-Sender, though).
