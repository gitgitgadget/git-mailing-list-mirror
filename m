Return-Path: <SRS0=QAHC=4O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A495EC4BA13
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 16:50:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6193B2467D
	for <git@archiver.kernel.org>; Wed, 26 Feb 2020 16:50:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="QU8XXyad"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727503AbgBZQt4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Feb 2020 11:49:56 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57384 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726980AbgBZQt4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Feb 2020 11:49:56 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 50412B7976;
        Wed, 26 Feb 2020 11:49:54 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=nYPq1IxFLRniv29IBWB06KSA6UI=; b=QU8XXy
        adAGcdvZqA2jlVAe2+1UKFpcQJqUDPHuVcFFi0icy7I8Ay5G2NlD6LhVJgLVAOhx
        XNwXjeIN4QqLKnvwkqoUykPoB6w3hZyhFm5HjpMMmhfY90Z0BZv0Zge5ifnIugSF
        LENbmAVoyxaBlRr+oy4E0AF6KjDybnFCzjcVE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=hX7BhSZZErN4Rky1yzAFHxpfEQUPH/XZ
        cLn/Pv2+/Cj7yjB05TMaO4hyo7G5nMeBWidcDQDj7L+Ytb+w9tKLT5WQfMgj3KLJ
        QmZWvYkjwhJUmR8qftaBEobYtm1YQe26hs3NsM8Ga8C2SecgHPykdWzm/DNOmfQX
        f3zmnuteg50=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 488DEB7975;
        Wed, 26 Feb 2020 11:49:54 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 6C619B7974;
        Wed, 26 Feb 2020 11:49:51 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Subject: Re: [PATCH v8 09/15] bugreport: generate config safelist based on docs
References: <20200220015858.181086-1-emilyshaffer@google.com>
        <20200220015858.181086-10-emilyshaffer@google.com>
        <nycvar.QRO.7.76.6.2002261649550.46@tvgsbejvaqbjf.bet>
Date:   Wed, 26 Feb 2020 08:49:49 -0800
In-Reply-To: <nycvar.QRO.7.76.6.2002261649550.46@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Wed, 26 Feb 2020 17:13:00 +0100 (CET)")
Message-ID: <xmqqr1yhjnte.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 01BCE032-58B8-11EA-8F38-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Subject: [PATCH] fixup??? bugreport: generate config safelist based on docs
>
> The Visual Studio build is a special beast: as we cannot assume the
> presence of any Unix tools on Windows, we have to commit all of the
> files generated via shell scripts.
>
> These two generated header files are no exception.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  config.mak.uname | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/config.mak.uname b/config.mak.uname
> index 6d58d22cd5a..f1f36e43e47 100644
> --- a/config.mak.uname
> +++ b/config.mak.uname
> @@ -788,8 +788,10 @@ vcxproj:
>  	git add -f git/LinkOrCopyBuiltins.targets git-remote-http/LinkOrCopyRemoteHttp.targets
>
>  	# Add command-list.h
> -	$(MAKE) MSVC=1 SKIP_VCPKG=1 prefix=/mingw64 command-list.h
> -	git add -f command-list.h
> +	$(MAKE) MSVC=1 SKIP_VCPKG=1 prefix=/mingw64 command-list.h \
> +		config-list.h bugreport-config-safelist.h
> +	git add -f command-list.h \
> +	 	config-list.h bugreport-config-safelist.h

Two important questions are 

 - Is $(GENERATED_H) visible to you at this point in this makefile
   snippet that is included from the main Makefile?

 - Currently the list of files listed on $(GENERATED_H) match what
   you are building and adding here.  Is there a reason to believe
   two would ever diverge?

If the answers to the above are yes and no, there is an obvious
futureproofing of the suggested patch, i.e.

-	$(MAKE) MSVC=1 SKIP_VCPKG=1 prefix=/mingw64 command-list.h
-	git add -f command-list.h
+	$(MAKE) MSVC=1 SKIP_VCPKG=1 prefix=/mingw64 $(GENERATED_H)
+	git add -f $(GENERATED_H)

