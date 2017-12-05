Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CFCAB20A40
	for <e@80x24.org>; Tue,  5 Dec 2017 21:17:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751288AbdLEVRf (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Dec 2017 16:17:35 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63158 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751161AbdLEVRf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Dec 2017 16:17:35 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9517BC254E;
        Tue,  5 Dec 2017 16:17:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Za3hdIxKb/fboGGHkAB82aH5k0w=; b=hDJ/45
        nXMYUTvm+/z1MEMZHc4BYaOy/X5fHjniiWjCymkTHWe4MEzytYCiRx580gRiSBTP
        QsT4EafG1AyRbfrOlZ4SW1c/xD24nHaJ3cXTpYqJcp3qgiNy1jVGm/s2FtfpDquU
        Y9I1VucJWGOZIiwaKrIgDlWXXY5PT1Ilkj4tM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=HDwgLwg49AHjMuY6cux02hFtch3sarX/
        +ZLpcC5mufK0qqmhV9PLEl0beONQvI6o3H23Xcdc85a5IU3owiWwjfPREYHwZOvV
        9x2DKrKadFDPDtPN+82ym5kS4LUzP3QaDWI70dj8B56XIsrRYvDzUxapyErBGgWS
        Uf2NB8YrZCc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8C47EC254D;
        Tue,  5 Dec 2017 16:17:34 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id ED110C254A;
        Tue,  5 Dec 2017 16:17:33 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Dan Jacques <dnj@google.com>, git@vger.kernel.org,
        avarab@gmail.com
Subject: Re: [PATCH v4 1/4] Makefile: generate Perl header from template file
References: <20171129155637.89075-1-dnj@google.com>
        <20171129155637.89075-2-dnj@google.com>
        <3c897f4c-0cb5-ca44-f144-598a623c1dc3@kdbg.org>
        <alpine.DEB.2.21.1.1712011812250.98586@virtualbox>
        <97acc3d3-5c6a-2e65-a372-24def5b21d54@kdbg.org>
        <f0ad1ad4-67d8-21e2-fdd0-0a08328c1eaa@kdbg.org>
Date:   Tue, 05 Dec 2017 13:17:32 -0800
In-Reply-To: <f0ad1ad4-67d8-21e2-fdd0-0a08328c1eaa@kdbg.org> (Johannes Sixt's
        message of "Tue, 5 Dec 2017 21:54:11 +0100")
Message-ID: <xmqqbmjcj2mr.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B5E9505A-DA01-11E7-96D2-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> Today's version, with the tip at 5d7f59c391ce, is definitely bogus
> with its quoting. It needs the patch below, otherwise an unquoted
> semicolon may be expanded from $(pathsep). This would terminate the sed
> command, of course.

Of course ;-)

Somehow I was lucky that the topic as been de-queued from 'pu' for
the past few days.

> diff --git a/Makefile b/Makefile
> index 484dc44ade..a658c8169a 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2071,10 +2071,10 @@ GIT-PERL-HEADER: $(PERL_HEADER_TEMPLATE) GIT-PERL-DEFINES perl/perl.mak
>  	INSTLIBDIR=`MAKEFLAGS= $(MAKE) -C perl -s --no-print-directory instlibdir` && \
>  	INSTLIBDIR_EXTRA='$(PERLLIB_EXTRA_SQ)' && \
>  	INSTLIBDIR="$$INSTLIBDIR$${INSTLIBDIR_EXTRA:+:$$INSTLIBDIR_EXTRA}" && \
> -	sed -e 's=@@PATHSEP@@='$(pathsep)'=g' \
> -	    -e 's=@@INSTLIBDIR@@='$$INSTLIBDIR'=g' \
> -	    -e 's=@@GITEXECDIR@@='$(gitexecdir_relative_SQ)'=g' \
> -	    -e 's=@@PERLLIBDIR@@='$(perllibdir_relative_SQ)'=g' \
> +	sed -e 's=@@PATHSEP@@=$(pathsep)=g' \
> +	    -e 's=@@INSTLIBDIR@@='"$$INSTLIBDIR"'=g' \
> +	    -e 's=@@GITEXECDIR@@=$(gitexecdir_relative_SQ)=g' \
> +	    -e 's=@@PERLLIBDIR@@=$(perllibdir_relative_SQ)=g' \
>  	    $< >$@
>  
>  .PHONY: gitweb
