Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D249B1FD99
	for <e@80x24.org>; Tue, 23 Aug 2016 23:08:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754385AbcHWXIB (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Aug 2016 19:08:01 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60114 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754331AbcHWXIB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Aug 2016 19:08:01 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B5CE4377E6;
        Tue, 23 Aug 2016 19:07:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=z5yvabSG8iVO8Hy8k/vpb4nlO8U=; b=cRcFs8
        pGll6Y7qwHm/OzSHawKNMgxwP3LH0UskRBA1Xz8NQTGJhsh9bzDSjEd5uq4WB3o0
        VQNw5teiH4PtKkPkxFESPmWecLh8YhxMYWvGWg0EumuBW/b7ThkYyOEwFAXsZ2Ww
        0OVg58FQYVV+tpWSZHEQW4SnorenDw2kChcM0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=uo5LN1wvcaNS7bOUT5wI0RQk0YnKAIqA
        ekc0QURNtkCA0ngMqo6dPWiy6CDxMhTCmVlgi/7FPMDNCFhLPu7EfLD4m56I1WHF
        k3D7S58q9TwLocM3ZfNYm0LBVNkmRQ+fZZnasHs38tOCgRwFgRw4OD0IxIRLiK0J
        7mlzaHqKXWo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id ADD74377E5;
        Tue, 23 Aug 2016 19:07:59 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 381B5377E4;
        Tue, 23 Aug 2016 19:07:59 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Keller <jacob.e.keller@intel.com>
Cc:     git@vger.kernel.org, Stefan Beller <stefanbeller@gmail.com>,
        Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v10 8/9] submodule: refactor show_submodule_summary with helper function
References: <20160822234344.22797-1-jacob.e.keller@intel.com>
        <20160822234344.22797-9-jacob.e.keller@intel.com>
Date:   Tue, 23 Aug 2016 16:07:57 -0700
In-Reply-To: <20160822234344.22797-9-jacob.e.keller@intel.com> (Jacob Keller's
        message of "Mon, 22 Aug 2016 16:43:43 -0700")
Message-ID: <xmqqfupvt776.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6F2BE82C-6986-11E6-9C32-FCB17B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller <jacob.e.keller@intel.com> writes:

> From: Jacob Keller <jacob.keller@gmail.com>
>
> A future patch is going to add a new submodule diff format which
> displays an inline diff of the submodule changes. To make this easier,
> and to ensure that both submodule diff formats use the same initial
> header, factor out show_submodule_header() function which will print the
> current submodule header line, and then leave the show_submodule_summary
> function to lookup and print the submodule log format.
>
> This does create one format change in that "(revision walker failed)"
> will now be displayed on its own line rather than as part of the message
> because we no longer perform this step directly in the header display
> flow. However, this is a rare case as most causes of the failure will be
> due to a missing commit which we already check for and avoid previously.
> flow. However, this is a rare case and shouldn't impact much.
>
> Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
> ---

Up to this step it all looked sensible.  I'll take a look at 9/9
later.

Thanks.
