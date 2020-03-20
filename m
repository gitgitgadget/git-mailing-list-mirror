Return-Path: <SRS0=v+yc=5F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CFC5C4332E
	for <git@archiver.kernel.org>; Fri, 20 Mar 2020 22:24:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA7F120709
	for <git@archiver.kernel.org>; Fri, 20 Mar 2020 22:24:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="wSaFHas6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbgCTWYY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Mar 2020 18:24:24 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53546 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbgCTWYX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Mar 2020 18:24:23 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 545A15E01D;
        Fri, 20 Mar 2020 18:24:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vNyfj9SM4tNWncFUOcKABZcHreg=; b=wSaFHa
        s65Jq63kOISqHWRfBb65uwyi+S53Ohx0WaXF+SzNECm/Bq+frfuVfEi+pbWXz8xg
        hnlBQs0Kp4X1Td9be4xDZuAiUAuKuRJCCrVRrK9d95wtiF/X378PIcIFgtFhvp3A
        e6XY2ibbGc0GDGLBkGGSBlVIjJxCLQVPh1MzY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=v0EmWLXAExQueUOHAsRki1oR3ct1Hl4y
        wuP4DaSC40dS1OXfp+34HZPtdaYNQMoT5Nq8O5QqY7SEAgNrJjZav9KlavpnWd93
        BaI+O3ioPHdF1OPOBSsDjYAzoIruFhjppR5xvwZusT+obzaDPg1ppGPU030GboRT
        /aTimG7TcE4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4BF5F5E01C;
        Fri, 20 Mar 2020 18:24:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CEE9F5E01B;
        Fri, 20 Mar 2020 18:24:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] t3419: prevent failure when run with EXPENSIVE
References: <20200320213916.604658-1-sandals@crustytoothpaste.net>
        <CABPp-BGiP7eG7Ojt8FKV5PUBFk74pkO6jnOwJEZbDzBjdJUm5w@mail.gmail.com>
Date:   Fri, 20 Mar 2020 15:24:20 -0700
In-Reply-To: <CABPp-BGiP7eG7Ojt8FKV5PUBFk74pkO6jnOwJEZbDzBjdJUm5w@mail.gmail.com>
        (Elijah Newren's message of "Fri, 20 Mar 2020 14:44:41 -0700")
Message-ID: <xmqqeetmbr6z.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8C216DD0-6AF9-11EA-9F94-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

>> -               rm -rf .git/rebase-apply
>> +               rm -rf .git/rebase-merge .git/rebase-apply
>>         '
>>  }
>
> Good catch, thanks.  Perhaps we just want to invoke 'git rebase
> --quit' and let it clean up instead of manually doing so ourselves,
> since it may buy us some future-proofing in case we ever want to move
> the place we store rebase state?

I started writing "I would agree 100% if this script were not about
testing 'rebase', but using 'rebase' itself for a framework to test
'rebase'???" but then if 'rebase --quit' fails to clear these, what
we are likely to see is that the next test to fail, so it probably
is an OK approach.

Thanks.
