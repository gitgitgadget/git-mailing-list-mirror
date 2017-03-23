Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 86BAE2095B
	for <e@80x24.org>; Thu, 23 Mar 2017 07:33:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753483AbdCWHdH (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 03:33:07 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55598 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751375AbdCWHdG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 03:33:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 618778479A;
        Thu, 23 Mar 2017 02:16:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=nxcS6ozvrHWvZdh/OuQskHrVlTU=; b=sIarPT
        ePodqPqV+SWsuFGQXWqspYjs/OVq5lVAMLzBfA9v5nKbx4YO0NWmt3wWczmXl9ES
        +jou115VrthuFgAjbGegZY91EdgPkFsJ7utzglZ+V2O0ZNunhihjgbPMjjxul7o5
        BqzDEdEUHWmTwhC+oitNqFOovas3LHvqX0NgI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=eEYK07nfT0svYnlkLzndxU6SydY+qlpf
        A8fR4HeZ3BQZ7wZa45ZvdqJ436Pxa6QTNHZtf+j+fiCTacvieXQmIC4IlovZcIKv
        5sfEoEZE6DxbownfE+TAQWGa6p7uozXmXwAluuCkBYCMEHT1v7Hje/SlFfEFZHTf
        Jm0tyfzWmmQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 473DC84798;
        Thu, 23 Mar 2017 02:16:39 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 92F9A84795;
        Thu, 23 Mar 2017 02:16:38 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ben Peart <peartben@gmail.com>
Cc:     git@vger.kernel.org, benpeart@microsoft.com,
        christian.couder@gmail.com, larsxschneider@gmail.com
Subject: Re: [PATCH v1 2/3] sub-process: refactor the filter process code into a reusable module
References: <20170322165220.5660-1-benpeart@microsoft.com>
        <20170322165220.5660-3-benpeart@microsoft.com>
Date:   Wed, 22 Mar 2017 23:16:37 -0700
In-Reply-To: <20170322165220.5660-3-benpeart@microsoft.com> (Ben Peart's
        message of "Wed, 22 Mar 2017 12:52:19 -0400")
Message-ID: <xmqqk27gfrga.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 464058AC-0F90-11E7-809D-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ben Peart <peartben@gmail.com> writes:

> This code is refactored from:
>
> 	Commit edcc85814c ("convert: add filter.<driver>.process option", 2016-10-16)
> 	keeps the external process running and processes all commands

I am afraid that this organization of the patch series is making it
harder than necessary to review, by duplicating the same code first
_WITH_ renaming of symbols, etc., in this step and then updaing the
original callers while removing the now-stale original callee
implementation in a separate next step.

Would it perhaps make it clearer to understand what is going on if
you instead started to update the code in convert.c in place to make
it more suitable fro reuse as the patch title advertises, and then
move the resulting cleaned-up code to a separate file, I wonder.

