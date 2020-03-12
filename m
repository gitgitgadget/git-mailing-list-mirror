Return-Path: <SRS0=YYoh=45=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91FD5C10DCE
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 18:58:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 682352071B
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 18:58:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="YrPKN6Pw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbgCLS62 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Mar 2020 14:58:28 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59323 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726469AbgCLS62 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Mar 2020 14:58:28 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E986A3B930;
        Thu, 12 Mar 2020 14:58:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=EUYpvUYMNWWHfICVyVx2m7N+qmo=; b=YrPKN6
        PwwkXyREvof5nz/IK/wh9ez5FSqPB+31sfpCJSnzzt8RzaQ5sFuxeIFRuFMHkPIg
        QiVhHaNxZVPZnJGYkLBxvfTU97/Y72PaUAIyvfKldSJYj4aL0tEWsSGTGoTdfyit
        n8i1zjK+TDsUGaeXcbL/wqSXDVKcy+UGSUs70=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=LlLrBAUsoOLzDKz62dArU+PtNjujz2l0
        BJpZj9rlJGEzmbfnW9hbTUcgPB3zcNA0rLfXap5HILYW6xr3sWyMJKUUoT36nVAm
        FOejHfAEgzNtWbvGbB4SGSvEnbsdUlKB88AQR45UQPH3qMl7Nx+F66eJwhlStCfd
        dKYDnXh9NFc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E143A3B92F;
        Thu, 12 Mar 2020 14:58:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6AFFB3B92E;
        Thu, 12 Mar 2020 14:58:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Konstantin Tokarev <annulen@yandex.ru>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [Feature request] "Hooks" for git log
References: <558831584024173@sas1-438a02fc058e.qloud-c.yandex.net>
Date:   Thu, 12 Mar 2020 11:58:24 -0700
In-Reply-To: <558831584024173@sas1-438a02fc058e.qloud-c.yandex.net>
        (Konstantin Tokarev's message of "Thu, 12 Mar 2020 18:06:44 +0300")
Message-ID: <xmqqo8t1flin.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 73D63718-6493-11EA-A2F9-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Konstantin Tokarev <annulen@yandex.ru> writes:

> I think it would be very useful if git log provided new option named e.g.
> --hook or --script, which would take script path as an argument.
> git log would follow it's normal way of operation, applying other filtering
> options it was given, however intstead of printing info on commit that
> matches filters, it invokes script with commit hash as an argument.
> Script can do whatever it needs with hash, including any git operations,
> can print commit info to log if needed, or print something else, or keep
> silence. If script returns non-zero, parent git log command terminates,
> otherwise it continues.

You do not need a hook for that, no?

 $ git log --format='%H' ...your other options here... |
   while read commit
   do
	... your "hook" that checks the $commit to see if
        ... it is "interesting" and shows or discard or whatever
        ... it does comes here
   done

