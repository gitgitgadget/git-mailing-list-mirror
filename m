Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B300C433F5
	for <git@archiver.kernel.org>; Sun,  9 Oct 2022 21:27:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbiJIV1D (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 9 Oct 2022 17:27:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbiJIV1B (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Oct 2022 17:27:01 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0EC01EAF4
        for <git@vger.kernel.org>; Sun,  9 Oct 2022 14:26:59 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id bk15so14453260wrb.13
        for <git@vger.kernel.org>; Sun, 09 Oct 2022 14:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UdUqlxBTYnet6xvKxyIIQNOpz9MJG77uI6cUOVnXxPw=;
        b=q2uSvElBzCiniE3iKXfXVYvUI44jqbLLK6smmwLRb2/wM1i2gDZ5Lh3ByqZJl0CG0f
         l5n8luiPFp/VzAktJ0Ht/OfChjf22t605KVgwerOcCqT2bbOcvB0Wkm7hpfeQDZzKnAj
         gGavwqi20jNH7mqbrxcHd8KBah+RnHerpofXa6Xzk6MsoWQSjv0vfS2PsS0Q44GPlehk
         JEWjlgLgYXF/uoAZ6RJ5gkuMNjexOBctaQ0n8XDviMOl42whib9XpB6OUd6zWpmypsSN
         cu1ia3UNjQRCTF1U57Iqb/X9EGBb77RXGNI5uJzZLvDrRjUt9GzOFV/AGegkpYV1WDQk
         xFfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UdUqlxBTYnet6xvKxyIIQNOpz9MJG77uI6cUOVnXxPw=;
        b=v9HjctW3oHXg53aPHkpr18/EjLwcMHSLicPkHrC5bqo3jGB8zjWCGyXktzpqtrtTb1
         CYvEV9eWSvInCKkUAXidXc4eqdnq8V83WWRdQG1dVuj0UH3Jf9w12KooPR5qgI0spZMy
         Lqcud1HbhSKXuTS7RAHIjBYOINXZK6nUGRB2HgCqJ/HRJxzPzVNGr/nMp0dy9pnhBXIo
         v1pJUestY250EZGc73L8sgrXZjjRpX9XDRiuAZ43guZ0ekBwptaPirKNXBsglV/6eyxv
         uJ7TSbsXAgh5fLYeFnR6hZNOkJSiDCCTG6MiJW10ueGJghnBOIghbVqPxmbE8qAFbOxx
         5MRA==
X-Gm-Message-State: ACrzQf0Vr4iQhhAw6eAA4JcszrRgD3wmx4uAb53wvhGdtEc0yrtpDwd9
        E5oWXLVmkJuz3ZlEQrJZVTA=
X-Google-Smtp-Source: AMsMyM4cQViKrf654CcT3v58RQscUXN1TVEWaTwJyc+RMV6uemV748GYpNzvI5PYJ/us+YU/J+kFfQ==
X-Received: by 2002:adf:f5c5:0:b0:22e:264b:2179 with SMTP id k5-20020adff5c5000000b0022e264b2179mr9325792wrp.386.1665350818331;
        Sun, 09 Oct 2022 14:26:58 -0700 (PDT)
Received: from [192.168.2.52] (138.83-213-116.dynamic.clientes.euskaltel.es. [83.213.116.138])
        by smtp.gmail.com with ESMTPSA id p26-20020a7bcc9a000000b003b476cabf1csm8476596wma.26.2022.10.09.14.26.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Oct 2022 14:26:57 -0700 (PDT)
Subject: Re: [PATCH v5] branch: support for shortcuts like @{-1}, completed
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
References: <pull.1346.git.1662388460.gitgitgadget@gmail.com>
 <93b0b442-b277-66a6-3f5f-5a498593aa07@gmail.com>
 <7abdb5a9-5707-7897-4196-8d2892beeb81@gmail.com>
 <2e164aea-7dd8-5018-474a-01643553ea49@gmail.com>
 <de200fa0-379d-c1ce-8446-9e4292d0b66a@gmail.com> <xmqqa6647qx2.fsf@gitster.g>
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
Message-ID: <dacb1f40-2765-5978-1131-f78ba919e6e6@gmail.com>
Date:   Sun, 9 Oct 2022 23:26:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <xmqqa6647qx2.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/10/22 21:11, Junio C Hamano wrote:
> Rubén Justo <rjusto@gmail.com> writes:
> 
>  * cmd_foo() should not return an negative value.

Yes, the refactoring we already discussed early in this thread.

> 
>  * branch_name used in the calls to error() could point at buf.buf
>    that holds the expansion of @{-1}, but buf was released way too
>    early, leading to a use-after-free.

:-( good catch, thanks. Removing the refactoring commit was not
carefully done.

> 
>  * Style: if/else if/else cascade whose one arm has multiple
>    statements and requires {braces} around it should have {braces}
>    around all of its arms.

Ok.

> 
>  * each arm in the top-level if/else if/else cascade for "git
>    branch" subcommands were more or less independent, and there
>    wasn't anything common that they need to execute after exiting
>    the cascade.  Unconditionally returning from the arm for the
>    edit-description subcommand seems to make the logic flow easier
>    to read.

Mmm, I don't feel the same here, we already discussed about this. Maybe?:

diff --git a/builtin/branch.c b/builtin/branch.c
index 17853225fa..307073cc47 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -817,7 +817,8 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
                strbuf_release(&branch_ref);
                strbuf_release(&buf);
 
-               return ret;
+               if (ret)
+                       return ret; /* some failure happened */
        } else if (copy) {
                if (!argc)
                        die(_("branch name required"));


not much important, though.

You can squash the changes in the commit or if you need me to send a v6,
please let me know. Thank you for your careful review.
