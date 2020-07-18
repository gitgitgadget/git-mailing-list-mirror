Return-Path: <SRS0=BQqG=A5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2E03C433E0
	for <git@archiver.kernel.org>; Sat, 18 Jul 2020 20:10:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90C9C2073A
	for <git@archiver.kernel.org>; Sat, 18 Jul 2020 20:10:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="wWNrPQDS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727856AbgGRUKc (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Jul 2020 16:10:32 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62616 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727042AbgGRUKc (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Jul 2020 16:10:32 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 685F9D90AD;
        Sat, 18 Jul 2020 16:10:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jEv3Ztgbsc8PRMa/0ad1w4fsQU8=; b=wWNrPQ
        DSZdZpTNYoFUeJJmTVbdeVhSCF7+Idt5T6qI6Snw7O1wXE6r2on61plzD0qfenBO
        JNVs2kwuQMtNJZXOhrTks73VrNsGsuR555G+55jk1dUzJ3Mwg9BHqIAwN4E8bgoe
        eZhPZD5ZVqVymTntSIG/lr5yVwaj03+OuE+KA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=n3oh004uTK0qOWEas/q7+r24rcGpBo5p
        zWyw1fmXbVc3Y8akS7rd/HbQhelwezlV/qZrJiovcoEp1WNEueB1Du/HdSN9uncQ
        sHufHJrz2h8xa2V8Flj029bcQ3ipXt4oB3YSNlXUyJRQ1gm4oHTLo/HBAuIjTlWW
        +hktzopOwpY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 61615D90AC;
        Sat, 18 Jul 2020 16:10:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id AEACDD90AB;
        Sat, 18 Jul 2020 16:10:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Drew DeVault" <sir@cmpwn.com>
Cc:     <git@vger.kernel.org>
Subject: Re: [PATCH] git-send-email: die if sendmail.* config is set
References: <C49YLQZUZ4RG.129ZY8FQEYDYU@homura>
Date:   Sat, 18 Jul 2020 13:10:26 -0700
In-Reply-To: <C49YLQZUZ4RG.129ZY8FQEYDYU@homura> (Drew DeVault's message of
        "Sat, 18 Jul 2020 14:25:41 -0400")
Message-ID: <xmqqh7u4bn4d.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B8FBAB1C-C932-11EA-B316-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Drew DeVault" <sir@cmpwn.com> writes:

> I originally had this just a warning, but it can be difficult to see.
> There's a lot of text printed from git send-email, a lot of it looks
> like diagnostics, and it can be easy to lose a message in there. And if
> you pass --annotate, which I encourage people to do, your editor
> immediately covers up the warning.

OK.

> I wonder if a happy medium would be adding a config option which
> squelches the message? If sendemail.squelchConfigError is set, for
> example.

I think with "squelches the message" replaced with "bypasses the
check", it would probably be a good idea.  It may be that a
reasonable behaviour would be to check for any "sendemail.*" and
die, like your version does, by default, an optional opt-out
configuration variable (sendemail.forbidSendmailVariables) to
disable the check entirely, and then add a hint that mentions the
variable to the "die" message in your patch.


