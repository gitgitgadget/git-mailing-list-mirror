Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02058C61DA4
	for <git@archiver.kernel.org>; Sat, 11 Feb 2023 19:24:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbjBKTYj (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Feb 2023 14:24:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjBKTYi (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Feb 2023 14:24:38 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 289674EF9
        for <git@vger.kernel.org>; Sat, 11 Feb 2023 11:24:37 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id n20-20020a17090aab9400b00229ca6a4636so13414447pjq.0
        for <git@vger.kernel.org>; Sat, 11 Feb 2023 11:24:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=isdK6awrC+IMsof9vRasR6r0p5re19JpVaYHJPK1UBU=;
        b=IzGp8beAkcreVmXmY+67fGykREfs/8hgxpazXco4IHK8wLhQtTK7wFGsZpN4GjhXvr
         kLInmoLSoKg+Z7Nn3fcZojiIpCjpcwqRXuw+/Q3nOrbv7BTgcj6dhWXyJmo/PsMwrK3v
         L+11ff+O8R+ul/Zk+AC6zO+80Yak9w9aZFAWqbWqg9uBDqAUMMdVyO7Aojbz1j5NUw1S
         XbXqCDlqpYWVPMM9JUpMScweXkXGoFdmV3KHTSXkMx3nPOieAAtyVqFb0M+7GgkU8YeZ
         SkeL1m0NlqK8Z9RxAOd3zEkQ1iVhSuwVvhixrHsmz8Y3ISf6NeGAJw+J06j/wEbtA/be
         rEXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=isdK6awrC+IMsof9vRasR6r0p5re19JpVaYHJPK1UBU=;
        b=g3Ue+QCAJo6b+4ucEjB/QPFCQjTvesy+6dLsG3MoDDFtsMnmNQtp7WpM8f7CIsvzYs
         fmjGvZqPbx/7L+DNyJbpa4RqjpEtqGHCC8N2/zki76ahPIk6Y1toec80SyvFjkyrDtRm
         0eXwNHfx265tO6kn81mMnwThX6xSBxwUmLdXPpBDFV0Jccrs3R4JMO+QXmKK+b/Y/XNO
         1v8VltCO/ulZO5bgWUyjVTcNT7n7l1ZgeP29EUiTG61cnfWSo9rGZdgBKN/DSUrcOK2N
         3u5++0VJRWkbrBdcWs+K9pBbZTdAbrTkegs84C9pKlaHX6+Ng5MVfxBAQLQw8DNGAIIV
         m9uw==
X-Gm-Message-State: AO0yUKUSuAmU+yThC4H2vOi1e9XyWD7kOMk0gpQ9J3VFVyU6Zq36xej5
        BeCtUNJMK9zbXSWSga9JJu4=
X-Google-Smtp-Source: AK7set8sRgNB2iURIwqGELyJANMP5RWWNvcz/oq4MyjYILi1zeCLHYdJKIxXoh3d6l/aj+hHd0pniw==
X-Received: by 2002:a17:902:c40b:b0:194:9b4e:1c90 with SMTP id k11-20020a170902c40b00b001949b4e1c90mr22818575plk.57.1676143476487;
        Sat, 11 Feb 2023 11:24:36 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id iw21-20020a170903045500b00198ea7e4bafsm5341039plb.92.2023.02.11.11.24.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Feb 2023 11:24:35 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Wong <e@80x24.org>
Cc:     git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
Subject: Re: [RFC] fetch: support hideRefs to speed up connectivity checks
References: <20230209122857.M669733@dcvr> <xmqq1qmxgmed.fsf@gitster.g>
        <20230211075333.M933000@dcvr>
Date:   Sat, 11 Feb 2023 11:24:35 -0800
In-Reply-To: <20230211075333.M933000@dcvr> (Eric Wong's message of "Sat, 11
        Feb 2023 07:53:33 +0000")
Message-ID: <xmqqv8k8dmz0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Wong <e@80x24.org> writes:

> Junio C Hamano <gitster@pobox.com> wrote:
>> I however notice error handling in the codepath that deals with
>> "--exclude-hidden" is  a bit sloppy.
>> 
>> refs.c::parse_hide_refs_config() is nice enough to diagnose a
>> malformed transfer.hiderefs configuration as an error by returning
>> -1, and revision.c::hide_refs_config() propagates such an error up,
>> but revision.c::exclude_hidden_refs() ignores the error from
>> git_config(), and revision.c::handle_revision_pseudo_opt() ignores
>> any error from exclude_hidden_refs() anyway.
>
> Not sure I follow.  exclude_hidden_refs() either dies or calls
> git_config().  git_config() calls repo_config(), then
> configset_iter().  configset_iter() will git_die_config_linenr()
> if `fn' (hide_refs_config() in this case) returns < 0.

Somehow I had this wishful thinking that the return value from
git_config() can be checked and the caller can handle the error more
gracefully, but its return type is void.  We'll die when we see a
bad configuration but only when we see "--exclude-hidden", which is
when we need a valid value from there.  That is how it should work,
so I am now happier.

Thanks.
