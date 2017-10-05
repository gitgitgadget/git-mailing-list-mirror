Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C73F32036C
	for <e@80x24.org>; Thu,  5 Oct 2017 01:38:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751347AbdJEBiw (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Oct 2017 21:38:52 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63297 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751275AbdJEBiv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Oct 2017 21:38:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 56EE3B254A;
        Wed,  4 Oct 2017 21:38:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=RzGbNCjUvyi4
        3v5lUDfzNtBNbsk=; b=kaqMe5GiJGdPHfZiOzSPwnK80ISCe3VRHr79N8EbcUP4
        HfDsOhUc6ca5w7M3cIzntmxKUqgVp4F262KBcBB4WsB/Ambb096dxgPxq7OJmIg5
        gGaQY2MGhQafii57NDws46v4XQQbNpw+xDyHGj56X+Rq5RxKC8V9UokH9ox4Wo0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=dGJefW
        18z+EmnnHyQlQRUNtbfirAs8ZPn4EBAjG/djVi5rXu05P8QQllJqjEQyHa1LZ5dm
        w3aZMc5GEGM0ob7ZrukJz8UMBm64hb+I01NuuR5LyAHuFios/agrGKnSx7k2MhjK
        IY264KKpDD+QyOr5Z2K91MSsTOKwHDyB+pBWk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4D571B2549;
        Wed,  4 Oct 2017 21:38:51 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BAC6CB2548;
        Wed,  4 Oct 2017 21:38:50 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Robert Dailey <rcdailey.lists@gmail.com>, Git <git@vger.kernel.org>
Subject: Re: Line ending normalization doesn't work as expected
References: <CAHd499B5hM9ixnsnwWwB2uyDT10dRQpN473m5QjxH9raHtFXiw@mail.gmail.com>
        <958c9b03-062c-0bea-3b25-939a36659f32@web.de>
        <CAHd499AD5Kgbp-vxXTnEPkb-Mb5oEeXhaRO5kGniDdqmXwd2QQ@mail.gmail.com>
        <88c57b88-ef2c-d7db-15e2-12791d4cb201@web.de>
        <xmqq8tgrhdt0.fsf@gitster.mtv.corp.google.com>
        <CAHd499BCMOcur6NRbKfwd81zpnyzoiVCY54d=UmGpAhbD7AVTA@mail.gmail.com>
        <20171004211734.GA25379@tor.lan>
Date:   Thu, 05 Oct 2017 10:38:49 +0900
In-Reply-To: <20171004211734.GA25379@tor.lan> ("Torsten =?utf-8?Q?B=C3=B6g?=
 =?utf-8?Q?ershausen=22's?=
        message of "Wed, 4 Oct 2017 23:17:34 +0200")
Message-ID: <xmqq7ewa9xw6.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: F0656A62-A96D-11E7-918A-575F0C78B957-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> One solution, which you can tell your team, is this one:
> $ git rm -r --cached . && git add .

Both this and its "git read-tree --empty" cousin share a grave
issue.  The "git add ." step would mean that before doing these
commands, your working tree must be truly clean, i.e. the paths
in the filesystem known to the index must match what is in the
index (modulo the line-ending gotcha you are trying to correct),=20
*AND* there must be *NO* untracked paths you do not want to add
in the working tree.

That is a reason why we should solve it differently.  Perhaps adding
a new option "git add --rehash" to tell Git "Hey, you may think some
paths in the index and in the working tree are identical and no need
to re-register, but you are WRONG.  For each path in the index,
remove it and then register the object by hashing the contents from
the filesystem afresh!" would be the best way to go.  That will not
pick up untracked paths left in the filesystem, and does not limit
our solution to the "eol normalization is screwey" issue by not
calling the option "renormalize" or any other words that imply "why"
we are hashing again anew.

