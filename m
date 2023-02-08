Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D4AC636D3
	for <git@archiver.kernel.org>; Wed,  8 Feb 2023 17:56:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231465AbjBHR4U (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Feb 2023 12:56:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231474AbjBHR4S (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2023 12:56:18 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0180459E2
        for <git@vger.kernel.org>; Wed,  8 Feb 2023 09:56:18 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id u75so6584239pgc.10
        for <git@vger.kernel.org>; Wed, 08 Feb 2023 09:56:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FUaDB5Q6BBVKCfrEiqbSYXsJ+7ow1Sp0b65KkDuRjqg=;
        b=Qe5Buhfp0D3yknVEbziGb/619yXcEmuhEL6GO9OEULOpuoxxMNfybhwgkdvUIJNWJO
         J35nn/WItj/0+rmvj1z/9DxpkqKoeaw1+uJmlas7inEBCbLtiXBOXjVu5EgwFL8ibkuV
         3yaHgoggu8WMNRY7XrWLpbqjN+YVSSRpcD3KaYeo8oi2hcyU2n4hRVYCe73JJWJRDmhR
         uExmdS2Fkl26ule+pRpCiE82nEPIPBxgNjB2utm90AffrT9QQ37xrB/SIuFQcTUsiXEf
         AdbqGPLl0fxvExsKLDOq+DQYE2hl8ONBpir4o6zWByruHTDQ62GizM6UopkYhx97tzSy
         mP+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FUaDB5Q6BBVKCfrEiqbSYXsJ+7ow1Sp0b65KkDuRjqg=;
        b=Yj43QXEsAhnFWa3X48y6JaD6nNzGgnkY1vTSKzFhdPXaC7TtxHSunZOnQS5TzWyX3t
         T/9krFBUZ00im+DB49p5cwpIYVwSWmJkCRTJm7+cYb+xhXu7MbOHcbKI4VlN+zkdPDyL
         fsJ99YkMSKg9eJ21HEBmKF67r/ddFXSjH9QpGUzy/FlCr0Q2mZzGDxKqbwUiWaPF5ipY
         AUTIkvuGmBUW513Gimac+1Kf4htvCL5/h8UU39BHQXPsRylpTEDOMUOAVQOR5mApv15B
         tC1Inni2eFUWat4nijgvQtC4siggi7iPnnMIEVyLXky/0XVLyxiOC5C7YZIyvg5rPCkt
         4ZwQ==
X-Gm-Message-State: AO0yUKURRsEKIcl5kpVniw/5H0OJzQZ4psZRyaFVaVLGP3v8WYfTcn4k
        PFujPD05/wks3Lf55ui/rSI=
X-Google-Smtp-Source: AK7set/xnFb0Jas1i5TkAlpDPFQcSMlJ+qTyymXbEsRpDWNnUsms3wJ+4ZMVknU8GV6ooLaxcVvl+A==
X-Received: by 2002:a62:1e86:0:b0:593:b13a:c4f5 with SMTP id e128-20020a621e86000000b00593b13ac4f5mr7042398pfe.29.1675878977400;
        Wed, 08 Feb 2023 09:56:17 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id j23-20020a62e917000000b005a817f72c21sm2138817pfh.131.2023.02.08.09.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 09:56:16 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Max Gautier <max.gautier@redhat.com>, git@vger.kernel.org
Subject: Re: git rev-list fails to verify ssh-signed commits (but git log
 works)
References: <Y+PGRaiTTaZ/DtlJ@work-laptop-max>
        <Y+PRTYtFDoE73XEM@coredump.intra.peff.net>
Date:   Wed, 08 Feb 2023 09:56:16 -0800
In-Reply-To: <Y+PRTYtFDoE73XEM@coredump.intra.peff.net> (Jeff King's message
        of "Wed, 8 Feb 2023 11:43:57 -0500")
Message-ID: <xmqqmt5orqgv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> +	/*
> +	 * yikes, this needs to come early in the function because it
> +	 * also handles user.signingkey, which would otherwise get
> +	 * shunted to git_ident_config() below
> +	 */
> +	if (git_gpg_config(var, value, cb) < 0)
> +		return -1;

Indeed.

>  	if (starts_with(var, "user.") ||
>  	    starts_with(var, "author.") ||
>  	    starts_with(var, "committer."))
>
> but it would need a bit more work:
>
>   1. Somebody would need to dig into the reasons, if any, for not
>      calling git_gpg_config() everywhere. It might be fine, but there
>      may be a good reason which we're now violating. Digging in the
>      history and looking at the code might yield some hints.

Hmph, I didn't consider calling gpg_config unconditionally.  It may
do a bit more than what a typical config callback does (i.e. as
opposed to just store the string values it gets, it tries table
look-ups and stuff) but it is not too bad.

>   2. The individual calls to git_gpg_config() in other programs should
>      go away.

Naturally.

>   3. It's possible some refactoring may let us avoid the "yikes" comment
>      above (e.g., should user.signingkey just go into the normal ident
>      config handler?).

Hindsight is golden---if this were called gpg.signingkey we wouldn't
be having this discussion X-<.
