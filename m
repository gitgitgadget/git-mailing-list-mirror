Return-Path: <SRS0=KwJF=EL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EACA9C55178
	for <git@archiver.kernel.org>; Thu,  5 Nov 2020 22:02:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87D6E20728
	for <git@archiver.kernel.org>; Thu,  5 Nov 2020 22:02:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="bQmIK7Iw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732574AbgKEWCB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Nov 2020 17:02:01 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57242 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731508AbgKEWCB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Nov 2020 17:02:01 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5A149102414;
        Thu,  5 Nov 2020 17:01:59 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=InPp4kaA3nsZ/3s96dl6qgi485E=; b=bQmIK7
        IwIjnHaZ1DpXBWT0t+LXvCLD+09eDgyLh7pfumBmL9wRkTlXUFMPGDLQHDX4B/vB
        Y8/BlIKjWbMLRwj0ow+RHTHoWs5yrVhJbbee5lAbMbVPHvQRdHoLMYSoWP4rcS0z
        dD+gTAQpoBP6Ce2IpG97imIHkKWXCWC/6WZyk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=btNSFwStYaekEhEK1XjCq+m/x7mTb/QE
        K23CpytdxXTgt76InMnjQ3M0WEUhtgV/nU2ZpxKGZpjQZC+90nLDrcG+jN3SRe1y
        gSMCJwXNc197l4hQ2lCyiRBVBnXK6YFj/jHhZii3/f2kRuLdOGVUWH7OpK4mi0T2
        Ikn6fu4P3V4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 510A4102412;
        Thu,  5 Nov 2020 17:01:59 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 8954D1023DC;
        Thu,  5 Nov 2020 17:01:56 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH 7/8] Makefile: don't delete dist tarballs directly by name
References: <48fdd198-93ad-7282-27e6-9a0c6de93067@ramsayjones.plus.com>
Date:   Thu, 05 Nov 2020 14:01:54 -0800
In-Reply-To: <48fdd198-93ad-7282-27e6-9a0c6de93067@ramsayjones.plus.com>
        (Ramsay Jones's message of "Thu, 5 Nov 2020 21:09:49 +0000")
Message-ID: <xmqqr1p7h38t.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8549D5E2-1FB2-11EB-86B0-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

> diff --git a/.gitignore b/.gitignore
> index 6232d33924..425b8cc2a4 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -191,6 +191,7 @@
>  /gitweb/static/gitweb.min.*
>  /config-list.h
>  /command-list.h
> +/dist-tars
>  *.tar.gz
>  *.dsc
>  *.deb
> diff --git a/Makefile b/Makefile
> index 90e91a2185..bc9ce28bc3 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -3083,6 +3083,7 @@ dist: git-archive$(X) configure
>  		--prefix=$(GIT_TARNAME)/ HEAD^{tree} > $(GIT_TARNAME).tar
>  	@$(RM) -r .dist-tmp-dir
>  	gzip -f -9 $(GIT_TARNAME).tar
> +	@echo $(GIT_TARNAME).tar.gz >>dist-tars

Sorry, but I'd rather not to see such a longer-term "list of files
to be removed" on the filesystem.  This invites attackers to write a
rogue test addition that writes into ../../dist-tars something like
"~/.gitconfig" and wait for me to say "make clean".
