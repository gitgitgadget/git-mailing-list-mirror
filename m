Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F1342203F3
	for <e@80x24.org>; Fri, 21 Jul 2017 19:28:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753509AbdGUT2i (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Jul 2017 15:28:38 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50932 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752780AbdGUT2i (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jul 2017 15:28:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 182319BABC;
        Fri, 21 Jul 2017 15:28:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=PzCYeytIEibWGiJOn02UP6s1OJI=; b=Kpl0Qj
        UdrWOCSi9odViHEdQGqRUuF9D4Krf+wp9HrLBa325dW2L+LUkwIvhxHsyHe37f21
        z0oKNByDPTxggY9oKexS5Z75reBbtWWVXZrRlQOZKJWLfoc7PonGpJ5nlg9S1pWl
        opCXbtjvfjVrkMUYU62FaPEo+Zv+8ND1vY/0c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=lQIRhlowl5UztXPF2mYeAa+H0uQ16jCn
        hhiJUFTb3waPmNUbH6OdMb48W1Zkf2vHgsgkLOckD/J1XhuAulTza2AUMTph1E3a
        /kw+FgfU+QaOH+V9AvBUket1l7BfWtO9ykCHwyE4cAexJUoRI0Zmala2WojiUM4d
        FHAoZIfJPds=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0ED359BABB;
        Fri, 21 Jul 2017 15:28:32 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6848A9BABA;
        Fri, 21 Jul 2017 15:28:31 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Adam Dinwoodie <adam@dinwoodie.org>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH] config.mak.uname: set FREAD_READS_DIRECTORIES for cygwin
References: <506cb9f2-cf59-2df6-2d4c-30c82dfbf85b@ramsayjones.plus.com>
Date:   Fri, 21 Jul 2017 12:28:30 -0700
In-Reply-To: <506cb9f2-cf59-2df6-2d4c-30c82dfbf85b@ramsayjones.plus.com>
        (Ramsay Jones's message of "Fri, 21 Jul 2017 19:43:17 +0100")
Message-ID: <xmqq4lu5h9nl.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C7A7C54C-6E4A-11E7-BA03-EFB41968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> ---
>
> Hi Junio,
>
> My 'make test' run for the v2.14.0-rc0 on cygwin turned up a new
> test failure (over and above the v2.13.0 failures), namely t1308.23.
> Running the test in the debugger showed that cygwin was fopen-ing
> the 'a-directory' without problem.
>
> On one occasion, while in the debugger, I did see fopen return NULL
> while trying to open a directory. So, I created a test program which
> showed reliably that fopen succeeds on a directory. (So, maybe I was
> just seeing things! :-D ).
>
> t1308 was reliably failing before this patch, afterwards it reliably
> passes, so ...
>
> [I have a full test run going at the moment, but it won't finish for
> about 3 hours.]
>
> ATB,
> Ramsay Jones

Thanks.  Let's apply it for -rc1.

>
>  config.mak.uname | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/config.mak.uname b/config.mak.uname
> index 551e465a7..6604b130f 100644
> --- a/config.mak.uname
> +++ b/config.mak.uname
> @@ -185,6 +185,7 @@ ifeq ($(uname_O),Cygwin)
>  	SPARSE_FLAGS = -isystem /usr/include/w32api -Wno-one-bit-signed-bitfield
>  	OBJECT_CREATION_USES_RENAMES = UnfortunatelyNeedsTo
>  	COMPAT_OBJS += compat/cygwin.o
> +	FREAD_READS_DIRECTORIES = UnfortunatelyYes
>  endif
>  ifeq ($(uname_S),FreeBSD)
>  	NEEDS_LIBICONV = YesPlease
