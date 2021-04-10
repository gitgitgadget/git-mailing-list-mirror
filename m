Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3139FC433ED
	for <git@archiver.kernel.org>; Sat, 10 Apr 2021 01:09:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED148610CD
	for <git@archiver.kernel.org>; Sat, 10 Apr 2021 01:09:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235319AbhDJBJs (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 21:09:48 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51218 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235215AbhDJBJq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 21:09:46 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C9707B006D;
        Fri,  9 Apr 2021 21:09:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=5+Ef9k9HnmJpA9sjKxwiDiU7mMc=; b=hu3NBb
        Ux2S21cn6ZhA0s56PzslXn4Elx89aHbzh0Ss690HpQ3SP3g/n4qM8Dn6/LXwH00M
        zp/AsInH6OJCkBndxVezJxAEvfnd5NsMRb05ZG76pxFzCaWLgVIoxyQ65OortPJG
        TeJUWIXc79xPUNRHhzwZRRPYRgCFS1j+2J7Lw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=SBl7+6LqXXxcZJ3EAqXmSXo5fNAbe73T
        QpMPvXl9O70i9XmEWn4aPfXavYO1/0aK61SHgOZ5IgBmhDqz/fjx2uBcHGs4ssTa
        12fEUcKKfkhQ7As9fbHtt6DSkSdFE8Z6hm25zR45Ejn8EBe1k71G1y0lFkUUUNys
        b45TldTldT4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C2C77B006C;
        Fri,  9 Apr 2021 21:09:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.243.138.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5105EB006B;
        Fri,  9 Apr 2021 21:09:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Drew DeVault" <sir@cmpwn.com>
Cc:     <git@vger.kernel.org>
Subject: Re: [PATCH] send-email: clarify SMTP encryption settings
References: <20210409211812.3869-1-sir@cmpwn.com> <xmqqlf9rklkb.fsf@gitster.g>
        <CAJMW3X0O81L.8TNFDEFUNML1@taiga>
Date:   Fri, 09 Apr 2021 18:09:31 -0700
In-Reply-To: <CAJMW3X0O81L.8TNFDEFUNML1@taiga> (Drew DeVault's message of
        "Fri, 09 Apr 2021 20:57:30 -0400")
Message-ID: <xmqqczv3kks4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 68476E30-9999-11EB-8F5A-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Drew DeVault" <sir@cmpwn.com> writes:

>> I couldn't find a justification for our log message to call
>> STARTTLS-style explicit TLS "deprecated". When you send an updated
>> version, please give a reference.
>
> The main concern with STARTTLS is downgrade attacks. I'll note this in
> the commit message for v2.
> ...
> If I may propose a bold alternative: what I added as "ssl/tls", i.e.
> "modern" SSL, should be "yes", no encryption should be "no", and if you
> specifically need starttls: "starttls".

Well, "is starttls deprecated" given to search engine gives me

    SMTPS (implicit SSL) has been deprecated/obsolete since
    SMTP+STARTTLS (explicit SSL) was defined in RFC2487.

as the "featured snippet", and there are debates like "SMTPS has
been deprecated since forever (late 90's or thereabouts)"
https://news.ycombinator.com/item?id=10556797

I strongly prefer to keep our documentation out of that mess by not
taking sides.  To me, both are valid options to make the world safer
over cleartext, and we won't have to make recommendations when both
are available.

Thanks.
