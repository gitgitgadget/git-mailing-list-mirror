Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D28BC433F5
	for <git@archiver.kernel.org>; Fri, 22 Apr 2022 06:50:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444555AbiDVGx2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Apr 2022 02:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388274AbiDVGx0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Apr 2022 02:53:26 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6A2F642E
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 23:50:32 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id y20so14467077eju.7
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 23:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vmiklos-hu.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DJXrPJrIwjJqP/bxWDSpQNlAnJvhEOYIxwgXk1taOI8=;
        b=5oBNA6L8Ki7TXOl4ORKI3wtNOGo1GG7LFhYgLsskKKzn+lLeMTQDD5mUxAF+rjWqjZ
         5M3qWZZTSTMziwreelazDGk93pBDnvhPjwAHD0wTGVr/rJMPU/0cFFfqdrajzrjsDNBU
         0EbLNXr+eMc+suBDJ4Ds9BwywYAogseVANpUXVqAVViCN278yvFYKgSGgPaGYLvN+v5R
         XZNt2mPgoDilGhp6/ZxGoRCA5cuB0bnoxtAXKigfu3ErvLJlPv6gNeuQD7bELu+k1Rmg
         LBOa0l7l+w2tnR+omF+3oS3Ua00ASCXqlJ40uK5c0k7S8a97klXeFuad6Qkr5KF/IlDd
         N4yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DJXrPJrIwjJqP/bxWDSpQNlAnJvhEOYIxwgXk1taOI8=;
        b=Ry7JgoDYPuq8tZG8rQIUex29k6AXrQHL28FRUmaBDSQNvpJiSuslx+cCOtnmUF6TmX
         nAaDbr8WB3Pzki1DrvVD31MTlTmwdj3gH1Qp38rdIwHuVGFQ51gCDFskP6DXK52QNv6z
         f93VmHAVx2zI3+/fg/o5tX86DE9sN+eilR5vH7ORnu3FP/EhIYsHJa+u6hqr7o2MsQ9L
         kyyp5QIYDq141/pgNAl51ZNfkQ21QIjR2uZKQChhH9ynuON8Fw3i8Gk0t+O2kqnI8tz+
         3ozGJaqHI4wWQ0AiwzW0xX4L5/sPOTVtBi1jbNYXHAr9wJf3zuGbTAej+uTXHamOX7fj
         2JDQ==
X-Gm-Message-State: AOAM530ovmrfDGjkzZ31g+CX+DvbeBLkUqA2rIaYKimMocRtldaKq780
        ulgvtjyPwNXhvlihBR9HpBsOCE8LxIvrG8DHKp4=
X-Google-Smtp-Source: ABdhPJzrMI8GYQs6xOXUg2uaru+iIfW3IgU/6HV04E9dvhaJvn4d1YewJaFLUJYf6Hh47thS8+1h2g==
X-Received: by 2002:a17:907:97cc:b0:6da:a8fb:d1db with SMTP id js12-20020a17090797cc00b006daa8fbd1dbmr2812840ejc.267.1650610231246;
        Thu, 21 Apr 2022 23:50:31 -0700 (PDT)
Received: from vmiklos.hu (92-249-245-217.pool.digikabel.hu. [92.249.245.217])
        by smtp.gmail.com with ESMTPSA id o22-20020a170906289600b006e44a0c1105sm442568ejd.46.2022.04.21.23.50.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 23:50:30 -0700 (PDT)
Date:   Fri, 22 Apr 2022 08:50:28 +0200
From:   Miklos Vajna <vmiklos@vmiklos.hu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v5] log: "--as-filter" option adjusts how "--since"
 cut-off works
Message-ID: <YmJQNKdMj3Bp2RJE@vmiklos.hu>
References: <xmqqtub3moa0.fsf@gitster.g>
 <xmqqv8vkpara.fsf@gitster.g>
 <YlCiqgO6rL908Zsi@vmiklos.hu>
 <220412.86pmlmhe9a.gmgdl@evledraar.gmail.com>
 <YlnYDgZRzDI87b/z@vmiklos.hu>
 <xmqqmtgm9c01.fsf@gitster.g>
 <YlrRT6NAgW6nK2fc@vmiklos.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YlrRT6NAgW6nK2fc@vmiklos.hu>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Sat, Apr 16, 2022 at 04:23:14PM +0200, Miklos Vajna <vmiklos@vmiklos.hu> wrote:
> Thanks a lot, I've updated the commit message to match this.

Is there anything else I should tweak in v5 to get this into a topic
branch?

Thanks,

Miklos
