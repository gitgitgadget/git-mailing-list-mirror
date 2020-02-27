Return-Path: <SRS0=G+lC=4P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80A53C11D3D
	for <git@archiver.kernel.org>; Thu, 27 Feb 2020 17:54:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C54C2469B
	for <git@archiver.kernel.org>; Thu, 27 Feb 2020 17:54:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="eraXhC0c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729773AbgB0RyN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Feb 2020 12:54:13 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57539 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729433AbgB0RyN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Feb 2020 12:54:13 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 59E334036C;
        Thu, 27 Feb 2020 12:54:11 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=bNbr6z5Z0m4eGtQ+edh1lKJjyjs=; b=eraXhC
        0cn7Y14Kzwrkq+8NGkRUEr0D1Og6Qb4Uyqi7oVqjP1k2vEDwk4p4LITDW21hzbPn
        4ZuiSJVZnP+PVI0sPgVSg/7lIEK08sGoyqmUAJuKq9EZ338nXBRmLcZ2I60qt5wv
        gHXtBUQPgIdftL65VfH8C2D3Ussj+41bdrRQ0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=dqvO1ThF+WKuZXYO9E3Gn6tLKUUf2m+s
        WY8au+LR+V0BzVf7JaKzRt1MWB00tlbk+0ahtTf4ATwpKuFkVhNjkMNd1zWmnrHn
        z96fr2Q5St2DTqQrmjzXIYmTGsrEw3hTEE0Z3846WOLmWy/3c2pRntE8EAMVLQcS
        XuOqn+LmWpI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 51E4E40369;
        Thu, 27 Feb 2020 12:54:11 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AD79540368;
        Thu, 27 Feb 2020 12:54:10 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Pascal Roeleven <dev@pascalroeleven.nl>
Cc:     Danh Doan <congdanhqx@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/1] ls-remote: don't use '-h' for options
References: <b0397b3285eab3448a3fd5dd2c50abb9@pascalroeleven.nl>
        <20200227130833.GA10339@danh.dev>
        <03985e4099e82f04709d5ea9ca2a56a6@pascalroeleven.nl>
        <xmqqa754gger.fsf@gitster-ct.c.googlers.com>
        <74969200f4dd2993eece8308a72546c3@pascalroeleven.nl>
Date:   Thu, 27 Feb 2020 09:54:09 -0800
In-Reply-To: <74969200f4dd2993eece8308a72546c3@pascalroeleven.nl> (Pascal
        Roeleven's message of "Thu, 27 Feb 2020 18:39:44 +0100")
Message-ID: <xmqqk147gblq.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 28744D8C-598A-11EA-B656-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pascal Roeleven <dev@pascalroeleven.nl> writes:

> Although I still don't quite agree with the inner workings of this
> command (but I understand the choice because of
> backwards-compatibility),...

Yeah, the unpleasant backstory is that "ls-remote -h" predates the
universal "-h" support offered by the parse-options API by a large
margin.

