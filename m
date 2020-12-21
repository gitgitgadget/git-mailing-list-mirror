Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29717C433DB
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 18:38:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7CB122CB2
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 18:38:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727055AbgLUShw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Dec 2020 13:37:52 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57601 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725910AbgLUShv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Dec 2020 13:37:51 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7109C98757;
        Mon, 21 Dec 2020 13:37:09 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Zvocf0xlN9Eq7v+MN3hAjCtQs7s=; b=Q2DHeZ
        VVxjvaDtDhu6dyAFiK3F/Bw4s9dT52oeQpJVdHrvaT7mc9JjTcJxeHAs5R0TQQhz
        +emXtAwHi9W5RnxflgFu1zXdr+a+xHNQRd3RZ3aCD6PgavcyNstYfuRANnz/XbTL
        LDGF1Kn7+AkCAfgnHgoObUTDNzf7oR8ZOjjYU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=aVbtw6GKmKXqNIGyU0Z7Qgpq4L0SZtVm
        h9iHYc9xFKs/qxz/eBfeGc2G+4kZTG89zpu99XOO+pizOoiL9vRPFA4zN00Q+Dw3
        Nie5vfy6EcQKXFi6uZdwRiWSgvix1GzfS+VhTXgoETkqhzREq4RZPx5Qg2qsMzqB
        KMXXaEXxgA0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3627C98756;
        Mon, 21 Dec 2020 13:37:09 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 458FF98754;
        Mon, 21 Dec 2020 13:37:08 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     <git@vger.kernel.org>
Subject: Re: [BUG] git-2.30.0-rc1 - Transitive OpenLDAP requirement in libcurl
References: <002001d6d7bd$d03d7e10$70b87a30$@nexbridge.com>
Date:   Mon, 21 Dec 2020 10:37:07 -0800
In-Reply-To: <002001d6d7bd$d03d7e10$70b87a30$@nexbridge.com> (Randall
        S. Becker's message of "Mon, 21 Dec 2020 12:22:04 -0500")
Message-ID: <xmqqeejjm2ek.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 87E840F4-43BB-11EB-BFBE-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Randall S. Becker" <rsbecker@nexbridge.com> writes:

> The NonStop platform does not have an implementation of OpenLDAP, but git is
> attempting to use it. We are getting unresolved references from libcurl,
> which makes references to openldap regardless of whether it exists. We do
> not expect git to use ldap_setup_connection, for example. We need a way of
> disabling the use of this package. This appears to be is a net new for issue
> for 2.23.0, which we just did not get far enough on rc0 to encounter. 

I assume "23" on the last line is typo for "30".

Between v2.29.0..v2.30.0-rc1, there is nothing other than 3b990aa6
(push: parse and set flag for "--force-if-includes", 2020-10-03),
which seem to have nothing to do with auth, that touches http*.c or
remote-curl.c

Is it possible that you updated your build procedure and/or options
for libcurl since last time you built a working Git successfully?
If you build v2.29.0 with the same toolchain and library that failed
with -rc1, does the result work OK?

Does NonStop software collection have programs other than Git that
links with libcurl, and if so do they work (in other words, is the
latest source of Git the only thing that suffers from this issue)?

Sorry, I have *no* further suggestions even if you answered any of
the above questions to me, but I hope others (inclusing you and your
folks) may have better insights after answering the above questions
;-)

> Need assistance to resolve this.
>
> Thanks,
> Randall
>
> Sample (there are more) references:
>
> eld command line:
>    /usr/bin/eld -o git-imap-send -set systype oss -set highpin on -set
>    highrequestor on -set inspect on /usr/lib/ccplmain.o imap-send.o http.o
>    common-main.o -L/usr/local/lib -lcurl -lssl -lcrypto -lssl -lcrypto -lz
>    -lssl -lcrypto -lcrypto libgit.a xdiff/lib.a -lz -lintl -liconv
>    -L/usr/local/lib -lfloss -lutil -lrld -L /G/system/sys04 -lcre -lcrtl
>    -lossk -lossf -lsec -li18n -licnv -losse -linet -lossh -lossc
>    -allow_duplicate_procs
>
> **** ERROR **** [1210]:
>    /usr/local/lib/libcurl.a(libcurl_la-openldap.o): In function
>    `ldap_setup_connection':
>    libcurl_la-openldap.o(.text._153926392+0x72): unresolved reference to
>    ldap_url_parse.
>
>
> -- Brief whoami:
>  NonStop developer since approximately 211288444200000000
>  UNIX developer since approximately 421664400
> -- In my real life, I talk too much.
