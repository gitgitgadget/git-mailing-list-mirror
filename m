Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84AF3C4742C
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 23:23:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AD3B207E8
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 23:23:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="RMHB5ifX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731713AbgKJXXB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Nov 2020 18:23:01 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57021 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726706AbgKJXXA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Nov 2020 18:23:00 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E52CF10F987;
        Tue, 10 Nov 2020 18:22:58 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=CjqkQG+gHeHeWbLkfx1XHfe8a8o=; b=RMHB5i
        fXAU6pv5kECFWBfagO9zRIChSmlQTB8Sfa57fkn0txRAc/BsfEjUh1pk5L+m/UQf
        7AydYfKAzKs7KR4McLlJ97ED6wGczad206DRhh4+kSYjay+FRL5zl0WGhKGDklIH
        gArT6AUr8MUSxW5xzqMimVoyBDCZs9rEocRuk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=MICRj16CwrY3qhboy3qiyABwxNSsuvLC
        tuaSelLv2eb+5gqwzGR6xbYGdqv0O9cyKSnE+IzYSFhhznQZ3mKwApirjN6HYvwL
        gxoC4IA9x6GKCaQilp7kvDekyBj1Iwc5oswhh93xnMekc0jK0uWJZdYlqFYCG10j
        muEJr1ZG1D0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DE7F410F986;
        Tue, 10 Nov 2020 18:22:58 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 330CB10F985;
        Tue, 10 Nov 2020 18:22:56 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Brandon Richardson <brandon1024.br@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: format-patch: "magic" mbox timestamp
References: <CAETBDP6d8UwiJEF_pX0p=xLG79pwHeEtectmOnjPiUpjUCPaqw@mail.gmail.com>
        <nycvar.QRO.7.76.6.2011102347320.18437@tvgsbejvaqbjf.bet>
Date:   Tue, 10 Nov 2020 15:22:54 -0800
In-Reply-To: <nycvar.QRO.7.76.6.2011102347320.18437@tvgsbejvaqbjf.bet>
        (Johannes Schindelin's message of "Wed, 11 Nov 2020 00:12:05 +0100
        (CET)")
Message-ID: <xmqqimac6bld.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A9EDAB06-23AB-11EB-B76E-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> The original magic timestamp, however, was the one I reintroduced, and as
> you can see from the part I quoted above, I only imitated the original
> script.

That's almost a lifetime ago that I totally forgot that it was
original a shell script.  

It indeed does this:

+	case "$mbox" in
+	t)
+	    echo 'From nobody Mon Sep 17 00:00:00 2001' ;# UNIX "From" line
+	    mailScript="$mailScript"'
+	    s|^|Subject: [PATCH'"$num"'] |'
+	    ;;

which clearly shows that "nobody" was chosen to mimic a real mailbox
(i.e. unlike what Brandon said in the other message, the <mailbox>
may not have "@" <domain> after <local-part>).

In any case, I think what's more important is after 15 years, if any
implementation of the /etc/magic database actually take advantage of
that magic date as the "magic" signal to identify a format-patch
output.  Despite the wishes of original authors and designers of Git
and its format-patch output, perhaps no /etc/magic author noticed it,
in which case it is safe to use other randomly picked dates, or the
timestamp of underlying commits.  Otherwise, changing the "magic"
timestamp would introduce a needless regression.

