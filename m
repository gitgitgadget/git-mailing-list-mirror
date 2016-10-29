Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8CADC2021E
	for <e@80x24.org>; Sat, 29 Oct 2016 01:11:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933767AbcJ2BL2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Oct 2016 21:11:28 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50021 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752423AbcJ2BL1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2016 21:11:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4DBE94AE67;
        Fri, 28 Oct 2016 21:11:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xG9RzQavhizl1hJqAKqOzAYfu4g=; b=W1iVJf
        90Kw4dMcVYtT/x6FY5oE83mcx8xbRiMKdcV7vRybWphJPpTRiXHbY0N4mUI3njuD
        SMi9wY1KmLG9NuuzFhLJNUC2I3/zAZHhbOqp0W/VDZ45w+hNdUaSUtggkLs7NV78
        +1aMjbVyJnEsiWCdRw0LroaT0b0xnrraz2WY4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=k+W9LYblcZVYjb26HED4wVD/61m2uMpk
        vMbyufEDhPLovm5NewdisU0AX70bRfbW3G9z44flyrBbh4F7KqERz51yWbXj9hK4
        uxTMsNto6b+BKFcqjBHlHpTb5WVhaaKwpRlvr3JhsaWnoqIypnBLdqFypAixruoa
        /YIn5wCjShA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3FBF94AE66;
        Fri, 28 Oct 2016 21:11:26 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9B5234AE64;
        Fri, 28 Oct 2016 21:11:25 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matt McCutchen <matt@mattmccutchen.net>
Cc:     git@vger.kernel.org
Subject: Re: Fetch/push lets a malicious server steal the targets of "have" lines
References: <1477690790.2904.22.camel@mattmccutchen.net>
        <xmqqmvhoxhfp.fsf@gitster.mtv.corp.google.com>
        <1477692961.2904.36.camel@mattmccutchen.net>
Date:   Fri, 28 Oct 2016 18:11:23 -0700
In-Reply-To: <1477692961.2904.36.camel@mattmccutchen.net> (Matt McCutchen's
        message of "Fri, 28 Oct 2016 18:16:01 -0400")
Message-ID: <xmqq7f8sx8lg.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9CF63DEE-9D74-11E6-BF6C-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matt McCutchen <matt@mattmccutchen.net> writes:

> Then the server generates a commit X3 that lists Y2 as a parent, even
> though it doesn't have Y2, and advances 'x' to X3.  The victim fetches
> 'x':
>
>            victim                  server
>
>              Y1---Y2----                      (Y2)
>             /           \                         \ 
>     ---O---O---X1---X2---X3   ---O---O---X1---X2---X3
>
> Then the server rolls back 'x' to X2:
>
>            victim                  server
>
>              Y1---Y2----
>             /           \
>     ---O---O---X1---X2---X3   ---O---O---X1---X2

Ah, I see.  My immediate reaction is that you can do worse things in
the reverse direction compared to this, but your scenario does sound
bad already.

