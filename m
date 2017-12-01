Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3614020954
	for <e@80x24.org>; Fri,  1 Dec 2017 16:59:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750995AbdLAQ7u (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Dec 2017 11:59:50 -0500
Received: from bsmtp.bon.at ([213.33.87.14]:45693 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750854AbdLAQ7u (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Dec 2017 11:59:50 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 3ypL9J0Dwbz5tlF;
        Fri,  1 Dec 2017 17:59:47 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id BAA17211E;
        Fri,  1 Dec 2017 17:59:46 +0100 (CET)
Subject: Re: [PATCH v4 1/4] Makefile: generate Perl header from template file
To:     Dan Jacques <dnj@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, Johannes.Schindelin@gmx.de,
        avarab@gmail.com
References: <20171129155637.89075-1-dnj@google.com>
 <20171129155637.89075-2-dnj@google.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <3c897f4c-0cb5-ca44-f144-598a623c1dc3@kdbg.org>
Date:   Fri, 1 Dec 2017 17:59:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20171129155637.89075-2-dnj@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 29.11.2017 um 16:56 schrieb Dan Jacques:
> @@ -1989,6 +1986,15 @@ GIT-PERL-DEFINES: FORCE
>   		echo "$$FLAGS" >$@; \
>   	    fi
>   
> +GIT-PERL-HEADER: $(PERL_HEADER_TEMPLATE) GIT-PERL-DEFINES perl/perl.mak Makefile
> +	$(QUIET_GEN)$(RM) $@ && \
> +	INSTLIBDIR=`MAKEFLAGS= $(MAKE) -C perl -s --no-print-directory instlibdir` && \
> +	INSTLIBDIR_EXTRA='$(PERLLIB_EXTRA_SQ)' && \
> +	INSTLIBDIR="$$INSTLIBDIR$${INSTLIBDIR_EXTRA:+:$$INSTLIBDIR_EXTRA}" && \
> +	sed -e 's=@@PATHSEP@@=$(pathsep)=g' \

This doesn't work, unfortunately. When $(pathsep) is ';', we get an 
incomplete sed expression because ';' is also a command separator in the 
sed language.

> +	    -e 's=@@INSTLIBDIR@@='$$INSTLIBDIR'=g' \
> +	    $< >$@+ && \
> +	mv $@+ $@
>   
>   .PHONY: gitweb
>   gitweb:

-- Hannes
