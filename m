Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C6714208CD
	for <e@80x24.org>; Tue, 15 Aug 2017 22:24:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752364AbdHOWYj (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Aug 2017 18:24:39 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55717 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751780AbdHOWYi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Aug 2017 18:24:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CEC70A3DD2;
        Tue, 15 Aug 2017 18:24:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=cp1o5Zdskeb/LfpAWcTlNE8HSs4=; b=XZ3xOE
        VSCSOP/Af0c5+6cXJsxjSMeruHj4OCJE4TMSoDRPlQSOrcG/fvux7VkIHbGJ1f3e
        eNZrLP73ZLQf3g6IoKEqfvwMc6rpsaeClnjEYZp3EM+tyyc2UuXV/daqLy8Jddfu
        eDMC2+ysGFiccXuk767TqwQhX1O4g+otn9Xrc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=OdfIBVvsC3DFuRHIwM8RUWZTulc2g8mS
        zpMTawXWwgqkEvVdGqz8d5ycYeRO1Yp8fBlxdi3MJV5fwc55jsqaFZVyyg6DNonr
        R4bS8fPOr6pROA5EsAgapGfsToPoAos+1pq7cA9A2aoAYgC/URleCW1KG/NfXy4i
        tlzFtbCAxnM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C6783A3DD1;
        Tue, 15 Aug 2017 18:24:30 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 29CE9A3DCF;
        Tue, 15 Aug 2017 18:24:30 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Anthony Sottile <asottile@umich.edu>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH/RFC] git-grep: correct exit code with --quiet and -L
References: <20170815203503.12299-1-asottile@umich.edu>
        <xmqqpobwplde.fsf@gitster.mtv.corp.google.com>
        <CA+dzEBnMOoXYaP7QadQ+gzKKJ7OzJKAPwbW=zr=1fksCQNBVcw@mail.gmail.com>
Date:   Tue, 15 Aug 2017 15:24:29 -0700
In-Reply-To: <CA+dzEBnMOoXYaP7QadQ+gzKKJ7OzJKAPwbW=zr=1fksCQNBVcw@mail.gmail.com>
        (Anthony Sottile's message of "Tue, 15 Aug 2017 14:41:19 -0700")
Message-ID: <xmqqlgmkpizm.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 817C6AC4-8208-11E7-92EC-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Anthony Sottile <asottile@umich.edu> writes:

> Ah yes, I didn't intend to include the first hunk (forgot to amend it
> out when formatting the patch).
>
> I think git's exit codes for -L actually make more sense than the GNU
> exit codes (especially when comparing with `grep` vs `grep -v`) --
> that is, produce `0` when the search is successful (producing
> *something* on stdout) and `1` when the search fails.
>
> Shall I create a new mail with the adjusted patch as suggested above?

I do not mind seeing an updated patch that does not change the exit
status (as you seem to like what we have currently that contradicts
what GNU grep does) but makes it consistent between "--quiet" and
"--no-quiet".  But I would not be surprised if people seeing this
exchange from the sideline are already working on fixing the exit
status and also making sure that the fixed code would produce the
same corrected exit status with or without "--quiet", so an updated
patch from you will likely conflict with their effort.

So if I were you, I'd wait to see what other people would say about
the actual exit codes we give when "git grep -L" is run without the
"--quiet" option, and if they are also happy with the current exit
code, then send in an updated patch.

Thanks.


