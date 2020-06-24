Return-Path: <SRS0=BxWL=AF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51947C433E0
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 04:35:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CEFE2084D
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 04:35:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ebY9iCgk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728794AbgFXEfW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Jun 2020 00:35:22 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51551 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728681AbgFXEfW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jun 2020 00:35:22 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 76E52D77C2;
        Wed, 24 Jun 2020 00:35:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=MWs9UzLnoAaBCc4eJuwKwSoF+yA=; b=ebY9iC
        gkMgt01l+uNsXtwdXjB0fuQgaALtrY+Rtf+EyFqHBVzZ1i2kravIcpHfL5rB1rfq
        HrSplkzWHU3frq11REfN/dgh3sAWOkMGP7kjU/9jhaQn+ViYKcBDUcigZk46mSeo
        X7FhdLqt9aWMhaeAY2nAAzybTuXFy7JRY6MqI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=EURi9y4j1kYyZEsJfKK6IqI7M03vJwbT
        RLc762DmwSO5i0CdIFPJIxrONBf+3O0h5mpNtBadn9QxSlYdu92ydCStgXJhef0V
        o1AaZWTmEb/aWILUMiAhXIR1+fhMpKXuxcvmcSqwEj6Uiufj5Dyw5iAkIUlkLD4d
        pEbj4H0TaI0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6E98BD77C1;
        Wed, 24 Jun 2020 00:35:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B5EBAD77BF;
        Wed, 24 Jun 2020 00:35:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org,
        =?utf-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/2] bugreport: generate config safelist based on docs
References: <20200624012827.34126-1-emilyshaffer@google.com>
        <20200624012827.34126-2-emilyshaffer@google.com>
Date:   Tue, 23 Jun 2020 21:35:15 -0700
In-Reply-To: <20200624012827.34126-2-emilyshaffer@google.com> (Emily Shaffer's
        message of "Tue, 23 Jun 2020 18:28:26 -0700")
Message-ID: <xmqq4kr19j3w.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1AEC3566-B5D4-11EA-849F-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> ... To mark a config as safe,
> add "annotate:bugreport[include]" to the corresponding line in the
> config documentation; to mark it as unsafe, add
> "annotate:bugreport[exclude]" instead.

Hmph,...

> -sendemail.smtpEncryption::
> +sendemail.smtpEncryption annotate:bugreport[include] ::
>  	See linkgit:git-send-email[1] for description.  Note that this
>  	setting is not subject to the 'identity' mechanism.
>  
> @@ -15,7 +15,7 @@ sendemail.smtpsslcertpath::
>  	Path to ca-certificates (either a directory or a single file).
>  	Set it to an empty string to disable certificate verification.
>  
> -sendemail.<identity>.*::
> +sendemail.<identity>.* annotate:bugreport[exclude] ::

So "sendemail.git-devel.cc" is not included due to [exclude] here,
but ...

> +sendemail.annotate annotate:bugreport[include] ::
> +sendemail.bcc annotate:bugreport[include] ::
> +sendemail.cc annotate:bugreport[include] ::

... "sendemail.cc" that is a fallback value for other "sendemail.*.cc"
is included?  

> +++ b/generate-bugreport-config-safelist.sh
> @@ -0,0 +1,18 @@
> +#!/bin/sh
> +
> +cat <<"EOF"
> +/* Automatically generated by bugreport-generate-config-safelist.sh */
> +
> +
> +static const char *bugreport_config_safelist[] = {
> +EOF
> +
> +# cat all regular files in Documentation/config
> +find Documentation/config -type f -exec cat {} \; |
> +# print the command name which matches the annotate-bugreport macro
> +sed -n 's/^\([^ ]*\)  *annotate:bugreport\[include\].* ::$/  "\1",/p' |
> +	sort

We just care about "include" entries, so it does not matter whether
we mark entries with [exclude] or not anyway?

Puzzled...
