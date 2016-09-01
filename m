Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 610491F6BF
	for <e@80x24.org>; Thu,  1 Sep 2016 22:21:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752117AbcIAWVC (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Sep 2016 18:21:02 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60157 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750771AbcIAWVB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2016 18:21:01 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 536673A0E4;
        Thu,  1 Sep 2016 18:21:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wQkXrqthOvAojVyIuCLS5L7OMxc=; b=DEfZWd
        0PcZcRB9qU2sXFJ1OXdj8799qnAbAZqtWZajRo+bE44ppnzWj+l4/YzZIbHqFEwQ
        popY2HuiocBFgShxs58JXBuV349WI0QJ31WHMKh7lgpvofBr61uYiR2MkaXNUhIC
        3EwRMBLhxaoOQk1RVnvlo9Qygk/z53MEUQ4fY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=RV5RKKdrHWEZqfbmPgN0mgLSNhgqVGNa
        LSQbVZHmbYXvOQl9q0cZ2V7DUzKqr9RDhL8Re6nuvJG90WISzZwIJoVRrvhejg+j
        N3vcdu0iseGsKdkFSOH99obUsdoZpJqWEl0zxJGdvWvnv2REP/R8+9Mcp9cNmb1h
        zni0G4XN4VY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4B0873A0E3;
        Thu,  1 Sep 2016 18:21:00 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C17BC3A0E2;
        Thu,  1 Sep 2016 18:20:59 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Philip Oakley" <philipoakley@iee.org>
Cc:     "Git List" <git@vger.kernel.org>
Subject: Re: Are --first-parent and --ancestry-path compatible rev-list options?
References: <2FA1998250474E76A386B82AD635E56A@PhilipOakley>
        <xmqqfuprdtwh.fsf@gitster.mtv.corp.google.com>
        <CD6AE25418644EB688D4488F8AB40155@PhilipOakley>
        <xmqq8tvby19a.fsf@gitster.mtv.corp.google.com>
        <1BC836ACA8C741AD9732122B3B198752@PhilipOakley>
Date:   Thu, 01 Sep 2016 15:20:57 -0700
In-Reply-To: <1BC836ACA8C741AD9732122B3B198752@PhilipOakley> (Philip Oakley's
        message of "Thu, 1 Sep 2016 21:48:14 +0100")
Message-ID: <xmqqd1knuura.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5C55BA58-7092-11E6-ACD7-F7BB12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Philip Oakley" <philipoakley@iee.org> writes:

> The user question was, given a commit 'J', and a future commit 'H'
> (typically a branch tip such as 'master'), find those commits that are
> :
> A) merges
> B) on the first parent DAG chain of the future commit 'H'
> C) children of the given commit 'J'

The answer then is that there is no such single step operation.

In the picture, if D or E were a merge from a side branch that does
not have anything to do with 'J', "log --first-parent --merges" will
not exclude it (i.e. C won't be fulfilled by --first-parent --merges).

