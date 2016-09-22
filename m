Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D10E51F4F8
	for <e@80x24.org>; Thu, 22 Sep 2016 20:23:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934981AbcIVUXh (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Sep 2016 16:23:37 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50244 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S934727AbcIVUXg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Sep 2016 16:23:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CE8F03F018;
        Thu, 22 Sep 2016 16:23:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=WBkapiBtrUX59IK34PwTuBLCzS4=; b=sOaLov
        byIAr1xjFf6kd6AX8tGXXM1Er/cMwiLLVSrhKXetP/kv7Sr9KttLSFfP45fH2Ekm
        gjlV6NN795BE3nAQ8SJaCsua0pSKaQFbjS0+r8cEyhkjPXYhX18d2prNZvZwX8id
        CLOJkiGUf/Xk3qxXHZdJQxAWnX/O+/TTjrdk4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=dI1F4bGBZ8z+12kIbyVGoLIYunqWnY00
        vxPRuGp0YjKc690JaRxe6i3MnXR0zcoWeNkAuOa2WQ8M57kYpKvEkViGrNJMAoR3
        AFo9Xn8Plns5AfaJCFSfQ4hd70tUj6CfFvecq2SGllfpsR8iIITNEC7SVmtu8o6R
        m/2ctLBoh30=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C6BC13F017;
        Thu, 22 Sep 2016 16:23:34 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4AFF63F016;
        Thu, 22 Sep 2016 16:23:34 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     santiago@nyu.edu
Cc:     git@vger.kernel.org, peff@peff.net, sunshine@sunshineco.com,
        walters@verbum.org
Subject: Re: [PATCH 1/6] builtin/tag: move format specifier to global var
References: <20160922185317.349-1-santiago@nyu.edu>
        <20160922185317.349-2-santiago@nyu.edu>
Date:   Thu, 22 Sep 2016 13:23:32 -0700
In-Reply-To: <20160922185317.349-2-santiago@nyu.edu> (santiago@nyu.edu's
        message of "Thu, 22 Sep 2016 14:53:12 -0400")
Message-ID: <xmqqbmzf4raz.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6F9CAF38-8102-11E6-9713-C26412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

santiago@nyu.edu writes:

> From: Santiago Torres <santiago@nyu.edu>
>
> The format specifier will be likely used in other functions throughout
> git tag. One likely candidate to require format strings in the future is
> the gpg_verify_tag function. However, changing the signature of
> functions such as for_each_ref or verify_tag would be quite burdensome.

I do not understand the above excuse.  for-each-ref takes a
callback data pointer exactly because it wants you to be able to
extend what data the callback function gets without changing its
signature.  builtin/tag.c::verify_tag() is a helper static to the
file--why should it be "burdensome" to change it to fit your needs?

Adding technical debt by going backwards is never a good idea
especially done to add a new feature that is not desperately needed.

