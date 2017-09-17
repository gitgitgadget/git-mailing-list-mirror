Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B99DA20A26
	for <e@80x24.org>; Sun, 17 Sep 2017 03:17:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751365AbdIQDQ7 (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Sep 2017 23:16:59 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65259 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751310AbdIQDQ6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Sep 2017 23:16:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 93B61997BB;
        Sat, 16 Sep 2017 23:16:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=PULldfq0g9w4
        nD4W3UOcibmjsYs=; b=XyhBv1pqN63fBSzQEmObw9fq/E+Kn1Yk6OoVJwLnxmf1
        x7bmPWgK8rVSQZ1YaYHC4FgRGkrfoYBBF0SSe0hh9H5NBTx0fhJgklriRvv3ftpz
        idzU5CsFfzeub+LYw2xC0ZnA817GBFSeTXXk9avZrT/M7sXrg9CnJMzxQI0yzbU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=oFs6XZ
        BZaoBPtklsKQznJKA0j9YWTL3rr/ywTBDufjUTyRr0MkIOn0PwnqK1BBYWxXVTZa
        4Zk9SAWNv3l2dYl6aw4goTpYrnssWByltJbBQ/0krYWk9TbDodfHrJXn71XYkMWK
        Z8dJEJlwE8sJbUCdbrrLcSPn5EWCHHimDQTV8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8B30B997BA;
        Sat, 16 Sep 2017 23:16:57 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DB841997B9;
        Sat, 16 Sep 2017 23:16:56 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "A. Wilcox" <awilfox@adelielinux.org>
Cc:     musl@lists.openwall.com, Jeff King <peff@peff.net>,
        Kevin Daudt <me@ikke.info>, git@vger.kernel.org
Subject: Re: Git 2.14.1: t6500: error during test on musl libc
References: <59BB3E40.7020804@adelielinux.org>
        <20170915063740.GB21499@alpha.vpn.ikke.info>
        <20170915113011.emko6q5utb7x4bvu@sigill.intra.peff.net>
        <59BCAF81.3090206@adelielinux.org>
        <xmqqpoaqupo5.fsf@gitster.mtv.corp.google.com>
        <59BDD6AF.5090604@adelielinux.org>
Date:   Sun, 17 Sep 2017 12:16:55 +0900
In-Reply-To: <59BDD6AF.5090604@adelielinux.org> (A. Wilcox's message of "Sat,
        16 Sep 2017 20:58:07 -0500")
Message-ID: <xmqq60ciui8o.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: A9687048-9B56-11E7-9DC3-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"A. Wilcox" <awilfox@adelielinux.org> writes:

>> I did a quick scan for substring "scanf" and read through the=20
>> output, and it seems that this is the only one that wants to do
>> the this many characters, e.g. "%42c", conversion.
>> So it seems to me that a real fix has to read the file ourselves
>> and parse up to our HOST_NAME_MAX+1 to see if the hostname refers
>> to us, and fscanf that cannot take "slurp up to this many bytes" is
>> not useful tool to implementing that parsing.
> ...
> Except that is *exactly* *what* *s* *does* (quoting C11 =C2=A77.21.6.2)=
:
>
> 9   An input item is defined as the longest sequence of input
>     characters which does not exceed any specified field width

Ah, sorry, I completely misread what you meant.

I thought you were suggesting to replace "%<length>c" with just an
unadorned "%s".  You meant that we can use "%<length>s" instead.
And that solution makes sense.  Yes, it is exactly what %<len>s
does.

So something like the following would be a sufficient fix, I guess?

Thanks.

-- >8 --
Subject: gc: call fscanf() with %<len>s, not %<len>c, when reading hostna=
me

Earlier in this codepath, we (ab)used "%<len>c" to read the hostname
recorded in the lockfile into locking_host[HOST_NAME_MAX + 1] while
substituting <len> with the actual value of HOST_NAME_MAX.

This turns out to be incorrect, as it an instruction to read exactly
the specified number of bytes.  We are trying to read at most that
many bytes, we should be using "%<len>s" instead.

Helped-by: A. Wilcox <awilfox@adelielinux.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/gc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 3c78fcb9b1..bb2d6c1fb2 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -258,7 +258,7 @@ static const char *lock_repo_for_gc(int force, pid_t*=
 ret_pid)
 		int should_exit;
=20
 		if (!scan_fmt)
-			scan_fmt =3D xstrfmt("%s %%%dc", "%"SCNuMAX, HOST_NAME_MAX);
+			scan_fmt =3D xstrfmt("%s %%%ds", "%"SCNuMAX, HOST_NAME_MAX);
 		fp =3D fopen(pidfile_path, "r");
 		memset(locking_host, 0, sizeof(locking_host));
 		should_exit =3D
