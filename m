Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AA53C433E0
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 18:36:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1808F64E63
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 18:36:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbhBPSgW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Feb 2021 13:36:22 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59590 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230410AbhBPSgF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Feb 2021 13:36:05 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id F114D1193D9;
        Tue, 16 Feb 2021 13:35:22 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=uz40GueRCy11
        ANwZNhcTf9IbcTo=; b=LWOAWbjx4EoY37s3SCtmGBkvWqzqQHJREOeGfrLgSWvi
        AY3W0AuXxkHIrOHomR/DjZJqpZOPeqYXJtPrm5epPN8uEfoYv/EUqbSNsM78f2nT
        nJC9riQ0fmuMu5WZ+F9xmFqoON4rBAhqAxj99dY2Z74W/zbhXBa5aUMSuUkXOYo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=K69HXl
        Mb1w7TKiR/CANDlCXjTiWNEpjmncIX73ChRaeN4Z3fxk9W/bOyrYOlPXraB2v2eX
        Zxeq68V8XArQOVL91zlel+Bf+blNmk1KcJwrKQ4yxA0HDp3EURM4mfeTqfNOCjWQ
        HBXMIg3anaMALbzMBOdWp/dMcWD1BqtC3vAoo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D6C451193D8;
        Tue, 16 Feb 2021 13:35:22 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.243.138.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 17F341193D5;
        Tue, 16 Feb 2021 13:35:20 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Adam Spiers <git@adamspiers.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Chris Torek <chris.torek@gmail.com>
Subject: Re: [PATCH v2 12/27] userdiff tests: rewrite hunk header test
 infrastructure
References: <20210215005236.11313-1-avarab@gmail.com>
        <20210215154427.32693-13-avarab@gmail.com>
Date:   Tue, 16 Feb 2021 10:35:18 -0800
In-Reply-To: <20210215154427.32693-13-avarab@gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Mon, 15 Feb 2021 16:44:12 +0100")
Message-ID: <xmqqo8gjrhcp.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: B8F7D280-7085-11EB-8692-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Rewrite the hunk header test infrastructure introduced in
> bfa7d01413 (t4018: an infrastructure to test hunk headers,
> 2014-03-21).

Is this "oops, we added something unacceptably ugly in 09/27 and
this step fixes it"?  Please don't.
