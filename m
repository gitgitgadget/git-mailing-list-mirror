Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B4AFEB64DD
	for <git@archiver.kernel.org>; Fri, 23 Jun 2023 09:52:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231165AbjFWJwt (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jun 2023 05:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231236AbjFWJwl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jun 2023 05:52:41 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 633A41A3
        for <git@vger.kernel.org>; Fri, 23 Jun 2023 02:52:40 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4E18E35076;
        Fri, 23 Jun 2023 05:52:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=1Mo28f44QeC/
        TWWeuZyn2HedJ979AX4xSnKW9yAc0Z8=; b=GeOe6FE18QRY5lNYTAcRnrfqY55W
        OUk1WyqF4UBTWQwqp1TbPBYzdjOAU2Gg8ZFnhabLYKYl/P81kzTtev+a53jN1Nu/
        7LatAF7cX7zBsQ45Jw9aPn4o30mCxr1OCkCJUEGT31s4Y0/1JV4qY1hqxEOdNh+5
        iFMPELyJp0KnNXE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 46ACA35075;
        Fri, 23 Jun 2023 05:52:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.62.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6839835074;
        Fri, 23 Jun 2023 05:52:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Konstantin Kharlamov <hi-angel@yandex.ru>
Cc:     git@vger.kernel.org
Subject: Re: Getting path to a file from arbitrary project directory
References: <21c8396c1441dd4f74cd2097ac970a2033b81da4.camel@yandex.ru>
Date:   Fri, 23 Jun 2023 02:52:29 -0700
In-Reply-To: <21c8396c1441dd4f74cd2097ac970a2033b81da4.camel@yandex.ru>
        (Konstantin Kharlamov's message of "Fri, 23 Jun 2023 11:52:58 +0300")
Message-ID: <xmqqzg4qbj4y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: AB33ACC2-11AB-11EE-98AE-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Konstantin Kharlamov <hi-angel@yandex.ru> writes:

> 1: the usecase is I have a Emacs helper function to pick up a an
> aribtrarily mangled path to a file in the project from the primary
> clipboard and open that file. It's often "mangled", because gdb
> prints it with `../`, then logs print no path whatsoever, just a
> filename=E2=80=A6 So it's generally useful to have.

Sounds like you are looking for the top (and possibly glob) magic
pathspec, e.g. in the source tree of Git itself, I can go a few
levels down into a random directory and get exactly the same listing
of two files whose name is "rerere.c" located in two directories:

    $ cd t/helper
    $ git ls-files --full-name ':(top,glob)**/rerere.c'
    builtin/rerere.c
    rerere.c

Look for magic pathspec in "git help glossary" to learn more.


