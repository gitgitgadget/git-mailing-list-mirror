Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAFC7C74A5B
	for <git@archiver.kernel.org>; Thu, 23 Mar 2023 20:57:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231350AbjCWU5O (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Mar 2023 16:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231394AbjCWU5A (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2023 16:57:00 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8658623301
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 13:56:29 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id a16so18224211pjs.4
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 13:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679604987;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XXv3+mZQfyXIX0J5PmoKi7Z+P5dhcjZmrbnpZvWSeNU=;
        b=BLY8XrExyJ6P3+aN4U2pwLfLUqoOor48jkDXJQlFDjKrqgr3fIq9LLNRL6Y3wiDEN8
         i6w48XuF3vLcCCbAtYVh2PGQxzR2u5OYy0voRdPrRhOk0QBVe++6yHopIgZEgotXz2Uy
         +Bggf69NqH9JO/CBCrB2S6Fn0LjQ4hBI0xIHY2+LCSL2NMqO29ubccU4jSrUxTASm3Zo
         2YLctDOmOW3NCYyqjAjTnqticw6CpX6EJ+RUrj1Zt+7Pcrk9SUSViyxPjHD/4bL9WH1C
         L75rsHeiOLAqEsiet5yrD4EIF7+SdcSLirRGWyfJ3nE0J7tTCQY4FtaC7lAtjvVTsHOn
         pDhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679604987;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XXv3+mZQfyXIX0J5PmoKi7Z+P5dhcjZmrbnpZvWSeNU=;
        b=KW2TjI25GdocGkBafQuK6S7N4Mp19HpKBIgZWCUCiWPU/M/ySQQEjBXzSZRqRIN6/9
         61FKMxx4s9zlmenhS1YAd1Lzu7jLANlx3X7TI6xWs+45JDTH9Rf2+7fexWrifVzU8WQ5
         H6ogzt1jET3YQO761i1xyQb0YcH47vA0guXcUB4QnSiSHhOmaRsazN0TyzKv9l6jTts2
         VcOjb25qQzSLIUSdMcwIhfuNTqCfLGHCpFasbKKh53DLz3c1w7EkduNdgWvzyJ1nd56Z
         Lf2jZ+NllVmlkNJ7zb+hCacP4jeVAEA46N1SUTGtckmwAzXxXrZYEv0IZLqKDRjoCcyE
         0GWQ==
X-Gm-Message-State: AAQBX9c+aVkH5AP6+LCBsCsrqnpkRLypx7OdCtmQ4tt4OyA5AdJ6H8ra
        EtbDjPkJSdIuNQZrC2UWZvM=
X-Google-Smtp-Source: AKy350bo1yn18V6N9Y+Jm4pImnBc4gw+8KuXwNj/twn1Y3BccT5eLD2q09qPoR+gwq3GFaXVxiommw==
X-Received: by 2002:a17:90a:520c:b0:23f:aa16:bdd9 with SMTP id v12-20020a17090a520c00b0023faa16bdd9mr206777pjh.44.1679604986721;
        Thu, 23 Mar 2023 13:56:26 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id ja2-20020a170902efc200b001a1f830c9d0sm739616plb.13.2023.03.23.13.56.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 13:56:26 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [RFC/PATCH] pack-redundant: escalate deprecation warning to an
 error
References: <20230323204047.GA9290@coredump.intra.peff.net>
Date:   Thu, 23 Mar 2023 13:56:26 -0700
In-Reply-To: <20230323204047.GA9290@coredump.intra.peff.net> (Jeff King's
        message of "Thu, 23 Mar 2023 16:40:47 -0400")
Message-ID: <xmqqlejn6vb9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I was looking in this file recently, and was reminded of the deprecation
> plan. The two data points above do give me a little bit of pause, but it
> seems like the current state is the worst of both worlds: we do not have
> the benefit of dropping the code, and people who try to use the command
> have a bad experience. So we should probably either proceed (as with
> this patch), or decide we need to keep pack-redundant.

Sounds like a good thing to do.  Will queue.  Thanks.

>
>  builtin/pack-redundant.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/builtin/pack-redundant.c b/builtin/pack-redundant.c
> index 82115c5808c..5e93d873208 100644
> --- a/builtin/pack-redundant.c
> +++ b/builtin/pack-redundant.c
> @@ -604,6 +604,7 @@ int cmd_pack_redundant(int argc, const char **argv, const char *prefix)
>  			"option, '--i-still-use-this', on the command line\n"
>  			"and let us know you still use it by sending an e-mail\n"
>  			"to <git@vger.kernel.org>.  Thanks.\n"), stderr);
> +		die(_("refusing to run without --i-still-use-this"));
>  	}
>  
>  	if (load_all_packs)
