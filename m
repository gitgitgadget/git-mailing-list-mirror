Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A0F0C77B7A
	for <git@archiver.kernel.org>; Wed, 24 May 2023 20:26:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234213AbjEXU0I (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 May 2023 16:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235746AbjEXU0G (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 May 2023 16:26:06 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9288119
        for <git@vger.kernel.org>; Wed, 24 May 2023 13:25:55 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-64d3578c25bso1572248b3a.3
        for <git@vger.kernel.org>; Wed, 24 May 2023 13:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684959955; x=1687551955;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AeACL81Mhnw7gCHwLuKVX76D+FMUIAUM5DLqkz3hWUk=;
        b=nOoo+xeY4PyR4pLI1VUZYhr15aptlFc/PybjDokw9F3Fdg+58mzLOESPvuovHN2cCv
         +v5B8dAVO1y/ZopippHTLedBCOIaJawuOGZBCMnpnXrPh+mcuJlcZuQubcqFKjF/0Yvw
         60EGwZ5sDVrmS9JOGRoOP/1P2Ab0vHyaaO2S7tty9HyeKzOSVdU+q3lFPevMUiMYrl4A
         tep61eSt0+ARc6zxr1PtwX5wL59TGNDActWx4shODfjebp2f4gONtWLohsXRuH98nXFZ
         hp4G4ufYDiYgpA8VIHxRI4hndvPfUSyCMx5OQN47eqoR4+wYKyiyT35pHR/sM3wgYxW2
         mJLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684959955; x=1687551955;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AeACL81Mhnw7gCHwLuKVX76D+FMUIAUM5DLqkz3hWUk=;
        b=VDZRJRokPiFcp5lNLx5nv0LC/SBnq0xlOvUGE9CFXVoCGnJquHv0KBr9LrowQVI87P
         0y528zDP7lWymoEYDtvDCNRC6dgnA75mp8ORVs0Bu9Iq4bOQfj5bp4njeX9loXvsxgJ4
         s4XpVC9bU+27+kVagN+ID+7WTl6tvDwkLpmRKIkZrOBM4eL63EpjjfhYl2btQ5oIgJc8
         kUx6N5cHAI39+9yg7qq+8xcmXkVVAamec1rw/+Mk4QKoVqKcY+kGKkO7mGzyQY4ViAhY
         m3zWXAWxKXGnP0MPWHtZDr9fqgoI/B7MUsl7TtJNDXrkSnERLGoUxD+/srTLEqEMYbs+
         jj6Q==
X-Gm-Message-State: AC+VfDyz3kZ0jxq0CmKCnjXVMch4wV5OOMJ62ulOjyd47fGcUIAqv2LB
        XHq/cwWz+E59Sh+utbHR6As=
X-Google-Smtp-Source: ACHHUZ4f30v7b5LMoZM4sp61B2wcWpTzv++x6K8HQhfQvXwE270DQz1RksC/tckhz/SjCrB67VQRLg==
X-Received: by 2002:a05:6a21:3703:b0:101:7ccd:e195 with SMTP id yl3-20020a056a21370300b001017ccde195mr15510021pzb.8.1684959955082;
        Wed, 24 May 2023 13:25:55 -0700 (PDT)
Received: from localhost (217.195.118.34.bc.googleusercontent.com. [34.118.195.217])
        by smtp.gmail.com with ESMTPSA id c2-20020aa78802000000b006413bf8becesm7844491pfo.63.2023.05.24.13.25.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 13:25:54 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Tribo Dar <3bodar@gmail.com>, git@vger.kernel.org
Subject: Re: [BUG] Segmentation fault in git v2.41.0.rc1
References: <CACJVABb8tvgXAowgtHLrC6Uau8Q03VRFu1m7K91SJwjvufqXYw@mail.gmail.com>
        <ZG4jcceXn2G6Xic0@nand.local>
Date:   Thu, 25 May 2023 05:25:54 +0900
In-Reply-To: <ZG4jcceXn2G6Xic0@nand.local> (Taylor Blau's message of "Wed, 24
        May 2023 10:47:13 -0400")
Message-ID: <xmqqttw1fpd9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> which points to e0a862fdaf (submodule helper: convert relative URL to
> absolute URL if needed, 2018-10-16) as the culprit.

Whew, that is fairly ancient.  I was afraid if we have another
regression, but it does not look that way.  Fixing is certainly good
and we'd need to eventually get to it, but we have luxury to make
sure that the fix is sound without having to rush anything ;-)

In the meantime, "if it hurts, don't do it" is what we can say.
Telling random users to muck with their config in certain ways that
violate the way how the system represents (un-)initialized
submodules and then to run certain command to induce a NULL pointer
dereference is rather an ineffective social engineering as an attack
vector, so this is not urgent in that sense.

I am more worried that the original report talked about mucking with
the in-tree .gitmodules file affects the result, though.  Once a
submodule is initialized, what is in the file for that submodule
should not affect the working of local Git (otherwise the file can
be used as a route to inject stuff to unsuspecting repositories),
but in this case apparently it does?

Thanks.
