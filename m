Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AFCAC7618D
	for <git@archiver.kernel.org>; Thu,  6 Apr 2023 04:22:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235101AbjDFEWH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Apr 2023 00:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233641AbjDFEWF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Apr 2023 00:22:05 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E26379747
        for <git@vger.kernel.org>; Wed,  5 Apr 2023 21:22:04 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id nh20-20020a17090b365400b0024496d637e1so403987pjb.5
        for <git@vger.kernel.org>; Wed, 05 Apr 2023 21:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680754924;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Anf6UfNcNkBWMjwD2w/kjvcOrjykY0blxzZWIpNCfx0=;
        b=Lwf6huLx1OOEge0mZcwsAJy9YtPLIY/AvwmM9DhVXZcQxEGjktJb08MppVekPcObz0
         I0FJlW1EAJNn/uLphUSJGY95bP8ZEEQk/3AvyvXAUCJW6SG53V35LR4RE4AJ+8WPF7mt
         OEiOoYx02xxPMsZ/3RVJlJL1oMqpuUgDB9+KWRKIOb6E2Qa2UfO3a4CydzDX18hiJ95n
         TEiZ5ptAnfRaX1CdZkVrDnnTsxYom5VoIt5dpW7SfKKgX5dEQlWzAwBBMu8jTbtPsykh
         JjY771atNe6JoHHy/ORof9GIzEOEs7wOO70DhLgeZpr3CTqX/HufnJrsOLhcIzo9srD1
         oeSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680754924;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Anf6UfNcNkBWMjwD2w/kjvcOrjykY0blxzZWIpNCfx0=;
        b=NO6778YbjRoF0oAuja+UKKjZHXTAaexDLNF2qOijP2iV7BLgr90YaQMqHRvOuJMj5+
         omz/rBJVlMORkjNjlksQLjJmuOQgMv9sTroDxTL7uRP3kXeWOoQQVvxr7btVmvS99HHS
         GjTOYhUeOz5bKxHn52ggA47+wgEYHX4Pu7J8rw7n0I3z11O/RjoE6TSym9tme1AWd+k9
         Z00S05lvf/dcDDeHIdHeKYkor7MF8FRKHBB67RjmkXsO2x4Kiw7mjxiMfGwlJT1T/JhX
         D3lE7l0KdFM5P9oup3cPgdPUqNf1OxN2ypBWEOFXSAueBTx4cvGiT4bwXZ2c1cZ0I5Yl
         z00g==
X-Gm-Message-State: AAQBX9d9s6rPkcJPMVKuTckqmEWU55m7BGIA+IxMKzO5ooFNyN9apfYM
        sX9owgBGB0NZ5RjlcFKEyz8=
X-Google-Smtp-Source: AKy350bQGxg7RBg5pF92eSikkFi5M5fqpO6uodydM7FzcgTsZW8L7r5DaRxEIq6ZgQGMWEOyKM+a/A==
X-Received: by 2002:a05:6a20:bf2a:b0:d9:ab8b:9f4b with SMTP id gc42-20020a056a20bf2a00b000d9ab8b9f4bmr1585233pzb.46.1680754924267;
        Wed, 05 Apr 2023 21:22:04 -0700 (PDT)
Received: from localhost (254.80.82.34.bc.googleusercontent.com. [34.82.80.254])
        by smtp.gmail.com with ESMTPSA id l19-20020a62be13000000b005941ff79428sm219479pff.90.2023.04.05.21.22.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 21:22:03 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Subject: Re: [PATCH] doc: asciidoc: remove custom header macro
References: <20230323221523.52472-1-felipe.contreras@gmail.com>
        <20230406035729.GA2092667@coredump.intra.peff.net>
Date:   Wed, 05 Apr 2023 21:22:03 -0700
In-Reply-To: <20230406035729.GA2092667@coredump.intra.peff.net> (Jeff King's
        message of "Wed, 5 Apr 2023 23:57:29 -0400")
Message-ID: <xmqq8rf5r66s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Thu, Mar 23, 2023 at 04:15:23PM -0600, Felipe Contreras wrote:
>
>> In 2007 we added a custom header macro to provide version information
>> 7ef195ba3e (Documentation: Add version information to man pages,
>> 2007-03-25),
>> 
>> However, in 2008 asciidoc added the attributes to do this properly [1].
>> 
>> This was not implemented in Git until 2019: 226daba280 (Doc/Makefile:
>> give mansource/-version/-manual attributes, 2019-09-16).
>> 
>> But in 2023 we are doing it properly, so there's no need for the custom
>> macro.
>> 
>> [1] https://github.com/asciidoc-py/asciidoc-py/commit/ad78a3c
>
> This should be OK to do, as it is just touching the python asciidoc
> side. When we discussed those attributes in 2019:
>
>   https://lore.kernel.org/git/20190320183229.GK31362@pobox.com/
>
> asciidoctor support was new and incomplete. It needed v1.5.7 (from
> 2018), and even today still does not seem to handle manversion. But
> since this patch leaves in place the equivalent hack in
> asciidoctor-extensions.rb, it will continue working.

Sounds like the proposed log message can use a bit more polishing to
help future readers of "git log", then.  But I think it is not
required to be explicit about us leaving the asciidoctor side
untouched to keep it working (in other words, we do not talk about
things that we are not doing in our log message, unless it is so
unnatural not to do them at the same time to warrant such an
explanation).

Will queue with your Reviewed-by: in the morning.

Thanks, both.
