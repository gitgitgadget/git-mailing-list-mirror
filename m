Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F41821F4C0
	for <e@80x24.org>; Sun, 10 Nov 2019 06:25:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbfKJGZs (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Nov 2019 01:25:48 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60120 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbfKJGZs (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Nov 2019 01:25:48 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 58479AAD9C;
        Sun, 10 Nov 2019 01:25:46 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=uTOnLeBgozdM
        ygFSY8mA8R0jxpA=; b=sin8phV3JdnzCw9QozAbkypQy3YUaB+7RpsIS3I/G30k
        cnyZrT4iueelaHzd2qZSveic83fo/pjxIRQ9oMuiIhcBBlKGEoBI6G0J86/AvHyC
        Eqn+vjnwScJFnJwsUy6TKkxguZEi3JcBsemvys0xFqy3vNKk7LrVVFAuSfvDrbE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=SgEi+D
        RztAwKa5co8cCxLP1D1l6dE1EZ85xlw4rkiMwceKmhfZ9mmPl3lWNYAAJUguVzUm
        sA6Qx5TlIwoboeX1EC8cMmKJO/7MWJqJ9quoVouNqdNGMS2tGmiCPQFlRnYTt6Vv
        fWEXB7n8vuAQBdB/VPLlpOQazFpqxkoMwqFII=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 42C05AAD9B;
        Sun, 10 Nov 2019 01:25:46 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 6425FAAD9A;
        Sun, 10 Nov 2019 01:25:43 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 09/10] pretty: implement 'summary' format
References: <cover.1572897736.git.liu.denton@gmail.com>
        <cover.1573241590.git.liu.denton@gmail.com>
        <e74eab6d21f655698ef8b6e1286b44ea070a7af7.1573241590.git.liu.denton@gmail.com>
        <08afdbcd-5972-05f9-ec8c-b12bd29d9030@web.de>
Date:   Sun, 10 Nov 2019 15:25:41 +0900
In-Reply-To: <08afdbcd-5972-05f9-ec8c-b12bd29d9030@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Sat, 9 Nov 2019 07:38:13 +0100")
Message-ID: <xmqqftiwl02i.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: EC5BA14A-0382-11EA-8B45-8D86F504CC47-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Hmm, that's quite a lot of code to add to the formatting code with its
> repeated special-case checks.  Why not implement it as a built-in user
> format, like making it an alias for something like this?
>
>    git log --format=3D'%C(auto)%h ("%s", %as)'
>
> We don't have %as, yet, but making --date=3Dshort available as a
> placeholder would be a good idea anyway (patch below).

Yes!  Implementing the 'summary' internally as merely an alias to a
canned user format does sound like the right approach.

Further, instead of inventing %as, I think you could just use %ad
there, and when 'summary' uses that canned user format, flip the
default date format to short.

That way, "git show -s --pretty=3Dsummary --date=3Diso" would be
available to those who like the format.

Thanks.
