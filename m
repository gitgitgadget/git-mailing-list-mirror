Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 65265208CD
	for <e@80x24.org>; Tue,  5 Sep 2017 02:20:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753773AbdIECUR (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Sep 2017 22:20:17 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56693 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753724AbdIECUQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Sep 2017 22:20:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5D34C9E90F;
        Mon,  4 Sep 2017 22:20:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=qwwUHJ7mLwgg7Zde4nPadtGlOX4=; b=hUkk9C93glcZ4G5hRPgn
        6CPTIlwqg7dp94wcXK0jPah7JmzQCm9v4m5cU+v9Mqm0pjvxUWGPPHrQ8stZ9xgQ
        86FpS2nxhMKUf5XPWbQYJ8YDHv3dX+WEXVXSYW+IZ9iSTkcSFlq5SiUIT7AP/PGJ
        xScTxn6fHfDZxonGRGLIScE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=kyCheHhnvYKGF2n54lO1f9he66x1eozJ/1L8FcaJnc2eq9
        rojsRxSq44b4B2ZfMMAfjluKyk5kxmetFnB+D+OdVkCFtejUgUretx9yny6CV+GT
        ukGVBbzAxQTMnb+LWsQWsNcX79Nv51l4icT02aG6cvQ1rXRSYiNgh8vWsdmWw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 561379E90E;
        Mon,  4 Sep 2017 22:20:16 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BAF609E90D;
        Mon,  4 Sep 2017 22:20:15 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "josephpattara ." <josephpattara@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: HP-UX (git-2.14.0) Depot File / Source Code Build throws SHA1 Error
References: <CAC-YKd1sTQLMUZ6k+-4K09=NOa_HaOf1gp8H51VNZjziUrxOfA@mail.gmail.com>
        <20170901212620.w4ml5umoydbtuspw@sigill.intra.peff.net>
        <CAC-YKd0dDDJ_YkT=+Euqc=AMuTYobV-dWdKHkA5SgKJVKwMeug@mail.gmail.com>
Date:   Tue, 05 Sep 2017 11:20:14 +0900
Message-ID: <xmqqd175dgyp.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C12DB8AC-91E0-11E7-BCA7-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"josephpattara ." <josephpattara@gmail.com> writes:

> Firstly, I could see the SHA1 hash was definitely wrong.
> -bash-4.3$ echo foo | ./git hash-object --stdin
> 408935f8873a5ef17ef10cf2a316e51937e90f0b
> ...
> But I can confirm with the adapated source code from HPUX connect and
> using the  OPENSSL_SHA1=Yes I am able to build a working git locally.

I do not know if your HP-UX on Itanium is big/little endian (IIRC it
is selectable at the CPU level), but my blind guess is that this
might help before building without OPENSSL_SHA1=YesPlease?

        cat >>config.mak <<-\EOF
        BASIC_CFLAGS += -DSHA1DC_FORCE_BIGENDIAN=1
        EOF
