Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16FBBC432BE
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 18:42:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDEE661027
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 18:42:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243372AbhHZSnX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Aug 2021 14:43:23 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63507 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243371AbhHZSnX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Aug 2021 14:43:23 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 076EE156BEA;
        Thu, 26 Aug 2021 14:42:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=lW5jZf8xpAumgHED1QQ66X9yeEUEH5YDXAzIB/
        J62qk=; b=cbFAEVQZAptNra36fZokIDyTNk8XSQARTFkJNh7KR1Q1aMUkIpQ+9Z
        cs3/H7B2lVw0+uc/W4NUraWAfsSEvdD7BzCDtJLp/dSMXRlquJLZx+uzcLkNcMt5
        hNQDUTy0Ze6extOhe7XFcmJWMq3YlbZf0mMPaJ0k60ulKTYf/MX8k=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id F3EB6156BE9;
        Thu, 26 Aug 2021 14:42:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 4DAD4156BE8;
        Thu, 26 Aug 2021 14:42:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Hoffmeister <stefan.hoffmeister@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: BUG: git diff --name-only ignores --ignore-*
References: <CALhB_QNZJtUoSEE==xBoX3cTxE4duB+QqsSzuyeY7JFMh7sKhQ@mail.gmail.com>
Date:   Thu, 26 Aug 2021 11:42:28 -0700
In-Reply-To: <CALhB_QNZJtUoSEE==xBoX3cTxE4duB+QqsSzuyeY7JFMh7sKhQ@mail.gmail.com>
        (Stefan Hoffmeister's message of "Thu, 26 Aug 2021 08:53:31 +0200")
Message-ID: <xmqqwno8dp4b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5E4C2648-069D-11EC-8750-9BA3EF469F85-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Hoffmeister <stefan.hoffmeister@gmail.com> writes:

> When using the --name-only option on git diff (git 2.33.0),
> command-line parameters such as  --ignore-blank-lines are not
> respected.

I think I've seen something related this one at around

  https://lore.kernel.org/git/xmqq4kkl1atq.fsf@gitster.c.googlers.com/

(look for mention of --name-only in the message).

It would make things more expensive to make --name-only inspect
changes when these options are in effect (iow, the --name-only
currently is about "are these the same blob object?  if not, show
the path" and nothing else) but it would probably be OK, as the user
expresses their willingness to spend extra cycles by explicitly
giving --ignore-* options.

