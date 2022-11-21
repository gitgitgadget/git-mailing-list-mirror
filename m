Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F6D1C433FE
	for <git@archiver.kernel.org>; Mon, 21 Nov 2022 00:37:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbiKUAhW (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Nov 2022 19:37:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbiKUAhV (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Nov 2022 19:37:21 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9844D2D3
        for <git@vger.kernel.org>; Sun, 20 Nov 2022 16:37:20 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id w15-20020a17090a380f00b0021873113cb4so9444404pjb.0
        for <git@vger.kernel.org>; Sun, 20 Nov 2022 16:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XrilibaXleZGkhcIChhVbdwFnB1DXbDatMay9Lk8on0=;
        b=KSkY/xGfeRtEeZdlmKOskGDEgq7HpywsVkamJGW+DEhvOF5CffT795rATKP5GeZlor
         UNiivZwUybHg+zM+eGNQ5VFYlBYvFHKWzlqHaWHq0G6FvwqqzmUhHUYN34kU4zswt4rQ
         cO7z+tbFHu/PXTSrEcj2IgJoGUcgB0mXko+9MuIHnQogVG6+vi2ytg/jGkhQH6YumKc5
         m+eO2HUsFe+XtjF9b+oCocSNOmHx1fCHUOLHjxWrCmK+ntg2dxsc1Z1ihq8ljZPYTsID
         lilJLN+JunGegbozEHHsFYIFUA+d3WfeKmXRsHsjNDc+vCcmq/ZdJNIG+avT9gw2gkJ/
         Bq5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XrilibaXleZGkhcIChhVbdwFnB1DXbDatMay9Lk8on0=;
        b=vAGDQo87RdblgYDWF/bY+5OLGmqM8zqEC3qpFF/I7LeAj9LuZtkgYslv6vLk/e2nVj
         664/h+9V5gaVW8S/4d3ZIeSXMZajHs5x9wWALx93h+rMver5t9COFTFsj+VQsyB1mFi6
         Z160eSwVltnzG0gRvDCB7OF1sMS3LGMr/W+XuVTwmPQN6poJ4MuLuNn4cNitOYkLtOqt
         tOtdExKkw0gNN2Xn6sJeSooWKXS8D18s4COnAhoMqZ91tE+zrxSnKbpmhRKtKMZgw6rl
         Hgw/ziC2/Xbl34Dq9bXBTHPo+gOPgpZ2MQAeUNgBAPpg7uIW3qARrv2KZUNW+F+CwX5K
         PE3A==
X-Gm-Message-State: ANoB5pkFO9QrAWh4jD4jv8Hrx0LNrHHTqhMj1NwZWDwAjyoCPi4AM3St
        P6CSNtpDocGWlkU6Nt0jMjM=
X-Google-Smtp-Source: AA0mqf4QYKD83ZfimtkORPF4AekjVIQ0OqSUB64vrFZixp2DTMU6cpRg6v3M0IYi/tOdsDpjri5cRw==
X-Received: by 2002:a17:902:e807:b0:189:117c:fcfe with SMTP id u7-20020a170902e80700b00189117cfcfemr5587113plg.124.1668991039989;
        Sun, 20 Nov 2022 16:37:19 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id y10-20020a17090322ca00b0017bb38e4588sm8212017plg.135.2022.11.20.16.37.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Nov 2022 16:37:19 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
Subject: Re: Looking for a review (pretty-formats, hard truncation), was
 What's cooking in git.git (Nov 2022, #04; Fri, 18))
References: <Y3g95OYdwzq2OP3z@nand.local>
        <8791cb85-cf4a-4302-5c1a-54a7e7766cfb@iee.email>
Date:   Mon, 21 Nov 2022 09:37:19 +0900
In-Reply-To: <8791cb85-cf4a-4302-5c1a-54a7e7766cfb@iee.email> (Philip Oakley's
        message of "Sun, 20 Nov 2022 17:42:43 +0000")
Message-ID: <xmqqedtxywg0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philip Oakley <philipoakley@iee.email> writes:

> Ping, Hopefully an easy single patch review for someone on-list.
>
> Potential review points:
>
> Is the commit message sufficient?
> Are the tests: Sufficient, Complete, Correct ?
> Is `qz_to_tab_space` conversion applied correctly?

Is the feature and the design sensible?

Are the tests checking interesting cases?  The underlying mechanism
uses strbuf_utf8_replace() because there are character strings whose
display columns do not match their byte length (otherwise you can
just use strlen() and chomp at byte boundary), so a test whose
result would be different if strbuf_utf8_replace() were replaced
with a more naive strbuf_splice() would be valuable and meaningful.
