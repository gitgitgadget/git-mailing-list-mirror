Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 868D1C3DA6E
	for <git@archiver.kernel.org>; Sun, 18 Dec 2022 01:36:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbiLRBdL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Dec 2022 20:33:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiLRBdK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Dec 2022 20:33:10 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55988EE3D
        for <git@vger.kernel.org>; Sat, 17 Dec 2022 17:33:09 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id d3so5823328plr.10
        for <git@vger.kernel.org>; Sat, 17 Dec 2022 17:33:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=65pylZu95I6rJGn35GhOtsnQo+pwu3qoqX58aG2DD3c=;
        b=Ha+MflfzW8Yl7+bPJ9IT4wOM3ha30Y+KkX+p4CdTLT8UcxWHW4TD80rEap8bGYkdNk
         iXf0J4dxQAWRq7x6q0euDv7KU7z8VGHKLGGrfNd2ae8vp50XKYDuW/1Q67pz6cOm1XzP
         3tVV/I1KUYTOuBa1d/ZDEmAA9REi7WJVm67OK6esNPatFlaRkzxazcIESShsyZLer91E
         aErbFxZIBZJ+24W85980p/QJlKfx1KSJVTwW3m3OLo5aeEqRFaPWCFh8fCZjpHCaVzAi
         vnW+tG7yhmJHEZhstL80MMBJwgX9aMiybIHUHEmeg6Yr6tNmo72a8upMawAPWiM9x+qO
         7W0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=65pylZu95I6rJGn35GhOtsnQo+pwu3qoqX58aG2DD3c=;
        b=jubdhTAkxSEqMPDl4+Fa2gtAvqtC5MrsiAl7lvclhRMTFf1UHNBHS3QtIK1k6ZwUsz
         qJDH472jlldSsJWupxXbQpuR8B5yq2GF4XgMLpJl3XnIIZi3az+YNr2k/fLe//MoEQhN
         Dr/f6RFvvjNILy4hll5EZcsGLMM0GuvreML1dLIM8FXd8UmSTz/GoOucpulOhESFTfM/
         /6OIDtVyYlc68FQ3TQ5CjsK/bKyRgTIZK1Jhn1CN/KSM+moJxigvqWDjSGnDA2/knP1R
         wgd3m+y/IVXAQdQ5k0fNuKRC0DXmmXbQeg5HdS6F9k0XZOcF+UuW197CkFWPRxu+eKXe
         dRMw==
X-Gm-Message-State: ANoB5pkskBojvfSfvR8UBWNvfx8S5lJjKdzoVMgx25tr493o99b7gGOz
        IiXAGbykIAHfbQgX4lUYloEXcHUK38d9mg==
X-Google-Smtp-Source: AA0mqf4+kZbrhw4m6H1IDR6arXVU6TkQvleMikbyYkUmA+MkEMuZyj2BI9jI0gnvCRpAKpW4FDfQOA==
X-Received: by 2002:a17:902:c3c3:b0:18d:6138:e4f6 with SMTP id j3-20020a170902c3c300b0018d6138e4f6mr38225665plj.29.1671327188725;
        Sat, 17 Dec 2022 17:33:08 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id l5-20020a170903120500b00186da904da0sm4136554plh.154.2022.12.17.17.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Dec 2022 17:33:08 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Lars Kellogg-Stedman <lars@oddbit.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3] line-range: Fix infinite loop bug with degenerate
 '$' regex
References: <20221205193625.2424202-1-lars@oddbit.com>
        <20221211015340.2181837-1-lars@oddbit.com>
        <xmqq5yeiwr6x.fsf@gitster.g>
        <20221214145341.sonppjtshwqoxs6n@oddbit.com>
Date:   Sun, 18 Dec 2022 10:33:07 +0900
In-Reply-To: <20221214145341.sonppjtshwqoxs6n@oddbit.com> (Lars
        Kellogg-Stedman's message of "Wed, 14 Dec 2022 09:53:41 -0500")
Message-ID: <xmqqa63lzeb0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lars Kellogg-Stedman <lars@oddbit.com> writes:

>> > @@ -161,6 +160,7 @@ static const char *find_funcname_matching_regexp(xdemitconf_t *xecfg, const char
>> >  			return bol;
>> >  		start = eol;
>> >  	}
>> > +	return NULL;
>> >  }
>> 
>> What is this change about?  Isn't the above an endless loop without
>> break, from which the only way for the control to leave it is by
>> returning?
>
> It's not an endless loop without break; this change modified the loop
> condition:

Ah, thanks, that's clear, and sorry for the noise, and thanks.

