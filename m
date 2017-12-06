Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 244E520C11
	for <e@80x24.org>; Wed,  6 Dec 2017 18:47:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752018AbdLFSrc (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Dec 2017 13:47:32 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62959 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751711AbdLFSrc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Dec 2017 13:47:32 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7A144C7CC6;
        Wed,  6 Dec 2017 13:47:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4TomJwcVVQRW8tpmVTuUUS3To1E=; b=W2FZe1
        JpvlIjQE3+EyZq72cpHvDwO6rVh7CLjeKh7fGC/YyispcJNQ9GXgCQtMkGYj9y7U
        JKtHY6Y8+CjFP8zIdrApksR2lu6+1AaiKcGU7/QOnocE9wF+k3Xmctn5MahtOhoo
        ReDEZPC/AAMX3q8uQdw2htzFkL8GhSSl5vHQ4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=TFoaX0EThSaFm4+GDo9SjOJ5VmlgQxyX
        cXdNGYd0HnIjI3gF4i9MToH3KulpMcYW9HiFAdMxwRdT/mMCIgbYreqKdAQnTtsP
        0wBXPvUzU/dMb+0qb41m4CfwpR+OBM2pcHdO/NJRAsm/kdXfQmWtQ3fGZrnG0sM3
        ECamNvvbIrc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7077BC7CC5;
        Wed,  6 Dec 2017 13:47:31 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AA260C7CC2;
        Wed,  6 Dec 2017 13:47:30 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Dan Jacques <dnj@google.com>, Johannes.Schindelin@gmx.de,
        avarab@gmail.com, git@vger.kernel.org
Subject: Re: [PATCH v4 1/4] Makefile: generate Perl header from template file
References: <f0ad1ad4-67d8-21e2-fdd0-0a08328c1eaa@kdbg.org>
        <20171205212625.6616-1-dnj@google.com>
        <xmqq7eu0j1th.fsf@gitster.mtv.corp.google.com>
        <e0a22ee4-9503-760f-293c-be56fa46fa04@kdbg.org>
Date:   Wed, 06 Dec 2017 10:47:29 -0800
In-Reply-To: <e0a22ee4-9503-760f-293c-be56fa46fa04@kdbg.org> (Johannes Sixt's
        message of "Wed, 6 Dec 2017 19:25:25 +0100")
Message-ID: <xmqqd13rhewu.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E9F470E6-DAB5-11E7-816F-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> The updated series works for me now. Nevertheless, I suggest to squash
> in the following change to protect against IFS and globbing characters in
> $INSTLIBDIR.

Yeah, that is very sensible.

> diff --git a/Makefile b/Makefile
> index 7ac4458f11..08c78a1a63 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2072,7 +2072,7 @@ GIT-PERL-HEADER: $(PERL_HEADER_TEMPLATE) GIT-PERL-DEFINES perl/perl.mak Makefile
>  	INSTLIBDIR_EXTRA='$(PERLLIB_EXTRA_SQ)' && \
>  	INSTLIBDIR="$$INSTLIBDIR$${INSTLIBDIR_EXTRA:+:$$INSTLIBDIR_EXTRA}" && \
>  	sed -e 's=@@PATHSEP@@=$(pathsep)=g' \
> -	    -e 's=@@INSTLIBDIR@@='$$INSTLIBDIR'=g' \
> +	    -e 's=@@INSTLIBDIR@@='"$$INSTLIBDIR"'=g' \
>  	    -e 's=@@GITEXECDIR@@=$(gitexecdir_relative_SQ)=g' \
>  	    -e 's=@@PERLLIBDIR@@=$(perllibdir_relative_SQ)=g' \
>  	    $< >$@+ && \
